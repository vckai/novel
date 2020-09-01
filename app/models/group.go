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
	"strings"
	"time"

	"github.com/astaxie/beego/orm"

	"novel/app/utils"
)

// 管理员群组
type Group struct {
	Id        uint32 `orm:"auto"`
	Name      string `orm:"size(30)"`
	Desc      string `orm:"size(255)"`
	RoleIds   string `orm:"size(2555);"`
	CreatedAt uint32 `orm:"size(11)"`
	UpdatedAt uint32 `orm:"size(11)"`
	DeletedAt uint32 `orm:"size(11);default(0)"`
}

func NewGroup() *Group {
	return &Group{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix(TABLE_PREFIX, new(Group))
}

func (m *Group) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *Group) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 读取
func (m *Group) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}

// 修改
func (m *Group) Update(fields ...string) error {
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
func (m *Group) Delete(forceDelete ...bool) error {
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

// 获取群组列表
func (m *Group) GetAll() []*Group {
	list := make([]*Group, 0)
	m.query().Filter("deleted_at__exact", 0).All(&list, "id", "name", "desc", "role_ids")

	return list
}

// 获取权限id列表
func (m *Group) GetRoleIds() []string {
	return strings.Split(m.RoleIds, ",")
}

// 判断是否有权限
func (m *Group) HasRole(roleId uint32) bool {
	id := fmt.Sprint(roleId)

	return utils.InArray(id, m.GetRoleIds)
}
