layui.use(['element'], function() {
	$ = layui.jquery;
  	element = layui.element(); 
  
    //导航的hover效果、二级菜单等功能，需要依赖element模块
    // 侧边栏点击隐藏兄弟元素
	$('.layui-nav-item').click(function(event) {
		//$(this).siblings().removeClass('layui-nav-itemed');
	});

	$('.layui-tab-title li').eq(0).find('i').remove();

	height = $('.layui-layout-admin .site-demo').height();
	$('.layui-layout-admin .site-demo').height(height-100);

	if ($(window).width()<750) {
		trun = 0;
		$('.x-slide_left').css('background-position','0px -61px');
	} else {
		trun = 1;
	}

    // 记录上一次跳转页面
    if ($.cookie('x_iframe_url')) {
        load_page($.cookie('x_iframe_url'));
    }

	$('.x-slide_left').click(function(event) {
		if (trun) {
			$('.x-side').animate({left: '-200px'}, 200).siblings('.x-main').animate({left: '0px'},200);
			$(this).css('background-position','0px -61px');
			trun = 0;
		} else {
			$('.x-side').animate({left: '0px'},200).siblings('.x-main').animate({left: '200px'},200);
			$(this).css('background-position','0px 0px');
			trun = 1;
		}
	});

  	// 监听导航点击
  	element.on('nav(side)', function(elem) {
    	var title = elem.find('cite').text();
    	var url   = elem.find('a').attr('_href');

        load_page(url);
	});

	// 全选
	$(".all-select").click(function() {   
		$(".all-x-select").prop("checked", this.checked);
	});

    $(".load-page").click(function () {
        top.load_page($(this).attr('_href'));
    });
});

function reload() {
    if ($.cookie('x_iframe_url')) {
        load_page($.cookie('x_iframe_url'));
    }
}

function load_page(url) {
    $.cookie('x_iframe_url', url);

	$(".x-iframe").css({"display": "none"});

    $(".loading-box").css({"display": "flex"});

    $('.x-iframe').attr("src", url);
    $('.x-iframe').one("load", function() {
        $(".loading-box").hide();
        $(".x-iframe").fadeIn(200);
    });

    $('.layui-nav').find('a').each(function() {
        var _url = $(this).attr('_href');
        var urls = url.split("?");
        if (_url && _url == urls[0]) {
            $('.layui-nav').removeClass('layui-this');
            $(this).parent().addClass('layui-this');
        }
    });

    $('.layui-tab-title li').eq(0).find('i').remove();
}
