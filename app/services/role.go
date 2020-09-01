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

package services

import (
	"fmt"

	"github.com/astaxie/beego/validation"

	"novel/app/models"
	"novel/app/utils"
)

type Role struct{}

func NewRole() *Role {
	return &Role{}
}

// 获取单个权限
func (this *Role) GetRole(id uint32) *models.Role {
	if id < 0 {
		return nil
	}

	role := &models.Role{Id: id}
	err := role.Read()
	if err != nil {
		return nil
	}

	return role
}

// 检查是否有权限
func (this *Role) ValidPurview(groupId uint32, module, action string, roleIds []string) bool {
	role := models.RoleModel.GetByPurview(module, action)
	if role.Id == 0 && groupId == 1 {
		// 权限不存在，自动生成权限记录
		r := &models.Role{
			Name:   module + "/" + action,
			Module: module,
			Action: action,
		}
		r.Insert()
		return true
	}

	if groupId == 1 {
		return true
	}

	if len(roleIds) == 0 {
		return false
	}

	if !utils.InArray(fmt.Sprint(role.Id), roleIds) {
		return false
	}

	return true
}

// 获取菜单分类
func (this *Role) GetMenus(roleIds []string) []*models.Role {
	menus := models.RoleModel.GetMenus(roleIds)
	tree := this.getTree(menus)

	return tree
}

// 获取权限分类
func (this *Role) GetRoles(isTree ...bool) []*models.Role {
	menus := models.RoleModel.GetRoles()

	if len(isTree) > 0 {
		menus = this.getTree(menus)
	}

	return menus
}

// 生成树分类
func (this *Role) getTree(menus []*models.Role) []*models.Role {
	tmpMap := make(map[uint32]*models.Role)
	var tree []*models.Role
	for _, menu := range menus {
		tmpMap[menu.Id] = menu
	}

	for _, menu := range menus {
		if _, ok := tmpMap[menu.Pid]; ok {
			tmpMap[menu.Pid].Child = append(tmpMap[menu.Pid].Child, tmpMap[menu.Id])
		} else {
			tree = append(tree, tmpMap[menu.Id])
		}
	}

	return tree
}

// 添加菜单/权限
func (this *Role) Save(role *models.Role) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(role.Name, "nameEmpty").Message("权限名称不能为空")
	valid.MaxSize(role.Name, 20, "nameMax").Message("权限名称长度不能超过20个字符")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	var err error
	if role.Id > 0 {
		err = role.Update("name", "is_menu", "icon", "desc", "module", "action", "sort", "is_default", "pid")
	} else {
		err = role.Insert()
	}

	return err
}
