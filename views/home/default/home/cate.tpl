
	<link rel="stylesheet" data-ignore="true" href="{{.mOut.ViewUrl}}css/cate.css">
    <div class="all-pro-wrap box-center cf">
        <div class="range-sidebar fl">
            <div class="site">
                <a class="act" href="javascript:">男生</a>
            </div>
            <div class="select-list">
                <div class="work-filter type-filter">
                    <h3>分类</h3>
                    <ul class="row-1" type="category">
                        <li data-id="-1" {{if lt .Search.cate_id 1}}class="act"{{end}}><a href="{{urlfor "home.HomeController.Cate"}}">全部</a></li>
						{{range .Cates}}
                        <li data-id="{{.Id}}" {{if eq $.CateId .Id}}class="act"{{end}}><a href="{{urlfor "home.HomeController.Cate" ":id" .Id}}">{{.Name}}</a></li>
						{{end}}
                    </ul>
                </div>
                <div class="work-filter action-filter">
                    <h3>状态</h3>
                    <ul type="action">
                        <li {{if lt .Search.status 1}}class="act"{{end}}><a href="javascript:gourl('status', 0);">全部</a></li>
						{{range $k, $v := .StatusList}}
                        <li {{if eq $.Status $k}}class="act"{{end}}><a href="javascript:gourl('status', '{{$k}}');">{{$v}}</a></li>
						{{end}}
                    </ul>
                </div>
                
                <div class="work-filter">
                    
                    <h3>字数</h3>
                    <ul type="size">
                        <li {{if eq .Search.text_num 0}}class="act"{{end}}><a href="javascript:gourl('text_num', 0);">全部</a></li>
                        <li {{if eq .Search.text_num 1}}class="act"{{end}}><a href="javascript:gourl('text_num', 1);">30万字以下</a></li>
                        <li {{if eq .Search.text_num 2}}class="act"{{end}}><a href="javascript:gourl('text_num', 2);">30-50万字</a></li>
                        <li {{if eq .Search.text_num 3}}class="act"{{end}}><a href="javascript:gourl('text_num', 3);">50-100万字</a></li>
                        <li {{if eq .Search.text_num 4}}class="act"{{end}}><a href="javascript:gourl('text_num', 4);">100-200万字</a></li>
                        <li {{if eq .Search.text_num 5}}class="act"{{end}}><a href="javascript:gourl('text_num', 5);">200万字以上</a></li>
                    </ul>
                </div>
                <div class="work-filter" data-l2="9">
                    <h3>更新时间</h3>
                    <ul type="update">
                        <li {{if eq .Search.uptime 0}}class="act"{{end}}><a href="javascript:gourl('uptime', 0);">全部</a></li>
                        <li {{if eq .Search.uptime 1}}class="act"{{end}}><a href="javascript:gourl('uptime', 1);">三日内</a></li>
                        <li {{if eq .Search.uptime 2}}class="act"{{end}}><a href="javascript:gourl('uptime', 2);">七日内</a></li>
                        <li {{if eq .Search.uptime 3}}class="act"{{end}}><a href="javascript:gourl('uptime', 3);">半月内</a></li>
                        <li {{if eq .Search.uptime 4}}class="act"{{end}}><a href="javascript:gourl('uptime', 4);">一月内</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="main-content-wrap fl">
				{{if eq .NovCount 0}}
					<div class="no-result-wrap" data-l1="3">
						<div class="no-result-img">
							<span class="no-data-img"></span>
						</div>
						<h3>没有找到符合条件的书</h3>
					</div>
				{{else}}
                <div class="tool-bar cf">
                    <div class="select-wrap">
                        <a {{if eq .Search.ot 1}}class="act"{{end}} href="javascript:gourl('ot', 1);">人气排序<cite class="iconfont"></cite></a>
                        <a {{if eq .Search.ot 2}}class="act"{{end}} href="javascript:gourl('ot', 2);">更新时间</a>
                        <a {{if eq .Search.ot 3}}class="act"{{end}} href="javascript:gourl('ot', 3);">总字数</a>
                        
                        <div class="sort-count count-info" id="sort-count">
                            <div class="count-text">共<span>{{.NovCount}}</span>本相关作品</div>
                        </div>
                    </div>
                </div>

                <div class="all-book-list">
                    <div class="book-img-text">
                        <ul class="all-img-list cf">
						{{range .Novs}}
                            <li>
								<div class="book-img-box">
									<a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank" class="f-pic-box">
										<img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}}>
									</a>
								</div>
								<div class="book-mid-info">
									<h4><a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank">{{.Name}}</a></h4>
									<p class="author">
										<a class="name" href="javascript:;">{{.Author}}</a>
										<em>|</em>
										<a href="{{urlfor "home.HomeController.Cate" ":id" .CateId}}">{{.CateName}}</a>
										<em>|</em>
										<span>{{.StatusName}}</span>
									</p>
									<p class="intro">
										{{substr_no_html .Desc 0 60}}
									</p>
									<p class="update"><span>{{num_format .TextNum}}字</span></p>
								</div>
                            </li>
						{{end}}
                        </ul>
                    </div>
                </div>
                    
                <div class="page-box cf">
					{{template "home/default/common/page.tpl" .}}
				</div>
				{{end}}
        </div>
    </div>

	<script>
	var params = {
		"status": {{.Search.status}},
		"text_num": {{.Search.text_num}},
		"uptime": {{.Search.uptime}},
		"ot": {{.Search.ot}},
		"p": {{.Search.p}}
	};

	function gourl(name, value) {
		// 重置分页
		if (name != "p") {
			params["p"] = 1;
		}
		params[name] = value

		var url = new Array();

		for (i in params) {
			url.push(i + "=" + params[i]);
		}

		window.location.href = {{urlfor "home.HomeController.Cate" ":id" .Search.cate_id}} + "?" + url.join("&");
	}
	</script>
