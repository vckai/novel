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
	"strings"
	"testing"

	"novel/app/models"
)

var providerTest *models.SnatchRule = &models.SnatchRule{
	Id:      1,
	Name:    "顶点小说",
	Code:    "x23us",
	Url:     "https://www.x23us.com/",
	Charset: "GB18030",
	CateMaps: []*models.CateMap{
		&models.CateMap{
			Id:   1,
			Name: "玄幻魔法",
		},
	},
	Rules: &models.Rule{
		IsBookURL:    `^https://www.x23us.com/book/([\d]+)$`,
		IsCrawlerURL: `^https://www.x23us.com/class/([\d]+)_([\d]+).html`,

		// 小说简介页面采集规则
		BookTitleSelector:      "#content dd:nth-of-type(1) h1",
		BookTitleFilter:        "全文阅读 | 哈哈",
		BookAuthorSelector:     "#content dd:nth-of-type(2) div:nth-of-type(2) table tr:nth-of-type(1) td:nth-of-type(2)",
		BookAuthorFilter:       "作者\n[:|：]",
		BookCateSelector:       "#content dd:nth-of-type(2) div:nth-of-type(2) table tr:nth-of-type(1) td:nth-of-type(1) a",
		BookCateFilter:         "",
		BookDescSelector:       "#content dd:nth-of-type(4) p:nth-of-type(2)",
		BookDescFilter:         "",
		BookCoverSelector:      "#content dd:nth-of-type(2) div:nth-of-type(1) a img",
		BookNoCover:            "nocover.jpg",
		BookChapterURLSelector: "#content dd:nth-of-type(2) div:nth-of-type(1) a",

		// 章节目录采集规则
		ChapterCatalogSelector: ".bdsub dl dd:nth-of-type(3) a",
		ChapterAbandonNum:      0,

		// 详情页面采集规则
		InfoTitleSelector:    ".bdsub dl dd h1",
		InfoTitleFilter:      "",
		InfoDescSelector:     "#contents",
		InfoDescFilter:       "顶 点 小 说 Ｘ ２３ Ｕ Ｓ．Ｃ ＯＭ\n顶点小说 ２３ＵＳ．ＣＯＭ更新最快\n顶点小说(.*)更新最快\n",
		InfoPrePageSelector:  "#footlink a:nth-of-type(1)",
		InfoNextPageSelector: "#footlink a:nth-of-type(3)",

		// 搜索页面采集规则
		FindURL:             "https://www.x23us.com/modules/article/search.php?searchtype=keywords&searchkey=",
		FindBookURLSelector: "#content tr:nth-of-type(2) td:nth-of-type(1) a",
	},
}

var proxyFunc func() string = func() string {
	return ""
}

func TestFindNovel(t *testing.T) {
	s := NewSnatch(proxyFunc)
	info, err := s.FindNovel(providerTest, "圣墟")
	if err != nil {
		t.Fatal(err.Error())
	}

	nov := info.Nov

	if nov == nil {
		t.Fatal("获取小说失败")
	}

	if nov.Name != "圣墟" {
		t.Fatal("获取小说标题错误", nov.Name)
	}

	if !strings.Contains(nov.Desc, "在寂灭中复苏") {
		t.Fatal("获取小说内容错误", nov.Desc)
	}

	if nov.Author != "辰东" {
		t.Fatal("获取小说作者错误", nov.Author)
	}

	if info.Url != "https://www.x23us.com/book/66656" {
		t.Fatal("获取小说链接错误", info.Url)
	}

	if info.ChapterUrl != "https://www.x23us.com/html/66/66656/" {
		t.Fatal("获取小说章节链接错误", info.ChapterUrl)
	}
}

func TestIsBookURL(t *testing.T) {
	s := NewSnatch(proxyFunc)

	url := "https://www.x23us.com/book/66656"
	if !s.IsBookURL(providerTest, url) {
		t.Fatal("小说简介页面匹配错误", url)
	}

	url = "https://www.x23us.com/html/66/66656/"
	if s.IsBookURL(providerTest, url) {
		t.Fatal("小说简介页面匹配错误", url)
	}

	url = "https://www.x23us.com/html/66/66656/27429415.html"
	if s.IsBookURL(providerTest, url) {
		t.Fatal("小说简介页面匹配错误", url)
	}

	url = "https://www.x23us.com/"
	if s.IsBookURL(providerTest, url) {
		t.Fatal("小说简介页面匹配错误", url)
	}
}

