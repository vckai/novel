package api

import (
	"novel/app/controllers"

	"novel/app/services"
)

const (
	PAGESIZE = 5
)

type ChapterController struct {
	controllers.BaseController
}

// 根据小说ID获取章节列表
func (this *ChapterController) AjaxChaps() {
	id, _ := this.GetUint32("id")
	if id < 1 {
		this.OutJson(1001, "参数错误，无法访问")
	}

	p, _ := this.GetInt("p")
	asc := this.GetString("asc")

	if p < 1 {
		p = 1
	}

	offset := (p - 1) * 10

	// 获取章节列表
	chaps, _ := services.ChapterService.GetNovChaps(id, 10, offset, asc, false)

	var res []map[string]interface{}

	for _, chap := range chaps {
		tmp := make(map[string]interface{})

		tmp["id"] = chap.Id
		tmp["no"] = chap.ChapterNo
		tmp["title"] = chap.Title

		res = append(res, tmp)
	}

	this.OutJson(0, "", res)
}

// 根据小说Id和章节Id获取章节内容
func (this *ChapterController) AjaxChap() {
	id, _ := this.GetUint64("id")
	novId, _ := this.GetUint32("novid")
	if id < 1 || novId < 1 {
		this.Msg("参数错误，无法访问")
	}

	// 获取小说章节信息
	chap := services.ChapterService.Get(id, novId)
	if chap == nil {
		this.Msg("该章节不存在或者已被删除")
	}

	tmp := map[string]interface{}{
		"id":    chap.Id,
		"title": chap.Title,
		"desc":  chap.Desc,
	}

	// 获取下一章节ID
	next := services.ChapterService.GetNext(chap.NovId, chap.ChapterNo)
	nextId := uint64(0)
	if next != nil {
		nextId = next.Id
	}

	res := map[string]interface{}{
		"chap":    tmp,
		"next_id": nextId,
	}
	this.OutJson(0, "", res)
}
