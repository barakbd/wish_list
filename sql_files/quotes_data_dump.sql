-- MySQL dump 10.13  Distrib 5.6.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: quotes
-- ------------------------------------------------------
-- Server version	5.6.31-0ubuntu0.15.10.1

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
-- Table structure for table `favourites`
--

DROP TABLE IF EXISTS `favourites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favourites` (
  `quotes_quote_id` int(11) NOT NULL,
  `users_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`quotes_quote_id`,`users_user_id`),
  KEY `fk_quotes_has_users_users1_idx` (`users_user_id`),
  KEY `fk_quotes_has_users_quotes1_idx` (`quotes_quote_id`),
  CONSTRAINT `fk_quotes_has_users_quotes1` FOREIGN KEY (`quotes_quote_id`) REFERENCES `quotes` (`quote_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quotes_has_users_users1` FOREIGN KEY (`users_user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favourites`
--

LOCK TABLES `favourites` WRITE;
/*!40000 ALTER TABLE `favourites` DISABLE KEYS */;
INSERT INTO `favourites` VALUES (6,9,'2016-07-22 12:47:47'),(8,10,'2016-07-22 14:57:59'),(9,4,'2016-07-22 14:40:50'),(9,9,'2016-07-22 12:47:45'),(10,4,'2016-07-22 13:07:23'),(10,10,'2016-07-22 14:57:57'),(11,4,'2016-07-22 14:40:37'),(12,10,'2016-07-22 14:57:56'),(12,11,'2016-08-01 17:14:24'),(13,4,'2016-07-22 14:58:49'),(14,11,'2016-08-01 17:14:21');
/*!40000 ALTER TABLE `favourites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotes`
--

DROP TABLE IF EXISTS `quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotes` (
  `quote_id` int(11) NOT NULL AUTO_INCREMENT,
  `quoted_by` varchar(255) NOT NULL,
  `quote_text` longtext NOT NULL,
  `users_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`quote_id`),
  KEY `fk_quotes_users_idx` (`users_user_id`),
  CONSTRAINT `fk_quotes_users` FOREIGN KEY (`users_user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotes`
--

LOCK TABLES `quotes` WRITE;
/*!40000 ALTER TABLE `quotes` DISABLE KEYS */;
INSERT INTO `quotes` VALUES (5,'The Terminator','I\'ll be back!',9,'2016-07-22 12:16:12','2016-07-22 12:16:12'),(6,'The Terminator','I\'ll be back!',9,'2016-07-22 12:16:37','2016-07-22 12:16:37'),(7,'Mel Gibson','They may take our lives but they\'ll never take our freedom!',9,'2016-07-22 12:17:52','2016-07-22 12:17:52'),(8,'Barak Ben-David','Food is the most important meal of the day :)',9,'2016-07-22 12:18:12','2016-07-22 12:18:12'),(9,'Confucious','Everything has beauty but not everyone sees it',9,'2016-07-22 12:19:06','2016-07-22 12:19:06'),(10,'X Men','Tomorrow is another day',9,'2016-07-22 13:05:46','2016-07-22 13:05:46'),(11,'Superman','Up up and away!',4,'2016-07-22 13:07:19','2016-07-22 13:07:19'),(12,'Confucious','Eat Half, Run Twice, Smile Infinity',10,'2016-07-22 14:57:53','2016-07-22 14:57:53'),(13,'Me','Hahahahha',4,'2016-07-22 14:58:44','2016-07-22 14:58:44'),(14,'hhhhhhh','sdfsdfDFSgDSFFGadfgDFggDFSgFDs',11,'2016-07-31 21:52:04','2016-07-31 21:52:04');
/*!40000 ALTER TABLE `quotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `email` varchar(255) NOT NULL,
  `pw_hash` varchar(255) NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'Donald','Duck','0000-00-00 00:00:00','donald@duck.com','$2b$12$y7i8/kdZtrxHCRYCDAVsFOwH1Lw.jOZQA7opyGSpf/czFWWw/Z0eK','2016-07-22 11:47:08','2016-07-22 11:47:08'),(5,'Mickey','Mouse','0000-00-00 00:00:00','mickey@mouse.com','$2b$12$rKkGMsnHdXscsZc.zDIES.ndZMS6F3kpiXUGVYSksDQwyUxwtZxO2','2016-07-22 11:49:50','2016-07-22 11:49:50'),(6,'Scooby','Doo','0000-00-00 00:00:00','scooby@doo.com','$2b$12$ULi5BR7l8sdKU.zH0OC9Z.E9CwbFM/d3blRfFt/G39OcUNrnDhdQq','2016-07-22 11:51:07','2016-07-22 11:51:07'),(7,'Bugs','Bunny','0000-00-00 00:00:00','bugs@bunny.com','$2b$12$0L57TkMiKbRM1uxPQjVN9OAyW7WY0bfMg7vaZskqGW7exi/Rl725.','2016-07-22 11:51:50','2016-07-22 11:51:50'),(8,'Fred','Flinstone','0000-00-00 00:00:00','fred@flinstone.com','$2b$12$wktckSp2XT9Gn75w3PyYUOm.KYWkT1D5vEj.0Cmoq/d2BOpeuz/u6','2016-07-22 11:52:33','2016-07-22 11:52:33'),(9,'Eric','Cartman','0000-00-00 00:00:00','eric@cartman.com','$2b$12$mH8Wxe4yPmrLdbN0riFV/eeq.hNLj3M3rTX93LoyzGDiYrQGMjCkC','2016-07-22 11:53:32','2016-07-22 11:53:32'),(10,'sdfsdfsdf','sfsfd','0000-00-00 00:00:00','bob@sponge.com','$2b$12$Pat9eMvfbEsorYt6cTA/Y.5aED2667aTL2GV.X4YxhVZmkJdTfZg2','2016-07-22 14:57:11','2016-07-22 14:57:11'),(11,'WInnie','Poo','0000-00-00 00:00:00','winnie@poo.com','$2b$12$4HiLN3nt4Tk2605KnoItP.tXCKTgbjJDY9Y0cNvQGCzywinlI4gRm','2016-07-31 21:17:14','2016-07-31 21:17:14');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-01 21:35:49
