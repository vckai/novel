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

	"novel/app/models"
)

// 定义AdminLogService
type AdminLog struct {
}

func NewAdminLog() *AdminLog {
	return &AdminLog{}
}

// 获取单个操作日记信息
func (this *AdminLog) Get(id uint32) *models.AdminLog {
	if id < 0 {
		return nil
	}

	AdminLog := &models.AdminLog{Id: id}
	err := AdminLog.Read()
	if err != nil {
		return nil
	}

	return AdminLog
}

// 批量获取操作日记列表
func (this *AdminLog) GetAll(args models.ArgsAdminLog) ([]*models.AdminLog, int64) {
	return models.AdminLogModel.GetAll(args)
}

// 批量删除操作日记
func (this *AdminLog) DeleteBatch(ids []string) error {
	if len(ids) == 0 {
		return errors.New("params error")
	}

	return models.AdminLogModel.DeleteBatch(ids)
}

// 删除操作日记
func (this *AdminLog) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	log := models.AdminLog{Id: id}
	err := log.Delete()
	if err != nil {
		return err
	}

	return nil
}

// 添加操作日记
func (this *AdminLog) Add(a *models.AdminLog) error {
	if a.Uid == 0 {
		return errors.New("缺少操作对象")
	}

	err := a.Insert()

	return err
}
