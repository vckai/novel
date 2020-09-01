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

import (
	"errors"

	"github.com/astaxie/beego/validation"

	"novel/app/models"
)

const (
	// 广告区域
	ZONEINDEXSLICE  uint8 = iota + 1 // pc首页轮播
	ZONEINDEXBANNER                  // pc首页banner图
	ZONEMINDEX                       // h5首页轮播
	ZONENOV                          // 小说详情页右侧轮播
)

var (
	ERRVALIDZONE = errors.New("广告区域不存在")
)

// 定义BannerService
type Banner struct {
}

func NewBanner() *Banner {
	return &Banner{}
}

// 获取单个banner信息
func (this *Banner) Get(id uint32) *models.Banner {
	if id < 0 {
		return nil
	}

	banner := &models.Banner{Id: id}
	err := banner.Read()
	if err != nil {
		return nil
	}

	return banner
}

// 批量获取banner列表
func (this *Banner) GetAll(args map[string]interface{}) []*models.Banner {
	banners := models.BannerModel.GetAll(args)

	return banners
}

// 批量删除banner
func (this *Banner) DeleteBatch(ids []string) error {
	if len(ids) == 0 {
		return errors.New("params error")
	}

	return models.BannerModel.DeleteBatch(ids)
}

// 删除banner
func (this *Banner) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	banner := models.Banner{Id: id}
	err := banner.Delete(true)
	if err != nil {
		return err
	}

	return nil
}

// 添加/修改
func (this *Banner) Save(banner *models.Banner) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(banner.Zone, "zoneEmpty").Message("区域不能为空")

	zones := this.Zones()
	if _, ok := zones[banner.Zone]; !ok {
		return ERRVALIDZONE
	}

	valid.Required(banner.Name, "nameEmpty").Message("banner名称不能为空")
	valid.MaxSize(banner.Name, 20, "nameMax").Message("banner名称长度不能超过20个字符")

	valid.Required(banner.Link, "linkEmpty").Message("链接地址不能为空")
	valid.MaxSize(banner.Link, 100, "linkMax").Message("链接地址长度不能超过100个字符")

	valid.Required(banner.Img, "imgEmpty").Message("图片不能为空")
	valid.MaxSize(banner.Img, 100, "imgMax").Message("图片地址长度不能超过100个字符")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	var err error
	if banner.Id > 0 {
		err = banner.Update("name", "img", "link", "zone", "desc")
	} else {
		err = banner.Insert()
	}

	return err
}

// 广告区域列表
func (this Banner) Zones() map[uint8]string {
	return map[uint8]string{
		ZONEINDEXSLICE:  "pc首页轮播",
		ZONEINDEXBANNER: "pc首页中间小banner",
		ZONEMINDEX:      "h5首页轮播",
		ZONENOV:         "pc小说详情右侧轮播",
	}
}
