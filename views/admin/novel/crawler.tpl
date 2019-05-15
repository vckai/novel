<body>
	<div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="source" class="layui-form-label">
					<span class="x-red">*</span>爬虫站点
				</label>
				<div class="layui-input-inline">
				  <select name="source" lay-verify="required">
					<option value="0">请选择站点</option>
					{{range $k, $v:= .Snatchs}}
					<option value="{{$v.Code}}">{{$v.Name}}</option>
					{{end}}
				  </select>
				</div>
			</div>
	
			<div class="layui-form-item">
                <div class="layui-input-block">
                    <button  class="layui-btn" lay-filter="save" lay-submit="">
                        运行
                    </button>
                </div>
			</div>
		</form>
	</div>
	<script>
		window.onload = function() {
			layui.use(['form', 'layer'], function() {
				$ = layui.jquery;

				var form = layui.form
					,layer = layui.layer;

				// 监听提交
				form.on('submit(save)', function(data) {
					ajax_post({{urlfor "admin.NovelController.Crawler"}}, data.field, top.reload_page, true, true, true);
					return false;
				});
			});
		}
	</script>
</body>
