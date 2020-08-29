package api

import (
	"github.com/astaxie/beego"
	"github.com/vckai/novel/app/controllers"

	"github.com/vckai/novel/app/models"
	"github.com/vckai/novel/app/services"
)

type BookController struct {
	controllers.BaseController
}

// 根据排行榜、热更等属性获取小说列表
func (this *BookController) Rank() {
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


// 根据分类Id获取小说列表
func (this *BookController) AjaxNovels() {
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