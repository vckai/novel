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

	"github.com/astaxie/beego/validation"

	"novel/app/models"
)

// 定义CateService
type Cate struct {
}

func NewCate() *Cate {
	return &Cate{}
}

// 获取单个分类信息
func (this *Cate) Get(id uint32) *models.Cate {
	if id < 0 {
		return nil
	}

	cate := &models.Cate{Id: id}
	err := cate.Read()
	if err != nil {
		return nil
	}

	return cate
}

// 批量获取小说分类列表
func (this *Cate) GetAll() []*models.Cate {
	cates := models.CateModel.GetAll()

	return cates
}

// 批量删除小说分类
func (this *Cate) DeleteBatch(ids []string) error {
	if len(ids) == 0 {
		return errors.New("params error")
	}

	return models.CateModel.DeleteBatch(ids)
}

// 删除小说分类
func (this *Cate) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	cate := models.Cate{Id: id}
	err := cate.Delete(true)
	if err != nil {
		return err
	}

	return nil
}

// 添加/修改
func (this *Cate) Save(cate *models.Cate) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(cate.Name, "nameEmpty").Message("分类名称不能为空")
	valid.MaxSize(cate.Name, 20, "nameMax").Message("分类名称长度不能超过20个字符")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	var err error
	if cate.Id > 0 {
		err = cate.Update("name", "is_home", "is_menu")
	} else {
		err = cate.Insert()
	}

	return err
}
