<body>
	<div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="name" class="layui-form-label">
					<span class="x-red">*</span>小说URL
				</label>
				<div class="layui-input-block">
					<input type="text" id="url" name="url" value="" lay-verify="required|url" autocomplete="off" class="layui-input">
				</div>
			</div>
	
			<div class="layui-form-item">
                <div class="layui-input-block">
                    <button  class="layui-btn" lay-filter="save" lay-submit="">
                        采集
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
					ajax_post({{urlfor "admin.NovelController.AddSnatch"}}, data.field, top.reload_page, true, true, true);
					return false;
				});
			});
		}
	</script>
</body>
