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
-- Temporary view structure for view `recent_time_logs`
--

DROP TABLE IF EXISTS `recent_time_logs`;
/*!50001 DROP VIEW IF EXISTS `recent_time_logs`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `recent_time_logs` AS SELECT 
 1 AS `log_id`,
 1 AS `employee_name`,
 1 AS `project_id`,
 1 AS `date`,
 1 AS `hours_worked`,
 1 AS `tasks_completed`,
 1 AS `last_modified`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `project_overview`
--

DROP TABLE IF EXISTS `project_overview`;
/*!50001 DROP VIEW IF EXISTS `project_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `project_overview` AS SELECT 
 1 AS `project_id`,
 1 AS `project_name`,
 1 AS `created_by`,
 1 AS `deadline`,
 1 AS `team_members`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employee_productivity_summary`
--

DROP TABLE IF EXISTS `employee_productivity_summary`;
/*!50001 DROP VIEW IF EXISTS `employee_productivity_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `employee_productivity_summary` AS SELECT 
 1 AS `employee_id`,
 1 AS `full_name`,
 1 AS `department_name`,
 1 AS `total_hours`,
 1 AS `total_tasks`,
 1 AS `productivity_score`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `department_productivity`
--

DROP TABLE IF EXISTS `department_productivity`;
/*!50001 DROP VIEW IF EXISTS `department_productivity`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `department_productivity` AS SELECT 
 1 AS `department_name`,
 1 AS `total_employees`,
 1 AS `total_hours`,
 1 AS `total_tasks`,
 1 AS `department_score`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `recent_time_logs`
--

/*!50001 DROP VIEW IF EXISTS `recent_time_logs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `recent_time_logs` AS select `tl`.`log_id` AS `log_id`,concat(`e`.`first_name`,' ',`e`.`last_name`) AS `employee_name`,`tl`.`project_id` AS `project_id`,`tl`.`date` AS `date`,`tl`.`hours_worked` AS `hours_worked`,`tl`.`tasks_completed` AS `tasks_completed`,`tl`.`last_modified` AS `last_modified` from (`time_logs` `tl` join `employee` `e` on((`tl`.`employee_id` = `e`.`employee_id`))) order by `tl`.`date` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `project_overview`
--

/*!50001 DROP VIEW IF EXISTS `project_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `project_overview` AS select `p`.`project_id` AS `project_id`,`p`.`project_name` AS `project_name`,concat(`e`.`first_name`,' ',`e`.`last_name`) AS `created_by`,`p`.`deadline` AS `deadline`,count(distinct `ep`.`employee_id`) AS `team_members` from ((`project` `p` join `employee` `e` on((`p`.`employee_id` = `e`.`employee_id`))) left join `employee_project` `ep` on((`p`.`project_id` = `ep`.`project_id`))) group by `p`.`project_id`,`p`.`project_name`,`created_by`,`p`.`deadline` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employee_productivity_summary`
--

/*!50001 DROP VIEW IF EXISTS `employee_productivity_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employee_productivity_summary` AS select `e`.`employee_id` AS `employee_id`,concat(`e`.`first_name`,' ',`e`.`last_name`) AS `full_name`,`d`.`department_name` AS `department_name`,coalesce(sum(`t`.`hours_worked`),0) AS `total_hours`,coalesce(sum(`t`.`tasks_completed`),0) AS `total_tasks`,round((coalesce(sum(`t`.`hours_worked`),0) + (coalesce(sum(`t`.`tasks_completed`),0) * 1.5)),2) AS `productivity_score`,(case when ((coalesce(sum(`t`.`hours_worked`),0) >= 8) and (coalesce(sum(`t`.`tasks_completed`),0) = 0)) then 'Overworked' when ((coalesce(sum(`t`.`hours_worked`),0) + (coalesce(sum(`t`.`tasks_completed`),0) * 1.5)) >= 8) then 'Productive' when ((coalesce(sum(`t`.`hours_worked`),0) + (coalesce(sum(`t`.`tasks_completed`),0) * 1.5)) < 5) then 'Underperforming' else 'Average' end) AS `status` from ((`employee` `e` join `department` `d` on((`e`.`department_id` = `d`.`department_id`))) left join `time_logs` `t` on((`e`.`employee_id` = `t`.`employee_id`))) group by `e`.`employee_id`,`e`.`first_name`,`e`.`last_name`,`d`.`department_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `department_productivity`
--

/*!50001 DROP VIEW IF EXISTS `department_productivity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `department_productivity` AS select `d`.`department_name` AS `department_name`,count(distinct `e`.`employee_id`) AS `total_employees`,round(sum(`t`.`hours_worked`),2) AS `total_hours`,sum(`t`.`tasks_completed`) AS `total_tasks`,round((sum(`t`.`hours_worked`) + (sum(`t`.`tasks_completed`) * 1.5)),2) AS `department_score` from ((`department` `d` join `employee` `e` on((`d`.`department_id` = `e`.`department_id`))) left join `time_logs` `t` on((`e`.`employee_id` = `t`.`employee_id`))) group by `d`.`department_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-28  9:39:18
