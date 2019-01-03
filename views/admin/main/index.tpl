<body>
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header header header-demo">
			<div class="layui-main">
				<a class="logo" href="{{urlfor "admin.MainController.Index"}}">
					{{.aOut.Title}}
				</a>
				<ul class="layui-nav" lay-filter="">
				  <li class="layui-nav-item">
					<a href="javascript:;">admin</a>
					<dl class="layui-nav-child"> <!-- 二级菜单 -->
					  <dd><a>个人信息</a></dd>
					  <dd><a href="{{urlfor "admin.LoginController.Logout"}}">退出</a></dd>
					</dl>
				  </li>
				  <li class="layui-nav-item">
					<a href="" title="消息">
						<i class="layui-icon" style="top: 1px;">&#xe63a;</i>
					</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="layui-side layui-bg-black x-side">
			{{template "admin/common/menu.tpl" .}} 
		</div>
		<div class="layui-tab layui-tab-card site-demo-title x-main" lay-filter="x-tab" lay-allowclose="true">
			<div class="x-slide_left"></div>
			<ul class="layui-tab-title">
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
