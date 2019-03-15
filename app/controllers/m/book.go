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

package m

import (
	"github.com/astaxie/beego"

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services"
)

const (
	PAGESIZE = 5
)

type BookController struct {
	BaseController
}

// 首页
func (this *BookController) Index() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	// 获取小说详情
	novel := services.NovelService.Get(id)
	if novel == nil {
		this.Msg("该小说不存在或者已被删除")
	}

	// 获取章节列表
	chaps, count := services.ChapterService.GetNovChaps(novel.Id, 10, 0, "asc", true)
	this.SetPaginator(10, count)

	// 获取同类推荐
	this.Data["NovRecs"] = services.NovelService.GetCateRanks(int(novel.CateId), 3, 0)

	// 获取最新章节
	this.Data["FirstChap"] = services.ChapterService.GetFirst(novel.Id)
	this.Data["Chaps"] = chaps
	this.Data["Nov"] = novel
	this.Data["Title"] = novel.Name + " - " + novel.Author

	services.NovelService.UpViews(novel.Id)

	this.View("book/index.tpl")
}

// 小说列表
func (this *BookController) List() {
	q := this.GetString("q")
	cateId, _ := this.GetInt("cate_id")

	search := map[string]interface{}{
		"q":       q,
		"cate_id": cateId,
		"count":   false,
	}
	novels, _ := services.NovelService.GetList(PAGESIZE, 0, search)

	this.Data["Search"] = search
	this.Data["Novels"] = novels
	this.Data["IsNext"] = len(novels) >= PAGESIZE
	this.Data["Cates"] = services.CateService.GetAll()

	this.View("book/cate.tpl")
}

// 获取章节列表
func (this *BookController) AjaxChaps() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	p, _ := this.GetInt("p")
	asc := this.GetString("asc")

	if p < 1 {
		p = 1
	}

	offset := (p - 1) * 10

	// 获取章节列表
	chaps, _ := services.ChapterService.GetNovChaps(id, 10, offset, asc, false)

	var res []map[string]interface{}

	for _, chap := range chaps {
		tmp := make(map[string]interface{})

		tmp["id"] = chap.Id
		tmp["no"] = chap.ChapterNo
		tmp["title"] = chap.Title

		res = append(res, tmp)
	}

	this.OutJson(0, "", res)
}

// 详情页
func (this *BookController) Detail() {
	id, _ := this.GetUint64("id")
	novId, _ := this.GetUint32("novid")
	if id < 1 || novId < 1 {
		this.Msg("参数错误，无法访问")
	}

	chap := services.ChapterService.Get(id, novId)
	if chap == nil {
		this.Msg("该章节不存在或者已被删除")
	}

	// 浏览次数增加
	services.ChapterService.UpdateViews(chap)

	// 获取小说详情
	nov := services.NovelService.Get(chap.NovId)
	if nov == nil {
		this.Msg("该小说不存在或者已被删除")
	}

	this.Data["Nov"] = nov
	this.Data["Chap"] = chap
	this.Data["Next"] = services.ChapterService.GetNext(chap.NovId, chap.ChapterNo)
	this.Data["Pre"] = services.ChapterService.GetPre(chap.NovId, chap.ChapterNo)
	this.Data["Title"] = chap.Title + " - " + nov.Name

	this.View("book/detail.tpl")
}

// 搜索
func (this *BookController) Search() {
	q := this.GetString("keyword")

	search := map[string]interface{}{
		"q":     q,
		"count": false,
	}
	novels, _ := services.NovelService.GetList(PAGESIZE, 0, search)

	this.Data["SnatchNovels"] = nil
	// 非正式环境从采集点中搜索
	if beego.AppConfig.String("runmode") != "prod" {
		this.Data["SnatchNovels"] = services.SnatchService.FindNovels(q)
	}

	this.Data["Search"] = search
	this.Data["Novels"] = novels
	this.Data["IsNext"] = len(novels) >= PAGESIZE
	this.Data["Title"] = q + "搜索结果"

	this.View("book/search.tpl")
}

// 排行列表
func (this *BookController) Rank() {
	novels := services.NovelService.GetRanks(PAGESIZE, 0)

	this.Data["Novels"] = novels
	this.Data["IsNext"] = len(novels) >= PAGESIZE
	this.Data["Title"] = "排行榜"

	this.View("book/list.tpl")
}

// 最新更新小说列表
func (this *BookController) New() {
	novels := services.NovelService.GetNewUps(100, 0)

	this.Data["Novels"] = novels
	this.Data["IsNext"] = false
	this.Data["Title"] = "最新更新"

	this.View("book/list.tpl")
}

// 完本小说列表
func (this *BookController) End() {
	novels := services.NovelService.GetEnds(100, 0)

	this.Data["Novels"] = novels
	this.Data["IsNext"] = len(novels) >= PAGESIZE
	this.Data["Title"] = "完本小说"

	this.View("book/list.tpl")
}

// ajax获取小说列表
func (this *BookController) AjaxNovels() {
	p, _ := this.GetInt("p")
	cateId, _ := this.GetInt("cate_id")
	q := this.GetString("q")

	if p < 1 {
		p = 1
	}

	offset := (p - 1) * PAGESIZE

	var novels []*models.Novel
	switch this.GetString("act") {
	case "rank":
		novels = services.NovelService.GetRanks(PAGESIZE, offset)
	case "end":
		novels = services.NovelService.GetEnds(PAGESIZE, offset)
	default:
		// 获取小说列表
		search := map[string]interface{}{
			"q":       q,
			"cate_id": cateId,
			"count":   false,
		}
		novels, _ = services.NovelService.GetList(PAGESIZE, offset, search)
	}

	var list []map[string]interface{}

	for _, nov := range novels {
		tmp := make(map[string]interface{})

		tmp["id"] = nov.Id
		tmp["name"] = nov.Name
		tmp["author"] = nov.Author
		tmp["cate_name"] = nov.CateName
		tmp["desc"] = beego.HTML2str(nov.Desc)
		tmp["cover"] = nov.Cover

		list = append(list, tmp)
	}

	res := map[string]interface{}{
		"is_next": len(list) >= PAGESIZE,
		"list":    list,
	}
	this.OutJson(0, "", res)
}
