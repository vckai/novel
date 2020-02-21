<body class="x-iframe-body">

<style>
html{color: #666}
.layui-form .layui-form-label {width: 100px;}
.layui-form .layui-input-block {margin-left: 130px;}
</style>
<div class="x-nav">
    <span class="layui-breadcrumb">
      <a><cite>首页</cite></a>
      <a><cite>系统设置</cite></a>
      <a><cite>网站配置</cite></a>
    </span>
</div>

<div class="x-body">
    <div class="layui-card">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
          <ul class="layui-tab-title">
            <li class="{{if eq .Tab ""}}layui-this{{end}}">网站配置</li>
            <li class="{{if eq .Tab "snatch"}}layui-this{{end}}">采集配置</li>
            <li class="{{if eq .Tab "proxy"}}layui-this{{end}}">代理配置</li>
          </ul>
          <div class="layui-tab-content layui-card-body">
            <div class="layui-tab-item {{if eq .Tab ""}}layui-show{{end}}">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>网站名称
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="Title" autocomplete="off" placeholder="最好控制在10个字、50个字节以内"
                            class="layui-input" lay-verify="required" value="{{.Config.Title}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            网站副标题
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="SubTitle" autocomplete="off" placeholder="控制在25个字、50个字节以内"
                            class="layui-input" value="{{.Config.SubTitle}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            PC网站URL
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="WebURL" autocomplete="off" class="layui-input" placeholder="PC网站主域名配置" value="{{.Config.WebURL}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            手机网站URL
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="MobileURL" autocomplete="off" class="layui-input" placeholder="默认为/m，可配置指向其他域名" value="{{.Config.MobileURL}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            管理后台URL
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="AdminURL" autocomplete="off" class="layui-input" placeholder="默认为/admin，可配置指向其他域名" value="{{.Config.AdminURL}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            静态资源URL
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="ViewURL" autocomplete="off" placeholder="默认为/public/，可配置指向其他域名"
                            class="layui-input" value="{{.Config.ViewURL}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>PC网站模板
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="Theme" autocomplete="off" class="layui-input" lay-verify="required" value="{{.Config.Theme}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>手机网站模板
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="MobileTheme" autocomplete="off" class="layui-input" lay-verify="required" value="{{.Config.MobileTheme}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">网站LOGO</label>
                        <div class="layui-input-inline" style="width: 60px;">
                            <img id="LAY_upload_logo" width="50" src="{{.Config.Logo}}" />
                            <input type="hidden" id="logo" name="Logo" value="{{.Config.Logo}}" />
                        </div>
                        <div class="layui-input-inline">
                          <div class="site-demo-upbar">
                            <button type="button" name="upimg" class="layui-btn layui-btn-primary" id="upimg_logo">
                                <i class="layui-icon">&#xe67c;</i>上传图片
                            </button>
                          </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">Favicon图标</label>
                        <div class="layui-input-inline" style="width: 60px;">
                            <img id="LAY_upload_favicon" width="32" height="32" src="{{.Config.Favicon}}">
                            <input type="hidden" id="favicon" name="Favicon" value="{{.Config.Favicon}}" />
                        </div>
                        <div class="layui-input-inline">
                          <div class="site-demo-upbar">
                            <button type="button" name="upimg" class="layui-btn layui-btn-primary" id="upimg_favicon">
                                <i class="layui-icon">&#xe67c;</i>上传图片
                            </button>
                          </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            网站关键词
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="Keyword" autocomplete="off" placeholder="5个左右，8汉字以内，用英文,隔开"
                            class="layui-input" value="{{.Config.Keyword}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            网站描述
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="Description" autocomplete="off" placeholder="空制在80个汉字，160个字符以内"
                            class="layui-input" value="{{.Config.Description}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            底部版权信息
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="Copyright" autocomplete="off" placeholder="&copy; 2017 - 2019 KAQIU8.COM" class="layui-input" value="{{.Config.Copyright}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            备案号
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="Icp" autocomplete="off" placeholder="京ICP备00000000号"
                            class="layui-input" value="{{.Config.Icp}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            统计JS代码
                        </label>
                        <div class="layui-input-block">
                            <textarea name="StatisticsCode" autocomplete="off" placeholder="统计JS代码"
                            class="layui-textarea" rows="5">{{.Config.StatisticsCode}}</textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <input type="submit" class="layui-btn" lay-submit="" lay-filter="base" value="保存" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="layui-tab-item {{if eq .Tab "snatch"}}layui-show{{end}}">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label for="AutoNewSnatchDay" class="layui-form-label">
                            <span class="x-red">*</span>每天自动采集新小说
                        </label>
                        <div class="layui-input-block">
                          <input type="checkbox" {{if eq (or .Config.AutoNewSnatchDay "") "1"}}checked{{end}} name="AutoNewSnatchDay" lay-skin="switch" lay-filter="switchTest" lay-text="开启|关闭" vlaue="1" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="AutoSnatchRank" class="layui-form-label">
                            <span class="x-red">*</span>是否采集排行榜
                        </label>
                        <div class="layui-input-block">
                          <input type="checkbox" {{if eq (or .Config.AutoSnatchRank "") "1"}}checked{{end}} name="AutoSnatchRank" lay-skin="switch" lay-filter="switchTest" lay-text="开启|关闭" vlaue="1" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="IsSnatch" class="layui-form-label">
                            <span class="x-red">*</span>开启自动更新章节
                        </label>
                        <div class="layui-input-block">
                          <input type="checkbox" {{if eq (or .Config.IsSnatch "") "1"}}checked{{end}} name="IsSnatch" lay-skin="switch" lay-filter="switchTest" lay-text="开启|关闭" vlaue="1" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            更新间隔
                        </label>
                        <div class="layui-input-inline" >
                            <input type="number" name="Uptime" autocomplete="off" class="layui-input" placeholder="每次更新小说的时间间隔，单位：秒" value="{{.Config.Uptime}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            停更天数
                        </label>
                        <div class="layui-input-inline">
                            <input type="number" name="NotUpStopDays" autocomplete="off" class="layui-input" placeholder="小说无新内容后停止更新，单位：天" value="{{.Config.NotUpStopDays}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <input type="submit" class="layui-btn" lay-submit="" lay-filter="snatch" value="保存" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="layui-tab-item {{if eq .Tab "proxy"}}layui-show{{end}}">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label for="cate_id" class="layui-form-label">
                            代理模式
                        </label>
                        <div class="layui-input-inline">
                          <select name="ProxyMode" lay-verify="proxy_mode">
                            <option value="0">不启用</option>
                            <option value="1" {{if eq (or .Config.ProxyMode "") "1"}}selected{{end}}>代理IP</option>
                            <option value="2" {{if eq (or .Config.ProxyMode "") "2"}}selected{{end}}>自动代理</option>
                          </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            IP更新时间
                        </label>
                        <div class="layui-input-inline">
                            <input type="number" name="ProxyUpTime" autocomplete="off" class="layui-input" placeholder="API切换时间，单位：分钟" value="{{.Config.ProxyUpTime}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">
                            IP检测时间
                        </label>
                        <div class="layui-input-inline">
                            <input type="number" name="ProxyCheckTime" autocomplete="off" class="layui-input" placeholder="IP可用性检测时间，单位：毫秒" value="{{.Config.ProxyCheckTime}}" />
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" >
                            代理URL
                        </label>
                        <div class="layui-input-block" >
                            <input type="text" name="ProxyURL" autocomplete="off" class="layui-input" value="{{.Config.ProxyURL}}">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <input type="submit" class="layui-btn" lay-submit="" lay-filter="proxy" value="保存" />
                        </div>
                    </div>
                </form>
            </div>
          </div>
        </div>
    </div> 
</div>

<script>
    window.onload = function() {
        layui.use(['form', 'layer', 'upload'], function() {
            $ = layui.jquery;

            var form = layui.form
                ,layer = layui.layer;

            // logo图片上传接口
            layui.upload.render({
                elem: '#upimg_logo', // 绑定元素
                field: 'upimg',
                url: {{urlfor "admin.HomeController.UpImg"}},
                done: function(res) { //上传成功后的回调
                    if (res.ret == 0) {
                        $('#LAY_upload_logo').attr('src', res.data.url);
                        $('#logo').val(res.data.url);
                    } else {
                        layer.msg(res.msg, {icon: 3});
                    }
                }
            });

            // favicon图片上传接口
            layui.upload.render({
                elem: '#upimg_favicon', // 绑定元素
                field: 'upimg',
                url: {{urlfor "admin.HomeController.UpImg"}},
                done: function(res) { //上传成功后的回调
                    if (res.ret == 0) {
                        $('#LAY_upload_favicon').attr('src', res.data.url);
                        $('#favicon').val(res.data.url);
                    } else {
                        layer.msg(res.msg, {icon: 3});
                    }
                }
            });

            var url   = {{urlfor "admin.ConfigController.Save"}};
            var tourl = {{urlfor "admin.ConfigController.Index"}};

            // 监听提交
            form.on('submit(base)', function(data) {
                ajax_post(url, data.field, function () {
                    top.load_page(tourl); 
                }, true, false);

                return false;
            });

            // 监听提交
            form.on('submit(snatch)', function(data) {
                if (typeof data.field.IsSnatch == "undefined") {
                    data.field.IsSnatch = "0";
                } else {
                    data.field.IsSnatch = "1";
                }
                if (typeof data.field.AutoNewSnatchDay == "undefined") {
                    data.field.AutoNewSnatchDay = "0";
                } else {
                    data.field.AutoNewSnatchDay = "1";
                }
                if (typeof data.field.AutoSnatchRank == "undefined") {
                    data.field.AutoSnatchRank = "0";
                } else {
                    data.field.AutoSnatchRank = "1";
                }
                ajax_post(url, data.field, function () {
                    top.load_page(tourl + '?tab=snatch')
                }, true, false);

                return false;
            });

            // 监听提交
            form.on('submit(proxy)', function(data) {
                ajax_post(url, data.field, function () {
                    top.load_page(tourl + '?tab=proxy')
                }, true, false);

                return false;
            });
        });
    }
</script>

</body>
