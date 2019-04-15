<body>
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header header header-demo">
			<div class="layui-main">
				<a class="logo" href="{{urlfor "admin.MainController.Index"}}">
					{{.aOut.Title}}
				</a>
				<ul class="layui-nav" lay-filter="">
				  <li class="layui-nav-item">
					<a href="javascript:;">{{.LoginUserName}}</a>
					<dl class="layui-nav-child"> <!-- 二级菜单 -->
                      <dd><a href="javascript:;" onclick="x_admin_show('个人信息',  '{{urlfor "admin.AdminController.Edit"}}')">个人信息</a></dd>
					  <dd><a href="{{urlfor "admin.LoginController.Logout"}}">退出</a></dd>
					</dl>
				  </li>
				</ul>
			</div>
		</div>
		<div class="layui-side layui-bg-black x-side">
			{{template "admin/common/menu.tpl" .}} 
		</div>
		<div class="layui-tab layui-tab-card site-demo-title x-main" lay-filter="x-tab" lay-allowclose="true">
			<div class="x-slide_left"></div>
			<ul class="layui-tab-title" style="display:none">
				<li class="layui-this">
					首页
					<i class="layui-icon layui-unselect layui-tab-close">ဆ</i>
				</li>
			</ul>
			<div class="layui-tab-content site-demo site-demo-body">
				<div class="layui-tab-item layui-show">
					<iframe frameborder="0" src="{{urlfor "admin.HomeController.Index"}}" class="x-iframe"></iframe>
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
        window.onload = function() {
            layui.use(['layer'], function() {
                $ = layui.jquery; //jquery
                layer = layui.layer; //弹出层
            });
        }
    </script>
