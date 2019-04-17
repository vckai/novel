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
)

// banner图管理
type Banner struct {
	Id        uint32 `orm:"auto;size(11)"`
	Name      string `orm:"size(100)"`
	Img       string `orm:"size(100)"`
	Link      string `orm:"size(100)"`
	Zone      uint8  `orm:"size(3)"`
	Ext       string `orm:"size(100)"`
	Desc      string `orm:"size(100)"`
	Status    uint8  `orm:"size(1);default(0)"`
	CreatedAt uint32 `orm:"size(11);default(0)"`
	UpdatedAt uint32 `orm:"size(11);default(0)"`
	DeletedAt uint32 `orm:"size(11);default(0)`
}

func NewBanner() *Banner {
	return &Banner{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(Banner))
}

func (m *Banner) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *Banner) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 读取
func (m *Banner) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}

// 修改
func (m *Banner) Update(fields ...string) error {
	m.UpdatedAt = uint32(time.Now().Unix())
	if len(fields) > 0 {
		fields = append(fields, "updated_at")
	}
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}

// 批量删除
func (m *Banner) DeleteBatch(ids []string) error {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}
	sqlStr := fmt.Sprintf("DELETE FROM nov_banner WHERE `id` %s", fmt.Sprintf("IN (%s)", strings.Join(marks, ", ")))

	_, err := orm.NewOrm().Raw(sqlStr, ids).Exec()

	return err
}

// 删除
func (m *Banner) Delete(forceDelete ...bool) error {
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

// 获取banner列表
func (m *Banner) GetAll(args map[string]interface{}) []*Banner {
	list := make([]*Banner, 0)

	qs := m.optionHandle(args)

	qs.All(&list, "id", "name", "img", "link", "zone", "desc", "status", "created_at", "ext")

	return list
}

// 获取是否显示
func (m Banner) StatusName() string {
	if m.Status == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">不显示</span>`
	}

	return `<span class="layui-btn layui-btn-xs">已显示</span>`
}

// 过滤条件
func (m *Banner) optionHandle(args map[string]interface{}) orm.QuerySeter {
	qs := m.query()
	qs = qs.Filter("deleted_at", 0)

	argsFilters := []string{"zone"}
	for _, v := range argsFilters {
		if c, ok := args[v]; ok && c.(int) > 0 {
			qs = qs.Filter(v, c.(int))
		}
	}

	return qs
}
