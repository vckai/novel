// Copyright 2017 Vckai Author. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package services

import (
	"errors"
	"strings"
	"sync"
	"time"
	"unicode/utf8"

	"github.com/astaxie/beego"

	"github.com/vckai/novel/app/librarys/snatchs"
	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/utils"
	"github.com/vckai/novel/app/utils/log"
)

var (
	ErrNovExists      = errors.New("小说已经存在")
	ErrNovsEmpty      = errors.New("获取到的小说为空")
	ErrURLSnatchMatch = errors.New("该小说URL匹配不到采集站点")
)

const (
	TASKWAIT = iota
	TASKRUNING
	TASKFINISH
	TASKWAITGC

	// gc运行时间间隔（分钟）
	GCRUNTIME = 10

	// 每次gc运行查找的数量
	GCNUM = 100
)

var manager = NewSnatchTaskManager()

// 初始化小说采集列表
func initSnatch() {
	novLen := manager.LoadNovels()
	log.Info("初始化小说更新任务:", novLen, "本")

	manager.Run()
}

type SnatchTask struct {
	novId     uint32
	runStatus uint8

	upChapNum      int32
	lastUpChapTime int64

	rviews int32
	rtime  int64
	ctime  int64
}

func NewSnatchTask(novId uint32) *SnatchTask {
	return &SnatchTask{
		novId:          novId,
		ctime:          time.Now().Unix(),
		lastUpChapTime: time.Now().Unix(),
	}
}

func (this *SnatchTask) Run() {
	if this.runStatus != TASKWAIT {
		log.Debug("[小说更新任务] ID:", this.novId, " 任务无法运行，状态:", this.runStatus)
		return
	}

	// 获取小说采集链接列表
	links := NovelService.GetLinks(this.novId)
	if len(links) == 0 {
		log.Debug("[小说更新任务] ID:", this.novId, " 没有找到相应的采集站点")
		return
	}

	// 修复空章节
	this.fixEmptyChaps()

	// 修改运行状态
	this.upRunStatus(TASKRUNING)

	var status uint8

	for _, v := range links {
		status = this.upChapter(v.Source, v.ChapterLink)

		// 修改运行后的状态
		this.rviews++
		this.rtime = time.Now().Unix()

		if status != TASKWAIT {
			break
		}
	}
	this.upRunStatus(status)
}

// 修改小说更新任务运行状态
func (this *SnatchTask) upRunStatus(runStatus uint8) {
	this.runStatus = runStatus
}

// 是否可以被gc回收
func (this *SnatchTask) IsGc() bool {
	if this.runStatus == TASKWAITGC {
		return true
	}

	gcTime := ConfigService.Int64("NotUpStopDays", 10) * 60 * 60 * 24
	lastUpTime := time.Now().Unix() - this.lastUpChapTime

	// 超过N天没更新章节的放入gc中
	if lastUpTime > gcTime {
		// 修改小说状态
		NovelService.UpStatus(this.novId, models.BOOKEUNUCHS)

		return true
	}

	return false
}

// 修复采集失败的空章节
func (this *SnatchTask) fixEmptyChaps() {
	nov := NovelService.Get(this.novId)
	if nov == nil {
		log.Debug("[小说修复任务] ID:", this.novId, " 不存在")
		return
	}
	// 获取小说空章节列表
	// 用于重试修复空章节
	emptyChaps := ChapterService.GetEmptyChaps(this.novId)
	if emptyChaps == nil {
		log.Debug("[小说修复任务] ID:", this.novId, " 无需修复")
		return
	}

	succ := 0
	errNum := 0
	novTextNum := 0

	for _, v := range emptyChaps {
		info, err := SnatchService.GetChapter(v.Source, v.Link)
		if err != nil {
			errNum++
			log.Warn("[小说修复任务] ID:", nov.Id, " 小说:", nov.Name, " provider:", v.Source, " 章节:", v.ChapterNo, " 获取失败:", err.Error())
			v.Status = 1
		} else {
			succ++
			v.Desc = info.Chap.Desc
			v.Status = 0

			// 字数计算
			textNum := utf8.RuneCountInString(info.Chap.Desc)
			novTextNum += textNum

			v.TextNum = uint32(textNum)
		}

		ChapterService.UpdateEmpty(v)
	}

	// 调整小说字数
	NovelService.UpChapterTextNum(nov.Id, novTextNum, true)

	log.Info("[小说修复任务] ID:", nov.Id,
		" 小说:", nov.Name,
		" 修复成功:", succ,
		" 修复失败:", errNum)
}

