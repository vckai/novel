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

package controllers

import (
	"strings"

	"github.com/astaxie/beego"
	"github.com/beego/i18n"

	"novel/app/services"
	"novel/app/utils"
)

// 控制器基类
type BaseController struct {
	beego.Controller
	i18n.Locale

	Module string
}

// 初始化操作
func (this *BaseController) Prepare() {
	defLang := beego.AppConfig.String("lang::default")
	this.Lang = defLang
}

// 模板封装处理
/**
 * @api POST /user/:id get user
 */
func (this *BaseController) View(tpl string) {
	// 系统参数
	aOut := make(map[string]interface{})
	aOut["WebURL"] = services.ConfigService.String("WebURL")
	aOut["ViewUrl"] = services.ConfigService.String("ViewURL")
	aOut["Title"] = services.ConfigService.String("Title")
	aOut["SubTitle"] = services.ConfigService.String("SubTitle")
	aOut["Keyword"] = services.ConfigService.String("Keyword")
	aOut["Description"] = services.ConfigService.String("Description")
	aOut["Icp"] = services.ConfigService.String("Icp")
	aOut["Copyright"] = services.ConfigService.String("Copyright")
	aOut["StatisticsCode"] = services.ConfigService.String("StatisticsCode", "")
	aOut["Logo"] = services.ConfigService.String("Logo")
	aOut["Favicon"] = services.ConfigService.String("Favicon")
	aOut["Version"] = beego.AppConfig.String("version")

	// 获取控制器名称和方法名称
	controllerName, actionName := this.GetControllerAndAction()
	aOut["Controller"] = controllerName[0 : len(controllerName)-10]
	aOut["Action"] = actionName
	aOut["MethodName"] = controllerName + "." + actionName

	this.Data["aOut"] = aOut

	// 设置语言
	this.Data["Lang"] = this.Lang

	this.TplName = this.Module + "/" + tpl
}

// 设置分页
func (this *BaseController) SetPaginator(per int, nums int64) *utils.Paginator {
	p := utils.NewPaginator(this.Ctx.Request, per, nums)
	this.Data["Paginator"] = p
	return p
}

type JSONResponse struct {
	Ret   interface{} `json:"ret"`
	Msg   interface{} `json:"msg"`
	Data  interface{} `json:"data"`
	URL   interface{} `json:"url"`
	IsTop interface{} `json:"is_top"`
}

// json数据输出
func (this *BaseController) OutJson(args ...interface{}) {
	json := &JSONResponse{
		Ret:   0,
		Msg:   "",
		URL:   "",
		IsTop: false,
	}

	json.Ret = args[0]
	if len(args) > 1 {
		json.Msg = args[1]
	}
	if len(args) > 2 {
		json.Data = args[2]
	}

	if len(args) > 3 {
		json.URL = args[3]
	}
	// 是否顶部跳转
	if len(args) > 4 {
		json.IsTop = args[4]
	}

	this.Data["json"] = json
	this.ServeJSON()
	this.StopRun()
}

// 提示信息
func (this *BaseController) Msg(msg string, args ...interface{}) {
	url := ""
	if len(args) > 0 {
		url = args[0].(string)
	}

	isTop := false
	if len(args) > 1 {
		isTop = args[1].(bool)
	}

	// ajax 返回json
	if this.IsAjax() {
		this.OutJson(1001, msg, url, isTop)
	}

	this.Data["Url"] = url
	this.Data["Msg"] = msg
	this.Data["Wait"] = 2
	this.Data["IsTop"] = isTop
	this.Data["Title"] = services.ConfigService.String("Title")
	this.Layout = ""
	this.TplName = "message.tpl"
	this.Render()
	this.StopRun()
}

// 去除URLFor生成的URL前缀
func URLFor(endpoint string, values ...interface{}) string {
	url := beego.URLFor(endpoint, values...)

	if mURL := services.ConfigService.String("MobileURL"); mURL != "" {
		url = strings.Replace(url, "/m/", "/", 1)
	}

	if adminURL := services.ConfigService.String("AdminURL"); adminURL != "" {
		url = strings.Replace(url, "/admin/", "/", 1)
	}

	return url
}
