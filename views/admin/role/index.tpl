<body>
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>管理员管理</cite></a>
		  <a><cite>权限/菜单管理</cite></a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height: 1.6em; margin-top: 3px; float: right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
	</div>
	<div class="x-body">
		
		<xblock>
			<button class="layui-btn layui-btn-danger" onclick="del_all()"><i class="layui-icon">&#xe640;</i>批量删除</button>
			<button class="layui-btn" onclick="x_admin_show('添加权限', '{{urlfor "admin.RoleController.Add"}}', '650', '680')"><i class="layui-icon">&#xe608;</i>添加</button>
			<span class="x-right" style="line-height:40px">共有数据：{{.roles_count}} 条</span>
		</xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th><input type="checkbox" name="" value="" class="all-select"></th>
					<th>ID</th>
					<th>权限名称</th>
					<th>模块/方法</th>
					<th>是否菜单</th>
					<th>描述</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			{{range .roles}}
				<tr>
					<td><input type="checkbox" value="{{.Id}}" name="" class="all-x-select"></td>
					<td>{{.Id}}</td>
					<td>{{.Name}}</td>
					<td>{{if compare .Module ""}}-{{else}}{{.Module}}/{{.Action}}{{end}}</td>
					<td>{{str2html .IsMenuName}}</td>
					<td>{{.Desc}}</td>
					<td class="td-manage">
						<a title="编辑" href="javascript:;" onclick="x_admin_show('编辑', {{urlfor "admin.RoleController.Edit" "id" .Id}}, '650', '730')" class="ml-5" style="text-decoration:none">
							<i class="layui-icon">&#xe642;</i>
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

		// 批量删除提交
		function del_all() {
			layer.confirm('确认要删除吗？', function(index) {
				// 捉到所有被选中的，发异步进行删除
				layer.msg('删除成功', {icon: 1});
			});
		}

		// 删除
		function role_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.CateController.Delete"}}, {id: id});
			});
		}
	</script>
</body>
