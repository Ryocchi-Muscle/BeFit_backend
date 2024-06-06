-- MySQL dump 10.13  Distrib 8.1.0, for macos13.3 (arm64)
--
-- Host: localhost    Database: fitapp_api_development
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2024-05-05 02:50:45.569465','2024-05-05 02:50:45.569465'),('schema_sha1','4b1c0ae0e8b8a576c8b12b9a6d7b4538f11633ac','2024-05-05 02:50:45.595708','2024-05-05 02:50:45.595708');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_programs`
--

DROP TABLE IF EXISTS `daily_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_programs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `details` json DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `program_bundle_id` bigint NOT NULL,
  `week` int NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `day` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_daily_programs_on_program_bundle_id` (`program_bundle_id`),
  CONSTRAINT `fk_daily_programs_program_bundles_custom` FOREIGN KEY (`program_bundle_id`) REFERENCES `program_bundles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_programs`
--

LOCK TABLES `daily_programs` WRITE;
/*!40000 ALTER TABLE `daily_programs` DISABLE KEYS */;
INSERT INTO `daily_programs` VALUES (46,'\"{\\\"menu\\\":\\\"スクワット\\\",\\\"set_info\\\":\\\"10回3セット インターバル3分\\\"}\"','2024-06-06 00:51:58.966623','2024-06-06 00:51:58.966623',62,1,0,1);
/*!40000 ALTER TABLE `daily_programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_bundles`
--

DROP TABLE IF EXISTS `program_bundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_bundles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `gender` varchar(255) DEFAULT NULL,
  `frequency` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `duration` int NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_program_bundles_users_custom` (`user_id`),
  CONSTRAINT `fk_program_bundles_users_custom` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_bundles`
--

LOCK TABLES `program_bundles` WRITE;
/*!40000 ALTER TABLE `program_bundles` DISABLE KEYS */;
INSERT INTO `program_bundles` VALUES (57,'male','weekly','2024-06-05 21:22:37.000000','2024-06-05 21:22:37.000000',12,NULL),(58,'male','weekly','2024-06-05 21:26:13.000000','2024-06-05 21:26:13.000000',12,NULL),(62,'male','2','2024-06-06 00:51:58.955853','2024-06-06 00:51:58.955853',6,NULL);
/*!40000 ALTER TABLE `program_bundles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20240320080331'),('20240322070041'),('20240327021556'),('20240327021721'),('20240327022004'),('20240327022240'),('20240327022635'),('20240401021604'),('20240403120728'),('20240403120817'),('20240403120946'),('20240403122750'),('20240403123003'),('20240403130016'),('20240407054206'),('20240409125136'),('20240409125257'),('20240409130216'),('20240410122236'),('20240412005822'),('20240422015156'),('20240502130813'),('20240505073614'),('20240519090200'),('20240519091435'),('20240519091505'),('20240519092552'),('20240519092609'),('20240519092906'),('20240519092925'),('20240528044309'),('20240528051424'),('20240528052708'),('20240531090854'),('20240531091304'),('20240601021002'),('20240602012512'),('20240602020201'),('20240602020802'),('20240602102721'),('20240602111419'),('20240604123547'),('20240604220619'),('20240605114816'),('20240605120839'),('20240605121549'),('20240605121651'),('20240605122744'),('20240605122801'),('20240606012939'),('20240606020438'),('20240606025046'),('20240606065524'),('20240606065545'),('20240606065633'),('20240606071157'),('20240606073333'),('20240606080401'),('20240606085628'),('20240606105418');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_days`
--

DROP TABLE IF EXISTS `training_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_days` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_training_days_on_user_id_and_date` (`user_id`,`date`),
  KEY `index_training_days_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_a5d156f0f9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_days`
--

LOCK TABLES `training_days` WRITE;
/*!40000 ALTER TABLE `training_days` DISABLE KEYS */;
INSERT INTO `training_days` VALUES (21,4,'2024-05-02','2024-05-19 10:40:12.269431','2024-05-19 10:40:12.269431'),(22,4,'2024-05-22','2024-05-21 02:50:53.391452','2024-05-21 02:50:53.391452'),(23,4,'2024-05-28','2024-05-21 02:51:08.040546','2024-05-21 02:51:08.040546'),(24,4,'2024-05-25','2024-05-25 07:03:02.266048','2024-05-25 07:03:02.266048'),(25,4,'2024-05-09','2024-05-28 09:19:58.316127','2024-05-28 09:19:58.316127'),(29,5,'2024-05-29','2024-05-29 01:01:03.132328','2024-05-29 01:01:03.132328');
/*!40000 ALTER TABLE `training_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_menus`
--

DROP TABLE IF EXISTS `training_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_menus` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body_part` varchar(255) DEFAULT NULL,
  `exercise_name` varchar(255) DEFAULT NULL,
  `training_day_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `set_info` varchar(255) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL,
  `daily_program_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_training_menus_on_training_day_id` (`training_day_id`),
  CONSTRAINT `fk_rails_f9fde505d3` FOREIGN KEY (`training_day_id`) REFERENCES `training_days` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_menus`
--

LOCK TABLES `training_menus` WRITE;
/*!40000 ALTER TABLE `training_menus` DISABLE KEYS */;
INSERT INTO `training_menus` VALUES (247,'胸','っっd',21,'2024-05-19 10:40:12.300584','2024-05-19 10:40:12.300584',NULL,NULL,0),(253,'腕','プリチャーカール',24,'2024-05-25 07:17:20.949443','2024-05-25 07:17:20.949443',NULL,NULL,0),(254,'胸','あああ',25,'2024-05-28 09:19:58.326277','2024-05-28 09:19:58.326277',NULL,NULL,0),(256,'胸','ss',29,'2024-05-29 01:01:03.140513','2024-05-29 01:01:03.140513',NULL,NULL,0);
/*!40000 ALTER TABLE `training_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_sessions`
--

DROP TABLE IF EXISTS `training_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_sessions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `start_date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_training_sessions_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_sessions`
--

LOCK TABLES `training_sessions` WRITE;
/*!40000 ALTER TABLE `training_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `training_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_sets`
--

DROP TABLE IF EXISTS `training_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `training_sets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `set_number` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `completed` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `training_menu_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_training_sets_on_training_menu_id` (`training_menu_id`),
  CONSTRAINT `fk_rails_2f0451ed8b` FOREIGN KEY (`training_menu_id`) REFERENCES `training_menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_sets`
--

LOCK TABLES `training_sets` WRITE;
/*!40000 ALTER TABLE `training_sets` DISABLE KEYS */;
INSERT INTO `training_sets` VALUES (344,1,20,15,1,'2024-05-25 07:17:20.957417','2024-05-25 07:17:20.957417',253),(345,2,30,15,1,'2024-05-25 07:17:20.961947','2024-05-25 07:17:20.961947',253),(346,3,40,7,1,'2024-05-25 07:17:20.967648','2024-05-25 07:17:20.967648',253),(347,4,40,5,1,'2024-05-25 07:17:20.974117','2024-05-25 07:17:20.974117',253),(348,1,20,20,0,'2024-05-28 09:19:58.335606','2024-05-28 09:19:58.335606',254),(349,1,22,22,1,'2024-05-29 01:01:03.147459','2024-05-29 01:01:03.147459',256);
/*!40000 ALTER TABLE `training_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'Test User',NULL,'2024-06-05 21:22:19.000000','2024-06-05 21:22:19.000000'),(4,'106328513442892547365','Ryo Ninomiya','google','2024-05-19 10:39:51.073699','2024-05-19 10:39:51.073699'),(5,'110446993639298212985','Ryo Ninomiya','google','2024-05-29 00:59:23.586477','2024-05-29 00:59:23.586477');
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

-- Dump completed on 2024-06-06 20:20:36
