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

// 小说内容
type Novel struct {
	Id               uint32 `orm:"auto"`
	Name             string `orm:"size(100)"`
	Desc             string `orm:"size(2555)"`
	Cover            string `orm:"size(100);"`
	CateId           uint32 `orm:"size(11);default(0);"`
	CateName         string `orm:"size(30);"`
	Author           string `orm:"size(30);"`
	IsHot            uint8  `orm:"size(1);default(0);"`
	IsRec            uint8  `orm:"size(1);default(0);"`
	IsTodayRec       uint8  `orm:"size(1);default(0);"`
	IsVipRec         uint8  `orm:"size(1);default(0);"`
	IsManLike        uint8  `orm:"size(1);default(0);"`
	IsGirlLike       uint8  `orm:"size(1);default(0);"`
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
	orm.RegisterModelWithPrefix("nov_", new(Novel))
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

// 批量删除
func (m *Novel) DeleteBatch(ids []string) error {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}
	sqlStr := fmt.Sprintf("DELETE FROM nov_novel WHERE `id` %s", fmt.Sprintf("IN (%s)", strings.Join(marks, ", ")))

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
func (m *Novel) GetAll(size, offset int, args map[string]interface{}, fields ...string) ([]*Novel, int64) {
	list := make([]*Novel, 0)

	qs := m.optionHandle(args)

	// 统计
	var count int64 = 0
	c := false
	if c, ok := args["count"]; ok && c.(bool) == true {
		c = true
		count, _ = qs.Count()
	}

	// 排序
	orderBy := "-id"
	if c, ok := args["orderBy"]; ok && len(c.(string)) > 0 {
		orderBy = c.(string)
	}

	if count > 0 || c == false {
		if len(fields) == 0 {
			fields = []string{"id", "name", "author", "cate_id", "cate_name", "status", "is_hot", "is_rec", "is_vip_rec", "chapter_updated_at", "chapter_num"}
		}
		qs.OrderBy(orderBy).Limit(size, offset).All(&list, fields...)
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

// 获取是否热门
func (m Novel) IsHotName() string {
	if m.IsHot == 0 {
		return `<span class="layui-btn layui-btn-disabled layui-btn-mini">否</span>`
	}

	return `<span class="layui-btn layui-btn-normal layui-btn-mini">是</span>`
}

// 获取是否推荐
func (m Novel) IsRecName() string {
	if m.IsRec == 0 {
		return `<span class="layui-btn layui-btn-disabled layui-btn-mini">否</span>`
	}

	return `<span class="layui-btn layui-btn-normal layui-btn-mini">是</span>`
}

// 获取是否精品
func (m Novel) IsVipRecName() string {
	if m.IsVipRec == 0 {
		return `<span class="layui-btn layui-btn-disabled layui-btn-mini">否</span>`
	}

	return `<span class="layui-btn layui-btn-normal layui-btn-mini">是</span>`
}

// 条件生成
func (m *Novel) optionHandle(args map[string]interface{}) orm.QuerySeter {
	qs := m.query()
	qs = qs.Filter("deleted_at", 0)

	// 名称搜索
	if q, ok := args["q"]; ok && len(q.(string)) > 0 {
		qs = qs.Filter("name__contains", q.(string))
	}

	argsFilters := []string{"status", "is_hot", "is_rec", "is_vip_rec", "is_today_rec", "cate_id", "is_man_like", "is_girl_like"}
	for _, v := range argsFilters {
		if c, ok := args[v]; ok && c.(int) > 0 {
			qs = qs.Filter(v, c.(int))
		}
	}

	// 字数过滤
	if st, ok := args["start_text_num"]; ok && st.(int) > 0 {
		qs = qs.Filter("text_num__gt", st.(int))
	}
	// 字数过滤
	if et, ok := args["end_text_num"]; ok && et.(int) > 0 {
		qs = qs.Filter("text_num__lte", et.(int))
	}

	// 章节更新时间过滤
	if m, ok := args["max_chapter_at"]; ok && m.(int64) > 0 {
		qs = qs.Filter("chapter_updated_at__gt", m.(int64))
	}

	return qs
}
