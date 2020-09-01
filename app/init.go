package app

import (
	"strings"
	"time"

	"github.com/astaxie/beego"
	"github.com/beego/i18n"

	"novel/app/controllers"
	"novel/app/models"
	_ "novel/app/routers"
	"novel/app/services"
	"novel/app/utils"
	"novel/app/utils/log"
)

const (
	VERSION = "0.0.6"
)

var (
	RunTime = time.Now()
)

func init() {
	// 初始化db
	models.InitDB()

	// 初始化语言选项
	initLang()

	// 服务初始化配置
	services.Init()

	beego.AddFuncMap("urlfor", controllers.URLFor)

	// 注册模板函数
	utils.RegisterFuncMap()

	// 设置版本号
	beego.AppConfig.Set("version", VERSION)
}

// 初始化语言选项
func initLang() {
	// Initialized language type list.
	langs := strings.Split(beego.AppConfig.String("lang::types"), "|")

	for _, lang := range langs {
		if err := i18n.SetMessage(lang, "lang/"+"locale_"+lang+".ini"); err != nil {
			log.Error("Fail to set message file: " + err.Error())
			return
		}
	}

	beego.AddFuncMap("i18n", i18n.Tr)
}
