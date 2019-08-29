<body>
	<div class="x-body">
		<form class="layui-form">
			{{if compare .IsAdd false}}
			<div class="layui-form-item">
				<label for="role_id" class="layui-form-label">
					ID
				</label>
				<div class="layui-input-inline">
					<input type="text" id="cate_id" name="cate_id" required="" lay-verify="required" autocomplete="off" value="{{.Cate.Id}}" disabled="" class="layui-input">
				</div>
			</div>
			{{end}}
			<div class="layui-form-item">
				<label for="name" class="layui-form-label">
					<span class="x-red">*</span>分类名称
				</label>
				<div class="layui-input-inline">
					<input type="text" id="name" name="name" value="{{.Cate.Name}}" required="" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="is_menu" class="layui-form-label">
					首页菜单
				</label>
				<div class="layui-input-block">
				  <input type="checkbox" {{if .Cate.IsMenu}}checked="1"{{end}} name="is_menu" lay-skin="switch" lay-filter="switchTest" title="菜单" value="1" lay-text="是|否">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="is_home" class="layui-form-label">
					首页模块
				</label>
				<div class="layui-input-block">
				  <input type="checkbox" {{if .Cate.IsHome}}checked="1"{{end}} name="is_home" lay-skin="switch" lay-filter="switchTest" title="首页" value="1" lay-text="是|否">
				</div>
			</div>
	
			<div class="layui-form-item">
				<label for="L_repass" class="layui-form-label">
				</label>
				<button  class="layui-btn" lay-filter="save" lay-submit="">
					保存
				</button>
			</div>
		</form>
	</div>
	<script>
		window.onload = function() {
			layui.use(['form','layer'], function() {
				$ = layui.jquery;

				var form = layui.form
					,layer = layui.layer;

				// 监听提交
				form.on('submit(save)', function(data) {
					ajax_post("{{.PostUrl}}", data.field, top.reload_page, true, true, true);
					return false;
				});
			});
		}
	</script>
</body>
