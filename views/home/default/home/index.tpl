<style>
.r-banner-list li {
    position: absolute;
}
</style>
<script>
var myScroll = null;
var hot_timer = null;
var currentIndex = 0;
var picCount = {{.BannerSlicesCount}};
</script>
<div class="read-banner" onmouseover="$('.banner-btn').show()" onmouseout="$('.banner-btn').hide()">
    <!--banner轮播 需要计算每个li的背景色以及透明度-->
    <ul class="r-banner-list" id="scrollBox">
		{{range .BannerSlices}}
		 <li style="{{css .Ext}}">
			<a href="{{.Link}}" target="_blank" class="img-box">
				<img src="{{.Img}}" alt="{{.Name}}">
			</a>
		</li>
		{{end}}
    </ul>
    
    <!--//banner轮播-->
    <!--小圆点（两种位置pager1和pager2，pager为两种共有）-->
    <div class="pager pager1" id="scrollSmallBox">
	{{range $k, $v := .BannerSlices}}	
		<a uigs="none_home_top_pic_index" href="javascript:void(0)" onmouseover="clearTimeout(hot_timer);hot_timer=setTimeout(function(){scrollBox({{$k}}, 500);},50)" onmouseout="clearTimeout(hot_timer)" {{if eq $k 0}}class="cur"{{end}}></a>
	{{end}}
    </div>
    
    <!--//小圆点-->
    <!--左右方向键（右方向键有两种位置right-btn1和right-btn2，right-btn为两种共有）-->
    <a uigs="none_home_top_pic_right" style="display: none;" href="javascript:void(0)" onclick="scrollBox(currentIndex + 1, 500)" class="banner-btn right-btn right-btn1">
        <div class="btn-shadow" style="background-color: transparent; opacity: 0.078;"></div>
    </a>
    <a uigs="none_home_top_pic_left" style="display: none;" href="javascript:void(0)" onclick="scrollBox(currentIndex - 1, 500)" class="banner-btn left-btn">
        <div class="btn-shadow" style="background-color: transparent; opacity: 0.078;"></div>
    </a>

<script>
function scrollBox(_index, scrollDuration) {
	var index = (_index + picCount) % picCount;

	if (index == currentIndex) {
		return;
	}
	
	$("#scrollBox li:eq(" + index + ")").fadeIn(scrollDuration);
	$("#scrollBox li:eq(" + currentIndex + ")").fadeOut(scrollDuration);
	
	currentIndex = index;
	$("#scrollSmallBox a").removeClass("cur");
	$("#scrollSmallBox a:eq(" + currentIndex + ")").addClass("cur");
}

$(document).ready(function() {
	myScroll = setInterval(function(){ scrollBox(currentIndex + 1, 1500); }, 5000);
    $(".m_banner").hover(function() {
        clearInterval(myScroll);
        }, function() {
            myScroll = setInterval(function(){ scrollBox(currentIndex + 1, 1500); }, 5000);
        }
	);
});
</script>
</div>

<!--
<div class="read-notice">
	<em>公告：</em>为响应国家净网行动，部分小说或章节不予展示，感谢读者理解。
</div>
 -->

<div class="r-section">
    <div class="r-left">
        <h1 class="r-tit"><i class="r-ico re-ico"></i>推荐阅读</h1>

		 {{range $key, $val := .NovRecs}}
         <ul class="re-book" id="re_book_{{$key}}" {{if ne $key 0}}style="display: none;"{{end}}>
			 {{range $k, $v := $val}}
              <li>
                <a href="{{urlfor "home.BookController.Index" "id" $v.Id}}" target="_blank" class="re-pic-box">
                    <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne $v.Cover ""}}data-echo="{{$v.Cover}}"{{end}} alt="{{$v.Name}}" style="width: 179px;height: 249px;">
                </a>
                <h2 class="re-book-name over-txt"><a href="{{urlfor "home.BookController.Index" "id" $v.Id}}" target="_blank">{{$v.Name}}</a></h2>
                <span class="source over-txt">{{$v.Author}}</span>
                <a href="{{urlfor "home.HomeController.Cate" ":id" $v.CateId}}" class="r-type">{{$v.CateName}}</a>
              </li>
			{{end}}
        </ul>
		{{end}}
         
        <div class="corner corner-top"></div>
        <div class="corner corner-bottom"></div>
        <div class="scroll">
            <a href="javascript:rightSlide()" class="scroll-btn lf-btn"></a>
		 {{range $k, $v := .NovRecs}}
        	<a href="javascript:changeSlide('{{$k}}')" class="{{if eq $k 0}}cur{{end}}" id="slide_{{$k}}"></a>
		 {{end}}
            <a href="javascript:leftSlide()" class="scroll-btn rt-btn"></a>
        </div>
    </div>

    <div class="r-right">
        <div class="tab-box">
            <a href="javascript:void(0)" onmouseover="changeRank(1, this)" class="cur">今日推荐</a>
            <a href="javascript:void(0)" onmouseover="changeRank(2, this)">热门推荐</a>
        </div>
        <ul class="r-list" id="rank_1"></ul>
        <ul class="r-list" id="rank_2" style="display: none;"></ul>
    </div>
