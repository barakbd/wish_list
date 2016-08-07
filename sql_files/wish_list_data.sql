-- MySQL dump 10.13  Distrib 5.6.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: wish_list
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
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `users_user_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_items_users1_idx` (`users_user_id`),
  CONSTRAINT `fk_items_users1` FOREIGN KEY (`users_user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Yacht','2016-08-07 14:40:53','2016-08-07 14:40:53',3),(2,'Dinosaur','2016-08-07 15:07:35','2016-08-07 15:07:35',3),(5,'Carrots','2016-08-07 15:08:43','2016-08-07 15:08:43',2),(6,'Tea','2016-08-07 16:18:45','2016-08-07 16:18:45',1),(8,'Honey','2016-08-07 16:20:34','2016-08-07 16:20:34',4);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Scooby','Doo','0000-00-00 00:00:00','scooby@doo.com','$2b$12$fGv3YJLtqM9V1FGc8TstZO5Lq6B7FCcT6dyLJ8JRMkSLqrZRRa8bS','2016-08-07 13:53:58','2016-08-07 13:53:58'),(2,'Donald','Duck','0000-00-00 00:00:00','donald@duck.com','$2b$12$Nc0uGnKOgjD5hNYldDhZOOrYVDE73S6Hf9xKHxha.2fwgnr8KEcP6','2016-08-07 14:10:25','2016-08-07 14:10:25'),(3,'Mickey','Mouse','0000-00-00 00:00:00','mickey@mouse.com','$2b$12$gZ2PTEQjT5Gr2FuDVOu.NOapIq3eOiRzJJX.GpYTphEhrKXXztr4e','2016-08-07 14:11:04','2016-08-07 14:11:04'),(4,'Winnie','Poo','0000-00-00 00:00:00','winnie@poo.com','$2b$12$7r8hTsL/aGMYxL7n4ug0MeD2rOzQXC5uI0H2sg0PnTuk4ORkJhBRi','2016-08-07 16:20:24','2016-08-07 16:20:24');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wish_list`
--

DROP TABLE IF EXISTS `wish_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wish_list` (
  `users_user_id` int(11) NOT NULL,
  `items_item_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  KEY `fk_favourites_users1_idx` (`users_user_id`),
  KEY `fk_favourites_items1_idx` (`items_item_id`),
  CONSTRAINT `fk_favourites_items1` FOREIGN KEY (`items_item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_favourites_users1` FOREIGN KEY (`users_user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wish_list`
--

LOCK TABLES `wish_list` WRITE;
/*!40000 ALTER TABLE `wish_list` DISABLE KEYS */;
INSERT INTO `wish_list` VALUES (2,5,'2016-08-07 15:34:10'),(3,2,'2016-08-07 15:57:20'),(3,1,'2016-08-07 15:57:21'),(1,5,'2016-08-07 16:01:12'),(1,6,'2016-08-07 16:18:45'),(3,6,'2016-08-07 16:19:26'),(4,6,'2016-08-07 16:20:26'),(4,5,'2016-08-07 16:20:27'),(4,8,'2016-08-07 16:20:34');
/*!40000 ALTER TABLE `wish_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-07 16:26:19
