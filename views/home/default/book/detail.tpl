<!DOCTYPE html>
<html class="theme-default autoscroll-close mode-vertical autopay-close fontSize-18">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	<meta name="renderer" content="webkit">
	<title>{{.Chap.Title}} - {{.Nov.Name}} - {{.aOut.Title}}</title>
	<meta name="keywords" content="{{.aOut.Keyword}}">
	<meta name="description" content="{{.aOut.Description}}">

	<link rel="stylesheet" href="{{.mOut.ViewUrl}}css/style.css">
<script type="text/javascript">
	if (screen.width < 1280) {
		document.documentElement.setAttribute('class', 'screen-small');
	}
</script>
<style>
html{
	font-size: 62.5%; /* 10÷16=62.5% */
}
.book-list {
	padding: 70px 0 0.5em;
	background: #FDF9F3;
	width: 100%;
	font-size: 18px
}
.bf {
  text-indent: 0!important;
}
c{
	/*
	padding-bottom: 1em;
	line-height: 1em;
    font-size: 1.7em;
    */
    font-weight: normal;
    color: #A34544;
}
</style>
</head>
<body class="bookshelf-bigactive bookheader-active bookheader-topactive">
<div id="nav">
	<div class="nav-wrap wp">
		<div class="nav-logo"><a href="{{urlfor "home.HomeController.Index"}}" title="{{.aOut.Title}}"><i class="icon icon-logo"></i></a></div>
		<div class="nav-search">
			<form action="{{urlfor "home.HomeController.Search"}}" autocomplete="off">
				<input type="text" name="kw" placeholder="搜索书籍" title="请输入搜索关键字">
				<button type="submit" title="点击搜索"><i class="icon icon-search-btn"></i></button>
			</form>
			<div class="nav-search-list">
				<ul>
				</ul>
			</div>
		</div>
		<!--
		 <div class="nav-login">
			<a href="javascript:;" id="userLogin">登录</a><span class="nav-login-pipe">|</span>
			<a href="" class="nav-login-reg">注册</a>
		 </div>
		 -->
	</div>
</div>

