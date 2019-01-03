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

package api

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
	data := services.NovelService.GetTodayRecs(9, 0)

	this.OutJson(0, "", data)
}

// 用户反馈
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
