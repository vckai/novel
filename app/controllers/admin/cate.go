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

	"novel/app/controllers"
	"novel/app/models"
	"novel/app/services"
	"novel/app/utils/log"
)

type CateController struct {
	BaseController
}

// 管理员列表
func (this *CateController) Index() {
	cates := services.CateService.GetAll()

	this.Data["List"] = cates
	this.Data["Count"] = len(cates)
	this.View("cate/index.tpl")
}

// 添加管理员页面
func (this *CateController) Add() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	this.Data["Cate"] = models.NewCate()
	this.Data["IsAdd"] = true
	this.Data["PostUrl"] = controllers.URLFor("admin.CateController.Add")
	this.View("cate/add.tpl")
}

// 编辑管理员页面
func (this *CateController) Edit() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	cate := services.CateService.Get(id)
	if cate == nil {
		this.Msg("该分类不存在或者已被删除")
	}

	this.Data["Cate"] = cate
	this.Data["IsAdd"] = false
	this.Data["PostUrl"] = controllers.URLFor("admin.CateController.Edit")
	this.View("cate/add.tpl")
}

// 删除小说分类
func (this *CateController) Delete() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	err := services.CateService.Delete(id)
	if err != nil {
		this.OutJson(1001, "删除分类失败")
	}

	// 添加操作日记
	this.AddLog(3001, "删除", "", id)
	this.OutJson(0, "已删除！")
}

// 批量删除分类
func (this *CateController) DeleteBatch() {
	ids := this.GetStrings("ids[]")
	if len(ids) == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	err := services.CateService.DeleteBatch(ids)
	if err != nil {
		this.OutJson(1002, "批量删除分类失败")
	}

	// 添加操作日记
	this.AddLog(3004, strings.Join(ids, ","))

	this.OutJson(0, "已删除！")
}

// 保存数据
// 提供修改/新增处理
func (this *CateController) save() {
	id, _ := this.GetUint32("cate_id")

	mtitle := "添加"
	cate := models.NewCate()
	// 编辑
	if id > 0 {
		cate = services.CateService.Get(id)
		if cate == nil {
			this.OutJson(1001, "该分类不存在或者已被删除")
		}

		mtitle = "修改"
	}

	// 入库参数
	cate.Name = this.GetString("name")
	cate.IsHome, _ = this.GetUint8("is_home")
	cate.IsMenu, _ = this.GetUint8("is_menu")

	err := services.CateService.Save(cate)
	if err != nil {
		log.Error(mtitle, "分类失败：", err.Error())
		this.OutJson(1003, mtitle+"分类失败："+err.Error())
	}
	// 添加操作日记
	this.AddLog(3001, mtitle, cate.Name, cate.Id)

	this.OutJson(0, mtitle+"成功")
}
