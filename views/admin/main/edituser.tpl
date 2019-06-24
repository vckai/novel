<body>
	 <div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="account" class="layui-form-label">
					<span class="x-red">*</span>登录名
				</label>
				<div class="layui-input-inline">
					<input type="text" value="{{.admin.Account}}" autocomplete="off" class="layui-input" disabled>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="nickname" class="layui-form-label">
					<span class="x-red">*</span>昵称
				</label>
				<div class="layui-input-inline">
					<input type="text" id="nickname" name="nickname" value="{{.admin.Name}}" lay-verify="nick" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="phone" class="layui-form-label">
					手机
				</label>
				<div class="layui-input-inline">
					<input type="text" id="mobile" name="mobile" value="{{itoa .admin.Mobile}}" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_email" class="layui-form-label">
					邮箱
				</label>
				<div class="layui-input-inline">
					<input type="text" id="mail" name="mail" value="{{.admin.Mail}}" autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"></label>
				<button  class="layui-btn" lay-filter="save" lay-submit="">
					保存
				</button>
			</div>
		</form>
	</div>

	<script>
		window.onload = function() {
			layui.use(['form', 'layer'], function() {
				$ = layui.jquery;

				var form = layui.form
					,layer = layui.layer;

				//自定义验证规则
				form.verify({
					nick: function(value) {
						if (value.length < 2) {
							return "昵称至少得2个字符啊";
						}
					}
				});

				// 监听提交
				form.on("submit(save)", function(data) {
					ajax_post("{{.PostUrl}}", data.field, top.reload_page, true, true, true);
					return false;
				});
			});
		}
	</script>
</body>
