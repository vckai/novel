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

import (
	"testing"
)

var configService = &Config{cfg: make(map[string]string)}

func TestSet(t *testing.T) {
	configService.cfg["Title"] = "test"
	configService.cfg["IsSnatch"] = "0"
	configService.cfg["Uptime"] = "10"
	configService.cfg["NotUpStopDays"] = "100"
}

func TestString(t *testing.T) {
	title := configService.String("Title")
	if title != "test" {
		t.Fatal("String Get Error: ", title)
	}

	titleDef := configService.String("TitleDef", "def")
	if titleDef != "def" {
		t.Fatal("String Get Default Value Error: ", titleDef)
	}
}

func TestInt(t *testing.T) {
	up := configService.Int("Uptime")
	if up != 10 {
		t.Fatal("Int Get Error: ", up)
	}

	upDef := configService.Int("UptimeDef", 1)
	if upDef != 1 {
		t.Fatal("Int Get Default Error: ", upDef)
	}
}

func TestInt64(t *testing.T) {
	up := configService.Int64("Uptime")
	if up != 10 {
		t.Fatal("Int64 Get Error: ", up)
	}

	upDef := configService.Int64("UptimeDef", 1)
	if upDef != 1 {
		t.Fatal("Int64 Get Default Error: ", upDef)
	}
}

func TestBool(t *testing.T) {
	is := configService.Bool("IsSnatch")
	if is != false {
		t.Fatal("Bool Get Error: ", is)
	}

	isSnatchDef := configService.Bool("IsSnatchDef", true)
	if isSnatchDef != true {
		t.Fatal("Bool Get Default Error: ", isSnatchDef)
	}
}
