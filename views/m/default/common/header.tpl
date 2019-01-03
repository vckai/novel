
<link href="{{.mOut.ViewUrl}}css/bookstore.css" rel="stylesheet" type="text/css">
<style type="text/css">
	#activity li:nth-child(1) dl dt{color:#409ad8 }
	#activity li:nth-child(2) dl dt{color:#fb7c4a }
	#activity li:nth-child(3) dl dt{color:#ff635b }
	#activity li:nth-child(4) dl dt{color:#ffa314 }
</style>
<div class="search-suggestion-overlay" id="sugg-overlay" style="display: none;"></div>
<div class="header">
	<div class="logo-wrap">
		<b>{{.aOut.Title}}</b>
		<i class="search-btn"></i>
	</div>
	<div class="search-wrap">
		<form class="search-query" method="GET" action="{{urlfor "m.BookController.Search"}}" id="searchform" accept-charset="utf-8">
			<input type="text" class="search-query-input" id="keyword" name="keyword">
			<i class="search-clear" id="resetbtn"></i>
		</form>
		<div class="search-cancel"> 取消</div>
	</div>
	<div class="search-suggestion" id="sug_wraper" style="display: none"></div>
</div>