</div>

<div class="r-section">
    <div class="r-left">
        <h1 class="r-tit"><i class="r-ico free-ico"></i>最新热更</h1>
        <ul class="free-book">
		{{range .NovNews}}
        	 <li>
                <a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank" class="f-pic-box">
                    <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}} alt="{{.Name}}" style="height:167px;width: 119px;">
                </a>
                <h3 class="f-book-name over-txt">
                	<a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank">{{.Name}}</a>
                </h3>
                <span class="source over-txt">{{.Author}}</span>
            </li>
		{{end}}
        </ul>
    </div>
    
    <div class="r-right">
        <div class="tab-box">
            <a href="javascript:void(0)" onmouseover="changeRank(3, this)" class="cur">新书榜</a>
            <a href="javascript:void(0)" onmouseover="changeRank(4, this)">原创榜</a>
        </div>
        <ul class="r-list" id="rank_3"></ul>
        <ul class="r-list" id="rank_4" style="display: none;"></ul>
    </div>
</div>

<div class="r-show">
	{{range $k, $v := .BannerSmalls}}
 	<a href="{{$v.Link}}" target="_blank" class="{{if eq $k 0}} lf-img{{else}}rt-img{{end}}">
        <img src="{{$v.Img}}" alt="{{$v.Name}}">
    </a>
	{{end}}
</div>

<div class="r-section">
    <h1 class="r-tit"><i class="r-ico choice-ico"></i>分类精选</h1>
    <div class="sort-choice ">
	{{range $k, $v := .CateRecs}}
    	  <a href="javascript:void(0)" onmouseover="getChoiceBook('{{$v.Id}}', this)" {{if eq $k 0}}class="cur"{{end}}>{{$v.Name}}</a>{{if ne $k $.CateRecsNum}}<span>|</span>{{end}}
	{{end}}
    </div>
    <ul class="choice-book" id="choice_book"></ul>
</div>

<div class="r-section">
    <div class="boy-like">
        <h1 class="r-tit"><i class="r-ico boy-ico"></i>新书推荐</h1>
        <ul class="boy-list">
		{{range .NovSignNewBooks}}
        	 <li>
                <a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank">
                    <div class="rotate">
                        <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}} style="top: 20px; left: 47px; z-index: 2;" class="cur">
                    </div>
                    <span class="r-sort over-txt">{{.Name}}</span>
                    <span class="cover"></span>
                </a>
            </li>
		{{end}}
        </ul>
    </div>
    <div class="girl-like">
        <h1 class="r-tit"><i class="r-ico girl-ico"></i>收藏推荐</h1>
        <ul class="girl-list">
		{{range .NovCollects}}
        	 <li>
                <a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank">
                    <div class="rotate">
                        <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}} style="top: 20px; left: 47px; z-index: 2;" class="cur">
                    </div>
                    <span class="r-sort over-txt">{{.Name}}</span>
                    <span class="cover"></span>
                </a>
            </li>
		{{end}}
        </ul>
    </div>
</div>

