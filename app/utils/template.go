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

package utils

import (
	"fmt"
	"html/template"
	"strings"

	"github.com/astaxie/beego"
)

func RegisterFuncMap() {
	// 注册模板函数
	beego.AddFuncMap("datetime", GetDateFormat)
	beego.AddFuncMap("itoa", IntToString)
	beego.AddFuncMap("substr_no_html", SubstrNoHtml)
	beego.AddFuncMap("add", Add)
	beego.AddFuncMap("css", Css)
	beego.AddFuncMap("num_format", NumFormat)
}

// 数字转换字符串
func IntToString(in interface{}) string {
	if in == nil || in == 0 {
		return ""
	}

	s := fmt.Sprint(in)

	if s == "0" {
		return ""
	}

	return s
}

// 去除html标签后截取
func SubstrNoHtml(s string, start, length int) string {
	s = beego.Htmlunquote(s)
	s = beego.HTML2str(s)

	s = strings.Replace(s, "\n", "", -1)

	s = beego.Substr(s, start, length)

	return s
}

// 加法计算
func Add(n, m int) int {
	return n + m
}

// 数字格式化计算
func NumFormat(num uint32) string {
	str := fmt.Sprintf("%d", num)
	if num > 10000 {
		n := float64(num) / float64(10000)
		str = fmt.Sprintf("%.2f万", n)
	}

	return str
}

// 转换css输出
func Css(css string) template.CSS {
	return template.CSS(css)
}
