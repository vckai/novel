-- MySQL dump 10.14  Distrib 5.5.52-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: gochapter
-- ------------------------------------------------------
-- Server version	5.5.52-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `nov_chapter_0000`
--

DROP TABLE IF EXISTS `nov_chapter_0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0000` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0001`
--

DROP TABLE IF EXISTS `nov_chapter_0001`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0001` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0002`
--

DROP TABLE IF EXISTS `nov_chapter_0002`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0002` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0003`
--

DROP TABLE IF EXISTS `nov_chapter_0003`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0003` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0004`
--

DROP TABLE IF EXISTS `nov_chapter_0004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0004` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0005`
--

DROP TABLE IF EXISTS `nov_chapter_0005`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0005` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0006`
--

DROP TABLE IF EXISTS `nov_chapter_0006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0006` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0007`
--

DROP TABLE IF EXISTS `nov_chapter_0007`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0007` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0008`
--

DROP TABLE IF EXISTS `nov_chapter_0008`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0008` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0009`
--

DROP TABLE IF EXISTS `nov_chapter_0009`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0009` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0010`
--

DROP TABLE IF EXISTS `nov_chapter_0010`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0010` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0011`
--

DROP TABLE IF EXISTS `nov_chapter_0011`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0011` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0012`
--

DROP TABLE IF EXISTS `nov_chapter_0012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0012` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0013`
--

DROP TABLE IF EXISTS `nov_chapter_0013`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0013` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0014`
--

DROP TABLE IF EXISTS `nov_chapter_0014`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0014` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0015`
--

DROP TABLE IF EXISTS `nov_chapter_0015`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0015` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0016`
--

DROP TABLE IF EXISTS `nov_chapter_0016`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0016` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0017`
--

DROP TABLE IF EXISTS `nov_chapter_0017`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0017` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=2792 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0018`
--

DROP TABLE IF EXISTS `nov_chapter_0018`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0018` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=19633 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0019`
--

DROP TABLE IF EXISTS `nov_chapter_0019`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0019` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=12367 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0020`
--

DROP TABLE IF EXISTS `nov_chapter_0020`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0020` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=5320 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0021`
--

DROP TABLE IF EXISTS `nov_chapter_0021`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0021` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=1562 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0022`
--

DROP TABLE IF EXISTS `nov_chapter_0022`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0022` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=1522 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0023`
--

DROP TABLE IF EXISTS `nov_chapter_0023`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0023` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=2763 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0024`
--

