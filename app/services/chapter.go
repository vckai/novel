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

package services

import (
	"errors"
	"math"
	"time"

	"github.com/astaxie/beego/validation"

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/utils/log"
)

type Chapter struct{}

func NewChapter() *Chapter {
	return &Chapter{}
}

// 获取单个章节内容
func (this *Chapter) Get(id uint64, novId uint32) *models.Chapter {
	if id < 1 {
		return nil
	}

	m := models.NewChapter()
	m.NovId = novId
	m.Id = id

	err := m.Read()
	if err != nil {
		return nil
	}

	return m
}

// 获取第一章节
func (this *Chapter) GetFirst(novId uint32) *models.Chapter {
	if novId < 1 {
		return nil
	}

	m := models.NewChapter()
	m.NovId = novId

	err := m.GetFirst()
	if err != nil {
		return nil
	}

	return m
}

// 获取小说上一章节
func (this *Chapter) GetPre(novId, chapNo uint32) *models.Chapter {
	if novId < 0 || chapNo < 1 {
		return nil
	}

	m := models.NewChapter()
	m.NovId = novId
	m.ChapterNo = chapNo

	err := m.GetByChapNo("pre")
	if err != nil {
		return nil
	}

	return m
}

// 获取小说下一章节
func (this *Chapter) GetNext(novId, chapNo uint32) *models.Chapter {
	if novId < 1 || chapNo < 1 {
		return nil
	}

	m := models.NewChapter()
	m.NovId = novId
	m.ChapterNo = chapNo

	err := m.GetByChapNo("next")
	if err != nil {
		return nil
	}

	return m
}

// 获取小说最新章节
func (this *Chapter) GetLast(novId uint32) *models.Chapter {
	m := models.NewChapter()

	if novId < 1 {
		return m
	}

	m.NovId = novId

	err := m.GetLast()
	if err != nil {
		return m
	}

	return m
}

// 获取小说章节列表
func (this *Chapter) GetNovChaps(novId uint32, size, offset int, sort string, isCount bool) ([]*models.Chapter, int64) {
	if novId < 1 {
		return nil, 0
	}

	m := models.NewChapter()
	m.NovId = novId

	// 获取小说章节列表
	chaps := m.GetNovChaps(size, offset, sort)

	// 获取小说章节数
	var count int64 = 0
	if isCount {
		count = m.Count()
	}

	return chaps, count
}

// 删除操作章节
func (this *Chapter) Delete(id uint64, novId uint32) error {
	if id < 1 || novId < 1 {
		return errors.New("params error")
	}

	m := models.NewChapter()
	m.NovId = novId
	m.Id = id

	return m.Delete()
}

// 删除指定小说章节
func (this *Chapter) DelByNovId(novId uint32) error {
	if novId < 0 {
		return errors.New("params error")
	}

	m := models.NewChapter()
	m.NovId = novId

	return m.DelByNovId()
}

// 添加编辑小说章节内容
func (this *Chapter) Save(chapter *models.Chapter) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(chapter.Title, "titleEmpty").Message("章节名称不能为空")
	valid.MaxSize(chapter.Title, 100, "nameMax").Message("章节名称长度不能超过100个字符")
	valid.Required(chapter.NovId, "novidEmpty").Message("所属小说不能为空")
	valid.Required(chapter.Desc, "descEmpty").Message("章节内容不能为空")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	var err error
	if chapter.Id > 0 {
		err = chapter.Update("nov_id", "title", "desc")
	} else {
		err = chapter.Insert()
	}

	return err
}

// 批量插入多个章节内容
func (this *Chapter) InsertMulti(chapters []*models.Chapter, isInit bool) error {

	// 非小说初始化情况，通过单条插入的方式，判断章节是否重复
	if isInit == false {
		for _, chap := range chapters {
			err := chap.Insert()
			if err != nil {
				log.Error("插入章节错误：", chap.Title, "，小说ID：", chap.NovId, "，错误：", err)
				continue
			}
		}

		return nil
	}

	max := 200
	chapLen := len(chapters)
	for i := 0; i < chapLen; i += max {
		index := int(math.Min(float64(i+max), float64(chapLen)))

		err := models.ChapterModel.InsertMulti(chapters[i:index])
		if err != nil {
			return err
		}

		time.Sleep(time.Duration(10) * time.Microsecond)
	}

	return nil
}
