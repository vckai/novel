<body class="login-bg">

    <div class="login">
        <div class="message">{{.aOut.Title}}-后台管理</div>
        <div id="darkbannerwrap"></div>

        <form method="post" class="layui-form" >
            <input name="username" id="username" placeholder="用户名" type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="pass" id="pass" lay-verify="pass" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
        </form>
    </div>

	<script src="{{.aOut.ViewUrl}}js/md5.min.js"></script>
    <script>
		window.onload = function() {
			layui.use(['form'], function() {
				$ = layui.jquery;
				var form = layui.form,
				layer = layui.layer;
				// 自定义验证规则
				form.verify({
					pass: [/(.+){6,20}$/, "密码必须6到20位"]
				});

				$('.x-login-right li').click(function(event) {
					color = $(this).attr('color');
					$('body').css('background-color', color);
				});

				// 登录请求
				form.on('submit(login)', function(data) {
					data.field.pass = md5(data.field.pass);

					ajax_post({{urlfor "admin.LoginController.Index"}}, data.field, "", false);

					return false;
				});
			});
		}
    </script>
</body>
