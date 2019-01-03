var extendClass = function() {
	var F = function() {};
	return function(Parent, constructor, prototype) {
		var Child, proto, name, hasOwnProperty;
		if('function' !== typeof Parent) {
			throw TypeError('Parent class may only be a function');
		}
		var Child = function() {
			if(!(this instanceof Child)) {
				throw new TypeError('Cannot call a class as a function');
			}
			Parent.apply(this, arguments);
			if('function' === typeof constructor) {
				constructor.apply(this, arguments);
			}
			return this;
		};
		F.prototype = Parent.prototype;
		proto = Child.prototype = new F;
		if('object' === typeof prototype && prototype) {
			hasOwnProperty = Object.prototype.hasOwnProperty;
			for(name in prototype) {
				if(hasOwnProperty.call(prototype, name)) {
					proto[name] = prototype[name];
				}
			}
		}
		proto.constructor = Child;
		proto._super = Parent.prototype;

		
		return Child;
	};
}();


var ToolBtn = function(name) {
	this.name = name;
	this.status = false;
	this.$btn = $('.toolbtn-' + name);
	this.init();
};

ToolBtn.$container = function() {
	return $('body').on('click', '.tool-close a', function() {
		return ToolBtn.close();
	});
}();

ToolBtn.cache = [];
ToolBtn.add = function(toolBtn) {
	if(toolBtn instanceof this) {
		this.cache.push(toolBtn);
		return true;
	}
	return false;
};

ToolBtn.bind = function(evt) {
	evt.data.toggle(evt);
	return false;
};

ToolBtn.close = function() {
	var btns = this.cache;
	var length = btns.length;
	while(length--) {
		btns[length].close();
	}
	return true;
};

ToolBtn.prototype = {
	constructor: ToolBtn,
	init: function() {
		this.$btn.on('click', this, ToolBtn.bind);
		ToolBtn.add(this);
	},
	toggle: function() {
		return this[this.status ? 'close' : 'open']();
	},
	close: function() {
		if(this.status) {
			ToolBtn.$container.removeClass(this.name + '-active');
			this.status = false;
			return true;
		}
		return false;
	},
	open: function() {
		if(this.status) {
			return false;
		}
		ToolBtn.close();
		ToolBtn.$container.addClass(this.name + '-active');
		$(".tool-set").css({right:"-496px"}).animate({right:0},'fast') ;
		return this.status = true;
	}
};

var ToolBtnOuterClose = extendClass(ToolBtn, function() {
	this.$tool = $('.tool-' + this.name);
}, {
	open: function() {
		var context = this;
		this._super.open.call(this);
		return;
		this.$tool.add(this.$btn).outerClick(function() {
			return context.close();
		})
	}
});


