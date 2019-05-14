<body>
	<div class="x-body">
		<form class="layui-form">
			{{if .IsUpdate}}
			<div class="layui-form-item">
				<label for="role_id" class="layui-form-label">
					ID
				</label>
				<div class="layui-input-inline">
					<input type="text" id="role_id" name="role_id" required="" lay-verify="required" autocomplete="off" value="{{.role.Id}}" disabled="" class="layui-input">
				</div>
			</div>
			{{end}}
			<div class="layui-form-item">
				<label class="layui-form-label">所属分类</label>
				<div class="layui-input-inline" >
					<select name="pid">
						<option value="0">顶级分类</option>
						{{str2html .options}}
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="name" class="layui-form-label">
					<span class="x-red">*</span>权限名称
				</label>
				<div class="layui-input-inline">
					<input type="text" id="name" name="name" value="{{.role.Name}}" required="" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="module" class="layui-form-label">
					模块
				</label>
				<div class="layui-input-inline">
					<input type="text" id="module" name="module" autocomplete="off" class="layui-input" value="{{.role.Module}}">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="action" class="layui-form-label">
					方法
				</label>
				<div class="layui-input-inline">
					<input type="text" id="action" name="action" autocomplete="off" class="layui-input" value="{{.role.Action}}">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="icon" class="layui-form-label">
					icon
				</label>
				<div class="layui-input-inline">
					<input type="text" id="icon" name="icon" autocomplete="off" class="layui-input" value="{{.role.Icon}}">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="is_menu" class="layui-form-label">
					是否菜单
				</label>
				<div class="layui-input-block">
				  <input type="checkbox" {{if .role.IsMenu}}checked="1"{{end}} name="is_menu" lay-skin="switch" lay-filter="switchTest" title="菜单" value="1" lay-text="是|否">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="is_default" class="layui-form-label">
					默认权限
				</label>
				<div class="layui-input-block">
				  <input type="checkbox" {{if .role.IsDefault}}checked="1"{{end}} name="is_default" lay-skin="switch" lay-filter="switchTest" title="权限" value="1" lay-text="是|否">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="sort" class="layui-form-label">
					菜单排序
				</label>
				<div class="layui-input-inline">
					<input type="text" id="sort" name="sort" autocomplete="off" class="layui-input" value="{{.role.Sort}}">
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label for="desc" class="layui-form-label">
					描述
				</label>
				<div class="layui-input-block">
					<textarea placeholder="随便写些什么" id="desc" name="desc" autocomplete="off" class="layui-textarea" style="height: 80px;">{{.role.Desc}}</textarea>
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
