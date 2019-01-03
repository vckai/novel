// Copyright 2017 Vckai Author. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not Biqugee this file except in compliance with the License.
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
	"fmt"
	"net/url"
	"regexp"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/axgle/mahonia"

	"github.com/vckai/novel/app/models"
)

type Xs struct {
	proxy string
}

const (
	XS_SOURCE    = "31xs"
	XS_TITLE     = "31小说网"
	XS_URL       = "http://www.31xs.net"
	XS_NOT_COVER = XS_URL + "/modules/article/images/nocover.jpg"
	//XS_SEARCH_URL = "http://zhannei.baidu.com/cse/search?s=7845455592055299828&entry=1&q=%s"
	XS_SEARCH_URL = "http://www.31xs.org/search.php?keywords=%s"
)

var cateXSMap map[string]uint32 = map[string]uint32{
	"玄幻": 1,
	"奇幻": 1,
	"修真": 2,
	"武侠": 2,
	"都市": 3,
	"言情": 3,
	"职场": 3,
	"历史": 4,
	"军事": 4,
	"网游": 6,
	"竞技": 6,
	"科幻": 7,
	"灵异": 8,
	"同人": 12,
}

func init() {
	Register(XS_SOURCE, &Provide{
		Title:  XS_TITLE,
		Client: NewXs(),
	})
}

func NewXs() *Xs {
	return &Xs{
		proxy: "",
	}
}

// 获取小说网站URL
func (this *Xs) GetURL() string {
	return XS_URL
}

// 是否小说简介页面
func (this *Xs) IsBookURL(rawurl string) bool {
	if !strings.Contains(rawurl, XS_SOURCE) {
		return false
	}

	re, _ := regexp.Compile(`(?U)\/[\d]{1,2}\/[\d]+\/`)
	return re.MatchString(rawurl) && !strings.Contains(rawurl, ".html")
}

// 是否可爬虫页面
func (this *Xs) IsCrawlerURL(rawurl string) bool {
	if !strings.Contains(rawurl, XS_SOURCE) {
		return false
	}
	return strings.Contains(rawurl, "/list/")
}

