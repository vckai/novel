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
	"io"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
	"github.com/axgle/mahonia"

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/utils"
)

const (
	// 默认分类
	DEF_CATE_ID = 13

	// 请求失败重试次数
	RETRY = 5
)

var (
	ErrNotProvider  = errors.New("没有获取到采集点")
	ErrNotRule      = errors.New("没有采集规则")
	ErrNotNov       = errors.New("获取小说失败")
	ErrNotUrl       = errors.New("没有传入URL地址")
	ErrNotNovName   = errors.New("获取小说书名失败")
	ErrNotNovLink   = errors.New("获取小说链接失败")
	ErrNotNovAuthor = errors.New("获取小说作者失败")
	ErrNotChapTitle = errors.New("获取小说章节标题失败")
	ErrNotFindUrl   = errors.New("没有搜索页URL地址")
)

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
}

type Snatch struct {
	proxyFunc func() string
}

func NewSnatch(proxyFunc func() string) *Snatch {
	return &Snatch{
		proxyFunc: proxyFunc,
	}
}

// 是否小说简介页面
func (this *Snatch) IsBookURL(provider *models.SnatchRule, rawurl string) bool {
	if provider == nil {
		return false
	}

	rule := provider.Rules

	if rule == nil {
		return false
	}

	re, _ := regexp.Compile("(?U)" + rule.IsBookURL)
	s := re.FindString(rawurl)

	if len(s) == 0 {
		return false
	}

	return true
}

// 是否小说是否爬虫页面
func (this *Snatch) IsCrawlerURL(provider *models.SnatchRule, rawurl string) bool {
	if provider == nil {
		return false
	}

	rule := provider.Rules

	if rule == nil {
		return false
	}

	re, _ := regexp.Compile("(?U)" + rule.IsCrawlerURL)
	s := re.FindString(rawurl)

	if len(s) == 0 {
		return false
	}

	return true
}

// 查找小说
func (this *Snatch) FindNovel(provider *models.SnatchRule, kw string) (*SnatchInfo, error) {
	if provider == nil {
		return nil, ErrNotProvider
	}

	rule := provider.Rules

	if rule == nil {
		return nil, ErrNotRule
	}

	// 转换为gbk编码
	if provider.Charset == "GB18030" {
		enc := mahonia.NewEncoder(provider.Charset)
		kw = enc.ConvertString(kw)
	}

	if len(rule.FindURL) == 0 {
		return nil, ErrNotFindUrl
	}

	kw = url.QueryEscape(kw)

	// 解析URL
	u, err := url.Parse(rule.FindURL + kw)
	if err != nil {
		return nil, err
	}

	// 请求搜索页面
	doc, resp, err := this.newHtml(u.String(), provider.Charset)
	if err != nil && resp == nil && len(resp.Header.Get("Location")) == 0 {
		return nil, err
	}

	// 查找直接定向到小说简介页面
	novURL := resp.Header.Get("Location")
	if len(novURL) == 0 || !this.IsBookURL(provider, novURL) {
		// 获取小说介绍页面URL
		novURL, _ = doc.Find(rule.FindBookURLSelector).Attr("href")
	}

	if len(novURL) == 0 || !this.IsBookURL(provider, novURL) {
		return nil, ErrNotNovLink
	}

	novURL, err = this.genrateURL(u, novURL)
	if err != nil {
		return nil, err
	}

	return this.GetNovel(provider, novURL)
}

// 获取一本小说
func (this *Snatch) GetNovel(provider *models.SnatchRule, rawurl string) (*SnatchInfo, error) {
	if provider == nil {
		return nil, ErrNotProvider
	}

	rule := provider.Rules

	if rule == nil {
		return nil, ErrNotRule
	}

	t1 := time.Now()

	// 解析URL
	u, err := url.Parse(rawurl)
	if err != nil {
		return nil, err
	}

	// 请求采集
	doc, _, err := this.newHtml(rawurl, provider.Charset)
	if err != nil {
		return nil, err
	}

	nov := models.NewNovel()

	// 获取封面图片
	if img, ok := doc.Find(rule.BookCoverSelector).Attr("src"); ok {
		nov.Cover = img

		if !strings.Contains(nov.Cover, "http://") && len(nov.Cover) > 0 {
			nov.Cover, _ = this.genrateURL(u, nov.Cover)
		}
	}

	// 默认封面图片直接重置空
	if strings.Contains(nov.Cover, rule.BookNoCover) {
		nov.Cover = ""
	}

	// 获取小说类别
	nov.CateName = strings.TrimSpace(doc.Find(rule.BookCateSelector).Text())

	// 获取小说类别ID
	nov.CateId = DEF_CATE_ID
	for _, v := range provider.CateMaps {
		if v.Name == nov.CateName {
			nov.CateId = v.Id
			break
		}
	}

	// 获取小说标题
	nov.Name = doc.Find(rule.BookTitleSelector).Text()
	nov.Name = strings.TrimRight(nov.Name, " 全文阅读")
	nov.Name = strings.Replace(nov.Name, "&nbsp;", "", -1)
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = doc.Find(rule.BookAuthorSelector).Text()
	nov.Author = strings.Replace(nov.Author, "&nbsp;", "", -1)
	nov.Author = strings.TrimSpace(nov.Author)
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}

	// 获取小说简介
	nov.Desc, _ = doc.Find(rule.BookDescSelector).Html()

	// 获取章节链接地址
	chapterLink, _ := doc.Find(rule.BookChapterURLSelector).Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	// 生成完整链接地址
	chapterLink, _ = this.genrateURL(u, chapterLink)

	return &SnatchInfo{
		ChapterUrl: chapterLink,
		Title:      provider.Name,
		Source:     provider.Code,
		Url:        rawurl,
		UseTime:    time.Since(t1),
		Nov:        nov,
	}, nil
}

