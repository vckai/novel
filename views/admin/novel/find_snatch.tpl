<body>
	<div class="x-body">
		<table class="layui-table">
			<thead>
				<tr>
					<th>小说名称</th>
					<th>小说作者</th>
					<th>小说描述</th>
					<th>来源</th>
					<th>最新章节</th>
					<th>耗时</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			{{if gt .NovsCount 0}}
			{{range .Novs}}
				<tr>
					<td><a href="{{.Url}}" target="_blank">{{.Nov.Name}}</a></td>
					<td>{{.Nov.Author}}</td>
					<td>{{substr_no_html .Nov.Desc 0 30}}</td>
					<td>{{.Title}}</td>
					<td>{{.Nov.ChapterTitle}}</td>
					<td>{{.UseTime}}</td>
					<td class="td-manage">
						<a href="javascript:;" onclick="snatch('{{.Url}}')" class="layui-btn"><i class="layui-icon">&#xe608;</i>采集</a>
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

		// 添加采集
		function snatch(url) {
			ajax_post({{urlfor "admin.NovelController.AddSnatch"}}, {url: url}, "", true, false);
		}
	</script>
</body>
