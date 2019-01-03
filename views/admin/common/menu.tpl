<div class="layui-side-scroll">
    <ul class="layui-nav layui-nav-tree site-demo-nav" lay-filter="side">
		{{range .Menus}}
        <li class="layui-nav-item  layui-nav-itemed">
            <a class="javascript:;" href="javascript:;" _href="{{.Url}}">
                <i class="layui-icon" style="top: 3px;">{{str2html .Icon}}</i><cite>{{.Name}}</cite>
            </a>
			{{if compare .Url ""}}
            <dl class="layui-nav-child">
				{{range $k, $v := .Child}}
                <dd class="">
                    <dd class="">
                        <a href="javascript:;" _href="{{$v.Url}}">
                            <cite>{{$v.Name}}</cite>
                        </a>
                    </dd>
                </dd>
				{{end}}
            </dl>
			{{end}}
        </li>
		{{end}}
    </ul>
</div>
