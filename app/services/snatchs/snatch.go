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
	"bytes"
	"context"
	"errors"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
	"github.com/axgle/mahonia"
	"github.com/vckai/novel/app/utils/log"

	xhttp "github.com/vckai/novel/app/librarys/net/http"
	"github.com/vckai/novel/app/models"
)

const (
	// 默认分类
	DEF_CATE_ID = 13

	// 请求失败重试次数
	RETRY = 5
)

var (
	ErrNotProvider  = errors.New("没有获取到采集点")
	ErrNotResp      = errors.New("没有返回")
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

	rawurl = strings.TrimSpace(rawurl)
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

	if len(rule.IsCrawlerURL) == 0 {
		return true
	}

	rawurl = strings.TrimSpace(rawurl)

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

	t1 := time.Now()

	rule := provider.Rules

	if rule == nil {
		return nil, ErrNotRule
	}

	charset := provider.Charset
	if len(rule.FindCharset) > 0 {
		charset = rule.FindCharset
	}

	// 转换为gbk编码
	if charset == "GB18030" {
		enc := mahonia.NewEncoder(charset)
		kw = enc.ConvertString(kw)
	}

	if len(rule.FindURL) == 0 {
		return nil, ErrNotFindUrl
	}

	kw = strings.TrimSpace(kw)
	kw = url.QueryEscape(kw)

	// 解析URL
	u, err := url.Parse(rule.FindURL + kw)
	if err != nil {
		return nil, err
	}

	// 请求搜索页面
	doc, resp, err := this.newHtml(u.String(), charset)
	if err != nil {
		return nil, err
	}

	if resp == nil {
		return nil, ErrNotResp
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

	// 获取小说简介
	info, err := this.GetNovel(provider, novURL)
	if err != nil {
		return nil, err
	}

	info.UseTime = time.Since(t1)

	log.Debug(fmt.Sprintf("[%s]查找小说[%s]，使用时间：%v", provider.Name, info.Nov.Name, info.UseTime))

	return info, nil
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
	rawurl = strings.TrimSpace(rawurl)
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
	if len(rule.BookCoverAttr) == 0 {
		rule.BookCoverAttr = "src"
	}

	if img, ok := doc.Find(rule.BookCoverSelector).Attr(rule.BookCoverAttr); ok {
		nov.Cover = img

		if !strings.Contains(nov.Cover, "https://") && !strings.Contains(nov.Cover, "http://") && len(nov.Cover) > 0 {
			nov.Cover, _ = this.genrateURL(u, nov.Cover)
		}
	}

	// 默认封面图片直接重置空
	if len(rule.BookNoCover) > 0 && strings.Contains(nov.Cover, rule.BookNoCover) {
		nov.Cover = ""
	}

	// 获取小说类别
	if len(rule.BookCateAttr) > 0 {
		nov.CateName = doc.Find(rule.BookCateSelector).AttrOr(rule.BookCateAttr, "")
	} else {
		nov.CateName = doc.Find(rule.BookCateSelector).Text()
	}
	nov.CateName = this.filter(rule.BookCateFilter, nov.CateName)
	nov.CateName = strings.TrimSpace(nov.CateName)

	// 获取小说类别ID
	nov.CateId = DEF_CATE_ID
	for _, v := range provider.CateMaps {
		if v.Name == nov.CateName {
			nov.CateId = v.Id
			break
		}
	}

	// 获取小说标题
	if len(rule.BookTitleAttr) > 0 {
		nov.Name = doc.Find(rule.BookTitleSelector).AttrOr(rule.BookTitleAttr, "")
	} else {
		nov.Name = doc.Find(rule.BookTitleSelector).Text()
	}
	nov.Name = this.filter(rule.BookTitleFilter, nov.Name)
	nov.Name = strings.TrimSpace(nov.Name)
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说最新章节
	if len(rule.BookLastChapterTitleSelector) > 0 {
		if len(rule.BookLastChapterTitleAttr) > 0 {
			nov.ChapterTitle = doc.Find(rule.BookLastChapterTitleSelector).AttrOr(rule.BookLastChapterTitleAttr, "")
		} else {
			nov.ChapterTitle = doc.Find(rule.BookLastChapterTitleSelector).Text()
		}
		nov.ChapterTitle = strings.TrimSpace(nov.ChapterTitle)
	}

	// 获取小说作者
	if len(rule.BookAuthorAttr) > 0 {
		nov.Author = doc.Find(rule.BookAuthorSelector).AttrOr(rule.BookAuthorAttr, "")
	} else {
		nov.Author = doc.Find(rule.BookAuthorSelector).Text()
	}
	nov.Author = this.filter(rule.BookAuthorFilter, nov.Author)
	nov.Author = strings.TrimSpace(nov.Author)
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}

	// 获取小说简介
	if len(rule.BookDescAttr) > 0 {
		nov.Desc = doc.Find(rule.BookDescSelector).AttrOr(rule.BookDescAttr, "")
	} else {
		nov.Desc, _ = doc.Find(rule.BookDescSelector).Html()
	}
	nov.Desc = this.filter(rule.BookDescFilter, nov.Desc)

	// 获取章节链接地址
	chapterLink := rawurl
	if len(rule.BookChapterURLSelector) > 0 {
		if len(rule.BookChapterURLAttr) == 0 {
			rule.BookChapterURLAttr = "href"
		}

		chapterLink = doc.Find(rule.BookChapterURLSelector).AttrOr(rule.BookChapterURLAttr, "")
		if len(chapterLink) == 0 {
			return nil, ErrNotNovLink
		}
		// 生成完整链接地址
		chapterLink, _ = this.genrateURL(u, chapterLink)
	}

	useTime := time.Since(t1)
	log.Debug(fmt.Sprintf("[%s]获取小说[%s]，使用时间：%v", provider.Name, nov.Name, useTime))

	return &SnatchInfo{
		ChapterUrl: chapterLink,
		Title:      provider.Name,
		Source:     provider.Code,
		Url:        rawurl,
		UseTime:    useTime,
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
	rawurl = strings.TrimSpace(rawurl)
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
	chap.Title = this.filter(rule.InfoTitleFilter, chap.Title)
	chap.Title = strings.TrimSpace(chap.Title)
	if len(chap.Title) == 0 {
		return nil, ErrNotChapTitle
	}

	// 获取章节内容
	chap.Desc, _ = doc.Find(rule.InfoDescSelector).Html()
	chap.Desc = this.filter(rule.InfoDescFilter, chap.Desc)

	// 获取上一页
	preURL := ""
	if purl := doc.Find(rule.InfoPrePageSelector).AttrOr("href", ""); len(purl) > 0 {
		purl, _ = this.genrateURL(u, purl)
		if !this.IsBookURL(provider, purl) && rawurl != purl {
			preURL = purl
		}
	}

	// 获取下一页
	nextURL := ""
	if nurl := doc.Find(rule.InfoNextPageSelector).AttrOr("href", ""); len(nurl) > 0 {
		nurl, _ = this.genrateURL(u, nurl)
		if !this.IsBookURL(provider, nurl) && rawurl != nurl {
			nextURL = nurl
		}
	}

	log.Debug(fmt.Sprintf("[%s]获取小说章节内容[%s][%s]，使用时间：%v", provider.Name, chap.Title, rawurl, time.Since(t1)))

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
	t1 := time.Now()

	rule := provider.Rules

	if rule == nil {
		return nil, ErrNotRule
	}

	// 解析URL
	rawurl = strings.TrimSpace(rawurl)
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

	catalogSelector := doc.Find(rule.ChapterCatalogSelector)

	// 章节数量
	catalogSize := catalogSelector.Size()

	// 新书章节小于丢弃数量情况，防止丢失章节
	// 丢弃章节 = 章节数量 / 2
	if rule.ChapterAbandonNum > 0 && catalogSize < rule.ChapterAbandonNum*2 {
		rule.ChapterAbandonNum = catalogSize / 2
	}

	abandonNum := 1
	// 获取小说URL地址
	catalogSelector.Each(func(i int, s *goquery.Selection) {
		// 过滤掉最新章节
		if rule.ChapterAbandonNum >= abandonNum {
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
			Chap:    chap,
			UseTime: time.Since(t1),
		})
		chapNo++
	})

	log.Debug(fmt.Sprintf("[%s]获取小说章节列表[%s]，使用时间：%v", provider.Name, rawurl, time.Since(t1)))

	if len(rule.ChapterNextPageSelector) == 0 {
		return links, nil
	}

	// @TODO
	// 存在下一页章节目录
	// 通过递归的方式采集分页章节列表
	// 不推荐采集章节列表分页的站点，因为请求的次数太多了，导致采集速度过慢。
	if nextURL := doc.Find(rule.ChapterNextPageSelector).AttrOr("href", ""); len(nextURL) > 0 {
		nextURL, _ = this.genrateURL(u, nextURL)
		if !this.IsBookURL(provider, nextURL) && rawurl != nextURL {
			// 重置第二页的丢弃章节为0
			provider.Rules.ChapterAbandonNum = 0
			ls, err := this.GetChapters(provider, nextURL)
			if err == nil {
				links = append(links, ls...)
			}
		}
	}

	return links, nil
}

