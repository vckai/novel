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

// 小说采集来源列表内容
type NovelLinks struct {
	Id          uint32 `orm:"auto"`
	NovId       uint32 `orm:"size(11)"`
	Link        string `orm:"size(100)"`
	Source      string `orm:"size(30);"`
	ChapterLink string `orm:"size(100);"`
	CreatedAt   uint32 `orm:"size(11);default(0);"`
	UpdatedAt   uint32 `orm:"size(11);default(0);"`
	DeletedAt   uint32 `orm:"size(11);default(0)"`
}

func NewNovelLinks() *NovelLinks {
	return &NovelLinks{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(NovelLinks))
}

func (m *NovelLinks) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *NovelLinks) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 删除
func (m *NovelLinks) Delete(forceDelete ...bool) error {
	// 软删除
	if len(forceDelete) == 0 {
		m.DeletedAt = uint32(time.Now().Unix())
		_, err := orm.NewOrm().Update(m, "deleted_at")
		return err
	}

	// 强制删除
	if _, err := orm.NewOrm().Delete(m); err != nil {
		return err
	}
	return nil
}

// 判断小说是否存在
func (m *NovelLinks) GetByLink(link, source string) *NovelLinks {
	var n NovelLinks
	if len(link) == 0 || len(source) == 0 {
		return NewNovelLinks()
	}

	m.query().Filter("link", link).Filter("source", source).One(&n, "id")

	return &n
}

// 获取小说采集点列表
func (m *NovelLinks) GetAll(size, offset int, args map[string]interface{}, fields ...string) ([]*NovelLinks, int64) {
	list := make([]*NovelLinks, 0)

	qs := m.optionHandle(args)

	// 统计
	var count int64 = 0
	isCount := false
	if c, ok := args["count"]; ok && c.(bool) == true {
		isCount = true
		count, _ = qs.Count()
	}

	// 排序
	orderBy := "-id"
	if c, ok := args["orderBy"]; ok && len(c.(string)) > 0 {
		orderBy = c.(string)
	}

	if count > 0 || isCount == false {
		if len(fields) == 0 {
			fields = []string{"id", "nov_id", "link", "source", "chapter_link", "created_at"}
		}
		qs.OrderBy(orderBy).Limit(size, offset).All(&list, fields...)
	}

	return list, count
}

// 条件生成
func (m *NovelLinks) optionHandle(args map[string]interface{}) orm.QuerySeter {
	qs := m.query()
	qs = qs.Filter("deleted_at", 0)

	// 小说ID
	if novId, ok := args["nov_id"]; ok && novId.(uint32) > 0 {
		qs = qs.Filter("nov_id__exact", novId.(uint32))
	}

	// 采集URL
	if link, ok := args["link"]; ok && len(link.(string)) > 0 {
		qs = qs.Filter("link__exact", link.(string))
	}
	// 来源站点
	if source, ok := args["source"]; ok && len(source.(string)) > 0 {
		qs = qs.Filter("source__exact", source.(string))
	}

	return qs
}
