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
	"regexp"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"

	"github.com/vckai/novel/app/models"
)

type Biquge struct {
	proxy string
}

const (
	BIQUGE_SOURCE     = "biquge"
	BIQUGE_TITLE      = "笔趣阁"
	BIQUGE_URL        = "http://www.biqiuge.com"
	BIQUGE_NOT_COVER  = BIQUGE_URL + "/modules/article/images/nocover.jpg"
	BIQUGE_SEARCH_URL = "http://zhannei.baidu.com/cse/search?q=%s&s=17512219138159063592&entry=1"
)

var cateBQMap map[string]uint32 = map[string]uint32{
	"玄幻小说": 1,
	"修真小说": 2,
	"都市小说": 3,
	"穿越小说": 4,
	"网游小说": 6,
	"科幻小说": 7,
}

func init() {
	Register(BIQUGE_SOURCE, &Provide{
		Title:  BIQUGE_TITLE,
		Client: NewBiquge(),
	})
}

func NewBiquge() *Biquge {
	return &Biquge{
		proxy: "",
	}
}

// 获取小说网站URL
func (this *Biquge) GetURL() string {
	return BIQUGE_URL
}

// 是否小说简介页面
func (this *Biquge) IsBookURL(rawurl string) bool {
	return strings.Contains(rawurl, BIQUGE_URL+"/book/") && !strings.Contains(rawurl, ".html")
}

// 是否可爬虫页面
func (this *Biquge) IsCrawlerURL(rawurl string) bool {
	return strings.Contains(rawurl, BIQUGE_URL) && !strings.Contains(rawurl, BIQUGE_URL+"/book/")
}

// 获取小说信息
func (this *Biquge) GetNovel(rawurl string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find(".book")
	// 获取封面图片
	if img, ok := c.Find(".cover img").Attr("src"); ok {
		nov.Cover = BIQUGE_URL + img
	}

	// 默认封面图片直接重置空
	if nov.Cover == BIQUGE_NOT_COVER {
		nov.Cover = ""
	}

	// 获取小说类别
	nov.CateName = c.Find(".small span").Eq(1).Text()
	nov.CateName = strings.Replace(nov.CateName, "分类：", "", -1)
	//re := regexp.MustCompile(`(?U)> (.*) >`)
	//arr := re.FindStringSubmatch(nov.CateName)
	///if len(arr) > 1 {
	//nov.CateName = strings.TrimSpace(arr[1])
	//}

	// 获取分类ID
	nov.CateId = DEF_CATE_ID
	if id, ok := cateBQMap[nov.CateName]; ok {
		nov.CateId = id
	}

	// 获取小说标题
	nov.Name = c.Find(".info h2").Text()
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = c.Find(".small span").Eq(0).Text()
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}

	nov.Author = strings.Replace(nov.Author, "作者：", "", -1)

	// 获取小说简介
	nov.Desc, _ = c.Find(".intro").Html()
	if i := strings.Index(nov.Desc, "作者"); i >= 0 {
		prefix := []byte(nov.Desc)[:i]
		len := len([]rune(string(prefix)))
		nov.Desc = string([]rune(nov.Desc[:len]))
	}

	return &SnatchInfo{
		Url:        rawurl,
		Source:     BIQUGE_SOURCE,
		ChapterUrl: rawurl,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 搜索小说
func (this *Biquge) FindNovel(kw string) (*SnatchInfo, error) {
	return nil, ErrNotNovName
	t1 := time.Now()
	doc, err := NewHtml(fmt.Sprintf(BIQUGE_SEARCH_URL, kw), this.proxy, "utf-8")
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

	// 获取章节链接地址
	chapterLink, _ := c.Find(".result-game-item-title-link").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	// 获取图片封面
	nov.Cover, _ = c.Find(".result-game-item-pic-link-img").Attr("src")

	return &SnatchInfo{
		Source:     BIQUGE_SOURCE,
		Url:        chapterLink,
		ChapterUrl: chapterLink,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 获取小说章节内容
func (this *Biquge) GetChapter(rawurl string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	chap := models.NewChapter()
	chap.Link = rawurl

	// 获取章节标题
	chap.Title = doc.Find(".content h1").Text()

	if len(chap.Title) == 0 {
		return nil, ErrNotChapTitle
	}
	chap.Title = strings.Trim(chap.Title, " ")

	// 获取章节内容
	chap.Desc, _ = doc.Find("#content").Html()

	// 过滤关键词
	keywords := []string{
		"一秒记住【笔♂趣→阁 WWW.BiQiuGe.Com】，精彩小说无弹窗免费阅读！<br><br>",
	}
	for _, v := range keywords {
		chap.Desc = strings.Replace(chap.Desc, v, "", -1)
	}

	// 正则过滤关键词
	keyexs := []string{
		`(?U)本文由(.*)首发`,
		`(?U)请记住本书(.*)。`,
		`(?U)笔趣阁(.*)com`,
		`(?U)一秒记住(.*)免费阅读！<br><br>`,
		`(?U)一秒记住(.*)免费阅读`,
		`(?U)笔趣阁(.*)最新章节！`,
		`(?U)http://(.*)html`,
		`(?U)https://(.*)html`,
	}

	for _, v := range keyexs {
		re, _ := regexp.Compile(v)
		chap.Desc = re.ReplaceAllString(chap.Desc, "")
	}

	// 获取上一页
	preUrl, _ := doc.Find(".page_chapter li").Eq(0).Find("a").Attr("href")
	if preUrl == "" || !strings.Contains(preUrl, "html") {
		preUrl = ""
	} else {
		preUrl = BIQUGE_URL + preUrl
	}

	// 获取下一页
	nextUrl, _ := doc.Find(".page_chapter li").Eq(2).Find("a").Attr("href")
	if nextUrl == "" || !strings.Contains(nextUrl, "html") {
		nextUrl = ""
	} else {
		nextUrl = BIQUGE_URL + nextUrl
	}

	return &SnatchInfo{
		Chap:    chap,
		Source:  BIQUGE_SOURCE,
		UseTime: t2,
		NextUrl: nextUrl,
		PreUrl:  preUrl,
	}, nil
}

// 获取章节列表
func (this *Biquge) GetChapters(rawurl string) ([]*SnatchInfo, error) {
	links := []*SnatchInfo{}
	doc, err := NewHtml(rawurl, this.proxy)
	if err != nil {
		return links, err
	}

	// 获取小说URL地址
	lastChap := ""
	chapNo := uint32(1)
	j := 0
	doc.Find(".listmain dd").Find("a").Each(func(i int, s *goquery.Selection) {
		// 过滤最新章节
		if j < 6 {
			j++
			return
		}

		chapLink, _ := s.Attr("href")
		if len(chapLink) == 0 {
			return
		}

		// 获取章节名称，去重判断
		chapText := s.Text()
		// 过滤空章节目录
		if strings.Contains(chapText, "章节目录") {
			return
		}

		if strings.EqualFold(chapText, lastChap) {
			return
		}

		chap := models.NewChapter()
		chap.Title = chapText
		chap.Link = BIQUGE_URL + chapLink
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
func (this *Biquge) Proxy(rawurl string) {
	this.proxy = rawurl
}
