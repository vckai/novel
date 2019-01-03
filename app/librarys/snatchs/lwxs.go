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
	"fmt"
	"regexp"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"

	"github.com/vckai/novel/app/models"
)

type Lwxs struct {
	proxy string
}

const (
	LWXS_SOURCE     = "lwxs"
	LWXS_URL        = "http://www.lewendu8.com"
	LWXS_SEARCH_URL = "http://zhannei.baidu.com/cse/search?s=6329054699686151327&q=%s"
	LWXS_NOT_COVER  = LWXS_URL + "/modules/article/images/nocover.jpg"
)

var cateLWXSMap map[string]uint32 = map[string]uint32{
	"魔幻玄幻": 1,
	"仙侠修真": 2,
	"都市青春": 3,
	"历史军事": 4,
	"科幻游戏": 6,
	"近代现代": 13,
	"同人耽美": 12,
	"架空历史": 10,
	"重生异能": 3,
	"恐怖推理": 8,
}

func init() {
	//Register(LWXS_SOURCE, &Provide{
	//	Title:  "乐文小说",
	//	Client: NewLwxs(),
	//})
}

func NewLwxs() *Lwxs {
	return &Lwxs{
		proxy: "",
	}
}

// 获取小说网站URL
func (this *Lwxs) GetURL() string {
	return LWXS_URL
}

// 是否小说简介页面
func (this *Lwxs) IsBookURL(rawurl string) bool {
	return strings.Contains(rawurl, LWXS_URL+"/book/") && strings.Contains(rawurl, "index.html")
}

// 是否可爬虫页面
func (this *Lwxs) IsCrawlerURL(rawurl string) bool {
	return strings.Contains(rawurl, LWXS_URL)
}

// 获取小说信息
func (this *Lwxs) GetNovel(rawurl string) (*SnatchInfo, error) {
	if len(rawurl) == 0 {
		return nil, ErrNotUrl
	}

	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find(".box_intro")
	// 获取封面图片
	if img, ok := c.Find(".pic img").First().Attr("src"); ok {
		nov.Cover = img
	}

	// 默认封面图片直接重置空
	if nov.Cover == LWXS_NOT_COVER {
		nov.Cover = ""
	}

	// 获取小说类别
	nov.CateName = strings.Replace(c.Find(".box_info table tr").Eq(4).Find("td").Eq(0).Text(), "小说分类：", "", -1)

	// 获取小说标题
	//nov.Name = c.Find(".f21h").Text()
	if title, ok := c.Find(".pic img").First().Attr("alt"); ok {
		nov.Name = strings.Replace(title, "封面", "", -1)
	}
	if len(nov.Name) == 0 {
		return nil, ErrNotNov
	}

	// 获取小说作者
	nov.Author = c.Find(".f20h em").Text()
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}
	re := regexp.MustCompile(`(?U)作(.*)者[：|:]`)
	nov.Author = re.ReplaceAllString(nov.Author, "")
	nov.Author = strings.TrimSpace(nov.Author)

	// 获取小说简介
	nov.Desc, _ = c.Find(".intro").Html()

	re = regexp.MustCompile(`(?U)乐文小说(.*)books/[0-9]+/[0-9]+/`)
	nov.Desc = re.ReplaceAllString(nov.Desc, "")

	// 获取小说类别
	nov.CateName = doc.Find(".bread-crumbs").Find("a").Eq(1).Text()

	// 获取分类ID
	nov.CateId = DEF_CATE_ID
	if id, ok := cateLWXSMap[nov.CateName]; ok {
		nov.CateId = id
	}

	// 获取章节链接地址
	chapterLink, _ := c.Find(".btopt a").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}
	chapterLink = LWXS_URL + chapterLink

	return &SnatchInfo{
		Url:        rawurl,
		ChapterUrl: chapterLink,
		Source:     LWXS_SOURCE,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 搜索小说
func (this *Lwxs) FindNovel(keyword string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(fmt.Sprintf(LWXS_SEARCH_URL, keyword), this.proxy, "utf-8")
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find(".result-list").Find(".result-item").First()

	// 获取小说标题
	nov.Name = c.Find(".result-item-title em").Text()
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
	nov.Desc = nov.Desc

	// 获取章节链接地址
	chapterLink, _ := c.Find(".result-game-item-title-link").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	re, _ := regexp.Compile(`/books/[\d]+/`)
	link := re.ReplaceAllString(chapterLink, "/book/")

	// 获取图片封面
	nov.Cover, _ = c.Find(".result-game-item-pic-link-img").Attr("src")

	return &SnatchInfo{
		Url:        link + "index.html",
		ChapterUrl: chapterLink,
		Source:     LWXS_SOURCE,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 获取小说章节内容
func (this *Lwxs) GetChapter(rawurl string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	chap := models.NewChapter()
	chap.Link = rawurl

	// 获取章节标题
	chap.Title = beego.HTML2str(doc.Find("#bgdiv .border_l_r h1").Text())

	if len(chap.Title) == 0 {
		return nil, ErrNotChapTitle
	}

	// 获取章节内容
	chap.Desc, _ = doc.Find("#content p").Html()

	// 过滤关键词
	keywords := []string{
		"乐文小说",
		"超快稳定更新小说",
	}
	for _, v := range keywords {
		chap.Desc = strings.Replace(chap.Desc, v, "", -1)
	}

	// 正则过滤关键词
	keyexs := []string{
		`(?U)本文由(.*)首发`,
		`(?i)www.lewendu8.com`,
	}

	for _, v := range keyexs {
		re, _ := regexp.Compile(v)
		chap.Desc = re.ReplaceAllString(chap.Desc, "")
	}

	// 获取章节目录链接
	novLink, _ := doc.Find("#thumb a").Eq(1).Attr("href")

	preLink := rawurl[:strings.LastIndex(rawurl, "/")+1]
	// 获取上一页
	preUrl, _ := doc.Find("#thumb a").Eq(0).Attr("href")
	if preUrl == "" || preUrl == novLink {
		preUrl = ""
	} else {
		preUrl = preLink + preUrl
	}

	// 获取下一页
	nextUrl, _ := doc.Find("#thumb a").Eq(2).Attr("href")
	if nextUrl == "" || nextUrl == novLink {
		nextUrl = ""
	} else {
		nextUrl = preLink + nextUrl
	}

	return &SnatchInfo{
		Chap:    chap,
		UseTime: t2,
		Source:  LWXS_SOURCE,
		NextUrl: nextUrl,
		PreUrl:  preUrl,
	}, nil
}

// 获取章节列表
func (this *Lwxs) GetChapters(rawurl string) ([]*SnatchInfo, error) {
	links := []*SnatchInfo{}
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return links, err
	}

	// 获取小说章节URL地址
	lastChap := ""
	chapNo := uint32(1)
	doc.Find("#defaulthtml4 td .dccss").Find("a").Each(func(i int, s *goquery.Selection) {
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
		chap.ChapterNo = chapNo
		chap.Link = LWXS_URL + chapLink
		lastChap = chapText

		links = append(links, &SnatchInfo{
			Chap: chap,
		})
		chapNo++
	})

	return links, nil
}

// 设置代理
func (this *Lwxs) Proxy(rawurl string) {
	this.proxy = rawurl
}
