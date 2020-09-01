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
	"novel/app/controllers"
	"novel/app/models"
	"novel/app/services"
	"novel/app/utils/log"
)

type AdminController struct {
	BaseController
}

// 管理员列表
func (this *AdminController) Index() {
	admins := services.AdminService.GetAll()

	this.Data["List"] = admins
	this.Data["Count"] = len(admins)
	this.View("admin/index.tpl")
}

// 添加管理员页面
func (this *AdminController) Add() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	groups := services.GroupService.GetAll()

	this.Data["admin"] = models.NewAdmin()
	this.Data["IsAdd"] = true
	this.Data["groups"] = groups
	this.Data["PostUrl"] = controllers.URLFor("admin.AdminController.Add")
	this.View("admin/add.tpl")
}

// 编辑管理员页面
func (this *AdminController) Edit() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误")
	}

	admin := services.AdminService.Get(id)
	if admin == nil {
		this.Msg("该管理员不存在或者已被删除")
	}

	// 获取群组列表
	groups := services.GroupService.GetAll()

	this.Data["admin"] = admin
	this.Data["IsAdd"] = false
	this.Data["groups"] = groups
	this.Data["PostUrl"] = controllers.URLFor("admin.AdminController.Edit")
	this.View("admin/add.tpl")
}

// 修改密码
func (this *AdminController) EditPass() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误")
	}

	admin := services.AdminService.Get(id)
	if admin == nil {
		this.Msg("该管理员不存在或者已被删除")
	}

	// post 数据提交
	// 修改密码
	if this.IsAjax() {
		admin.Password = this.GetString("pass")
		err := services.AdminService.UpdatePwd(admin)
		if err != nil {
			this.OutJson(1001, "修改密码失败："+err.Error())
		}

		// 添加操作日记
		this.AddLog(2004, admin.Name, admin.Id)
		this.OutJson(0, "修改密码成功")
	}

	this.Data["admin"] = admin
	this.View("admin/editpass.tpl")
}

// 删除管理员
func (this *AdminController) Delete() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	err := services.AdminService.Delete(id)
	if err != nil {
		this.OutJson(1001, "删除管理员失败")
	}

	// 添加操作日记
	this.AddLog(2003, "删除", "", id)
	this.OutJson(0, "已删除！")
}

// 保存数据
// 提供修改/新增处理
func (this *AdminController) save() {
	id, _ := this.GetUint32("admin_id")

	mtitle := "添加"
	admin := models.NewAdmin()
	// 编辑
	if id > 0 {
		admin = services.AdminService.Get(id)
		if admin == nil {
			this.OutJson(1001, "该管理员不存在或者已被删除")
		}

		mtitle = "修改"
	}

	admin.Account = this.GetString("account")
	if services.AdminService.IsAccountExists(admin.Account, id) {
		this.OutJson(1002, "该账号已存在")
	}

	// 入库参数
	admin.Name = this.GetString("nickname")
	admin.Password = this.GetString("pass")
	admin.Mail = this.GetString("mail")
	admin.Mobile, _ = this.GetUint64("mobile")
	status, _ := this.GetUint8("status")
	admin.Status = 0
	if status == 0 {
		admin.Status = 1
	}

	admin.GroupId, _ = this.GetUint32("group_id")

	err := services.AdminService.Save(admin)
	if err != nil {
		log.Error(mtitle, "管理员失败：", err.Error())
		this.OutJson(1003, mtitle+"管理员失败："+err.Error())
	}
	// 添加操作日记
	this.AddLog(2003, mtitle, admin.Name, admin.Id)

	this.OutJson(0, mtitle+"成功")
}
