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
	"time"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/validation"

	"novel/app/models"
	"novel/app/utils"
	"novel/app/utils/log"
)

// 定义AdminService
type Admin struct {
}

func NewAdmin() *Admin {
	return &Admin{}
}

// 获取单个管理员信息
func (this *Admin) Get(id uint32) *models.Admin {
	if id < 0 {
		return nil
	}

	admin := &models.Admin{Id: id}
	err := admin.Read()
	if err != nil {
		log.Error("管理员信息读取失败[Get]：", err)
		return nil
	}

	return admin
}

// 登录账号密码检测
func (this *Admin) Login(account, password string) (*models.Admin, error) {
	if len(account) == 0 || len(password) == 0 {
		return nil, errors.New("参数错误")
	}

	admin := models.AdminModel.GetByAccount(account)
	if admin == nil {
		return nil, errors.New("账号不存在")
	}

	if admin.Password != this.encryptPass(password) {
		return nil, errors.New("密码错误")
	}

	if admin.Status != 0 {
		return nil, errors.New("该账号已被禁用")
	}

	return admin, nil
}

// 判断管理员是否存在
func (this *Admin) IsAccountExists(account string, filterId ...uint32) bool {
	if len(account) == 0 {
		return false
	}

	// 根据账号获取管理员
	admin := models.AdminModel.GetByAccount(account)
	if admin == nil {
		return false
	}

	// 过滤当前ID
	if len(filterId) > 0 && admin.Id == filterId[0] {
		return false
	}

	return true
}

// 验证用户是否有接口权限
func (this *Admin) ValidPurview(adminId uint32, module, action string) bool {
	admin := this.Get(adminId)
	if admin == nil {
		return false
	}

	return GroupService.ValidPurview(admin.GroupId, module, action)
}

// 获取当前管理员的菜单列表
func (this *Admin) GetMenus(adminId uint32) []*models.Role {
	admin := this.Get(adminId)
	if admin == nil {
		return nil
	}

	return GroupService.GetMenus(admin.GroupId)
}

// 批量获取管理员列表
func (this *Admin) GetAll() []*models.Admin {
	admins := models.AdminModel.GetAll()

	groups := GroupService.GetAll()
	inGroups := map[uint32]string{}
	for _, g := range groups {
		inGroups[g.Id] = g.Name
	}

	for _, a := range admins {
		if name, ok := inGroups[a.GroupId]; ok {
			a.GroupName = name
		}
	}

	return admins
}

// 删除管理员
func (this *Admin) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	admin := models.Admin{Id: id}
	err := admin.Delete(true)
	if err != nil {
		return err
	}

	return nil
}

// 修改用户登录信息
func (this *Admin) UpdateLoginInfo(admin *models.Admin) error {

	admin.LoginVisit++
	admin.LastLoginedAt = uint32(time.Now().Unix())
	err := admin.Update("login_visit", "last_login_ip", "last_logined_at")

	return err
}

// 修改密码
func (this *Admin) UpdatePwd(admin *models.Admin) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(admin.Password, "pwdEmpty").Message("请输入密码")
	valid.Length(admin.Password, 32, "pwdLen").Message("密码格式错误")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	// 密码加密
	admin.Password = this.encryptPass(admin.Password)
	err := admin.Update("password")

	return err
}

// 添加/修改
func (this *Admin) Save(admin *models.Admin) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(admin.Name, "nickEmpty").Message("昵称不能为空")
	valid.MaxSize(admin.Name, 20, "nickMax").Message("昵称长度不能超过20个字符")
	valid.Required(admin.Account, "accEmpty").Message("账号不能为空")
	valid.MaxSize(admin.Account, 20, "accMax").Message("账号长度不能超过20个字符")

	valid.Required(admin.GroupId, "groupEmtpy").Message("请选择权限群组")

	if admin.Id == 0 || len(admin.Password) > 0 {
		valid.Required(admin.Password, "pwdEmpty").Message("请输入密码")
		valid.Length(admin.Password, 32, "pwdLen").Message("密码格式错误")
	}

	// 邮箱格式验证
	if len(admin.Mail) > 0 {
		valid.Email(admin.Mail, "mail").Message("请输入正确格式的邮箱地址")
	}
	// 手机号码验证
	if admin.Mobile > 0 {
		valid.Phone(admin.Mobile, "mobile").Message("请输入正确格式的手机号码")
	}

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	// 密码二次加密处理
	if len(admin.Password) > 0 {
		admin.Password = this.encryptPass(admin.Password)
	}

	var err error
	if admin.Id > 0 {
		err = admin.Update("account", "name", "mail", "mobile", "group_id", "status")
	} else {
		err = admin.Insert()
	}

	return err
}

// 对密码进行加密
func (this *Admin) encryptPass(password string) string {
	if len(password) == 0 {
		return ""
	}

	pass, err := utils.NewPass(password, beego.AppConfig.String("secretkey"))
	if err != nil {
		log.Error("密码加密错误：", password, " - ", err.Error())
		return ""
	}

	return pass
}
