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

package log

import (
	"github.com/astaxie/beego"
)

// 错误日记
func Error(v ...interface{}) {
	beego.Error(v...)
}

// 警告日记
func Warn(v ...interface{}) {
	beego.Warning(v...)
}

// 注意日记
func Notice(v ...interface{}) {
	beego.Notice(v...)
}

// 正常信息日记
func Info(v ...interface{}) {
	beego.Info(v...)
}

// 调试日记
func Debug(v ...interface{}) {
	beego.Debug(v...)
}
