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

	"github.com/vckai/novel/app/models"
)

type Txt struct {
	proxy string
}

const (
	TXT_SOURCE     = "23txt"
	TXT_TITLE      = "天籁小说"
	TXT_URL        = "https://www.23txt.com"
	TXT_NOT_COVER  = TXT_URL + "/modules/article/images/nocover.jpg"
	TXT_SEARCH_URL = TXT_URL + "/search.php?keyword=%s"
)

var cateTXTMap map[string]uint32 = map[string]uint32{
	"玄幻小说": 1,
	"修真小说": 2,
	"都市小说": 3,
	"历史小说": 4,
	"网游小说": 6,
	"科幻小说": 7,
	"言情小说": 3,
	"其他小说": 13,
}

func init() {
	Register(TXT_SOURCE, &Provide{
		Title:  TXT_TITLE,
		Client: NewTxt(),
	})
}

func NewTxt() *Txt {
	return &Txt{
		proxy: "",
	}
}

// 获取小说网站URL
func (this *Txt) GetURL() string {
	return TXT_URL
}

// 是否小说简介页面
func (this *Txt) IsBookURL(rawurl string) bool {
	return strings.Contains(rawurl, TXT_URL+"/files/article/html/") && !strings.Contains(rawurl, ".html")
}

// 是否可爬虫页面
func (this *Txt) IsCrawlerURL(rawurl string) bool {
	return strings.Contains(rawurl, TXT_URL) && !strings.Contains(rawurl, TXT_URL+"/files/article/html/")
}

// 获取小说信息
func (this *Txt) GetNovel(rawurl string) (*SnatchInfo, error) {
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
		nov.Cover = img
	}

	// 默认封面图片直接重置空
	if nov.Cover == TXT_NOT_COVER {
		nov.Cover = ""
	}

	// 获取小说类别
	nov.CateName = c.Find(".con_top a").Eq(1).Text()

	// 获取分类ID
	nov.CateId = DEF_CATE_ID
	if id, ok := cateTXTMap[nov.CateName]; ok {
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

	// 获取小说简介
	nov.Desc, _ = c.Find("#intro p").Eq(0).Html()

	return &SnatchInfo{
		Url:        rawurl,
		Source:     TXT_SOURCE,
		ChapterUrl: rawurl,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 搜索小说
func (this *Txt) FindNovel(kw string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(fmt.Sprintf(TXT_SEARCH_URL, url.QueryEscape(kw)), this.proxy, "utf-8")
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find(".result-list").Find(".result-item").First()

	// 获取小说标题
	nov.Name = c.Find(".result-game-item-title-link span").Text()
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = c.Find(".result-game-item-info .result-game-item-info-tag").First().Find("span").Eq(1).Text()
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}
	nov.Author = strings.TrimSpace(nov.Author)

	// 获取小说最新章节
	nov.ChapterTitle = c.Find(".result-game-item-info .result-game-item-info-tag").Eq(3).Find("a").Text()

	// 获取小说简介
	nov.Desc = c.Find(".result-game-item-desc").Text()

	// 获取章节链接地址
	chapterLink, _ := c.Find(".result-game-item-title-link").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	// 获取图片封面
	nov.Cover, _ = c.Find(".result-game-item-pic-link-img").Attr("src")

	return &SnatchInfo{
		Source:     TXT_SOURCE,
		Url:        chapterLink,
		ChapterUrl: chapterLink,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 获取小说章节内容
func (this *Txt) GetChapter(rawurl string) (*SnatchInfo, error) {
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
	keywords := []string{}
	for _, v := range keywords {
		chap.Desc = strings.Replace(chap.Desc, v, "", -1)
	}

	// 正则过滤关键词
	keyexs := []string{
		`(?U)[』]?天[\s\S]{0,4}籁[\s\S]{0,4}小[\s\S]{0,4}说(.*)ＣＯＭ`,
	}

	for _, v := range keyexs {
		re, _ := regexp.Compile(v)
		chap.Desc = re.ReplaceAllString(chap.Desc, "")
	}

	// 获取上一页
	preUrl, _ := doc.Find(".bottem2 a").Eq(0).Attr("href")
	if preUrl == "" || !strings.Contains(preUrl, ".html") {
		preUrl = ""
	} else {
		preUrl = TXT_URL + preUrl
	}

	// 获取下一页
	nextUrl, _ := doc.Find(".bottem2 a").Eq(2).Attr("href")
	if nextUrl == "" || !strings.Contains(nextUrl, ".html") {
		nextUrl = ""
	} else {
		nextUrl = TXT_URL + nextUrl
	}

	return &SnatchInfo{
		Chap:    chap,
		Source:  TXT_SOURCE,
		UseTime: t2,
		NextUrl: nextUrl,
		PreUrl:  preUrl,
	}, nil
}

// 获取章节列表
func (this *Txt) GetChapters(rawurl string) ([]*SnatchInfo, error) {
	links := []*SnatchInfo{}
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return links, err
	}

	// 获取小说URL地址
	lastChap := ""
	chapNo := uint32(1)
	doc.Find("#list dd").Find("a").Each(func(i int, s *goquery.Selection) {
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
		chap.Link = TXT_URL + chapLink
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
func (this *Txt) Proxy(rawurl string) {
	this.proxy = rawurl
}
