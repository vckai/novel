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

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

const (
	TABLE_CHAPTER_SLICE_NUM uint32 = 100
)

// 小说章节内容
type Chapter struct {
	Id        uint64 `orm:"auto"`
	NovId     uint32 `orm:"size(11)"`
	ChapterNo uint32 `orm:"size(11)"`
	Title     string `orm:"size(100)"`
	Desc      string `orm:"type(text)"`
	Link      string `orm:"size(100)"`
	Source    string `orm:"size(10)"`
	Views     uint32 `orm:"size(11);default(0);"`
	TextNum   uint32 `orm:"size(11);default(0);"`
	Status    uint8  `orm:"size(1);default(0);"`
	TryViews  uint8  `orm:"size(2);default(0);"`
	CreatedAt uint32 `orm:"size(11);default(0);"`
	UpdatedAt uint32 `orm:"size(11);default(0);"`
	DeletedAt uint32 `orm:"size(11);default(0)"`
}

func NewChapter() *Chapter {
	return &Chapter{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(Chapter))
}

func (m *Chapter) newOrm() orm.Ormer {
	// 读取章节数据库配置
	drivername := beego.AppConfig.String("mysql_chapter::drivername")

	o := orm.NewOrm()
	o.Using(drivername)

	return o
}

func (m *Chapter) query() orm.QuerySeter {
	return m.newOrm().QueryTable(m)
}

// 获取分表表名
func (m *Chapter) getTable() string {
	if m.NovId < 1 {
		return ""
	}

	return fmt.Sprintf("nov_chapter_%04d", m.NovId%TABLE_CHAPTER_SLICE_NUM)
}

// 添加
func (m *Chapter) Insert() error {
	// 判断章节是否已存在
	m.GetByTitle()

	if m.Id > 0 {
		return nil
	}

	// 插入章节
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())

	sqlStr := fmt.Sprintf("INSERT INTO %s SET nov_id=?, chapter_no=?, title=?, `desc`=?, link=?, source=?, views=?, text_num=?, status=?, created_at=?, updated_at=?", m.getTable())

	_, err := m.newOrm().Raw(sqlStr, m.NovId, m.ChapterNo, m.Title, m.Desc, m.Link, m.Source, m.Views, m.TextNum, m.Status, m.CreatedAt, m.UpdatedAt).Exec()

	return err
}

// 批量添加
func (m *Chapter) InsertMulti(chapters []*Chapter) error {
	// 开启事物
	o := m.newOrm()
	err := o.Begin()
	if err != nil {
		return err
	}

	for _, v := range chapters {
		v.CreatedAt = uint32(time.Now().Unix())
		v.UpdatedAt = uint32(time.Now().Unix())

		sqlStr := fmt.Sprintf("INSERT INTO %s SET nov_id=?, chapter_no=?, title=?, `desc`=?, link=?, source=?, views=?, text_num=?, status=?, created_at=?, updated_at=?", v.getTable())
		_, err := o.Raw(sqlStr, v.NovId, v.ChapterNo, v.Title, v.Desc, v.Link, v.Source, v.Views, v.TextNum, v.Status, v.CreatedAt, v.UpdatedAt).Exec()
		if err != nil {
			o.Rollback()
			return err
		}
	}

	// 提交事物
	return o.Commit()
}

// 读取
func (m *Chapter) Read() error {
	err := m.newOrm().Raw(fmt.Sprintf("SELECT * FROM %s WHERE id=?", m.getTable()), m.Id).QueryRow(m)

	return err
}

// 根据小说ID和标题读取
func (m *Chapter) GetByTitle() error {
	err := m.newOrm().Raw(fmt.Sprintf("SELECT * FROM %s WHERE nov_id=? AND title=?", m.getTable()), m.NovId, m.Title).QueryRow(m)

	return err
}

// 修改章节信息
func (m *Chapter) Update(fields ...string) error {
	m.UpdatedAt = uint32(time.Now().Unix())

	sqlStr := fmt.Sprintf("UPDATE %s SET chapter_no=?, title=?, `desc`=?, updated_at=? WHERE id = ?", m.getTable())

	_, err := m.newOrm().Raw(sqlStr, m.ChapterNo, m.Title, m.Desc, m.UpdatedAt, m.Id).Exec()

	return err
}

// 修改章节浏览次数累加
func (m *Chapter) UpdateViews(fields ...string) error {
	m.UpdatedAt = uint32(time.Now().Unix())

	sqlStr := fmt.Sprintf("UPDATE %s SET `views`=`views`+1, updated_at=? WHERE id = ?", m.getTable())

	_, err := m.newOrm().Raw(sqlStr, m.UpdatedAt, m.Id).Exec()

	return err
}

