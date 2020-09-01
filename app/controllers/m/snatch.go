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

package m

import (
	"encoding/json"

	"novel/app/services"
)

type SnatchController struct {
	BaseController
}

// 首页
func (this *SnatchController) Index() {
	url := this.GetString("url")
	source := this.GetString("source")
	if len(url) == 0 || len(source) == 0 {
		this.Msg("参数错误，无法访问")
	}

	// 获取小说信息
	info, err := services.SnatchService.GetNovel(source, url)
	if err != nil {
		this.Msg("获取小说失败")
	}
	info.Source = source
	info.Url = url

	// 获取章节列表
	chaps, err := services.SnatchService.GetChapters(source, info.ChapterUrl)
	if err != nil {
		this.Msg("获取小说章节列表失败")
	}

	// 获取最新章节
	this.Data["FirstChap"] = nil
	if len(chaps) > 0 {
		this.Data["FirstChap"] = chaps[len(chaps)-1:][0].Chap
	}
	jsonData, _ := json.Marshal(chaps)
	this.Data["Chaps"] = string(jsonData)
	this.Data["ChapNum"] = len(chaps)
	this.Data["Info"] = info
	this.Data["Title"] = info.Nov.Name + " - " + info.Nov.Author

	this.View("snatch/index.tpl")
}

// 详情页
func (this *SnatchController) Detail() {
	url := this.GetString("url")
	novLink := this.GetString("nov_url")
	source := this.GetString("source")
	name := this.GetString("name")
	if len(url) == 0 || len(source) == 0 || len(novLink) == 0 {
		this.Msg("参数错误，无法访问")
	}

	// 获取章节内容
	chap, err := services.SnatchService.GetChapter(source, url)
	if err != nil {
		this.Msg("获取小说章节内容失败")
	}

	this.Data["Source"] = source
	this.Data["Name"] = name
	this.Data["Link"] = novLink
	this.Data["Chap"] = chap.Chap
	this.Data["NextUrl"] = chap.NextUrl
	this.Data["PreUrl"] = chap.PreUrl
	this.Data["Title"] = chap.Chap.Title + " - " + name

	this.View("snatch/detail.tpl")
}
