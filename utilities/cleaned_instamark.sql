
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
DROP TABLE IF EXISTS `attendance_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `user_profile_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `department_name` varchar(100) NOT NULL,
  `fullname` varchar(150) NOT NULL,
  `percentage` double NOT NULL,
  `time` time(6) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `user_profile_id` (`user_profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `attendance_attendance` WRITE;
/*!40000 ALTER TABLE `attendance_attendance` DISABLE KEYS */;
INSERT INTO `attendance_attendance` VALUES (6,'2024-12-26','Absent',2,2,'CSD','manager',0,'11:36:34.342586','manager',NULL),(7,'2024-12-26','Absent',10,2,'CSD','manoj kumar',0,'11:36:34.352365','user2',NULL),(8,'2024-12-26','Absent',46,2,'CSD','abhinav',0,'11:36:34.372487','user3',NULL),(9,'2024-12-26','Present',47,2,'CSD','user 4',0,'11:39:36.469897','user4',NULL),(78,'2024-12-26','Present',3,2,'CSD','suraj kumar',0,'13:03:20.709645','user',NULL);
/*!40000 ALTER TABLE `attendance_attendance` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add department',1,'add_department'),(2,'Can change department',1,'change_department'),(3,'Can delete department',1,'delete_department'),(4,'Can view department',1,'view_department'),(5,'Can add profile',2,'add_profile'),(6,'Can change profile',2,'change_profile'),(7,'Can delete profile',2,'delete_profile'),(8,'Can view profile',2,'view_profile'),(9,'Can add log entry',3,'add_logentry'),(10,'Can change log entry',3,'change_logentry'),(11,'Can delete log entry',3,'delete_logentry'),(12,'Can view log entry',3,'view_logentry'),(13,'Can add permission',4,'add_permission'),(14,'Can change permission',4,'change_permission'),(15,'Can delete permission',4,'delete_permission'),(16,'Can view permission',4,'view_permission'),(17,'Can add group',5,'add_group'),(18,'Can change group',5,'change_group'),(19,'Can delete group',5,'delete_group'),(20,'Can view group',5,'view_group'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add content type',7,'add_contenttype'),(26,'Can change content type',7,'change_contenttype'),(27,'Can delete content type',7,'delete_contenttype'),(28,'Can view content type',7,'view_contenttype'),(29,'Can add session',8,'add_session'),(30,'Can change session',8,'change_session'),(31,'Can delete session',8,'delete_session'),(32,'Can view session',8,'view_session'),(33,'Can add attendance',9,'add_attendance'),(34,'Can change attendance',9,'change_attendance'),(35,'Can delete attendance',9,'delete_attendance'),(36,'Can view attendance',9,'view_attendance');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$62uG03ZLDUZZPi4vqIEQkE$usBxEnaPR6CdTOifUgsdNPGPwmUjpz3x6rHj6zv5VHw=','2024-12-26 12:17:17.334910',1,'admin','me','','admin@gmail.com',1,1,'2024-12-18 05:46:39.000000'),(2,'pbkdf2_sha256$870000$yMxBDGUCOlS6Hg4C3g5nnz$AEdD8P++S+FR/VfzHmfgpfuTm5TLFpWYFRHMyoKC8dg=','2024-12-20 17:06:35.886857',0,'manager','manager','','manager@gmail.com',0,1,'2024-12-18 05:52:37.003534'),(3,'pbkdf2_sha256$870000$wstSba1v1EnomCfI9bzaCF$elIoW7NuolMnH3M1Nx7rEjV6isbLAJVzDdsbZRbJi9A=','2024-12-21 16:43:15.951463',0,'user','suraj','kumar','user1@gmail.com',0,1,'2024-12-18 05:59:06.780451'),(10,'pbkdf2_sha256$870000$9tGokbN8FRTYrVmOdN9M51$1m8jccibrOBqfmmhKPE9GmEhZdT6xH7+/BMD43g/0ag=',NULL,0,'user2','manoj','kumar','user2@gmail.com',0,1,'2024-12-20 13:28:03.599129'),(50,'pbkdf2_sha256$870000$7msKFjHqBFUxWyafocEPRO$kAToGOf1AhgonPCq1M0DQibr/UccsdGC3p/Ep8NwQBQ=',NULL,0,'user3','abhinav','','user3@gmail.com',0,1,'2024-12-24 06:59:35.227439'),(51,'pbkdf2_sha256$870000$KJOohP8ICWTl8Zhok4vyS2$NNra5gI8EnuPG9AXMZxFx5924rnkoHb4wc3Bw2VYDLc=',NULL,0,'user4','user','4','user4@gmail.com',0,1,'2024-12-26 05:57:14.440304');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-12-18 05:51:20.902397','1','admin',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',2,1),(2,'2024-12-18 05:51:28.312574','1','admin',2,'[]',2,1),(3,'2024-12-18 06:05:21.096994','4','user2',3,'',6,1),(4,'2024-12-18 06:05:21.096994','5','user3',3,'',6,1),(5,'2024-12-18 06:05:53.719103','2','manager',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',2,1),(6,'2024-12-18 06:37:22.724160','3','user',2,'[{\"changed\": {\"fields\": [\"Role\"]}}]',2,1),(7,'2024-12-18 06:37:26.769721','1','admin',2,'[]',2,1),(8,'2024-12-18 06:37:30.371376','2','manager',2,'[]',2,1),(9,'2024-12-18 07:20:18.847503','6','user2',3,'',6,1),(10,'2024-12-18 07:20:18.847503','7','user3',3,'',6,1),(11,'2024-12-18 07:20:18.847503','8','user4',3,'',6,1),(12,'2024-12-18 10:24:27.505223','1','CSE',1,'[{\"added\": {}}]',1,1),(13,'2024-12-18 10:24:38.472488','2','CSD',1,'[{\"added\": {}}]',1,1),(14,'2024-12-18 10:34:06.773562','3','CSM',1,'[{\"added\": {}}]',1,1),(15,'2024-12-20 13:27:37.753986','3','user',2,'[{\"changed\": {\"fields\": [\"Department\"]}}]',2,1),(16,'2024-12-20 13:28:04.160658','10','user2',1,'[{\"added\": {}}]',6,1),(17,'2024-12-20 13:28:20.946730','11','user3',1,'[{\"added\": {}}]',6,1),(18,'2024-12-20 13:28:37.404813','12','user4',1,'[{\"added\": {}}]',6,1),(19,'2024-12-20 13:28:50.166934','3','user',2,'[]',2,1),(20,'2024-12-20 13:29:03.992073','10','user2',2,'[{\"changed\": {\"fields\": [\"Department\", \"Role\"]}}]',2,1),(21,'2024-12-20 13:29:13.954170','11','user3',2,'[{\"changed\": {\"fields\": [\"Department\", \"Role\"]}}]',2,1),(22,'2024-12-20 13:29:28.820670','12','user4',2,'[{\"changed\": {\"fields\": [\"Department\", \"Role\"]}}]',2,1),(23,'2024-12-23 08:35:32.441039','1','admin1',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',6,1),(24,'2024-12-23 08:38:25.256378','1','admin',2,'[{\"changed\": {\"fields\": [\"Username\"]}}]',6,1),(25,'2024-12-23 08:57:59.385701','49','admin2',1,'[{\"added\": {}}]',6,1),(26,'2024-12-23 08:58:13.333838','49','admin2',2,'[{\"changed\": {\"fields\": [\"Staff status\", \"Superuser status\"]}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (3,'admin','logentry'),(9,'attendance','attendance'),(5,'auth','group'),(4,'auth','permission'),(6,'auth','user'),(7,'contenttypes','contenttype'),(8,'sessions','session'),(1,'users','department'),(2,'users','profile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-18 05:43:20.620052'),(2,'auth','0001_initial','2024-12-18 05:43:22.016526'),(3,'admin','0001_initial','2024-12-18 05:43:22.312067'),(4,'admin','0002_logentry_remove_auto_add','2024-12-18 05:43:22.327521'),(5,'admin','0003_logentry_add_action_flag_choices','2024-12-18 05:43:22.349508'),(6,'contenttypes','0002_remove_content_type_name','2024-12-18 05:43:22.501475'),(7,'auth','0002_alter_permission_name_max_length','2024-12-18 05:43:22.649972'),(8,'auth','0003_alter_user_email_max_length','2024-12-18 05:43:22.691401'),(9,'auth','0004_alter_user_username_opts','2024-12-18 05:43:22.702658'),(10,'auth','0005_alter_user_last_login_null','2024-12-18 05:43:22.834431'),(11,'auth','0006_require_contenttypes_0002','2024-12-18 05:43:22.850149'),(12,'auth','0007_alter_validators_add_error_messages','2024-12-18 05:43:22.867976'),(13,'auth','0008_alter_user_username_max_length','2024-12-18 05:43:23.002029'),(14,'auth','0009_alter_user_last_name_max_length','2024-12-18 05:43:23.134324'),(15,'auth','0010_alter_group_name_max_length','2024-12-18 05:43:23.173907'),(16,'auth','0011_update_proxy_permissions','2024-12-18 05:43:23.195318'),(17,'auth','0012_alter_user_first_name_max_length','2024-12-18 05:43:23.347418'),(18,'sessions','0001_initial','2024-12-18 05:43:23.435699'),(19,'users','0001_initial','2024-12-18 05:45:03.427589'),(20,'users','0002_alter_profile_department','2024-12-18 10:32:09.130475'),(21,'users','0003_profile_face_embedding_alter_profile_user','2024-12-20 18:36:49.669564'),(22,'attendance','0001_initial','2024-12-23 09:58:59.743352'),(23,'attendance','0002_remove_attendance_name_attendance_department_and_more','2024-12-23 13:24:14.716850'),(24,'attendance','0003_alter_attendance_user_profile','2024-12-23 14:11:12.120796'),(25,'attendance','0004_attendance_department_name_attendance_fullname_and_more','2024-12-25 14:55:34.336537'),(26,'attendance','0005_attendance_location','2024-12-25 16:27:59.369861');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
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

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('06e3no05kwpv1t6m6a8ot92od9v1wow3','e30:1tNncV:OeBzijeeKdpqSVRzQMkCgStRPFdC_uuBdCJIdrSs9Do','2025-01-01 06:33:19.326473'),('29rcxofu2td0x9zm01jlo59azpkqvzc0','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNoPd:mhllTLZUazqkEyFQ0yO71rhl8-BY_pEaXbDq7XDbGRw','2025-01-01 07:24:05.560048'),('7dhj1wt12yb0rkwgjqmplkb19udp9dng','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNnG1:HTT5ySSRFVpjiQ5sHXjraoz6xytfE27G8D-5GovZWcc','2025-01-01 06:10:05.015083'),('8aukhrhrskwj2wmo0lxtrawwcffezdu3','e30:1tNnpT:WLIBPouOQ51x5kGzUzeDK5K5jU2MM7SrYEbENOSpKpM','2025-01-01 06:46:43.200173'),('ezminpwjbscubvgcs21r1er6499d39h3','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNpyI:w9a1zwvLo3lrDm4KRk1Uu5Q5k-nSu0ioQ_tDFcdrCfw','2025-01-01 09:03:58.307757'),('m04x8dmuvrmwyvomojk2mo5ggyw6fj5w','e30:1tNnuf:6i5gBYTOHzcxpwiq9Ad6R0S1_UJexWGfDnS79iA2NQg','2025-01-01 06:52:05.649095'),('pc0yiwnt1dq12rbvksunnare0piniryk','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tPH89:QhyT_zeSsEH4-I-tl1eXzNQYgoBb4OmexSegADsDwCg','2025-01-05 08:16:05.017853'),('zxqrv3lqlvlyy3alcuj6iaj6jb6fufqz','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tQheP:qE9Jw82w5mclXyatAJZl-2WybeFTi6FpGRWxGJ0gI48','2025-01-09 12:17:17.348392');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `users_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_department` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users_department` WRITE;
/*!40000 ALTER TABLE `users_department` DISABLE KEYS */;
INSERT INTO `users_department` VALUES (2,'CSD'),(1,'CSE'),(4,'default');
/*!40000 ALTER TABLE `users_department` ENABLE KEYS */;
UNLOCK TABLES;
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users_profile` WRITE;
/*!40000 ALTER TABLE `users_profile` DISABLE KEYS */;
INSERT INTO `users_profile` VALUES (1,'superuser',1,1,NULL),(2,'staff',2,2,NULL),(3,'regular',2,3,'[-0.2029233276844025, 0.13178515434265137, 0.069699726998806, 0.003568981308490038, 0.08178863674402237, -0.06657876819372177, 0.045001063495874405, -0.08721011877059937, 0.1986222267150879, -0.08775223791599274, 0.20380249619483948, -0.024549487978219982, -0.1404927223920822, -0.161812886595726, 0.07085675001144409, 0.11296366155147552, -0.17194752395153046, -0.1669589877128601, -0.09165696054697035, -0.0942189395427704, 0.06605075299739838, -0.0011917233932763338, -0.016236666589975357, 0.019258519634604458, -0.1866970658302307, -0.3258955478668213, -0.05480644851922989, -0.1241932287812233, 0.03459779918193817, -0.1059987023472786, -0.03249946981668472, -0.01468303706496954, -0.25747084617614746, -0.05670800432562828, -0.07419177889823914, 0.0938425213098526, 0.04664463549852371, 0.04072277992963791, 0.1025475561618805, -0.01976078748703003, -0.18406274914741516, -0.0015912428498268127, 0.05829186737537384, 0.20859135687351227, 0.203487291932106, 0.05140039324760437, -0.0512385368347168, -0.000652700662612915, 0.038975827395915985, -0.24323156476020813, 0.02896473929286003, 0.097959965467453, 0.08366841077804565, 0.06469234079122543, 0.06468625366687775, -0.145903542637825, -0.031929485499858856, 0.010828647762537004, -0.1772860288619995, 0.07558036595582962, 0.037437353283166885, -0.11691299080848694, -0.07668545097112656, 0.06125513091683388, 0.19337011873722076, 0.09124602377414703, -0.10058804601430892, -0.056731414049863815, 0.18505775928497312, -0.1528443992137909, 0.014560061506927012, 0.05215798690915108, -0.023994943127036095, -0.1905665099620819, -0.32593145966529846, 0.10877394676208496, 0.3772864043712616, 0.11736693233251572, -0.1639813929796219, 0.07347320765256882, -0.12226580828428268, 0.024963542819023132, 0.045113857835531235, 0.04620177298784256, -0.10934944450855257, 0.06399594992399216, -0.1289266049861908, 0.06797583401203156, 0.14262090623378754, 0.0944712832570076, -0.012316456995904446, 0.20231162011623385, -0.044089581817388535, 0.0314292386174202, 0.020268863067030907, 0.06482144445180893, -0.05840472877025604, -0.06575299054384232, -0.10675035417079926, -0.03898584470152855, 0.10104107111692429, -0.08705277740955353, -0.03286958858370781, 0.14245596528053284, -0.18027418851852417, 0.1218898594379425, 0.024240445345640182, -0.023109806701540947, -0.00796547718346119, 0.1089867427945137, -0.017025891691446304, -0.040329884737730026, 0.0565263107419014, -0.22652804851531985, 0.17645734548568726, 0.2141102999448776, -0.04652520269155502, 0.1630856990814209, 0.03754546120762825, 0.0698089599609375, -0.0141079006716609, -0.0011805202811956406, -0.1558636724948883, -0.07122227549552917, 0.0085078040137887, -0.019297104328870773, 0.06775342673063278, 0.08456288278102875]'),(10,'regular',2,10,NULL),(46,'regular',2,50,'[-0.1435706466436386, 0.043745603412389755, 0.06870376318693161, -0.06287577748298645, 0.0365992970764637, -0.14959843456745148, 0.02377944439649582, -0.08982120454311371, 0.15712080895900726, -0.11716311424970628, 0.2037327140569687, -0.0499337799847126, -0.11807695776224136, -0.17281420528888702, 0.003421429544687271, 0.10023676604032516, -0.0851704329252243, -0.09669475257396698, -0.11732906848192216, -0.11974242329597472, 0.06948890537023544, 0.05109842121601105, 0.0989401713013649, 0.001524022314697504, -0.09480321407318117, -0.4185687303543091, -0.11442312598228456, -0.0781196728348732, 0.07246804982423782, -0.032399918884038925, 0.03365280479192734, 0.03868720307946205, -0.2653563320636749, -0.06358572840690613, -0.06141287088394165, -0.01892191357910633, 0.005177992396056652, 0.003887883387506008, 0.16784915328025818, 0.07258746027946472, -0.1606123000383377, -0.06955715268850327, 0.03821812942624092, 0.26574772596359253, 0.17088891565799713, 0.061731770634651184, -0.03791525214910507, 0.011118954978883266, 0.039772313088178635, -0.20607273280620575, 0.0816127210855484, 0.1030120849609375, 0.09264057129621506, 0.000491713173687458, 0.12780046463012695, 0.00962618552148342, 0.05143488571047783, -0.0040982551872730255, -0.2567377984523773, 0.014709238894283772, 0.044620580971241, -0.025998501107096672, -0.12530608475208282, -0.005185021087527275, 0.19908273220062256, 0.1484149992465973, -0.05947738140821457, -0.07005617022514343, 0.17072638869285583, -0.17734460532665253, 0.0608387291431427, 0.03816940635442734, -0.07983936369419098, -0.13178963959217072, -0.2663726508617401, 0.051256343722343445, 0.34930920600891113, 0.1338183432817459, -0.12755510210990906, 0.01879953220486641, -0.10283299535512924, 0.00021400721743702888, 0.14468275010585785, -0.015381544828414915, -0.11188159137964249, 0.02563576214015484, -0.059525761753320694, 0.06828352808952332, 0.08470460027456284, 0.0077874790877103806, -0.10550811886787416, 0.2098280638456345, -0.01872604712843895, -0.007185698486864567, 0.020502936094999313, -0.01695293001830578, -0.07873301953077316, -0.01181376911699772, -0.11280108988285063, 0.01358251180499792, 0.10772966593503952, -0.025024481117725372, -0.004329991061240435, 0.09151186048984528, -0.12899364531040192, 0.1106945499777794, 0.03213813900947571, -0.05409723520278931, 0.04605768620967865, 0.07631837576627731, -0.12409724295139311, -0.1500629037618637, -0.006331226788461208, -0.14587685465812683, 0.15983261168003082, 0.14322885870933533, -0.05358476936817169, 0.13101226091384888, 0.019452687352895737, 0.06423794478178024, -0.01499786227941513, 0.003979061730206013, -0.0806446522474289, -0.06851428002119064, 0.057275548577308655, 0.0036028679460287094, 0.06021919846534729, 0.0016950471326708794]'),(47,'regular',2,51,'[-0.08940424770116806, 0.018951263278722763, -0.013231169432401655, -0.055613595992326736, -0.05247459188103676, -0.05375055223703384, -0.043614763766527176, -0.09146414697170258, 0.20997662842273712, -0.16339688003063202, 0.2188711017370224, -0.07060927152633667, -0.09973499178886414, -0.08992694318294525, -0.03428703546524048, 0.11808860301971436, -0.11601641029119492, -0.14872664213180542, -0.052948325872421265, -0.05876696854829788, 0.011319362558424473, 0.016316315159201622, -0.0044355993159115314, 0.0853000357747078, -0.18204265832901, -0.3833959698677063, -0.08562779426574707, -0.1533999890089035, 0.018968529999256138, -0.07805086672306061, 0.05626947805285454, 0.14370043575763702, -0.2206681966781616, -0.008275151252746582, 0.021073289215564728, 0.1080797016620636, 0.011174699291586876, 0.02474888041615486, 0.1838361918926239, 0.04005736857652664, -0.2060774862766266, -0.06041084975004196, 0.06958094239234924, 0.2743009924888611, 0.18123650550842285, -0.006940957624465227, -0.022658618167042732, -0.051842086017131805, 0.13963159918785095, -0.1802302598953247, -0.048037976026535034, 0.1353258192539215, 0.11858735233545303, 0.005159053020179272, 0.11400268971920012, -0.022621866315603256, 0.05757994204759598, 0.08012357354164124, -0.23573754727840424, 0.03941544517874718, -0.014191341586411, -0.03339029848575592, -0.07048280537128448, -0.04181382060050965, 0.21673105657100675, 0.07075808197259903, -0.09680343419313432, -0.05792347341775894, 0.20901897549629211, -0.20090234279632568, -0.00015393132343888283, 0.10469111800193788, -0.08738083392381668, -0.20818494260311127, -0.2558567225933075, -0.0749528780579567, 0.47504863142967224, 0.12165267020463943, -0.14408747851848602, 0.10522498935461044, -0.048928190022706985, -0.11215317994356155, 0.06714807450771332, 0.06903648376464844, -0.06164528429508209, 0.0016063833609223366, -0.01912103220820427, 0.05887899920344353, 0.23529024422168732, 0.03406776115298271, 0.029400847852230072, 0.15677213668823242, -0.07667258381843567, 0.016998447477817535, 0.0021303296089172363, -0.03815094381570816, -0.09729105234146118, -0.028026405721902847, -0.10292895883321762, -0.05013332888484001, -0.05377548187971115, -0.07924667745828629, -0.01675630919635296, 0.06469284743070602, -0.22329753637313843, 0.14439964294433594, 0.04966207221150398, -0.0471862368285656, 0.02781294472515583, 0.11975362151861192, -0.07981343567371368, -0.06103856861591339, 0.14418479800224304, -0.2375650405883789, 0.14113160967826843, 0.11161544919013976, -0.014728067442774773, 0.13985274732112885, 0.023852918297052383, 0.06124711409211159, -0.04648438096046448, -0.036555662751197815, -0.16067951917648315, -0.07829947769641876, -0.005013546906411648, -0.0961057022213936, 0.0550135001540184, -0.053148914128541946]');
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

