<body class="x-iframe-body">
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>banner管理</cite></a>
		  <a><cite>banner列表</cite></a>
		</span>
	</div>
	<div class="x-body">
        <div class="layui-card">
            <xblock>
                <button class="layui-btn layui-btn-danger" onclick="del_all()"><i class="layui-icon">&#xe640;</i>批量删除</button>
                <button class="layui-btn" onclick="x_admin_show('添加banner', '{{urlfor "admin.BannerController.Add"}}')"><i class="layui-icon">&#xe608;</i>添加</button>
                <span class="x-right" style="line-height:40px">共有数据：{{.Count}} 条</span>
            </xblock>
            <table class="layui-table layui-form">
                <thead>
                    <tr>
                        <th style="width: 30px"><input type="checkbox" lay-skin="primary" lay-filter="all-select"></th>
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
                {{range .List}}
                    <tr>
                        <td><input type="checkbox" lay-skin="primary" value="{{.Id}}" class="all-x-select"></td>
                        <td>{{.Id}}</td>
                        <td><img src="{{.Img}}" width="200" /></td>
                        <td>{{map_get $.Zones .Zone}}</td>
                        <td>{{.Link}}</td>
                        <td>{{.Desc}}</td>
                        <td>{{str2html .StatusName}}</td>
                        <td>{{datetime .CreatedAt "2006-01-02 15:04:05"}}</td>
                        <td class="td-manage">
                            <a href="javascript:;" onclick="x_admin_show('编辑banner', {{urlfor "admin.BannerController.Edit" "id" .Id}})" class="layui-btn layui-btn-xs layui-btn-normal">
                                <i class="layui-icon">&#xe642;</i>编辑
                            </a>
                            <a class="layui-btn layui-btn-xs layui-btn-danger" href="javascript:;" onclick="del(this,'{{.Id}}', '{{.Name}}')">
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
			parent.layer.confirm('确认要删除吗？', function(index) {
                var ids = get_list_ids('all-x-select');
				// 发异步删除数据
				ajax_post({{urlfor "admin.BannerController.DeleteBatch"}}, {ids: ids}, top.reload_page);
			});
		}

		// 删除
		function del(obj, id, name) {
			tparentop.layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.BannerController.Delete"}}, {id: id, name: name}, top.reload_page);
			});
		}
	</script>
</body>
