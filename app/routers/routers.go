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

package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"

	"github.com/vckai/novel/app/controllers/admin"
	"github.com/vckai/novel/app/controllers/api"
	"github.com/vckai/novel/app/controllers/home"
	"github.com/vckai/novel/app/controllers/m"
)

func init() {
	// 静态资源
	beego.SetStaticPath("/public", "static")

	// 首页路由
	beego.Router("/", &home.HomeController{}, "GET:Index")
	beego.AutoRouter(&home.HomeController{})
	beego.AutoRouter(&home.BookController{})

	// 禁止浏览器页面缓存
	var FilterNoCache = func(ctx *context.Context) {
		ctx.Output.Header("Cache-Control", "no-cache, no-store, must-revalidate")
		ctx.Output.Header("Pragma", "no-cache")
		ctx.Output.Header("Expires", "0")
	}

	beego.InsertFilter("/*", beego.BeforeStatic, FilterNoCache)

	// APP接口
	appRouters()

	// H5网站
	mRouters()

	// 管理后台
	adminRouters()
}

func appRouters() {
	// APP接口
	ns := beego.NewNamespace("/api",
		// 路由执行前置条件
		beego.NSCond(func(ctx *context.Context) bool {
			return true
		}),

		beego.NSRouter("/", &api.HomeController{}, "GET:Index"),

		// 首页路由
		beego.NSAutoRouter(&api.HomeController{}),

		// 小说路由
		beego.NSAutoRouter(&api.BookController{}),

		// 转发小说路由
		beego.NSAutoRouter(&api.SnatchController{}),
	)

	beego.AddNamespace(ns)
}

func mRouters() {
	// 移动端网站
	ns := beego.NewNamespace("/m",
		// 路由执行前置条件
		beego.NSCond(func(ctx *context.Context) bool {
			return true
		}),

		beego.NSRouter("/", &m.HomeController{}, "GET:Index"),

		// 首页路由
		beego.NSAutoRouter(&m.HomeController{}),

		// 小说路由
		beego.NSAutoRouter(&m.BookController{}),

		// 转发小说路由
		beego.NSAutoRouter(&m.SnatchController{}),
	)

	beego.AddNamespace(ns)
}

func adminRouters() {
	// 管理后台
	ns := beego.NewNamespace("/admin",
		// 路由执行前置条件
		beego.NSCond(func(ctx *context.Context) bool {
			return true
		}),

		beego.NSRouter("/", &admin.LoginController{}, "GET:Index"),

		// 登录路由
		beego.NSAutoRouter(&admin.LoginController{}),

		// 框架主页面路由
		beego.NSAutoRouter(&admin.MainController{}),

		// 欢迎页面路由
		beego.NSAutoRouter(&admin.HomeController{}),

		// 权限路由
		beego.NSAutoRouter(&admin.RoleController{}),

		// 群组路由
		beego.NSAutoRouter(&admin.GroupController{}),

		// 管理员路由
		beego.NSAutoRouter(&admin.AdminController{}),

		// 管理操作日记路由
		beego.NSAutoRouter(&admin.AdminLogController{}),

		// 小说分类路由
		beego.NSAutoRouter(&admin.CateController{}),

		// 小说路由
		beego.NSAutoRouter(&admin.NovelController{}),

		// 小说章节路由
		beego.NSAutoRouter(&admin.ChapterController{}),

		// 用户反馈
		beego.NSAutoRouter(&admin.FeedbackController{}),

		// 轮播管理
		beego.NSAutoRouter(&admin.BannerController{}),
	)

	beego.AddNamespace(ns)
}
