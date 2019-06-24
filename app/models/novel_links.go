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

type ArgsNovelLinksList struct {
	ArgsBase
	NovId  uint32
	Link   string
	Source string
}

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
	orm.RegisterModelWithPrefix(TABLE_PREFIX, new(NovelLinks))
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

// 删除指定小说所有采集点
func (m *NovelLinks) DelByNovId(novId uint32) error {
	_, err := orm.NewOrm().Raw(fmt.Sprintf("DELETE FROM %snovel_links WHERE nov_id=?", TABLE_PREFIX), novId).Exec()

	return err
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
func (m *NovelLinks) GetAll(args ArgsNovelLinksList) ([]*NovelLinks, int64) {
	list := make([]*NovelLinks, 0)

	qs := m.optionHandle(args)

	// 统计
	var count int64 = 0
	if args.Count {
		count, _ = qs.Count()
	}

	// 分页
	if args.Limit > 0 {
		qs = qs.Limit(args.Limit, args.Offset)
	}

	// 排序
	orderBy := "-id"
	if args.OrderBy != "" {
		orderBy = args.OrderBy
	}

	// 查询字段
	fields := []string{"id", "nov_id", "link", "source", "chapter_link", "created_at"}
	if len(args.Fields) == 0 {
		fields = args.Fields
	}

	if count > 0 || args.Count == false {
		qs.OrderBy(orderBy).All(&list, fields...)
	}

	return list, count
}

// 条件生成
func (m *NovelLinks) optionHandle(args ArgsNovelLinksList) orm.QuerySeter {
	qs := m.query()
	qs = qs.Filter("deleted_at", 0)

	// 小说ID
	if args.NovId > 0 {
		qs = qs.Filter("nov_id__exact", args.NovId)
	}

	// 采集URL
	if args.Link != "" {
		qs = qs.Filter("link__exact", args.Link)
	}

	// 来源站点
	if args.Source != "" {
		qs = qs.Filter("source__exact", args.Source)
	}

	return qs
}
