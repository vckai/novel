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

package admin

import (
	"novel/app/services"
)

type FeedbackController struct {
	BaseController
}

// 管理操作日记列表
func (this *FeedbackController) Index() {
	q := this.GetString("q")
	size := 10
	p, _ := this.GetInt("p", 1)
	offset := (p - 1) * size
	search := map[string]interface{}{
		"q":     q,
		"p":     p,
		"count": true,
	}
	feeds, count := services.FeedbackService.GetAll(size, offset, search)

	this.Data["Search"] = search
	this.Data["Limit"] = feeds
	this.Data["Count"] = count
	this.Data["Limit"] = size
	this.View("feedback/index.tpl")
}

// 删除用户反馈
func (this *FeedbackController) Delete() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	err := services.FeedbackService.Delete(id)
	if err != nil {
		this.OutJson(1001, "删除反馈失败")
	}

	this.OutJson(0, "已删除！")
}

// 批量删除用户反馈
func (this *FeedbackController) DeleteBatch() {
	ids := this.GetStrings("ids[]")
	if len(ids) == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	err := services.FeedbackService.DeleteBatch(ids)
	if err != nil {
		this.OutJson(1002, "批量删除用户反馈失败")
	}

	this.OutJson(0, "已删除！")
}
