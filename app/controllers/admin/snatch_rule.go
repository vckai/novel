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

package admin

import (
	"io"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/axgle/mahonia"

	"github.com/vckai/novel/app/librarys/snatchs"
	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services"
	"github.com/vckai/novel/app/utils"
	"github.com/vckai/novel/app/utils/log"
)

type SnatchRuleController struct {
	BaseController
}

// 采集规则列表
func (this *SnatchRuleController) Index() {
	rules := services.SnatchRuleService.GetAll()

	this.Data["Rules"] = rules
	this.Data["Count"] = len(rules)
	this.View("snatch_rule/index.tpl")
}

// 添加采集规则页面
func (this *SnatchRuleController) Add() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	// 获取分类
	cates := services.CateService.GetAll()

	// 分类映射
	var cateMaps []*models.CateMap
	for _, c := range cates {
		cateMaps = append(cateMaps, &models.CateMap{Id: c.Id})
	}

	sr := models.NewSnatchRule()
	sr.CateMaps = cateMaps

	this.Data["Cates"] = cates
	this.Data["Rule"] = sr
	this.Data["IsAdd"] = true
	this.Data["PostUrl"] = this.URLFor("admin.SnatchRuleController.Add")
	this.View("snatch_rule/add.tpl")
}

// 编辑采集规则页面
func (this *SnatchRuleController) Edit() {
	// post 数据提交
	if this.IsAjax() {
		this.save()
		return
	}

	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	rule := services.SnatchRuleService.Get(id)

	if rule == nil {
		this.Msg("该采集规则不存在或者已被删除")
	}

	// 分类映射
	cates := services.CateService.GetAll()
	if len(rule.CateMaps) == 0 {
		for _, c := range cates {
			rule.CateMaps = append(rule.CateMaps, &models.CateMap{Id: c.Id})
		}
	}

	this.Data["Rule"] = rule
	this.Data["IsAdd"] = false
	this.Data["Cates"] = cates
	this.Data["PostUrl"] = this.URLFor("admin.SnatchRuleController.Edit")
	this.View("snatch_rule/add.tpl")
}

// 模拟goquery获取内容
func (this *SnatchRuleController) Goquery() {
	// ajax请求
	if this.IsAjax() {
		rawurl := this.GetString("url")
		selector := this.GetString("selector")
		charset := this.GetString("charset", "UTF-8")
		if len(rawurl) == 0 || len(selector) == 0 {
			this.OutJson(1001, "参数错误，无法访问")
		}

		resp, err := utils.HttpGet(rawurl, nil, services.ProxyService.Get())
		if err != nil {
			this.OutJson(1002, "请求失败："+err.Error())
		}

		var body io.Reader
		body = resp.Body

		// 编码转换
		enc := mahonia.NewDecoder(charset)
		body = enc.NewReader(body)

		doc, err := goquery.NewDocumentFromReader(body)
		if err != nil {
			this.OutJson(1003, "转换query失败："+err.Error())
		}

		html, err := doc.Find(selector).Html()
		if err != nil {
			this.OutJson(1004, "获取选取内容失败："+err.Error())
		}

		this.OutJson(0, "获取成功", html)
		return
	}

	this.View("snatch_rule/goquery.tpl")
}

// 采集规则测试
func (this *SnatchRuleController) Test() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	rule := services.SnatchRuleService.Get(id)

	if rule == nil {
		this.OutJson(1002, "该采集规则不存在或者已被删除")
	}

	if len(rule.Test.BookURL) == 0 {
		this.OutJson(1002, "测试数据中没有小说简介URL")
	}

	c := snatchs.NewSnatch(services.ProxyService.Get)

	// 测试验证小说简介URL
	if !c.IsBookURL(rule, rule.Test.BookURL) {
		this.OutJson(1003, "小说URL正则验证失败")
	}

	// 获取测试小说
	s, err := c.GetNovel(rule, rule.Test.BookURL)

	if err != nil {
		this.OutJson(1003, "获取简介页面错误："+err.Error())
	}

	if s.Nov.Name != rule.Test.BookTitle {
		this.OutJson(1004, "简介页面小说名称比对失败："+s.Nov.Name)
	}

	if s.Nov.Author != rule.Test.BookAuthor {
		this.OutJson(1005, "简介页面小说作者比对失败："+s.Nov.Author)
	}

	if s.Nov.CateName != rule.Test.BookCate {
		this.OutJson(1006, "简介页面小说分类比对失败："+s.Nov.CateName)
	}

	if !strings.Contains(s.Nov.Desc, rule.Test.BookDesc) {
		this.OutJson(1007, "简介页面小说简介比对失败："+s.Nov.Desc)
	}

	if s.Nov.Cover != rule.Test.BookCover {
		this.OutJson(1008, "简介页面小说缩略图比对失败："+s.Nov.Cover)
	}

	if s.ChapterUrl != rule.Test.BookChapterURL {
		this.OutJson(1009, "简介页面小说章节URL比对失败："+s.ChapterUrl)
	}

	// 获取测试章节列表
	links, err := c.GetChapters(rule, rule.Test.ChapterURL)
	if err != nil {
		this.OutJson(1010, "章节列表获取失败："+err.Error())
	}
	if len(links) == 0 {
		this.OutJson(1011, "章节列表获取为空")
	}

	if links[0].Chap.Link != rule.Test.ChapterCatalogURL {
		this.OutJson(1012, "章节列表第一章节URL错误："+links[0].Chap.Link)
	}

	if links[0].Chap.Title != rule.Test.ChapterCatalogTitle {
		this.OutJson(1013, "章节列表第一章节标题错误"+links[0].Chap.Title)
	}

	// 测试章节内容
	info, err := c.GetChapter(rule, rule.Test.InfoURL)
	if err != nil {
		this.OutJson(1014, "章节内容页获取失败："+err.Error())
	}

	if info.Chap.Title != rule.Test.InfoTitle {
		this.OutJson(1015, "章节内容页标题比对失败："+s.Chap.Title)
	}

	if !strings.Contains(info.Chap.Desc, rule.Test.InfoDesc) {
		this.OutJson(1016, "章节内容页章节内容比对失败："+info.Chap.Desc)
	}

	if info.PreUrl != rule.Test.InfoPrePageURL {
		this.OutJson(1017, "章节内容页上一页URL对比失败："+info.PreUrl)
	}

	if info.NextUrl != rule.Test.InfoNextPageURL {
		this.OutJson(1018, "章节内容页下一页URL对比失败："+info.NextUrl)
	}

	// 搜索小说
	find, err := c.FindNovel(rule, rule.Test.FindBookKw)
	if err != nil {
		this.OutJson(1019, "搜索小说失败："+err.Error())
	}

	if find.Url != rule.Test.FindBookURL {
		this.OutJson(1020, "章节内容页下一页URL对比失败："+find.Url)
	}

	this.OutJson(0, "测试成功")
}

