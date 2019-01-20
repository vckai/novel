<body>
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>管理员管理</cite></a>
		  <a><cite>管理员列表</cite></a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height: 1.6em; margin-top: 3px; float: right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
	</div>
	<div class="x-body">
		<xblock>
			<button class="layui-btn" onclick="x_admin_show('添加管理员', '{{urlfor "admin.AdminController.Add"}}')"><i class="layui-icon">&#xe608;</i>添加</button>
			<span class="x-right" style="line-height:40px">共有数据：{{.admins_count}} 条</span>
		</xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th>ID</th>
					<th>账号</th>
					<th>昵称</th>
					<th>手机号码</th>
					<th>邮箱地址</th>
					<th>状态</th>
					<th>群组</th>
					<th>登录次数</th>
					<th>最后登录IP</th>
					<th>最后登录时间</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			{{range .admins}}
				<tr>
					<td>{{.Id}}</td>
					<td>{{.Account}}</td>
					<td>{{.Name}}</td>
					<td>{{itoa .Mobile}}</td>
					<td>{{.Mail}}</td>
					<td>{{str2html .StatusName}}</td>
					<td>{{.GroupName}}</td>
					<td>{{.LoginVisit}}</td>
					<td>{{.LastLoginIp}}</td>
					<td>{{datetime .LastLoginedAt "2006-01-02 15:04"}}</td>
					<td>{{datetime .CreatedAt "2006-01-02 15:04"}}</td>
					<td class="td-manage">
						<a title="编辑管理员" href="javascript:;" onclick="x_admin_show('编辑管理员', {{urlfor "admin.AdminController.Edit" "id" .Id}})" class="ml-5" style="text-decoration:none">
							<i class="layui-icon">&#xe642;</i>
						</a>
						<a onclick="x_admin_show('修改密码', '{{urlfor "admin.AdminController.EditPass" "id" .Id}}')" href="javascript:;" title="修改密码">
							<i class="layui-icon">&#xe631;</i>
						</a>
						<a title="删除" href="javascript:;" onclick="role_del(this,'{{.Id}}')" style="text-decoration:none">
							<i class="layui-icon">&#xe640;</i>
						</a>
					</td>
				</tr>
			{{end}}
			</tbody>
		</table>
		<div id="page"></div>
	</div>
	<script>
		window.onload = function() {
			layui.use(['laypage','layer'], function() {
				$ = layui.jquery; //jquery
				laypage = layui.laypage; //分页
				layer = layui.layer; //弹出层
			});
		}

		// 删除
		function role_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.AdminController.Delete"}}, {id: id});
			});
		}
	</script>
</body>
