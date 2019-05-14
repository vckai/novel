<body>
	<div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="name" class="layui-form-label"><span class="x-red">*</span>名称</label>
				<div class="layui-input-block">
					<input type="text" id="name" name="name" lay-verify="required" autocomplete="off" class="layui-input" value="{{.Banner.Name}}">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="cate_id" class="layui-form-label">
					<span class="x-red">*</span>显示区域
				</label>
				<div class="layui-input-inline">
				  <select name="zone" lay-verify="required|number">
					<option value="0">请选择区域</option>
					{{range $k, $v:= .Zones}}
					<option value="{{$k}}" {{if eq $k $.Banner.Zone}}selected{{end}}>{{$v}}</option>
					{{end}}
				  </select>
				</div>
			</div>
			<div class="layui-form-item">
				<label  class="layui-form-label"><span class="x-red">*</span>缩略图</label>
				<div class="layui-input-inline">
					<img id="LAY_upload" width="150" src="{{.Banner.Img}}">
					<input type="hidden" id="upload_cover" name="img" value="{{.Banner.Img}}">
				</div>

				<div class="layui-input-inline">
				  <div class="site-demo-upbar">
                    <button type="button" class="layui-btn layui-btn-primary" id="upimg">
                        <i class="layui-icon">&#xe67c;</i>上传图片
                    </button>
				  </div>
				</div>
			</div>
			<div class="layui-form-item">
				<label for="link" class="layui-form-label"><span class="x-red">*</span>链接地址</label>
				<div class="layui-input-block">
					<input type="text" id="link" name="link" lay-verify="url" autocomplete="off" class="layui-input" value="{{.Banner.Link}}">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="ext" class="layui-form-label">扩展属性</label>
				<div class="layui-input-block">
					<input type="text" id="ext" name="ext" autocomplete="off" class="layui-input" value="{{.Banner.Ext}}">
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label for="desc" class="layui-form-label">
					描述
				</label>
				<div class="layui-input-block">
					<textarea placeholder="随便写些什么" id="desc" name="desc" autocomplete="off" class="layui-textarea" style="height: 80px;">{{.Banner.Desc}}</textarea>
				</div>
			</div>
	
			<div class="layui-form-item">
				<input type="hidden" id="id" name="id" value="{{.Banner.Id}}">
				<button  class="layui-btn" lay-filter="save" lay-submit="">
					保存
				</button>
			</div>
		</form>
	</div>
	<script>
		window.onload = function() {
			layui.use(['form', 'layer', 'upload'], function() {
				$ = layui.jquery;

				var form = layui.form
					,layer = layui.layer;
  
				//图片上传接口
				layui.upload.render({
                    elem: '#upimg',
                    field: 'upimg',
					url: {{urlfor "admin.HomeController.UpImg"}},
					done: function(res) { //上传成功后的回调
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
					ajax_post("{{.PostUrl}}", data.field, top.reload_page, true, true, true);
					return false;
				});
			});
		}
	</script>
</body>
