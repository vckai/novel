<body>
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>搜索管理</cite></a>
		  <a><cite>搜索记录</cite></a>
		</span>
		<a class="layui-btn layui-btn-small" style="line-height: 1.6em; margin-top: 3px; float: right"  href="javascript:top.reload();" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
	</div>
	<div class="x-body">
		<form class="layui-form x-center x-search-form" style="width:80%">
			<div class="layui-form-pane" style="margin-top: 15px;">
			  <div class="layui-form-item">
				<div class="layui-input-inline">
				  <input type="text" name="q" placeholder="请输入关键字" autocomplete="off" class="layui-input" value="{{.Search.q}}">
				</div>
				<div class="layui-input-inline" style="width:80px">
					<button class="layui-btn" type="button" id="btn-search"><i class="layui-icon">&#xe615;</i></button>
				</div>
			  </div>
			</div> 
		</form>
		<xblock>
			<button class="layui-btn layui-btn-danger" onclick="del_all()"><i class="layui-icon">&#xe640;</i>批量删除</button>
			<span class="x-right" style="line-height:40px">共有数据：{{.Count}} 条</span>
		</xblock>
		<table class="layui-table">
			<thead>
				<tr>
					<th><input type="checkbox" name="" value="" class="all-select"></th>
					<th>ID</th>
					<th>关键字</th>
					<th>搜索次数</th>
					<th>是否推荐</th>
					<th>时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				{{range .List}}
				<tr>
					<td><input type="checkbox" value="{{.Id}}" class="all-x-select"></td>
					<td>{{.Id}}</td>
					<td>{{.Kw}}</td>
					<td>{{.Views}}</td>
					<td>{{str2html .IsRecName}}</td>
					<td>{{datetime .CreatedAt "2006-01-02 15:04"}}</td>
					<td class="td-manage">
						<a title="删除" href="javascript:;" onclick="log_del(this, '{{.Id}}')" style="text-decoration:none">
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
		window.onload = function () {
			layui.use(['element', 'layer', 'laydate', 'laypage'], function() {
				var $ = layui.jquery;//jquery
				var laydate = layui.laydate;//日期插件
				var lement  = layui.element;//面包导航
				var layer   = layui.layer;//弹出层
				var laypage = layui.laypage;//分页

				// 分页
				laypage({
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
							top.load_page({{urlfor "admin.SearchController.Index"}} + "?p=" + obj.curr + "&q={{.Search.q}}");
						}
					}
				}); 
			});

            // 设置推荐
            $(".layui-btn-disabled").click(function () {
                var id = $(this).parent().parent().find("td").eq(1).text();
                var kw = $(this).parent().parent().find("td").eq(2).text();
                layer.confirm('确定要设置为推荐搜索关键字吗？', function(index) {
                    ajax_post({{urlfor "admin.SearchController.UpRec"}}, {id: id, is_rec: 1, kw: kw});
                });
            });

            // 设置取消推荐
            $(".layui-btn-normal").click(function () {
                var id = $(this).parent().parent().find("td").eq(1).text();
                var kw = $(this).parent().parent().find("td").eq(2).text();
                layer.confirm('确定要取消该推荐搜索关键字吗？', function(index) {
                    ajax_post({{urlfor "admin.SearchController.UpRec"}}, {id: id, is_rec: 0, kw: kw});
                });
            });

            $("input[name='q']").on("keydown", function (event) {
                if (event.keyCode == 13) {
                    $("#btn-search").click(); 
                } 
            });

            // 搜索
            $("#btn-search").click(function () {
                var query = $('.x-search-form').serialize();
                top.load_page({{urlfor "admin.SearchController.Index"}} + '?' + query);
            });
		}
		  
		// 批量删除提交
		function del_all() {
			layer.confirm('确认要删除吗？', function(index) {
                var ids = get_list_ids('all-x-select');
				//发异步删除数据
				ajax_post({{urlfor "admin.SearchController.DeleteBatch"}}, {ids: ids});
		    });
		}
	   
		/*-删除*/
		function log_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.SearchController.Delete"}}, {id: id});
			});
		}
		</script>
</body>
