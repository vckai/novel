# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.16)
# Database: gonovel
# Generation Time: 2019-01-03 08:52:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table nov_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_admin`;

CREATE TABLE `nov_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(30) NOT NULL DEFAULT '' COMMENT '用户账号',
  `mail` varchar(100) NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `mobile` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '用户手机号码',
  `password` varchar(100) NOT NULL DEFAULT '' COMMENT '用户密码',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户所属群组',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户状态',
  `login_visit` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `last_logined_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `nov_admin` WRITE;
/*!40000 ALTER TABLE `nov_admin` DISABLE KEYS */;

INSERT INTO `nov_admin` (`id`, `account`, `mail`, `name`, `mobile`, `password`, `group_id`, `status`, `login_visit`, `last_login_ip`, `last_logined_at`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'admin','','Vckai',0,'d5e8ee6b896d9f3fbbb14845a0845e3a02f06334065a4ba753932e29a301af3e',1,0,1,'127.0.0.1',1546503635,1492083069,1546503635,0);

/*!40000 ALTER TABLE `nov_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table nov_admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_admin_log`;

CREATE TABLE `nov_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作人UID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人名称',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '操作人IP',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日记类型',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '日记内容',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table nov_banner
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_banner`;

CREATE TABLE `nov_banner` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `img` varchar(100) NOT NULL DEFAULT '' COMMENT '图片URL',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '跳转URL',
  `zone` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '所属广告位',
  `desc` varchar(100) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  `ext` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table nov_cate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_cate`;

CREATE TABLE `nov_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `is_menu` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否菜单',
  `is_home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否首页显示',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `nov_cate` WRITE;
/*!40000 ALTER TABLE `nov_cate` DISABLE KEYS */;

INSERT INTO `nov_cate` (`id`, `name`, `is_menu`, `is_home`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'玄幻魔法',1,1,1491140543,1491140666,0),
	(2,'武侠修真',1,1,1491140686,1491140686,0),
	(3,'都市言情',1,1,1491140708,1491140708,0),
	(4,'历史军事',1,1,1491140720,1491140720,0),
	(5,'侦探推理',1,1,1491140732,1491140732,0),
	(6,'网游动漫',1,0,1491140748,1493984032,0),
	(7,'科幻小说',1,0,1491140760,1493984039,0),
	(8,'恐怖灵异',1,0,1491140775,1493984026,0),
	(10,'架空历史',1,0,1494055362,1494055362,0),
	(11,'高干总裁',1,0,1494055377,1494055377,0),
	(12,'同人耽美',1,0,1494055418,1494055418,0),
	(13,'其他类型',1,0,1495114540,1495114540,0);

/*!40000 ALTER TABLE `nov_cate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table nov_feedback
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_feedback`;

CREATE TABLE `nov_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '反馈人UID，游客为0',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '反馈人名称',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '反馈人IP',
  `type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '反馈类型',
  `status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '反馈处理状态',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '反馈内容',
  `contact` varchar(100) NOT NULL DEFAULT '' COMMENT '反馈人联系方式',
  `reply` varchar(255) NOT NULL DEFAULT '' COMMENT '处理说明',
  `reply_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '处理时间',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table nov_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_group`;

CREATE TABLE `nov_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '群组名称',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '群组说明',
  `role_ids` varchar(2555) NOT NULL DEFAULT '' COMMENT '群组权限ID，多个,分割',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `nov_group` WRITE;
/*!40000 ALTER TABLE `nov_group` DISABLE KEYS */;

INSERT INTO `nov_group` (`id`, `name`, `desc`, `role_ids`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'超级管理员','拥有至高无上的权限~','6,1,2,3,4,5,6',1492083053,1492083053,0);

/*!40000 ALTER TABLE `nov_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table nov_novel
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_novel`;

CREATE TABLE `nov_novel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '小说名称',
  `desc` varchar(2555) NOT NULL DEFAULT '' COMMENT '小说描述',
  `cover` varchar(100) NOT NULL DEFAULT '' COMMENT '小说封面',
  `cate_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说分类',
  `cate_name` varchar(30) NOT NULL DEFAULT '' COMMENT '分类名称',
  `author` varchar(30) NOT NULL DEFAULT '' COMMENT '小说作者',
  `is_hot` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否热门',
  `is_rec` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_vip_rec` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否会员推荐',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '小说状态，0更新，1完结，2太监',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说字数',
  `chapter_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说章节数',
  `chapter_updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最新章节时间',
  `chapter_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最新章节id',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_title` varchar(100) NOT NULL DEFAULT '' COMMENT '最新章节标题',
  `collect_num` int(10) unsigned NOT NULL DEFAULT '0',
  `rec_num` int(10) unsigned NOT NULL DEFAULT '0',
  `is_today_rec` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否今日推荐',
  `is_man_like` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否男生喜欢',
  `is_girl_like` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否女生喜欢',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table nov_novel_links
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_novel_links`;

CREATE TABLE `nov_novel_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(11) unsigned NOT NULL COMMENT '小说ID',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '采集来源小说简介URL',
  `source` varchar(30) NOT NULL DEFAULT '' COMMENT '采集站标识',
  `chapter_link` varchar(100) NOT NULL DEFAULT '' COMMENT '采集来源章节页面URL',
  `updated_at` int(11) unsigned NOT NULL COMMENT '更新时间',
  `created_at` int(11) unsigned NOT NULL COMMENT '创建时间',
  `deleted_at` int(11) unsigned NOT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `udx_link_source` (`source`,`link`),
  KEY `idx_novid` (`nov_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table nov_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_role`;

CREATE TABLE `nov_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父模块ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '模块名称',
  `icon` varchar(10) NOT NULL DEFAULT '' COMMENT '菜单icon',
  `is_menu` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否左侧菜单显示',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '模块说明',
  `module` varchar(50) NOT NULL DEFAULT '' COMMENT '模块',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '方法',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认模块',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `nov_role` WRITE;
/*!40000 ALTER TABLE `nov_role` DISABLE KEYS */;

INSERT INTO `nov_role` (`id`, `pid`, `name`, `icon`, `is_menu`, `desc`, `module`, `action`, `sort`, `is_default`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,0,'后台首页','&#xe60a;',1,'','Home','Index',255,1,1492082737,1492083266,0),
	(2,0,'管理员管理','&#xe613;',1,'','','',30,0,1492082898,1492083886,0),
	(3,2,'管理员列表','',1,'','Admin','Index',0,0,1492082919,1492082919,0),
	(4,2,'群组管理','',1,'','Group','Index',0,0,1492082943,1492082943,0),
	(5,2,'权限管理','',1,'','Role','Index',0,0,1492082961,1492082961,0),
	(6,0,'系统设置','&#xe614;',1,'','','',0,0,1492082995,1492082995,0),
	(7,0,'小说管理','&#xe650;',1,'','','',50,0,1492083163,1492083897,0),
	(8,7,'小说列表','',1,'','Novel','Index',100,0,1492083183,1492083252,0),
	(9,7,'章节管理','',0,'','Chapter','Index',100,0,1492083203,1495109728,0),
	(10,6,'用户反馈','',1,'','Feedback','Index',0,0,1493122753,1493122753,0),
	(11,7,'分类管理','',1,'','Cate','Index',0,0,1493983980,1493983980,0),
	(12,6,'轮播管理','',1,'','Banner','Index',0,0,1494999793,1494999824,0),
	(13,6,'操作日记','',1,'','AdminLog','Index',0,0,1495004798,1495004798,0);

/*!40000 ALTER TABLE `nov_role` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
