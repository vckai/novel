
<link href="{{.aOut.ViewUrl}}css/swiper-3.4.2.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="{{.aOut.ViewUrl}}js/swiper-3.4.2.jquery.min.js" charset="utf-8"></script>

<!-- container -->
<div id="container">
	<div id="content">
	  <!-- section -->
	   <div class="detail-section read-notice-sibling">
	    <!-- ad -->
	    <div class="ad-down">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					{{range .BannerSlices}}
					<div class="swiper-slide">
						<a href="{{.Link}}" target="_blank">
							<img src="{{.Img}}" alt="{{.Name}}" height="453" width="270">
						</a>
					</div>
					{{end}}
				</div>
				<!-- 如果需要分页器 -->
				<div class="swiper-pagination swiper-button-white"></div>
			</div>
		</div>
	    <!-- //ad -->
	    <!-- category -->
	    <ul class="category-lst">
	      <li><a href="{{urlfor "home.HomeController.Index"}}" class="category-tab txtlink">首页<i></i></a></li>
	      <li>{{.Nov.Name}}</li>
	    </ul>
	    <!-- //category -->
	    <div class="detail-wrap">
	      <a href="javascript:void(0);" class="detail-thumb">
	        <i class="thumb-design"></i>
	        <div class="thumb-animation">
	          <div class="detail-thumb-box"><img src="{{.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Nov.Cover ""}}data-echo="{{.Nov.Cover}}"{{end}} height="284" width="210" alt=""></div>
	        </div>
	        <i class="thumb-design2"></i>
	      </a>
	      <div class="detail-info">
	        <h1 class="detail-tit">{{.Nov.Name}}</h1>
	        <table class="detail-profile">
	          <tbody><tr>
	            <td><strong>作者：</strong>{{.Nov.Author}}</td>
	            <td><strong>类型：</strong>{{.Nov.CateName}}</td>
	          </tr>
	          <tr>
	            <td><strong>状态：</strong>{{.Nov.StatusName}}</td>
	            <td><strong>字数：</strong>{{num_format .Nov.TextNum}}</td>
	          </tr>
	        </tbody></table>
	        <p class="detail-description">
	        <c id="info_short_txt">{{substr_no_html .Nov.Desc 0 64}}...</c>
	        <c id="info_long_txt" style="display:none;">{{substr_no_html .Nov.Desc 0 200}}</c>
	        <a href="javascript:void(0)" id="zhankaishouqi" class="btn-description"><i></i>展开</a>
	        </p>
	        <div class="detail-btn-wrap">
			{{if eq .FirstChapId 0}}
	          <a href="javascript:alert('暂无章节信息');" class="btn-read">开始阅读</a>
			{{else}}
	          <a href="{{urlfor "home.BookController.Detail" "id" .FirstChapId "novid" .Nov.Id}}" target="_blank" class="btn-read">开始阅读</a>
			{{end}}
	          <a href="javascript:addFavorite('{{.Nov.Name}}', location.href);" class="btn-keep" id="fav_btn">收藏本书</a>
	        </div>
	      </div>
	    </div>
	  </div>
	  <!-- //section -->
	  <!-- section -->
	  <div class="detail-section">
	    <!-- aside -->
	    <div class="detail-aside">
	      <h2 class="aside-tit">同类热门书籍</h2>
	      <ul class="book-lst" id="recommUl">
		  {{range .NovCateRanks}}
	      	<li> 
	      		<a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank" class="book-lst-tab">
		      		<img src="{{$.mOut.ViewUrl}}img/nocover.jpg" {{if ne .Cover ""}}data-echo="{{.Cover}}"{{end}} height="100" width="75" alt="{{.Name}}">
		      		<div class="book-lst-tit">{{.Name}}</div>
		      		<div class="book-lst-txt book-lst-clr2">{{.CateName}}</div>
		      		<div class="book-lst-txt">{{.Author}}</div>
	      		</a>
	      	</li>
			{{end}}
	      </ul>
	    </div>

	    <!-- //aside -->
	    <h2 class="section-tit">目录</h2>
	    <div class="contents-lst-wrap">
	      <ol class="contents-lst" id="contl1">
		  {{range .Chaps}}
	      	<li class="odd">
	      		<a onclick="dealCurrentPageCookie()" href="{{urlfor "home.BookController.Detail" "id" .Id "novid" $.Nov.Id}}" class="contents-tab" target="_blank" title="{{.Title}}">
	      			<span>{{.ChapterNo}}</span>{{.Title}}
	      		</a>
	      	</li>
		  {{end}}
	      </ol>
	    </div>
	  </div>
	  <!-- //section -->
	</div>
</div>
<script>

var len = {{.Nov.Desc|len}};
$(function() {
	var mySwiper = new Swiper ('.swiper-container', {
		direction: 'horizontal',
		loop: true,
		autoplay: 5000,//可选选项，自动滑动

		// 如果需要分页器
		pagination: '.swiper-pagination',
		paginationClickable: true
	})        

	$('#zhankaishouqi').on('click', function() {
		if ($("#zhankaishouqi").html() == "<i></i>收起") {
			$("#info_short_txt").show();
			$("#info_long_txt").hide();
			$("#zhankaishouqi").removeClass();
			$("#zhankaishouqi").addClass("btn-description");
			$("#zhankaishouqi").html("<i></i>展开");

		} else {
			$("#info_short_txt").hide();
			$("#info_long_txt").show();
			$("#zhankaishouqi").removeClass();
			$("#zhankaishouqi").addClass("btn-description on");
			$("#zhankaishouqi").html("<i></i>收起");
		}
	});

	if (len > 64) {
	} else {
		$("#info_short_txt").hide();
		$("#info_long_txt").show();
		$("#zhankaishouqi").hide();
	}
});
</script>
