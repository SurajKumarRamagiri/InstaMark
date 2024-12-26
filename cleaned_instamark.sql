
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add department',1,'add_department'),(2,'Can change department',1,'change_department'),(3,'Can delete department',1,'delete_department'),(4,'Can view department',1,'view_department'),(5,'Can add profile',2,'add_profile'),(6,'Can change profile',2,'change_profile'),(7,'Can delete profile',2,'delete_profile'),(8,'Can view profile',2,'view_profile'),(9,'Can add log entry',3,'add_logentry'),(10,'Can change log entry',3,'change_logentry'),(11,'Can delete log entry',3,'delete_logentry'),(12,'Can view log entry',3,'view_logentry'),(13,'Can add permission',4,'add_permission'),(14,'Can change permission',4,'change_permission'),(15,'Can delete permission',4,'delete_permission'),(16,'Can view permission',4,'view_permission'),(17,'Can add group',5,'add_group'),(18,'Can change group',5,'change_group'),(19,'Can delete group',5,'delete_group'),(20,'Can view group',5,'view_group'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add content type',7,'add_contenttype'),(26,'Can change content type',7,'change_contenttype'),(27,'Can delete content type',7,'delete_contenttype'),(28,'Can view content type',7,'view_contenttype'),(29,'Can add session',8,'add_session'),(30,'Can change session',8,'change_session'),(31,'Can delete session',8,'delete_session'),(32,'Can view session',8,'view_session');
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$62uG03ZLDUZZPi4vqIEQkE$usBxEnaPR6CdTOifUgsdNPGPwmUjpz3x6rHj6zv5VHw=','2024-12-23 06:16:34.000000',1,'admin','me','','admin@gmail.com',1,1,'2024-12-18 05:46:39.000000'),(2,'pbkdf2_sha256$870000$yMxBDGUCOlS6Hg4C3g5nnz$AEdD8P++S+FR/VfzHmfgpfuTm5TLFpWYFRHMyoKC8dg=','2024-12-20 17:06:35.886857',0,'manager','manager','','manager@gmail.com',0,1,'2024-12-18 05:52:37.003534'),(3,'pbkdf2_sha256$870000$wstSba1v1EnomCfI9bzaCF$elIoW7NuolMnH3M1Nx7rEjV6isbLAJVzDdsbZRbJi9A=','2024-12-21 16:43:15.951463',0,'user','user','1','user1@gmail.com',0,1,'2024-12-18 05:59:06.780451'),(10,'pbkdf2_sha256$870000$9tGokbN8FRTYrVmOdN9M51$1m8jccibrOBqfmmhKPE9GmEhZdT6xH7+/BMD43g/0ag=',NULL,0,'user2','user','2','user2@gmail.com',0,1,'2024-12-20 13:28:03.599129'),(11,'pbkdf2_sha256$870000$bnxpBP9BSOdZAkXJC9zdhJ$grY12TJX6pcXFvjb7ga6JvCozZqIZhPs28VYomFuK6c=','2024-12-20 17:07:53.277343',0,'user3','user','3','user3@gmail.com',0,1,'2024-12-20 13:28:20.412311'),(12,'pbkdf2_sha256$870000$UYxSKuEKq7b3GOtOZIekHk$PPR2fxpbNezIWHWf9Pig2lMgTll/g3cJF1jDNbferQE=','2024-12-20 17:07:36.639965',0,'user4','user','4','user4@gmail.com',0,1,'2024-12-20 13:28:36.854609'),(47,'pbkdf2_sha256$870000$QAMxZARtO9XClRrbTFT3CB$bF7FYXIyN4IU9Ah2B9Dfr5nF7dTXcALneII4yLkIl90=','2024-12-20 17:26:37.207394',0,'user5','user','5','user5@gmail.com',0,1,'2024-12-20 15:24:38.639941'),(48,'pbkdf2_sha256$870000$Wh7kOcuVxdrCk7RLnBoqlm$GUREmM/MDWvb1USgxJJd+jW0zgPXq2VHXHQpewMIYrE=',NULL,0,'manager2','manager','2','manager2@gmail.com',0,1,'2024-12-20 17:48:42.187273'),(49,'pbkdf2_sha256$870000$x5QUYgKpBQ8fmJJSfK8cSN$qu1rjusLM+hBtbaMWpm6FJfbf9EsU0GEojoo3rupDP4=',NULL,1,'admin2','','','',1,1,'2024-12-23 08:57:58.000000');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (3,'admin','logentry'),(5,'auth','group'),(4,'auth','permission'),(6,'auth','user'),(7,'contenttypes','contenttype'),(8,'sessions','session'),(1,'users','department'),(2,'users','profile');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-18 05:43:20.620052'),(2,'auth','0001_initial','2024-12-18 05:43:22.016526'),(3,'admin','0001_initial','2024-12-18 05:43:22.312067'),(4,'admin','0002_logentry_remove_auto_add','2024-12-18 05:43:22.327521'),(5,'admin','0003_logentry_add_action_flag_choices','2024-12-18 05:43:22.349508'),(6,'contenttypes','0002_remove_content_type_name','2024-12-18 05:43:22.501475'),(7,'auth','0002_alter_permission_name_max_length','2024-12-18 05:43:22.649972'),(8,'auth','0003_alter_user_email_max_length','2024-12-18 05:43:22.691401'),(9,'auth','0004_alter_user_username_opts','2024-12-18 05:43:22.702658'),(10,'auth','0005_alter_user_last_login_null','2024-12-18 05:43:22.834431'),(11,'auth','0006_require_contenttypes_0002','2024-12-18 05:43:22.850149'),(12,'auth','0007_alter_validators_add_error_messages','2024-12-18 05:43:22.867976'),(13,'auth','0008_alter_user_username_max_length','2024-12-18 05:43:23.002029'),(14,'auth','0009_alter_user_last_name_max_length','2024-12-18 05:43:23.134324'),(15,'auth','0010_alter_group_name_max_length','2024-12-18 05:43:23.173907'),(16,'auth','0011_update_proxy_permissions','2024-12-18 05:43:23.195318'),(17,'auth','0012_alter_user_first_name_max_length','2024-12-18 05:43:23.347418'),(18,'sessions','0001_initial','2024-12-18 05:43:23.435699'),(19,'users','0001_initial','2024-12-18 05:45:03.427589'),(20,'users','0002_alter_profile_department','2024-12-18 10:32:09.130475'),(21,'users','0003_profile_face_embedding_alter_profile_user','2024-12-20 18:36:49.669564');
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
INSERT INTO `django_session` VALUES ('06e3no05kwpv1t6m6a8ot92od9v1wow3','e30:1tNncV:OeBzijeeKdpqSVRzQMkCgStRPFdC_uuBdCJIdrSs9Do','2025-01-01 06:33:19.326473'),('29rcxofu2td0x9zm01jlo59azpkqvzc0','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNoPd:mhllTLZUazqkEyFQ0yO71rhl8-BY_pEaXbDq7XDbGRw','2025-01-01 07:24:05.560048'),('7dhj1wt12yb0rkwgjqmplkb19udp9dng','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNnG1:HTT5ySSRFVpjiQ5sHXjraoz6xytfE27G8D-5GovZWcc','2025-01-01 06:10:05.015083'),('8aukhrhrskwj2wmo0lxtrawwcffezdu3','e30:1tNnpT:WLIBPouOQ51x5kGzUzeDK5K5jU2MM7SrYEbENOSpKpM','2025-01-01 06:46:43.200173'),('ezminpwjbscubvgcs21r1er6499d39h3','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tNpyI:w9a1zwvLo3lrDm4KRk1Uu5Q5k-nSu0ioQ_tDFcdrCfw','2025-01-01 09:03:58.307757'),('kfhz8y3vkmqe3ujubaurggi9p49zhnmy','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tPbk2:XaMoAT4WlQamjo0HlEaMMmnn8yv-_dDwhUFaZDiwtsk','2025-01-06 06:16:34.996227'),('m04x8dmuvrmwyvomojk2mo5ggyw6fj5w','e30:1tNnuf:6i5gBYTOHzcxpwiq9Ad6R0S1_UJexWGfDnS79iA2NQg','2025-01-01 06:52:05.649095'),('pc0yiwnt1dq12rbvksunnare0piniryk','.eJxVjDkOwjAUBe_iGlnxQuxQ0ucM1l_8cQDFUpxUiLtDpBTQvpl5L5VgW0vaWl7SxOqijDr9bgj0yPMO-A7zrWqq87pMqHdFH7TpsXJ-Xg_376BAK9_aGg8OHQ3BSJ8Dh4jGhmgCCdHZB_ESe7Fs0cnQCfkImOMAyCwdGlTvD-hGOMs:1tPH89:QhyT_zeSsEH4-I-tl1eXzNQYgoBb4OmexSegADsDwCg','2025-01-05 08:16:05.017853');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users_department` WRITE;
/*!40000 ALTER TABLE `users_department` DISABLE KEYS */;
INSERT INTO `users_department` VALUES (2,'CSD'),(1,'CSE');
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users_profile` WRITE;
/*!40000 ALTER TABLE `users_profile` DISABLE KEYS */;
INSERT INTO `users_profile` VALUES (1,'superuser',1,1,NULL),(2,'staff',2,2,NULL),(3,'regular',2,3,'[-0.2491605579853058, 0.19826051592826843, 0.11456599831581116, -0.020453473553061485, 0.027555806562304497, -0.06274363398551941, 0.012799298390746117, -0.08601152896881104, 0.1839188188314438, -0.08181843906641006, 0.20817098021507263, -0.02706996724009514, -0.12260136008262634, -0.15535695850849152, 0.007308080792427063, 0.1174810528755188, -0.19539569318294525, -0.17717431485652924, -0.07414307445287704, -0.08320184051990509, 0.03751946240663528, 0.009444652125239372, -0.03262488916516304, 0.036298204213380814, -0.14303570985794067, -0.3681584894657135, -0.06873472779989243, -0.13179580867290497, 0.0985238254070282, -0.0791529044508934, -0.0249352864921093, -0.052210092544555664, -0.2798406779766083, -0.09199067950248718, -0.07094577699899673, 0.06716720759868622, 0.07220833003520966, 0.020176418125629425, 0.1203511282801628, -0.04410724341869354, -0.16369561851024628, -0.020419105887413025, 0.029583342373371124, 0.2392357885837555, 0.1734319031238556, 0.0399928092956543, -0.02538434788584709, -0.03176455199718475, 0.05050078779459, -0.18548151850700376, 0.031874462962150574, 0.11710475385189056, 0.06461133062839508, 0.060373514890670776, -0.0012957267463207245, -0.13923460245132446, -0.016029179096221924, 0.036412108689546585, -0.20641574263572693, 0.07751401513814926, 0.04038744792342186, -0.13566510379314425, -0.11310378462076189, 0.04639562219381333, 0.2164799273014069, 0.09619272500276566, -0.1028200313448906, -0.13780049979686737, 0.1939435601234436, -0.1652272641658783, 0.045255232602357864, 0.04337408021092415, -0.023696819320321083, -0.1374487429857254, -0.33918696641921997, 0.11027303338050842, 0.38703250885009766, 0.1256750524044037, -0.19424116611480713, 0.06473418325185776, -0.1690993458032608, 0.029955219477415085, 0.07234993577003479, 0.08746036142110825, -0.10621563345193864, 0.06317300349473953, -0.11953692883253098, 0.05171933025121689, 0.12557293474674225, 0.10218276083469392, -0.045938652008771896, 0.1934313923120499, -0.020988935604691505, 0.045365966856479645, 0.03264773637056351, 0.06644784659147263, -0.08475257456302643, -0.07325991988182068, -0.09078530222177504, -0.009990262798964976, 0.09673963487148284, -0.02849154733121395, -0.04667458310723305, 0.1466877907514572, -0.1489081084728241, 0.12641818821430206, 0.03226137533783913, 0.002919902093708515, -0.005270886234939098, 0.06589436531066895, -0.028451165184378624, -0.09163129329681396, 0.0955348014831543, -0.20836496353149417, 0.1929706335067749, 0.20032870769500732, -0.04379098117351532, 0.1926596313714981, 0.09458065032958984, 0.059268154203891754, -0.005818039178848267, -0.017502326518297195, -0.1428564041852951, -0.06163160130381584, 0.04043775796890259, -0.06502729654312134, 0.0983922928571701, 0.05432457849383354]'),(10,'regular',2,10,NULL),(11,'regular',1,11,NULL),(12,'regular',1,12,NULL),(43,'regular\n',1,47,NULL),(44,'staff',1,48,NULL),(45,'',NULL,49,NULL);
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

