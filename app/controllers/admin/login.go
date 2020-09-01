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
)

type LoginController struct {
	BaseController
}

func (this *LoginController) Prepare() {
	this.SetExcepts("Index", "Logout")
	this.BaseController.Prepare()
}

// 登录页面
func (this *LoginController) Index() {
	// ajax post 操作
	if this.IsAjax() {
		this.login()
		return
	}

	this.View("login/index.tpl")
}

// 退出登录
func (this *LoginController) Logout() {
	this.SetLogout()
	this.Redirect(controllers.URLFor("admin.LoginController.Index"), 301)
}

// 登录操作
func (this *LoginController) login() {
	account := this.GetString("username")
	password := this.GetString("pass")

	if len(account) == 0 || len(password) != 32 {
		this.OutJson(1001, "请输入账号或密码")
	}

	admin, err := services.AdminService.Login(account, password)
	if err != nil {
		this.OutJson(1002, "登录失败："+err.Error())
	}

	if admin.Id < 1 {
		this.OutJson(1003, "登录失败：用户信息获取失败")
	}

	// 设置登录态
	this.SetLogin(admin)

	// 修改管理员登录信息
	admin.LastLoginIp = this.Ctx.Input.IP()
	services.AdminService.UpdateLoginInfo(admin)

	// 添加登录日记
	this.AddLog(1001)

	this.OutJson(0, "登录成功", "", controllers.URLFor("admin.MainController.Index"), true)
}