// 获取小说章节内容
func (this *Snatch) GetChapter(provider *models.SnatchRule, rawurl string) (*SnatchInfo, error) {
	if provider == nil {
		return nil, ErrNotProvider
	}

	rule := provider.Rules

	if rule == nil {
		return nil, ErrNotRule
	}

	t1 := time.Now()

	// 解析URL
	u, err := url.Parse(rawurl)
	if err != nil {
		return nil, err
	}

	// 请求小说详情页面
	doc, _, err := this.newHtml(rawurl, provider.Charset)
	if err != nil {
		return nil, err
	}

	chap := models.NewChapter()
	chap.Link = rawurl

	// 获取章节标题
	chap.Title = doc.Find(rule.InfoTitleSelector).Text()
	chap.Title = beego.HTML2str(chap.Title)
	chap.Title = strings.Replace(chap.Title, "正文 ", "", -1)
	chap.Title = strings.TrimSpace(chap.Title)
	if len(chap.Title) == 0 {
		return nil, ErrNotChapTitle
	}

	// 获取章节内容
	chap.Desc, _ = doc.Find(rule.InfoDescSelector).Html()

	// 正则过滤关键词
	keyexs := strings.Split(rule.InfoDescFilterRule, "\n")
	for _, v := range keyexs {
		if len(v) > 0 {
			re, _ := regexp.Compile("(?U)" + v)
			chap.Desc = re.ReplaceAllString(chap.Desc, "")
		}
	}

	// 获取上一页
	preURL := doc.Find(rule.InfoPrePageSelector).AttrOr("href", "")
	if preURL != "" {
		preURL, _ = this.genrateURL(u, preURL)
	}

	// 获取下一页
	nextURL := doc.Find(rule.InfoNextPageSelector).AttrOr("href", "")
	if nextURL != "" {
		nextURL, _ = this.genrateURL(u, nextURL)
	}

	return &SnatchInfo{
		Source:  provider.Code,
		Chap:    chap,
		UseTime: time.Since(t1),
		NextUrl: nextURL,
		PreUrl:  preURL,
	}, nil
}

// 获取小说章节列表
func (this *Snatch) GetChapters(provider *models.SnatchRule, rawurl string) ([]*SnatchInfo, error) {
	if provider == nil {
		return nil, ErrNotProvider
	}

	rule := provider.Rules

	if rule == nil {
		return nil, ErrNotRule
	}

	// 解析URL
	u, err := url.Parse(rawurl)
	if err != nil {
		return nil, err
	}

	links := make([]*SnatchInfo, 0)

	// 请求章节页面
	doc, _, err := this.newHtml(rawurl, provider.Charset)
	if err != nil {
		return links, err
	}

	lastChap := ""
	chapNo := uint32(1)

	// 获取小说URL地址
	abandonNum := 0
	doc.Find(rule.ChapterCatalogSelector).Each(func(i int, s *goquery.Selection) {
		// 过滤掉最新章节
		if abandonNum < rule.ChapterAbandonNum {
			abandonNum++
			return
		}

		chapLink, _ := s.Attr("href")
		if len(chapLink) == 0 {
			return
		}

		// 获取章节名称，去重判断
		chapText := s.Text()
		if strings.EqualFold(chapText, lastChap) {
			return
		}

		chap := models.NewChapter()
		chap.Title = chapText
		chap.Link, _ = this.genrateURL(u, chapLink)
		chap.ChapterNo = chapNo
		lastChap = chapText

		if len(chapLink) == 0 {
			return
		}

		links = append(links, &SnatchInfo{
			Chap: chap,
		})
		chapNo++
	})

	return links, nil
}

// 代理设置
func (this *Snatch) Proxy(proxyFunc func() string) {
	this.proxyFunc = proxyFunc
}

// 网页请求，失败重试
// 返回goquery
func (this *Snatch) newHtml(rawurl, charset string) (*goquery.Document, *http.Response, error) {
	var body io.Reader
	var resp *http.Response
	var err error

	// 失败重试
	for i := 0; i < RETRY; i++ {
		resp, err = utils.HttpGet(rawurl, nil, this.proxyFunc())
		if err == nil {
			break
		}

		if resp != nil && (resp.StatusCode == 301 || resp.StatusCode == 302) {
			break
		}

		// 休眠10ms，防止采集速度过快被屏蔽
		time.Sleep(time.Duration(50) * time.Millisecond)
	}

	if err != nil {
		return nil, resp, err
	}

	body = resp.Body

	// 编码转换
	if charset != "UTF-8" {
		enc := mahonia.NewDecoder("GB18030")
		body = enc.NewReader(body)
	}

	doc, err := goquery.NewDocumentFromReader(body)
	if err != nil {
		return nil, resp, err
	}

	return doc, resp, nil
}

// 拼装当前页面获取到的连接，生成完整的URL
func (this *Snatch) genrateURL(base *url.URL, rawurl string) (string, error) {
	u, err := url.Parse(rawurl)
	if err != nil {
		return "", err
	}

	return base.ResolveReference(u).String(), nil
}