// 更新小说章节
func (this *SnatchTask) upChapter(source, chapLink string) uint8 {
	nov := NovelService.Get(this.novId)
	if nov == nil {
		log.Debug("[小说更新任务] ID:", this.novId, " 不存在")
		return TASKWAITGC
	}
	if nov.IsOriginal == 1 {
		log.Debug("[小说更新任务] ID:", this.novId, " 原创小说不更新")
		return TASKWAITGC
	}

	if nov.Status != snatchs.BOOKOPEN {
		log.Debug("[小说更新任务] ID:", nov.Id, " 小说:", nov.Name, " 状态为:", nov.StatusName())
		return TASKWAITGC
	}

	// 获取小说章节列表
	chapLinks, err := SnatchService.GetChapters(source, chapLink)
	if err != nil {
		log.Warn("[小说更新任务] ID:", nov.Id, " 小说:", nov.Name, " provider:", source, " 获取小说章节失败:", err.Error())
		return TASKWAIT
	}

	// 获取最后一章节
	lastChap := ChapterService.GetLast(nov.Id)
	isInit := lastChap.Id == 0

	index := 0
	chapterNo := uint32(0)
	if lastChap != nil && lastChap.Id > 0 {
		for k, v := range chapLinks {
			if lastChap.Title == v.Chap.Title || lastChap.Link == v.Chap.Link {
				index = k + 1
				chapterNo = lastChap.ChapterNo
				break
			}
		}

		// 做容错处理，防止最后一章是已经被采集站删除的错误章节
		// 最后一章节没有匹配到内容，继续匹配倒数第二章节
		if index == 0 {
			pre := ChapterService.GetPre(nov.Id, lastChap.ChapterNo)
			if pre != nil && pre.Id > 0 {
				for k, v := range chapLinks {
					if pre.Title == v.Chap.Title || pre.Link == v.Chap.Link {
						index = k + 1
						chapterNo = lastChap.ChapterNo
						break
					}
				}
			}
		}

		// 没有匹配到更新章节，返回最大值表示匹配失败
		if index == 0 {
			index = len(chapLinks)
		}
	}

	links := chapLinks[index:]
	log.Debug("[小说更新任务] ID:", nov.Id, " 小说:", nov.Name, " provider:", source, " 获取到", len(chapLinks), "章节 其中:", len(links), "章节未更新")
	if len(links) == 0 {
		return TASKWAIT
	}

	// 完本状态
	status := models.BOOKOPEN

	chapterNum := 0
	errNum := 0
	novTextNum := 0
	t1 := time.Now()
	var chaps []*models.Chapter
	for _, v := range links {
		// 章节数累加
		chapterNo++

		info, err := SnatchService.GetChapter(source, v.Chap.Link)

		// 获取章节失败
		if err != nil {
			log.Warn("[小说更新任务] ID:", nov.Id, " 小说:", nov.Name, " provider:", source, " 章节:", chapterNo, " 获取失败:", err.Error())
			info = v
			info.Chap.Status = 1
			errNum++
		}

		chap := info.Chap

		// 跳过无用的章节
		if strings.Contains(chap.Title, "请假一晚") ||
			strings.Contains(chap.Title, "请假一天") ||
			strings.Contains(chap.Title, "今天无更") ||
			strings.Contains(chap.Title, "晚点更新") ||
			strings.Contains(chap.Title, "更新延迟") {
			continue
		}

		// 跳过无用的章节
		if strings.Contains(chap.Desc, "正在手打中，请稍等片刻") {
			continue
		}

		chapterNum += 1

		// 章节数统计
		textNum := utf8.RuneCountInString(info.Chap.Desc)
		novTextNum += textNum

		chap.TextNum = uint32(textNum)
		chap.NovId = nov.Id
		chap.ChapterNo = chapterNo
		chap.Source = source
		chap.Link = v.Chap.Link
		chap.UpdatedAt = uint32(time.Now().Unix())
		chap.CreatedAt = uint32(time.Now().Unix())
		chaps = append(chaps, chap)

		// 判断是否完本
		if strings.Contains(chap.Title, "大结局") ||
			strings.Contains(chap.Title, "本书完") ||
			strings.Contains(chap.Title, "全书完") ||
			strings.Contains(chap.Title, "完结感言") ||
			strings.Contains(chap.Title, "完本后的话") ||
			strings.Contains(chap.Title, "完本感言") {
			status = snatchs.BOOKFINISH
		}

		time.Sleep(time.Duration(100) * time.Microsecond)
	}

	if len(chaps) == 0 {
		log.Warn("[小说更新任务] ID:", nov.Id, " 小说:", nov.Name, " provider:", source, " 获取章节列表内容失败")

		return TASKWAIT
	}

	ct := time.Since(t1)

	t2 := time.Now()
	// 批量插入
	err = ChapterService.InsertMulti(chaps, isInit)
	if err != nil {
		log.Warn("[小说更新任务] ID:", nov.Id, " 小说:", nov.Name, " provider:", source, " 批量写入章节内容失败", err)
		return TASKWAIT
	}
	it := time.Since(t2)

	// 获取最后一章节信息更新主信息表
	lastChap = ChapterService.GetLast(nov.Id)
	lastId := uint64(0)
	lastTitle := ""
	if lastChap != nil {
		lastId = lastChap.Id
		lastTitle = lastChap.Title
	}
	NovelService.UpChapterInfo(nov.Id, novTextNum, chapterNum, lastId, lastTitle, status)

	// 最后更新章节时间
	this.lastUpChapTime = time.Now().Unix()

	log.Debug("[小说更新任务] ID:", nov.Id,
		" 小说:", nov.Name,
		" provider:", source,
		" 获取到", len(chapLinks),
		"章节 错误", errNum,
		"章节 更新章节为:", len(links),
		" 更新成功:", len(chaps),
		"采集时间:", ct,
		"db写入时间:", it)

	return TASKWAIT
}

