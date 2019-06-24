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

// 后台日记操作
type AdminLog struct {
	Id        uint32 `orm:"auto"`
	Uid       uint32 `orm:"size(11)"`
	Name      string `orm:"size(50)"`
	Ip        string `orm:"size(15);"`
	Type      uint   `orm:"size(5);"`
	Content   string `orm:"size(255);"`
	CreatedAt uint32 `orm:"size(11)"`
	UpdatedAt uint32 `orm:"size(11)"`
	DeletedAt uint32 `orm:"size(11);default(0)"`
}

// 管理日记列表参数
type ArgsAdminLog struct {
	ArgsBase
	StartTime int64
	EndTime   int64
}

func NewAdminLog() *AdminLog {
	return &AdminLog{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix(TABLE_PREFIX, new(AdminLog))
}

func (m *AdminLog) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *AdminLog) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 读取
func (m *AdminLog) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}

// 修改
func (m *AdminLog) Update(fields ...string) error {
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
func (m *AdminLog) DeleteBatch(ids []string) error {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}
	sqlStr := fmt.Sprintf("UPDATE %sadmin_log SET deleted_at=? WHERE `id` IN(%s)", TABLE_PREFIX, strings.Join(marks, ", "))

	_, err := orm.NewOrm().Raw(sqlStr, uint32(time.Now().Unix()), ids).Exec()

	return err
}

// 删除
func (m *AdminLog) Delete(forceDelete ...bool) error {
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

// 获取日记列表
func (m *AdminLog) GetAll(args ArgsAdminLog) ([]*AdminLog, int64) {
	list := make([]*AdminLog, 0)
	qs := m.query()
	qs = qs.Filter("deleted_at", 0)

	if args.StartTime > 0 {
		qs = qs.Filter("created_at__gte", args.StartTime)
	}

	if args.EndTime > 0 {
		qs = qs.Filter("created_at__lte", args.EndTime)
	}

	if args.Keyword != "" {
		qs = qs.Filter("content__contains", args.Keyword)
	}

	var count int64 = 0
	if args.Count {
		count, _ = qs.Count()
	}

	// 分页
	if args.Limit > 0 {
		qs = qs.Limit(args.Limit, args.Offset)
	}

	orderBy := "-id"
	if args.OrderBy != "" {
		orderBy = args.OrderBy
	}

	if count > 0 || args.Count == false {
		qs.OrderBy(orderBy).All(&list, "id", "name", "content", "type", "ip", "created_at")
	}

	return list, count
}