func TestIsCrawlerURL(t *testing.T) {
	s := NewSnatch(proxyFunc)

	url := "https://www.x23us.com/class/1_1.html"
	if !s.IsCrawlerURL(providerTest, url) {
		t.Fatal("爬虫匹配错误", url)
	}

	url = "https://www.23txt.com/files/article/html/37/37532/12224612.html"
	if s.IsCrawlerURL(providerTest, url) {
		t.Fatal("爬虫URL匹配错误", url)
	}

	url = "https://www.x23us.com/html/66/66656/27429415.html"
	if s.IsCrawlerURL(providerTest, url) {
		t.Fatal("爬虫匹配错误", url)
	}

	url = "https://www.x23us.com/"
	if s.IsCrawlerURL(providerTest, url) {
		t.Fatal("爬虫匹配错误", url)
	}
}

func TestGetNovel(t *testing.T) {
	s := NewSnatch(proxyFunc)

	info, err := s.GetNovel(providerTest, "https://www.x23us.com/book/66656")
	if err != nil {
		t.Fatal(err.Error())
	}

	nov := info.Nov

	if nov == nil {
		t.Fatal("获取小说失败")
	}

	if nov.Name != "圣墟" {
		t.Fatal("获取小说标题错误", nov.Name)
	}

	if !strings.Contains(nov.Desc, "中崛起，在寂灭中") {
		t.Fatal("获取小说内容错误", nov.Desc)
	}

	if nov.Author != "辰东" {
		t.Fatal("获取小说作者错误", nov.Author)
	}

	if nov.CateName != "玄幻魔法" {
		t.Fatal("获取小说分类名称错误", nov.CateName)
	}

	if nov.CateId != 1 {
		t.Fatal("匹配小说分类ID错误", nov.CateId)
	}

	if nov.Cover != "https://www.x23us.com/files/article/image/66/66656/66656s.jpg" {
		t.Fatal("获取小说封面错误", nov.Cover)
	}

	if info.ChapterUrl != "https://www.x23us.com/html/66/66656/" {
		t.Fatal("获取小说章节链接错误", info.ChapterUrl)
	}
}

func TestFindNove2(t *testing.T) {
	s := NewSnatch(proxyFunc)
	info, err := s.FindNovel(providerTest, "洪荒")
	if err != nil {
		t.Fatal(err.Error())
	}

	nov := info.Nov
	return

	if nov == nil {
		t.Fatal("获取小说失败")
	}

	if nov.Name != "我是洪荒第一人" {
		t.Fatal("获取小说标题错误", nov.Name)
	}
}

func TestGetChapter(t *testing.T) {
	s := NewSnatch(proxyFunc)

	info, err := s.GetChapter(providerTest, "https://www.x23us.com/html/66/66656/29798305.html")
	if err != nil {
		t.Fatal(err.Error())
	}

	chap := info.Chap

	if chap.Title != "第二章 后文明时代" {
		t.Fatal("获取章节标题错误", chap.Title)
	}

	if !strings.Contains(chap.Desc, "疑似受惊，差点闯出栅栏") {
		t.Fatal("获取章节内容错误", chap.Desc)
	}

	if info.PreUrl != "https://www.x23us.com/html/66/66656/27429411.html" {
		t.Fatal("获取上一页链接错误", info.PreUrl)
	}

	if info.NextUrl != "https://www.x23us.com/html/66/66656/27429412.html" {
		t.Fatal("获取下一页链接错误", info.NextUrl)
	}
}

func TestGetChapters(t *testing.T) {
	s := NewSnatch(proxyFunc)

	links, err := s.GetChapters(providerTest, "https://www.x23us.com/html/66/66656/")
	if err != nil {
		t.Fatal("获取章节列表失败", err.Error())
	}
	if len(links) == 0 {
		t.Fatal("获取章节列表失败")
	}

	if links[0].Chap.Link != "https://www.x23us.com/html/66/66656/27429411.html" {
		t.Fatal("获取小说章节内容链接错误", links[0].Chap.Link)
	}

	if links[0].Chap.Title != "第一章 沙漠中的彼岸花" {
		t.Fatal("获取小说章节内容链接错误", links[0].Chap.Title)
	}
}