// 采集任务管理
type SnatchTaskManager struct {
	sync.RWMutex
	tasks     map[uint32]*SnatchTask
	taskChans chan *SnatchTask
}

func NewSnatchTaskManager() *SnatchTaskManager {
	return &SnatchTaskManager{
		tasks: make(map[uint32]*SnatchTask),
	}
}

// 加载小说写入任务队列
func (this *SnatchTaskManager) LoadNovels() int {
	novs, _ := NovelService.GetAll(10000000, 0, map[string]interface{}{
		"status": int(models.BOOKOPEN),
	}, "id", "name", "status")

	for _, v := range novs {
		this.AddTask(v.Id)
	}

	return len(novs)
}

// 获取章节小说更新
func (this *SnatchTaskManager) Run() {
	this.taskChans = make(chan *SnatchTask, 3000)

	for i := 0; i < 5; i++ {
		go func() {
			for {
				task, ok := <-this.taskChans
				if !ok {
					return
				}

				// 是否开启自动采集更新
				if ConfigService.Bool("IsSnatch", true) {
					task.Run()
				}
			}
		}()
	}

	go func() {
		for _, task := range this.tasks {
			this.taskChans <- task
		}
		// 休眠指定时间更新一次
		time.Sleep(time.Duration(ConfigService.Int64("Uptime", 10)) * time.Minute)
	}()

	this.gc()
}

// 运行指定小说的采集任务
func (this *SnatchTaskManager) RunOneTask(novId uint32) error {
	this.AddTask(novId)

	if task, ok := this.tasks[novId]; ok {
		go task.Run()
	}

	return nil
}

// 添加采集章节更新队列
func (this *SnatchTaskManager) AddTask(novId uint32) error {
	this.Lock()
	defer this.Unlock()

	if _, ok := this.tasks[novId]; ok {
		return nil
	}

	this.tasks[novId] = NewSnatchTask(novId)

	return nil
}

// 删除采集队列任务
func (this *SnatchTaskManager) DelTask(novId uint32) error {
	this.Lock()
	defer this.Unlock()

	if _, ok := this.tasks[novId]; !ok {
		return nil
	}

	delete(this.tasks, novId)

	return nil
}

// 运行gc删除过期任务
func (this *SnatchTaskManager) gc() {
	ticker := time.NewTicker(time.Minute * time.Duration(GCRUNTIME))

	go func() {
		for _ = range ticker.C {
			// 是否开启自动采集更新
			if ConfigService.Bool("IsSnatch", true) {
				log.Debug("gc running...")
				i := 0
				for novId, task := range this.tasks {
					if i > GCNUM {
						break
					}
					if task.IsGc() {
						log.Debug("GC删除任务:", novId)
						this.DelTask(novId)
					}

					i++
				}
			}
		}
	}()
}

type Snatch struct{}

func NewSnatch() *Snatch {
	return &Snatch{}
}