// 代理设置
func (this *Snatch) Proxy(proxyFunc func() string) {
	this.proxyFunc = proxyFunc
}

// 网页请求，失败重试
// 返回goquery
func (this *Snatch) newHtml(rawurl, charset string) (*goquery.Document, *http.Response, error) {
	var res []byte
	var resp *http.Response
	var body io.Reader
	var err error

	conf := &xhttp.ClientConfig{
		Timeout:   10 * time.Second,
		Dial:      10 * time.Second,
		KeepAlive: 60 * time.Second,
		CheckRedirect: func(req *http.Request, via []*http.Request) error {
			return http.ErrUseLastResponse
		},
	}
	c := xhttp.NewClient(conf)

	// 失败重试
	for i := 0; i < RETRY; i++ {
		c.SetProxy(this.proxyFunc())
		res, resp, err = c.Get(context.TODO(), rawurl, nil)
		if err == nil {
			break
		}

		if resp != nil && (resp.StatusCode == 301 || resp.StatusCode == 302) {
			break
		}

		log.Debug("请求失败：", rawurl, err)

		// 休眠10ms，防止采集速度过快被屏蔽
		time.Sleep(time.Duration(10) * time.Millisecond)
	}

	if err != nil {
		return nil, resp, err
	}

	body = bytes.NewReader(res)

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

// 采集内容过滤
func (this *Snatch) filter(filter, kw string) string {
	if len(kw) == 0 {
		return kw
	}

	// 正则过滤关键词
	keyexs := strings.Split(filter, "\n")
	for _, v := range keyexs {
		if len(v) == 0 {
			continue
		}
		replaced := ""
		if strings.Contains(v, " | ") {
			aR := strings.Split(v, " | ")
			v = aR[0]
			replaced = aR[1]
		}
		re, _ := regexp.Compile("(?U)" + v)
		kw = re.ReplaceAllString(kw, replaced)
	}

	return kw
}

// 拼装当前页面获取到的连接，生成完整的URL
func (this *Snatch) genrateURL(base *url.URL, rawurl string) (string, error) {
	u, err := url.Parse(rawurl)
	if err != nil {
		return "", err
	}

	return base.ResolveReference(u).String(), nil
}
