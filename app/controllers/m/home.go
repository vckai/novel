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
	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services"
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
