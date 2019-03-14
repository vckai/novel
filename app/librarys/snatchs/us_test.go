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

func TestUSGetNovel(t *testing.T) {
	us := NewUs()

	us.Proxy("http://vxvfoaaib:tL0ttIGxn8egZ@ip4.hahado.cn:35044")

	info, err := us.GetNovel("https://www.x23us.com/book/66656")
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

func TestUSFindNovel(t *testing.T) {
	us := NewUs()
	info, err := us.FindNovel("圣墟")
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

func TestUSFindNovel2(t *testing.T) {
	us := NewUs()
	info, err := us.FindNovel("洪荒之逆天妖帝")
	if err != nil {
		t.Fatal(err.Error())
	}

	nov := info.Nov

	if nov == nil {
		t.Fatal("获取小说失败")
	}

	if nov.Name != "洪荒之逆天妖帝" {
		t.Fatal("获取小说标题错误", nov.Name)
	}
}

func TestUSGetChapter(t *testing.T) {
	us := NewUs()

	info, err := us.GetChapter("https://www.x23us.com/html/67/67056/27840263.html")
	if err != nil {
		t.Fatal(err.Error())
	}

	chap := info.Chap

	if chap.Title != "第二章 高手" {
		t.Fatal("获取章节标题错误", chap.Title)
	}

	if !strings.Contains(chap.Desc, "的官道上，一辆华贵的") {
		t.Fatal("获取章节内容错误", chap.Desc)
	}

	if info.PreUrl != "https://www.x23us.com/html/67/67056/27840261.html" {
		t.Fatal("获取上一页链接错误", info.PreUrl)
	}

	if info.NextUrl != "https://www.x23us.com/html/67/67056/27840265.html" {
		t.Fatal("获取下一页链接错误", info.NextUrl)
	}
}

func TestUSGetChapters(t *testing.T) {
	us := NewUs()

	links, err := us.GetChapters("https://www.x23us.com/html/67/67056/")
	if err != nil {
		t.Fatal("获取章节列表失败", err.Error())
	}
	if len(links) == 0 {
		t.Fatal("获取章节列表失败")
	}

	if links[0].Chap.Link != "https://www.x23us.com/html/67/67056/27840261.html" {
		t.Fatal("获取小说章节内容链接错误", links[0].Chap.Link)
	}
}
