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

// 搜索记录管理模型
type Search struct {
	Id        uint64 `orm:"auto"`
	Kw        string `orm:"size(100);unique"`
	Views     uint64 `orm:"size(21)"`
	IsRec     uint8  `orm:"size(1)"`
	CreatedAt uint32 `orm:"size(11)"`
	UpdatedAt uint32 `orm:"size(11)"`
}

func NewSearch() *Search {
	return &Search{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(Search))
}

func (m *Search) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 修改
func (m *Search) Update(fields ...string) error {
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
func (m *Search) Delete() error {
	if _, err := orm.NewOrm().Delete(m); err != nil {
		return err
	}
	return nil
}

// 批量删除
func (m *Search) DeleteBatch(ids []string) error {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}
	sqlStr := fmt.Sprintf("DELETE FROM nov_search WHERE `id` IN(%s)", strings.Join(marks, ", "))

	_, err := orm.NewOrm().Raw(sqlStr, ids).Exec()

	return err
}

// 更新搜索记录、不存在新增，存在更新搜索次数
func (m *Search) InsertOrIncrement(kw string) error {
	sqlStr := "INSERT INTO nov_search SET kw=?, views=1, is_rec=0, created_at=?, updated_at=? ON DUPLICATE KEY UPDATE `views` = `views` + 1, updated_at=?"

	t := uint32(time.Now().Unix())
	_, err := orm.NewOrm().Raw(sqlStr, kw, t, t, t).Exec()

	return err
}

// 获取搜索记录列表
func (m *Search) GetAll(size, offset int, args map[string]string) ([]*Search, int64) {
	list := make([]*Search, 0)
	qs := m.query()

	if q, ok := args["q"]; ok && len(q) > 0 {
		qs = qs.Filter("kw__contains", q)
	}

	// 是否推荐
	if isRec, ok := args["is_rec"]; ok {
		qs = qs.Filter("is_rec", isRec)
	}

	var count int64 = 0
	isCount := false
	if c, ok := args["count"]; ok && len(c) > 0 {
		isCount = true
		count, _ = qs.Count()
	}

	if count > 0 || isCount == false {
		qs.Limit(size, offset).All(&list, "id", "kw", "views", "is_rec", "created_at")
	}

	return list, count
}

// 获取是否推荐
func (m Search) IsRecName() string {
	if m.IsRec == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs btn-set-rec">未推荐</span>`
	}

	return `<span class="layui-btn layui-btn-xs btn-set-un-rec">已推荐</span>`
}
