<body class="x-iframe-body">
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>小说管理</cite></a>
		<a><cite>分类管理</cite></a>
		</span>
	</div>
	<div class="x-body">
	    <div class="layui-card">	
            <xblock>
                <button class="layui-btn layui-btn-danger" onclick="del_all()"><i class="layui-icon">&#xe640;</i>批量删除</button>
                <button class="layui-btn" onclick="x_admin_show('添加分类', '{{urlfor "admin.CateController.Add"}}', '350', '350')"><i class="layui-icon">&#xe608;</i>添加</button>
                <span class="x-right" style="line-height:40px">共有数据：{{.Count}} 条</span>
            </xblock>
            <table class="layui-table layui-form">
                <thead>
                    <tr>
                        <th style="width: 30px"><input type="checkbox" lay-skin="primary" lay-filter="all-select"></th>
                        <th>ID</th>
                        <th>分类名称</th>
                        <th>是否首页</th>
                        <th>是否菜单</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                {{range .List}}
                    <tr>
                        <td><input type="checkbox" value="{{.Id}}" lay-skin="primary" class="all-x-select"></td>
                        <td>{{.Id}}</td>
                        <td>{{.Name}}</td>
                        <td>{{str2html .IsMenuName}}</td>
                        <td>{{str2html .IsHomeName}}</td>
                        <td class="td-manage">
                            <a href="javascript:;" onclick="x_admin_show('编辑', {{urlfor "admin.CateController.Edit" "id" .Id}}, '350', '350')" class="layui-btn layui-btn-xs layui-btn-normal">
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
			layui.use(['layer', 'form'], function() {
				$ = layui.jquery; //jquery
				layer = layui.layer; //弹出层
				form = layui.form; //表单
			});
		}

		// 批量删除提交
		function del_all() {
			top.layer.confirm('确认要删除吗？', function(index) {
                var ids = get_list_ids('all-x-select');
				//发异步删除数据
				ajax_post({{urlfor "admin.CateController.DeleteBatch"}}, {ids: ids}, top.reload_page);
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