<div id="wrap">
	<div id="main" class="wp">
		<div id="tool" class="wp">
			<div class="tool-set">
				<div class="tool-close"><a href="javascript:;"><i class="icon icon-close"></i></a></div>
				<div class="tool-set-tr">
					<div class="tool-set-th">主题模式</div>
					<div class="tool-set-cle" data-set="theme">
						<a href="javascript:;" class="tool-set-default tool-set-selected" data-theme="default"><span class="tool-set-text">默认</span></a>
						<a href="javascript:;" class="tool-set-green" data-theme="green"><span class="tool-set-text">绿色</span></a>
						<a href="javascript:;" class="tool-set-blue" data-theme="blue"><span class="tool-set-text">蓝色</span></a>
						<a href="javascript:;" class="tool-set-white" data-theme="white"><span class="tool-set-text">白色</span></a>
						<a href="javascript:;" class="tool-set-eye" data-theme="eye"><i class="icon icon-set-eye"></i><span class="tool-set-text">护眼</span></a>
						<a href="javascript:;" class="tool-set-night" data-theme="night"><i class="icon icon-set-night"></i><span class="tool-set-text">夜间</span></a>
					</div>
				</div>
				<div class="tool-set-tr">
					<div class="tool-set-th">
						文字大小
					</div>
					<div class="tool-set-font" data-set="font">
						<a href="javascript:;" data-font="minus">A-</a>
						<a href="javascript:;" class="tool-set-fontsize" id="wordSize">18</a>
						<a href="javascript:;" data-font="plus">A+</a>
					</div>
				</div>
				<div class="tool-set-tr">
					<div class="tool-set-th">
						阅读方式
					</div>
					<div class="tool-set-mode" data-set="mode">
						<a href="javascript:;" data-mode="horizon"><i class="icon icon-set-horizon"></i>左右翻页</a>
						<a href="javascript:;" data-mode="vertical" class="tool-set-selected"><i class="icon icon-set-vertical"></i>上下滚屏</a>
					</div>
				</div>
				<div class="tool-set-tr">
					<div class="tool-set-th">
						自动滚屏
					</div>
					<div class="tool-set-autoscroll" data-set="autoscroll">
						<a href="javascript:;" data-autoscroll="close" class="tool-set-selected">关闭</a>
						<a href="javascript:;" data-autoscroll="slow">慢</a>
						<a href="javascript:;" data-autoscroll="normal">中</a>
						<a href="javascript:;" data-autoscroll="fast">快</a>
					</div>
				</div>
			</div>
			<div class="tool-help">
				<div class="tool-help-title">键盘快捷键</div>
				<div class="tool-help-keyboard">
					<p>全屏阅读 / 退出全屏阅读</p>
					<p>前后翻页（横向阅读模式可用）</p>
					<p>上下移动（竖向阅读模式可用）</p>
				</div>
				<div class="tool-help-btn"><a href="javascript:;">我知道了</a></div>
			</div>
			<div class="tool-dir wp">
				<div class="tool-close"><a href="javascript:;"><i class="icon icon-close"></i></a></div>
				<div class="tool-dir-title">目录</div>
				<div class="tool-dir-bar"><a class="javascript:void(0);"><span class="tool-dir-drag"></span></a></div>
				<div class="tool-dir-list">
					<ul>
					{{range .Chaps}}
						<li id="dir_li_{{.Id}}" name="{{.ChapterNo}}">    
							<a href="{{urlfor "home.BookController.Detail" "id" .Id "novid" $.Nov.Id}}" data-chap-id="{{.Id}}" {{if eq $.Chap.Id .Id}}class="tool-dir-current"{{end}}>
								<span class="tool-dir-index">{{.ChapterNo}}</span>
								<span class="tool-dir-status"><i class="icon"></i></span>{{.Title}}</a>   
						</li>
					{{end}}
					</ul>
				</div>
			</div>
		</div>
		<div id="toolbtn">
			<a href="javascript:;" class="toolbtn-dir"><i class="icon icon-tool-dir"></i><span class="help-text">查看目录</span></a>
			<!--<a href="javascript:;" class="toolbtn-set" name="tool-setting"><i class="icon icon-tool-set"></i><span class="help-text">修改设置</span></a>-->
			<a href="javascript:;" class="toolbtn-fullscreen"><i class="icon icon-tool-fullscreen"></i><span class="help-text">全屏模式</span></a>
			<a href="javascript:;" class="toolbtn-help"><i class="icon icon-tool-help"></i><span class="help-text">查看帮助</span></a>
			<a href="javascript:;" class="toolbtn-prev"><i class="icon icon-tool-up"></i><i class="icon icon-tool-prev"></i><span class="help-text">查看上一页</span></a>
			{{if not_nil .Next}}
			<a href="{{urlfor "home.BookController.Detail" "id" .Next.Id "novid" .Nov.Id}}" class="toolbtn-next"><i class="icon icon-tool-down"></i><i class="icon icon-tool-next"></i><span class="help-text">查看下一页</span></a>
			{{end}}
		</div>
		<div class="book-header">
			<div class="book-header-wrap">
				<div id="bookshelf">
					<div class="bookshelf-btn">
						<a href="javascript:;" class="toolbtn-bookshelf"><i class="icon icon-tool-bookshelf"></i></a>
						<span class="help-text">书籍信息</span>
					</div>
					<div class="bookshelf-book">
						<div class="bookshelf-book-close">
							<a href="javascript:;"><i class="icon icon-close"></i></a>
						</div>
						<div class="bookshelf-book-info">
							<em class="bookshelf-book-title">{{.Nov.Name}}</em>
							<a href="{{urlfor "home.BookController.Index" "id" .Nov.Id}}" class="bookshelf-book-cover">
								<img src="{{.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Nov.Cover ""}}data-echo="{{.Nov.Cover}}"{{end}}>
							</a>
						</div>
					</div>
				</div>
				<div class="book-wrap">
					<a href="javascript:;" class="book-ctrl">
						<i class="icon icon-ctrl-hide"></i>
						<span class="book-ctrl-hide">隐藏</span>
						<span class="book-ctrl-show">显示</span>工具栏
					</a>
					<p class="book-header-title">{{.Chap.Title}}</p>
				</div>
			</div>
		</div>
		<div class="book-horizon-btn book-wrap">
			<div class="book-horizon-prev"></div>
			<div class="book-horizon-next"></div>
		</div>
		<div class="book-view">
			 <div class="book-horizon">
				<div class="book-list" style="font-size: 18px;">   
					<div class="book" id="book_{{.Chap.Id}}" ckey="{{.Chap.Id}}">    
						<div class="book-wrap">     
							<h2 class="book-title">{{.Chap.Title}}</h2>     
							<div class="book-content">
								{{str2html .Chap.Desc}}
							</div>
						</div>   
					</div>  
				</div>
				<div class="load-more">正在加载...</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="{{.aOut.ViewUrl}}js/jquery.min.js" charset="utf-8"></script>
<script type="text/javascript" src="{{.aOut.ViewUrl}}js/jquery.cookie.js" charset="utf-8"></script>
<script type="text/javascript" src="{{.mOut.ViewUrl}}js/tool.js" charset="utf-8"></script>

<script type="text/javascript">

window.GLOBAL = window.GLOBAL || {};
GLOBAL.font = $.cookie("kaqiu-fontSize") || 18;
GLOBAL.viewHeight = document.documentElement.clientHeight - 180 ;
GLOBAL.space = parseInt(GLOBAL.font) * 2 ; //line-height
GLOBAL.mode = $.cookie("kaqiu-mode") || "vertical";
GLOBAL.currChap = $.cookie("kaqiu-currentChapId") || '{{.Chap.Id}}' ;
GLOBAL.isLoad = true;

