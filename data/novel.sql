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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台管理员表';

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台操作日记表';



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网站banner配置表';



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='小说分类表';

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='游客会员反馈表';



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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台用户群组表';

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
  `is_original` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否原创',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否热门',
  `is_rec` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_vip_rec` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否会员推荐',
  `is_today_rec` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否今日推荐',
  `is_sign_new_book` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否签约新书榜',
  `is_collect` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏推荐',
  `is_vip_reward` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否vip打赏',
  `is_vip_up` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否vip更新',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '小说状态，1更新，2完结，3太监',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说字数',
  `chapter_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说章节数',
  `chapter_updated_at` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最新章节时间',
  `chapter_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '最新章节id',
  `chapter_title` varchar(100) NOT NULL DEFAULT '' COMMENT '最新章节标题',
  `collect_num` int(10) unsigned NOT NULL DEFAULT '0',
  `rec_num` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='小说主信息表';



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='小说采集站点链接关联表';



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台菜单权限表';

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
	(13,6,'操作日记','',1,'','AdminLog','Index',0,0,1495004798,1495004798,0),
	(14,6,'网站配置','',1,'','Config','Index',0,0,1555230351,1555230351,0),
	(15,0,'搜索管理','&#xe615;',1,'','','',40,0,1555230351,1555230351,0),
	(16,15,'搜索记录','',1,'','Search','Index',0,0,1555230351,1555230351,0),
	(17,15,'搜索日记','',1,'','SearchLog','Index',0,0,1555230351,1555230351,0),
    (18,7,'采集规则','',1,'','SnatchRule','Index',0,0,1555398698,1555398698,0);

/*!40000 ALTER TABLE `nov_role` ENABLE KEYS */;
UNLOCK TABLES;

# Dump of table nov_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_config`;

CREATE TABLE `nov_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL DEFAULT '' COMMENT '健值名',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT '健值内容',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网站配置表';

LOCK TABLES `nov_config` WRITE;
/*!40000 ALTER TABLE `nov_config` DISABLE KEYS */;

INSERT INTO `nov_config` (`id`, `key`, `value`, `created_at`, `updated_at`)
VALUES
	(1, 'Title', '卡丘小说', 1554814419, 1554814419),
	(2, 'SubTitle', '海量小说', 1554814419, 1554814419),
	(3, 'Keyword', '小说,免费小说,热门小说,言情小说,小说下载,漫画,好文章,电子书', 1554814419, 1554814419),
	(4, 'Description', '精彩小说尽在卡丘小说，提供海量热门小说免费在线阅读和下载，玄幻小说，武侠小说，原创小说，网游小说，都市小说，言情小说，青春小说，>    历史小说，军事小说，网游小说，科幻小说等多种丰富的内容类型', 1554814419, 1554814419),
	(5, 'WebURL', '', 1554814419, 1554814419),
	(6, 'MobileURL', '', 1554814419, 1554814419),
	(7, 'AdminURL', '', 1554814419, 1554814419),
	(8, 'ViewURL', '/public/', 1554814419, 1554814419),
	(9, 'Theme', 'default', 1554814419, 1554814419),
	(10, 'MobileTheme', 'default', 1554814419, 1554814419),
	(11, 'Logo', '/public/home/default/img/logo.png', 1554814419, 1554814419),
	(12, 'Favicon', '/public/img/favicon.ico', 1554814419, 1554814419),
	(13, 'Copyright', '© 2017 - 2019 KAQIU8.COM', 1554814419, 1554814419),
	(14, 'Icp', '', 1554814419, 1554814419),
	(15, 'IsSnatch', '0', 1554814419, 1554814419),
	(16, 'Uptime', '1', 1554814419, 1554814419),
	(17, 'NotUpStopDays', '10', 1554814419, 1554814419),
	(18, 'ProxyMode', '0', 1554814419, 1554814419),
	(19, 'ProxyURL', '', 1554814419, 1554814419),
	(20, 'ProxyUpTime', '10', 1554814419, 1554814419),
	(21, 'ProxyCheckTime', '30000', 1554814419, 1554814419),
	(22, 'AutoNewSnatchDay', '0', 1554814419, 1554814419),
	(23, 'AutoSnatchRank', '0', 1554814419, 1554814419),
	(24, 'StatisticsCode', '', 1554814419, 1554814419);

/*!40000 ALTER TABLE `nov_config` ENABLE KEYS */;
UNLOCK TABLES;

# Dump of table nov_search
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_search`;

