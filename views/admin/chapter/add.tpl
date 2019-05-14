<body>
	<div class="x-body">
		<form class="layui-form layui-form-pane">
			<div class="layui-form-item">
				<label for="_chapter_no" class="layui-form-label">
					章节编号
				</label>
				<div class="layui-input-block">
					<input type="text" id="_chapter_no" name="chapter_no" required autocomplete="off" class="layui-input" value="{{.Chapter.ChapterNo}}">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="_title" class="layui-form-label">
					章节标题
				</label>
				<div class="layui-input-block">
					<input type="text" id="_title" name="title" required lay-verify="title" autocomplete="off" class="layui-input" value="{{.Chapter.Title}}">
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<div class="layui-input-block">
					<textarea id="L_content" name="desc" placeholder="请输入章节内容" class="layui-textarea fly-editor" style="height: 260px;">{{.Chapter.Desc}}</textarea>
				</div>
				<label for="L_content" class="layui-form-label" style="top: -2px;">
					章节内容
				</label>
			</div>	
			<div class="layui-form-item">
				<input type="hidden" id="chapter_id" name="chapter_id" value="{{.Chapter.Id}}">
				<input type="hidden" id="novid" name="novid" value="{{.NovId}}">
				<button  class="layui-btn" lay-filter="save" lay-submit="">
					保存
				</button>
			</div>
		</form>
	</div>
	<script>
		window.onload = function() {
			layui.use(['form', 'layer', 'layedit'], function() {
				$ = layui.jquery;

				var form = layui.form
					,layer = layui.layer;
  
				//创建一个编辑器
				editIndex = layui.layedit.build('L_content');

				// 监听提交
				form.on('submit(save)', function(data) {
                    data.field.desc = layui.layedit.getContent(editIndex)
					ajax_post("{{.PostUrl}}", data.field, "", true, false, true);
					return false;
				});
			});
		}
	</script>
</body>
