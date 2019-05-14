<body>
	<div class="x-body">
		<table class="layui-table">
			<thead>
				<tr>
					<th>来源站点</th>
					<th>站点URL</th>
					<th>添加时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			{{if gt .NovLinksCount 0}}
                {{range .NovLinks}}
                    <tr>
                        <td><a href="{{.Link}}" target="_blank">{{.Source}}</a></td>
                        <td>{{.Link}}</td>
                        <td>{{datetime .CreatedAt "01-02 15:04:05"}}</td>
                        <td class="td-manage">
                            <a class="layui-btn layui-btn-xs layui-btn-danger" href="javascript:;" onclick="del(this, '{{.Id}}', '{{.NovId}}', '{{.Source}}')">
                                <i class="layui-icon">&#xe640;</i>删除
                            </a>
                        </td>
                    </tr>
                {{end}}
			{{end}}
			</tbody>
		</table>
	</div>

	<script>
		window.onload = function() {
			layui.use(['layer', 'form'], function() {
				$ = layui.jquery; //jquery
				layer = layui.layer; //弹出层
			});
		}

		// 删除
		function del(obj, id, nov_id, source) {
			top.layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.NovelController.DelLink"}}, {id: id, nov_id: nov_id, source: source}, "", true, false);
			});
		}
	</script>
</body>
