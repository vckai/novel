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
	"strconv"

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
	id, _ := strconv.ParseUint(this.Ctx.Input.Param(":id"), 10, 32)
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	// 获取小说详情
	novel := services.NovelService.Get(uint32(id))
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

// 详情页
func (this *BookController) Detail() {
	id, _ := strconv.ParseUint(this.Ctx.Input.Param(":id"), 10, 32)
	novId, _ := strconv.ParseUint(this.Ctx.Input.Param(":novid"), 10, 32)

	if id < 1 || novId < 1 {
		this.Msg("参数错误，无法访问")
	}

	chap := services.ChapterService.Get(id, uint32(novId))
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
