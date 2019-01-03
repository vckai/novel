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

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/utils"
)

// 定义AdminLogService
type AdminLog struct {
}

func NewAdminLog() *AdminLog {
	return &AdminLog{}
}

// 获取单个管理员信息
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

// 批量获取管理员列表
func (this *AdminLog) GetAll(size, offset int, args map[string]interface{}) ([]*models.AdminLog, int64) {
	qs := map[string]string{}

	if st, ok := args["st"]; ok && len(st.(string)) > 0 {
		t := utils.GetDateParse(st.(string))
		qs["st"] = utils.ToStr(t)
	}

	if et, ok := args["et"]; ok && len(et.(string)) > 0 {
		t := utils.GetDateParse(et.(string))
		// 结束时间+1天，时间戳转换为次日凌晨
		t += 60 * 60 * 24
		qs["et"] = utils.ToStr(t)
	}

	if q, ok := args["q"]; ok && len(q.(string)) > 0 {
		qs["q"] = q.(string)
	}

	if c, ok := args["count"]; ok && c.(bool) == true {
		qs["count"] = "1"
	}

	AdminLogs, count := models.AdminLogModel.GetAll(size, offset, qs)

	return AdminLogs, count
}

// 删除操作日记
func (this *AdminLog) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	log := models.AdminLog{Id: id}
	err := log.Delete(true)
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
