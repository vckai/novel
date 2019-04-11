<div class="header-box">
	<div class="header" style="height:78px">
	  <div class="searchbox">
	      <a href="/" class="logo">
	          <img src="{{.aOut.Logo}}" alt="{{.aOut.Title}}">
	      </a>
	      <form action="{{urlfor "home.HomeController.Search"}}" method="get" class="searchform" id="searchForm" onsubmit="return checkSearch()">
	          <div class="querybox">
	              <div class="qborder">
	              	<input type="text" value="{{.Search.q}}" name="kw" id="query" class="query" autocomplete="off">
	             </div>
	          </div>
	          <div class="sbtn1"><input type="submit" value="搜索" onmouseout="this.className='btn1'" onmouseup="this.className='sbtn1'" onmousedown="this.className='btnactive'" id="searchBtn"></div>
	          <div class="hotwords">热搜书籍：
	          		<a href="{{urlfor "home.HomeController.Search" "kw" "圣墟"}}" target="_blank">圣墟</a>
	          		<a href="{{urlfor "home.HomeController.Search" "kw" "雪鹰领主"}}" target="_blank">雪鹰领主</a>
	          		<a href="{{urlfor "home.HomeController.Search" "kw" "一念永恒"}}" target="_blank">一念永恒</a>
	          		<a href="{{urlfor "home.HomeController.Search" "kw" "择天记"}}" target="_blank">择天记</a>
	          </div>
	      </form>
	  </div>
		<script type="text/javascript">
		var checkSearch = function() {
			if ($.trim($("#query").val()).length < 1)
				return false;
			else
				return true;
		};
		</script>

		<div class="login">
			<a href="javascript:setHome(this, location.href)">设为首页</a>
			<span class="divider divider1"></span>
			<a href="javascript:addFavorite('{{.aOut.Title}}', location.href)">收藏本站</a>
		</div>
	</div>

	<div class="mnavbox">
	  <ul class="mnav" style="width:1200px">
	      <li {{if eq .aOut.MethodName "HomeController.Index"}}class="cur"{{end}}><a href="{{urlfor "home.HomeController.Index"}}">首页</a></li>
	      <li {{if eq .aOut.MethodName "HomeController.Cate"}}class="cur"{{end}}><a href="{{urlfor "home.HomeController.Cate"}}" class="r-tab">全部作品</a></li>
	      <!--<li><a href="#" class="r-tab">排行</a></li>-->
	      <li class="all-sort">
	          <a href="{{urlfor "home.HomeController.Cate"}}" class="sort-tab">全部书籍分类</a>
	          <div class="t-box">
	            <span class="triangle"></span>
	          </div>
	          <div class="sort-box" id="allsortbox" style="display: none;">
	              <ul>
					{{range .Cates}}
	          			<li><a href="{{urlfor "home.HomeController.Cate" "id" .Id}}" class="top-a">{{.Name}}</a></li>
					{{end}}
	              </ul>
	          </div>

	      </li>
	  </ul>
	</div>
</div>	
