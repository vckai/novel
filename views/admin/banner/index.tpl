<body>
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>banner管理</cite></a>
		  <a><cite>banner列表</cite></a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height: 1.6em; margin-top: 3px; float: right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
	</div>
	<div class="x-body">
		<xblock>
			<button class="layui-btn layui-btn-danger" onclick="del_all()"><i class="layui-icon">&#xe640;</i>批量删除</button>
			<button class="layui-btn" onclick="x_admin_show('添加banner', '{{urlfor "admin.BannerController.Add"}}', '600', '500')"><i class="layui-icon">&#xe608;</i>添加</button>
			<span class="x-right" style="line-height:40px">共有数据：{{.BannersCount}} 条</span>
		</xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th><input type="checkbox" name="" value="" class="all-select"></th>
					<th>ID</th>
					<th>缩略图</th>
					<th>广告位</th>
					<th>链接</th>
					<th>描述</th>
					<th>状态</th>
					<th>添加时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="x-img">
			{{range .Banners}}
				<tr>
					<td><input type="checkbox" value="{{.Id}}" name="" class="all-x-select"></td>
					<td>{{.Id}}</td>
					<td><img src="{{.Img}}" width="200" /></td>
					<td>{{map_get $.Zones .Zone}}</td>
					<td>{{.Link}}</td>
					<td>{{.Desc}}</td>
					<td>{{str2html .StatusName}}</td>
					<td>{{datetime .CreatedAt "2006-01-02 15:04:05"}}</td>
					<td class="td-manage">
						<a title="编辑banner" href="javascript:;" onclick="x_admin_show('编辑banner', {{urlfor "admin.BannerController.Edit" "id" .Id}}, '600', '500')" class="ml-5" style="text-decoration:none">
							<i class="layui-icon">&#xe642;</i>
						</a>
						<a title="删除" href="javascript:;" onclick="del(this,'{{.Id}}', '{{.Name}}')" style="text-decoration:none">
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
			layui.use(['layer'], function() {
				$ = layui.jquery; //jquery
				layer = layui.layer; //弹出层

				layer.ready(function() { //为了layer.ext.js加载完毕再执行
					layer.photos({
						photos: '#x-img'
						//,shift: 5 //0-6的选择，指定弹出图片动画类型，默认随机
					});
				}); 
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
		function del(obj, id, name) {
			layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.BannerController.Delete"}}, {id: id, name: name});
			});
		}
	</script>
</body>
