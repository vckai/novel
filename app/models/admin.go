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
	"time"

	"github.com/astaxie/beego/orm"
)

// 管理员模型
type Admin struct {
	Id            uint32 `orm:"auto"`
	Account       string `orm:"size(30);unique"`
	Mail          string `orm:"size(100)"`
	Name          string `orm:"size(20)"`
	Mobile        uint64 `orm:"size(11)"`
	Password      string `orm:"size(100)"`
	GroupId       uint32 `orm:"size(11);default(0)"`
	GroupName     string `orm:"-"`
	Status        uint8  `orm:"size(1);default(0)"`
	LoginVisit    uint32 `orm:"size(1);default(0)"`
	LastLoginIp   string `orm:"size(15)"`
	LastLoginedAt uint32 `orm:"size(11)"`
	CreatedAt     uint32 `orm:"size(11)"`
	UpdatedAt     uint32 `orm:"size(11)"`
	DeletedAt     uint32 `orm:"size(11);default(0)"`
}

func NewAdmin() *Admin {
	return &Admin{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(Admin))
}

func (m *Admin) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *Admin) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 读取
func (m *Admin) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}

// 修改
func (m *Admin) Update(fields ...string) error {
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
func (m *Admin) Delete(forceDelete ...bool) error {
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

// 获取管理员列表
func (m *Admin) GetAll() []*Admin {
	list := make([]*Admin, 0)
	m.query().Filter("deleted_at", 0).All(&list, "id", "account", "name", "status", "mail", "mobile", "group_id", "login_visit", "last_login_ip", "last_logined_at", "created_at")

	return list
}

// 判断账号是否存在
func (m *Admin) GetByAccount(account string) *Admin {
	if len(account) == 0 {
		return nil
	}

	var a Admin
	m.query().Filter("account", account).One(&a, "id", "account", "password", "name", "mail", "mobile", "group_id", "login_visit", "last_login_ip", "last_logined_at", "created_at")

	if a.Id < 1 {
		return nil
	}

	return &a
}

// 获取用户状态
func (m Admin) StatusName() string {
	if m.Status == 1 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">禁用</span>`
	}

	return `<span class="layui-btn layui-btn-xs">启用</span>`
}
