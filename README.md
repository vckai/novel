# gonovel

基于beego的小说采集展示网站，演示站点：[卡丘小说](http://139.199.178.202:8089/)。

### 环境说明
* Go1.9+
* Beego1.7.2
* MySQL5.7

### 安装说明

Go环境和MySQL请自行安装。

1. 下载源码
```
git clone http://github.com/vckai/novel.git
cd novel
go build
```

2. 导入SQL文件
    * `./data/novel.sql`   小说主数据库信息文件
    * `./data/chapter.sql` 小说章节

3. 配置
请根据实际情况修改`app.conf`和`data.conf`的配置文件
```
cp ./conf/app.conf.example ./conf/app.conf
cp ./conf/data.conf.example ./conf/data.conf
```

4. 运行访问
```
./novel
```
然后在浏览器中输入localhost:8089 访问首页 进入localhost:8089/admin进入后台，初始用户名/密码：admin/admin123
