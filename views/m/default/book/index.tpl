
	<link href="{{.mOut.ViewUrl}}css/detail.css?v=aa6bf34e" rel="stylesheet" type="text/css">

	<header class="hd-bar">
		<a href="javascript:history.go(-1);" class="search-back" id="historyBack"></a>
		<h1>{{.Nov.Name}}</h1>
		<a href="{{urlfor "m.HomeController.Index"}}" class="search-home"></a>
	</header>

    <div class="detail-top">
        <div class="detail-wrap">
            <div class="detail-pic"><img src="{{.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Nov.Cover}}" width="100" height="135" alt="{{.Nov.Name}}"></div>
            <div class="detail-main">
                <h3 class="detail-title">{{.Nov.Name}}</h3>
                {{.Nov.Author}} | {{.Nov.CateName}}
				<br />
                {{.Nov.StatusName}}
				<br />
                
                <div>{{datetime .Nov.CreatedAt "2006-01-02"}}</div>
            </div>
        </div>
    </div>

    <div class="column-wrap">
	{{if not_nil .FirstChap}}
        <div class="detail-read-btn">
			<a href="{{urlfor "m.BookController.Detail" "id" .FirstChap.Id "novid" .Nov.Id}}">开始阅读</a>
			<a id="down_all" href="javascript:void(0)">离线全本</a>
		</div>
	{{end}}

	    <div id="s_descr" class="detail-summary fold">{{substr_no_html .Nov.Desc 0 70}}...</div>
	    <div id="l_descr" style="display:none" class="detail-summary">{{str2html .Nov.Desc}}</div>
    </div>

    <div class="column-wrap">
        <h2 class="index-title"><a href="javascript:void(0)" class="index-sort">倒序</a><strong>目录</strong>共{{.Nov.ChapterNum}}章</h2>
        <div class="index-new"><a href="{{urlfor "m.BookController.Detail" "id" .Nov.ChapterId "novid" .Nov.Id}}"><span class="index-tag">{{datetime .Nov.ChapterUpdatedAt "01-02 15:04"}}</span>{{.Nov.ChapterTitle}}</a></div>
        <ol class="index-list" id="index-list">
		{{range .Chaps}}
			<a href="{{urlfor "m.BookController.Detail" "id" .Id "novid" $.Nov.Id}}">	
            <li>
            	<b>[{{.ChapterNo}}]</b> {{.Title}} 
            </li>
			</a>
		{{end}}
        </ol>
		{{if .Paginator.HasPages}}
        <div class="index-page">
            <a href="javascript:void(0)" id="first_page" class="disable">首页</a>
            <a href="javascript:void(0)" id="prev_page" class="disable">上一页</a>
            <div class="index-select">
                <select id="index-select">
				{{range $index, $page := .Paginator.PageNos}}
                	<option value="{{$page}}" {{if eq $page 1}}selected="true"{{end}}>{{$page}}{{if eq $page 1}}/{{$.Paginator.PageNums}}{{end}}</option>
				{{end}}
                </select>
            </div>
            <a href="javascript:void(0)" id="next_page">下一页</a>
            <a href="javascript:void(0)" id="end_page">尾页</a>
        </div>
		{{end}}
    </div>

    {{template "m/default/common/rec.tpl" .}}

	<script type="text/javascript">

		var lastPage = {{.Paginator.PageNums}};
		var pageNo = 1;
		var prePage = pageNo;
		var asc = 'asc';

		$(document).ready(function() {
			Echo.init();	

			{{if .Paginator.HasPages}}
				resetPage(pageNo, lastPage);
			{{end}}
	
			$('a.index-sort').on('click', function() {
				if (asc == 'asc') {
					asc = 'desc';
					$(this).html("顺序");
				} else {
					asc = 'asc';
					$(this).html("倒序");
				}
				getIndexList();
			});
			
			$('#first_page').on('click', function() {
				if(!$(this).hasClass('disable')) {
					prePage = pageNo;
					pageNo = 1;
					getIndexList();
				}
			});
			
			$('#prev_page').on('click', function(){
				if(!$(this).hasClass('disable') && pageNo > 1) {
					prePage = pageNo;
					pageNo--;
					getIndexList();
				}
			});
			
			$('#next_page').on('click', function(){
				if (!$(this).hasClass('disable') && pageNo < lastPage) {
					prePage = pageNo;
					pageNo ++;	
					getIndexList();
				}
			});
	
			$('#end_page').on('click', function() {
				if (!$(this).hasClass('disable')) {
					prePage = pageNo;
					pageNo = lastPage;
					getIndexList();
				}
			});
			
			$('#index-select').on('change', function() {
				prePage = pageNo;
				pageNo = $(this).val();
				getIndexList();
			});
			
			$('#s_descr').on('click', function() {
				$('#s_descr').hide();
				$('#l_descr').show();
			});
		})

		function updateIndexList(pagedList) {
			$('ol.index-list').empty();
			var items = pagedList;
			var _html = '';
			for (var i=0; i<items.length; i++) {
				var item = items [i];
				var name = "<b>[" + item.no+']</b> '+ item.title;
				//if (item.ckey == latest) {
					//_html += '<li class="index-bookmark">'+ name + '</li>';
				//} else {
					_html += '<a href="{{urlfor "m.BookController.Detail"}}?id=' + item.id + '&novid={{.Nov.Id}}"><li>'+ name + '</li></a>';
				//}
			}

			$('ol.index-list').append(_html);
			resetPage(pageNo, lastPage);

			$('option').eq(prePage-1).html(prePage).removeAttr('selected');
			$('option').eq(pageNo-1).html(pageNo+'/'+lastPage).prop('selected', true);
		}
	
		function getIndexList() {
			$.ajax({ 
				type: "post",
				dataType: "json",
				data:{p: pageNo, asc: asc},
				url: {{urlfor "m.BookController.AjaxChaps" "id" .Nov.Id}},
				success: function(data) {
					if (data.ret == 0) {
						updateIndexList(data.data);
					}
				}
			});
		}
		
		function resetPage(pNo, maxPNo) {
			if (pNo == 1) {
				$('#first_page').addClass('disable');
				$('#prev_page').addClass('disable');
				$('#end_page').removeClass('disable');
				$('#next_page').removeClass('disable');
			} else if (pNo == maxPNo) {
				$('#end_page').addClass('disable');
				$('#next_page').addClass('disable');
				$('#first_page').removeClass('disable');
				$('#prev_page').removeClass('disable');
			} else {
				$('#first_page').removeClass('disable');
				$('#prev_page').removeClass('disable');
				$('#end_page').removeClass('disable');
				$('#next_page').removeClass('disable');
			}
		}
	</script>
