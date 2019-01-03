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
	"fmt"
	"io"
	"net/url"
	"strings"
	"sync"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/axgle/mahonia"

	"github.com/vckai/novel/app/librarys/snatchs"
	"github.com/vckai/novel/app/utils"
	"github.com/vckai/novel/app/utils/log"
)

const (
	CRAWLER_WAIT uint8 = iota
	CRAWLER_RUNING
)

// 定义CrawlerService
type Crawler struct {
	initURL  *url.URL
	provider *snatchs.Provide

	linkChans chan string

	// 采集URL列表
	URLs map[string]bool

	// 小说简介URL列表
	bookURLs map[string]bool

	// 运行状态
	runStatus uint8
}

func NewCrawler() *Crawler {
	return &Crawler{
		runStatus: CRAWLER_WAIT,
		URLs:      map[string]bool{},
		bookURLs:  map[string]bool{},
	}
}

// 爬虫初始化
func (this *Crawler) Init(provideName string) (*Crawler, error) {
	if this.runStatus != CRAWLER_WAIT {
		log.Warn("爬虫任务正在运行中..")
		return this, errors.New("task running..")
	}

	var err error

	this.provider, err = snatchs.NewManager(provideName)
	if err != nil {
		return this, err
	}

	// 解析URL
	this.initURL, err = url.Parse(this.provider.Client.GetURL())
	if err != nil {
		return this, err
	}

	// 小说URL channels
	this.linkChans = make(chan string, 5000)

	this.bookURLs = map[string]bool{}
	this.URLs = map[string]bool{}

	return this, nil
}

// 爬虫入口
func (this *Crawler) Run() {
	if this.runStatus != CRAWLER_WAIT {
		log.Warn("爬虫任务正在运行中..")
		return
	}

	log.Info("开始运行爬虫，站点：", this.provider.Name)
	go this.run()
}

// 真正的运行逻辑
func (this *Crawler) run() {
	this.runStatus = CRAWLER_RUNING

	var wg sync.WaitGroup

	// 小说采集入库
	for i := 0; i < 5; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for {
				link, ok := <-this.linkChans
				if !ok {
					return
				}

				this.snatchBook(link)

				// 休眠1ms，防止采集速度过快被屏蔽
				time.Sleep(time.Duration(1) * time.Millisecond)
			}
		}()
	}

	// 爬虫执行爬取URL地址
	go func() {
		t1 := time.Now()
		this.runCrawler(this.initURL.String(), "")
		log.Info("URL爬虫，采集URL:", len(this.URLs), "，采集小说URL:", len(this.bookURLs), "，耗时:", time.Since(t1))

		close(this.linkChans)
	}()

	t1 := time.Now()
	wg.Wait()

	log.Info("采集done，采集URL:", len(this.URLs), "，采集小说URL:", len(this.bookURLs), "，耗时:", time.Since(t1))

	// 清理运行内容
	this.bookURLs = map[string]bool{}
	this.URLs = map[string]bool{}
	this.runStatus = CRAWLER_WAIT
}

// 爬虫真正运行处理
func (this *Crawler) runCrawler(rawurl string, oldURL string) {
	// 已经采集过
	if _, ok := this.URLs[rawurl]; ok {
		return
	}

	// 内容采集
	proxy := ProxyService.Get()
	doc, err := this.NewHtml(rawurl, proxy, "utf-8")
	if err != nil {
		log.Warn("采集URL失败：", rawurl, proxy, err, oldURL)
		return
	}

	this.URLs[rawurl] = true

	// 获取小说URL地址
	doc.Find("a").Each(func(i int, s *goquery.Selection) {
		uri, _ := s.Attr("href")
		link := this.genrateURL(rawurl, uri)
		if len(link) == 0 {
			return
		}

		// 是否小说简介页面
		if this.provider.Client.IsBookURL(link) {
			// 小说已经采集过
			if _, ok := this.bookURLs[link]; ok {
				return
			}

			this.bookURLs[link] = true

			// 写入channel
			this.linkChans <- link

			return
		}

		// 是否可采集的爬虫URL
		if !this.provider.Client.IsCrawlerURL(link) {
			return
		}

		// URL已经爬过
		if _, ok := this.URLs[link]; ok {
			return
		}

		// 休眠1ms，防止采集速度过快被屏蔽
		time.Sleep(time.Duration(1) * time.Millisecond)

		// 递归爬虫URL
		this.runCrawler(link, rawurl)
	})

	return
}

// 执行小说采集
func (this *Crawler) SnatchBookFor() {
	// 采集小说
	for i := 1; i <= 69749; i++ {
		link := fmt.Sprintf("http://www.x23us.com/book/%d", i)
		err := SnatchService.InitNovel(link)

		if err != nil {
			log.Warn("小说采集失败：", link, err)
		}
	}
}

// 执行小说采集
func (this *Crawler) snatchBook(link string) {
	// 采集小说
	err := SnatchService.InitNovel(link)

	if err != nil {
		log.Warn("小说采集失败：", link, err)
		return
	}
}

// 生成返回完整的URL地址
func (this *Crawler) genrateURL(currURL, rawurl string) string {
	// 当前域名下的URL
	// 防止部分https的情况进行转换
	rawHost := strings.Replace(rawurl, "https://", "", -1)
	rawHost = strings.Replace(rawHost, "http://", "", -1)
	initHost := strings.Replace(this.initURL.String(), "https://", "", -1)
	initHost = strings.Replace(initHost, "http://", "", -1)
	if strings.HasPrefix(rawHost, initHost) {
		return rawurl
	}

	// 非当前域名下的URL直接返回空
	if strings.HasPrefix(rawurl, "http://") ||
		strings.Contains(rawurl, "https://") ||
		strings.Contains(rawurl, "javascript:") ||
		strings.Contains(rawurl, "(") ||
		strings.Contains(rawurl, "mailto") {
		return ""
	}

	// 拼装URL
	if strings.HasPrefix(rawurl, "/") {
		return this.initURL.String() + rawurl
	}

	return currURL + rawurl
}

// 网页请求
// 返回goquery格式内容
func (this *Crawler) NewHtml(rawurl, proxyURL string, args ...string) (*goquery.Document, error) {
	var body io.Reader
	var err error

	body, err = utils.HttpGet(rawurl, nil, proxyURL)

	if err != nil {
		return nil, err
	}

	if len(args) == 0 || args[0] != "utf-8" {
		enc := mahonia.NewDecoder("GB18030")
		body = enc.NewReader(body)
	}
	doc, err := goquery.NewDocumentFromReader(body)
	if err != nil {
		return nil, err
	}

	return doc, nil
}
