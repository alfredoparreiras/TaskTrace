-- MySQL dump 10.13  Distrib 8.1.0, for macos14.0 (arm64)
--
-- Host: localhost    Database: TaskTrace
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
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (1,'work'),(2,'personal'),(3,'health&fitness'),(4,'shopping'),(5,'finance'),(6,'social'),(7,'education'),(8,'travel'),(9,'hobbies');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task`
--

DROP TABLE IF EXISTS `Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Task` (
  `id` varchar(36) NOT NULL,
  `title` varchar(25) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `priority` varchar(25) DEFAULT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_done` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Task_User_id_fk` (`user_id`),
  CONSTRAINT `Task_User_id_fk` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task`
--

LOCK TABLES `Task` WRITE;
/*!40000 ALTER TABLE `Task` DISABLE KEYS */;
/*!40000 ALTER TABLE `Task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskCategories`
--

DROP TABLE IF EXISTS `TaskCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TaskCategories` (
  `category_id` int NOT NULL,
  `task_id` varchar(36) NOT NULL,
  PRIMARY KEY (`task_id`,`category_id`),
  KEY `TaskCategories_Category_id_fk` (`category_id`),
  CONSTRAINT `TaskCategories_Category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TaskCategories_Task_id_fk` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaskCategories`
--

LOCK TABLES `TaskCategories` WRITE;
/*!40000 ALTER TABLE `TaskCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `TaskCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(55) NOT NULL,
  `last_name` varchar(55) NOT NULL,
  `password` varchar(64) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_pk` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Alfredo','Silva','admin','a.alfredops@gmail.com', CURRENT_TIMESTAMP);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-06 15:00:36
