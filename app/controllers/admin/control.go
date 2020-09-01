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
	"fmt"
	"time"

	"github.com/astaxie/beego"

	"novel/app/controllers"
	"novel/app/models"
	"novel/app/services"
	"novel/app/utils"
)

// 后台管理基类
type BaseController struct {
	controllers.BaseController

	// 排除权限验证的接口
	except []string

	controllerName string
	actionName     string
}

// 初始化
func (this *BaseController) Prepare() {
	this.BaseController.Prepare()

	this.Module = "admin"
	this.Layout = "admin/layout.tpl"

	controllerName, actionName := this.GetControllerAndAction()
	this.controllerName = controllerName[0 : len(controllerName)-10]
	this.actionName = actionName

	this.Auth()
}

// 获取登陆的UID
func (this *BaseController) GetUid() uint32 {
	s := this.GetSession("admin_id")
	if s == nil {
		if beego.AppConfig.String("runmode") == "dev" {
			return 1
		}
		return 0
	}
	return s.(uint32)
}

// 获取登陆的用户昵称
func (this *BaseController) GetNickName() string {
	s := this.GetSession("admin_name")
	if s == nil {
		if beego.AppConfig.String("runmode") == "dev" {
			return "Vckai"
		}
		return ""
	}
	return s.(string)
}

// 设置登录session信息
func (this *BaseController) SetLogin(admin *models.Admin) {
	this.SetSession("admin_id", admin.Id)
	this.SetSession("group_id", admin.GroupId)
	this.SetSession("admin_name", admin.Name)
	this.SetSession("login_visit", admin.LoginVisit)
	this.SetSession("last_login_ip", admin.LastLoginIp)
	this.SetSession("last_logined_at", admin.LastLoginedAt)
	this.SetSession("admin_visit_time", time.Now().Unix())
}

// 退出登录
func (this *BaseController) SetLogout() {
	this.DelSession("admin_id")
	this.DelSession("group_id")
	this.DelSession("admin_name")
	this.DelSession("admin_visit_time")
	this.DelSession("login_visit")
	this.DelSession("last_login_ip")
	this.DelSession("last_logined_at")
}

// 添加后台操作日记
func (this *BaseController) AddLog(logType int, logs ...interface{}) error {
	// 拼装日记内容
	content := this.Tr("admin_log.log_"+fmt.Sprint(logType), logs)

	log := &models.AdminLog{
		Uid:     this.GetUid(),
		Name:    this.GetNickName(),
		Ip:      this.Ctx.Input.IP(),
		Type:    uint(logType),
		Content: content,
	}

	err := services.AdminLogService.Add(log)

	return err
}

// 检测登录权限
func (this *BaseController) Auth() {
	// 排除不验证的接口
	if this.exceptAuth() {
		return
	}

	// 未登录
	if this.GetUid() < 1 {
		if this.IsAjax() {
			this.OutJson(1, "请先登录", "", controllers.URLFor("admin.LoginController.Index"), true)
		}

		this.Msg("请先登录", controllers.URLFor("admin.LoginController.Index"), true)
	}

	if services.AdminService.ValidPurview(this.GetUid(), this.controllerName, this.actionName) {
		return
	}

	if this.IsAjax() {
		this.OutJson(1, "您没有权限执行该操作")
	}

	this.Msg("您没有权限执行该操作")
}

// 设置排除登录验证接口
func (this *BaseController) SetExcepts(actions ...string) {
	this.except = actions
}

// 排除登录验证的接口
func (this *BaseController) exceptAuth() bool {
	if len(this.except) == 0 {
		return false
	}

	if !utils.InArray(this.actionName, this.except) {
		return false
	}

	return true
}
