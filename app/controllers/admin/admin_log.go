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

package admin

import (
	"math"
	"time"

	"github.com/vckai/novel/app/services"
	"github.com/vckai/novel/app/utils"
)

type AdminLogController struct {
	BaseController
}

// 管理操作日记列表
func (this *AdminLogController) Index() {

	st := this.GetString("st")
	if len(st) == 0 {
		st = utils.GetDate(uint32(time.Now().AddDate(0, -1, 0).Unix()))

	}
	et := this.GetString("et")
	if len(et) == 0 {
		et = utils.GetDate(uint32(time.Now().Unix()))
	}
	q := this.GetString("q")
	size := 10
	p, _ := this.GetInt("p")
	offset := (p - 1) * size
	search := map[string]interface{}{
		"p":     p,
		"st":    st,
		"et":    et,
		"q":     q,
		"count": true,
	}
	logs, count := services.AdminLogService.GetAll(size, offset, search)

	this.Data["Search"] = search
	this.Data["Logs"] = logs
	this.Data["LogCount"] = count
	this.Data["MaxPages"] = math.Ceil(float64(count) / float64(size))
	this.View("admin_log/index.tpl")
}

// 删除操作日记
func (this *AdminLogController) Delete() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	err := services.AdminLogService.Delete(id)
	if err != nil {
		this.OutJson(1002, "删除操作日记失败")
	}

	this.OutJson(0, "已删除！")
}

// 批量删除操作日记
func (this *AdminLogController) DeleteBatch() {
	ids := this.GetStrings("ids[]")
	if len(ids) == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	err := services.AdminLogService.DeleteBatch(ids)
	if err != nil {
		this.OutJson(1002, "批量删除操作日记失败")
	}

	this.OutJson(0, "已删除！")
}
