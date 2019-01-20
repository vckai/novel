<body>
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>小说管理</cite></a>
		  <a><cite>小说列表</cite></a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height: 1.6em; margin-top: 3px; float: right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
	</div>
	<div class="x-body">
		<form class="layui-form x-center" action="" style="width:80%">
			<div class="layui-form-pane" style="margin-top: 15px;">
			  <div class="layui-form-item">
				<div class="layui-input-inline">
				  <input type="text" name="q"  placeholder="请输入小说名称" autocomplete="off" class="layui-input" value="{{.Search.q}}">
				</div>
				<div class="layui-input-inline" style="width:80px">
					<button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
				</div>
			  </div>
			</div> 
		</form>
		<xblock>
			<button class="layui-btn layui-btn-danger" onclick="del_all()"><i class="layui-icon">&#xe640;</i>批量删除</button>
			<button class="layui-btn" onclick="x_admin_show('添加小说', '{{urlfor "admin.NovelController.Add"}}')"><i class="layui-icon">&#xe608;</i>添加</button>
			<button class="layui-btn" onclick="x_admin_show('运行爬虫', '{{urlfor "admin.NovelController.Crawler"}}')"><i class="layui-icon">&#xe608;</i>运行爬虫</button>
			<button class="layui-btn" onclick="x_admin_show('添加小说采集', '{{urlfor "admin.NovelController.AddSnatch"}}')"><i class="layui-icon">&#xe608;</i>添加采集</button>

			<div class="layui-input-inline" style="width:250px">
			<input type="text" id="nov_name" placeholder="请输入采集小说名称" autocomplete="off" class="layui-input" value="">
			</div>
			<button class="layui-btn" onclick="find_snatch()"><i class="layui-icon">&#xe615;</i>搜索采集小说</button>
			<span class="x-right" style="line-height:40px">共有数据：{{.NovelsCount}} 条</span>
		</xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th><input type="checkbox" name="" value="" class="all-select"></th>
					<th>ID</th>
					<th>小说名称</th>
					<th>小说作者</th>
					<th>小说分类</th>
					<th>小说状态</th>
					<th>章节数</th>
					<th>热门</th>
					<th>推荐</th>
					<th>精品</th>
					<th>章节更新时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			{{range .Novels}}
				<tr>
					<td><input type="checkbox" value="{{.Id}}" name="" class="all-x-select"></td>
					<td>{{.Id}}</td>
					<td><a href="{{urlfor "home.BookController.Index" "id" .Id}}" target="_blank">{{.Name}}</a></td>
					<td>{{.Author}}</td>
					<td>{{.CateName}}</td>
					<td>{{map_get .StatusList .Status}}</td>
					<td>{{.ChapterNum}}</td>
					<td>{{str2html .IsHotName}}</td>
					<td>{{str2html .IsRecName}}</td>
					<td>{{str2html .IsVipRecName}}</td>
					<td>{{datetime .ChapterUpdatedAt "01-02 15:04:05"}}</td>
					<td class="td-manage">
						<a title="编辑小说" href="javascript:;" onclick="x_admin_show('编辑小说', {{urlfor "admin.NovelController.Edit" "id" .Id}})" class="ml-5" style="text-decoration:none">
							<i class="layui-icon">&#xe642;</i>
						</a>
						<a title="查看章节列表" href="javascript:;" onclick="x_admin_show('【{{.Name}}】小说章节列表', {{urlfor "admin.ChapterController.Index" "novid" .Id}})" class="ml-5" style="text-decoration:none">
							<i class="layui-icon">&#xe62d;</i>
						</a>
						<a title="查看采集站点" href="javascript:;" onclick="x_admin_show('【{{.Name}}】小说采集站点列表', '{{urlfor "admin.NovelController.Links" "novid" .Id}}')" class="ml-5" style="text-decoration:none">
							<i class="layui-icon">&#xe60a;</i>
						</a>
						<a title="执行采集" href="javascript:;" onclick="snatch_novel('{{.Id}}', '{{.Name}}')" class="ml-5" style="text-decoration:none">
							<i class="layui-icon">&#xe623;</i>
						</a>
						<a title="删除" href="javascript:;" onclick="del(this, '{{.Id}}', '{{.Name}}')" style="text-decoration:none">
							<i class="layui-icon">&#xe640;</i>
						</a>
						<a title="清空章节内容" href="javascript:;" onclick="del_chapter(this, '{{.Id}}', '{{.Name}}')" style="text-decoration:none">
							<i class="layui-icon">&#x1007;</i>
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
			layui.use(['laypage', 'layer'], function() {
				$ = layui.jquery; //jquery
				layer = layui.layer; //弹出层

				// 分页
				layui.laypage({
					cont: 'page',
					pages: {{.MaxPages}},
					last: {{.MaxPages}},
					curr: {{.Search.p}},
					first: 1,
					prev: '<em><</em>',
					next: '<em>></em>',
					skip: false,
					jump: function (obj, first) {
						if (first != true) {
							window.location.href = {{urlfor "admin.NovelController.Index"}} + "?p=" + obj.curr + "&q={{.Search.q}}";
						}
					}
				}); 
			});
		}

		function find_snatch() {
			var kw = $("#nov_name").val();
			if (kw == "") {
				layer.msg("请输入小说名称", {icon: 2});	
				return ;
			}

			x_admin_show('搜索采集小说', '{{urlfor "admin.NovelController.FindSnatchs"}}?kw='+kw);
		}

		// 批量删除提交
		function del_all() {
			layer.confirm('确认要删除吗？', function(index) {
                var ids = get_list_ids('all-x-select');
				//发异步删除数据
				ajax_post({{urlfor "admin.NovelController.DeleteBatch"}}, {ids: ids});
			});
		}

		// 删除
		function del(obj, id, name) {
			layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.NovelController.Delete"}}, {id: id, name: name});
			});
		}

		// 删除章节内容
		function del_chapter(obj, id, name) {
			layer.confirm('确认要清空小说章节吗？', function(index) {
				//发异步删除数据
				ajax_post({{urlfor "admin.NovelController.DelChapters"}}, {id: id, name: name});
			});
		}

		// 执行采集操作
		function snatch_novel(id, name) {
			layer.confirm('确认要手动执行【'+name+'】采集任务吗？', function(index) {
				//发异步删除数据
				ajax_post({{urlfor "admin.NovelController.Snatch"}}, {id: id, name: name});
			});
		}
	</script>
</body>
