<body>
	<div class="x-body">
		<form class="layui-form">
			<div class="layui-form-item">
				<label for="source" class="layui-form-label">
					<span class="x-red">*</span>页面URL
				</label>
				<div class="layui-input-block">
					<input type="text" id="url" name="url" value="" lay-verify="required|url" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="source" class="layui-form-label">
					<span class="x-red">*</span>CSS选择器
				</label>
				<div class="layui-input-block">
					<input type="text" id="selector" name="selector" value="" lay-verify="required" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="source" class="layui-form-label">
					CSS选择器属性
				</label>
				<div class="layui-input-block">
					<input type="text" id="attr" name="attr" value="" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label for="source" class="layui-form-label">
					<span class="x-red">*</span>选择编码
				</label>
            
				<div class="layui-input-inline">
                  <select name="charset" lay-verify="charset">
                    <option value="UTF-8">UTF-8</option>
                    <option value="GB18030">GBK/GB2312</option>
                  </select>
				</div>
            </div>
	
			<div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-filter="save" lay-submit="">
                        获取选取结果
                    </button>
                </div>
			</div>
		</form>
        <div class="result" style="display: none;">
            <pre class="layui-code"></pre>
        </div>
	</div>
	<script>
		window.onload = function() {
			layui.use(['form', 'layer'], function() {
				$ = layui.jquery;

				var form = layui.form
					,layer = layui.layer;

				// 监听提交
				form.on('submit(save)', function(data) {
                    $(".result").hide();
                    $(".result pre").html("");
					ajax_post({{urlfor "admin.SnatchRuleController.Goquery"}}, data.field, function (res) {
                        $(".result").show();
                        $(".result pre").html(res.data);
                    }, true, true, false);
					return false;
				});
			});
		}
	</script>
</body>
