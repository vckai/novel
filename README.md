# gonovel

基于beego的小说采集展示网站，演示站点：[卡丘小说](http://139.199.178.202:8089/)。

### 环境说明
* Go1.9+
* Beego1.7.2
* MySQL5.7

### 效果展示

#### PC网站效果

| | |
|:---:|:---:|
|![卡丘小说](https://s01.vckai.com/up/2019/03/18/1552841367440689274.jpg)|![卡丘小说](https://s01.vckai.com/up/2019/03/18/1552841394044154532.jpg "卡丘小说")|
|![](https://s01.vckai.com/up/2019/03/18/1552841442329459205.jpg)|![](https://s01.vckai.com/up/2019/03/18/1552841452836628644.jpg)|

####  H5网站效果
| | |
|:---:|:---:|
|![](https://s01.vckai.com/up/2019/03/18/1552841460952649196.jpg)|![](https://s01.vckai.com/up/2019/03/18/1552841494705762686.jpg)|
|![](https://s01.vckai.com/up/2019/03/18/1552841479351451190.jpg)|![](https://s01.vckai.com/up/2019/03/18/1552841486870139995.jpg)|

####  管理后台效果
| | |
|:---:|:---:|
|![](https://s01.vckai.com/up/2019/03/18/1552841512895310951.jpg)|![](https://s01.vckai.com/up/2019/03/18/1552841521101010135.jpg)|
|![](https://s01.vckai.com/up/2019/03/18/1552841528344794326.jpg)|![](https://s01.vckai.com/up/2019/03/18/1552841537608031827.jpg)|
|![](https://s01.vckai.com/up/2019/03/18/1552841544702908774.jpg)|![](https://s01.vckai.com/up/2019/03/18/1552842227563530600.jpg)|

### 安装说明

Go环境和MySQL请自行安装。

1. 下载源码
```
go get -u github.com/vckai/novel
cd $GOPATH/src/github.com/vckai/novel
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