// 获取小说信息
func (this *Xs) GetNovel(rawurl string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find(".box_con")
	// 获取封面图片
	if img, ok := c.Find("#fmimg img").Attr("src"); ok {
		nov.Cover = XS_URL + img
	}

	// 默认封面图片直接重置空
	if nov.Cover == XS_NOT_COVER {
		nov.Cover = ""
	}

	// 获取小说类别
	nov.CateName = c.Find(".con_top").Find("a").Eq(2).Text()

	// 获取分类ID
	nov.CateId = DEF_CATE_ID
	if id, ok := cateXSMap[nov.CateName]; ok {
		nov.CateId = id
	}

	// 获取小说标题
	nov.Name = c.Find("#info h1").Text()
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = strings.TrimSpace(c.Find("#info p").Eq(0).Text())
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}
	re := regexp.MustCompile(`(?U)作(.*)者[：|:]`)
	nov.Author = re.ReplaceAllString(nov.Author, "")

	nov.Author = strings.Replace(nov.Author, " 著", "", -1)

	// 获取小说简介
	nov.Desc, _ = c.Find("#intro").Html()

	return &SnatchInfo{
		Url:        rawurl,
		Source:     XS_SOURCE,
		ChapterUrl: rawurl,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 搜索小说
func (this *Xs) FindNovel(kw string) (*SnatchInfo, error) {
	t1 := time.Now()
	// 转换为gbk编码
	enc := mahonia.NewEncoder("GB18030")
	kw = url.QueryEscape(enc.ConvertString(kw))
	doc, err := NewHtml(fmt.Sprintf(XS_SEARCH_URL, kw), this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find("#content").Find("tr").Eq(1)

	// 获取小说标题
	nov.Name = c.Find("td").Eq(0).Find("a").Eq(1).Text()
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = c.Find("td").Eq(2).Text()
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}
	nov.Author = strings.Replace(nov.Author, " 著", "", -1)
	nov.Author = strings.TrimSpace(nov.Author)

	// 获取小说最新章节
	nov.ChapterTitle = c.Find("td").Eq(1).Find("a").Text()

	// 获取小说简介
	nov.Desc = ""

	// 获取章节链接地址
	chapterLink, _ := c.Find("td").Eq(0).Find("a").Eq(1).Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	// 获取图片封面
	nov.Cover = ""

	chapterLink = strings.Replace(chapterLink, "31xs.com", "31xs.org", -1)

	return &SnatchInfo{
		Source:     XS_SOURCE,
		Url:        chapterLink,
		ChapterUrl: chapterLink,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 获取小说章节内容
func (this *Xs) GetChapter(rawurl string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	chap := models.NewChapter()
	chap.Link = rawurl

	// 获取章节标题
	chap.Title = doc.Find(".bookname h1").Text()

	if len(chap.Title) == 0 {
		return nil, ErrNotChapTitle
	}
	chap.Title = strings.Trim(chap.Title, " ")

	// 获取章节内容
	chap.Desc, _ = doc.Find("#content").Html()

	// 过滤关键词
	keywords := []string{
		//"一秒记住【笔♂趣→阁 WWW.BiQiuGe.Com】，精彩小说无弹窗免费阅读！<br><br>",
		"www.31xs.net",
		"www.31xs.org",
		"www.31xs.com",
	}
	for _, v := range keywords {
		chap.Desc = strings.Replace(chap.Desc, v, "", -1)
	}

	// 正则过滤关键词
	keyexs := []string{
		`(?U)本文由(.*)首发`,
		`(?U)一秒记住(.*)免费阅读！<br><br>`,
		`(?U)一秒记住(.*)免费阅读`,
		`(?U)最新最快(.*)\)`,
		`(?U)＝＝＝＝(.*)＝＝＝＝`,
	}

	for _, v := range keyexs {
		re, _ := regexp.Compile(v)
		chap.Desc = re.ReplaceAllString(chap.Desc, "")
	}

	chap.Desc = strings.Replace(chap.Desc, " ", "&nbsp;&nbsp;", -1)

	// 获取上一页
	preUrl, _ := doc.Find(".bottem2 a").Eq(1).Attr("href")
	if preUrl == "" || strings.Contains(preUrl, "index.html") {
		preUrl = ""
	} else {
		preUrl = XS_URL + preUrl
	}

	// 获取下一页
	nextUrl, _ := doc.Find(".bottem2 a").Eq(3).Attr("href")
	if nextUrl == "" || strings.Contains(nextUrl, "index.html") {
		nextUrl = ""
	} else {
		nextUrl = XS_URL + nextUrl
	}

	return &SnatchInfo{
		Chap:    chap,
		Source:  XS_SOURCE,
		UseTime: t2,
		NextUrl: nextUrl,
		PreUrl:  preUrl,
	}, nil
}

// 获取章节列表
func (this *Xs) GetChapters(rawurl string) ([]*SnatchInfo, error) {
	links := []*SnatchInfo{}
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return links, err
	}

	// 获取小说URL地址
	lastChap := ""
	chapNo := uint32(1)
	j := 0
	doc.Find("#list dd").Find("a").Each(func(i int, s *goquery.Selection) {
		// 过滤最新章节
		if j < 10 {
			j++
			return
		}

		chapLink, _ := s.Attr("href")
		if len(chapLink) == 0 || strings.Contains(chapLink, "javascript:") {
			return
		}

		// 获取章节名称，去重判断
		chapText := s.Text()
		if strings.EqualFold(chapText, lastChap) {
			return
		}

		chap := models.NewChapter()
		chap.Title = chapText
		chap.Link = XS_URL + chapLink
		chap.ChapterNo = chapNo
		lastChap = chapText

		links = append(links, &SnatchInfo{
			Chap: chap,
		})
		chapNo++
	})

	return links, nil
}

// 设置代理
func (this *Xs) Proxy(rawurl string) {
	this.proxy = rawurl
}
