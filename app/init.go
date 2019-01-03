package app

import (
	"strings"
	"time"

	"github.com/astaxie/beego"
	"github.com/beego/i18n"

	"github.com/vckai/novel/app/models"
	_ "github.com/vckai/novel/app/routers"
	"github.com/vckai/novel/app/services"
	"github.com/vckai/novel/app/utils"
	"github.com/vckai/novel/app/utils/log"
)

const (
	VERSION = "0.0.5"
)

var (
	RunTime = time.Now()
)

func init() {
	// 初始化db
	models.InitDB()

	// 初始化语言选项
	initLang()

	// 初始化采集
	services.InitSnatch()

	// 代理IP获取
	services.InitProxy()

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
