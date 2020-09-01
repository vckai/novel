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
	"bytes"
	"context"
	"io"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/axgle/mahonia"

	xhttp "novel/app/librarys/net/http"
	"novel/app/utils/log"
)

type SnatchRank struct{}

func NewSnatchRank() *SnatchRank {
	return &SnatchRank{}
}

// 运行
func (this *SnatchRank) Run() {
	this.Qidian()
}

// 采集起点排行榜
func (this *SnatchRank) Qidian() {
	baseurl := "https://www.qidian.com/rank"

	// 获取今日推荐
	books, err := this.getBooks(baseurl + "/hotsales?style=1")
	if err != nil {
		log.Error("起点更新今日推荐小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_today_rec", books)
	}

	// 获取vip推荐
	books, err = this.getBooks(baseurl + "/recom?style=1")
	if err != nil {
		log.Error("起点更新vip推荐更新小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_vip_rec", books)
	}

	// 获取推荐
	books, err = this.getBooks(baseurl + "/recom?style=1&page=2")
	if err != nil {
		log.Error("起点更新推荐小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_rec", books)
	}

	// 获取收藏
	books, err = this.getBooks(baseurl + "/collect?style=1")
	if err != nil {
		log.Error("起点更新收藏小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_hot", books)
	}

	// 获取vip收藏
	books, err = this.getBooks(baseurl + "/vipcollect?style=1")
	if err != nil {
		log.Error("起点更新vip收藏小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_collect", books)
	}

	// 获取新人签约书
	books, err = this.getBooks(baseurl + "/signnewbook?style=1")
	if err != nil {
		log.Error("起点更新新人签约小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_sign_new_book", books)
	}

	// 获取vip打赏
	books, err = this.getBooks(baseurl + "/vipreward?style=1")
	if err != nil {
		log.Error("起点更新vip打赏小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_vip_reward", books)
	}

	// 获取vip更新
	books, err = this.getBooks(baseurl + "/vipup?style=1")
	if err != nil {
		log.Error("起点更新vip更新小说失败：", err)
	} else {
		NovelService.UpRecBatch("is_vip_up", books)
	}
}

func (this *SnatchRank) getBooks(rawurl string) ([]string, error) {
	books := []string{}

	doc, err := this.NewHtml(rawurl, "UTF-8")
	if err != nil {
		return books, err
	}

	// 获取小说名称
	doc.Find("#rank-view-list > div > ul > li").Each(func(i int, s *goquery.Selection) {
		books = append(books, s.Find("div.book-mid-info > h4 > a").Text())
	})

	return books, nil
}

// 网页请求
// 返回goquery格式内容
func (this *SnatchRank) NewHtml(rawurl, charset string) (*goquery.Document, error) {
	var res []byte
	var body io.Reader
	var err error

	c := xhttp.NewClient(
		&xhttp.ClientConfig{
			Timeout:   10 * time.Second,
			Dial:      10 * time.Second,
			KeepAlive: 60 * time.Second,
			ProxyURL:  ProxyService.Get(),
		})

	res, _, err = c.Get(context.TODO(), rawurl, nil)
	if err != nil {
		return nil, err
	}

	body = bytes.NewReader(res)

	// 编码格式转码
	enc := mahonia.NewDecoder(charset)
	body = enc.NewReader(body)

	doc, err := goquery.NewDocumentFromReader(body)
	if err != nil {
		return nil, err
	}

	return doc, nil
}
