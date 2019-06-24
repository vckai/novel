<body>
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
            <ul class="layui-nav layui-layout-left">
              <li class="layui-nav-item layui-hide-xs" lay-unselect="" style="margin-left:30px;">
                <a href="{{.aOut.WebURL}}" target="_blank" title="前台">
                  <i class="layui-icon layui-icon-website"></i>
                </a>
              </li>
              <li class="layui-nav-item" lay-unselect="">
                <a href="javascript:;" onclick="reload_page();" title="刷新">
                  <i class="layui-icon layui-icon-refresh-3"></i>
                </a>
              </li>
              <li class="layui-nav-item layui-hide-xs" lay-unselect="">
                <input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search" layadmin-event="serach" lay-action="template/search.html?keywords="> 
              </li>
            </ul>

            <ul class="layui-nav layui-layout-right" lay-filter="">
              <li class="layui-nav-item">
                <a href="javascript:;">
                    <cite>{{.LoginUserName}}</cite>
                </a> 
                <!-- 二级菜单 -->
                <dl class="layui-nav-child layui-anim layui-anim-upbit x-nav-child">
                  <dd><a href="javascript:;" onclick="x_admin_show('个人信息', '{{urlfor "admin.MainController.EditUser"}}', 550, 500)">个人信息</a></dd>
                  <dd><a href="javascript:;" onclick="x_admin_show('修改密码', '{{urlfor "admin.MainController.EditPass"}}', 550, 300)">修改密码</a></dd>
                  <hr />
                  <dd><a href="{{urlfor "admin.LoginController.Logout"}}">退出</a></dd>
                </dl>
              </li>
              <li class="layui-nav-item layui-hide-xs" lay-unselect="">
                <a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>
              </li>
            </ul>
		</div>
        <div class="layui-logo">
            <span>{{.aOut.Title}}</span>
        </div>
		<div class="layui-side layui-side-menu x-side">
            <div class="layui-side-scroll">
                {{template "admin/common/menu.tpl" .}} 
            </div>
		</div>
		<div class="layui-tab layui-tab-card site-demo-title x-main" lay-filter="x-tab" lay-allowclose="true">
			<ul class="layui-tab-title" style="display:none">
				<li class="layui-this">
					首页
					<i class="layui-icon layui-unselect layui-tab-close">ဆ</i>
				</li>
			</ul>
			<div class="layui-tab-content site-demo site-demo-body">
				<div class="layui-tab-item layui-show">
					<iframe frameborder="0" src="" class="x-iframe"></iframe>
				</div>
			</div>
		</div>
		<div class="site-mobile-shade">
		</div>
	</div>
    <!--loading-->
    <div class="loading-box">
        <div class="loading">
            <img src="{{.aOut.ViewUrl}}img/admin/loading.gif" alt="">
        </div>
    </div>
    <script>
        var def_main_page = {{urlfor "admin.HomeController.Index"}};
        window.onload = function() {
            layui.use(['layer'], function() {
                $ = layui.jquery; //jquery
                layer = layui.layer; //弹出层
            });
        }
    </script>