<div class="r-section">
    <div class="r-left">
        <h1 class="r-tit"><i class="r-ico hot-ico"></i>大家都在看</h1>
		{{if not_nil .NovRank}}
        <div class="d-book">
            <a href="{{urlfor "home.BookController.Index" "id" .NovRank.Id}}" target="_blank" class="re-pic-box">
                <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .NovRank.Cover ""}}data-echo="{{.NovRank.Cover}}"{{end}} alt="{{.NovRank.Name}}">
            </a>
            <h2 class="re-book-name over-txt">
            	<a href="{{urlfor "home.BookController.Index" "id" .NovRank.Id}}" target="_blank">{{.NovRank.Name}}</a>
            </h2>
            <span class="source over-txt">{{.NovRank.Author}}</span>
            <div class="brief-intro">{{str2html .NovRank.Desc}}</div>
            <div class="corner x-corner-top"></div>
            <div class="corner x-corner-bottom"></div>
        </div>
		{{end}}

        <ul class="hot-book">
		{{range .NovRanks}}
          	<li>
                <a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank" class="f-pic-box">
                    <img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}} alt="{{.Name}}" style="width: 119px;height: 167px;">
                </a>
                <h3 class="f-book-name over-txt">
					<a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank">{{.Name}}</a>
				</h3>
                <span class="source over-txt">{{.Author}}</span>
            </li>
		{{end}}
        </ul>
    </div>
    <div class="r-right">
        <div class="tab-box">
            <a href="javascript:void(0)" onmouseover="changeRank(5, this)" class="cur">VIP打赏</a>
            <a href="javascript:void(0)" onmouseover="changeRank(6, this)">VIP更新</a>
        </div>
        <ul class="r-list" id="rank_5"></ul>
        <ul class="r-list" id="rank_6" style="display: none;"></ul>
    </div>
</div>

