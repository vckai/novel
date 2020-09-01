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

// 定义FeedbackService
type Feedback struct {
}

func NewFeedback() *Feedback {
	return &Feedback{}
}

// 获取单个反馈信息
func (this *Feedback) Get(id uint32) *models.Feedback {
	if id < 0 {
		return nil
	}

	feedback := &models.Feedback{Id: id}
	err := feedback.Read()
	if err != nil {
		return nil
	}

	return feedback
}

// 批量获取反馈列表
func (this *Feedback) GetAll(size, offset int, args map[string]interface{}) ([]*models.Feedback, int64) {
	qs := map[string]string{}

	if q, ok := args["q"]; ok && len(q.(string)) > 0 {
		qs["q"] = q.(string)
	}

	if c, ok := args["count"]; ok && c.(bool) == true {
		qs["count"] = "1"
	}

	feedbacks, count := models.FeedbackModel.GetAll(size, offset, qs)

	return feedbacks, count
}

// 批量删除反馈内容
func (this *Feedback) DeleteBatch(ids []string) error {
	if len(ids) == 0 {
		return errors.New("params error")
	}

	return models.FeedbackModel.DeleteBatch(ids)
}

// 删除反馈内容
func (this *Feedback) Delete(id uint32) error {
	if id < 0 {
		return errors.New("params error")
	}

	log := models.Feedback{Id: id}
	err := log.Delete()
	if err != nil {
		return err
	}

	return nil
}

// 添加/修改
func (this *Feedback) Save(feed *models.Feedback) error {
	// 参数校验
	valid := validation.Validation{}
	valid.Required(feed.Content, "nameEmpty").Message("反馈内容不能为空")
	valid.MaxSize(feed.Content, 255, "nameMax").Message("反馈内容长度不能超过255个字符")

	valid.Required(feed.Contact, "contactEmpty").Message("联系方式不能为空")
	valid.MaxSize(feed.Contact, 100, "contactMax").Message("联系方式长度不能超过100个字符")

	if valid.HasErrors() {
		for _, err := range valid.Errors {
			return err
		}
	}

	var err error
	if feed.Id > 0 {
		err = feed.Update("status", "reply", "reply_at")
	} else {
		err = feed.Insert()
	}

	return err
}
