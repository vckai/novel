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

const (
	// 小说状态
	BOOKOPEN uint8 = iota + 1
	BOOKFINISH
	BOOKEUNUCHS
)

type ArgsNovelList struct {
	ArgsBase
	StartTextNum        int
	EndTextNum          int
	MaxChapterUpdatedAt int64
	FilterMaps          map[string]int
}

// 小说内容
type Novel struct {
	Id               uint32 `orm:"auto"`
	Name             string `orm:"size(100)"`
	Desc             string `orm:"size(2555)"`
	Cover            string `orm:"size(100);"`
	CateId           uint32 `orm:"size(11);default(0);"`
	CateName         string `orm:"size(30);"`
	Author           string `orm:"size(30);"`
	IsOriginal       uint8  `orm:"size(1);default(0);"`
	IsHot            uint8  `orm:"size(1);default(0);"`
	IsRec            uint8  `orm:"size(1);default(0);"`
	IsTodayRec       uint8  `orm:"size(1);default(0);"`
	IsVipRec         uint8  `orm:"size(1);default(0);"`
	IsVipReward      uint8  `orm:"size(1);default(0);"`
	IsVipUp          uint8  `orm:"size(1);default(0);"`
	IsSignNewBook    uint8  `orm:"size(1);default(0);"`
	IsCollect        uint8  `orm:"size(1);default(0);"`
	Status           uint8  `orm:"size(11);default(0);"`
	Views            uint32 `orm:"size(11);default(0);"`
	CollectNum       uint32 `orm:"size(11);default(0)"`
	RecNum           uint32 `orm:"size(11);default(0)"`
	TextNum          uint32 `orm:"size(11);default(0)"`
	ChapterNum       uint32 `orm:"size(6);default(0)"`
	ChapterUpdatedAt uint32 `orm:"size(11);default(0);"`
	ChapterId        uint64 `orm:"size(20);default(0);"`
	ChapterTitle     string `orm:"size(100);"`
	CreatedAt        uint32 `orm:"size(11);default(0);"`
	UpdatedAt        uint32 `orm:"size(11);default(0);"`
	DeletedAt        uint32 `orm:"size(11);default(0)"`
}

func NewNovel() *Novel {
	return &Novel{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix(TABLE_PREFIX, new(Novel))
}

func (m *Novel) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *Novel) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 读取
func (m *Novel) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}

// 修改
func (m *Novel) Update(fields ...string) error {
	m.UpdatedAt = uint32(time.Now().Unix())
	if len(fields) > 0 {
		fields = append(fields, "updated_at")
	}

	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}

	return nil
}

// 批量更新推荐
func (m *Novel) UpRecBatch(field string, books []string) error {
	marks := make([]string, len(books))
	for i := range marks {
		marks[i] = "?"
	}

	// 取消之前推荐
	sqlStr := fmt.Sprintf("UPDATE %snovel SET %s=0, updated_at=? WHERE `%s`=1", TABLE_PREFIX, field, field)
	orm.NewOrm().Raw(sqlStr, time.Now().Unix()).Exec()

	// 更新新书推荐
	sqlStr = fmt.Sprintf("UPDATE %snovel SET %s=1, updated_at=? WHERE `name` IN(%s)", TABLE_PREFIX, field, strings.Join(marks, ", "))
	_, err := orm.NewOrm().Raw(sqlStr, time.Now().Unix(), books).Exec()

	return err
}

// 批量删除
func (m *Novel) DeleteBatch(ids []string) error {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}
	sqlStr := fmt.Sprintf("DELETE FROM %snovel WHERE `id` IN(%s)", TABLE_PREFIX, strings.Join(marks, ", "))

	_, err := orm.NewOrm().Raw(sqlStr, ids).Exec()

	return err
}

// 删除
func (m *Novel) Delete(forceDelete ...bool) error {
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

// 判断小说是否存在
func (m *Novel) GetByName(name string) *Novel {
	var n Novel

	if len(name) == 0 {
		return &Novel{}
	}

	m.query().Filter("name", name).One(&n, "id", "author", "cover", "desc", "created_at")

	return &n
}

// 获取小说列表
func (m *Novel) GetAll(args ArgsNovelList) ([]*Novel, int64) {
	list := make([]*Novel, 0)

	qs := m.optionHandle(args)

	// 统计
	var count int64 = 0
	if args.Count {
		count, _ = qs.Count()
	}

	// 排序
	orderBy := "-id"
	if args.OrderBy != "" {
		orderBy = args.OrderBy
	}

	// 获取字段
	fields := []string{"id", "name", "author", "cate_id", "cate_name", "status", "is_original", "is_hot", "is_rec", "is_vip_rec", "chapter_updated_at", "chapter_num"}
	if len(args.Fields) == 0 {
		fields = args.Fields
	}

	// 分页
	if args.Limit > 0 {
		qs = qs.Limit(args.Limit, args.Offset)
	}

	if count > 0 || args.Count == false {
		qs.OrderBy(orderBy).All(&list, fields...)
	}

	return list, count
}

func (m Novel) StatusList() map[uint8]string {
	return map[uint8]string{
		BOOKOPEN:    "连载中",
		BOOKFINISH:  "完结",
		BOOKEUNUCHS: "太监",
	}
}

// 获取状态
func (m Novel) StatusName() string {
	status := m.StatusList()

	if text, ok := status[m.Status]; ok {
		return text
	}

	return "未开始"
}

// 获取是否原创小说
func (m Novel) IsOriginalName() string {
	if m.IsOriginal == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">否</span>`
	}

	return `<span class="layui-btn layui-btn-xs">是</span>`
}

// 获取是否热门
func (m Novel) IsHotName() string {
	if m.IsHot == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">否</span>`
	}

	return `<span class="layui-btn layui-btn-xs">是</span>`
}

// 获取是否推荐
func (m Novel) IsRecName() string {
	if m.IsRec == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">否</span>`
	}

	return `<span class="layui-btn layui-btn-xs">是</span>`
}

// 获取是否精品
func (m Novel) IsVipRecName() string {
	if m.IsVipRec == 0 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">否</span>`
	}

	return `<span class="layui-btn layui-btn-xs">是</span>`
}

// 条件生成
func (m *Novel) optionHandle(args ArgsNovelList) orm.QuerySeter {
	qs := m.query()
	qs = qs.Filter("deleted_at", 0)

	// 名称搜索
	if args.Keyword != "" {
		qs = qs.Filter("name__contains", args.Keyword)
	}

	argsFilters := []string{"status", "is_original", "is_hot", "is_rec", "is_vip_rec", "is_today_rec", "cate_id", "is_sign_new_book", "is_collect", "is_vip_up", "is_vip_reward"}
	for _, v := range argsFilters {
		if c, ok := args.FilterMaps[v]; ok && c > 0 {
			qs = qs.Filter(v, c)
		}
	}

	// 字数过滤
	if args.StartTextNum > 0 {
		qs = qs.Filter("text_num__gt", args.StartTextNum)
	}
	// 字数过滤
	if args.EndTextNum > 0 {
		qs = qs.Filter("text_num__lte", args.EndTextNum)
	}

	// 章节更新时间过滤
	if args.MaxChapterUpdatedAt > 0 {
		qs = qs.Filter("chapter_updated_at__gt", args.MaxChapterUpdatedAt)
	}

	return qs
}
