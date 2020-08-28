package m

import (
	"github.com/astaxie/beego"

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services"
)


type AjaxController struct {
	BaseController
}

// 获取章节列表
func (this *AjaxController) AjaxChaps() {
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

// ajax获取小说列表
func (this *AjaxController) AjaxNovels() {
	p, _ := this.GetInt("p")
	cateId, _ := this.GetInt("cate_id")
	q := this.GetString("q")

	if p < 1 {
		p = 1
	}

	offset := (p - 1) * PAGESIZE

	var novels []*models.Novel
	switch this.GetString("act") {
	case "rank":
		novels = services.NovelService.GetRanks(PAGESIZE, offset)
	case "end":
		novels = services.NovelService.GetEnds(PAGESIZE, offset)
	default:
		// 获取小说列表
		search := map[string]interface{}{
			"q":       q,
			"cate_id": cateId,
			"count":   false,
		}
		novels, _ = services.NovelService.GetList(PAGESIZE, offset, search)
	}

	var list []map[string]interface{}

	for _, nov := range novels {
		tmp := make(map[string]interface{})

		tmp["id"] = nov.Id
		tmp["name"] = nov.Name
		tmp["author"] = nov.Author
		tmp["cate_name"] = nov.CateName
		tmp["desc"] = beego.HTML2str(nov.Desc)
		tmp["cover"] = nov.Cover

		list = append(list, tmp)
	}

	res := map[string]interface{}{
		"is_next": len(list) >= PAGESIZE,
		"list":    list,
	}
	this.OutJson(0, "", res)
}
