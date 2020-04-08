<body>
	<div class="x-body">
        <table class="layui-table layui-form" lay-filter="ruleTable">
            <thead>
                <tr>
                    <th lay-data="{field:'name', width:'12%'}">对比内容</th>
                    <th lay-data="{field:'rule', width:'17%'}">规则</th>
                    <th lay-data="{field:'data', width:'28%'}">对比数据</th>
                    <th lay-data="{field:'get_data', width:'29%'}">采集结果</th>
                    <th lay-data="{field:'use_time', width:'9%'}">请求耗时</th>
                    <th lay-data="{field:'ret', width:'5%'}">结果</th>
                </tr>
            </thead>
            <tbody>
                {{range .Results}}
                <tr data-ret="{{.Ret}}" {{if eq .Ret false}} class="layui-bg-red"{{end}}>
                    <td>{{.Name}}</td>
                    <td>{{.Rule}}</td>
                    <td>{{.Data}}</td>
                    <td>{{str2html .GetData}}</td>
                    <td>{{.UseTime}}</td>
                    <td><b style="{{if eq .Ret false}}color: red{{end}}">{{.Ret}}</b></td>
                </tr>
                {{end}}
            </tbody>
        </table>
	</div>
	<script>
		window.onload = function() {
			layui.use(['layer', 'table'], function() {
				var $ = layui.jquery; //jquery
				var layer = layui.layer; //弹出层
				var table = layui.table;// 表格

                //转换静态表格
                table.init('ruleTable', {
                    height: 600 //设置高度
                    ,limit: 50 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
                    ,done: function(res, curr, count) {
                        
                    }
                });
			});
        }

        function setColor(tableClassName) {
            var $table = $(tableClassName).eq(1);
            if ($table.length > 0) {
                //遍历所有行
                $table.find('tr').each(function() {
                    var open = $(this).find('td[data-field="open"]').attr('data-content');
                    if(open == "2"){   //给状态为2的数据行设置背景色
                        $(this).attr('style',"background:#f1dddd;color:#000");
                    }
                })
            }
    }
    </script>
</body>
