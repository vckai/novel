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
	"time"
)

func GetDateFormat(timestamp uint32, format string) string {
	if timestamp <= 0 {
		return ""
	}
	tm := time.Unix(int64(timestamp), 0)
	return tm.Format(format)
}

func GetDate(timestamp uint32) string {
	if timestamp <= 0 {
		return ""
	}
	tm := time.Unix(int64(timestamp), 0)
	return tm.Format("2006-01-02")
}

func GetDateMH(timestamp uint32) string {
	if timestamp <= 0 {
		return ""
	}
	tm := time.Unix(int64(timestamp), 0)
	return tm.Format("2006-01-02 15:04")
}

func GetTimeParse(times string) int64 {
	if "" == times {
		return 0
	}
	loc, _ := time.LoadLocation("Local")
	parse, _ := time.ParseInLocation("2006-01-02 15:04", times, loc)
	return parse.Unix()
}

func GetDateParse(dates string) int64 {
	if "" == dates {
		return 0
	}
	loc, _ := time.LoadLocation("Local")
	parse, _ := time.ParseInLocation("2006-01-02", dates, loc)
	return parse.Unix()
}
