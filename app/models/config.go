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
	"errors"
	"time"

	"github.com/astaxie/beego/orm"
)

// 配置模型
type Config struct {
	Id        uint32 `orm:"auto;size(11)"`
	Key       string `orm:"size(50)"`
	Value     string `orm:"size(255)"`
	CreatedAt uint32 `orm:"size(11)"`
	UpdatedAt uint32 `orm:"size(11)"`
}

func NewConfig() *Config {
	return &Config{}
}

// 初始化
// 注册模型
func init() {
	orm.RegisterModelWithPrefix("nov_", new(Config))
}

func (m *Config) query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}

// 添加
func (m *Config) Insert() error {
	m.CreatedAt = uint32(time.Now().Unix())
	m.UpdatedAt = uint32(time.Now().Unix())
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}

// 读取
func (m *Config) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}

// 修改
func (m *Config) Update(key, value string) error {
	if key == "" {
		return errors.New("error params")
	}
	m.UpdatedAt = uint32(time.Now().Unix())

	if _, err := m.query().Filter("key", key).Update(orm.Params{
		"value": value,
	}); err != nil {
		return err
	}
	return nil
}

// 删除
func (m *Config) Delete() error {
	// 强制删除
	if _, err := orm.NewOrm().Delete(m); err != nil {
		return err
	}
	return nil
}

// 获取配置列表
func (m *Config) GetAll() []*Config {
	list := make([]*Config, 0)
	m.query().All(&list, "id", "key", "value")

	return list
}
