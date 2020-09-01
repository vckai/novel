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

// 定义SearchService
type Search struct {
}

func NewSerach() *Search {
	return &Search{}
}

// 获取推荐的搜索关键字
func (this *Search) GetRes(size int) []*models.Search {
	args := models.ArgsSearchList{}
	args.IsRec = 1
	args.Limit = size

	list, _ := models.SearchModel.GetAll(args)

	return list
}

// 获取搜索记录列表
func (this *Search) GetAll(args models.ArgsSearchList) ([]*models.Search, int64) {
	return models.SearchModel.GetAll(args)
}

// 设置推荐/取消推荐
func (this *Search) UpRec(id uint64, isRec uint8) error {
	m := &models.Search{Id: id, IsRec: isRec}

	return m.Update("is_rec")
}

// 添加搜索记录
func (this *Search) InsertOrIncrement(kw string, log *models.SearchLog) error {
	if len(kw) == 0 {
		return errors.New("params error")
	}

	err := models.SearchModel.InsertOrIncrement(kw)

	// 添加搜索日记
	SearchLogService.Add(log)

	return err
}

// 删除搜索记录
func (this *Search) Delete(id uint64) error {
	if id < 0 {
		return errors.New("params error")
	}

	s := models.Search{Id: id}
	err := s.Delete()
	if err != nil {
		return err
	}

	return nil
}

// 批量删除搜索记录
func (this *Search) DeleteBatch(ids []string) error {
	if len(ids) == 0 {
		return errors.New("params error")
	}

	return models.SearchModel.DeleteBatch(ids)
}
