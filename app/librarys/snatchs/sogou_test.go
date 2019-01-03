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

func TestSGIsBookUrl(t *testing.T) {
	snatch := NewSg()

	url := "https://yuedu.sogou.com/book/info/3C723491F7D348808D618950AF1F9634?"
	if !snatch.IsBookURL(url) {
		t.Fatal("小说简介页面匹配失败")
	}

	url = "https://yuedu.sogou.com/search?keyword=%E5%A4%AA%E5%AD%90%E5%A6%83%E5%8D%87%E8%81%8C"
	if snatch.IsBookURL(url) {
		t.Fatal("小说简介页面匹配失败")
	}

	url = "https://yuedu.sogou.com/book/view/4D1A6FDD7AEA6EA1C883124C50763281/3A81D5C7DD91C0744F8063244E2A564E?from=list&w=1500&"
	if snatch.IsBookURL(url) {
		t.Fatal("小说简介页面匹配失败")
	}
}

func TestSGIsCrawlerUrl(t *testing.T) {
	snatch := NewSg()

	url := "https://yuedu.sogou.com/book/view/4D1A6FDD7AEA6EA1C883124C50763281/3A81D5C7DD91C0744F8063244E2A564E?from=list&w=1500&"
	if snatch.IsCrawlerURL(url) {
		t.Fatal("爬虫URL匹配失败")
	}

	url = "https://yuedu.sogou.com/book/info/3C723491F7D348808D618950AF1F9634?"
	if snatch.IsCrawlerURL(url) {
		t.Fatal("爬虫匹配失败")
	}

	url = "https://yuedu.sogou.com/category/101"
	if !snatch.IsCrawlerURL(url) {
		t.Fatal("爬虫匹配失败")
	}
}
func TestSGGetNovel(t *testing.T) {
	snatch := NewSg()

	info, err := snatch.GetNovel("https://yuedu.sogou.com/book/info/FD434CC4AA149CB8B85B8A15F14207FD?w=1489&pos=1&")
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

	if !strings.Contains(nov.Desc, "败中崛起，在寂灭中复苏") {
		t.Fatal("获取小说内容错误", nov.Desc)
	}

	if nov.Author != "辰东" {
		t.Fatal("获取小说作者错误", nov.Author)
	}

	if nov.CateName != "奇幻玄幻" {
		t.Fatal("获取小说分类名称错误", nov.CateName)
	}

	if nov.CateId != 1 {
		t.Fatal("匹配小说分类ID错误", nov.CateId)
	}

	if nov.Cover != "http://img04.sogoucdn.com/app/a/10070003/69BBAEBB18ACAF160E0BE701A1FC50D8" {
		t.Fatal("匹配小说封面错误", nov.Cover)
	}
}

func TestSGFindNovel(t *testing.T) {
	sg := NewSg()
	info, err := sg.FindNovel("圣墟")
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

	if info.Url != "https://yuedu.sogou.com/book/info/FD434CC4AA149CB8B85B8A15F14207FD?w=1490&pos=1&" {
		t.Fatal("获取小说链接错误", info.Url)
	}

	if info.ChapterUrl != "https://yuedu.sogou.com/book/info/FD434CC4AA149CB8B85B8A15F14207FD?w=1490&pos=1&" {
		t.Fatal("获取小说章节链接错误", info.ChapterUrl)
	}
}
