<body class="x-iframe-body">
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		  <a><cite>搜索管理</cite></a>
		  <a><cite>搜索日志</cite></a>
		</span>
	</div>
	<div class="x-body">
        <div class="layui-card">
            <form class="layui-form x-center x-search-form" style="width:80%">
                <div class="layui-form-pane" style="margin-top: 15px;">
                  <div class="layui-form-item">
                     <label class="layui-form-label">日期范围</label>
                     <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="date-range" value="{{.Search.st}} - {{.Search.et}}">
                        <input type="hidden" class="layui-input" name="st" value="{{.Search.st}}">
                        <input type="hidden" class="layui-input" name="et" value="{{.Search.et}}">
                     </div>
                    <div class="layui-input-inline">
                      <input type="text" name="kw" placeholder="请输入关键字" autocomplete="off" class="layui-input" value="{{.Search.kw}}">
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
            <table class="layui-table layui-form">
                <thead>
                    <tr>
                        <th style="width: 30px"><input type="checkbox" lay-skin="primary" lay-filter="all-select"></th>
                        <th>ID</th>
                        <th>关键字</th>
                        <th>搜索用户</th>
                        <th>来源</th>
                        <th>是否有结果</th>
                        <th>客户端IP</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    {{range .List}}
                    <tr>
                        <td><input type="checkbox" value="{{.Id}}" lay-skin="primary" class="all-x-select"></td>
                        <td>{{.Id}}</td>
                        <td>{{.Kw}}</td>
                        <td>{{or .Uid "游客"}}</td>
                        <td>{{str2html .SourceName}}</td>
                        <td>{{str2html .IsResultName}}</td>
                        <td>{{.Ip}}</td>
                        <td>{{datetime .CreatedAt "2006-01-02 15:04"}}</td>
                        <td class="td-manage">
                            <a class="layui-btn layui-btn-xs layui-btn-danger" href="javascript:;" onclick="log_del(this, '{{.Id}}', '{{.Kw}}')">
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
			layui.use(['element', 'layer', 'laydate', 'laypage'], function() {
				var $ = layui.jquery;        // jquery
				var laydate = layui.laydate; // 日期插件
				var lement  = layui.element; // 面包导航
				var layer   = layui.layer;   // 弹出层
				var laypage = layui.laypage; // 分页

				// 分页
				laypage.render({
					elem: 'page',
					count: {{.Count}},
					limit: {{.Search.limit}},
					curr:  {{.Search.page}},
					prev: '<em><</em>',
					next: '<em>></em>',
					skip: false,
					jump: function (obj, first) {
						if (first != true) {
							top.load_page({{urlfor "admin.SearchLogController.Index"}} + "?p=" + obj.curr + "&st={{.Search.st}}" + "&et={{.Search.et}}" + "&kw={{.Search.kw}}");
						}
					}
				}); 

                laydate.render({
                    elem: '#date-range' 
                    ,range: true
                    ,done: function(value, date, endDate) {
                        var dates = value.split(" - "); //得到日期生成的值，如：2017-08-18
                        $("input[name='st']") .val(dates[0]);
                        $("input[name='et']") .val(dates[1]);
                    }
                });
			});

            // 搜索
            $("#btn-search").click(function () {
                var query = $('.x-search-form').serialize();
                top.load_page({{urlfor "admin.SearchLogController.Index"}} + '?' + query);
            });
		}
		  
		// 批量删除提交
		function del_all() {
			top.layer.confirm('确认要删除吗？', function(index) {
                var ids = get_list_ids('all-x-select');
				//发异步删除数据
				ajax_post({{urlfor "admin.SearchLogController.DeleteBatch"}}, {ids: ids}, top.reload_page);
		    });
		}
	   
		/*-删除*/
		function log_del(obj, id, kw) {
			top.layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();

				//发异步删除数据
				ajax_post({{urlfor "admin.SearchLogController.Delete"}}, {id: id, kw: kw}, top.reload_page);
			});
		}
		</script>
</body>
