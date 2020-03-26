<body>

<style>
.layui-form-item .cate-icon{width: 30px;margin-top: 3px;}
.layui-tab-content {min-height: 500px;}
.cate_map .layui-form-item .layui-input-inline .layui-btn {margin-top:3px;}
.layui-form-label {width: 160px;}
.layui-input-block {margin-left: 190px}
</style>

<form class="layui-form" action="">
    <div class="x-body">
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
          <ul class="layui-tab-title">
            <li class="layui-this">基本配置</li>
            <li>采集规则</li>
            <li>分类映射</li>
            <li>测试数据</li>
          </ul>

          <div class="layui-tab-content" >
            <div class="layui-tab-item layui-show">
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        <span class='x-red'>*</span>网站名称
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="name" autocomplete="off" placeholder="最好控制在20个字、50个字节以内"
                        class="layui-input" lay-verify="required" value="{{.Rule.Name}}" />
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        <span class='x-red'>*</span>标识码
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="code" autocomplete="off" placeholder="控制在20个字节以内"
                        class="layui-input" value="{{.Rule.Code}}" lay-verify="required" />
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        <span class='x-red'>*</span>网址URL
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="url" lay-verify="required|url" autocomplete="off" class="layui-input" placeholder="网站URL" value="{{.Rule.Url}}" />
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="role" class="layui-form-label">
                        <span class="x-red">*</span>网站编码
                    </label>
                    <div class="layui-input-inline">
                      <select name="charset" lay-verify="charset">
                        <option value="0">请选择编码</option>
                        <option value="UTF-8" {{if eq "UTF-8" .Rule.Charset}}selected{{end}}>UTF-8</option>
                        <option value="GB18030" {{if eq "GB18030" .Rule.Charset}}selected{{end}}>GBK/GB2312</option>
                      </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="is_original" class="layui-form-label">
                        是否用于强制更新图片
                    </label>
                    <div class="layui-input-inline">
                      <input type="checkbox" {{if .Rule.IsUpdate}}checked="1"{{end}} name="is_update" lay-skin="switch" lay-filter="switchTest" title="强制更新" value="1" lay-text="是|否">
                    </div>
                </div>
                <div style="height:100px;"></div>
            </div>
            <div class="layui-tab-item">
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        <span class='x-red'>*</span>小说简介页URL规则
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="支持正则表达式" lay-verify="required" type="text" name="rule.IsBookURL" autocomplete="off" class="layui-input" value="{{.Rule.Rules.IsBookURL}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        允许爬虫页面URL规则
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="支持正则表达式" type="text" name="rule.IsCrawlerURL" autocomplete="off" class="layui-input" value="{{.Rule.Rules.IsCrawlerURL}}">
                    </div>
                </div>
                <hr />
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>名称CSS选择器
                        </label>
                        <div class="layui-input-block">
                            <input lay-verify="required" type="text" name="rule.BookTitleSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookTitleSelector}}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            名称选择属性
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookTitleAttr" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookTitleAttr}}">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        名称过滤规则
                    </label>
                    <div class="layui-input-block">
                        <textarea name="rule.BookTitleFilter" placeholder="多个规则回车分行，支持正则表达式" class="layui-textarea">{{.Rule.Rules.BookTitleFilter}}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            <span class='x-red'>*</span>作者CSS选择器
                        </label>
                        <div class="layui-input-block">
                            <input lay-verify="required" type="text" name="rule.BookAuthorSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookAuthorSelector}}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            作者选择属性
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookAuthorAttr" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookAuthorAttr}}">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        作者过滤规则
                    </label>
                    <div class="layui-input-block">
                        <textarea name="rule.BookAuthorFilter" placeholder="多个规则回车分行，支持正则表达式" class="layui-textarea">{{.Rule.Rules.BookAuthorFilter}}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            分类CSS选择器
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookCateSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookCateSelector}}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            分类选择属性
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookCateAttr" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookCateAttr}}">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        分类过滤规则
                    </label>
                    <div class="layui-input-block">
                        <textarea name="rule.BookCateFilter" placeholder="多个规则回车分行，支持正则表达式" class="layui-textarea">{{.Rule.Rules.BookCateFilter}}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            简介CSS选择器
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookDescSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookDescSelector}}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            简介选择属性
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookDescAttr" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookDescAttr}}">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        简介过滤规则
                    </label>
                    <div class="layui-input-block">
                        <textarea name="rule.BookDescFilter" placeholder="多个规则回车分行，支持正则表达式" class="layui-textarea">{{.Rule.Rules.BookDescFilter}}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            缩略图CSS选择器
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookCoverSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookCoverSelector}}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            缩略图选择属性
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookCoverAttr" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookCoverAttr}}">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        无缩略图标志
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="rule.BookNoCover" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookNoCover}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            章节目录页链接CSS选择器
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookChapterURLSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookChapterURLSelector}}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            章节目录页链接选择属性
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookChapterURLAttr" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookChapterURLAttr}}">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            最新章节标题CSS选择器
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookLastChapterTitleSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookLastChapterTitleSelector}}">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">
                            最新章节选择属性
                        </label>
                        <div class="layui-input-block">
                            <input type="text" name="rule.BookLastChapterTitleAttr" autocomplete="off" class="layui-input" value="{{.Rule.Rules.BookLastChapterTitleAttr}}">
                        </div>
                    </div>
                </div>
                <hr />
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        <span class='x-red'>*</span>章节CSS选择器
                    </label>
                    <div class="layui-input-block">
                        <input lay-verify="required" type="text" name="rule.ChapterCatalogSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.ChapterCatalogSelector}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        下一章节目录页CSS选择器
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="rule.ChapterNextPageSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.ChapterNextPageSelector}}" placeholder="不建议采集章节列表有分页的站点，效率太低">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        丢弃章节数
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="rule.ChapterAbandonNum" autocomplete="off" class="layui-input" value="{{.Rule.Rules.ChapterAbandonNum}}">
                    </div>
                </div>
                <hr />
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        <span class='x-red'>*</span>章节标题CSS选择器
                    </label>
                    <div class="layui-input-block">
                        <input lay-verfiy="required" type="text" name="rule.InfoTitleSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.InfoTitleSelector}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        章节标题过滤规则
                    </label>
                    <div class="layui-input-block">
                        <textarea name="rule.InfoTitleFilter" placeholder="多个规则回车分行，支持正则表达式" class="layui-textarea">{{.Rule.Rules.InfoTitleFilter}}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        <span class='x-red'>*</span>章节内容CSS选择器
                    </label>
                    <div class="layui-input-block">
                        <input lay-verify="required" type="text" name="rule.InfoDescSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.InfoDescSelector}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        章节内容过滤规则
                    </label>
                    <div class="layui-input-block">
                        <textarea name="rule.InfoDescFilter" placeholder="多个规则回车分行，支持正则表达式" class="layui-textarea">{{.Rule.Rules.InfoDescFilter}}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        上一页CSS选择器
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="rule.InfoPrePageSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.InfoPrePageSelector}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        下一页CSS选择器
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="rule.InfoNextPageSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.InfoNextPageSelector}}">
                    </div>
                </div>
                <hr />
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        搜索小说URL
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="rule.FindURL" autocomplete="off" class="layui-input" value="{{.Rule.Rules.FindURL}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        搜索页面编码
                    </label>
                    <div class="layui-input-inline">
                      <select name="rule.FindCharset" lay-verify="charset">
                        <option value="">请选择搜索页面编码</option>
                        <option value="UTF-8" {{if eq "UTF-8" .Rule.Rules.FindCharset}}selected{{end}}>UTF-8</option>
                        <option value="GB18030" {{if eq "GB18030" .Rule.Rules.FindCharset}}selected{{end}}>GBK/GB2312</option>
                      </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说链接CSS选择器
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="rule.FindBookURLSelector" autocomplete="off" class="layui-input" value="{{.Rule.Rules.FindBookURLSelector}}">
                    </div>
                </div>
            </div>
            <div class="layui-tab-item cate_map">
                <div class="layui-form-item">
                    <div class="layui-input-inline">
                        目标站分类名称
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-sm btn-cate-add">
                            <i class="layui-icon">&#xe608;</i>
                        </button>
                    </div>
                    <div class="layui-input-inline cate-icon"></div>
                    <div class="layui-input-inline">对应分类</div>
                </div>
                {{range $k, $m := .Rule.CateMaps}}
                <div class="layui-form-item">
                    <div class="layui-input-inline">
                        <input type="text" name="cate[]" autocomplete="off" class="layui-input" placeholder="目标站分类名称" value="{{$m.Name}}" />
                    </div>
                    <div class="layui-input-inline cate-icon" >
                        <i class="layui-icon" style="font-size: 30px;">&#xe602;</i>
                    </div>
                    <div class="layui-input-inline">
                        <select class="selecte-cate" name="ocate[]" lay-search="">
                             <option value="" selected>请选择分类</option>
                             {{range $key, $c := $.Cates}}
                             <option value="{{$c.Id}}" {{if eq $m.Id $c.Id}}selected{{end}}>{{$c.Name}}</option>
                             {{end}}
                        </select>
                    </div>
                    <div class="layui-input-inline">
                        <button type="button" class="layui-btn layui-btn-danger layui-btn-sm btn-cate-del">
                            <i class="layui-icon">&#xe640;</i>
                        </button>
                    </div>
                </div>
                {{end}}
            </div>
            <div class="layui-tab-item test_data">
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说简介页面URL 
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.BookURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.BookURL}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说比对名称
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.BookTitle" autocomplete="off" class="layui-input" value="{{.Rule.Test.BookTitle}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说比对作者
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.BookAuthor" autocomplete="off" class="layui-input" value="{{.Rule.Test.BookAuthor}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说分类比对名称
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.BookCate" autocomplete="off" class="layui-input" value="{{.Rule.Test.BookCate}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说简介比对内容
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="随便截取部分内容，用于匹配比对" type="text" name="test.BookDesc" autocomplete="off" class="layui-input" value="{{.Rule.Test.BookDesc}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说缩略图比对URL
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="完整的URL地址" type="text" name="test.BookCover" autocomplete="off" class="layui-input" value="{{.Rule.Test.BookCover}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说章节比对URL
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="完整的URL地址" type="text" name="test.BookChapterURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.BookChapterURL}}">
                    </div>
                </div>
                <hr />
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说章节页面URL
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.ChapterURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.ChapterURL}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说第一章节比对URL
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="完整的URL地址" type="text" name="test.ChapterCatalogURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.ChapterCatalogURL}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说第一章节比对名称
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.ChapterCatalogTitle" autocomplete="off" class="layui-input" value="{{.Rule.Test.ChapterCatalogTitle}}">
                    </div>
                </div>
                <hr />
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说章节内容URL
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.InfoURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.InfoURL}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说章节比对标题
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.InfoTitle" autocomplete="off" class="layui-input" value="{{.Rule.Test.InfoTitle}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说章节比对内容
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.InfoDesc" autocomplete="off" class="layui-input" value="{{.Rule.Test.InfoDesc}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说章节上一页比对URL
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="完整的URL地址" type="text" name="test.InfoPrePageURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.InfoPrePageURL}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        小说章节下一页比对URL
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="完整的URL地址" type="text" name="test.InfoNextPageURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.InfoNextPageURL}}">
                    </div>
                </div>
                <hr />
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        搜索关键字
                    </label>
                    <div class="layui-input-block">
                        <input type="text" name="test.FindBookKw" autocomplete="off" class="layui-input" value="{{.Rule.Test.FindBookKw}}">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">
                        搜索结果小说比对URL
                    </label>
                    <div class="layui-input-block">
                        <input placeholder="完整的URL地址" type="text" name="test.FindBookURL" autocomplete="off" class="layui-input" value="{{.Rule.Test.FindBookURL}}">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block" >
                    <input type="hidden" name="id" value="{{.Rule.Id}}" />
                    <input type="submit" class="layui-btn" lay-submit="" lay-filter="save" value="保存" />
                </div>
            </div>
        </div>
    </div>
</form>

<script>
    window.onload = function() {
        layui.use(['form', 'layer', 'element'], function() {
            var $ = layui.jquery
                ,form = layui.form
                ,element = layui.element
                ,layer = layui.layer;

            // 监听提交
            form.on('submit(save)', function(data) {
                ajax_post({{.PostUrl}}, data.field, top.reload_page(), true, false, true);

                return false;
            });

            $(".btn-cate-add").click(function() {
                var clone = $(".cate_map .layui-form-item").last().clone(true).appendTo(".cate_map");
                clone.find(".layui-input").val("");
                clone.find(".select-cate option[selected]").val("");
                clone.find(".select-cate option[selected]").attr("selected", "");

                form.render();
            });

            // 分类删除
            $(".btn-cate-del").click(function() {
                if ($(".cate_map .layui-form-item").length > 2) {
                    $(this).parent().parent().remove();
                }
            });
        });
    }
</script>

</body>
