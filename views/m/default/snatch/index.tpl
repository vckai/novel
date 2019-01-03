
	<link href="{{.mOut.ViewUrl}}css/detail.css?v=aa6bf34e" rel="stylesheet" type="text/css">

	<header class="hd-bar">
		<a href="javascript:history.go(-1);" class="search-back" id="historyBack"></a>
		<h1>{{.Info.Nov.Name}}</h1>
		<a href="{{urlfor "m.HomeController.Index"}}" class="search-home"></a>
	</header>

    <div class="detail-top">
        <div class="detail-wrap">
            <div class="detail-pic"><img src="{{.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Info.Nov.Cover}}" width="100" height="135" alt="{{.Info.Nov.Name}}"></div>
            <div class="detail-main">
                <h3 class="detail-title">{{.Info.Nov.Name}}</h3>
                {{.Info.Nov.Author}} | {{.Info.Nov.CateName}}
				<br />
				未知
				<br />
                
                <div>{{datetime .Info.Nov.CreatedAt "2006-01-02"}}</div>
            </div>
        </div>
    </div>

    <div class="column-wrap">
	{{if not_nil .FirstChap}}
        <div class="detail-read-btn">
			<a href="{{urlfor "m.SnatchController.Detail" "source" $.Info.Source "url" .FirstChap.Link "name" $.Info.Nov.Name "nov_url" $.Info.Url}}">开始阅读</a>
			<a id="down_all" href="javascript:void(0)">离线全本</a>
		</div>
	{{end}}

	    <div id="s_descr" class="detail-summary fold">{{substr_no_html $.Info.Nov.Desc 0 70}}...</div>
	    <div id="l_descr" style="display:none" class="detail-summary">{{str2html .Info.Nov.Desc}}</div>
    </div>

    <div class="column-wrap">
        <h2 class="index-title"><a href="javascript:void(0)" class="index-sort">倒序</a><strong>目录</strong>共{{.ChapNum}}章</h2>

        <div class="index-new"><a href="{{urlfor "m.SnatchController.Detail" "source" $.Info.Source "url" .FirstChap.Link "name" $.Info.Nov.Name "nov_url" $.Info.Url}}"><span class="index-tag">{{datetime $.Info.Nov.ChapterUpdatedAt "01-02 15:04"}}</span>{{.FirstChap.Title}}</a></div>

        <ol class="index-list" id="index-list"></ol>
    </div>

	<script type="text/javascript">
		var asc = 'asc';
		var chaps = {{.Chaps}};
		var chap_len = 0;
		var url = {{urlfor "m.SnatchController.Detail" "source" $.Info.Source "name" $.Info.Nov.Name "nov_url" $.Info.Url}};

		$(document).ready(function() {
			Echo.init();	
			chaps = eval(chaps);
			chap_len = chaps.length;
			getChapsByAsc();


			$('a.index-sort').on('click', function() {
				if (asc == 'asc') {
					asc = 'desc';
					$(this).html("顺序");
					getChapsByDesc();
				} else {
					asc = 'asc';
					$(this).html("倒序");
					getChapsByAsc();
				}
			});
			
			$('#s_descr').on('click', function() {
				$('#s_descr').hide();
				$('#l_descr').show();
			});
		});

		function getChapsByAsc() {
			$('ol.index-list').empty();
			var _html = '';
			for (var i=0; i<chap_len; i++) {
				var item = chaps[i].Chap;
				var name = "<b>[" + item.ChapterNo + ']</b> '+ item.Title;
				_html += '<a href="' + url + '&url=' + item.Link + '"><li>'+ name + '</li></a>';
			}
			
			$('ol.index-list').append(_html);
		}

		function getChapsByDesc() {
			$('ol.index-list').empty();
			var _html = '';
			for (var i=chap_len-1; i>=0; i--) {
				var item = chaps[i].Chap;
				var name = "<b>[" + item.ChapterNo + ']</b> '+ item.Title;
				_html += '<a href="' + url + '&url=' + item.Link + '"><li>'+ name + '</li></a>';
			}
			
			$('ol.index-list').append(_html);
		}
	</script>
