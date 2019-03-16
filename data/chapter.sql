/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50716
 Source Host           : localhost:3306
 Source Schema         : chapter

 Target Server Type    : MySQL
 Target Server Version : 50716
 File Encoding         : 65001

 Date: 16/03/2019 12:23:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for nov_chapter_0000
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0000`;
CREATE TABLE `nov_chapter_0000` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0001
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0001`;
CREATE TABLE `nov_chapter_0001` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0002
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0002`;
CREATE TABLE `nov_chapter_0002` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0003
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0003`;
CREATE TABLE `nov_chapter_0003` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0004
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0004`;
CREATE TABLE `nov_chapter_0004` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0005
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0005`;
CREATE TABLE `nov_chapter_0005` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0006
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0006`;
CREATE TABLE `nov_chapter_0006` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0007
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0007`;
CREATE TABLE `nov_chapter_0007` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0008
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0008`;
CREATE TABLE `nov_chapter_0008` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0009
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0009`;
CREATE TABLE `nov_chapter_0009` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0010
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0010`;
CREATE TABLE `nov_chapter_0010` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0011
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0011`;
CREATE TABLE `nov_chapter_0011` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0012
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0012`;
CREATE TABLE `nov_chapter_0012` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0013
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0013`;
CREATE TABLE `nov_chapter_0013` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0014
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0014`;
CREATE TABLE `nov_chapter_0014` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0015
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0015`;
CREATE TABLE `nov_chapter_0015` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0016
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0016`;
CREATE TABLE `nov_chapter_0016` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0017
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0017`;
CREATE TABLE `nov_chapter_0017` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0018
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0018`;
CREATE TABLE `nov_chapter_0018` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0019
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0019`;
CREATE TABLE `nov_chapter_0019` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0020
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0020`;
CREATE TABLE `nov_chapter_0020` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0021
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0021`;
CREATE TABLE `nov_chapter_0021` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0022
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0022`;
CREATE TABLE `nov_chapter_0022` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0023
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0023`;
CREATE TABLE `nov_chapter_0023` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0024
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0024`;
CREATE TABLE `nov_chapter_0024` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0025
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0025`;
CREATE TABLE `nov_chapter_0025` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0026
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0026`;
CREATE TABLE `nov_chapter_0026` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0027
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0027`;
CREATE TABLE `nov_chapter_0027` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0028
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0028`;
CREATE TABLE `nov_chapter_0028` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0029
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0029`;
CREATE TABLE `nov_chapter_0029` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0030
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0030`;
CREATE TABLE `nov_chapter_0030` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0031
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0031`;
CREATE TABLE `nov_chapter_0031` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0032
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0032`;
CREATE TABLE `nov_chapter_0032` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0033
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0033`;
CREATE TABLE `nov_chapter_0033` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0034
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0034`;
CREATE TABLE `nov_chapter_0034` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0035
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0035`;
CREATE TABLE `nov_chapter_0035` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0036
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0036`;
CREATE TABLE `nov_chapter_0036` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0037
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0037`;
CREATE TABLE `nov_chapter_0037` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0038
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0038`;
CREATE TABLE `nov_chapter_0038` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0039
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0039`;
CREATE TABLE `nov_chapter_0039` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0040
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0040`;
CREATE TABLE `nov_chapter_0040` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0041
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0041`;
CREATE TABLE `nov_chapter_0041` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0042
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0042`;
CREATE TABLE `nov_chapter_0042` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0043
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0043`;
CREATE TABLE `nov_chapter_0043` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0044
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0044`;
CREATE TABLE `nov_chapter_0044` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0045
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0045`;
CREATE TABLE `nov_chapter_0045` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0046
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0046`;
CREATE TABLE `nov_chapter_0046` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0047
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0047`;
CREATE TABLE `nov_chapter_0047` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0048
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0048`;
CREATE TABLE `nov_chapter_0048` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0049
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0049`;
CREATE TABLE `nov_chapter_0049` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0050
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0050`;
CREATE TABLE `nov_chapter_0050` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0051
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0051`;
CREATE TABLE `nov_chapter_0051` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0052
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0052`;
CREATE TABLE `nov_chapter_0052` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0053
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0053`;
CREATE TABLE `nov_chapter_0053` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0054
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0054`;
CREATE TABLE `nov_chapter_0054` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0055
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0055`;
CREATE TABLE `nov_chapter_0055` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0056
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0056`;
CREATE TABLE `nov_chapter_0056` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0057
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0057`;
CREATE TABLE `nov_chapter_0057` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0058
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0058`;
CREATE TABLE `nov_chapter_0058` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0059
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0059`;
CREATE TABLE `nov_chapter_0059` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0060
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0060`;
CREATE TABLE `nov_chapter_0060` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0061
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0061`;
CREATE TABLE `nov_chapter_0061` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0062
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0062`;
CREATE TABLE `nov_chapter_0062` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0063
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0063`;
CREATE TABLE `nov_chapter_0063` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0064
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0064`;
CREATE TABLE `nov_chapter_0064` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0065
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0065`;
CREATE TABLE `nov_chapter_0065` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0066
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0066`;
CREATE TABLE `nov_chapter_0066` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0067
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0067`;
CREATE TABLE `nov_chapter_0067` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0068
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0068`;
CREATE TABLE `nov_chapter_0068` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0069
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0069`;
CREATE TABLE `nov_chapter_0069` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0070
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0070`;
CREATE TABLE `nov_chapter_0070` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0071
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0071`;
CREATE TABLE `nov_chapter_0071` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0072
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0072`;
CREATE TABLE `nov_chapter_0072` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0073
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0073`;
CREATE TABLE `nov_chapter_0073` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0074
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0074`;
CREATE TABLE `nov_chapter_0074` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0075
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0075`;
CREATE TABLE `nov_chapter_0075` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0076
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0076`;
CREATE TABLE `nov_chapter_0076` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0077
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0077`;
CREATE TABLE `nov_chapter_0077` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0078
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0078`;
CREATE TABLE `nov_chapter_0078` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0079
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0079`;
CREATE TABLE `nov_chapter_0079` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0080
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0080`;
CREATE TABLE `nov_chapter_0080` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0081
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0081`;
CREATE TABLE `nov_chapter_0081` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0082
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0082`;
CREATE TABLE `nov_chapter_0082` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0083
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0083`;
CREATE TABLE `nov_chapter_0083` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0084
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0084`;
CREATE TABLE `nov_chapter_0084` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0085
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0085`;
CREATE TABLE `nov_chapter_0085` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0086
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0086`;
CREATE TABLE `nov_chapter_0086` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0087
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0087`;
CREATE TABLE `nov_chapter_0087` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0088
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0088`;
CREATE TABLE `nov_chapter_0088` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0089
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0089`;
CREATE TABLE `nov_chapter_0089` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0090
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0090`;
CREATE TABLE `nov_chapter_0090` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0091
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0091`;
CREATE TABLE `nov_chapter_0091` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0092
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0092`;
CREATE TABLE `nov_chapter_0092` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0093
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0093`;
CREATE TABLE `nov_chapter_0093` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0094
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0094`;
CREATE TABLE `nov_chapter_0094` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0095
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0095`;
CREATE TABLE `nov_chapter_0095` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0096
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0096`;
CREATE TABLE `nov_chapter_0096` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0097
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0097`;
CREATE TABLE `nov_chapter_0097` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0098
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0098`;
CREATE TABLE `nov_chapter_0098` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for nov_chapter_0099
-- ----------------------------
DROP TABLE IF EXISTS `nov_chapter_0099`;
CREATE TABLE `nov_chapter_0099` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '小说ID',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节标题',
  `desc` longtext NOT NULL COMMENT '章节内容',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '章节采集链接',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '章节采集站点源',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `text_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '章节字数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '章节采集状态0正常，1失败',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '采集重试次数',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
