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
	"fmt"
	"strings"
	"time"

	"github.com/astaxie/beego/validation"

	"github.com/vckai/novel/app/models"
)

// 定义NovelService
type Novel struct {
}

func NewNovel() *Novel {
	return &Novel{}
}

// 判断小说是否存在
func (this *Novel) IsExists(name string) bool {
	if len(name) == 0 {
		return false
	}

	nov := models.NovelModel.GetByName(name)
	if nov != nil {
		return true
	}

	return false
}

// 获取小说采集站点列表
func (this *Novel) GetLinks(novId uint32) []*models.NovelLinks {
	args := map[string]interface{}{
		"nov_id": novId,
		//"source": "31xs",
	}

	links, _ := models.NovelLinksModel.GetAll(100, 0, args)

	return links
}

// 根据你URL 和 站点获取小说采集URL
func (this *Novel) GetByLink(link, source string) *models.NovelLinks {
	return models.NovelLinksModel.GetByLink(link, source)
}

// 添加小说采集站点
func (this *Novel) AddLink(novId uint32, link, source, chapterLink string) error {

	// 采集点已存在则直接返回
	novLink := this.GetByLink(link, source)
	if novLink.Id > 0 {
		return nil
	}

	n := &models.NovelLinks{
		NovId:       novId,
		Link:        link,
		Source:      source,
		ChapterLink: chapterLink,
	}

	return n.Insert()
}

// 判断小说是否存在
func (this *Novel) GetByName(name string) *models.Novel {
	nov := models.NovelModel.GetByName(name)

	return nov
}

// 获取单个管理员信息
func (this *Novel) Get(id uint32) *models.Novel {
	nov := models.NewNovel()

	if id < 0 {
		return nov
	}

	nov.Id = id
	err := nov.Read()
	if err != nil {
		return nov
	}

	return nov
}

// 获取今日推荐
func (this *Novel) GetTodayRecs(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"is_today_rec": 1,
	}
	novs, _ := models.NovelModel.GetAll(size, offset, args, "id", "name", "cover", "author")

	return novs
}

// 获取推荐小说
func (this *Novel) GetRecs(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"is_rec": 1,
	}
	novs, _ := models.NovelModel.GetAll(size, offset, args, "id", "name", "cover", "cate_id", "cate_name", "author")

	return novs
}

// 获取精品推荐小说
func (this *Novel) GetVipRecs(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"is_vip_rec": 1,
	}
	novs, _ := models.NovelModel.GetAll(size, offset, args, "id", "name", "cover")

	return novs
}

// 获取热门小说
func (this *Novel) GetHots(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"is_hot": 1,
	}
	novs, _ := models.NovelModel.GetAll(size, offset, args, "id", "name", "cover", "desc", "views", "author", "cate_id", "cate_name")

	return novs
}

// 获取男生喜欢小说列表
func (this *Novel) GetManLikes(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"is_man_like": 1,
	}
	novs, _ := this.GetList(size, offset, args)

	return novs
}

// 获取女生喜欢小说列表
func (this *Novel) GetGirlLikes(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"is_girl_like": 1,
	}
	novs, _ := this.GetList(size, offset, args)

	return novs
}

// 获取排行榜小说列表
func (this *Novel) GetRanks(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"orderBy": "-views",
	}
	novs, _ := this.GetList(size, offset, args)

	return novs
}

// 获取同类推荐排行榜
func (this *Novel) GetCateRanks(cateId, size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"orderBy": "-views",
		"cate_id": cateId,
	}
	novs, _ := this.GetList(size, offset, args)

	return novs
}

// 获取最新更新小说列表
func (this *Novel) GetNewUps(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"orderBy": "-chapter_updated_at",
	}
	novs, _ := this.GetList(size, offset, args)

	return novs
}

// 获取新增小说榜单
func (this *Novel) GetNews(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"orderBy": "-id",
	}
	novs, _ := models.NovelModel.GetAll(size, offset, args, "id", "name", "cover", "desc", "views", "author", "cate_id", "cate_name")

	return novs
}

// 获取完本小说列表
func (this *Novel) GetEnds(size, offset int) []*models.Novel {
	args := map[string]interface{}{
		"status": int(models.BOOKFINISH),
	}
	novs, _ := this.GetList(size, offset, args)

	return novs
}