// 删除采集规则
func (this *SnatchRuleController) Delete() {
	id, _ := this.GetUint32("id")
	name := this.GetString("name", "")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	err := services.SnatchRuleService.Delete(id)
	if err != nil {
		this.OutJson(1001, "删除采集规则失败")
	}

	// 添加操作日记
	this.AddLog(3201, "删除", name, id)
	this.OutJson(0, "已删除！")
}

// 批量删除操作采集规则
func (this *SnatchRuleController) DeleteBatch() {
	ids := this.GetStrings("ids[]")
	if len(ids) == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	err := services.SnatchRuleService.DeleteBatch(ids)
	if err != nil {
		this.OutJson(1002, "批量删除操作采集规则失败")
	}

	// 添加操作日记
	this.AddLog(3202, strings.Join(ids, ","))

	this.OutJson(0, "已删除！")
}

// 启用/禁用规则
func (this *SnatchRuleController) UpState() {
	name := this.GetString("name")
	id, _ := this.GetUint32("id")
	if id == 0 {
		this.OutJson(1001, "参数错误，无法访问")
	}
	state, _ := this.GetUint8("state")

	err := services.SnatchRuleService.UpState(id, state)
	if err != nil {
		this.OutJson(1002, "操作失败")
	}

	if state == 1 {
		this.AddLog(3201, "启用", name, id)
	} else {
		this.AddLog(3201, "禁用", name, id)
	}

	this.OutJson(0, "操作成功")
}

// 保存数据
// 提供修改/新增处理
func (this *SnatchRuleController) save() {
	id, _ := this.GetUint32("id")

	mtitle := "添加"
	r := models.NewSnatchRule()
	// 编辑
	if id > 0 {
		r = services.SnatchRuleService.Get(id)
		if r == nil {
			this.OutJson(1001, "该采集规则不存在或者已被删除")
		}

		mtitle = "修改"
	}

	ocate := make([]uint32, 0)
	cate := make([]string, 0)
	this.Ctx.Input.Bind(&cate, "cate")
	this.Ctx.Input.Bind(&ocate, "ocate")

	// 分类映射
	r.CateMaps = make([]*models.CateMap, 0, len(cate))
	for k, v := range cate {
		if len(v) != 0 {
			cateMap := &models.CateMap{
				Id:   ocate[k],
				Name: v,
			}

			r.CateMaps = append(r.CateMaps, cateMap)
		}
	}

	// 采集规则
	this.Ctx.Input.Bind(&r.Rules, "rule")

	// 采集规则
	this.Ctx.Input.Bind(&r.Test, "test")

	// 入库参数
	r.Name = this.GetString("name")
	r.Code = this.GetString("code")
	r.State, _ = this.GetUint8("state")
	r.Url = this.GetString("url")
	r.Charset = this.GetString("charset")
	r.IsUpdate, _ = this.GetUint8("is_update")

	err := services.SnatchRuleService.Save(r)
	if err != nil {
		log.Error(mtitle, "采集规则失败：", err.Error())
		this.OutJson(1003, mtitle+"失败："+err.Error())
	}
	// 添加操作日记
	this.AddLog(3201, mtitle, r.Name, r.Id)

	this.OutJson(0, mtitle+"成功")
}
