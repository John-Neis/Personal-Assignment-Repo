-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: namesdb
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.19.04.1

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
-- Table structure for table `tblnames`
--

DROP TABLE IF EXISTS `tblnames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblnames` (
  `NameID` int(11) NOT NULL AUTO_INCREMENT,
  `LastName` varchar(50) NOT NULL DEFAULT '',
  `FirstName` varchar(50) NOT NULL DEFAULT '',
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  UNIQUE KEY `NameID` (`NameID`),
  KEY `PrimaryKey` (`LastName`,`FirstName`,`NameID`)
) ENGINE=MyISAM AUTO_INCREMENT=1332 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblnames`
--

LOCK TABLES `tblnames` WRITE;
/*!40000 ALTER TABLE `tblnames` DISABLE KEYS */;
INSERT INTO `tblnames` VALUES (2,'Backman','Nels','Fargo','ND'),(4,'Bennefeld','Greg','Devils Lake','ND'),(15,'Heidt','Brian','Fargo','ND'),(24,'Corimer','Travis','GF AFB','ND'),(25,'Duppong','Chad','Minneapolis','MN'),(26,'Dukart','Al','EGF','MN'),(250,'Olson','Chris','Boston','MA'),(29,'Anderson','Calvin','Crookston','MN'),(52,'Brady','Robin','Fargo','ND'),(56,'Cwikla','Dan','Grand Forks','ND'),(89,'Collins','Paul','El Paso','NM'),(90,'Hilliard','Wesley','Langby','MN'),(105,'Eder','Jason','Grand Forks','ND'),(111,'Kidder','David','Fargo','ND'),(115,'Hinsz','Bryan','Bismarck','ND'),(116,'Hollands','Kelly','Crookston','MN'),(249,'Pinyerd','Clay','Colorado Springs','CO'),(122,'Kaiser','Donnie','Woodbury','MN'),(240,'Dupree','Matt','Thief River Falls','MN'),(55,'Christensen','Guy','Fargo','ND'),(1330,'O\'Neil','Tom','Somewhere in ','MN'),(1329,'Stokke','Tom','ND','BC'),(1328,'Nelson','Jeffrey','Williston','ND'),(1331,'Jackson','Andie','Princeton','NJ');
/*!40000 ALTER TABLE `tblnames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblusers`
--

DROP TABLE IF EXISTS `tblusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblusers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblusers`
--

LOCK TABLES `tblusers` WRITE;
/*!40000 ALTER TABLE `tblusers` DISABLE KEYS */;
INSERT INTO `tblusers` VALUES (1,'Tom','Stokke','tstokke','8faf678cd96319fc642837407f2b3328'),(2,'Emanuel','Grant','grante','grante');
/*!40000 ALTER TABLE `tblusers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-14 16:02:34
