
<link href="{{.mOut.ViewUrl}}css/bookstore.css?v=aa6bf34e" rel="stylesheet" type="text/css">
<link href="{{.mOut.ViewUrl}}css/detail.css?v=aa6bf34e" rel="stylesheet" type="text/css">

<header class="hd-bar">
	<a href="javascript:history.go(-1);" class="search-back" id="historyBack"></a>
	<h1 style="text-align: center;">{{.Title}}</h1>
	<a href="{{urlfor "m.HomeController.Index"}}" class="search-home"></a>
</header>

<div class="column-wrap">
	<ul class="vertical-list multiline-intro" id="cate_list">

		{{range .Novels}}
		<a href="{{urlfor "m.BookController.Index" ":id" .Id}}">
		<li>
			<div class="book-cover book-cover-size72"><img src="{{$.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Cover}}" alt="{{.Name}}"></div>
			<div class="book-detail">
				<h3 class="book-title">{{.Name}}</h3>
				<p class="book-author"><em>{{.Author}}</em> | <em>{{.CateName}}</em></p>
				<p class="book-author"><em>{{.ChapterTitle}}</em></p>
				<div class="book-intro">{{.Desc | str2html}}</div>
			</div>
		</li>
		</a>
		{{end}}

	</ul>
	
	{{if .IsNext}}
	<div class="load-more" data-on="true">加载更多</div>
	{{end}}
</div>

<a href="javascript:void(0)" class="gotop" id="gotop" style="display:none"></a>

<script type="text/javascript">

var nav_fold="off";
var p = 1;
var is_load = true;

$(document).ready(function() {
	Echo.init()

	// 自动滚动加载
	$(window).scroll(function() { 
		if ($('.load-more').length > 0 && document.body.scrollTop+document.body.clientHeight>$('.load-more').offset().top - 30) {
			p++;
			getIndexList();
		}
	});

	$(".load-more").click(function() {
		if ($(this).data("on") == "true") {
			p++;
			getIndexList();
		}
	})

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

			_html += '<a href="{{urlfor "m.BookController.Index"}}/' + item.id + '">';
			_html += '<li>';
			_html += '	<div class="book-cover book-cover-size72"><img src="' + nocover + '" alt="' + item.name + '"></div>';
			_html += '  <div class="book-detail">';
			_html += '     <h3 class="book-title">' + item.name + '</h3>';
			_html += '<p class="book-author"><em>' + item.author + '</em> | <em>' + item.cate_name + '</em></p>';
			_html += '<div class="book-intro">' + item.desc + '</div>';
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
			data:{p: p, act: "{{.aOut.Action}}"},
			url: {{urlfor "api.BookController.AjaxNovels"}},
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

<script type="text/javascript">
	$(document).ready(function() {
		$(window).bind("scroll", $.debounce(500,function() {
			if (document.body.scrollTop > $(window).height()*0.5) {
				$('#gotop').show();
			} else {
				$('#gotop').hide();
			}
		}));
		$('#gotop').on('click',function() {
			window.scrollTo(0, 0);
		});
	})
</script>
