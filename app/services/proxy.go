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
	"io/ioutil"
	"math/rand"
	"time"

	"github.com/astaxie/beego"
	"github.com/tidwall/gjson"

	"github.com/vckai/novel/app/utils"
	"github.com/vckai/novel/app/utils/log"
)

const (
	// 代理IP获取间隔时间，单位：分钟
	PROXY_IP_UP_TIME = 12
)

// 代理模式
const (
	NO_PROXY int = iota
	HTTP_PROXY
	IP_AUTO_PROXY
)

// 定义CrawlerService
type Proxy struct {
	ips  []string
	mode int
}

func NewProxy() *Proxy {
	p := &Proxy{}
	p.Init()
	return p
}

// 运行入口
func (this *Proxy) Init() {

	go func() {
		for {
			// 代理配置模式
			this.mode = ConfigService.Int("proxy_mode", NO_PROXY)
			if this.mode == IP_AUTO_PROXY {
				this.run()
			}
			// 休眠12分钟更新一次
			time.Sleep(PROXY_IP_UP_TIME * time.Minute)
		}
	}()
}

// 获取代理IP池
func (this *Proxy) run() {
	resp, err := utils.HttpGet(ConfigService.String("proxy_url", ""), nil, "")
	if err != nil {
		log.Error("Request Proxy URL Error: ", err)
		return
	}

	body, err := ioutil.ReadAll(resp)
	if err != nil {
		log.Error("Get Proxy Body Error: ", err)
		return
	}

	this.ips = []string{}

	data := gjson.ParseBytes(body)
	data.ForEach(func(key, value gjson.Result) bool {
		this.ips = append(this.ips, value.Get("ip").String())
		return true
	})

	log.Info("获取到代理IP:", len(this.ips))
}

// 随机获取一个代理IP
func (this *Proxy) Get() string {
	proxy := ""

	switch this.mode {
	case NO_PROXY:

	case HTTP_PROXY:
		proxy = beego.AppConfig.String("proxy_url")
	default:
		r := rand.New(rand.NewSource(time.Now().UnixNano()))
		x := len(this.ips)

		if x > 0 {
			proxy = "http://" + this.ips[r.Intn(x)]
		}
	}

	return proxy
}