$(function() {
	new ToolBtnOuterClose('set');
	new ToolBtnOuterClose('dir');
	new ToolBtn('help');

	$('.tool-help-btn').on('click', function() {
		return ToolBtn.close();
	});

	$('.book-ctrl').on('click', function() {
		return $('body').toggleClass('book-ctrl-active');
	});

	$('.bookshelf-book-close').on('click', function() {
		return $('.bookshelf-book').animate({marginRight: '-190px'}, 'fast', function() {
			$(this).css('display', 'none');
			return $('.bookshelf-btn').css('display', 'block').animate({
				marginRight: 0
			}, 'fast', function() {
				$('body').addClass('bookshelf-smallactive').removeClass('bookshelf-bigactive');
				return $('.bookshelf-book, .bookshelf-btn').attr('style', '');
			});
		});
	});

	$('.bookshelf-btn').on('click', function() {
		$('body').addClass('bookshelf-bigactive');
		return $(this).animate({marginRight: '-60px'}, 'fast', function() {
			$(this).css('display', 'none');
			return $('.bookshelf-book').css('display', 'block').animate({
				marginRight: 0
			}, 'fast', function() {
				$('body').addClass('bookshelf-bigactive').removeClass('bookshelf-smallactive');
				return $('.bookshelf-book, .bookshelf-btn').attr('style', '');
			});
		});
	});

	!function fullScreen() {
		var userAgent = navigator.userAgent.toLowerCase();
		if(/msie/.test(userAgent) || /rv:([\d.]+)\) like gecko/.test(userAgent)) {
			return $('.toolbtn-fullscreen').remove();
		}
		var status;
		var html = document.documentElement;
		var requestFullScreen = function() {
			if(html.requestFullscreen) {
				return html.requestFullscreen(), true;
			}
			if(html.mozRequestFullScreen) {
				return html.mozRequestFullScreen(), true;
			}
			if(html.webkitRequestFullscreen) {
				return html.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT), true;
			}
			return false;
		};
		var exitFullScreen = function() {
			if(document.exitFullscreen) {
				return document.exitFullscreen(), true;
			}
			if(document.mozCancelFullScreen) {
				return document.mozCancelFullScreen(), true;
			}
			if(document.webkitExitFullscreen) {
				return document.webkitExitFullscreen(), true;
			}
			return false;
		};
		var changeStatus = function() {
			status = status ? undefined : true;
			return $('body')[status ? 'addClass' : 'removeClass']('fullscreen-active');
		};
		// webkitfullscreenchange mozfullscreenchange fullscreenchange
		// cannot listen key press
		$(document).on('keyup', function(evt) {
			return 122 === evt.keyCode && changeStatus();
		});
		return $('.toolbtn-fullscreen').on('click', function() {
			if(status) {
				return exitFullScreen() && changeStatus();
			}
			return requestFullScreen() && changeStatus();
		});
	}();

	$('.toolbtn-dir').on('click', function() {
		
		$('.tool-dir, .tool-dir-list, .tool-dir-list ul, .tool-dir-bar a').removeAttr('style');

		var innerHeight = parseInt($(window).innerHeight());
		var top, dirHeight;
		/*fuck ie6*/
		if(window.ActiveXObject && !window.XMLHttpRequest) {
			top = 0;
			dirHeight = innerHeight - 85;
		} else {
			var top = $('.book-header-wrap').get(0).getBoundingClientRect().top;
			dirHeight = innerHeight - top;
		}

		var listHeight = dirHeight - 170;
		var $list = $('.tool-dir-list');
		var $bar = $('.tool-dir-bar');
		$('.tool-dir').css({
			top: top + 'px',
			height: dirHeight + 'px',
			marginLeft: '100%'
		}).animate({
			marginLeft: 0
		});
		$list.css('height', listHeight + 'px');
		var scrollHeight = parseInt($list.get(0).scrollHeight);
		var barHeight = Math.ceil(Math.max(listHeight*listHeight/scrollHeight, 40));
		var remainHeight = listHeight - barHeight;
		var remainScroll = scrollHeight - listHeight;
		var $scroll = $bar.children('a');
		var lastPageY, barTop = 0, listTop = 0;
		var events = {
			mousemove: function(evt) {
				var lastBarTop = barTop;
				barTop += evt.pageY - lastPageY;
				barTop = Math.max(0, barTop);
				barTop = Math.min(remainHeight, barTop);
				lastPageY = evt.pageY;
				listTop = barTop/remainHeight*remainScroll;
				
				$scroll.css({'top': barTop + 'px'});

				$list.children('ul').css('top', - listTop + 'px');
				evt.preventDefault();
			},
			mouseup: function() {
				return $(this).off(events);
			},
			selectstart: function() {
				return false;
			}
		};
		$list.on('mousewheel', function(evt) {
			var event = evt.originalEvent;
			var isUp = (event.wheelDelta ? event.wheelDelta/120 : - event.detail / 3) > 0;
			listTop += isUp ? -120 : 120;
			listTop = Math.max(0, listTop);
			listTop = Math.min(remainScroll, listTop);
			barTop = listTop/remainScroll*remainHeight;
				$scroll.css({'top': barTop + 'px'});
				$list.children('ul').css('top', - listTop + 'px');
			return false;
		});
		$scroll.css('height', barHeight + 'px').on('mousedown', function(evt) {
			lastPageY = evt.pageY;
			barTop = $scroll.position().top;
			listTop = $("li[id^='dir_li']").position().top ;
			$(document).on(events);
		});
		
		listTop = $("li[id^='dir_li']").position().top ;
		$(".tool-dir-list ul").css("top", listTop * - 1 );
		
		barTop = listTop / remainScroll  * remainHeight ;
		$scroll.css({'top': barTop + 'px'});
	});
});
