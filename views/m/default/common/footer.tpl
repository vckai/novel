
    <footer>
        <form method="GET" action="{{urlfor "m.BookController.Search"}}" id="foot_search_form">
            <div class="foot-search">
                <input style="font-size:17px" type="search" name="keyword" value="" class="foot-search-input" id="novelKeyword_footer" autocapitalize="off" autocorrect="off" maxlength="2048" autocomplete="off">
                <button type="submit" class="foot-search-submit" value="" id="footer_submit_btn"></button>
            </div>
        </form>
        <nav>
            <a href="{{urlfor "m.HomeController.Index"}}">首页</a>-
            <a href="">免责</a>
            -<a href="{{urlfor "m.HomeController.Feedback"}}">意见反馈</a>-
            <a id="footer_login" href="javascript:void(0)">登录</a>
        </nav>
 
        <div class="foot-copyright">{{.aOut.Copyright}} {{.aOut.Icp}}</div>
		<div class="foot-copyright" style="font-size: 12px;">{{.aOut.Title}}所有内容均来自互联网和用户上传，如果侵权请联系我们删除！{{str2html .aOut.StatisticsCode}}</div>
    </footer>

    <script type="text/javascript" src="{{.mOut.ViewUrl}}js/util.js" charset="utf-8"></script>
    <script type="text/javascript" src="{{.mOut.ViewUrl}}js/echo.js" charset="utf-8"></script>

    <script type="text/javascript">
    	$('.search-btn').on('click',function() {
    		$('.search-wrap').show();
    		$('#keyword').focus();
    	});
    	$('.search-cancel').on('click',function() {
    		$('.search-wrap').hide();
    	});
    </script>