// 获取注册的采集器列表
func (this *Snatch) GetSnatchs() map[string]*snatchs.Provide {
	return snatchs.GetSnatchs()
}

// 执行指定小说的采集任务
func (this *Snatch) SnatchNovel(novId uint32) error {
	return manager.RunOneTask(novId)
}

// 查找小说列表
func (this *Snatch) FindNovels(kw string) []*snatchs.SnatchInfo {
	s := this.GetSnatchs()

	var list []*snatchs.SnatchInfo
	for _, v := range s {
		c := v.Client
		// 设置代理
		c.Proxy(ProxyService.Get())
		info, err := c.FindNovel(kw)
		if err == nil {
			info.Title = v.Title
			list = append(list, info)
		}
	}

	return list
}

// 获取一本小说
func (this *Snatch) GetNovel(provideName, url string) (*snatchs.SnatchInfo, error) {
	provider, err := snatchs.NewManager(provideName)
	if err != nil {
		return nil, err
	}
	c := provider.Client
	// 设置代理
	c.Proxy(ProxyService.Get())
	info, err := c.GetNovel(url)
	if err != nil {
		return nil, err
	}

	return info, nil
}

// 获取小说章节内容
func (this *Snatch) GetChapter(provideName, url string) (*snatchs.SnatchInfo, error) {
	provider, err := snatchs.NewManager(provideName)
	if err != nil {
		return nil, err
	}

	c := provider.Client
	// 设置代理
	c.Proxy(ProxyService.Get())
	info, err := c.GetChapter(url)
	if err != nil {
		return nil, err
	}

	return info, nil
}

// 获取小说章节列表
func (this *Snatch) GetChapters(provideName, url string) ([]*snatchs.SnatchInfo, error) {
	provider, err := snatchs.NewManager(provideName)
	if err != nil {
		return nil, err
	}

	c := provider.Client
	// 设置代理
	c.Proxy(ProxyService.Get())
	info, err := c.GetChapters(url)
	if err != nil {
		return nil, err
	}

	return info, nil
}

// 根据URL匹配采集站点
func (this *Snatch) GetProvideByURL(url string) (*snatchs.Provide, error) {
	snatchs := this.GetSnatchs()
	for _, v := range snatchs {
		// 匹配采集站点成功
		if v.Client.IsBookURL(url) {
			return v, nil
		}
	}

	return nil, ErrURLSnatchMatch
}

// 初始化一本小说
// 采集小说入库
func (this *Snatch) InitNovel(url string) error {

	// 获取小说采集器
	provider, err := this.GetProvideByURL(url)
	if err != nil {
		return err
	}

	c := provider.Client

	// 设置代理
	c.Proxy(ProxyService.Get())
	info, err := c.GetNovel(url)
	if err != nil {
		return err
	}

	nov := info.Nov

	// 判断小说是否已存在
	nv := NovelService.GetByName(nov.Name)

	// 下载封面图片
	isUp := false
	if len(nov.Cover) != 0 && (len(nv.Cover) == 0 || info.IsUpdate) {
		imgFile, err := utils.DownFile(nov.Cover, beego.AppConfig.String("static::uppredir"), beego.AppConfig.String("static::updir"), ProxyService.Get())
		if err != nil {
			log.Warn("下载图片失败：", nov.Cover, err)
			nov.Cover = ""
		} else {
			nov.Cover = ConfigService.String("ViewURL") + imgFile
		}
		isUp = true
		nv.Cover = nov.Cover
	}

	// 更新小说简介
	if nov.Desc != nv.Desc && info.IsUpdate {
		nv.Desc = nov.Desc
		isUp = true
	}

	// 更新小说作者名称
	if nv.Author == "" {
		nv.Author = nov.Author
		isUp = true
	}

	if nv.Id > 0 {
		// 添加采集点即可
		if info.Url != "" {
			NovelService.AddLink(nv.Id, info.Url, provider.Name, info.ChapterUrl)
		}

		// 更新小说简介内容和封面图片
		if isUp {
			nv.CateId = nov.CateId
			err = NovelService.UpNovelInfo(nv)
		}

		return err
	}

	// 保存小说
	err = NovelService.Save(nov)
	if err != nil {
		return err
	}

	// 添加采集URL
	if info.Url != "" {
		NovelService.AddLink(nov.Id, info.Url, provider.Name, info.ChapterUrl)
	}

	// 添加到采集队列中
	manager.AddTask(nov.Id)

	return nil
}
