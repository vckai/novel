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
	"errors"

	"github.com/astaxie/beego/validation"

	"novel/app/models"
)

// 定义GroupService
type Group struct{}

func NewGroup() *Group {
	return &Group{}
}

// 获取单个群组
func (this *Group) Get(id uint32) *models.Group {
	if id < 0 {
		return nil
	}

	group := &models.Group{Id: id}
	err := group.Read()
	if err != nil {
		return nil
	}

	return group
}

// 验证该权限组是否有接口权限
func (this *Group) ValidPurview(groupId uint32, module, action string) bool {
	group := GroupService.Get(groupId)
	if group == nil {
		return false
	}

	return RoleService.ValidPurview(groupId, module, action, group.GetRoleIds())
}

// 获取当前权限组菜单列表
func (this *Group) GetMenus(groupId uint32) []*models.Role {
	group := GroupService.Get(groupId)
	if group == nil {
		return nil
	}

	roleIds := []string{}
	if groupId != 1 {
		roleIds = group.GetRoleIds()
	}

	return RoleService.GetMenus(roleIds)
}

// 删除群组
func (this *Group) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	group := models.Group{Id: id}
	err := group.Delete()
	if err != nil {
		return err
	}

	return nil
}

// 批量获取群组
func (this *Group) GetAll() []*models.Group {
	groups := models.GroupModel.GetAll()

	return groups
}

// 添加菜单/权限
func (this *Group) Save(group *models.Group) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(group.Name, "groupEmpty").Message("群组名称不能为空")
	valid.MaxSize(group.Name, 20, "groupMax").Message("群组名称长度不能超过20个字符")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	var err error
	if group.Id > 0 {
		err = group.Update()
	} else {
		err = group.Insert()
	}

	return err
}
