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
	"bytes"
	"context"
	"encoding/json"
	"io"
	"strings"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/axgle/mahonia"

	"novel/app/controllers"
	xhttp "novel/app/librarys/net/http"
	"novel/app/models"
	"novel/app/services"
	"novel/app/services/snatchs"
	"novel/app/utils/log"
)

type SnatchRuleController struct {
	BaseController
}

// 导出采集规则配置模型
type ExportSnatchRule struct {
	Name     string                 `json:"name"`
	Code     string                 `json:"code"`
	Url      string                 `json:"url"`
	State    uint8                  `json:"state"`
	IsUpdate uint8                  `json:"is_update"`
	Charset  string                 `json:"charset"`
	Test     *models.SnatchTestData `json:"test"`
	Rules    *models.Rule           `json:"rules"`
	CateMaps []*models.CateMap      `json:"cate_maps"`
}

// 采集规则列表
func (this *SnatchRuleController) Index() {
	rules := services.SnatchRuleService.GetAll(&models.ArgsListRule{})

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
	this.Data["PostUrl"] = controllers.URLFor("admin.SnatchRuleController.Add")
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
	this.Data["PostUrl"] = controllers.URLFor("admin.SnatchRuleController.Edit")
	this.View("snatch_rule/add.tpl")
}

// 模拟goquery获取内容
func (this *SnatchRuleController) Goquery() {
	// ajax请求
	if this.IsAjax() {
		rawurl := this.GetString("url")
		selector := this.GetString("selector")
		attr := this.GetString("attr", "")
		charset := this.GetString("charset", "UTF-8")
		if len(rawurl) == 0 || len(selector) == 0 {
			this.OutJson(1001, "参数错误，无法访问")
		}

		c := xhttp.NewClient(
			&xhttp.ClientConfig{
				Timeout:   10 * time.Second,
				Dial:      10 * time.Second,
				KeepAlive: 60 * time.Second,
				ProxyURL:  services.ProxyService.Get(),
			})

		res, _, err := c.Get(context.TODO(), rawurl, nil)
		if err != nil {
			this.OutJson(1002, "请求失败："+err.Error())
		}

		var body io.Reader

		body = bytes.NewReader(res)

		// 编码转换
		enc := mahonia.NewDecoder(charset)
		body = enc.NewReader(body)

		doc, err := goquery.NewDocumentFromReader(body)
		if err != nil {
			this.OutJson(1003, "转换query失败："+err.Error())
		}

		html := ""
		if len(attr) > 0 {
			html = doc.Find(selector).AttrOr(attr, "")
		} else {
			html, err = doc.Find(selector).Html()
			if err != nil {
				this.OutJson(1004, "获取选取内容失败："+err.Error())
			}
		}
		snatch := snatchs.NewSnatch(services.ProxyService.Get)
		html = snatch.Filter("", html)

		this.OutJson(0, "获取成功", html)
		return
	}

	this.View("snatch_rule/goquery.tpl")
}

type TestResult struct {
	Name    string
	Rule    string
	UseTime time.Duration
	Attr    string
	Data    string
	GetData string
	Ret     bool
}

