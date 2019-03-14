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

type Bqg5 struct {
	proxy string
}

const (
	BIQUGE5_SOURCE     = "biquge5"
	BIQUGE5_TITLE      = "笔趣阁5"
	BIQUGE5_URL        = "https://www.bqg5.cc"
	BIQUGE5_NOT_COVER  = BIQUGE5_URL + "/modules/article/images/nocover.jpg"
	BIQUGE5_SEARCH_URL = "https://www.bqg5.cc/modules/article/search.php?searchkey=%s"
)

var cateBQ5Map map[string]uint32 = map[string]uint32{
	"玄幻小说": 1,
	"修真小说": 2,
	"都市小说": 3,
	"穿越小说": 4,
	"网游小说": 6,
	"科幻小说": 7,
}

func init() {
	Register(BIQUGE5_SOURCE, &Provide{
		Title:  BIQUGE5_TITLE,
		Client: NewBqg5(),
	})
}

func NewBqg5() *Bqg5 {
	return &Bqg5{
		proxy: "",
	}
}

// 获取小说网站URL
func (this *Bqg5) GetURL() string {
	return BIQUGE5_URL
}

// 是否小说简介页面
func (this *Bqg5) IsBookURL(rawurl string) bool {
	if !strings.Contains(rawurl, BIQUGE5_URL) {
		return false
	}

	re, _ := regexp.Compile(`(?U)\/[\d]{1,5}\_[\d]+\/`)
	return re.MatchString(rawurl)
}

// 是否可爬虫页面
func (this *Bqg5) IsCrawlerURL(rawurl string) bool {
	if !strings.Contains(rawurl, BIQUGE5_URL) {
		return false
	}

	re, _ := regexp.Compile(`(?U)\/[a-z]+\/`)
	return re.MatchString(rawurl) && strings.Contains(rawurl, BIQUGE5_URL)
}

// 获取小说信息
func (this *Bqg5) GetNovel(rawurl string) (*SnatchInfo, error) {
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
	if nov.Cover == BIQUGE5_NOT_COVER {
		nov.Cover = ""
	}

	// 获取小说类别
	nov.CateName = c.Find(".con_top").Text()
	re := regexp.MustCompile(`(?U)> (.*) >`)
	arr := re.FindStringSubmatch(nov.CateName)
	if len(arr) > 1 {
		nov.CateName = strings.TrimSpace(arr[1])
	}

	// 获取分类ID
	nov.CateId = DEF_CATE_ID
	if id, ok := cateBQ5Map[nov.CateName]; ok {
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
	re = regexp.MustCompile(`(?U)作(.*)者[：|:]`)
	nov.Author = re.ReplaceAllString(nov.Author, "")

	//nov.Author = strings.Replace(nov.Author, "作&nbsp;&nbsp;&nbsp;&nbsp;者：", "", -1)

	// 获取小说简介
	nov.Desc, _ = c.Find("#intro").Html()

	return &SnatchInfo{
		Url:        rawurl,
		Source:     BIQUGE5_SOURCE,
		ChapterUrl: rawurl,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 搜索小说
func (this *Bqg5) FindNovel(kw string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(fmt.Sprintf(BIQUGE5_SEARCH_URL, kw), this.proxy, "gbk")
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find("#hotcontent").Find("table tr").Eq(1)

	// 获取小说标题
	nov.Name = c.Find("td").Eq(0).Find("a").Text()
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = c.Find("td").Eq(2).Text()
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}
	nov.Author = strings.TrimSpace(nov.Author)

	// 获取小说最新章节
	nov.ChapterTitle = c.Find("td").Eq(1).Find("a").Text()

	// 获取小说简介
	//nov.Desc = c.Find(".result-game-item-desc").Text()

	// 获取章节链接地址
	chapterLink, _ := c.Find("td").First().Find("a").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}
	chapterLink = BIQUGE5_URL + chapterLink

	// 获取图片封面
	//nov.Cover, _ = c.Find(".result-game-item-pic-link-img").Attr("src")

	return &SnatchInfo{
		Source:     BIQUGE5_SOURCE,
		Url:        chapterLink,
		ChapterUrl: chapterLink,
		Nov:        nov,
		UseTime:    t2,
	}, nil
}

// 获取小说章节内容
func (this *Bqg5) GetChapter(rawurl string) (*SnatchInfo, error) {
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
		"一秒记住【笔♂趣→阁 WWW.BiQiuGe.Com】，精彩小说无弹窗免费阅读！<br><br>",
	}
	for _, v := range keywords {
		chap.Desc = strings.Replace(chap.Desc, v, "", -1)
	}

	// 正则过滤关键词
	keyexs := []string{
		`(?U)本文由(.*)首发`,
		`(?U)一秒记住(.*)免费阅读！<br><br>`,
		`(?U)一秒记住(.*)免费阅读`,
		`(?U)笔趣阁(.*)最新章节[!|！]<br><br>`,
		`(?U)笔趣阁(.*)最新章节[!|！]`,
	}

	for _, v := range keyexs {
		re, _ := regexp.Compile(v)
		chap.Desc = re.ReplaceAllString(chap.Desc, "")
	}

	// 获取上一页
	preUrl, _ := doc.Find(".bottem1 a").Eq(1).Attr("href")
	if preUrl == "" || !strings.Contains(preUrl, "html") {
		preUrl = ""
	} else {
		preUrl = BIQUGE5_URL + preUrl
	}

	// 获取下一页
	nextUrl, _ := doc.Find(".bottem1 a").Eq(3).Attr("href")
	if nextUrl == "" || !strings.Contains(nextUrl, "html") {
		nextUrl = ""
	} else {
		nextUrl = BIQUGE5_URL + nextUrl
	}

	return &SnatchInfo{
		Chap:    chap,
		Source:  BIQUGE5_SOURCE,
		UseTime: t2,
		NextUrl: nextUrl,
		PreUrl:  preUrl,
	}, nil
}

// 获取章节列表
func (this *Bqg5) GetChapters(rawurl string) ([]*SnatchInfo, error) {
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
		if j < 9 {
			j++
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
		chap.Link = BIQUGE5_URL + chapLink
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
func (this *Bqg5) Proxy(rawurl string) {
	this.proxy = rawurl
}
