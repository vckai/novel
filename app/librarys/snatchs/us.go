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
	"net/url"
	"regexp"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
	"github.com/axgle/mahonia"

	"github.com/vckai/novel/app/models"
)

type Us struct {
	proxy string
}

const (
	US_NAME       = "顶点小说"
	US_SOURCE     = "us"
	US_URL        = "https://www.x23us.com"
	US_HTTPS_URL  = "https://www.x23us.com"
	US_SEARCH_URL = "https://www.x23us.com/modules/article/search.php?searchtype=keywords&searchkey=%s"
	US_NOTCOVER   = US_URL + "/modules/article/images/nocover.jpg"
)

var cateUSMap map[string]uint32 = map[string]uint32{
	"玄幻魔法": 1,
	"武侠修真": 2,
	"都市言情": 3,
	"历史军事": 4,
	"侦探推理": 5,
	"网游动漫": 6,
	"科幻小说": 7,
	"恐怖灵异": 8,
	"散文诗词": 13,
}

func init() {
	Register(US_SOURCE, &Provide{
		Title:  US_NAME,
		Client: NewUs(),
	})
}

func NewUs() *Us {
	return &Us{
		proxy: "",
	}
}

// 获取小说网站URL
func (this *Us) GetURL() string {
	return US_URL
}

// 是否小说简介页面
func (this *Us) IsBookURL(rawurl string) bool {
	return strings.Contains(rawurl, US_URL+"/book/") ||
		strings.Contains(rawurl, US_HTTPS_URL+"/book/")
}

// 是否小说是否爬虫页面
func (this *Us) IsCrawlerURL(rawurl string) bool {
	return strings.Contains(rawurl, US_URL+"/class/") ||
		strings.Contains(rawurl, US_HTTPS_URL+"/class/")
}

// 获取小说信息
func (this *Us) GetNovel(rawurl string) (*SnatchInfo, error) {
	rawurl = strings.TrimRight(rawurl, "/")
	if len(rawurl) == 0 {
		return nil, ErrNotUrl
	}
	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	snatch, err := this.getNovel(doc)

	snatch.Url = rawurl
	snatch.UseTime = t2

	return snatch, err

}

// 获取小说信息
func (this *Us) getNovel(doc *goquery.Document) (*SnatchInfo, error) {

	nov := models.NewNovel()

	c := doc.Find("#content")
	// 获取封面图片
	if img, ok := c.Find("img").First().Attr("src"); ok {
		nov.Cover = img

		if !strings.Contains(nov.Cover, "http://") {
			nov.Cover = nov.Cover
		}
	}

	// 默认封面图片直接重置空
	if nov.Cover == US_NOTCOVER {
		nov.Cover = ""
	}

	// 获取小说类别
	nov.CateName = c.Find("table tr").First().Find("td").Eq(0).Find("a").Text()

	// 获取小说类别ID
	nov.CateId = DEF_CATE_ID
	if id, ok := cateUSMap[nov.CateName]; ok {
		nov.CateId = id
	}

	// 获取小说标题
	nov.Name = strings.Replace(strings.TrimRight(c.Find("dd h1").Text(), " 全文阅读"), "&nbsp;", "", -1)
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = strings.Replace(c.Find("table tr").First().Find("td").Eq(1).Text(), "&nbsp;", "", -1)
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}
	nov.Author = strings.TrimSpace(nov.Author)

	// 获取小说简介
	nov.Desc, _ = c.Find("p").Eq(4).Html()

	// 获取章节链接地址
	chapterLink, _ := c.Find(".read").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	return &SnatchInfo{
		ChapterUrl: chapterLink,
		Source:     US_SOURCE,
		Nov:        nov,
	}, nil
}

