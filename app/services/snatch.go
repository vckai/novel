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
	"bytes"
	"context"
	"errors"
	"io"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/astaxie/beego"

	xhttp "github.com/vckai/novel/app/librarys/net/http"
	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services/snatchs"
	"github.com/vckai/novel/app/utils/log"
)

var (
	ErrNotProvider    = errors.New("没有获取到采集点")
	ErrURLSnatchMatch = errors.New("该小说URL匹配不到采集站点")
)

type Snatch struct {
	c *snatchs.Snatch
}

func NewSnatch() *Snatch {
	return &Snatch{
		c: snatchs.NewSnatch(ProxyService.Get),
	}
}

// 执行指定小说的采集任务
func (this *Snatch) SnatchNovel(novId uint32) error {
	return manager.RunOneTask(novId)
}

// 是否小说简介页面
func (this *Snatch) IsBookURL(source, rawurl string) bool {
	provider := SnatchRuleService.GetByCode(source)
	return this.c.IsBookURL(provider, rawurl)
}

// 是否小说是否爬虫页面
func (this *Snatch) IsCrawlerURL(source, rawurl string) bool {
	provider := SnatchRuleService.GetByCode(source)
	return this.c.IsCrawlerURL(provider, rawurl)
}

// 查找小说列表
func (this *Snatch) FindNovels(kw string) []*snatchs.SnatchInfo {
	providers := SnatchRuleService.GetSnatchs()
	var list []*snatchs.SnatchInfo
	for _, provider := range providers {
		info, err := this.c.FindNovel(provider, kw)
		if err == nil {
			list = append(list, info)
		}
	}

	return list
}

// 查找小说
func (this *Snatch) FindNovel(source, kw string) (*snatchs.SnatchInfo, error) {
	provider := SnatchRuleService.GetByCode(source)
	return this.c.FindNovel(provider, kw)
}

// 获取一本小说
func (this *Snatch) GetNovel(source, rawurl string) (*snatchs.SnatchInfo, error) {
	provider := SnatchRuleService.GetByCode(source)
	return this.c.GetNovel(provider, rawurl)
}

// 获取小说章节内容
func (this *Snatch) GetChapter(source, rawurl string) (*snatchs.SnatchInfo, error) {
	provider := SnatchRuleService.GetByCode(source)
	return this.c.GetChapter(provider, rawurl)
}

// 获取小说章节列表
func (this *Snatch) GetChapters(source, rawurl string) ([]*snatchs.SnatchInfo, error) {
	provider := SnatchRuleService.GetByCode(source)
	return this.c.GetChapters(provider, rawurl)
}

// 根据URL匹配采集站点
func (this *Snatch) GetProvideByURL(url string) (*models.SnatchRule, error) {
	providers := SnatchRuleService.GetSnatchs()
	for _, v := range providers {
		// 匹配采集站点成功
		if this.c.IsBookURL(v, url) {
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

	// 获取小说
	info, err := this.c.GetNovel(provider, url)
	if err != nil {
		return err
	}

	nov := info.Nov

	// 判断小说是否已存在
	nv := NovelService.GetByName(nov.Name)

	// 下载封面图片
	isUp := false
	if len(nov.Cover) != 0 && (len(nv.Cover) == 0 || provider.IsUpdate == 1) {
		imgFile, err := DownImg(nov.Cover)
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
	if nov.Desc != nv.Desc && provider.IsUpdate == 1 {
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
			NovelService.AddLink(nv.Id, info.Url, provider.Code, info.ChapterUrl)
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
		NovelService.AddLink(nov.Id, info.Url, provider.Code, info.ChapterUrl)
	}

	// 添加到采集队列中
	manager.AddTask(nov.Id)

	return nil
}

// 下载缩略图
func DownImg(rawurl string) (string, error) {
	fileType := rawurl[strings.LastIndex(rawurl, "."):]
	if fileType != ".jpeg" && fileType != ".png" && fileType != ".jpg" {
		fileType = ".jpeg"
	}
	upPreDir := beego.AppConfig.String("static::uppredir")
	upDir := beego.AppConfig.String("static::updir")

	// 重命名文件
	newName := strconv.FormatInt(time.Now().UnixNano(), 10) + fileType

	// 创建上传目录
	uploadDir := upDir + time.Now().Format("2006/01/02") + "/"

	err := os.MkdirAll(upPreDir+uploadDir, os.ModePerm) //创建目录
	if err != nil {
		return "", err
	}

	c := xhttp.NewClient(
		&xhttp.ClientConfig{
			Timeout:   10 * time.Second,
			Dial:      500 * time.Millisecond,
			KeepAlive: 60 * time.Second,
			ProxyURL:  ProxyService.Get(),
		})

	body, _, err := c.Get(context.TODO(), rawurl, nil)
	if err != nil {
		return "", err
	}

	// 创建空文件
	f, err := os.Create(upPreDir + uploadDir + newName)
	if err != nil {
		return "", err
	}

	defer f.Close()

	rc := bytes.NewReader(body)

	_, err = io.Copy(f, rc)

	return uploadDir + newName, err
}
