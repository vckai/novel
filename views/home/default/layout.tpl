<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0023)http://yuedu.sogou.com/ -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>{{if ne "" (or .Title "")}}{{.Title}} - {{end}}{{.aOut.Title}} - {{.aOut.SubTitle}}</title>
	<meta name="keywords" content="{{.aOut.Keyword}}">
	<meta name="description" content="{{.aOut.Description}}">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link rel="shortcut icon" href="{{.aOut.Favicon}}" type="image/x-icon" />
	<link href="{{.mOut.ViewUrl}}css/header.css" rel="stylesheet" type="text/css">
  	<link href="{{.mOut.ViewUrl}}css/official-web.css" rel="stylesheet" type="text/css">
  	<link href="{{.mOut.ViewUrl}}css/detail.css" rel="stylesheet" type="text/css">
  	
	<script type="text/javascript" src="{{.aOut.ViewUrl}}js/jquery.min.js" charset="utf-8"></script>
</head>
<body>
    {{template "home/default/common/header.tpl" .}}

    {{.LayoutContent}}

    {{template "home/default/common/footer.tpl" .}}
</body>
</html>
