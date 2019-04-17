<ul class="layui-nav layui-nav-tree site-demo-nav" lay-filter="side">
    {{range .Menus}}
    <li class="layui-nav-item  layui-nav-itemed">
        <a class="javascript:;" href="javascript:;" _href="{{urlfor .Url}}">
            <i class="layui-icon">{{str2html .Icon}}</i><cite>{{.Name}}</cite>
        </a>
        {{if compare (urlfor .Url) ""}}
        <dl class="layui-nav-child">
            {{range $k, $v := .Child}}
            <dd class="">
                <dd class="">
                    <a href="javascript:;" _href="{{urlfor $v.Url}}">
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
