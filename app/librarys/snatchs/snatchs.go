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

package snatchs

import (
	"errors"
	"fmt"
	"io"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/axgle/mahonia"

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/utils"
)

const (
	// 小说状态
	BOOKOPEN = iota + 1
	BOOKFINISH
	BOOKEUNUCHS

	// 请求失败重试次数
	RETRY = 3

	// 默认分类ID
	DEF_CATE_ID = 13
)

var (
	ErrNotNov       = errors.New("获取小说失败")
	ErrNotUrl       = errors.New("没有传入URL地址")
	ErrNotNovName   = errors.New("获取小说书名失败")
	ErrNotNovLink   = errors.New("获取小说链接失败")
	ErrNotNovAuthor = errors.New("获取小说作者失败")
	ErrNotChapTitle = errors.New("获取小说章节标题失败")
)

var provides = make(map[string]*Provide)

type Provide struct {
	Title  string
	Name   string
	Client Snatchs
}

// 采集内容信息
type SnatchInfo struct {
	UseTime    time.Duration
	Title      string
	Nov        *models.Novel
	Chap       *models.Chapter
	Url        string
	Source     string
	ChapterUrl string
	NextUrl    string
	PreUrl     string
	IsUpdate   bool
}

type Snatchs interface {
	// 获取单本小说基本信息
	GetNovel(url string) (*SnatchInfo, error)

	// 搜索小说
	FindNovel(keyword string) (*SnatchInfo, error)

	// 获取单章节内容
	GetChapter(rawurl string) (*SnatchInfo, error)

	// 获取章节列表
	GetChapters(rawurl string) ([]*SnatchInfo, error)

	// 获取网站URL地址
	GetURL() string

	// 判断是否小说简介页面
	IsBookURL(rawurl string) bool

	// 判断是否爬虫页面
	IsCrawlerURL(rawurl string) bool

	// 设置代理
	Proxy(rawurl string)
}

func Register(name string, provide *Provide) {
	if _, dup := provides[name]; dup {
		panic("snatchs: Register called twice for provider " + name)
	}

	provide.Name = name

	provides[name] = provide
}

// 采集管理器
func NewManager(provideName string) (*Provide, error) {
	provider, ok := provides[provideName]
	if !ok {
		return nil, fmt.Errorf("snatch: unknown provide %q (forgotten import?)", provideName)
	}

	return provider, nil
}

// 获取采集器列表
func GetSnatchs() map[string]*Provide {
	return provides
}

// 网页请求
func NewHtml(rawurl, proxyURL string, args ...string) (*goquery.Document, error) {
	var body io.Reader
	var err error

	// 失败重试
	for i := 0; i < RETRY; i++ {
		body, err = utils.HttpGet(rawurl, nil, proxyURL)
		if err == nil {
			break
		}

		// 休眠10ms，防止采集速度过快被屏蔽
		time.Sleep(time.Duration(10) * time.Microsecond)
	}

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