<script type="text/javascript">
	var nocover = "{{.mOut.ViewUrl}}img/nocover.jpg";

    (function($) {
    	getRank(1);
    	getRank(3);
    	getRank(5);    	
    	
        $('.banner-btn').hover(function(){
            $(this).children('.btn-shadow').css('background-color', '#000').css('opacity', '0.078');
        },function(){
            $(this).children('.btn-shadow').css('background-color', 'transparent');
        });
    	
        init();

        initSlide();
        
        getCateBook();
    })(jQuery);

    function initRankHover(rank) {
    	$('#rank_'+rank+' li').hover(function() {
            $(this).siblings().removeClass('open-show default').end().addClass('open-show').prev().children('.close').css('border-color', 'transparent');
        },function() {
            $(this).prev().children('.close').css('border-color', '#eee');
        });
    }
    
    function init() {
    	$("#allsortbox").show();
    	$('.t-box').hide();
    }
    
    setInterval(function(){countDown($('#bookCD .txt_clr'));},1000);

    function countDown(time) {
        var d = time.eq(0),
            h = time.eq(1),
            m = time.eq(2),
            s = time.eq(3);
        var f_d = d.html(),
            f_h = h.html(),
            f_m = m.html(),
            f_s = s.html();
        if(f_s>0){
            s.html(f_s-1);
        }else if(f_s == 0 && f_m > 0){
            s.html(59);
            m.html(f_m-1);
        }else if(f_s == 0 && f_m == 0 && f_h > 0){
            s.html(59);
            m.html(59);
            h.html(f_h-1);
        }else if(f_s == 0 && f_m == 0 && f_h == 0 && f_d > 0){
            s.html(59);
            m.html(59);
            h.html(59);
            d.html(f_d-1);
        }
    }
    
    function  getRank(rank) {
        var url = {{urlfor "home.BookController.AjaxRank"}}+'?rank='+rank;
        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (b) {
            	handRank(rank, b.data.list);
            }
        });
    }
    
    function handRank(rank, d) {
        if (!d || !$.isArray(d)) {
			return ;
		}
		var books = "";
		
		for (var a = 0; a < d.length; a++) {
			  if (a >= 10) {
				  break;
			  }

			  var cover = nocover;
			  if (d[a].cover) {
				cover  = d[a].cover;
			  }

			  books = books + ' <li';
			  if (a == 0) {
				 books = books + ' class="default"' ; 
			  }
			  if (a == 1) {
				 books = books + ' class="cur"' ; 
			  } 

			  books = books + 
			  '  ><div class="open"> '+
			  '      <em class="rank rank1">'+(a+1)+'</em> '+
			  '      <a href="{{urlfor "home.BookController.Index"}}?id='+d[a].id+'" target="_blank" class="rank-pic"> '+
			   '         <img src="'+cover+'" alt="'+d[a].name+'" style="width: 74px;height: 102px;" /> '+
			   '     </a> '+
			   '     <div class="b-info"> '+
			   '         <h2 class="re-book-name"><a href="{{urlfor "home.BookController.Index"}}?id='+d[a].id+'" target="_blank" >'+d[a].name+'</a></h2> '+
			   '         <span class="source over-txt">'+d[a].author+'</span> '+
			   '     </div> '+
			   ' </div> '+
			   ' <div class="close"> ';

			  if(a < 3) {
				 books = books + '<em class="rank  rank2">'+(a+1)+'</em>' ; 
			  } else {
				books = books + '<em class="rank">'+(a+1)+'</em>' ;
			  }
 
			  books = books +
			  '<h3 class="book-name over-txt"><a href="{{urlfor "home.BookController.Index"}}?id='+d[a].id+'" target="_blank" >'+d[a].name+'</a></h3> '+
			  ' </div>'+
			  '</li>';
		}
		$("#rank_"+rank).html(books);
		initRankHover(rank);
    }
    
    function getChoiceBook(cateId, obj) {
    	$(obj).addClass("cur");
    	$(obj).siblings().removeClass("cur");
    	getCateBook(cateId);
    }
    
    function  getCateBook(cateId) {
        var url = '{{urlfor "home.BookController.AjaxRank"}}?rank=cate&cate_id='+cateId;
        $.ajax({
            type: "GET",
            url: url ,
            dataType: "json",
            success: function (b) {
            	handCateBook(b.data.list);
            }
        })
    }
    
    function handCateBook(d) {
    	if (!d || !$.isArray(d)) {
			return ;
		}
		var books = "";
		for (var a = 0; a < d.length; a++) {
		  if (a >= 6) {
			  break;
		  }

		  var cover = nocover;
		  if (d[a].cover) {
			cover  = d[a].cover;
		  }

		  books = books + 
		  '<li> '+
		  '      <a href="{{urlfor "home.BookController.Index"}}?id='+d[a].id+'" target="_blank" class="pic-container">'+
		  '          <img src="' + cover + '" alt="' + d[a].name + '" style="width: 120px;height: 163px;" />'+
		  '      </a>'+
		  '      <div class="book-info">'+
		  '          <h2 class="c-book-name over-txt"><a href="{{urlfor "home.BookController.Index"}}?id='+d[a].id+'" target="_blank" >' + d[a].name + '</a></h2>'+
		  '          <span class="source over-txt">' +  d[a].author + '</span>'+
		  '          <div class="brief-intro brief-intro2">' +d[a].desc + '</div>'+
		  '          <a href="{{urlfor "home.BookController.Index"}}?id='+d[a].id+'" target="_blank" class="read-now">立即阅读</a>'+
		  '      </div>'+
		  '  </li>';
		}

		$("#choice_book").html(books);
    }
    
   function changeRank(rankNum , obj) {
	   if (! $.trim($("#rank_"+rankNum).html())) {
		   getRank(rankNum)
	   }
	   
   		$(obj).addClass("cur");
		$(obj).siblings().removeClass("cur");
		
		$("#rank_"+rankNum).show();
		if (rankNum % 2 == 0) {
			$("#rank_"+ parseInt(rankNum - 1)).hide();	
		} else {
			$("#rank_"+ parseInt(rankNum + 1)).hide();
		}
		
   }
    
    var timer = 10000;
	var maxSlide = {{.NovRecsNum}}
    function initSlide() {
        window.setInterval(slide, 5000);
		{{range $k, $v := .NovRecs}}
			$('#slide_{{$k}}').bind('click', slide);
		{{end}}
    }
    function slide() {
        var num = timer % maxSlide;
        changeSlide(num);
        timer = timer + 1 ;
    }
    
    function rightSlide() {
    	 timer = timer - 1 ;
    	 var num = timer % maxSlide;
         changeSlide(num);
    }
    
    function leftSlide() {
    	 timer = timer + 1 ;
    	 var num = timer % maxSlide;
         changeSlide(num);
    }
    
    function changeSlide(num) {
    	$("[id^='re_book_']").hide();
    	$('#re_book_'+num).show();
    	$("[id^='slide_']").removeClass();
    	$("#slide_"+num).addClass("cur");
    }
</script>
