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
	"strings"

	"novel/app/models"
	"novel/app/services"
)

type SearchController struct {
	BaseController
}

// 搜索记录列表
func (this *SearchController) Index() {
	kw := this.GetString("q")
	size := 10
	p, _ := this.GetInt("p", 1)

	args := models.ArgsSearchList{}
	args.Count = true
	args.Limit = size
	args.Offset = (p - 1) * size
	args.IsRec = -1
	args.Keyword = kw

	list, count := services.SearchService.GetAll(args)

	this.Data["Search"] = map[string]interface{}{
		"kw":    kw,
		"page":  p,
		"limit": size,
	}
	this.Data["List"] = list
	this.Data["Count"] = count
	this.View("search/index.tpl")
}

// 删除搜索记录
func (this *SearchController) Delete() {
	id, _ := this.GetUint64("id")
	kw := this.GetString("kw")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	err := services.SearchService.Delete(id)
	if err != nil {
		this.OutJson(1001, "删除搜索记录失败")
	}

	// 添加操作日记
	this.AddLog(5001, "删除", kw, id)
	this.OutJson(0, "已删除！")
}

// 批量删除搜索记录
func (this *SearchController) DeleteBatch() {
	ids := this.GetStrings("ids[]")
	if len(ids) == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	err := services.SearchService.DeleteBatch(ids)
	if err != nil {
		this.OutJson(1002, "批量删除操作记录失败")
	}

	// 添加操作日记
	this.AddLog(5002, strings.Join(ids, ","))

	this.OutJson(0, "已删除！")
}

// 设置/取消推荐
func (this *SearchController) UpRec() {
	kw := this.GetString("kw")
	id, _ := this.GetUint64("id")
	if id == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}
	rec, _ := this.GetUint8("is_rec")

	err := services.SearchService.UpRec(id, rec)
	if err != nil {
		this.OutJson(1002, "操作失败")
	}

	if rec == 1 {
		this.AddLog(5001, "设置推荐", kw, id)
	} else {
		this.AddLog(5001, "取消推荐", kw, id)
	}
	this.OutJson(0, "操作成功")
}
