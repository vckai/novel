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
	"strings"

	"novel/app/controllers"
	"novel/app/models"
	"novel/app/services"
	"novel/app/utils/log"
)

type RoleController struct {
	BaseController
}

// 权限管理
func (this *RoleController) Index() {
	roles := services.RoleService.GetRoles()

	this.Data["List"] = roles
	this.Data["Count"] = len(roles)
	this.View("role/index.tpl")
}

// 添加权限页面
func (this *RoleController) Add() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	roles := services.RoleService.GetRoles(true)

	html := this.getSelectTree(roles, 0, 0)

	this.Data["role"] = models.NewRole()
	this.Data["IsUpdate"] = false
	this.Data["options"] = html
	this.Data["PostUrl"] = controllers.URLFor("admin.RoleController.Add")
	this.View("role/add.tpl")
}

// 编辑权限页面
func (this *RoleController) Edit() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	role := services.RoleService.GetRole(id)
	if role == nil {
		this.Msg("该权限不存在或者已被删除")
	}

	// 查询权限列表
	roles := services.RoleService.GetRoles(true)

	html := this.getSelectTree(roles, role.Pid, 0)

	this.Data["IsUpdate"] = true
	this.Data["role"] = role
	this.Data["options"] = html
	this.Data["PostUrl"] = controllers.URLFor("admin.RoleController.Edit")
	this.View("role/add.tpl")
}

// 保存数据
// 提供ajax请求
func (this *RoleController) save() {
	id, _ := this.GetUint32("role_id")

	mtitle := "添加"
	role := models.NewRole()
	// 编辑
	if id > 0 {
		role = services.RoleService.GetRole(id)
		if role == nil {
			this.OutJson(1001, "该权限不存在或者已被删除")
		}

		mtitle = "修改"
	}

	pid, _ := this.GetUint32("pid")
	isMenu, _ := this.GetUint8("is_menu")
	sort, _ := this.GetUint8("sort")
	isDefault, _ := this.GetUint8("is_default")

	// 入库参数
	role.Pid = pid
	role.Name = this.GetString("name")
	role.Icon = this.GetString("icon")
	role.Module = this.GetString("module")
	role.Action = this.GetString("action")
	role.IsMenu = isMenu
	role.Sort = sort
	role.IsDefault = isDefault
	role.Desc = this.GetString("desc")

	err := services.RoleService.Save(role)
	if err != nil {
		log.Error(mtitle, "权限失败：", err.Error())
		this.OutJson(1002, mtitle+"权限失败："+err.Error())
	}

	// 添加操作日记
	this.AddLog(2001, mtitle, role.Name, role.Id)

	this.OutJson(0, mtitle+"成功")
}

// 格式化为select表单树
func (this *RoleController) getSelectTree(roles []*models.Role, pid uint32, level int) string {
	html := ""
	for _, role := range roles {
		sel := ""
		if role.Id == pid {
			sel = " selected"
		}
		html += fmt.Sprintf(`<option value="%d" %s>%s%s</option>`,
			role.Id,
			sel,
			strings.Repeat("-", level*2),
			role.Name,
		)

		if role.Id != pid && len(role.Child) > 0 {
			html += this.getSelectTree(role.Child, pid, level+1)
		}
	}

	return html
}
