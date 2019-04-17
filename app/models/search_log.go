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

// 搜索日记操作
type SearchLog struct {
	Id        uint64 `orm:"auto"`
	Kw        string `orm:"size(100)"`
	Uid       uint32 `orm:"size(11)"`
	Ip        string `orm:"size(15);"`
	Source    uint   `orm:"size(1);"`
	IsResult  uint   `orm:"size(1);"`
	CreatedAt uint32 `orm:"size(11)"`
	UpdatedAt uint32 `orm:"size(11)"`
	DeletedAt uint32 `orm:"size(11);default(0)"`
}

func NewSearchLog() *SearchLog {
	return &SearchLog{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(SearchLog))
}

func (m *SearchLog) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 修改
func (m *SearchLog) Update(fields ...string) error {
	m.UpdatedAt = uint32(time.Now().Unix())
	if len(fields) > 0 {
		fields = append(fields, "updated_at")
	}
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}

// 添加
func (m *SearchLog) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 批量删除
func (m *SearchLog) DeleteBatch(ids []string) error {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}
	sqlStr := fmt.Sprintf("UPDATE nov_search_log SET deleted_at=? WHERE `id` %s", fmt.Sprintf("IN (%s)", strings.Join(marks, ", ")))

	_, err := orm.NewOrm().Raw(sqlStr, uint32(time.Now().Unix()), ids).Exec()

	return err
}

// 删除
func (m *SearchLog) Delete(forceDelete ...bool) error {
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

// 获取搜索日记列表
func (m *SearchLog) GetAll(size, offset int, args map[string]string) ([]*SearchLog, int64) {
	list := make([]*SearchLog, 0)
	qs := m.query()
	qs = qs.Filter("deleted_at", 0)

	if st, ok := args["st"]; ok && len(st) > 0 {
		qs = qs.Filter("created_at__gte", st)
	}

	if et, ok := args["et"]; ok && len(et) > 0 {
		qs = qs.Filter("created_at__lte", et)
	}

	if q, ok := args["q"]; ok && len(q) > 0 {
		qs = qs.Filter("kw__contains", q)
	}

	var count int64 = 0
	isCount := false
	if c, ok := args["count"]; ok && len(c) > 0 {
		isCount = true
		count, _ = qs.Count()
	}

	if count > 0 || isCount == false {
		qs.OrderBy("-id").Limit(size, offset).All(&list, "id", "kw", "uid", "source", "ip", "is_result", "created_at")
	}

	return list, count
}

// 获取是否推荐
func (m SearchLog) IsResultName() string {
	if m.IsResult == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">否</span>`
	}

	return `<span class="layui-btn layui-btn-xs">是</span>`
}

// 获取是否推荐
func (m SearchLog) SourceName() string {
	if m.Source == 0 {
		return `<span class="layui-btn layui-btn-warm layui-btn-xs">PC站点</span>`
	}

	return `<span class="layui-btn layui-btn-normal layui-btn-xs">手机站</span>`
}
