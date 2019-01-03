(function(b) {
    b.host = location.protocol + "//" + location.host;
    b.param = function(c) {
        c = c.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var e = new RegExp("[\\?&]" + c + "=([^&#]*)"),
        d = e.exec(location.search);
        return d == null ? "": decodeURIComponent(d[1].replace(/\+/g, " "))
    };
    String.prototype.trim = function() {
        return this.replace(/^\s+|\s+$/g, "")
    };
    String.prototype.startsWith = function(c) {
        return this.slice(0, c.length) == c
    };
    Date.prototype.Format = function(c) {
        var e = {
            "M+": this.getMonth() + 1,
            "d+": this.getDate(),
            "h+": this.getHours(),
            "m+": this.getMinutes(),
            "s+": this.getSeconds(),
            "q+": Math.floor((this.getMonth() + 3) / 3),
            S: this.getMilliseconds()
        };
        if (/(y+)/.test(c)) {
            c = c.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length))
        }
        for (var d in e) {
            if (new RegExp("(" + d + ")").test(c)) {
                c = c.replace(RegExp.$1, (RegExp.$1.length == 1) ? (e[d]) : (("00" + e[d]).substr(("" + e[d]).length)))
            }
        }
        return c
    };
    b.CookieUtil = {
        get: function(e) {
            var d = new RegExp("\\b" + e + "=([^;]*)\\b");
            var c = d.exec(document.cookie);
            return c ? decodeURIComponent(c[1]) : null
        },
        set: function(e, g) {
            var c = arguments,
            j = arguments.length,
            d = (j > 2) ? c[2] : new Date(new Date().valueOf() + 365 * 24 * 60 * 60 * 1000),
            i = (j > 3) ? c[3] : "/",
            f = (j > 4) ? c[4] : null,
            h = (j > 5) ? c[5] : false;
            document.cookie = e + "=" + encodeURIComponent(g) + ((d === null) ? "": ("; expires=" + d.toGMTString())) + ((i === null) ? "": ("; path=" + i)) + ((f === null) ? "": ("; domain=" + f)) + ((h === true) ? "; secure": "")
        },
        remove: function(c, e, d) {
            if (this.get(c)) {
                e = e || "/";
                document.cookie = c + "=; expires=Thu, 01-Jan-70 00:00:01 GMT; path=" + e + (d ? ("; domain=" + d) : "")
            }
        }
    };
    b.NumberUtil = {
        toInt: function(e, d) {
            d = d || 0;
            try {
                return parseInt(e, 10)
            } catch(c) {
                return d
            }
        }
    };
    b.DateUtil = {
        ymd: function() {
            return new Date().Format("yyyyMMdd")
        },
        tm: function() {
            return new Date().getTime()
        }
    };
    b.hasEvent = (function() {
        var d = !("onblur" in document.documentElement);
        function c(e, g) {
            var f;
            if (!e) {
                return false
            }
            if (!g || typeof g === "string") {
                g = a(g || "div")
            }
            e = "on" + e;
            f = e in g;
            if (!f && d) {
                if (!g.setAttribute) {
                    g = a("div")
                }
                g.setAttribute(e, "");
                f = typeof g[e] === "function";
                if (g[e] !== undefined) {
                    g[e] = undefined
                }
                g.removeAttribute(e)
            }
            return f
        }
        return c
    })();
    function a() {
        var c = document.documentElement.nodeName.toLowerCase() === "svg";
        if (typeof document.createElement !== "function") {
            return document.createElement(arguments[0])
        } else {
            if (c) {
                return document.createElementNS.call(document, "http://www.w3.org/2000/svg", arguments[0])
            } else {
                return document.createElement.apply(document, arguments)
            }
        }
    }
})(window);  
function fmtStr(b, a) {
    if (!b) {
        return ""
    }
    if (b.length < a) {
        return b
    }
    return b.substring(0, a - 2) + "..."
}
function escape2Html(b) {
    var a = {
        lt: "<",
        gt: ">",
        nbsp: " ",
        amp: "&",
        quot: '"'
    };
    return b.replace(/&(lt|gt|nbsp|amp|quot);/ig,
    function(d, c) {
        return a[c]
    })
}
function getCountDown(a) {
    var c = [];
    var b = a - new Date();
    c[0] = parseInt(b / 1000 / 3600 / 24);
    c[1] = parseInt(b / 1000 / 3600) - c[0] * 24;
    c[2] = parseInt(parseInt(b / 1000) % 3600 / 60);
    c[3] = parseInt(b / 1000) % 60;
    return c
}
function countDown(b) {
    var i = b.eq(0),
    f = b.eq(1),
    c = b.eq(2),
    k = b.eq(3);
    var j = i.html(),
    g = f.html(),
    e = c.html(),
    a = k.html();
    if (a > 0) {
        k.html(a - 1)
    } else {
        if (a == 0 && e > 0) {
            k.html(59);
            c.html(e - 1)
        } else {
            if (a == 0 && e == 0 && g > 0) {
                k.html(59);
                c.html(59);
                f.html(g - 1)
            } else {
                if (a == 0 && e == 0 && g == 0 && j > 0) {
                    k.html(59);
                    c.html(59);
                    f.html(59);
                    i.html(j - 1)
                }
            }
        }
    }
}
function simpleSwipe(j, a, e, f) {
    var d = e || 3000;
    var c = $(a).length;
    var i = f || 39;
    if (c == 2) {
        j.append(j.html());
        c = 4
    }
    var g = $(a);
    if (c > 2) {
        var h = 0,
        b = 1;
        setInterval(function() {
            for (var k = 0; k < c; k++) {
                if (k == h) {
                    g.eq(k).css("-webkit-transition", "500ms");
                    g.eq(k).css("-webkit-transform", "translate(0,-" + (k + 1) * i + "px) translateZ(0)")
                } else {
                    if (k == b) {
                        g.eq(k).css("-webkit-transition", "500ms");
                        g.eq(k).css("-webkit-transform", "translate(0,-" + k * i + "px) translateZ(0)")
                    } else {
                        g.eq(k).css("-webkit-transition", "0ms");
                        g.eq(k).css("-webkit-transform", "translate(0," + i + "px) translateZ(0)")
                    }
                }
            }
            h = b;
            b = (b + 1) % c
        },
        d)
    }
} (function(a) {
    a.extend(a, {
        throttle: function(b, c, g) {
            var e = 0,
            d;
            if (typeof c !== "function") {
                g = c;
                c = b;
                b = 250
            }
            function f() {
                var k = this,
                l = Date.now() - e,
                j = arguments;
                function i() {
                    e = Date.now();
                    c.apply(k, j)
                }
                function h() {
                    d = undefined
                }
                if (g && !d) {
                    i()
                }
                d && clearTimeout(d);
                if (g === undefined && l > b) {
                    i()
                } else {
                    d = setTimeout(g ? h: i, g === undefined ? b - l: b)
                }
            }
            f._zid = c._zid = c._zid || a.proxy(c)._zid;
            return f
        },
        debounce: function(b, d, c) {
            return d === undefined ? a.throttle(250, b, false) : a.throttle(b, d, c === undefined ? false: c !== false)
        }
    })
})(Zepto);
top.tlbsEmbed = true;