
	<link rel="stylesheet" data-ignore="true" href="{{.mOut.ViewUrl}}css/cate.css">
    <div class="all-pro-wrap box-center cf">
        <div class="main-content-wrap fl search-box">
		{{if eq .NovCount 0}}
			<div class="no-result-wrap" data-l1="3">
                <div class="no-result-img">
                    <span class="no-data-img"></span>
                </div>
                <h3>没有找到符合条件的书</h3>
                <p>你也可以去<a class="blue" href="{{urlfor "home.HomeController.Cate"}}">全部作品</a>找书</p>
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
                        <ul class="all-img-list cf search-list">
						{{range .Novs}}
                            <li>
								<div class="book-img-box">
									<a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank" class="f-pic-box">
										<img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}}>
									</a>
								</div>
								<div class="book-mid-info">
									<h4><a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank">{{str2html .Name}}</a></h4>
									<p class="author">
										<a class="name" href="javascript:;">{{.Author}}</a>
										<em>|</em>
										<a href="{{urlfor "home.HomeController.Cate" "id" .CateId}}">{{.CateName}}</a>
										<em>|</em>
										<span>{{.StatusName}}</span>
									</p>
									<p class="intro">
										{{substr_no_html .Desc 0 200}}
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
		<div class="detail-aside">
		  <h2 class="aside-tit">热门书籍</h2>
		  <ul class="book-lst" id="recommUl">
		  {{range .NovRanks}}
			<li> 
				<a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank" class="book-lst-tab">
					<img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}} height="100" width="75" alt="{{.Name}}">
					<div class="book-lst-tit">{{.Name}}</div>
					<div class="book-lst-txt book-lst-clr2">{{.CateName}}</div>
					<div class="book-lst-txt">{{.Author}}</div>
				</a>
			</li>
			{{end}}
		  </ul>
		</div>
    </div>

	<script>
	var params = {
		"kw": {{.Search.q}},
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

		window.location.href = {{urlfor "home.HomeController.Search"}} + "?" + url.join("&");
	}
	</script>
