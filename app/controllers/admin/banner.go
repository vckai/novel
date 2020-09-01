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

type BannerController struct {
	BaseController
}

// 管理员列表
func (this *BannerController) Index() {
	args := map[string]interface{}{}
	banners := services.BannerService.GetAll(args)

	this.Data["Zones"] = services.BannerService.Zones()
	this.Data["List"] = banners
	this.Data["Count"] = len(banners)
	this.View("banner/index.tpl")
}

// 添加管理员页面
func (this *BannerController) Add() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	this.Data["Zones"] = services.BannerService.Zones()
	this.Data["Banner"] = models.NewBanner()
	this.Data["IsAdd"] = true
	this.Data["PostUrl"] = controllers.URLFor("admin.BannerController.Add")
	this.View("banner/add.tpl")
}

// 编辑管理员页面
func (this *BannerController) Edit() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	banner := services.BannerService.Get(id)
	if banner == nil {
		this.Msg("该banner不存在或者已被删除")
	}

	this.Data["Zones"] = services.BannerService.Zones()
	this.Data["Banner"] = banner
	this.Data["IsAdd"] = false
	this.Data["PostUrl"] = controllers.URLFor("admin.BannerController.Edit")
	this.View("banner/add.tpl")
}

// 删除小说分类
func (this *BannerController) Delete() {
	id, _ := this.GetUint32("id")
	name := this.GetString("name", "")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	err := services.BannerService.Delete(id)
	if err != nil {
		this.OutJson(1001, "删除banner失败")
	}

	// 添加操作日记
	this.AddLog(4001, "删除", name, id)
	this.OutJson(0, "已删除！")
}

// 批量删除操作日记
func (this *BannerController) DeleteBatch() {
	ids := this.GetStrings("ids[]")
	if len(ids) == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	err := services.BannerService.DeleteBatch(ids)
	if err != nil {
		this.OutJson(1002, "批量删除操作banner失败")
	}
	// 添加操作日记
	this.AddLog(4002, strings.Join(ids, ","))

	this.OutJson(0, "已删除！")
}

// 保存数据
// 提供修改/新增处理
func (this *BannerController) save() {
	id, _ := this.GetUint32("id")

	mtitle := "添加"
	banner := models.NewBanner()
	// 编辑
	if id > 0 {
		banner = services.BannerService.Get(id)
		if banner == nil {
			this.OutJson(1001, "该banner不存在或者已被删除")
		}

		mtitle = "修改"
	}

	// 入库参数
	banner.Name = this.GetString("name")
	banner.Img = this.GetString("img")
	banner.Zone, _ = this.GetUint8("zone")
	banner.Status = 1
	banner.Link = this.GetString("link")
	banner.Desc = this.GetString("desc")
	banner.Ext = this.GetString("ext")

	err := services.BannerService.Save(banner)
	if err != nil {
		log.Error(mtitle, "banner失败：", err.Error())
		this.OutJson(1003, mtitle+"失败："+err.Error())
	}
	// 添加操作日记
	this.AddLog(4001, mtitle, banner.Name, banner.Id)

	this.OutJson(0, mtitle+"成功")
}
