<body class="x-iframe-body">
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>系统管理</cite></a>
		  <a><cite>用户反馈</cite></a>
		</span>
	</div>
	<div class="x-body">
        <div class="layui-card">
            <xblock>
                <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon">&#xe640;</i>批量删除</button>
                <span class="x-right" style="line-height:40px">共有数据：{{.Count}} 条</span>
            </xblock>
            <table class="layui-table layui-form">
                <thead>
                    <tr>
                        <th style="width: 30px"><input type="checkbox" lay-skin="primary" lay-filter="all-select"></th>
                        <th>ID</th>
                        <th>内容</th>
                        <th>联系方式</th>
                        <th>客户端IP</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    {{range .List}}
                    <tr>
                        <td><input type="checkbox" lay-skin="primary" value="{{.Id}}" name="" class="all-x-select"></td>
                        <td>{{.Id}}</td>
                        <td>{{.Content}}</td>
                        <td>{{.Contact}}</td>
                        <td>{{.Ip}}</td>
                        <td>{{datetime .CreatedAt "2006-01-02 15:04"}}</td>
                        <td class="td-manage">
                            <a class="layui-btn layui-btn-xs layui-btn-danger" href="javascript:;" onclick="log_del(this, '{{.Id}}')">
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
		window.onload = function () {
			layui.use(['element', 'layer', 'laypage', 'form'], function() {
				var $ = layui.jquery;//jquery
				var lement = layui.element;//面包导航
				var layer = layui.layer;//弹出层
				var laypage = layui.laypage;//分页

				// 分页
				laypage.render({
					elem: 'page',
					count: {{.Count}},
					limit: {{.Limit}},
					curr:  {{.Search.p}},
					prev: '<em><</em>',
					next: '<em>></em>',
					skip: false,
					jump: function (obj, first) {
						if (first != true) {
							top.load_page({{urlfor "admin.FeedbackController.Index"}} + "?p=" + obj.curr);
						}
					}
				}); 
			});
		}
		  
		//批量删除提交
		 function delAll () {
			top.layer.confirm('确认要删除吗？', function(index) {
                var ids = get_list_ids('all-x-select');
				// 发异步删除数据
				ajax_post({{urlfor "admin.FeedbackController.DeleteBatch"}}, {ids: ids}, top.reload_page);
			});
		 }
	   
		/*-删除*/
		function log_del(obj, id) {
			top.layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.FeedbackController.Delete"}}, {id: id}, top.reload_page);
			});
		}
		</script>
</body>