// 修改空章节信息
func (m *Chapter) UpdateEmpty(fields ...string) error {
	m.UpdatedAt = uint32(time.Now().Unix())

	sqlStr := fmt.Sprintf("UPDATE %s SET `desc`=?, `status`=?, `try_views`=?, `text_num`=?, updated_at=? WHERE id = ?", m.getTable())

	_, err := m.newOrm().Raw(sqlStr, m.Desc, m.Status, m.TryViews, m.TextNum, m.UpdatedAt, m.Id).Exec()

	return err
}

// 批量删除
func (m *Chapter) DeleteBatch(ids []string) error {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}
	sqlStr := fmt.Sprintf("DELETE FROM %s WHERE `id` %s", m.getTable(), fmt.Sprintf("IN (%s)", strings.Join(marks, ", ")))

	_, err := m.newOrm().Raw(sqlStr, ids).Exec()

	return err
}

// 删除
func (m *Chapter) Delete() error {
	_, err := m.newOrm().Raw(fmt.Sprintf("DELETE FROM %s WHERE id=?", m.getTable()), m.Id).Exec()

	return err
}

// 删除指定小说所有章节
func (m *Chapter) DelByNovId() error {
	_, err := m.newOrm().Raw(fmt.Sprintf("DELETE FROM %s WHERE nov_id=?", m.getTable()), m.NovId).Exec()

	return err
}

// 获取小说空章节列表
func (m *Chapter) GetEmptyChaps() []*Chapter {
	list := make([]*Chapter, 0)

	m.newOrm().Raw(fmt.Sprintf("SELECT id, nov_id, chapter_no, title, source, link, try_views FROM %s WHERE nov_id=? AND status = 1", m.getTable()), m.NovId).QueryRows(&list)

	return list
}

// 获取多个章节字数统计
func (m *Chapter) GetChapsTextNum(ids []string) int64 {
	marks := make([]string, len(ids))
	for i := range marks {
		marks[i] = "?"
	}

	var total int64

	m.newOrm().Raw(fmt.Sprintf("SELECT sum(text_num) FROM %s WHERE id IN (%s)", m.getTable(), strings.Join(marks, ", "))).QueryRow(&total)

	return total
}

// 获取小说章节列表
func (m *Chapter) GetNovChaps(size, offset int, sort string) []*Chapter {
	list := make([]*Chapter, 0)

	m.newOrm().Raw(fmt.Sprintf("SELECT id, nov_id, title, views, status, try_views, chapter_no, created_at FROM %s WHERE nov_id=? ORDER BY chapter_no %s LIMIT ? OFFSET ?", m.getTable(), sort), m.NovId, size, offset).QueryRows(&list)

	return list
}

// 获取小说章节统计
func (m *Chapter) Count() int64 {
	var total int64

	m.newOrm().Raw(fmt.Sprintf("SELECT count(1) FROM %s WHERE nov_id=?", m.getTable()), m.NovId).QueryRow(&total)

	return total
}

// 获取小说第一章节
func (m *Chapter) GetFirst() error {
	err := m.newOrm().Raw(fmt.Sprintf("SELECT id, title, link, chapter_no FROM %s WHERE nov_id=? ORDER BY chapter_no ASC", m.getTable()), m.NovId).QueryRow(m)

	return err
}

// 获取小说最新章节
func (m *Chapter) GetLast() error {
	err := m.newOrm().Raw(fmt.Sprintf("SELECT id, title, link, chapter_no FROM %s WHERE nov_id=? ORDER BY chapter_no DESC", m.getTable()), m.NovId).QueryRow(m)

	return err

}

// 获取小说上下章节
func (m *Chapter) GetByChapNo(asc string) error {
	lt := "<"
	sort := "DESC"

	if asc == "next" {
		sort = "ASC"
		lt = ">"
	}

	err := m.newOrm().Raw(fmt.Sprintf("SELECT id, title, link, chapter_no FROM %s WHERE nov_id=? AND chapter_no %s ? ORDER BY chapter_no %s", m.getTable(), lt, sort), m.NovId, m.ChapterNo).QueryRow(m)

	return err
}

// 获取是否推荐
func (m Chapter) StatusName() string {
	if m.Status == 1 {
		return `<span class="layui-btn layui-btn-primary layui-btn-xs">采集失败</span>`
	}
	return `<span class="layui-btn layui-btn-xs">采集成功</span>`
}
