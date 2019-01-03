
<link href="{{.mOut.ViewUrl}}css/detail.css?v=aa6bf34e" rel="stylesheet" type="text/css">

<header class="hd-bar">
	<a href="javascript:history.go(-1);" class="search-back" id="historyBack"></a>
	<h1>{{.Name}}</h1>
	<a href="{{urlfor "m.HomeController.Index"}}" class="search-home"></a>
</header>
<div class="nov_detail">
	<div class="am-btn-group am-btn-group-justify am-margin-vertical">
		<a class="am-btn am-btn-default" role="button" href="javascript:void(0)" onclick="light('off')">关灯</a>
		<a class="am-btn am-btn-default" role="button" href="javascript:void(0)" onclick="light('on')">开灯</a>
		<a class="am-btn am-btn-default" role="button" href="javascript:void(0)" onclick="font('big')">大字</a>
		<a class="am-btn am-btn-default" role="button" href="javascript:void(0)" onclick="font('middle')">中字</a>
		<a class="am-btn am-btn-default" role="button" href="javascript:void(0)" onclick="font('small')">小字</a>
	</div>
	<hr /> 
  
	<article class="am-article" style="font-size: 22px">
	  <div class="am-article-hd">
		<h3>{{.Chap.Title}}</h3>
	  </div>

	  <div class="am-btn-group am-btn-group-justify am-margin-vertical">
	  {{if ne .PreUrl ""}}
		<a class="am-btn am-btn-default" role="button" href="{{urlfor "m.SnatchController.Detail" "url" .PreUrl "source" .Source "name" .Name "nov_url" .Link}}">上一章</a>
	  {{else}}
		<span class="am-btn am-btn-default" role="button">没有了</span>
	  {{end}}
		<a class="am-btn am-btn-default" role="button" href="{{urlfor "m.SnatchController.Index" "url" .Link "source" .Source}}">目录</a>
	  {{if ne .NextUrl ""}}
		<a class="am-btn am-btn-default" role="button" href="{{urlfor "m.SnatchController.Detail" "url" .NextUrl "source" .Source "name" .Name "nov_url" .Link}}">下一章</a>
	  {{else}}
		<span class="am-btn am-btn-default" role="button">没有了</span>
	  {{end}}
	  </div>

	  <div class="am-article-bd">
		{{str2html .Chap.Desc}}
	  </div>

	  <div class="am-btn-group am-btn-group-justify am-margin-vertical">
	  {{if ne .PreUrl ""}}
		<a class="am-btn am-btn-default" role="button" href="{{urlfor "m.SnatchController.Detail" "url" .PreUrl "source" .Source "name" .Name "nov_url" .Link}}">上一章</a>
	  {{else}}
		<span class="am-btn am-btn-default" role="button">没有了</span>
	  {{end}}
		<a class="am-btn am-btn-default" role="button" href="{{urlfor "m.SnatchController.Index" "url" .Link "source" .Source}}">目录</a>
	  {{if ne .NextUrl ""}}
		<a class="am-btn am-btn-default" role="button" href="{{urlfor "m.SnatchController.Detail" "url" .NextUrl "source" .Source "name" .Name "nov_url" .Link}}">下一章</a>
	  {{else}}
		<span class="am-btn am-btn-default" role="button">没有了</span>
	  {{end}}
	  </div>
	</article>
</div>

<script type="text/javascript">
function light(off) {
    var bgcolor = '#222222';
    var color = '#999999';

    if(off != 'off') {
        var bgcolor = '#f9f9f9';
        var color = '#000000';
    }

    document.cookie = "light=" + off + ";path=/";

    document.body.style.backgroundColor = bgcolor;
    document.body.style.color = color;

    document.getElementsByTagName('footer')[0].style.backgroundColor = bgcolor;
    document.getElementsByTagName('footer')[0].style.color = color;

    var btnEl = document.getElementsByClassName('am-btn-default');
    var total = btnEl.length;
    for (var i = 0; i < total; i++) {
        document.getElementsByClassName('am-btn-default')[i].style.backgroundColor = bgcolor;
        document.getElementsByClassName('am-btn-default')[i].style.color = color;
    }

    var btnEl = document.getElementsByClassName('am-gotop')[0].getElementsByTagName('a');
    var total = btnEl.length;
    for (var i = 0; i < total; i++) {
        btnEl[i].style.backgroundColor = bgcolor;
        btnEl[i].style.color = color;
    }
}

function font(size) {
    var big = '26px';
    var middle = '22px';
    var small = '16px';

    switch(size) {
        case 'big':
            document.getElementsByTagName('article')[0].style.fontSize = big;
            break;
        case 'middle':
            document.getElementsByTagName('article')[0].style.fontSize = middle;
            break;
        case 'small':
            document.getElementsByTagName('article')[0].style.fontSize = small;
            break;
    }

    document.cookie = "font="+size+";path=/";
}
</script>
