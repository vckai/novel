<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="x5-fullscreen" content="true">
    <meta name="full-screen" content="yes">
    <link href="" rel="shortcut icon">
    <link rel="apple-touch-icon-precomposed" href="">
    <!-- iOS 设备 begin -->
    <meta name="apple-mobile-web-app-title" content="{{.aOut.Title}}">
    <title>{{if ne "" (or .Title "")}}{{.Title}} - {{end}}{{.aOut.Title}} - {{.aOut.SubTitle}}</title>
    <meta name="keywords" content="{{.aOut.Keyword}}">
    <meta name="description" content="{{.aOut.Description}}">
    <script type="text/javascript" src="{{.mOut.ViewUrl}}js/zepto.min.v1.0rc1.js" charset="utf-8"></script>
</head>
<body>
    {{.LayoutContent}}
    
    {{template "m/default/common/footer.tpl" .}}
</body>
<div>
    
</div>
</html>