// 采集规则测试
func (this *SnatchRuleController) Test() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.Msg("参数错误，无法访问")
	}

	rule := services.SnatchRuleService.Get(id)

	if rule == nil {
		this.Msg("该采集规则不存在或者已被删除")
	}

	if len(rule.Test.BookURL) == 0 {
		this.Msg("测试数据中没有小说简介URL，无法进行测试对比")
	}

	results := make([]TestResult, 0)

	c := snatchs.NewSnatch(services.ProxyService.Get)

	// 测试验证小说简介URL
	results = append(results, TestResult{
		Name: "小说简介URL验证",
		Rule: rule.Rules.IsBookURL,
		Data: rule.Test.BookURL,
		Ret:  c.IsBookURL(rule, rule.Test.BookURL),
	})

	// 获取测试小说
	nov, err := c.GetNovel(rule, rule.Test.BookURL)

	errMsg := ""
	useTime := time.Duration(0)
	if err != nil {
		errMsg = err.Error()
	} else {
		useTime = nov.UseTime
	}

	results = append(results, TestResult{
		Name:    "小说简介获取",
		UseTime: useTime,
		Rule:    rule.Rules.IsBookURL,
		Data:    rule.Test.BookURL,
		GetData: errMsg,
		Ret:     err == nil,
	})

	if err == nil {
		// 小说名对比
		results = append(results, TestResult{
			Name:    "简介页面小说名称",
			Rule:    rule.Rules.BookTitleSelector,
			Attr:    rule.Rules.BookTitleAttr,
			Data:    rule.Test.BookTitle,
			GetData: nov.Nov.Name,
			Ret:     nov.Nov.Name == rule.Test.BookTitle,
		})

		// 作者对比
		results = append(results, TestResult{
			Name:    "简介页面小说作者",
			Rule:    rule.Rules.BookAuthorSelector,
			Attr:    rule.Rules.BookAuthorAttr,
			Data:    rule.Test.BookAuthor,
			GetData: nov.Nov.Author,
			Ret:     nov.Nov.Author == rule.Test.BookAuthor,
		})

		// 分类对比
		results = append(results, TestResult{
			Name:    "简介页面小说分类",
			Rule:    rule.Rules.BookCateSelector,
			Attr:    rule.Rules.BookCateAttr,
			Data:    rule.Test.BookCate,
			GetData: nov.Nov.CateName,
			Ret:     nov.Nov.CateName == rule.Test.BookCate,
		})

		// 简介对比
		results = append(results, TestResult{
			Name:    "简介页面小说简介",
			Rule:    rule.Rules.BookDescSelector,
			Attr:    rule.Rules.BookDescAttr,
			Data:    rule.Test.BookDesc,
			GetData: nov.Nov.Desc,
			Ret:     strings.Contains(nov.Nov.Desc, rule.Test.BookDesc),
		})

		// 缩略图对比
		results = append(results, TestResult{
			Name:    "简介页面小说缩略图",
			Rule:    rule.Rules.BookCoverSelector,
			Attr:    rule.Rules.BookCoverAttr,
			Data:    rule.Test.BookCover,
			GetData: nov.Nov.Cover,
			Ret:     nov.Nov.Cover == rule.Test.BookCover,
		})

		// 章节目录URL对比
		results = append(results, TestResult{
			Name:    "简介页面章节目录URL",
			Rule:    rule.Rules.BookChapterURLSelector,
			Attr:    rule.Rules.BookChapterURLAttr,
			Data:    rule.Test.BookChapterURL,
			GetData: nov.ChapterUrl,
			Ret:     nov.ChapterUrl == rule.Test.BookChapterURL,
		})
	}

	// 获取测试章节列表
	catalogs, err := c.GetChapters(rule, rule.Test.ChapterURL)
	errMsg = ""
	useTime = time.Duration(0)
	if err != nil {
		errMsg = err.Error()
	} else if len(catalogs) == 0 {
		errMsg = "章节列表获取为空"
	} else {
		useTime = catalogs[0].UseTime
	}

	results = append(results, TestResult{
		Name:    "章节目录页面获取",
		UseTime: useTime,
		Data:    rule.Test.ChapterURL,
		GetData: errMsg,
		Ret:     err == nil,
	})

	if err == nil && len(catalogs) > 0 {
		// 章节目录第一章节URL对比
		results = append(results, TestResult{
			Name:    "章节目录第一章节URL",
			Rule:    rule.Rules.ChapterCatalogSelector,
			Data:    rule.Test.ChapterCatalogURL,
			GetData: catalogs[0].Chap.Link,
			Ret:     catalogs[0].Chap.Link == rule.Test.ChapterCatalogURL,
		})

		// 章节目录第一章节URL对比
		results = append(results, TestResult{
			Name:    "章节目录第一章节URL",
			Rule:    rule.Rules.ChapterCatalogSelector,
			Data:    rule.Test.ChapterCatalogTitle,
			GetData: catalogs[0].Chap.Link,
			Ret:     catalogs[0].Chap.Title == rule.Test.ChapterCatalogTitle,
		})
	}

	// 测试章节内容
	info, err := c.GetChapter(rule, rule.Test.InfoURL)
	errMsg = ""
	useTime = time.Duration(0)
	if err != nil {
		errMsg = err.Error()
	} else {
		useTime = info.UseTime
	}

	results = append(results, TestResult{
		Name:    "章节内容页面获取",
		UseTime: useTime,
		Data:    rule.Test.InfoURL,
		GetData: errMsg,
		Ret:     err == nil,
	})

	if err == nil {
		// 章节内容页面标题对比
		results = append(results, TestResult{
			Name:    "章节内容页面标题",
			Rule:    rule.Rules.InfoTitleSelector,
			Data:    rule.Test.InfoTitle,
			GetData: info.Chap.Title,
			Ret:     info.Chap.Title == rule.Test.InfoTitle,
		})

		// 章节内容页面内容对比
		results = append(results, TestResult{
			Name:    "章节内容页面内容",
			Rule:    rule.Rules.InfoDescSelector,
			Data:    rule.Test.InfoDesc,
			GetData: info.Chap.Desc,
			Ret:     strings.Contains(info.Chap.Desc, rule.Test.InfoDesc),
		})

		// 章节内容页面上一章URL对比
		results = append(results, TestResult{
			Name:    "章节内容页面上一章URL",
			Rule:    rule.Rules.InfoPrePageSelector,
			Data:    rule.Test.InfoPrePageURL,
			GetData: info.PreUrl,
			Ret:     info.PreUrl == rule.Test.InfoPrePageURL,
		})

		// 章节内容页面下一章URL对比
		results = append(results, TestResult{
			Name:    "章节内容页面下一章URL",
			Rule:    rule.Rules.InfoNextPageSelector,
			Data:    rule.Test.InfoNextPageURL,
			GetData: info.NextUrl,
			Ret:     info.NextUrl == rule.Test.InfoNextPageURL,
		})
	}

	// 搜索小说
	find, err := c.FindNovel(rule, rule.Test.FindBookKw)
	errMsg = ""
	useTime = time.Duration(0)
	if err != nil {
		errMsg = err.Error()
	} else {
		useTime = find.UseTime
	}

	results = append(results, TestResult{
		Name:    "搜索小说页面获取",
		UseTime: useTime,
		Rule:    rule.Rules.FindURL,
		Data:    rule.Test.FindBookKw,
		GetData: errMsg,
		Ret:     err == nil,
	})

	if err == nil {
		// 搜索小说页面小说URL对比
		results = append(results, TestResult{
			Name:    "章节内容页面下一章URL",
			Rule:    rule.Rules.FindURL,
			Data:    rule.Test.FindBookURL,
			GetData: find.Url,
			Ret:     find.Url == rule.Test.FindBookURL,
		})
	}

	this.Data["Results"] = results
	this.View("snatch_rule/test.tpl")
}

