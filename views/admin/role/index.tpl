<body class="x-iframe-body">
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>管理员管理</cite></a>
		  <a><cite>权限/菜单管理</cite></a>
		</span>
	</div>
	<div class="x-body">
	    <div class="layui-card">	
            <xblock>
                <button class="layui-btn" onclick="x_admin_show('添加权限', '{{urlfor "admin.RoleController.Add"}}')"><i class="layui-icon">&#xe608;</i>添加</button>
                <span class="x-right" style="line-height:40px">共有数据：{{.Count}} 条</span>
            </xblock>
            <table class="layui-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>权限名称</th>
                        <th>模块/方法</th>
                        <th>是否菜单</th>
                        <th>描述</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                {{range .List}}
                    <tr>
                        <td>{{.Id}}</td>
                        <td>{{.Name}}</td>
                        <td>{{if compare .Module ""}}-{{else}}{{.Module}}/{{.Action}}{{end}}</td>
                        <td>{{str2html .IsMenuName}}</td>
                        <td>{{.Desc}}</td>
                        <td class="td-manage">
                            <a href="javascript:;" onclick="x_admin_show('编辑', {{urlfor "admin.RoleController.Edit" "id" .Id}})" class="layui-btn layui-btn-xs layui-btn-normal">
                                <i class="layui-icon">&#xe642;</i>编辑
                            </a>
                            <a class="layui-btn layui-btn-xs layui-btn-danger" href="javascript:;" onclick="role_del(this,'{{.Id}}')">
                                <i class="layui-icon">&#xe640;</i>删除
                            </a>
                        </td>
                    </tr>
                {{end}}
                </tbody>
            </table>
            <div id="page"></div>
        </div>
	</div>
	<script>
		window.onload = function() {
			layui.use(['laypage', 'layer'], function() {
				$ = layui.jquery; //jquery
				layer = layui.layer; //弹出层
			});
		}

		// 删除
		function role_del(obj, id) {
			top.layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.CateController.Delete"}}, {id: id}, top.reload_page);
			});
		}
	</script>
</body>
