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
	"context"
	"fmt"
	"math/rand"
	"sync"
	"time"

	"github.com/parnurzeal/gorequest"
	"github.com/tidwall/gjson"

	xhttp "novel/app/librarys/net/http"
	"novel/app/utils/log"
)

// 代理模式
const (
	NO_PROXY int = iota
	HTTP_PROXY
	IP_AUTO_PROXY

	STATE_WAIT int = iota
	STATE_RUNING
)

// 定义CrawlerService
type Proxy struct {
	sync.RWMutex

	ips         []string
	state       int
	lastGetTime time.Time
}

func NewProxy() *Proxy {
	p := &Proxy{
		ips:         []string{},
		state:       STATE_WAIT,
		lastGetTime: time.Now(),
	}
	p.Init()
	return p
}

// 运行入口
func (this *Proxy) Init() {
	go func() {
		for {
			this.run()

			// 休眠指定时间更新
			upTime := ConfigService.Int("ProxyUpTime", 10)
			time.Sleep(time.Duration(upTime) * time.Minute)
		}
	}()

	// 定时IP可用性检测
	go func() {
		for {
			// 休眠
			checkTime := ConfigService.Int("ProxyCheckTime", 10000)
			time.Sleep(time.Duration(checkTime) * time.Millisecond)

			this.check()
		}
	}()
}

// 获取代理IP池
func (this *Proxy) run() {
	mode := ConfigService.Int("ProxyMode", NO_PROXY)
	if mode != IP_AUTO_PROXY {
		return
	}

	if this.state == STATE_RUNING {
		return
	}

	// 最后获取时间超过一分钟则不自动更新
	if time.Since(this.lastGetTime) > time.Duration(1)*time.Minute {
		return
	}

	this.state = STATE_RUNING

	c := xhttp.NewClient(
		&xhttp.ClientConfig{
			Timeout:   10 * time.Second,
			Dial:      500 * time.Millisecond,
			KeepAlive: 60 * time.Second,
		})

	body, _, err := c.Get(context.TODO(), ConfigService.String("ProxyURL"), nil)
	if err != nil {
		this.state = STATE_WAIT
		log.Error("获取代理IP列表错误： ", err)
		return
	}

	this.Lock()

	data := gjson.ParseBytes(body)
	data.Get("data").ForEach(func(key, value gjson.Result) bool {
		ip := value.Get("ip").String()
		port := value.Get("port").String()
		if len(ip) == 0 || len(port) == 0 {
			return true
		}

		host := fmt.Sprintf("%s:%s", ip, port)
		this.ips = append(this.ips, host)
		return true
	})

	this.Unlock()

	log.Info("获取到代理IP:", this.Count())
	this.state = STATE_WAIT
}

// 获取可用IP数量
func (this *Proxy) Count() int {
	this.RLock()
	defer this.RUnlock()

	return len(this.ips)
}

// 获取所有IP
func (this *Proxy) GetAll() []string {
	this.RLock()
	defer this.RUnlock()

	return this.ips
}

// 随机获取一个代理IP
func (this *Proxy) get() string {
	this.RLock()
	defer this.RUnlock()

	ips := this.ips
	x := len(ips)

	if x == 0 {
		return ""
	}

	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	proxy := "http://" + ips[r.Intn(x)]

	return proxy
}

// 删除IP
func (this *Proxy) Del(ip string) error {
	this.Lock()
	defer this.Unlock()

	ips := this.ips
	for k, v := range ips {
		if v == ip {
			this.ips = append(this.ips[:k], this.ips[k+1:]...)
		}
	}

	return nil
}

// 随机获取一个代理IP
func (this *Proxy) Get() string {
	this.lastGetTime = time.Now()
	proxy := ""

	mode := ConfigService.Int("ProxyMode", NO_PROXY)
	switch mode {
	case NO_PROXY:

	case HTTP_PROXY:
		proxy = ConfigService.String("ProxyURL")
	default:
		proxy = this.get()
	}

	return proxy
}

// IP可用性管理
func (this *Proxy) check() {
	mode := ConfigService.Int("ProxyMode", NO_PROXY)
	if mode != IP_AUTO_PROXY {
		return
	}

	ox := this.Count()
	if ox == 0 {
		return
	}

	ips := make([]string, this.Count())
	copy(ips, this.GetAll())

	for _, v := range ips {
		if !this.checkIP(v) {
			this.Del(v)
		}
	}

	x := this.Count()
	log.Debug(fmt.Sprintf("Before check, has: %d records, After check, has: %d records.", ox, x))

	if x == 0 {
		this.run()
	}
}

// IP可用性校验
func (this *Proxy) checkIP(ip string) bool {
	testIP := "http://" + ip
	pollURL := "http://httpbin.org/get"

	resp, _, err := gorequest.New().Timeout(time.Duration(10) * time.Second).Proxy(testIP).Get(pollURL).End()
	if err != nil {
		log.Debug(fmt.Sprintf("[CheckIP] testIP = %s, pollURL = %s: Error = %v", testIP, pollURL, err))
		return false
	}

	defer resp.Body.Close()
	if resp.StatusCode == 200 {
		return true
	}

	return false
}