// 导入规则文件
func (this *SnatchRuleController) Import() {
	if this.IsAjax() {
		ruleContent := this.GetString("rule_content")
		if len(ruleContent) == 0 {
			this.OutJson(1001, "请输入需要导入的JSON规则")
		}

		imports := make([]*ExportSnatchRule, 0)
		err := json.Unmarshal([]byte(ruleContent), &imports)
		if err != nil {
			this.OutJson(1002, "转换JSON失败："+err.Error())
		}

		for _, i := range imports {
			r := &models.SnatchRule{
				Name:     i.Name,
				Code:     i.Code,
				Url:      i.Url,
				State:    i.State,
				IsUpdate: i.IsUpdate,
				Charset:  i.Charset,
				Test:     i.Test,
				Rules:    i.Rules,
				CateMaps: i.CateMaps,
			}

			err = services.SnatchRuleService.Save(r)

			if err != nil {
				this.OutJson(1003, "导入失败："+err.Error())
			}
		}

		this.OutJson(0, "导入成功")
		return
	}

	this.View("snatch_rule/import.tpl")
}

// 导出规则文件
func (this *SnatchRuleController) Export() {
	idStr := this.GetString("ids")
	ids := strings.Split(idStr, ",")
	if len(ids) == 0 {
		this.Msg("请选择需要导出的规则")
	}
	args := &models.ArgsListRule{
		Ids: make([]interface{}, 0),
	}

	for _, id := range ids {
		args.Ids = append(args.Ids, id)
	}

	rules := services.SnatchRuleService.GetAll(args)

	if len(rules) == 0 {
		this.Msg("没有可导出的内容")
	}

	exports := make([]*ExportSnatchRule, 0)
	for _, r := range rules {
		r.Decode()
		export := &ExportSnatchRule{
			Name:     r.Name,
			Code:     r.Code,
			Url:      r.Url,
			State:    r.State,
			IsUpdate: r.IsUpdate,
			Charset:  r.Charset,
			Test:     r.Test,
			Rules:    r.Rules,
			CateMaps: r.CateMaps,
		}

		exports = append(exports, export)
	}

	data, err := json.Marshal(exports)

	if err != nil {
		this.Msg("转换JSON失败：" + err.Error())
	}

	var buf bytes.Buffer
	_ = json.Indent(&buf, data, "", "    ")

	file := bytes.NewReader(buf.Bytes())

	this.Ctx.Output.Header("Content-Type", "application/octet-stream")
	this.Ctx.Output.Header("content-disposition", "attachment; filename=\"novel_snatch_rules.txt\"")
	_, err = io.Copy(this.Ctx.ResponseWriter, file)
	if err != nil {
		this.Msg("下载失败：" + err.Error())
	}
}

// 删除采集规则
func (this *SnatchRuleController) Delete() {
	id, _ := this.GetUint32("id")
	name := this.GetString("name", "")
	if id < 1 {
		this.OutJson(1001, "参数错误，无法访问")
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
