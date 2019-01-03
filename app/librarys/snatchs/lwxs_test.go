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

func TestLWXSGetNovel(t *testing.T) {
	lw := NewLwxs()

	info, err := lw.GetNovel("http://www.lewendu8.com/book/42121/index.html")
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

	if !strings.Contains(nov.Desc, "一缕幽雾又一次临近") {
		t.Fatal("获取小说内容错误", nov.Desc)
	}

	if strings.Contains(nov.Desc, "lewendu8") {
		t.Fatal("获取小说内容错误", nov.Desc)
	}

	if nov.Author != "辰东" {
		t.Fatal("获取小说作者错误", nov.Author)
	}

	if nov.CateName != "科幻游戏" {
		t.Fatal("获取小说类型错误", nov.CateName)
	}

	if nov.CateId != 6 {
		t.Fatal("获取小说类型ID错误", nov.CateId)
	}

	if nov.Cover != "http://www.lewendu8.com/files/article/image/42/42121/42121s.jpg" {
		t.Fatal("获取小说封面错误", nov.Cover)
	}

	if info.ChapterUrl != "http://www.lewendu8.com/books/42/42121/" {
		t.Fatal("获取小说章节链接错误", info.ChapterUrl)
	}
}

func TestLWXSFindNovel(t *testing.T) {
	lw := NewLwxs()
	info, err := lw.FindNovel("圣墟")
	if err != nil {
		t.Fatal(err.Error())
	}

	nov := info.Nov

	if nov == nil {
		t.Fatal("获取小说失败")
	}

	if nov.Name != "圣墟" {
		t.Fatal("获取小说标题错误")
	}

	if !strings.Contains(nov.Desc, "在寂灭中复苏") {
		t.Fatal("获取小说内容错误")
	}

	if nov.Author != "辰东" {
		t.Fatal("获取小说作者错误")
	}

	if info.Url != "http://www.lewendu8.com/book/42121/index.html" {
		t.Fatal("获取小说链接错误", info.Url)
	}

	if info.ChapterUrl != "http://www.lewendu8.com/books/42/42121/" {
		t.Fatal("获取小说章节链接错误", info.ChapterUrl)
	}
}

func TestLWXSGetChapter(t *testing.T) {
	lw := NewLwxs()

	info, err := lw.GetChapter("http://www.lewendu8.com/books/42/42121/10776604.html")
	if err != nil {
		t.Fatal(err.Error())
	}

	chap := info.Chap

	if chap.Title != "第一章 沙漠中的彼岸花" {
		t.Fatal("获取章节标题错误", chap.Title)
	}

	if !strings.Contains(chap.Desc, "一望无垠的大漠") {
		t.Fatal("获取章节内容错误", chap.Desc)
	}
}

func TestLWXSGetChapters(t *testing.T) {
	lw := NewLwxs()

	links, err := lw.GetChapters("http://www.lewendu8.com/books/42/42121/")
	if err != nil {
		t.Fatal("获取章节列表失败", err.Error())
	}

	if len(links) == 0 {
		t.Fatal("获取章节列表失败")
	}

	if links[0].Chap.Link != "http://www.lewendu8.com/books/42/42121/10776604.html" {
		t.Fatal("获取小说链接错误", links[0].Chap.Link)
	}
}
