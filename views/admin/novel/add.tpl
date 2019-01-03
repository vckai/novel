<body>
	<div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="cate_id" class="layui-form-label">
					<span class="x-red">*</span>分类
				</label>
				<div class="layui-input-inline">
				  <select name="cate_id" lay-verify="cate_id">
					<option value="0">请选择分类</option>
					{{range $k, $v := .Cates}}
					<option value="{{$v.Id}}" {{if eq $v.Id $.Novel.CateId}}selected{{end}}>{{$v.Name}}</option>
					{{end}}
				  </select>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="name" class="layui-form-label">
					<span class="x-red">*</span>小说名称
				</label>
				<div class="layui-input-block">
					<input type="text" id="name" name="name" value="{{.Novel.Name}}" required="" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="author" class="layui-form-label">
					<span class="x-red">*</span>作者
				</label>
				<div class="layui-input-inline">
					<input type="text" id="author" name="author" value="{{.Novel.Author}}" required="" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label  class="layui-form-label">缩略图</label>
				<div class="layui-input-inline">
					<img id="LAY_upload" width="150" src="{{.Novel.Cover}}">
					<input type="hidden" id="upload_cover" name="cover" value="{{.Novel.Cover}}">
				</div>

				<div class="layui-input-inline">
				  <div class="site-demo-upbar">
					<input type="file" name="upimg" class="layui-upload-file" id="upimg">
				  </div>
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label for="desc" class="layui-form-label">
					描述
				</label>
				<div class="layui-input-block">
					<textarea id="L_content" name="desc" placeholder="小说简介" class="layui-textarea fly-editor" style="height: 80px;">{{.Novel.Desc}}</textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="cate_id" class="layui-form-label">
					<span class="x-red">*</span>状态
				</label>
				<div class="layui-input-inline">
				  <select name="status" lay-verify="status">
					{{range $k, $v := .Novel.StatusList}}
					<option value="{{$k}}" {{if eq $k $.Novel.Status}}selected{{end}}>{{$v}}</option>
					{{end}}
				  </select>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="is_hot" class="layui-form-label">
					是否热门
				</label>
				<div class="layui-input-inline">
				  <input type="checkbox" {{if .Novel.IsHot}}checked="1"{{end}} name="is_hot" lay-skin="switch" lay-filter="switchTest" title="热门" value="1">
				</div>
				<label for="is_menu" class="layui-form-label">
					是否推荐
				</label>
				<div class="layui-input-inline">
				  <input type="checkbox" {{if .Novel.IsRec}}checked="1"{{end}} name="is_rec" lay-skin="switch" lay-filter="switchTest" title="推荐" value="1">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="is_menu" class="layui-form-label">
					是否精品
				</label>
				<div class="layui-input-inline">
				  <input type="checkbox" {{if .Novel.IsVipRec}}checked="1"{{end}} name="is_vip_rec" lay-skin="switch" lay-filter="switchTest" title="精品" value="1">
				</div>
				<label for="is_menu" class="layui-form-label">
					今日推荐
				</label>
				<div class="layui-input-inline">
				  <input type="checkbox" {{if .Novel.IsTodayRec}}checked="1"{{end}} name="is_today_rec" lay-skin="switch" lay-filter="switchTest" title="今日推荐" value="1">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="is_menu" class="layui-form-label">
					男生喜欢
				</label>
				<div class="layui-input-inline">
				  <input type="checkbox" {{if .Novel.IsManLike}}checked="1"{{end}} name="is_man_like" lay-skin="switch" lay-filter="switchTest" title="男生喜欢" value="1">
				</div>
				<label for="is_menu" class="layui-form-label">
					女生喜欢
				</label>
				<div class="layui-input-inline">
				  <input type="checkbox" {{if .Novel.IsGirlLike}}checked="1"{{end}} name="is_girl_like" lay-skin="switch" lay-filter="switchTest" title="女生喜欢" value="1">
				</div>
			</div>
	
			<div class="layui-form-item">
				<input type="hidden" id="novel_id" name="novel_id" value="{{.Novel.Id}}">
				<button  class="layui-btn" lay-filter="save" lay-submit="">
					保存
				</button>
			</div>
		</form>
	</div>
	<script>
		window.onload = function() {
			layui.use(['form', 'layer', 'upload', 'layedit'], function() {
				$ = layui.jquery;

				var form = layui.form()
					,layer = layui.layer;
  
				//创建一个编辑器
				editIndex = layui.layedit.build('L_content');

				//图片上传接口
				layui.upload({
					url: {{urlfor "admin.HomeController.UpImg"}},
					success: function(res) { //上传成功后的回调
						if (res.ret == 0) {
							$('#LAY_upload').attr('src', res.data.url);
							$('#upload_cover').val(res.data.url);
						} else {
							layer.msg(res.msg, {icon: 3});
						}
					}
				});

				// 监听提交
				form.on('submit(save)', function(data) {
					ajax_post("{{.PostUrl}}", data.field);
					return false;
				});
			});
		}
	</script>
</body>
