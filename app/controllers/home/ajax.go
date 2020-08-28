package home

import (
	"github.com/astaxie/beego"

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services"
)

type AjaxController struct {
	BaseController
}

// ajax加载小说章节
func (this *AjaxController) AjaxChap() {
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

// ajax获取小说列表
func (this *AjaxController) AjaxRank() {
	var novels []*models.Novel
	switch this.GetString("rank") {
	case "1":
		novels = services.NovelService.GetTodayRecs(10, 0)
	case "2":
		novels = services.NovelService.GetHots(10, 0)
	case "3": // 新书榜
		novels = services.NovelService.GetNews(10, 0)
	case "4": // 原创榜
		novels = services.NovelService.GetOriginals(10, 0)
	case "5": // VIP推荐榜
		novels = services.NovelService.GetVipRewards(10, 0)
	case "6": // VIP更新
		novels = services.NovelService.GetVipUps(10, 0)
	case "cate":
		cateId, _ := this.GetInt("cate_id")
		// 获取指定分类小说列表
		search := map[string]interface{}{
			"cate_id": cateId,
			"count":   false,
		}
		novels, _ = services.NovelService.GetList(6, 0, search)
	default:
		// 获取小说列表
		search := map[string]interface{}{
			"count": false,
		}
		novels, _ = services.NovelService.GetList(10, 0, search)
	}

	var list []map[string]interface{}

	for _, nov := range novels {
		tmp := make(map[string]interface{})

		tmp["id"] = nov.Id
		tmp["name"] = nov.Name
		tmp["author"] = nov.Author
		tmp["cate_name"] = nov.CateName
		tmp["cover"] = nov.Cover
		tmp["desc"] = beego.HTML2str(nov.Desc)

		list = append(list, tmp)
	}

	res := map[string]interface{}{
		"list": list,
	}
	this.OutJson(0, "", res)
}
