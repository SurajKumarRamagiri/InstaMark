-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: instamark
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `attendance_attendance`
--

DROP TABLE IF EXISTS `attendance_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `department_id` int DEFAULT NULL,
  `department_name` varchar(100) NOT NULL,
  `fullname` varchar(150) NOT NULL,
  `check_in_time` time(6) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `user_profile_id` int DEFAULT NULL,
  `username` varchar(150) DEFAULT NULL,
  `check_out_time` time(6) DEFAULT NULL,
  `late` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_attendance`
--

LOCK TABLES `attendance_attendance` WRITE;
/*!40000 ALTER TABLE `attendance_attendance` DISABLE KEYS */;
INSERT INTO `attendance_attendance` VALUES (1,'2024-12-27','Present',2,'CSD','suraj kumar','22:01:45.555455',NULL,3,'user','23:15:02.839473',0),(2,'2024-12-28','Present',2,'CSD','suraj kumar','00:43:51.132861',NULL,3,'user','00:57:42.614606',0),(4,'2024-12-28','Absent',2,'CSD','abhinav',NULL,NULL,46,'user3',NULL,0),(6,'2024-12-28','Absent',2,'CSD','user 6',NULL,NULL,50,'user6',NULL,0),(8,'2024-12-28','Absent',2,'CSD','suhas Akkenapally','15:09:43.607641',NULL,52,'suhas_09',NULL,0),(9,'2024-12-28','Half Present',2,'CSD','user 10','15:51:51.420543',NULL,53,'user10','15:55:54.335248',0),(10,'2024-12-29','Present',2,'CSD','suraj kumar','20:35:36.834725',NULL,3,'user','22:25:55.601171',0),(11,'2024-12-29','Absent',2,'CSD','user 10','22:26:07.569192',NULL,53,'user10',NULL,0),(19,'2024-12-30','Present',2,'CSD','suraj kumar','03:47:13.297012',NULL,3,'user','10:44:08.655152',0);
/*!40000 ALTER TABLE `attendance_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add department',1,'add_department'),(2,'Can change department',1,'change_department'),(3,'Can delete department',1,'delete_department'),(4,'Can view department',1,'view_department'),(5,'Can add profile',2,'add_profile'),(6,'Can change profile',2,'change_profile'),(7,'Can delete profile',2,'delete_profile'),(8,'Can view profile',2,'view_profile'),(9,'Can add log entry',3,'add_logentry'),(10,'Can change log entry',3,'change_logentry'),(11,'Can delete log entry',3,'delete_logentry'),(12,'Can view log entry',3,'view_logentry'),(13,'Can add permission',4,'add_permission'),(14,'Can change permission',4,'change_permission'),(15,'Can delete permission',4,'delete_permission'),(16,'Can view permission',4,'view_permission'),(17,'Can add group',5,'add_group'),(18,'Can change group',5,'change_group'),(19,'Can delete group',5,'delete_group'),(20,'Can view group',5,'view_group'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add content type',7,'add_contenttype'),(26,'Can change content type',7,'change_contenttype'),(27,'Can delete content type',7,'delete_contenttype'),(28,'Can view content type',7,'view_contenttype'),(29,'Can add session',8,'add_session'),(30,'Can change session',8,'change_session'),(31,'Can delete session',8,'delete_session'),(32,'Can view session',8,'view_session'),(33,'Can add attendance',9,'add_attendance'),(34,'Can change attendance',9,'change_attendance'),(35,'Can delete attendance',9,'delete_attendance'),(36,'Can view attendance',9,'view_attendance'),(37,'Can add System Setting',10,'add_systemsettings'),(38,'Can change System Setting',10,'change_systemsettings'),(39,'Can delete System Setting',10,'delete_systemsettings'),(40,'Can view System Setting',10,'view_systemsettings');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$62uG03ZLDUZZPi4vqIEQkE$usBxEnaPR6CdTOifUgsdNPGPwmUjpz3x6rHj6zv5VHw=','2024-12-30 03:21:38.530041',1,'admin','me','','admin@gmail.com',1,1,'2024-12-18 05:46:39.000000'),(2,'pbkdf2_sha256$870000$yMxBDGUCOlS6Hg4C3g5nnz$AEdD8P++S+FR/VfzHmfgpfuTm5TLFpWYFRHMyoKC8dg=','2024-12-30 01:17:26.594796',0,'manager','manager','','manager@gmail.com',0,1,'2024-12-18 05:52:37.003534'),(3,'pbkdf2_sha256$870000$wstSba1v1EnomCfI9bzaCF$elIoW7NuolMnH3M1Nx7rEjV6isbLAJVzDdsbZRbJi9A=','2024-12-30 01:26:01.066365',0,'user','suraj','kumar','jarvis22112022@gmail.com',0,1,'2024-12-18 05:59:06.780451'),(50,'pbkdf2_sha256$870000$7msKFjHqBFUxWyafocEPRO$kAToGOf1AhgonPCq1M0DQibr/UccsdGC3p/Ep8NwQBQ=',NULL,0,'user3','abhinav','','user3@gmail.com',0,1,'2024-12-24 06:59:35.227439'),(52,'pbkdf2_sha256$870000$PbUiotNvkWTLoAlAsvnF5h$i6xHFHBm06oVuOzvW48EVNs7WMYBiF8SUwOqQSq9q2M=','2024-12-26 17:36:12.603829',0,'user5','user','5','user5@gmail.com',0,1,'2024-12-26 17:36:12.022157'),(54,'pbkdf2_sha256$870000$Hv0uRLwR5fMjwj39NKlLme$ZH1GMTun+QswnruwsCEfOrARwoKVZgk3DoocSrFW6Vs=','2024-12-27 23:50:55.854082',0,'user6','user','6','user6@gmail.com',0,1,'2024-12-27 23:49:56.704713'),(56,'pbkdf2_sha256$870000$W02LG4rv7v1EdR1IjS2d5X$onn4KgpfmmE/D8nZtKF5cD+9TiD2fJPsMxhU78AienY=',NULL,0,'suhas_09','suhas','Akkenapally','suhas@gmail.com',0,1,'2024-12-28 14:50:44.047083'),(57,'pbkdf2_sha256$870000$giZTqL2ExIa2KEFcY66mi1$VBASBXC012v4jXpy5ll4r5VwBnWIG+G6C1zO2nraLq4=','2024-12-28 15:56:40.490996',0,'user10','user','10','user10@gmail.com',0,1,'2024-12-28 15:48:22.204873');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-12-18 05:51:20.902397','1','admin',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',2,1),(2,'2024-12-18 05:51:28.312574','1','admin',2,'[]',2,1),(3,'2024-12-18 06:05:21.096994','4','user2',3,'',6,1),(4,'2024-12-18 06:05:21.096994','5','user3',3,'',6,1),(5,'2024-12-18 06:05:53.719103','2','manager',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',2,1),(6,'2024-12-18 06:37:22.724160','3','user',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',2,1),(7,'2024-12-18 06:37:26.769721','1','admin',2,'[]',2,1),(8,'2024-12-18 06:37:30.371376','2','manager',2,'[]',2,1),(9,'2024-12-18 07:20:18.847503','6','user2',3,'',6,1),(10,'2024-12-18 07:20:18.847503','7','user3',3,'',6,1),(11,'2024-12-18 07:20:18.847503','8','user4',3,'',6,1),(12,'2024-12-18 10:24:27.505223','1','CSE',1,'[{\"added\": {}}]',1,1),(13,'2024-12-18 10:24:38.472488','2','CSD',1,'[{\"added\": {}}]',1,1),(14,'2024-12-18 10:34:06.773562','3','CSM',1,'[{\"added\": {}}]',1,1),(15,'2024-12-20 13:27:37.753986','3','user',2,'[{\"changed\": {\"fields\": [\"Department\"]}}]',2,1),(16,'2024-12-20 13:28:04.160658','10','user2',1,'[{\"added\": {}}]',6,1),(17,'2024-12-20 13:28:20.946730','11','user3',1,'[{\"added\": {}}]',6,1),(18,'2024-12-20 13:28:37.404813','12','user4',1,'[{\"added\": {}}]',6,1),(19,'2024-12-20 13:28:50.166934','3','user',2,'[]',2,1),(20,'2024-12-20 13:29:03.992073','10','user2',2,'[{\"changed\": {\"fields\": [\"Department\", \"Role\"]}}]',2,1),(21,'2024-12-20 13:29:13.954170','11','user3',2,'[{\"changed\": {\"fields\": [\"Department\", \"Role\"]}}]',2,1),(22,'2024-12-20 13:29:28.820670','12','user4',2,'[{\"changed\": {\"fields\": [\"Department\", \"Role\"]}}]',2,1),(23,'2024-12-23 08:35:32.441039','1','admin1',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',6,1),(24,'2024-12-23 08:38:25.256378','1','admin',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',6,1),(25,'2024-12-23 08:57:59.385701','49','admin2',1,'[{\"added\": {}}]',6,1),(26,'2024-12-23 08:58:13.333838','49','admin2',2,'[{\"changed\": {\"fields\": [\"Staff status\", \"Superuser status\"]}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (3,'admin','logentry'),(9,'attendance','attendance'),(5,'auth','group'),(4,'auth','permission'),(6,'auth','user'),(7,'contenttypes','contenttype'),(8,'sessions','session'),(10,'settings','systemsettings'),(1,'users','department'),(2,'users','profile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-18 05:43:20.620052'),(2,'auth','0001_initial','2024-12-18 05:43:22.016526'),(3,'admin','0001_initial','2024-12-18 05:43:22.312067'),(4,'admin','0002_logentry_remove_auto_add','2024-12-18 05:43:22.327521'),(5,'admin','0003_logentry_add_action_flag_choices','2024-12-18 05:43:22.349508'),(6,'contenttypes','0002_remove_content_type_name','2024-12-18 05:43:22.501475'),(7,'auth','0002_alter_permission_name_max_length','2024-12-18 05:43:22.649972'),(8,'auth','0003_alter_user_email_max_length','2024-12-18 05:43:22.691401'),(9,'auth','0004_alter_user_username_opts','2024-12-18 05:43:22.702658'),(10,'auth','0005_alter_user_last_login_null','2024-12-18 05:43:22.834431'),(11,'auth','0006_require_contenttypes_0002','2024-12-18 05:43:22.850149'),(12,'auth','0007_alter_validators_add_error_messages','2024-12-18 05:43:22.867976'),(13,'auth','0008_alter_user_username_max_length','2024-12-18 05:43:23.002029'),(14,'auth','0009_alter_user_last_name_max_length','2024-12-18 05:43:23.134324'),(15,'auth','0010_alter_group_name_max_length','2024-12-18 05:43:23.173907'),(16,'auth','0011_update_proxy_permissions','2024-12-18 05:43:23.195318'),(17,'auth','0012_alter_user_first_name_max_length','2024-12-18 05:43:23.347418'),(18,'sessions','0001_initial','2024-12-18 05:43:23.435699'),(19,'users','0001_initial','2024-12-18 05:45:03.427589'),(20,'users','0002_alter_profile_department','2024-12-18 10:32:09.130475'),(21,'users','0003_profile_face_embedding_alter_profile_user','2024-12-20 18:36:49.669564'),(22,'attendance','0001_initial','2024-12-23 09:58:59.743352'),(23,'attendance','0002_remove_attendance_name_attendance_department_and_more','2024-12-23 13:24:14.716850'),(24,'attendance','0003_alter_attendance_user_profile','2024-12-23 14:11:12.120796'),(25,'attendance','0004_attendance_department_name_attendance_fullname_and_more','2024-12-25 14:55:34.336537'),(26,'attendance','0005_attendance_location','2024-12-25 16:27:59.369861'),(27,'attendance','0006_remove_attendance_percentage','2024-12-27 01:41:43.850495'),(28,'attendance','0007_rename_time_attendance_check_in_time_and_more','2024-12-27 03:53:05.697964'),(29,'attendance','0008_alter_attendance_status','2024-12-27 05:55:21.570664'),(30,'attendance','0009_alter_attendance_status','2024-12-27 05:55:43.501332'),(31,'attendance','0010_attendance_late','2024-12-27 06:11:14.201103'),(32,'attendance','0011_alter_attendance_check_in_time','2024-12-27 09:19:07.632592'),(33,'attendance','0012_alter_attendance_check_in_time','2024-12-27 22:05:01.035081'),(34,'settings','0001_initial','2024-12-29 23:23:17.116478'),(35,'settings','0002_alter_systemsettings_face_recognition_threshold','2024-12-29 23:37:47.122037');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('06e3no05kwpv1t6m6a8ot92od9v1wow3','e30:1tNncV:OeBzijeeKdpqSVRzQMkCgStRPFdC_uuBdCJIdrSs9Do','2025-01-01 06:33:19.326473'),('29rcxofu2td0x9zm01jlo59azpkqvzc0','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNoPd:mhllTLZUazqkEyFQ0yO71rhl8-BY_pEaXbDq7XDbGRw','2025-01-01 07:24:05.560048'),('7dhj1wt12yb0rkwgjqmplkb19udp9dng','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNnG1:HTT5ySSRFVpjiQ5sHXjraoz6xytfE27G8D-5GovZWcc','2025-01-01 06:10:05.015083'),('8aukhrhrskwj2wmo0lxtrawwcffezdu3','e30:1tNnpT:WLIBPouOQ51x5kGzUzeDK5K5jU2MM7SrYEbENOSpKpM','2025-01-01 06:46:43.200173'),('ezminpwjbscubvgcs21r1er6499d39h3','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNpyI:w9a1zwvLo3lrDm4KRk1Uu5Q5k-nSu0ioQ_tDFcdrCfw','2025-01-01 09:03:58.307757'),('llz7dwifjcg4tea0jgmpiowokcor2kqm','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tS1CE:v-QZU2NkMuYD-qz2Mu3QyaBE9y43N58sbX1hkL1ZYtg','2025-01-13 03:21:38.544464'),('m04x8dmuvrmwyvomojk2mo5ggyw6fj5w','e30:1tNnuf:6i5gBYTOHzcxpwiq9Ad6R0S1_UJexWGfDnS79iA2NQg','2025-01-01 06:52:05.649095'),('pc0yiwnt1dq12rbvksunnare0piniryk','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tPH89:QhyT_zeSsEH4-I-tl1eXzNQYgoBb4OmexSegADsDwCg','2025-01-05 08:16:05.017853');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings_systemsettings`
--

DROP TABLE IF EXISTS `settings_systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings_systemsettings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attendance_time_limit` int unsigned NOT NULL,
  `face_recognition_threshold` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `settings_systemsettings_chk_1` CHECK ((`attendance_time_limit` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings_systemsettings`
--

LOCK TABLES `settings_systemsettings` WRITE;
/*!40000 ALTER TABLE `settings_systemsettings` DISABLE KEYS */;
INSERT INTO `settings_systemsettings` VALUES (1,1,0.6);
/*!40000 ALTER TABLE `settings_systemsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_department`
--

DROP TABLE IF EXISTS `users_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_department` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_department`
--

LOCK TABLES `users_department` WRITE;
/*!40000 ALTER TABLE `users_department` DISABLE KEYS */;
INSERT INTO `users_department` VALUES (2,'CSD'),(1,'CSE');
/*!40000 ALTER TABLE `users_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_profile`
--

DROP TABLE IF EXISTS `users_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(50) NOT NULL,
  `department_id` bigint DEFAULT NULL,
  `user_id` int NOT NULL,
  `face_embedding` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `users_profile_department_id_c65780ab_fk_users_department_id` (`department_id`),
  CONSTRAINT `users_profile_department_id_c65780ab_fk_users_department_id` FOREIGN KEY (`department_id`) REFERENCES `users_department` (`id`),
  CONSTRAINT `users_profile_user_id_2112e78d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_profile`
--

LOCK TABLES `users_profile` WRITE;
/*!40000 ALTER TABLE `users_profile` DISABLE KEYS */;
INSERT INTO `users_profile` VALUES (1,'superuser',1,1,NULL),(2,'staff',2,2,NULL),(3,'regular',2,3,'[-0.2029233276844025, 0.13178515434265137, 0.069699726998806, 0.003568981308490038, 0.08178863674402237, -0.06657876819372177, 0.045001063495874405, -0.08721011877059937, 0.1986222267150879, -0.08775223791599274, 0.20380249619483948, -0.024549487978219982, -0.1404927223920822, -0.161812886595726, 0.07085675001144409, 0.11296366155147552, -0.17194752395153046, -0.1669589877128601, -0.09165696054697035, -0.0942189395427704, 0.06605075299739838, -0.0011917233932763338, -0.016236666589975357, 0.019258519634604458, -0.1866970658302307, -0.3258955478668213, -0.05480644851922989, -0.1241932287812233, 0.03459779918193817, -0.1059987023472786, -0.03249946981668472, -0.01468303706496954, -0.25747084617614746, -0.05670800432562828, -0.07419177889823914, 0.0938425213098526, 0.04664463549852371, 0.04072277992963791, 0.1025475561618805, -0.01976078748703003, -0.18406274914741516, -0.0015912428498268127, 0.05829186737537384, 0.20859135687351227, 0.203487291932106, 0.05140039324760437, -0.0512385368347168, -0.000652700662612915, 0.038975827395915985, -0.24323156476020813, 0.02896473929286003, 0.097959965467453, 0.08366841077804565, 0.06469234079122543, 0.06468625366687775, -0.145903542637825, -0.031929485499858856, 0.010828647762537004, -0.1772860288619995, 0.07558036595582962, 0.037437353283166885, -0.11691299080848694, -0.07668545097112656, 0.06125513091683388, 0.19337011873722076, 0.09124602377414703, -0.10058804601430892, -0.056731414049863815, 0.18505775928497312, -0.1528443992137909, 0.014560061506927012, 0.05215798690915108, -0.023994943127036095, -0.1905665099620819, -0.32593145966529846, 0.10877394676208496, 0.3772864043712616, 0.11736693233251572, -0.1639813929796219, 0.07347320765256882, -0.12226580828428268, 0.024963542819023132, 0.045113857835531235, 0.04620177298784256, -0.10934944450855257, 0.06399594992399216, -0.1289266049861908, 0.06797583401203156, 0.14262090623378754, 0.0944712832570076, -0.012316456995904446, 0.20231162011623385, -0.044089581817388535, 0.0314292386174202, 0.020268863067030907, 0.06482144445180893, -0.05840472877025604, -0.06575299054384232, -0.10675035417079926, -0.03898584470152855, 0.10104107111692429, -0.08705277740955353, -0.03286958858370781, 0.14245596528053284, -0.18027418851852417, 0.1218898594379425, 0.024240445345640182, -0.023109806701540947, -0.00796547718346119, 0.1089867427945137, -0.017025891691446304, -0.040329884737730026, 0.0565263107419014, -0.22652804851531985, 0.17645734548568726, 0.2141102999448776, -0.04652520269155502, 0.1630856990814209, 0.03754546120762825, 0.0698089599609375, -0.0141079006716609, -0.0011805202811956406, -0.1558636724948883, -0.07122227549552917, 0.0085078040137887, -0.019297104328870773, 0.06775342673063278, 0.08456288278102875]'),(46,'regular',2,50,'[-0.1435706466436386, 0.043745603412389755, 0.06870376318693161, -0.06287577748298645, 0.0365992970764637, -0.14959843456745148, 0.02377944439649582, -0.08982120454311371, 0.15712080895900726, -0.11716311424970628, 0.2037327140569687, -0.0499337799847126, -0.11807695776224136, -0.17281420528888702, 0.003421429544687271, 0.10023676604032516, -0.0851704329252243, -0.09669475257396698, -0.11732906848192216, -0.11974242329597472, 0.06948890537023544, 0.05109842121601105, 0.0989401713013649, 0.001524022314697504, -0.09480321407318117, -0.4185687303543091, -0.11442312598228456, -0.0781196728348732, 0.07246804982423782, -0.032399918884038925, 0.03365280479192734, 0.03868720307946205, -0.2653563320636749, -0.06358572840690613, -0.06141287088394165, -0.01892191357910633, 0.005177992396056652, 0.003887883387506008, 0.16784915328025818, 0.07258746027946472, -0.1606123000383377, -0.06955715268850327, 0.03821812942624092, 0.26574772596359253, 0.17088891565799713, 0.061731770634651184, -0.03791525214910507, 0.011118954978883266, 0.039772313088178635, -0.20607273280620575, 0.0816127210855484, 0.1030120849609375, 0.09264057129621506, 0.000491713173687458, 0.12780046463012695, 0.00962618552148342, 0.05143488571047783, -0.0040982551872730255, -0.2567377984523773, 0.014709238894283772, 0.044620580971241, -0.025998501107096672, -0.12530608475208282, -0.005185021087527275, 0.19908273220062256, 0.1484149992465973, -0.05947738140821457, -0.07005617022514343, 0.17072638869285583, -0.17734460532665253, 0.0608387291431427, 0.03816940635442734, -0.07983936369419098, -0.13178963959217072, -0.2663726508617401, 0.051256343722343445, 0.34930920600891113, 0.1338183432817459, -0.12755510210990906, 0.01879953220486641, -0.10283299535512924, 0.00021400721743702888, 0.14468275010585785, -0.015381544828414915, -0.11188159137964249, 0.02563576214015484, -0.059525761753320694, 0.06828352808952332, 0.08470460027456284, 0.0077874790877103806, -0.10550811886787416, 0.2098280638456345, -0.01872604712843895, -0.007185698486864567, 0.020502936094999313, -0.01695293001830578, -0.07873301953077316, -0.01181376911699772, -0.11280108988285063, 0.01358251180499792, 0.10772966593503952, -0.025024481117725372, -0.004329991061240435, 0.09151186048984528, -0.12899364531040192, 0.1106945499777794, 0.03213813900947571, -0.05409723520278931, 0.04605768620967865, 0.07631837576627731, -0.12409724295139311, -0.1500629037618637, -0.006331226788461208, -0.14587685465812683, 0.15983261168003082, 0.14322885870933533, -0.05358476936817169, 0.13101226091384888, 0.019452687352895737, 0.06423794478178024, -0.01499786227941513, 0.003979061730206013, -0.0806446522474289, -0.06851428002119064, 0.057275548577308655, 0.0036028679460287094, 0.06021919846534729, 0.0016950471326708794]'),(48,'regular',1,52,NULL),(50,'regular',2,54,NULL),(52,'regular',2,56,'[-0.1226491630077362, 0.0800548642873764, 0.08770791441202164, 0.0005789436399936676, 0.06231711804866791, -0.097973994910717, 0.014896278269588947, -0.06932688504457474, 0.10674241185188292, -0.08785434067249298, 0.22717522084712985, -0.018540536984801292, -0.15234783291816711, -0.16978643834590912, 0.003811304457485676, 0.05984612926840782, -0.1612556278705597, -0.14707686007022858, -0.06091608479619026, -0.08846765756607056, 0.003953791223466396, 0.0179915688931942, 0.05541716143488884, -0.03690164163708687, -0.1424326449632645, -0.31417736411094666, -0.10190180689096452, -0.1139831468462944, 0.08187854290008545, -0.06925605237483978, 0.0264221616089344, 0.058879658579826355, -0.19866134226322177, -0.03588676452636719, -0.051647111773490906, 0.06387458741664886, 0.03992842510342598, -0.009149492718279362, 0.1952707916498184, -0.002100487239658833, -0.10925281047821044, -0.09159068018198012, 0.0636945590376854, 0.2820158302783966, 0.15628650784492493, 0.0003946125507354736, -0.0002377666532993317, -0.0006994642317295074, -0.015336007811129091, -0.19895265996456143, 0.0897286906838417, 0.08283289521932602, 0.17491069436073303, 0.08386722952127457, 0.07769151777029037, -0.09008507430553436, 0.027530880644917488, -0.035681530833244324, -0.14943355321884155, 0.026741759851574894, 0.021691344678401947, -0.01045076735317707, -0.04690483957529068, 0.02874647825956345, 0.24378275871276855, 0.05051741003990173, -0.07460206747055054, -0.07194964587688446, 0.19460676610469815, -0.16628412902355194, -0.018416546285152435, 0.11648991703987122, -0.022220415994524956, -0.11704513430595398, -0.25798070430755615, 0.0670076236128807, 0.3762808442115784, 0.13768638670444489, -0.1703474521636963, 0.03603135049343109, -0.14902456104755402, -0.09567847102880478, 0.05811753123998642, 0.0050046988762915134, -0.14630189538002014, 0.0923604890704155, -0.12216725945472716, 0.051154762506484985, 0.18403905630111697, 0.028349585831165314, -0.10963363200426102, 0.1269164681434631, 0.039004795253276825, 0.0006409594789147377, 0.08997945487499237, -0.01656598597764969, 0.012429259717464449, -0.014520051889121532, -0.13656654953956604, -0.006326464936137199, 0.0937742218375206, -0.11935935169458388, -0.06779296696186066, 0.1088911145925522, -0.13829556107521057, 0.12329515814781188, 0.07680127769708633, -0.10090882331132887, 0.023000676184892654, 0.09887667000293732, -0.12346803396940231, -0.09851397573947906, 0.11775952577590942, -0.2558169662952423, 0.10931438952684402, 0.15541477501392365, 0.003855711780488491, 0.16274209320545197, 0.04880137741565704, 0.1286273896694183, -0.0314861536026001, -0.03568781167268753, -0.06680002808570862, -0.09865017235279085, 0.02144833654165268, 0.007452588528394699, 0.08873113244771957, 0.07040681689977646]'),(53,'regular',2,57,'[-0.13383835554122925, 0.06317055225372314, 0.014057764783501623, -0.0398557111620903, 0.028391346335411072, -0.12724417448043823, 0.03297306224703789, -0.11356781423091888, 0.1770406812429428, -0.11451831459999084, 0.22414201498031616, 0.018948279321193695, -0.1633375585079193, -0.1234949231147766, 0.0385621003806591, 0.07303677499294281, -0.1763857752084732, -0.10252360999584198, -0.09153129905462264, -0.06161472573876381, 0.04211294651031494, -0.019483666867017743, 0.05829795077443123, 0.03241879492998123, -0.1787395179271698, -0.329075425863266, -0.10840921103954317, -0.06123390793800354, -0.002853451296687126, -0.029858503490686417, 0.0076398709788918495, 0.07843081653118134, -0.2075601667165756, -0.04445327818393707, 0.010215730406343935, 0.11915779858827592, -0.06848427653312683, -0.03186831250786781, 0.23001070320606232, 0.05076807737350464, -0.12340348958969116, -0.09861281514167786, 0.07260405272245407, 0.2804763913154602, 0.1984667032957077, 0.03639627620577812, -0.019410086795687675, -0.04486200213432312, 0.08818063884973526, -0.23044589161872864, 0.046461768448352814, 0.12887336313724518, 0.06878351420164108, 0.07473266869783401, 0.1430346518754959, -0.13590747117996216, 0.06905895471572876, 0.01010672003030777, -0.1843159794807434, -0.006099738646298647, 0.0007773609831929207, -0.05916525423526764, -0.05646628141403198, -0.029305383563041687, 0.2210380733013153, 0.12542907893657684, -0.0911829024553299, -0.06668820977210999, 0.17208245396614075, -0.16853220760822296, -0.02472526393830776, 0.08402274549007416, -0.10160915553569794, -0.2124266177415848, -0.29937323927879333, -0.003297679126262665, 0.404895693063736, 0.18228216469287872, -0.106389582157135, 0.0012714555487036705, -0.07031121104955673, -0.09945464879274368, 0.14942464232444763, 0.038911785930395126, -0.11326781660318376, 0.03306800127029419, -0.09592033177614212, 0.0971505343914032, 0.19489943981170657, 0.03674899786710739, -0.1143074482679367, 0.16205193102359772, -0.009868107736110687, 0.041408851742744446, 0.026448359712958336, -0.055157434195280075, -0.05542349815368652, 0.02707167342305183, -0.1820573657751083, -0.00019910652190446856, 0.08107033371925354, -0.08729048818349838, -0.004024356137961149, 0.1298476755619049, -0.14816176891326904, 0.06155882030725479, 0.08003194630146027, -0.06477834284305573, -0.014070700854063034, 0.04083181917667389, -0.22710782289505005, -0.056786347180604935, 0.07126465439796448, -0.25725457072257996, 0.19425790011882785, 0.17377501726150513, -0.006343673914670944, 0.12572410702705383, 0.06051556393504143, 0.039032407104969025, -0.01523918192833662, -0.016918793320655823, -0.12392289936542512, -0.03441276401281357, 0.024248801171779633, 0.037398867309093475, 0.1238495260477066, -0.0013761664740741253]');
/*!40000 ALTER TABLE `users_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-30 11:05:16
