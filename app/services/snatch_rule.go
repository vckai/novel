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

// 定义SnatchRuleService
type SnatchRule struct {
	rules map[string]*models.SnatchRule
}

func NewSnatchRule() *SnatchRule {
	c := &SnatchRule{rules: make(map[string]*models.SnatchRule)}
	c.Init()

	return c
}

func (this *SnatchRule) Init() {
	this.Load()
}

func (this *SnatchRule) Load() {
	rs := models.SnatchRuleModel.GetAll(&models.ArgsListRule{})

	this.rules = make(map[string]*models.SnatchRule)
	for _, r := range rs {
		if r.State != 1 {
			continue
		}

		r.Decode()

		this.rules[r.Code] = r
	}
}

// 获取单个采集配置
func (this *SnatchRule) Get(id uint32) *models.SnatchRule {
	if id < 0 {
		return nil
	}

	r := &models.SnatchRule{Id: id}
	err := r.Read()
	if err != nil {
		return nil
	}

	return r
}

// 获取单个采集配置
func (this *SnatchRule) GetByCode(code string) *models.SnatchRule {
	if r, ok := this.rules[code]; ok {
		return r
	}

	return nil
}

// 获取可用采集器列表
func (this *SnatchRule) GetSnatchs() map[string]*models.SnatchRule {
	return this.rules
}

// 获取采集规则列表
func (this *SnatchRule) GetAll(args *models.ArgsListRule) []*models.SnatchRule {
	rs := models.SnatchRuleModel.GetAll(args)

	return rs
}

// 批量删除采集规则
func (this *SnatchRule) DeleteBatch(ids []string) error {
	if len(ids) == 0 {
		return errors.New("params error")
	}

	err := models.SnatchRuleModel.DeleteBatch(ids)

	if err == nil {
		this.Load()
	}

	return err
}

// 删除采集规则
func (this *SnatchRule) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	r := models.SnatchRule{Id: id}
	err := r.Delete(true)
	if err != nil {
		return err
	}

	this.Load()

	return nil
}

// 启用/禁用
func (this *SnatchRule) UpState(id uint32, state uint8) error {
	m := &models.SnatchRule{Id: id, State: state}

	err := m.Update("state")

	if err == nil {
		this.Load()
	}

	return err
}

// 添加/修改
func (this *SnatchRule) Save(sr *models.SnatchRule) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(sr.Name, "nameEmpty").Message("网站名称不能为空")
	valid.MaxSize(sr.Name, 50, "nameMax").Message("网站名称长度不能超过50个字符")
	valid.Required(sr.Code, "codeEmpty").Message("网站唯一标识码不能为空")
	valid.MaxSize(sr.Code, 20, "nameMax").Message("网站唯一标识码不能超过20个字符")
	valid.Required(sr.Charset, "charsetEmpty").Message("网站编码不能为空")
	valid.Required(sr.Url, "urlEmpty").Message("网站网址不能为空")
	//valid.Required(sr.Rules, "ruleEmpty").Message("页面采集规则不能为空")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	// 判断是否已经存在
	s := models.SnatchRuleModel.GetByCode(sr.Code)
	if s != nil && s.Id > 0 {
		if sr.Id > 0 && sr.Id != s.Id {
			return errors.New("该code已经存在，不能重复添加")
		} else if sr.Id == 0 {
			return errors.New("该code已经存在，不能重复添加")
		}
	}

	var err error
	if sr.Id > 0 {
		err = sr.Update("name", "code", "charset", "cate_map", "url", "rule", "test_data")
	} else {
		err = sr.Insert()
	}

	if err == nil {
		this.Load()
	}

	return err
}
