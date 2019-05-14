<body>
	 <div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="account" class="layui-form-label">
					登录名
				</label>
				<div class="layui-input-inline">
					<input type="text" value="{{.admin.Account}}" required="" lay-verify="required" autocomplete="off" class="layui-input" disabled>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_pass" class="layui-form-label">
					<span class="x-red">*</span>新密码
				</label>
				<div class="layui-input-inline">
					<input type="password" id="L_pass" name="pass" required="" lay-verify="pass" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					6到20个字符
				</div>
			</div>
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label">
					<span class="x-red">*</span>确认密码
				</label>
				<div class="layui-input-inline">
					<input type="password" id="L_repass" name="repass" required="" lay-verify="repass"
					autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"></label>
				<input type="hidden" name="id" value="{{.admin.Id}}" />
				<button  class="layui-btn" lay-filter="save" lay-submit="">
					保存
				</button>
			</div>
		</form>
	</div>

	<script src="{{.aOut.ViewUrl}}js/md5.min.js"></script>
	<script>
		window.onload = function() {
			layui.use(['form', 'layer'], function() {
				$ = layui.jquery;

				var form = layui.form
					,layer = layui.layer;

				//自定义验证规则
				form.verify({
					pass: [/(.+){6,20}$/, "密码必须6到20位"]
					,repass: function(value){
						if ($("#L_pass").val() != $("#L_repass").val()) {
							return "两次密码不一致";
						}
					}
				});

				// 监听提交
				form.on("submit(save)", function(data) {
					data.field.pass = md5(data.field.pass);
					delete data.field.repass;
					ajax_post({{urlfor "admin.AdminController.EditPass"}}, data.field, top.reload_page, true, true, true);
					return false;
				});
			});
		}
	</script>
</body>
