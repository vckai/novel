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

	"github.com/vckai/novel/app/models"
)

type Sg struct {
	proxy string
}

const (
	SG_NAME       = "搜狗小说"
	SG_SOURCE     = "sogou"
	SG_URL        = "https://yuedu.sogou.com"
	SG_SEARCH_URL = SG_URL + "/search?keyword=%s"
)

var cateSGMap map[string]uint32 = map[string]uint32{
	"都市生活": 3,
	"奇幻玄幻": 1,
	"武侠修仙": 2,
	"军史谋略": 4,
	"游戏动漫": 6,
	"总裁高干": 11,
	"现代言情": 3,
	"古代言情": 10,
	"魔幻情缘": 7,
	"穿越架空": 13,
}

func init() {
	Register(SG_SOURCE, &Provide{
		Title:  SG_NAME,
		Client: NewSg(),
	})
}

func NewSg() *Sg {
	return &Sg{
		proxy: "",
	}
}

// 获取小说网站URL
func (this *Sg) GetURL() string {
	return SG_URL
}

// 是否小说简介页面
func (this *Sg) IsBookURL(rawurl string) bool {
	return strings.Contains(rawurl, SG_URL+"/book/info/")
}

// 是否小说是否爬虫页面
func (this *Sg) IsCrawlerURL(rawurl string) bool {
	return strings.Contains(rawurl, SG_URL+"/category")
}

// 获取小说信息
func (this *Sg) GetNovel(rawurl string) (*SnatchInfo, error) {
	rawurl = strings.TrimRight(rawurl, "/")
	if len(rawurl) == 0 {
		return nil, ErrNotUrl
	}

	t1 := time.Now()
	doc, err := NewHtml(rawurl, this.proxy, "utf-8")
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	// 获取封面图片
	nov.Cover, _ = doc.Find(".detail-thumb-box").Find("img").Attr("src")
	if nov.Cover == "" {
		return nil, ErrNotNov
	}

	// 获取小说标题
	nov.Name = doc.Find(".detail-tit").Text()
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说简介
	nov.Desc = doc.Find("#info_long_txt").Text()

	// 获取小说作者
	nov.Author = doc.Find(".detail-profile").Find("td").First().Text()
	re := regexp.MustCompile(`(?U)作(.*)者[：|:]`)
	nov.Author = re.ReplaceAllString(nov.Author, "")

	// 获取小说分类
	nov.CateName = doc.Find(".detail-profile").Find("td").Eq(1).Text()
	re = regexp.MustCompile(`(?U)类(.*)型[：|:]`)
	nov.CateName = re.ReplaceAllString(nov.CateName, "")

	// 获取分类ID
	nov.CateId = DEF_CATE_ID
	if id, ok := cateSGMap[nov.CateName]; ok {
		nov.CateId = id
	}

	return &SnatchInfo{
		Url:        "",
		ChapterUrl: "",
		Source:     SG_SOURCE,
		Nov:        nov,
		UseTime:    t2,
		IsUpdate:   true,
	}, nil
}

// 搜索小说
func (this *Sg) FindNovel(keyword string) (*SnatchInfo, error) {
	t1 := time.Now()
	doc, err := NewHtml(fmt.Sprintf(SG_SEARCH_URL, keyword), this.proxy, "utf-8")
	if err != nil {
		return nil, err
	}
	t2 := time.Since(t1)

	nov := models.NewNovel()

	c := doc.Find(".sort_list").Find("li").First()

	// 获取小说标题
	nov.Name = c.Find(".sort_list_tit").Text()
	if len(nov.Name) == 0 {
		return nil, ErrNotNovName
	}

	// 获取小说作者
	nov.Author = c.Find(".sort_info").Text()
	if len(nov.Author) == 0 {
		return nil, ErrNotNovAuthor
	}
	arr := strings.Split(nov.Author, "|")
	nov.Author = strings.TrimSpace(strings.Replace(arr[0], "著", "", -1))

	// 获取小说最新章节
	nov.ChapterTitle = c.Find(".result-game-item-info .result-game-item-info-tag").Eq(3).Find("a").Text()

	// 获取小说简介
	nov.Desc = c.Find(".sort_info2").Text()

	// 获取小说链接地址
	chapterLink, _ := c.Find(".sort_list_tit a").Attr("href")
	if len(chapterLink) == 0 {
		return nil, ErrNotNovLink
	}

	// 小说URL地址
	chapterLink = SG_URL + chapterLink

	// 获取图片封面
	nov.Cover, _ = c.Find(".sort_list_thumb img").Attr("src")

	return &SnatchInfo{
		Url:        chapterLink,
		ChapterUrl: chapterLink,
		Source:     SG_SOURCE,
		Nov:        nov,
		UseTime:    t2,
		IsUpdate:   true,
	}, nil
}

// 获取小说章节内容
func (this *Sg) GetChapter(rawurl string) (*SnatchInfo, error) {
	return nil, ErrNotNov
}

// 获取章节内容
func (this *Sg) GetChapters(rawurl string) ([]*SnatchInfo, error) {
	return nil, ErrNotNov
}

// 设置代理
func (this *Sg) Proxy(rawurl string) {
	this.proxy = rawurl
}