// 搜索小说
func (this *Us) FindNovel(kw string) (*SnatchInfo, error) {
	t1 := time.Now()
	// 转换为gbk编码
	enc := mahonia.NewEncoder("GB18030")
	kw = url.QueryEscape(enc.ConvertString(kw))
	doc, err := NewHtml(fmt.Sprintf(US_SEARCH_URL, kw), this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	// 查找后直接跳转到小说封面页面
	if strings.Contains(doc.Find("#content").Find("h1").Text(), "全文阅读") {
		snatch, err := this.getNovel(doc)
		snatch.UseTime = t2

		re, _ := regexp.Compile(`/html/[\d]+/`)
		snatch.Url = strings.TrimRight(re.ReplaceAllString(snatch.ChapterUrl, "/book/"), "/")

		return snatch, err
	}

	nov := models.NewNovel()

	c := doc.Find("#content").Find("tr").Eq(1)

	// 获取小说标题
	nov.Name = c.Find("td").Eq(0).Find("a").First().Text()
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

	// 获取小说介绍页面URL
	link, _ := c.Find("td").Eq(0).Find("a").Attr("href")
	if len(link) == 0 {
		return nil, ErrNotNovLink
	}

	// 获取章节链接地址
	chapterLink, _ := c.Find("td").Eq(1).Find("a").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	link = strings.Replace(link, "http://", "https://", -1)
	chapterLink = strings.Replace(chapterLink, "http://", "https://", -1)

	return &SnatchInfo{
		Url:        link,
		ChapterUrl: chapterLink,
		Source:     US_SOURCE,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 获取小说章节内容
func (this *Us) GetChapter(rawurl string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	chap := models.NewChapter()
	chap.Link = rawurl

	// 获取章节标题
	chap.Title = beego.HTML2str(doc.Find(".bdsub dl dd h1").Text())

	if len(chap.Title) == 0 {
		return nil, ErrNotChapTitle
	}

	chap.Title = strings.Replace(chap.Title, "正文 ", "", -1)

	// 获取章节内容
	chap.Desc, _ = doc.Find("#contents").Html()

	// 过滤关键词
	keywords := []string{
		"顶 点 小 说 Ｘ ２３ Ｕ Ｓ．Ｃ ＯＭ",
		"顶点小说 ２３ＵＳ．ＣＯＭ更新最快",
		"(看小说到顶点小说网www.23us.com)",
		"16977小游戏每天更新好玩的小游戏，等你来发现！",
		"ｗＷｗ．２３ｕＳ．ｃｏＭ",
		"２３Ｕｓ．ｃｏｍ",
		"ｗＥＮｘｕＥｍＩ。ｃＯＭ",
		"ＷＥＮｘｕｅＭＩ。ｃＯｍ",
		"ｗｅＮｘＵｅｍｉ。Ｃｏｍ",
		"ｗｅｎＸＵＥｍＩ。ＣＯｍ",
		"ＷｅｎＸｕｅＭｉ。ｃｏｍ",
		"ＷＥｎＸＵｅＭｉ。ＣｏＭ",
		"ｗｅｎｘｕｅｍｉ。ｃｏｍ",
		"ＷｅｎＸｕｅＭｉ。ｃｏｍ",
		"ＷｅＮＸｕＥｍＩ。ｃＯＭ",
		"ＷＥＮｘｕｅＭＩ。ｃＯｍ",
		"()",
		"www.siluke.com",
	}
	for _, v := range keywords {
		chap.Desc = strings.Replace(chap.Desc, v, "", -1)
	}

	// 正则过滤关键词
	keyexs := []string{
		`(?U)顶点小说(.*)更新最快`,
		`(?U)本文由(.*)首发`,
	}

	for _, v := range keyexs {
		re, _ := regexp.Compile(v)
		chap.Desc = re.ReplaceAllString(chap.Desc, "")
	}

	// 获取章节目录链接
	novLink, _ := doc.Find("#footlink a").Eq(1).Attr("href")

	// 获取上一页
	preUrl, _ := doc.Find("#footlink a").Eq(0).Attr("href")
	if preUrl == "" || preUrl == novLink {
		preUrl = ""
	} else {
		preUrl = US_URL + preUrl
	}

	// 获取下一页
	nextUrl, _ := doc.Find("#footlink a").Eq(2).Attr("href")
	if nextUrl == "" || nextUrl == novLink {
		nextUrl = ""
	} else {
		nextUrl = US_URL + nextUrl
	}

	return &SnatchInfo{
		Source:  US_SOURCE,
		Chap:    chap,
		UseTime: t2,
		NextUrl: nextUrl,
		PreUrl:  preUrl,
	}, nil
}

// 获取章节内容
func (this *Us) GetChapters(rawurl string) ([]*SnatchInfo, error) {
	links := []*SnatchInfo{}
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return links, err
	}

	// 获取小说URL地址
	lastChap := ""
	chapNo := uint32(1)
	doc.Find(".bdsub dl dd").Eq(2).Find("a").Each(func(i int, s *goquery.Selection) {
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
		chap.Link = rawurl + chapLink
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
func (this *Us) Proxy(rawurl string) {
	this.proxy = rawurl
}
