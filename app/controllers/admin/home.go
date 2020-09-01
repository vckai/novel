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
	"net"
	"os"
	"runtime"
	"strconv"
	"strings"
	"time"

	"github.com/astaxie/beego"
	"github.com/shirou/gopsutil/mem"

	"novel/app/services"
)

type HomeController struct {
	BaseController
}

// 欢迎页面
func (this *HomeController) Index() {

	this.Data["Version"] = runtime.Version()
	this.Data["Goos"] = runtime.GOOS
	this.Data["Cpus"] = runtime.NumCPU()
	this.Data["Port"] = beego.AppConfig.String("httpport")
	this.Data["AppName"] = beego.AppConfig.String("appname")
	this.Data["NowTime"] = time.Now().Format("2006-05-04 15:02:01")
	this.Data["SessionID"] = this.Ctx.Input.CruSession.SessionID()

	// 登录信息
	this.Data["LoginVisit"] = this.GetSession("login_visit")
	this.Data["LastLoginIp"] = this.GetSession("last_login_ip")
	this.Data["LastLoginedAt"] = uint32(0)

	loginedAt := this.GetSession("last_logined_at")
	if loginedAt != nil {
		this.Data["LastLoginedAt"] = loginedAt
	}

	// 获取服务器内存信息
	m, _ := mem.VirtualMemory()
	this.Data["Memory"] = m.Total / 1000 / 1000 / 8

	// 获取服务器IP地址
	addrs, err := net.InterfaceAddrs()
	if err != nil {
		beego.Error("获取IP地址错误", err)
	} else {

		for _, address := range addrs {
			// 检查ip地址判断是否回环地址
			if ipnet, ok := address.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
				if ipnet.IP.To4() != nil {
					this.Data["Ip"] = ipnet.IP.String()
				}

			}
		}
	}

	this.View("home/index.tpl")
}

// 图片上传处理
func (this *HomeController) UpImg() {
	_, fileHeader, err := this.GetFile("upimg")
	if err != nil {
		this.OutJson(1001, "图片上传失败："+err.Error())
	}

	oriName := strings.ToLower(fileHeader.Filename)

	newName := strconv.FormatInt(time.Now().UnixNano(), 10) + oriName[strings.LastIndex(oriName, "."):]
	upPreDir := beego.AppConfig.String("static::uppredir")
	uploadDir := beego.AppConfig.String("static::updir") + time.Now().Format("2006/01/02") + "/"
	err = os.MkdirAll(upPreDir+uploadDir, 0777) //创建目录
	if err != nil {
		this.OutJson(1002, "创建目录失败："+err.Error())
	}

	err = this.SaveToFile("upimg", upPreDir+uploadDir+newName)
	if err != nil {
		this.OutJson(1003, "保存文件出错："+err.Error())
	}

	this.OutJson(0, "", map[string]interface{}{
		"url":   services.ConfigService.String("ViewURL", "/public/") + uploadDir + newName,
		"title": newName,
	})
}