DROP TABLE IF EXISTS `nov_chapter_0024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0024` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=1653 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0025`
--

DROP TABLE IF EXISTS `nov_chapter_0025`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0025` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=1765 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0026`
--

DROP TABLE IF EXISTS `nov_chapter_0026`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0026` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=3265 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0027`
--

DROP TABLE IF EXISTS `nov_chapter_0027`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0027` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0028`
--

DROP TABLE IF EXISTS `nov_chapter_0028`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0028` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0029`
--

DROP TABLE IF EXISTS `nov_chapter_0029`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0029` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=505 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0030`
--

DROP TABLE IF EXISTS `nov_chapter_0030`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0030` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=3189 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0031`
--

DROP TABLE IF EXISTS `nov_chapter_0031`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0031` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB AUTO_INCREMENT=689 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0032`
--

DROP TABLE IF EXISTS `nov_chapter_0032`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0032` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0033`
--

DROP TABLE IF EXISTS `nov_chapter_0033`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0033` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0034`
--

DROP TABLE IF EXISTS `nov_chapter_0034`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0034` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0035`
--

DROP TABLE IF EXISTS `nov_chapter_0035`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0035` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0036`
--

DROP TABLE IF EXISTS `nov_chapter_0036`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0036` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0037`
--

DROP TABLE IF EXISTS `nov_chapter_0037`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0037` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0038`
--

DROP TABLE IF EXISTS `nov_chapter_0038`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0038` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0039`
--

DROP TABLE IF EXISTS `nov_chapter_0039`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0039` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0040`
--

DROP TABLE IF EXISTS `nov_chapter_0040`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0040` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0041`
--

DROP TABLE IF EXISTS `nov_chapter_0041`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0041` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0042`
--

DROP TABLE IF EXISTS `nov_chapter_0042`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0042` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0043`
--

DROP TABLE IF EXISTS `nov_chapter_0043`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0043` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0044`
--

DROP TABLE IF EXISTS `nov_chapter_0044`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0044` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0045`
--

DROP TABLE IF EXISTS `nov_chapter_0045`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0045` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0046`
--

DROP TABLE IF EXISTS `nov_chapter_0046`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0046` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0047`
--

DROP TABLE IF EXISTS `nov_chapter_0047`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0047` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0048`
--

DROP TABLE IF EXISTS `nov_chapter_0048`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0048` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0049`
--

DROP TABLE IF EXISTS `nov_chapter_0049`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0049` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0050`
--

DROP TABLE IF EXISTS `nov_chapter_0050`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0050` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0051`
--

DROP TABLE IF EXISTS `nov_chapter_0051`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0051` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0052`
--

DROP TABLE IF EXISTS `nov_chapter_0052`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0052` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0053`
--

DROP TABLE IF EXISTS `nov_chapter_0053`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0053` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0054`
--

DROP TABLE IF EXISTS `nov_chapter_0054`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0054` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0055`
--

DROP TABLE IF EXISTS `nov_chapter_0055`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0055` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0056`
--

DROP TABLE IF EXISTS `nov_chapter_0056`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0056` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0057`
--

DROP TABLE IF EXISTS `nov_chapter_0057`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0057` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0058`
--

DROP TABLE IF EXISTS `nov_chapter_0058`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0058` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0059`
--

DROP TABLE IF EXISTS `nov_chapter_0059`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0059` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0060`
--

DROP TABLE IF EXISTS `nov_chapter_0060`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0060` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0061`
--

DROP TABLE IF EXISTS `nov_chapter_0061`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0061` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0062`
--

DROP TABLE IF EXISTS `nov_chapter_0062`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0062` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0063`
--

DROP TABLE IF EXISTS `nov_chapter_0063`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0063` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0064`
--

DROP TABLE IF EXISTS `nov_chapter_0064`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0064` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0065`
--

DROP TABLE IF EXISTS `nov_chapter_0065`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0065` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0066`
--

DROP TABLE IF EXISTS `nov_chapter_0066`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0066` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0067`
--

DROP TABLE IF EXISTS `nov_chapter_0067`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0067` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0068`
--

DROP TABLE IF EXISTS `nov_chapter_0068`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0068` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0069`
--

DROP TABLE IF EXISTS `nov_chapter_0069`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0069` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0070`
--

DROP TABLE IF EXISTS `nov_chapter_0070`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0070` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0071`
--

DROP TABLE IF EXISTS `nov_chapter_0071`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0071` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0072`
--

DROP TABLE IF EXISTS `nov_chapter_0072`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0072` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0073`
--

DROP TABLE IF EXISTS `nov_chapter_0073`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0073` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0074`
--

DROP TABLE IF EXISTS `nov_chapter_0074`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0074` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0075`
--

DROP TABLE IF EXISTS `nov_chapter_0075`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0075` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0076`
--

DROP TABLE IF EXISTS `nov_chapter_0076`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0076` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0077`
--

DROP TABLE IF EXISTS `nov_chapter_0077`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0077` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0078`
--

DROP TABLE IF EXISTS `nov_chapter_0078`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0078` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0079`
--

DROP TABLE IF EXISTS `nov_chapter_0079`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0079` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0080`
--

DROP TABLE IF EXISTS `nov_chapter_0080`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0080` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0081`
--

DROP TABLE IF EXISTS `nov_chapter_0081`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0081` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0082`
--

DROP TABLE IF EXISTS `nov_chapter_0082`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0082` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0083`
--

DROP TABLE IF EXISTS `nov_chapter_0083`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0083` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0084`
--

DROP TABLE IF EXISTS `nov_chapter_0084`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0084` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0085`
--

DROP TABLE IF EXISTS `nov_chapter_0085`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0085` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0086`
--

DROP TABLE IF EXISTS `nov_chapter_0086`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0086` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0087`
--

DROP TABLE IF EXISTS `nov_chapter_0087`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0087` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0088`
--

DROP TABLE IF EXISTS `nov_chapter_0088`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0088` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0089`
--

DROP TABLE IF EXISTS `nov_chapter_0089`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0089` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0090`
--

DROP TABLE IF EXISTS `nov_chapter_0090`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0090` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0091`
--

DROP TABLE IF EXISTS `nov_chapter_0091`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0091` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0092`
--

DROP TABLE IF EXISTS `nov_chapter_0092`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0092` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0093`
--

DROP TABLE IF EXISTS `nov_chapter_0093`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0093` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0094`
--

DROP TABLE IF EXISTS `nov_chapter_0094`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0094` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0095`
--

DROP TABLE IF EXISTS `nov_chapter_0095`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0095` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0096`
--

DROP TABLE IF EXISTS `nov_chapter_0096`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0096` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0097`
--

DROP TABLE IF EXISTS `nov_chapter_0097`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0097` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0098`
--

DROP TABLE IF EXISTS `nov_chapter_0098`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0098` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nov_chapter_0099`
--

DROP TABLE IF EXISTS `nov_chapter_0099`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nov_chapter_0099` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nov_id` int(10) unsigned NOT NULL DEFAULT '0',
  `chapter_no` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(100) NOT NULL DEFAULT '',
  `desc` longtext NOT NULL,
  `link` varchar(100) NOT NULL DEFAULT '',
  `source` varchar(10) NOT NULL DEFAULT '',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `try_views` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `created_at` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted_at` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `udx_novid_no_source` (`nov_id`,`chapter_no`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-03 16:23:02