GLOBAL.nextChapId = '{{if not_nil .Next}}{{.Next.Id}}{{end}}';

// 自动滚动加载
$(window).scroll(function() {
　　var scrollTop = $(this).scrollTop();
　　var scrollHeight = $(document).height();
　　var windowHeight = $(this).height();
　　if ((scrollTop + windowHeight) / scrollHeight > 0.9) {
		getNextChapter();
　　}
});

// 加载下一章节内容
function getNextChapter() {
	if (!GLOBAL.isLoad) {
		return false;
	}

	if (!GLOBAL.nextChapId) {
		$(".load-more").text("没有了");
		$(".load-more").show();
		return false;
	}

	$(".load-more").text("正在加载...");
	$(".load-more").show();
	GLOBAL.isLoad = false;
	var lastId = GLOBAL.nextChapId;
	$.ajax({ 
		type: "post",
		dataType: "json",
		data:{id: lastId, novid: {{.Nov.Id}}},
		url: {{urlfor "home.BookController.AjaxChap"}},
		success: function(data) {
			if (data.ret == 0 && data.data.chap) {
				GLOBAL.isLoad = true;
				GLOBAL.nextChapId = data.data.next_id;;
				insertChapter(data.data.chap, lastId);
				if (GLOBAL.nextChapId > 0) {
					$(".load-more").hide();
				} else {
					$(".load-more").text("没有了");
				}
			} else {
				$(".load-more").text(data.msg);
			}
		}
	});
}

function insertChapter(d, lastId) {
	var html = '';
	html += '   <div class="book" id="book_'+d.id+'" ckey="'+d.id+'">'
			+ '		<div class="book-wrap"> ' 
			+ '			<h2 class="book-title">'+d.title+'</h2>'
			+ '			<div class="book-content">'
			+				d.desc 
			+ '			</div>'
			+ '		</div> '
			+ ' </div>';

	$(".book-list").append(html);
	$('.book-header-title').text(d.title);

	if (lastId > 0) {
		$('.tool-dir-list a').each(function(event) {
			$(this).removeClass('tool-dir-current');
		});
		$("#dir_li_" + lastId + " a").addClass("tool-dir-current");
	}
}

initViewHeight(parseInt(GLOBAL.font));
function initViewHeight(font) {
	switch( font ) {
	case 14 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52) ;
		break;
	case 16 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52) ;
		break;	
	case 18 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52) ;
		break;
	case 20 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52) ;
		break;
	case 22 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52) ;
		break;
	case 24 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 3) ;
		break;
	case 26 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 3) ;
		break;
	case 28 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 3) ;
		break;
	case 30 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 3) ;
		break;
	case 32 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 5) ;
		break;
	case 34 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 5) ;
		break;
	case 36 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 6) ;
		break;
	case 38 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 8) ;
		break;
	case 40 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 9) ;
		break;
	case 42 :
		GLOBAL.viewHeight = document.documentElement.clientHeight - (98 + 52 + 10) ;
		break;
	}
}

//禁用鼠标右键
function stop() { 
	return false; 
} 
//document.oncontextmenu = stop; 

function processVC(_content) {
	 content = '<p>' + _content.replace(/\s*\n\s*/g, '</p><p>').replace(/(^\s+|\s+$)/g, '') + '</p>';
	 GLOBAL.vchapter = content;
}

//根据字体大小，获取行高和段落起始空格距离
function getLineHeightAndParageraphSpacing () {
    var fontSize = parseInt(GLOBAL.font) ,
        lineHeight,
        paragraphSpacing;
    switch(fontSize) {
    	case 14:
        	lineHeight = 28 ;
        	paragraphSpacing = 16;
        	break;
        case 16:
            lineHeight = 32;
            paragraphSpacing = 18;
            break;
        case 18:
            lineHeight = 36;
            paragraphSpacing = 20;
            break;
        case 20:
            lineHeight = 40;
            paragraphSpacing = 22;
            break;
        case 22:
            lineHeight = 44;
            paragraphSpacing = 24;
            break;
        case 24:
            lineHeight = 48;
            paragraphSpacing = 28;
            break;
        case 26:
            lineHeight = 52;
            paragraphSpacing = 32;
            break;
        case 28:
            lineHeight = 56;
            paragraphSpacing = 44;
            break;
        case 30:
            lineHeight = 60;
            paragraphSpacing = 46;
            break;
        case 32:
            lineHeight = 64;
            paragraphSpacing = 48;
            break;
        case 34:
            lineHeight = 68;
            paragraphSpacing = 52;
            break;
        case 36:
            lineHeight = 72;
            paragraphSpacing = 56;
            break;
        case 38:
            lineHeight = 76;
            paragraphSpacing = 58;
            break;
        case 40:
            lineHeight = 80;
            paragraphSpacing = 62;//40
            break;
        case 42:
            lineHeight = 84;
            paragraphSpacing = 66;
            break;
            
    }
    return [fontSize, lineHeight, paragraphSpacing];
}

</script>
</body>
</html>
