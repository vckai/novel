<body>
	<div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="name" class="layui-form-label">
					<span class="x-red">*</span>规则内容
				</label>
				<div class="layui-input-block">
                    <textarea  lay-verify="required" rows="25" name="rule_content" placeholder="JSON字符串内容" class="layui-textarea"></textarea>
				</div>
			</div>
	
			<div class="layui-form-item">
                <div class="layui-input-block">
                    <button  class="layui-btn" lay-filter="save" lay-submit="">
                        导入
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
					ajax_post({{urlfor "admin.SnatchRuleController.Import"}}, data.field, top.reload_page, true, false, true);
					return false;
				});
			});
		}
	</script>
</body>
