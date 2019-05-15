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

package services

var (
	RoleService       *Role
	GroupService      *Group
	AdminService      *Admin
	AdminLogService   *AdminLog
	NovelService      *Novel
	CateService       *Cate
	ChapterService    *Chapter
	FeedbackService   *Feedback
	SnatchService     *Snatch
	BannerService     *Banner
	CrawlerService    *Crawler
	ProxyService      *Proxy
	ConfigService     *Config
	SearchService     *Search
	SearchLogService  *SearchLog
	SnatchRuleService *SnatchRule
)

func Init() {
	initServices()

	// 初始化采集
	initSnatch()
}

func initServices() {
	ConfigService = NewConfig()
	RoleService = NewRole()
	GroupService = NewGroup()
	AdminService = NewAdmin()
	AdminLogService = NewAdminLog()
	NovelService = NewNovel()
	CateService = NewCate()
	ChapterService = NewChapter()
	FeedbackService = NewFeedback()
	SnatchService = NewSnatch()
	BannerService = NewBanner()
	CrawlerService = NewCrawler()
	ProxyService = NewProxy()
	SnatchRuleService = NewSnatchRule()
}
