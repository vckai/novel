<body>
	 <div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="account" class="layui-form-label">
					<span class="x-red">*</span>登录名
				</label>
				<div class="layui-input-inline">
					<input type="text" id="account" name="account" value="{{.admin.Account}}" required="" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">
					<span class="x-red">*</span>将会成为您唯一的登入名
				</div>
			</div>
			<div class="layui-form-item">
				<label for="role" class="layui-form-label">
					<span class="x-red">*</span>群组
				</label>
				<div class="layui-input-inline">
				  <select name="group_id" lay-verify="group">
					<option value="0">请选择群组</option>
					{{range $k, $v := .groups}}
					<option value="{{$v.Id}}" {{if eq $v.Id $.admin.GroupId}}selected{{end}}>{{$v.Name}}</option>
					{{end}}
				  </select>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="nickname" class="layui-form-label">
					<span class="x-red">*</span>昵称
				</label>
				<div class="layui-input-inline">
					<input type="text" id="nickname" name="nickname" value="{{.admin.Name}}" required="" lay-verify="nick" autocomplete="off" class="layui-input">
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
			{{if .IsAdd}}
			<div class="layui-form-item">
				<label for="L_pass" class="layui-form-label">
					<span class="x-red">*</span>密码
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
			{{end}}
			<div class="layui-form-item">
				<label for="status" class="layui-form-label">
					状态
				</label>
				<div class="layui-input-block">
				  <input type="checkbox" {{if compare .admin.Status 0}}checked="1"{{end}} name="status" lay-skin="switch" lay-filter="switchTest" title="状态" value="1" lay-text="启用|禁用">
				</div>
			</div>

			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label"></label>
				<input type="hidden" name="admin_id" value="{{.admin.Id}}" />
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
					nick: function(value) {
						if (value.length < 2) {
							return "昵称至少得2个字符啊";
						}
					}
					,group: function(value) {
						if (value == "0") {
							return "请选择权限群组";
						}
					}
					,pass: [/(.+){6,20}$/, "密码必须6到20位"]
					,repass: function(value){
						if ($("#L_pass").val() != $("#L_repass").val()) {
							return "两次密码不一致";
						}
					}
				});

				// 监听提交
				form.on("submit(save)", function(data) {
				{{if .IsAdd}}
					data.field.pass = md5(data.field.pass);
					delete data.field.repass;
				{{end}}
					ajax_post("{{.PostUrl}}", data.field, top.reload_page, true, true, true);
					return false;
				});
			});
		}
	</script>
</body>
