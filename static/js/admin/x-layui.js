/*弹出层*/
/*
	参数解释：
	title	标题
	url		请求的url
	id		需要操作的数据id
	w		弹出层宽度（缺省调默认值）
	h		弹出层高度（缺省调默认值）
*/
function x_admin_show(title, url, w, h) {
	if (title == null || title == '') {
		title=false;
	};
	if (url == null || url == '') {
		url="404.html";
	};
	if (w == null || w == '') {
        w=800;
	};
	if (h == null || h == '') {
		h=($(window).height() - 50);
	};

    if (!isNaN(w) || w.charAt('px') < 0 || w.charAt('%') < 0) {
        w += 'px';
    }
    if (!isNaN(h) || h.charAt('px') < 0 || h.charAt('%') < 0) {
        h += 'px';
    }
	layer.open({
		type: 2,
		area: [w, h],
		fix: false, //不固定
		maxmin: true,
		shadeClose: true,
		shade:0.4,
		title: title,
		content: url
	});
}

/*关闭弹出框口*/
function x_admin_close() {
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

// 发异步，把数据提交给服务端
var is_submit = true;
function ajax_post(url, data, tourl, is_alert, is_parent) {
	if (!is_submit) {
		return false;
	}

	if (typeof tourl == "undefined") {
		tourl = "";
	}

	if (typeof is_alert == "undefined") {
		is_alert = true;
	}

	if (typeof is_parent == "undefined") {
		is_parent = true;
	}

    var parent_script = "";
	if (is_parent && typeof parent.layer != "undefined") {
		parent_script = "parent.";
	}

	var index = layer.load(2, {shade: [0.3]});
	is_submit = false;
	$.post(url, data, function (res) {
		if (res.ret == 0) {
			if (is_alert) {
				layer.msg(res.msg, {icon: 1});
			}

            var delay_time = 0;
            if (is_alert) {
                delay_time = 1000; 
            }

			if (!tourl) {
				setTimeout(parent_script + "location.reload()", delay_time);
			} else {
				if (typeof tourl == "function") {
					setTimeout(function () {tourl(res.data)}, delay_time);
				} else if (typeof tourl == "string") {
					setTimeout(parent_script + "location.href='" + tourl + "'", delay_time);
				}
			}
		} else {
			layer.msg(res.msg, {icon: 2});	
		}

		// 返回URL跳转
		if (typeof res.url != "undefined" && res.url) {
			if (typeof res.is_top != "undefined" && res.is_top == true) {
				setTimeout("top.location.href='" + res.url + "'", delay_time);
			} else {
				setTimeout(parent_script + "location.href='" + res.url + "'", delay_time);
			}
		}
		is_submit = true;
		layer.close(index);

	}, "JSON").error(function() {
		is_submit = true;
		layer.close(index);
		layer.msg("请求失败", {icon: 5});
	});
}

/**
 * 获取全选按钮的值
 */
function get_list_ids(id) {
    var checkbox = $("." + id);
    var ids = new Array();
    for (var i = 0; i < checkbox.length; i++) {
        if (checkbox[i].checked) {
			ids.push(checkbox[i].value);
        }
    }

    return ids;
}
