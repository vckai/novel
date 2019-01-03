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
)

func TestXSIsBookUrl(t *testing.T) {
	xs := NewXs()

	url := "http://www.31xs.org/8/8984/"
	if !xs.IsBookURL(url) {
		t.Fatal("小说简介页面匹配失败")
	}

	url = "http://www.31xs.org/8/8984/7223195.html"
	if xs.IsBookURL(url) {
		t.Fatal("小说简介页面匹配失败")
	}

	url = "http://www.31xs.org/list/"
	if xs.IsBookURL(url) {
		t.Fatal("小说简介页面匹配失败")
	}

	url = "http://www.31xs.org/list33/"
	if xs.IsBookURL(url) {
		t.Fatal("小说简介页面匹配失败")
	}
}

func TestXSIsCrawlerUrl(t *testing.T) {
	xs := NewXs()
	url := "http://www.31xs.org/8/8984/"
	if xs.IsCrawlerURL(url) {
		t.Fatal("小说爬虫页面匹配失败")
	}

	url = "http://www.31xs.org/8/8984/7223195.html"
	if xs.IsCrawlerURL(url) {
		t.Fatal("小说爬虫页面匹配失败")
	}

	url = "http://www.31xs.org/list222/"
	if xs.IsCrawlerURL(url) {
		t.Fatal("小说爬虫页面匹配失败")
	}

	url = "http://www.31xs.org/list/"
	if !xs.IsCrawlerURL(url) {
		t.Fatal("小说爬虫页面匹配失败")
	}
}

func TestXSGetNovel(t *testing.T) {
	xs := NewXs()

	url := "http://www.31xs.org/1/1886/"
	info, err := xs.GetNovel(url)
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

	if !strings.Contains(nov.Desc, "在破败中崛起，在寂灭") {
		t.Fatal("获取小说内容错误", nov.Desc)
	}

	if nov.Author != "辰东" {
		t.Fatal("获取小说作者错误", nov.Author)
	}

	if nov.CateName != "玄幻" {
		t.Fatal("获取小说分类名称错误", nov.CateName)
	}

	if nov.CateId != 1 {
		t.Fatal("匹配小说分类ID错误", nov.CateId)
	}

	if nov.Cover != "http://www.31xs.net/img/1/1886/1886s.jpg" {
		t.Fatal("获取小说封面错误", nov.Cover)
	}

	if info.ChapterUrl != url {
		t.Fatal("获取小说章节链接错误", info.ChapterUrl)
	}
}

func TestXSFindNovel(t *testing.T) {
	xs := NewXs()
	info, err := xs.FindNovel("圣墟")
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

	//if !strings.Contains(nov.Desc, "在寂灭中复苏") {
	//	t.Fatal("获取小说内容错误", nov.Desc)
	//}

	if nov.Author != "辰东" {
		t.Fatal("获取小说作者错误", nov.Author)
	}

	if info.Url != "http://www.31xs.org/1/1886/" {
		t.Fatal("获取小说链接错误", info.Url)
	}

	if info.ChapterUrl != "http://www.31xs.org/1/1886/" {
		t.Fatal("获取小说章节链接错误", info.ChapterUrl)
	}
}

func TestXSGetChapter(t *testing.T) {
	xs := NewXs()

	info, err := xs.GetChapter("http://www.31xs.org/1/1886/4192618.html")
	if err != nil {
		t.Fatal(err.Error())
	}
	chap := info.Chap

	if chap.Title != "第一章 沙漠中的彼岸花" {
		t.Fatal("获取章节标题错误")
	}

	if !strings.Contains(chap.Desc, "的大漠，空旷而高远，壮阔") {
		t.Fatal("获取章节内容错误")
	}
}

func TestXSGetChapters(t *testing.T) {
	xs := NewXs()

	links, err := xs.GetChapters("http://www.31xs.org/1/1886/")
	if err != nil {
		t.Fatal("获取章节列表失败", err.Error())
	}
	if len(links) == 0 {
		t.Fatal("获取章节列表失败")
	}

	if links[0].Chap.Link != "http://www.31xs.net/1/1886/4192618.html" {
		t.Fatal("获取小说链接错误", links[0].Chap.Link)
	}
}
