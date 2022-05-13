<body class="x-iframe-body">
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>小说管理</cite></a>
		<a><cite>采集规则</cite></a>
		</span>
	</div>
	<div class="x-body">
        <div class="layui-card">
            <xblock>
                <button class="layui-btn layui-btn-danger" onclick="del_all()"><i class="layui-icon">&#xe640;</i>批量删除</button>
                <button class="layui-btn layui-btn-normal" onclick="export_rules()"><i class="layui-icon">&#xe601;</i>批量导出</button>
                <button class="layui-btn" onclick="x_admin_show('添加采集规则', '{{urlfor "admin.SnatchRuleController.Add"}}')"><i class="layui-icon">&#xe608;</i>添加</button>
                <button class="layui-btn" onclick="x_admin_show('导入规则', '{{urlfor "admin.SnatchRuleController.Import"}}')"><i class="layui-icon">&#xe608;</i>导入规则</button>
                <button class="layui-btn" onclick="x_admin_show('模拟测试获取页面元素', '{{urlfor "admin.SnatchRuleController.Goquery"}}')"><i class="layui-icon">&#xe631;
</i>模拟测试获取页面元素</button>
                <span class="x-right" style="line-height:40px">共有数据：{{.Count}} 条</span>
            </xblock>
            <table class="layui-table layui-form">
                <thead>
                    <tr>
                        <th style="width: 30px"><input type="checkbox" lay-skin="primary" lay-filter="all-select"></th>
                        <th>ID</th>
                        <th>网站名称</th>
                        <th>网站标识码</th>
                        <th>URL</th>
                        <th>编码格式</th>
                        <th>启用状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                {{range .Rules}}
                    <tr>
                        <td><input type="checkbox" value="{{.Id}}" lay-skin="primary" class="all-x-select"></td>
                        <td>{{.Id}}</td>
                        <td>{{.Name}}</td>
                        <td>{{.Code}}</td>
                        <td>{{.Url}}</td>
                        <td>{{.Charset}}</td>
                        <td>{{str2html .StateName}}</td>
                        <td class="td-manage">
                            <a href="javascript:;" onclick="x_admin_show('编辑', {{urlfor "admin.SnatchRuleController.Edit" "id" .Id}})" class="layui-btn layui-btn-xs layui-btn-normal">
                                <i class="layui-icon">&#xe642;</i>编辑
                            </a>
                            <a class="layui-btn layui-btn-xs layui-btn-normal" href="javascript:;" onclick="export_rule(this, '{{.Id}}')">
                                <i class="layui-icon">&#xe601;</i>导出
                            </a>
                            <a class="layui-btn layui-btn-xs layui-btn-warm" href="javascript:;" onclick="test(this, '{{.Id}}')">
                                <i class="layui-icon">&#xe623;</i>测试
                            </a>
                            <a class="layui-btn layui-btn-xs layui-btn-danger" href="javascript:;" onclick="del(this, '{{.Id}}', '{{.Name}}')">
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
			layui.use(['layer', 'element'], function() {
				var $ = layui.jquery; //jquery
				var layer = layui.layer; //弹出层
				var element = layui.element;//面包导航
			});

            // 设置启用
            $(".btn-set-state").click(function () {
                var id   = $(this).parent().parent().find("td").eq(1).text();
                var name = $(this).parent().parent().find("td").eq(2).text();
                layer.confirm('确定要启用该采集规则吗？', function(index) {
                    ajax_post({{urlfor "admin.SnatchRuleController.UpState"}}, {id: id, state: 1, name: name});
                });
            });

            // 设置禁用
            $(".btn-set-un-state").click(function () {
                var id   = $(this).parent().parent().find("td").eq(1).text();
                var name = $(this).parent().parent().find("td").eq(2).text();
                layer.confirm('确定要禁用该采集规则吗？', function(index) {
                    ajax_post({{urlfor "admin.SnatchRuleController.UpState"}}, {id: id, state: 0, name: name});
                });
            });
		}

		// 批量删除提交
		function del_all() {
			layer.confirm('确认要删除吗？', function(index) {
                var ids = get_list_ids('all-x-select');
				//发异步删除数据
				ajax_post({{urlfor "admin.SnatchRuleController.DeleteBatch"}}, {ids: ids}, top.reload_page);
			});
		}

		// 删除
		function del(obj, id, name) {
			layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

                		//发异步删除数据
				ajax_post({{urlfor "admin.SnatchRuleController.Delete"}}, {id: id, name: name}, top.reload_page);
			});
		}

		// 导出单个规则
		function export_rule(obj, id) {
            window.location.href = {{urlfor "admin.SnatchRuleController.Export"}} + "?ids=" + id;
		}

		// 批量导出规则
		function export_rules() {
            var ids = get_list_ids('all-x-select');
            if (ids.length == 0) {
                top.layer.msg("请选择需要导出的规则", {icon: 5});
                return 
            } else {
                window.location.href = {{urlfor "admin.SnatchRuleController.Export"}} + "?ids=" + ids.join(",");
            }
		}

		// 测试规则
		function test(obj, id) {
            x_admin_show('测试采集规则', '{{urlfor "admin.SnatchRuleController.Test"}}?id=' + id, '80%', '80%');
		}
	</script>
</body>
