<!DOCTYPE html>
<html id="html">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <meta name="renderer" content="webkit">
    <title>{{.Chap.Title}} - {{.Nov.Name}} - {{.aOut.Title}}</title>
    <meta name="keywords" content="{{.aOut.Keyword}}">
    <meta name="description" content="{{.aOut.Description}}">

    <link rel="stylesheet" href="{{.mOut.ViewUrl}}css/style.css">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript">
        if (screen.width < 1280) {
            document.documentElement.setAttribute('class', 'screen-small');
        }
    </script>
    <style>
        html {
            font-size: 62.5%;
            /* 10÷16=62.5% */
        }

        .book-list {
            padding: 70px 0 0.5em;
            background: #FDF9F3;
            width: 100%;
            font-size: 18px
        }

        .bf {
            text-indent: 0 !important;
        }

        c {
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
            <div class="nav-logo"><a href="{{urlfor "home.HomeController.Index"}}" title="{{.aOut.Title}}"><i
                        class="icon icon-logo"></i></a></div>
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
                            <a href="javascript:;" class="tool-set-default tool-set-selected" data-theme="#f5e9d7"><span
                                    class="tool-set-text">默认</span></a>
                            <a href="javascript:;" class="tool-set-green" data-theme="#cee6d2"><span
                                    class="tool-set-text">绿色</span></a>
                            <a href="javascript:;" class="tool-set-blue" data-theme="#c4d6e7"><span
                                    class="tool-set-text">蓝色</span></a>
                            <a href="javascript:;" class="tool-set-white" data-theme="white"><span
                                    class="tool-set-text">白色</span></a>
                            <a href="javascript:;" class="tool-set-eye" data-theme="#E3EDCD"
                                style="background-color:#E3EDCD"><i class="icon icon-set-eye"></i><span
                                    class="tool-set-text">护眼</span></a>
                            <a href="javascript:;" class="tool-set-night" data-theme="rgb(34, 34, 34)"
                                style="background-color:rgb(34, 34, 34)"><i class="icon icon-set-night"></i><span
                                    class="tool-set-text">夜间</span></a>
                        </div>
                    </div>
                    <div class="tool-set-tr">
                        <div class="tool-set-th">
                            文字大小
                        </div>
                        <div class="tool-set-font" data-set="font">
                            <a href="javascript:;" data-font="minus" onclick="fontSizeMinus()">A-</a>
                            <a href="javascript:;" class="tool-set-fontsize" id="wordSize">18</a>
                            <a href="javascript:;" data-font="plus" onclick="fontSizePlus()">A+</a>
                        </div>
                    </div>

                    <div class="tool-set-tr">
                        <div class="tool-set-th">
                            文字间距
                        </div>
                        <div class="tool-set-font" data-set="font">
                            <a href="javascript:;" data-font="minus" onclick="fontSpacingMinus()">A-</a>
                            <a href="javascript:;" class="tool-set-fontsize" id="wordSpacing">0</a>
                            <a href="javascript:;" data-font="plus" onclick="fontSpacingPlus()">A+</a>
                        </div>
                    </div>

                    <!-- <div class="tool-set-tr">
					<div class="tool-set-th">
						阅读方式
					</div>
					<div class="tool-set-mode" data-set="mode">
						<a href="javascript:;" data-mode="horizon"><i class="icon icon-set-horizon"></i>左右翻页</a>
						<a href="javascript:;" data-mode="vertical" class="tool-set-selected"><i class="icon icon-set-vertical"></i>上下滚屏</a>
					</div>
				</div> -->
                    <div class="tool-set-tr">
                        <div class="tool-set-th">
                            滚屏(秒)
                        </div>
                        <div class="tool-set-autoscroll" data-set="autoscroll">
                            <a href="javascript:;" data-autoscroll="close" class="tool-set-selected" onclick="closeautoRoll()">关闭</a>
                            <a href="javascript:;" data-font="minus" onclick="autoRollMinus()">-</a>
                            <a href="javascript:;" class="tool-set-fontsize" id="autoRoll">0</a>
                            <a href="javascript:;" data-font="plus" onclick="autoRollPlus()">+</a>
                        </div>
                    </div>
                </div>
                <div class="tool-help">
                    <div class="tool-help-title">键盘快捷键</div>
                    <div class="tool-help-keyboard">
                        <p>F11全屏阅读 / 退出全屏阅读</p>
                        <p> <i class="fa fa-long-arrow-down"></i><i class="fa fa-long-arrow-down"></i>左右键盘  (上一页、下一页）</p>
                        <p><i class="fa fa-long-arrow-up"></i><i class="fa fa-long-arrow-down"></i>上下移动（上下移动）</p>
                    </div>
                    <div class="tool-help-btn"><a href="javascript:;">我知道了</a></div>
                </div>
                <div class="tool-dir wp">
                    <div class="tool-close"><a href="javascript:;"><i class="icon icon-close"></i></a></div>
                    <div class="tool-dir-title">目录</div>
                    <div class="tool-dir-bar"><a class="javascript:void(0);"><span class="tool-dir-drag"></span></a>
                    </div>
                    <div class="tool-dir-list">
                        <ul>
                            {{range .Chaps}}
                            <li id="dir_li_{{.Id}}" name="{{.ChapterNo}}">
                                <a href="{{urlfor "home.BookController.Detail" "id" .Id "novid" $.Nov.Id}}"
                                    data-chap-id="{{.Id}}" {{if eq $.Chap.Id .Id}}class="tool-dir-current" {{end}}>
                                    <span class="tool-dir-index">{{.ChapterNo}}</span>
                                    <span class="tool-dir-status"><i class="icon"></i></span>{{.Title}}</a>
                            </li>
                            {{end}}
                        </ul>
                    </div>
                </div>
            </div>
            <div id="toolbtn">
                <a href="javascript:;" class="toolbtn-dir"><i class="fa fa-list-ul"></i><span
                        class="help-text">查看目录</span></a>
                <a href="javascript:;" class="toolbtn-set" name="tool-setting"><i class="fa fa-cog"></i><span
                        class="help-text">修改设置</span></a>
                <a href="javascript:;" class="toolbtn-fullscreen"><i class="fa fa-arrows-alt"></i><span
                        class="help-text">全屏模式</span></a>
                <a href="javascript:;" class="toolbtn-help"><i class="fa fa-question-circle-o"></i><span
                        class="help-text">查看帮助</span></a>

                <a class="toolbtn-prev" style="margin-top: 30px;height: 0px;"></a>

                {{if not_nil .Pre}}
                <a href="{{urlfor "home.BookController.Detail" "id" .Pre.Id "novid" .Nov.Id}}" class="toolbtn-prev"><i
                        class="fa fa-chevron-up"></i><i class="icon icon-tool-prev"></i><span
                        class="help-text">查看上一页</span></a>
                {{end}}
                {{if not_nil .Next}}
                <a href="{{urlfor "home.BookController.Detail" "id" .Next.Id "novid" .Nov.Id}}" class="toolbtn-next"><i
                        class="fa fa-chevron-down"></i><i class="icon icon-tool-next"></i><span
                        class="help-text">查看下一页</span></a>
                {{end}}

            </div>
            <div class="book-header">
                <div class="book-header-wrap">
                    <div id="bookshelf">
                        <div class="bookshelf-btn">
                            <a href="javascript:;" class="toolbtn-bookshelf"><i
                                    class="icon icon-tool-bookshelf"></i></a>
                            <span class="help-text">书籍信息</span>
                        </div>
                        <div class="bookshelf-book">
                            <div class="bookshelf-book-close">
                                <a href="javascript:;"><i class="icon icon-close"></i></a>
                            </div>
                            <div class="bookshelf-book-info">
                                <em class="bookshelf-book-title">{{.Nov.Name}}</em>
                                <a href="{{urlfor "home.BookController.Index" "id" .Nov.Id}}"
                                    class="bookshelf-book-cover">
                                    <img src="{{.mOut.ViewUrl}}img/nocover.jpg"
                                        {{if ne .Nov.Cover ""}}data-echo="{{.Nov.Cover}}" {{end}}>
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
        var setting = {
            bgColor: null, //背景颜色
            fontSize: 18,//字体大小
            fontSpacing: 0,//文字间距
            autoRoll: 0 //自动滚屏
        }

        $(function () {
            init()

        })

        //初始化
        function init() {
            initSettingVar()
            initSetting(setting)
            bgColorClick()
            autoRollDsq(setting)
            $("#autoRoll").text(setting.autoRoll)
            console.log(setting)
        }

        //初始设置变量
        function initSettingVar() {
            var d = localStorage.getItem("local_setting"); //获取本地存储
            if (d != null) {
                setting = JSON.parse(d);
            }
        }

        //初始设置
        function initSetting(settin_var) {
            setBgColor(settin_var.bgColor)
            setFontSize(settin_var.fontSize)
            setFontSpacing(settin_var.fontSpacing)
        }

        //设置背景颜色
        function setBgColor(color_var) {
            $("#html").css("background-color", color_var)
            $("#wrap").css("background-color", color_var)
            setting.bgColor = color_var
            localStorage.setItem("local_setting", JSON.stringify(setting));
        }

        //设置字体大小
        function setFontSize(size_var) {
            $(".book-content").css("font-size", size_var)
            $("#wordSize").text(size_var);
            setting.fontSize = size_var
            localStorage.setItem("local_setting", JSON.stringify(setting));
        }

        //设置字体间距
        function setFontSpacing(spacing_var) {
            $(".book-content").css("letter-spacing", spacing_var)
            $("#wordSpacing").text(spacing_var);
            setting.fontSpacing = spacing_var
            localStorage.setItem("local_setting", JSON.stringify(setting));
        }


        //设置自动滚屏
        function setAutoRoll(sd) {
        }

        //设置背景颜色单击事件
        function bgColorClick() {
            $("div[data-set='theme'] a").click(function () {
                setBgColor($(this).attr("data-theme"))
            })
        }

        //设置字体大小 - 事件
        function fontSizeMinus() {
            var minusSize = parseInt($("#wordSize").text()) - 1
            if (minusSize < 10) {
                alert("字体太小眼睛会瞎哦:)")
            } else {
                $("#wordSize").text(minusSize);
                setFontSize(minusSize)
            }
        }

        //设置字体大小 + 事件
        function fontSizePlus() {
            var plusSize = parseInt($("#wordSize").text()) + 1
            $("#wordSize").text(plusSize)
            setFontSize(plusSize)

        }

        //设置字体间距 - 事件
        function fontSpacingMinus() {
            var wordSpacing = parseInt($("#wordSpacing").text()) - 1
            if (wordSpacing < 0) {
                alert("间距太小眼睛会瞎哦:)")
            } else {
                $("#wordSpacing").text(wordSpacing);
                setFontSpacing(wordSpacing)
            }
        }

        //设置字体间距 + 事件
        function fontSpacingPlus() {
            var wordSpacing = parseInt($("#wordSpacing").text()) + 1
            $("#wordSpacing").text(wordSpacing)
            setFontSpacing(wordSpacing)
        }

        // 自动滚动加载定时器
		var timer 
        function autoRollDsq(setting_var) {
            if(setting_var.autoRoll == null || setting_var.autoRoll == 0){
                setting_var.autoRoll = 0
                //清除定时器
                clearInterval(timer);
				return
            }
            //使用定时器
            timer = setInterval(function(){
                var scrollTop = $(this).scrollTop();
                var scrollHeight = $(document).height();
                var windowHeight = $(this).height();

                if (scrollHeight - windowHeight == scrollTop) {
                    //清除定时器
                    clearInterval(timer);

                    //下一页
                    var url = ""
                    {{if not_nil .Next}}
                        url = '{{urlfor "home.BookController.Detail" "id" .Next.Id "novid" .Nov.Id}}'
                    {{end}}
                    if (url == ""){
                        alert("已经到底啦～没有下一页:)")
                    }else{
                        window.location.href = window.location.protocol+"//"+window.location.host + url;
                    }
                } else {
                    // window.scrollTo(0, scrollTop + 100);
                    // $("#html").scrollTop(scrollTop + 500)
					$("html,body").animate({ scrollTop: scrollTop + 500 }, 500);//100为滚动条的位置，1000为滚动的时延
                }
            }, setting_var.autoRoll * 1000);
        }

        //设置自动滚屏 - 事件
        function autoRollMinus(){
            //清除定时器
            clearInterval(timer);
            var autoRoll = parseInt($("#autoRoll").text()) - 1

            if(autoRoll < 0){
                alert("不能少于0秒 :(")
            }else{
                $("#autoRoll").text(autoRoll)
                setting.autoRoll = autoRoll
                localStorage.setItem("local_setting", JSON.stringify(setting));
                autoRollDsq(setting)
            }

        }

        //设置自动滚屏 + 事件
        function autoRollPlus(){
            //清除定时器
            clearInterval(timer);
            var autoRoll = parseInt($("#autoRoll").text()) + 1
            $("#autoRoll").text(autoRoll)
            setting.autoRoll = autoRoll
            localStorage.setItem("local_setting", JSON.stringify(setting));
            autoRollDsq(setting)
        }

        //设置自动滚屏 关闭 事件
        function closeautoRoll(){
            //清除定时器
            clearInterval(timer);
            setting.autoRoll = 0
            $("#autoRoll").text("0")
            localStorage.setItem("local_setting", JSON.stringify(setting));
        }


    </script>

</body>

</html>