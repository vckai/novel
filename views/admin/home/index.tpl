<body class="x-iframe-body">
	<div class="x-nav">
		<span class="layui-breadcrumb">
		  <a><cite>首页</cite></a>
		</span>
	</div>

	<div class="x-body">
        <div class="layui-card">
            <blockquote class="layui-elem-quote">
                欢迎使用{{.aOut.Title}}！<span class="f-14">v{{.aOut.Version}}</span>
            </blockquote>
            <table class="layui-table">
                <thead>
                    <tr>
                        <th colspan="2" scope="col">登录信息</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th width="30%">登录次数</th>
                        <td><span>{{.LoginVisit}}</span></td>
                    </tr>
                    <tr>
                        <td>上次登录IP</td>
                        <td>{{.LastLoginIp}}</td>
                    </tr>
                    <tr>
                        <td>上次登录时间</td>
                        <td>{{datetime .LastLoginedAt "2006-01-02 15:04"}}</td>
                    </tr>
                </tbody>
            </table>
            <!--
            <fieldset class="layui-elem-field layui-field-title site-title">
              <legend><a name="default">信息统计</a></legend>
            </fieldset>
            <table class="layui-table">
                <thead>
                    <tr>
                        <th>统计</th>
                        <th>资讯库</th>
                        <th>图片库</th>
                        <th>产品库</th>
                        <th>用户</th>
                        <th>管理员</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>总数</td>
                        <td>92</td>
                        <td>9</td>
                        <td>0</td>
                        <td>8</td>
                        <td>20</td>
                    </tr>
                    <tr>
                        <td>今日</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td>昨日</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td>本周</td>
                        <td>2</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td>本月</td>
                        <td>2</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                </tbody>
            </table>
            -->
            <fieldset class="layui-elem-field layui-field-title site-title">
              <legend><a name="default">系统信息</a></legend>
            </fieldset>
            <table class="layui-table">
                <thead>
                    <tr>
                        <th colspan="2" scope="col">服务器信息</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th width="30%">应用名称</th>
                        <td><span id="lbServerName">{{.AppName}}</span></td>
                    </tr>
                    <tr>
                        <td>服务器IP地址</td>
                        <td>{{.Ip}}</td>
                    </tr>
                    <tr>
                        <td>服务器端口 </td>
                        <td>{{.Port}}</td>
                    </tr>
                    <tr>
                        <td>Goos</td>
                        <td>{{.Goos}}</td>
                    </tr>
                    <tr>
                        <td>Go Version</td>
                        <td>{{.Version}}</td>
                    </tr>
                    <tr>
                        <td>服务器当前时间 </td>
                        <td>{{.NowTime}}</td>
                    </tr>
                    <tr>
                        <td>服务器上次启动到现在已运行 </td>
                        <td>{{.UpTime}}分钟</td>
                    </tr>
                    <tr>
                        <td>CPU 总数 </td>
                        <td>{{.Cpus}}</td>
                    </tr>
                    <tr>
                        <td>CPU 类型 </td>
                        <td>{{.CPUModelName}}</td>
                    </tr>
                    <tr>
                        <td>虚拟内存 </td>
                        <td>{{.Memory}}MB</td>
                    </tr>
                    <tr>
                        <td>当前程序占用内存 </td>
                        <td>3.29M</td>
                    </tr>
                    <tr>
                        <td>当前Session数量 </td>
                        <td>8</td>
                    </tr>
                    <tr>
                        <td>当前SessionID </td>
                        <td>{{.SessionID}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
	<div class="layui-footer footer footer-demo">
		<div class="layui-main">
			<p>
                Copyright ©2017 <a href="https://github.com/vckai/novel" target="_blank">vckai/novel</a> v{{.aOut.Version}} All Rights Reserved.
			</p>
		</div>
	</div>
</body>
