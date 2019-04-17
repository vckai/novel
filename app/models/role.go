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

package models

import (
	"fmt"
	"time"

	"github.com/astaxie/beego/orm"
)

// 权限模型
type Role struct {
	Id        uint32  `orm:"auto;size(11)"`
	Pid       uint32  `orm:"default(0);"`
	Name      string  `orm:"size(30)"`
	Icon      string  `orm:"size(10)"`
	IsMenu    uint8   `orm:"size(1)"`
	Desc      string  `orm:"size(255)"`
	Module    string  `orm:"size(50)"`
	Action    string  `orm:"size(50)"`
	Sort      uint8   `orm:"size(3)"`
	IsDefault uint8   `orm:"size(1);default(0)"`
	CreatedAt uint32  `orm:"size(11)"`
	UpdatedAt uint32  `orm:"size(11)"`
	DeletedAt uint32  `orm:"size(11);default(0)"`
	Child     []*Role `orm:"-"`
}

func NewRole() *Role {
	return &Role{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(Role))
}

func (m *Role) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *Role) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 读取
func (m *Role) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}

// 修改
func (m *Role) Update(fields ...string) error {
	m.UpdatedAt = uint32(time.Now().Unix())
	if len(fields) > 0 {
		fields = append(fields, "updated_at")
	}

	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}

// 删除
func (m *Role) Delete(forceDelete ...bool) error {
	// 软删除
	if len(forceDelete) == 0 {
		m.DeletedAt = uint32(time.Now().Unix())
		return m.Update("deleted_at")
	}

	// 强制删除
	if _, err := orm.NewOrm().Delete(m); err != nil {
		return err
	}
	return nil
}

// 获取后台菜单列表
func (m *Role) GetMenus(roleIds []string) []*Role {
	list := make([]*Role, 0)
	qs := m.query().Filter("is_menu", 1).Filter("deleted_at", 0)

	// 根据权限过滤
	if len(roleIds) > 0 {
		qs.Filter("id__in", roleIds)
	}
	qs.OrderBy("-sort").All(&list, "id", "pid", "name", "icon", "module", "action")

	return list
}

// 获取权限列表
func (m *Role) GetRoles() []*Role {
	list := make([]*Role, 0)
	m.query().Filter("deleted_at", 0).All(&list, "id", "pid", "name", "icon", "module", "action", "is_menu", "is_default")

	return list
}

// 根据接口获取权限id
func (m *Role) GetByPurview(module, action string) *Role {
	var r Role

	m.query().Filter("module", module).Filter("action", action).Filter("deleted_at", 0).One(&r, "id")

	return &r
}

// 拼接URL地址
func (m Role) Url() string {
	return fmt.Sprintf("admin.%sController.%s", m.Module, m.Action)
}

// 获取是否菜单
func (m Role) IsMenuName() string {
	if m.IsMenu == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">否</span>`
	}

	return `<span class="layui-btn layui-btn-xs">是</span>`
}
