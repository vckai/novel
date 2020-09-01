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
	"novel/app/models"
	"novel/app/services"
)

type HomeController struct {
	BaseController
}

// 首页
func (this *HomeController) Index() {
	// 获取今日推荐
	this.Data["NovTodayRecs"] = services.NovelService.GetTodayRecs(5, 0)

	// 获取小编推荐
	this.Data["NovRecs"] = services.NovelService.GetRecs(3, 0)

	// 获取小编热推
	NovHots := services.NovelService.GetHots(5, 0)

	this.Data["NovHot"] = nil
	this.Data["NovHots"] = nil
	if len(NovHots) > 0 {
		this.Data["NovHot"] = NovHots[0:1][0]
		if len(NovHots) > 1 {
			this.Data["NovHots"] = NovHots[1:]
		}
	}

	// 获取精品推荐
	this.Data["NovVipRecs"] = services.NovelService.GetVipRecs(3, 0)

	// banner 轮播图
	args := map[string]interface{}{
		"zone": int(services.ZONEMINDEX),
	}
	this.Data["Banners"] = services.BannerService.GetAll(args)

	this.View("home/index.tpl")
}

func (this *HomeController) Feedback() {

	// post 数据提交
	if this.IsAjax() {
		feed := models.NewFeedback()
		// 入库参数
		feed.Content = this.GetString("content")
		feed.Contact = this.GetString("contact")
		feed.Ip = this.Ctx.Input.IP()
		err := services.FeedbackService.Save(feed)
		if err != nil {
			this.OutJson(1001, "反馈失败："+err.Error())
		}

		this.OutJson(0, "反馈成功")
		return
	}

	this.Data["Title"] = "建议反馈"
	this.View("home/feedback.tpl")
}

// 小说列表
func (this *HomeController) List() {
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

// 搜索
func (this *HomeController) Search() {
	q := this.GetString("keyword")

	search := map[string]interface{}{
		"q":     q,
		"count": false,
	}
	novels, _ := services.NovelService.GetList(PAGESIZE, 0, search)

	log := &models.SearchLog{
		Kw:     q,
		Source: 1,
		Ip:     this.Ctx.Input.IP(),
	}

	if len(novels) > 0 {
		log.IsResult = 1
	}
	services.SearchService.InsertOrIncrement(q, log)

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
func (this *HomeController) Rank() {
	novels := services.NovelService.GetRanks(PAGESIZE, 0)

	this.Data["Novels"] = novels
	this.Data["IsNext"] = len(novels) >= PAGESIZE
	this.Data["Title"] = "排行榜"

	this.View("book/list.tpl")
}

// 最新更新小说列表
func (this *HomeController) New() {
	novels := services.NovelService.GetNewUps(100, 0)

	this.Data["Novels"] = novels
	this.Data["IsNext"] = false
	this.Data["Title"] = "最新更新"

	this.View("book/list.tpl")
}

// 完本小说列表
func (this *HomeController) End() {
	novels := services.NovelService.GetEnds(100, 0)

	this.Data["Novels"] = novels
	this.Data["IsNext"] = len(novels) >= PAGESIZE
	this.Data["Title"] = "完本小说"

	this.View("book/list.tpl")
}
