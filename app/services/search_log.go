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

// 定义SearchLogService
type SearchLog struct {
}

func NewSearchLog() *SearchLog {
	return &SearchLog{}
}

// 获取搜索日记列表
func (this *SearchLog) GetAll(args models.ArgsSearchLogList) ([]*models.SearchLog, int64) {
	return models.SearchLogModel.GetAll(args)
}

// 批量删除搜索日记
func (this *SearchLog) DeleteBatch(ids []string) error {
	if len(ids) == 0 {
		return errors.New("params error")
	}

	return models.SearchLogModel.DeleteBatch(ids)
}

// 删除操作日记
func (this *SearchLog) Delete(id uint64) error {
	if id < 0 {
		return errors.New("params error")
	}

	log := models.SearchLog{Id: id}
	err := log.Delete()
	if err != nil {
		return err
	}

	return nil
}

// 添加搜索日记
func (this *SearchLog) Add(a *models.SearchLog) error {
	err := a.Insert()

	return err
}
