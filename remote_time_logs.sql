-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: remote
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `time_logs`
--

DROP TABLE IF EXISTS `time_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `hours_worked` decimal(4,2) DEFAULT NULL,
  `tasks_completed` int DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY ` employee_idk_idx` (`employee_id`),
  KEY `project_idf_idx` (`project_id`),
  CONSTRAINT ` employee_idk` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `project_idf` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_logs`
--

LOCK TABLES `time_logs` WRITE;
/*!40000 ALTER TABLE `time_logs` DISABLE KEYS */;
INSERT INTO `time_logs` VALUES (1,100,1,'2025-02-01',9.76,2,'2025-04-24 13:42:44'),(2,101,1,'2025-02-01',8.00,2,'2025-04-24 12:27:50'),(3,105,2,'2025-02-02',9.00,0,'2025-04-24 12:27:50'),(4,106,2,'2025-02-02',5.25,1,'2025-04-24 12:27:50'),(5,109,3,'2025-02-03',9.50,1,'2025-04-24 12:27:50'),(6,110,3,'2025-02-03',4.00,1,'2025-04-24 12:27:50'),(7,113,4,'2025-02-04',8.00,0,'2025-04-24 12:27:50'),(8,114,4,'2025-02-04',6.75,1,'2025-04-24 12:27:50'),(9,109,1,'2025-04-25',10.50,0,'2025-04-24 14:05:24'),(10,110,4,'2025-04-24',7.35,6,'2025-04-27 18:56:11'),(11,110,2,'2025-04-04',7.35,6,'2025-04-27 18:56:17'),(12,102,3,'2025-03-14',2.40,4,'2025-04-27 18:56:17'),(13,108,3,'2025-01-06',3.79,3,'2025-04-27 18:56:17'),(14,103,2,'2025-04-12',14.40,2,'2025-04-27 18:56:17'),(15,112,3,'2025-03-11',5.05,2,'2025-04-27 18:56:17'),(16,100,3,'2025-03-18',13.00,4,'2025-04-27 18:56:17'),(25,110,1,'2025-04-27',1.00,0,'2025-04-27 18:36:17'),(26,107,1,'2025-04-27',11.20,1,'2025-04-27 18:44:39'),(27,111,3,'2025-04-12',20.00,1,'2025-04-27 19:01:06'),(28,106,2,'2025-02-14',2.00,0,'2025-04-27 19:01:06'),(29,109,4,'2025-03-15',6.13,2,'2025-04-27 19:01:06'),(30,105,2,'2025-01-23',1.23,0,'2025-04-27 19:01:06'),(31,112,2,'2025-04-27',12.20,1,'2025-04-27 19:02:50'),(32,114,3,'2025-04-27',23.20,0,'2025-04-27 19:03:36'),(33,106,3,'2025-04-27',1.45,0,'2025-04-27 19:04:44');
/*!40000 ALTER TABLE `time_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_overwork_alert` AFTER INSERT ON `time_logs` FOR EACH ROW BEGIN
IF NEW.hours_worked >= 10 AND NEW.tasks_completed<=1 THEN INSERT INTO alerts(employee_id,alert_type)
VALUES(NEW.employee_id,'Overworked: 10+ hours, LOW tasks');
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_low_productivity_alert` AFTER INSERT ON `time_logs` FOR EACH ROW BEGIN IF (NEW.hours_worked<2)AND(NEW.tasks_completed=0)THEN
INSERT INTO alerts(employee_id,alert_type,alert_time)
VALUES (NEW.employee_id,'Low Productivity:<2 hours,0 tasks',NOW());
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_time_logs_update` AFTER UPDATE ON `time_logs` FOR EACH ROW BEGIN 
DECLARE msg TEXT;
SET msg=CONCAT('Time log updated on', NOW(),':','Hours from', OLD.hours_worked,'to',NEW.hours_worked,
'Tasks from', OLD.tasks_completed,'to', NEW.tasks_completed);
INSERT INTO alerts(employee_id, alert_type)
VALUES (NEW. employee_id,msg);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-28  9:39:16