// 批量获取小说列表
// 用于前台查询
func (this *Novel) GetList(size, offset int, args map[string]interface{}) ([]*models.Novel, int64) {
	// 排序
	if ot, ok := args["ot"]; ok {
		switch ot.(int) {
		case 1:
			args["orderBy"] = "-views"
		case 2:
			args["orderBy"] = "-chapter_updated_at"
		case 3:
			args["orderBy"] = "-text_num"
		default:
		}
	}

	// 字数查询
	if textNum, ok := args["text_num"]; ok {
		switch textNum.(int) {
		case 1:
			args["start_text_num"] = 0
			args["end_text_num"] = 300000
		case 2:
			args["start_text_num"] = 300000
			args["end_text_num"] = 500000
		case 3:
			args["start_text_num"] = 500000
			args["end_text_num"] = 1000000
		case 4:
			args["start_text_num"] = 1000000
			args["end_text_num"] = 2000000
		case 5:
			args["start_text_num"] = 2000000
			args["end_text_num"] = 0
		default:
		}
	}

	// 更新时间
	if upTime, ok := args["uptime"]; ok {
		switch upTime.(int) {
		case 1:
			args["max_chapter_at"] = time.Now().AddDate(0, 0, -3).Unix()
		case 2:
			args["max_chapter_at"] = time.Now().AddDate(0, 0, -7).Unix()
		case 3:
			args["max_chapter_at"] = time.Now().AddDate(0, 0, -15).Unix()
		case 4:
			args["max_chapter_at"] = time.Now().AddDate(0, 0, -30).Unix()
		default:
		}
	}

	novs, count := models.NovelModel.GetAll(size, offset, args, "id", "name", "cover", "desc", "author", "cate_id", "cate_name", "text_num", "status", "cate_id", "chapter_title")

	// 关键词替换
	if len(novs) > 0 {
		// 名称搜索
		if q, ok := args["q"]; ok && len(q.(string)) > 0 {
			for k, v := range novs {
				novs[k].Name = strings.Replace(v.Name, q.(string), fmt.Sprintf(`<font color="red">%s</font>`, q.(string)), -1)
			}
		}
	}

	return novs, count
}

// 批量获取小说列表
func (this *Novel) GetAll(size, offset int, args map[string]interface{}) ([]*models.Novel, int64) {
	novs, count := models.NovelModel.GetAll(size, offset, args)

	return novs, count
}

// 删除小说
func (this *Novel) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	m := models.Novel{Id: id}
	err := m.Delete(true)
	if err != nil {
		return err
	}

	// 删除小说章节列表
	ChapterService.DelByNovId(id)

	return nil
}

// 清空小说章节列表
func (this *Novel) DelChapters(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	nov := this.Get(id)
	if nov == nil {
		return errors.New("获取小说失败")
	}

	// 删除章节列表
	err := ChapterService.DelByNovId(id)
	if err != nil {
		//return err
	}

	nov.ChapterNum = 0
	nov.ChapterId = 0
	nov.TextNum = 0
	nov.ChapterTitle = ""
	nov.ChapterUpdatedAt = 0

	nov.Update("chapter_num", "chapter_id", "text_num", "chapter_title", "chapter_updated_at")

	return nil
}

// 删除小说采集站点
func (this *Novel) DelLink(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	m := models.NovelLinks{Id: id}
	err := m.Delete(true)
	if err != nil {
		return err
	}

	return nil
}

// 更新浏览次数
func (this *Novel) UpViews(novId uint32) {
	nov := this.Get(novId)
	if nov == nil {
		return
	}

	nov.Views++

	nov.Update("views")
}

// 更新小说连载状态
func (this *Novel) UpStatus(novId uint32, status uint8) {
	nov := this.Get(novId)
	if nov == nil {
		return
	}

	nov.Status = status

	nov.Update("status")
}

// 修改小说简介信息
func (this *Novel) UpNovelInfo(nov *models.Novel) error {
	// 获取分类名称
	cate := CateService.Get(nov.CateId)
	if cate == nil {
		return errors.New("分类不存在或者已被删除")
	}

	nov.CateName = cate.Name
	err := nov.Update("desc", "cover", "cate_id", "cate_name", "author")

	return err
}

// 修改章节信息
func (this *Novel) UpChapterInfo(novId uint32, novTextNum, chapterNum int, chapterId uint64, chapterTitle string, status uint8) {
	nov := this.Get(novId)
	if nov == nil {
		return
	}

	nov.ChapterNum += uint32(chapterNum)
	nov.TextNum += uint32(novTextNum)
	nov.ChapterId = chapterId
	nov.ChapterTitle = chapterTitle
	nov.ChapterUpdatedAt = uint32(time.Now().Unix())

	if status > 0 {
		nov.Status = status
	}

	nov.Update("text_num", "chapter_num", "chapter_id", "chapter_title", "chapter_updated_at", "status")
}

// 添加/修改
func (this *Novel) Save(novel *models.Novel) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(novel.Name, "nameEmpty").Message("小说名称不能为空")
	valid.MaxSize(novel.Name, 50, "nameMax").Message("小说名称长度不能超过50个字符")
	valid.Required(novel.Author, "authorEmpty").Message("小说作者不能为空")
	valid.MaxSize(novel.Author, 20, "authorMax").Message("作者名称不能超过20个字符")

	valid.Required(novel.CateId, "cidEmpty").Message("小说分类不能为空")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	// 获取分类名称
	cate := CateService.Get(novel.CateId)
	if cate == nil {
		return errors.New("分类不存在或者已被删除")
	}

	novel.CateName = cate.Name

	var err error
	if novel.Id > 0 {
		err = novel.Update("name", "desc", "cover", "cate_id", "cate_name", "author", "is_hot", "is_rec", "is_vip_rec", "is_today_rec", "status", "is_man_like", "is_girl_like")
	} else {
		novel.Status = models.BOOKOPEN
		err = novel.Insert()
	}

	return err
}
