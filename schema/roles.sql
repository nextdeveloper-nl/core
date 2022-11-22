-- MySQL dump 10.13  Distrib 8.0.30, for Linux (x86_64)
--
-- Host: 10.100.0.105    Database: plusclouds_v3
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'YwQPmvKr','super-admin','PlusClouds Super Admin',100,1,5,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(2,'XAQOMdJq','admin','PlusClouds Admin',99,1,5,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(3,'lVLYrQrA','accountant','Accountant',91,0,5,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(4,'rxQqxLEk','supporter','Support Engineer',75,0,5,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(5,'vyGLGyNo','vendor','Vendor',10,1,NULL,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(6,'RPLbOQGK','reseller','Reseller',5,1,NULL,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(7,'ybQZRQWR','dealer','Dealer',4,1,NULL,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(8,'AlvzYQKW','tester','Tester',2,0,NULL,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(9,'xXLgrdoM','member','Member',1,0,NULL,'2018-03-28 11:32:15','2018-03-28 11:32:15'),(12,'GBQEWdAX','plusclouds-sales-manager','PlusClouds Sales Manager',90,1,5,'2018-06-27 16:09:07','2018-06-27 16:09:07'),(13,'MeQXYvPa','sales-manager','Sales Manager',10,0,NULL,'2018-06-27 16:10:34','2018-06-27 16:10:34'),(14,'rPLrpvNJ','sales-person','Sales Person',9,0,5,'2018-06-27 16:10:34','2018-06-27 16:10:34'),(15,'nWvkgvop','plusclouds-marketing-manager','PlusClouds Marketing Manager',90,1,5,'2018-06-27 16:10:35','2018-06-27 16:10:35'),(16,'DpvBNvOe','marketing-manager','Marketing Manager',10,0,NULL,'2018-06-27 16:10:35','2018-06-27 16:10:35'),(17,'ywvaYvjl','marketing-person','Marketing Person',9,0,NULL,'2018-06-27 16:10:36','2018-06-27 16:10:36'),(21,'MgLoOLlX','account-owner','Account Owner',1,0,NULL,'2018-11-13 08:56:19','2018-11-13 08:56:19'),(22,'WBdAYdeM','web-master','Web Master',50,1,5,'2020-12-30 05:44:12','2020-12-30 05:44:12');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-28 13:54:34