CREATE TABLE `nov_search` (
  `id` bigint(21) unsigned NOT NULL AUTO_INCREMENT,
  `kw` varchar(100) NOT NULL COMMENT '关键词',
  `views` int(11) NOT NULL COMMENT '搜索次数',
  `is_rec` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `created_at` int(11) unsigned NOT NULL,
  `updated_at` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_kw` (`kw`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='搜索记录统计表';


# Dump of table nov_search_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_search_log`;

CREATE TABLE `nov_search_log` (
  `id` bigint(21) unsigned NOT NULL AUTO_INCREMENT,
  `kw` varchar(100) NOT NULL COMMENT '搜索关键词',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '搜索用户，0游客',
  `source` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '搜索来源，0：PC，1：手机站',
  `is_result` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有搜索结果，0：否，1：是',
  `ip` varchar(15) NOT NULL COMMENT '搜索用户IP',
  `created_at` int(11) unsigned NOT NULL,
  `updated_at` int(11) unsigned NOT NULL,
  `deleted_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='搜索日记表';

# Dump of table nov_snatch_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `nov_snatch_rule`;

CREATE TABLE `nov_snatch_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '采集站名称',
  `code` varchar(20) NOT NULL COMMENT '采集站唯一标识码',
  `url` varchar(50) NOT NULL COMMENT '采集站URL',
  `state` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用，0：禁用，1：启用',
  `is_update` tinyint(1) NOT NULL COMMENT '是否强制更新用于小说信息',
  `charset` varchar(10) NOT NULL COMMENT '网站编码格式',
  `cate_map` varchar(2555) NOT NULL COMMENT '分类转换对应',
  `rule` varchar(2555) NOT NULL COMMENT '采集规则',
  `test_data` varchar(2555) NOT NULL DEFAULT '' COMMENT '测试对比数据',
  `created_at` int(11) unsigned NOT NULL,
  `updated_at` int(11) unsigned NOT NULL,
  `deleted_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `nov_snatch_rule` WRITE;
/*!40000 ALTER TABLE `nov_snatch_rule` DISABLE KEYS */;

INSERT INTO `nov_snatch_rule`(`id`, `name`, `code`, `url`, `state`, `charset`, `cate_map`, `rule`, `test_data`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '顶点小说', 'x23us', 'https://www.x23us.com/', 1, 'GB18030', '[{\"id\":1,\"name\":\"玄幻魔法\"},{\"id\":2,\"name\":\"eee\"}]', '{\"book_title_selector\":\"#content dd:nth-of-type(1) h1\",\"book_author_selector\":\"#content dd:nth-of-type(2) div:nth-of-type(2) table tr:nth-of-type(1) td:nth-of-type(2)\",\"book_cate_selector\":\"#content dd:nth-of-type(2) div:nth-of-type(2) table tr:nth-of-type(1) td:nth-of-type(1) a\",\"book_desc_selector\":\"#content dd:nth-of-type(4) p:nth-of-type(2)\",\"book_cover_selector\":\"#content dd:nth-of-type(2) div:nth-of-type(1) a img\",\"book_no_cover\":\"nocover.jpg\",\"book_chapter_url_selector\":\"#content dd:nth-of-type(2) div:nth-of-type(1) a\",\"book_is_url\":\"\",\"is_crawler_url\":\"\",\"chapter_catalog_selector\":\"5\",\"chapter_abandon_num\":1,\"info_title_selector\":\"6\",\"info_desc_selector\":\"7\",\"info_desc_filter_rule\":\"顶 点 小 说 Ｘ ２３ Ｕ Ｓ．Ｃ ＯＭ\\n顶点小说 ２３ＵＳ．ＣＯＭ更新最快\\n顶点小说(.*)更新最快\\n\",\"info_catalog_page_selector\":\"\",\"info_pre_page_selector\":\"1\",\"info_next_page_selector\":\"1\"}', '', 1557731894, 1557818755, 0);

UNLOCK TABLES;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
