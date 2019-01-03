
<link href="{{.mOut.ViewUrl}}css/bookstore.css?v=aa6bf34e" rel="stylesheet" type="text/css">
<link href="{{.mOut.ViewUrl}}css/search.css?v=aa6bf34e" rel="stylesheet" type="text/css">
<header class="hd-bar">
	<div class="logo-wrap">
		<a href="javascript:history.go(-1);" class="search-back" id="historyBack"></a>
		<h1>{{.Nov.Name}}</h1>
		<a href="{{urlfor "m.HomeController.Index"}}" class="search-home"></a>
	</div>

	<div class="search-wrap2">
		<form class="search-query2" method="GET" action="{{urlfor "m.BookController.Search"}}" id="searchform" accept-charset="utf-8">
			<input type="search" class="search-query-input" id="keyword" name="keyword">

			<button type="reset" class="search-clear" id="resetbtn" value=""></button>
			<button type="submit" class="search-btn"></button>
		</form>
	</div>
</header>

<div class="column-wrap">
{{if .Novels}}
	<ul class="vertical-list multiline-intro" id="cate_list">
		{{range .Novels}}
		<a href="{{urlfor "m.BookController.Index" "id" .Id}}">
		<li>
			<div class="book-cover book-cover-size72"><img src="{{$.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Cover}}" alt="{{html2str .Name}}"></div>
			<div class="book-detail">
				<h3 class="book-title">{{str2html .Name}}</h3>
				<p class="book-author"><em>{{.Author}}</em> | <em>{{.CateName}}</em></p>
				<p class="book-author"><em>{{.ChapterTitle}}</em></p>
				<div class="book-intro">{{str2html .Desc}}</div>
			</div>
		</li>
		</a>
		{{end}}
	</ul>
	
	{{if .IsNext}}
	<div class="load-more" data-on="true">加载更多</div>
	{{end}}
{{else}}
	<div class="bookshelf-remind">
		<img src="{{.mOut.ViewUrl}}img/noresult.png" alt="">
		<p>您所搜索的秘籍已失传</p>
		<a href="{{urlfor "m.HomeController.Index"}}" class="bookshelf-remind-btn">去书城逛逛</a>
	</div>
{{end}}

{{if not_nil .SnatchNovels}}
	<div>
		<h2>从采集站点查找</h2>
	</div>
	<ul class="vertical-list multiline-intro" id="cate_list">
		{{range .SnatchNovels}}
		<a href="{{urlfor "m.SnatchController.Index" "url" .Url "source" .Source}}">
		<li>
			<div class="book-cover book-cover-size72">
				<img src="{{$.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Nov.Cover}}" alt="{{html2str .Nov.Name}}">
			</div>
			<div class="book-detail">
				<h3 class="book-title">{{str2html .Nov.Name}}</h3>
				<p class="book-author"><em>{{.Nov.Author}}</em> | <em>{{.Title}}</em> | <em>{{.UseTime}}</em></p>
				<p class="book-author"><em>{{.Nov.ChapterTitle}}</em></p>
				<div class="book-intro">{{str2html .Nov.Desc}}</div>
			</div>
		</li>
		</a>
		{{end}}
	</ul>
{{end}}

</div>

<script type="text/javascript">

var nav_fold="off";
var p = 1;
var cid = {{.Search.cate_id}};
var is_load = true;
var q ="{{.Search.q}}";

$(document).ready(function() {
	$("#keyword").val(q);
	$("#novelKeyword_footer").val(q);
	Echo.init()

	$(".fold-btn").click(function() {
		var obj = $(this);
		if (nav_fold == "off") {
			obj.parent().addClass("unfold");
			nav_fold="on";
		} else {
			obj.parent().removeClass("unfold");
			nav_fold="off";
		}
	});
	$(".load-more").click(function() {
		if ($(this).data("on") == "true") {
			p++;
			getIndexList();
		}
	})
	$(".nav-landing li").click(function() {
		var obj = $(this);
		obj.siblings().removeClass("active");
		obj.addClass("active");
		cid = obj.find("a").data("cid");
		p = 1;
		$('#cate_list').html("");
		is_load = true;
		getIndexList();
	});

	function updateIndexList(items) {
		if (!items.list) {
			return false;
		}

		var _html = "";
		for (var i=0; i<items.list.length; i++) {
			var item = items.list[i];

			var nocover = item.cover;
			if (item.cover == "") {
				nocover = "{{.mOut.ViewUrl}}img/nocover.jpg";
			}

			_html += '<a href="{{urlfor "m.BookController.Index"}}?id=' + item.id + '">';
			_html += '<li>';
			_html += '	<div class="book-cover book-cover-size72"><img src="' + nocover + '" alt="' + item.name + '"></div>';
			_html += '  <div class="book-detail">';
			_html += '     <h3 class="book-title">' + item.name + '</h3>';
			_html += '<p class="book-author"><em>' + item.name + '</em> | <em>' + item.cate_name + '</em></p>';
			_html += '<p class="book-intro">' + item.desc + '</p>';
			_html += '</div>';
			_html += '</li>';
			_html += '</a>';
		}

		$('#cate_list').append(_html);
	}

	function getIndexList() {
		if (!is_load) {
			return false;
		}

		$(".load-more").text("正在加载...");

		$.ajax({ 
			type: "post",
			dataType: "json",
			data:{p: p, cate_id: cid},
			url: {{urlfor "m.BookController.AjaxNovels"}},
			success: function(data) {
				if (data.ret == 0) {
					if (!data.data.is_next) {
						is_load = false;
						$(".load-more").text("没有了");
					} else {
						$(".load-more").text("加载更多");
					}
					updateIndexList(data.data);
				} else {
					$(".load-more").text("加载更多");
				}
			}
		});
	}
});

</script>
