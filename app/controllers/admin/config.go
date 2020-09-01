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
	"novel/app/services"
)

type ConfigController struct {
	BaseController
}

// 配置页面
func (this *ConfigController) Index() {
	tab := this.GetString("tab", "")

	this.Data["Tab"] = tab

	// 获取配置
	this.Data["Config"] = services.ConfigService.GetAll()

	this.View("config/index.tpl")
}

// 保存数据
func (this *ConfigController) Save() {
	configs := this.Input()

	for key, val := range configs {
		services.ConfigService.Set(key, val[0])
	}

	this.OutJson(0, "修改成功")
}
