<link href="{{.mOut.ViewUrl}}css/bookstore.css?v=aa6bf34e" rel="stylesheet" type="text/css">
<link href="{{.mOut.ViewUrl}}css/feedback.css?v=aa6bf34e" rel="stylesheet" type="text/css">

<header class="hd-bar">
	<a href="javascript:history.go(-1);" class="search-back" id="historyBack"></a>
	<h1 style="text-align: center;">{{.Title}}</h1>
	<a href="{{urlfor "m.HomeController.Index"}}" class="search-home"></a>
</header>

<div class="wrapper">
	<div class="e-lst">
		<div class="e-lst-area"><textarea placeholder="请输入您遇到的问题及宝贵建议" id="content"></textarea></div>
		<div class="e-lst-tit" >您的联系方式：</div>
		<div class="e-lst-area"><input type="text" placeholder="QQ/邮箱/手机号" id="contacts"></div>
		<div class="e-lst-btn"><a href="javascript:void(0)" id="submit">提交</a></div>
	</div>
</div>

<script type="text/javascript">
	var mobile,email;
	function isMobileOrQQ(value){
		var reg = /^\d{5,11}$/;
		return reg.test(value);
	}

	function isEmail(str){
		if(str != null && str != ''){
			str = str.toLowerCase()
		}
		var reg = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
		return reg.test(str);
	}

	function result(data) {
		var json = eval('(' + data + ')');
		if (json.ret == 0) {
			alert("提交成功，感谢您的反馈！");
			setTimeout('history.go(-1)', 2000);
		} else {
			alert("提交失败，请重新提交！");
		}
	}

	$(document).ready(function() {
		$('#submit').on('click', function() {
			var contacts = $.trim($("#contacts").val()),
				content =  $.trim($("#content").val());

			if (content.length < 5) {
				alert('您对问题的描述太少，请重新填写！');
				return ;
			}

			if (contacts != "" ) {
				if(!isEmail(contacts) && !isMobileOrQQ(NumberUtil.toInt(contacts)) ) {
					alert('您输入的联系方式有误，请重新填写！');
					return ;
				}
			} else {
				alert('您输入的联系方式为空，请重新填写！');
				return ;
			}

			var url = {{urlfor "m.HomeController.Feedback"}},
				 content = $('#content').val();

			var data = {
			    'content': content,
				'contact': contacts
			};

			$.post(url, data, result);
		})
	})
</script>
