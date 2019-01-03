
    {{template "m/default/common/header.tpl" .}}

	<nav class="nav">
		<ul>
			<li class="active"><a href="javascript:void(0)">精选</a></li>
			<li><a href="{{urlfor "m.BookController.List"}}">分类</a></li>
			<li><a href="{{urlfor "m.BookController.Rank"}}">排行</a></li>
			<!--<li><a href="javascript:void(0)">书架</a></li>-->
		</ul>
	</nav>

    <div id="mySwipe" style="width: 100%; overflow: hidden;">
        <div id="banner">
		{{range $k, $v := .Banners}}
            <div class="banner" style="float: left; position: relative">
                <a href="{{$v.Link}}" id="banner_{{$k}}" type="3">
                    <img src="{{$v.Img}}" alt="{{$v.Name}}">
                </a>
            </div>
		{{end}}
        </div>
    </div>

    <nav class="nav-circle">
        <ul id="tag">
            <li><a href="{{urlfor "m.BookController.List" "cate_id" 1}}">
                <img src="{{.mOut.ViewUrl}}img/icon-1.png" alt="玄幻">玄幻</a>
            </li>
        
            <li><a href="{{urlfor "m.BookController.New"}}">
                <img src="{{.mOut.ViewUrl}}img/icon-2.png" alt="最新更新">热更</a>
            </li>
        
            <li><a href="{{urlfor "m.BookController.End"}}">
                <img src="{{.mOut.ViewUrl}}img/icon-3.png" alt="完本">完本</a>
            </li>
        
            <li><a href="{{urlfor "m.BookController.List" "cate_id" 2}}">
                <img src="{{.mOut.ViewUrl}}img/icon-4.png" alt="修真">修真</a>
            </li>
        
            <li><a href="javascript:void(0)">
                <img src="{{.mOut.ViewUrl}}img/icon-5.png" alt="听书">听书</a>
           </li>
        </ul>
    </nav>
 
    <div class="announcement">
        <blockquote>
            <div id="broadcast">
			{{range .NovTodayRecs}}
                <a href="{{urlfor "m.BookController.Index" "id" .Id}}" id="boradcast_0" type="3">
                    {{.Name}}
                </a>
			{{end}}
            </div>
        </blockquote>
    </div>
    
    <div class="column-wrap">
        <h2 class="column-title">本期强推</h2>
        <div class="horizontal-list3">
            <table>
                <tbody>
				<tr>
				{{range .NovRecs}}
					<td>
					<a href="{{urlfor "m.BookController.Index" "id" .Id}}">
						<div class="book-detail">
							<div class="book-cover"><img src="{{$.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Cover}}" alt="{{.Name}}"></div>
							<h3 class="book-title">{{.Name}}</h3>
						</div>
					</a>
					</td>
				{{end}}
                </tr>
            </tbody></table>
        </div>
    </div>
    
    <div class="column-wrap" id="block_2">
        <h2 class="column-title">小编热推</h2>
		{{if not_nil .NovHot}}
        <ul class="vertical-list">
			<a href="{{urlfor "m.BookController.Index" "id" .NovHot.Id}}">
            <li>
                <div class="book-cover book-cover-size78">
                    <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.NovHot.Cover}}" alt="{{.NovHot.Name}}">
                </div>
                <div class="book-detail">
                    <h3 class="book-title">{{.NovHot.Name}}</h3>
                    <p class="book-author"><em>{{.NovHot.Author}}</em> | <em>{{.NovHot.CateName}}</em></p>
                    <p class="book-intro">{{substr_no_html .NovHot.Desc 0 35}}...</p>
                    <p class="book-statistics">
                        <i class="book-star"></i><i class="book-star"></i><i class="book-star"></i><i class="book-star"></i><i class="book-star"></i>{{.NovHot.Views}}人阅读
                    </p>
                </div>
            </li>
			</a>
        </ul>
		{{end}}
 
		{{range .NovHots}}
        <ul class="vertical-list3">
			<a href="{{urlfor "m.BookController.Index" "id" .Id}}">
            <li>
                <h3 class="book-title">
                        {{.Name}}<em class="book-author">{{.Author}}</em>
                </h3>
                <p class="book-intro">{{substr_no_html .Desc 0 30}}...</p>
            </li>
			</a>
		{{end}}
        </ul>
    </div>
    
    <div class="column-wrap">
        <h2 class="column-title">精品推荐</h2>
        <div class="horizontal-list3">
            <table id="block_5">
                <tbody>
                    <tr>
					{{range .NovVipRecs}}
                        <td>
						<a href="{{urlfor "m.BookController.Index" "id" .Id}}">
                            <div class="book-detail">
                                <div class="book-cover">
                                    <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Cover}}" alt="{{.Name}}">
                                </div>
                                <h3 class="book-title">{{.Name}}</h3>
                            </div>
						</a>
                        </td>
					{{end}}
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
	<a href="javascript:void(0)" class="gotop" id="gotop" style="display:none"></a>

    <script type="text/javascript" src="{{.mOut.ViewUrl}}js/swipe.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="{{.mOut.ViewUrl}}js/iscroll-lite.js" charset="utf-8"></script>
    <script type="text/javascript">
        //页面加载时初始化广播条高度
        function init_notice_height() {
            var notice_height =$('#broadcast>a').height();
            $('#broadcast').height(notice_height);
            simpleSwipe($('#broadcast'),'#broadcast a',3000,notice_height);
        }
        
        $(document).ready(function(){
            Echo.init();
            var banner = document.getElementById('mySwipe');
            window.mySwipe = Swipe(banner,{
                auto: 3000,
                disableScroll: false
            });

            init_notice_height();
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
                window.scrollTo(0,0);
            });
        })
    </script>
