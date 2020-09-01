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
	"novel/app/services"
	"novel/app/utils/log"
)

type MainController struct {
	BaseController
}

// 登录页面
func (this *MainController) Index() {
	this.Data["LoginUserName"] = this.GetNickName()
	this.Data["Menus"] = services.AdminService.GetMenus(this.GetUid())
	this.View("main/index.tpl")
}

// 编辑管理员页面
func (this *MainController) EditUser() {
	id := this.GetUid()

	admin := services.AdminService.Get(id)
	if admin == nil {
		this.Msg("该管理员不存在或者已被删除")
	}

	// post 数据提交
	if this.IsAjax() {
		// 入库参数
		admin.Name = this.GetString("nickname")
		admin.Mail = this.GetString("mail")
		admin.Mobile, _ = this.GetUint64("mobile")
		admin.Password = ""

		err := services.AdminService.Save(admin)
		if err != nil {
			log.Error("修改个人信息失败：", err.Error())
			this.OutJson(1003, "修改个人信息失败："+err.Error())
		}
		// 添加操作日记
		this.AddLog(2003, "修改", admin.Name, admin.Id)

		this.OutJson(0, "修改成功")
		return
	}

	this.Data["admin"] = admin
	this.Data["PostUrl"] = controllers.URLFor("admin.MainController.EditUser")
	this.View("main/edituser.tpl")
}

// 修改个人密码
func (this *MainController) EditPass() {
	id := this.GetUid()

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
	this.Data["PostUrl"] = controllers.URLFor("admin.MainController.EditPass")
	this.View("main/editpass.tpl")
}
