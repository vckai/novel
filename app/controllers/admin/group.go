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

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services"
	"github.com/vckai/novel/app/utils"
	"github.com/vckai/novel/app/utils/log"
)

type GroupController struct {
	BaseController
}

// 权限管理
func (this *GroupController) Index() {
	groups := services.GroupService.GetAll()

	this.Data["groups"] = groups
	this.Data["groups_count"] = len(groups)
	this.View("group/index.tpl")
}

// 添加群组页面
func (this *GroupController) Add() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	roles := services.RoleService.GetRoles(true)
	roleHtml := this.getRolesHtml(roles, make([]string, 0))

	this.Data["group"] = models.NewGroup()
	this.Data["IsUpdate"] = false
	this.Data["roleHtml"] = roleHtml
	this.Data["PostUrl"] = utils.URLFor("admin.GroupController.Add")
	this.View("group/add.tpl")
}

// 编辑群组页面
func (this *GroupController) Edit() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	group := services.GroupService.Get(id)
	if group == nil {
		this.Msg("该群组不存在或者已被删除")
	}

	// 获取权限列表
	roles := services.RoleService.GetRoles(true)
	roleHtml := this.getRolesHtml(roles, group.GetRoleIds())

	this.Data["group"] = group
	this.Data["IsUpdate"] = true
	this.Data["roleHtml"] = roleHtml
	this.Data["PostUrl"] = utils.URLFor("admin.GroupController.Edit")
	this.View("group/add.tpl")
}

// 删除群组
func (this *GroupController) Delete() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	err := services.GroupService.Delete(id)
	if err != nil {
		this.OutJson(1001, "删除群组失败")
	}

	// 添加操作日记
	this.AddLog(2002, "删除", "", id)

	this.OutJson(0, "已删除！")
}

// 保存数据
// 提供修改/新增处理
func (this *GroupController) save() {
	id, _ := this.GetUint32("group_id")

	mtitle := "添加"
	group := models.NewGroup()
	// 编辑
	if id > 0 {
		group = services.GroupService.Get(id)
		if group == nil {
			this.OutJson(1001, "该权限不存在或者已被删除")
		}

		mtitle = "修改"
	}

	// 入库参数
	group.Name = this.GetString("name")
	group.Desc = this.GetString("desc")
	group.RoleIds = strings.Join(this.GetStrings("role_ids[]"), ",")

	err := services.GroupService.Save(group)
	if err != nil {
		log.Error(mtitle, "权限失败：", err.Error())
		this.OutJson(1002, mtitle+"权限失败："+err.Error())
	}

	// 添加操作日记
	this.AddLog(2002, mtitle, group.Name, group.Id)

	this.OutJson(0, mtitle+"成功")
}

func (this GroupController) getRolesHtml(roles []*models.Role, selRoleIds []string) string {
	htmltpl := `
			<tr>
				<td><input class="roles-select" type="checkbox" lay-skin="primary" value="%d" lay-ignore>%s</td>
				<td>
					<div class="layui-input-block">
					%s
					%s
					</div>
				</td>
			</tr>
		`

	html := ""
	for _, role := range roles {
		html += fmt.Sprintf(htmltpl,
			role.Id,
			role.Name,
			this.getRoleFormatHtml(role, role.Id, selRoleIds),
			this.getRolesChildHtml(role.Child, role.Id, selRoleIds),
		)
	}

	return html
}

// child class html
func (this GroupController) getRolesChildHtml(roles []*models.Role, rootId uint32, selRoleIds []string) string {
	html := ""
	for _, role := range roles {
		// 格式化返回复选框html
		html += this.getRoleFormatHtml(role, rootId, selRoleIds)

		if len(role.Child) > 0 {
			html += this.getRolesChildHtml(role.Child, rootId, selRoleIds)
		}
	}

	return html
}

// 格式化返回复选框html
func (this GroupController) getRoleFormatHtml(role *models.Role, rootId uint32, selRoleIds []string) string {
	sel := ""
	if role.IsDefault == 1 || utils.InArray(fmt.Sprint(role.Id), selRoleIds) {
		sel = "checked"
	}
	html := fmt.Sprintf(`<input class="role_ids" name="role_ids[]" type="checkbox" value="%d" lay-skin="primary" pid="%d" %s> %s`,
		role.Id,
		rootId,
		sel,
		role.Name,
	)

	return html
}
