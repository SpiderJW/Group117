-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_gathmant
-- ------------------------------------------------------
-- Server version	10.6.7-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clinical_trials`
--

DROP TABLE IF EXISTS `clinical_trials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trials` (
  `clinical_trial_id` varchar(10) NOT NULL,
  `cancer_type` varchar(180) NOT NULL,
  `trial_description` varchar(256) NOT NULL,
  `maximum_patients` int(11) NOT NULL,
  PRIMARY KEY (`clinical_trial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinical_trials`
--

LOCK TABLES `clinical_trials` WRITE;
/*!40000 ALTER TABLE `clinical_trials` DISABLE KEYS */;
INSERT INTO `clinical_trials` VALUES ('HG1141','Breast','This randomized phase II trial studies how well abbreviated breast magnetic resonance imaging (MRI) and digital tomosynthesis mammography work in detecting cancer in women with dense breasts.',1500),('HG8143','Kidney','This phase III trial compares nephrectomy (surgery to remove a kidney or part of a kidney) with nivolumab to the usual approach of nephrectomy followed by standard post-operative follow-up and monitoring.',750),('HGG173','Myeloma','This phase III trial studies how well lenalidomide and dexamethasone works with or without daratumumab in treating patients with high-risk smoldering myeloma. ',300);
/*!40000 ALTER TABLE `clinical_trials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `employee_first_name` varchar(45) NOT NULL,
  `employee_last_name` varchar(45) NOT NULL,
  `position` varchar(45) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `desk_phone` varchar(18) DEFAULT NULL,
  `employer` varchar(45) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Regina','Dutch','Recruiter','dregina@hog.com','402-250-8329','Health Oncology Group'),(2,'Calvin','Jonas','Project Coordinator','cjonas@hog.com','714-338-2340','Health Oncology Group'),(3,'Haylie','Sandra','Data Manager','hsandra@hog.com','832-209-6628','Health Oncology Group'),(4,'Steve','Glenna','M.D.','sglenna@case.edu','775-981-5220','Case Western Reserve University'),(5,'Deitra','Gracie','M.D.','dgracie@baylor.edu','561-552-5564','Baylor University Medical Center'),(6,'Alex','King','M.D.','aking@geisinger.edu','914-774-0513','Geisinger Medical Center');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_supporting_clinical_trials`
--

DROP TABLE IF EXISTS `employees_supporting_clinical_trials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees_supporting_clinical_trials` (
  `employees_employee_id` int(11) NOT NULL,
  `clinical_trials_clinical_trial_id` varchar(10) NOT NULL,
  `employee_role` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`employees_employee_id`,`clinical_trials_clinical_trial_id`),
  KEY `fk_employees_has_clinical_trials_clinical_trials1_idx` (`clinical_trials_clinical_trial_id`),
  KEY `fk_employees_has_clinical_trials_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_employees_has_clinical_trials_clinical_trials1` FOREIGN KEY (`clinical_trials_clinical_trial_id`) REFERENCES `clinical_trials` (`clinical_trial_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_has_clinical_trials_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_supporting_clinical_trials`
--

LOCK TABLES `employees_supporting_clinical_trials` WRITE;
/*!40000 ALTER TABLE `employees_supporting_clinical_trials` DISABLE KEYS */;
INSERT INTO `employees_supporting_clinical_trials` VALUES (1,'HG1141','Recruiter'),(2,'HG8143','Project Coordinator'),(3,'HGG173','Data Manager'),(4,'HG1141','Study Chair'),(5,'HG8143','Committee Chair'),(6,'HGG173','Study Co-Chair');
/*!40000 ALTER TABLE `employees_supporting_clinical_trials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitals`
--

DROP TABLE IF EXISTS `hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospitals` (
  `hospital_id` int(11) NOT NULL AUTO_INCREMENT,
  `hospital_name` varchar(100) NOT NULL,
  `hospital_street` varchar(180) NOT NULL,
  `hospital_city` varchar(64) NOT NULL,
  `hospital_state` varchar(45) NOT NULL,
  `hospital_zip` varchar(5) NOT NULL,
  PRIMARY KEY (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitals`
--

LOCK TABLES `hospitals` WRITE;
/*!40000 ALTER TABLE `hospitals` DISABLE KEYS */;
INSERT INTO `hospitals` VALUES (1,'Baylor University Medical Center','3500 Gaston Ave','Dallas','TX','75246'),(2,'Case Western Reserve University','9501 Euclid Ave','Cleveland','OH','44106'),(3,'Geisinger Medical Center','100 N Academy Ave','Danville','PA','17821');
/*!40000 ALTER TABLE `hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitals_supporting_clinical_trials`
--

DROP TABLE IF EXISTS `hospitals_supporting_clinical_trials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospitals_supporting_clinical_trials` (
  `clinical_trials_clinical_trial_id` varchar(10) NOT NULL,
  `hospitals_hospital_id` int(11) NOT NULL,
  PRIMARY KEY (`clinical_trials_clinical_trial_id`,`hospitals_hospital_id`),
  KEY `fk_clinical_trials_has_hospitals_hospitals1_idx` (`hospitals_hospital_id`),
  KEY `fk_clinical_trials_has_hospitals_clinical_trials1_idx` (`clinical_trials_clinical_trial_id`),
  CONSTRAINT `fk_clinical_trials_has_hospitals_clinical_trials1` FOREIGN KEY (`clinical_trials_clinical_trial_id`) REFERENCES `clinical_trials` (`clinical_trial_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clinical_trials_has_hospitals_hospitals1` FOREIGN KEY (`hospitals_hospital_id`) REFERENCES `hospitals` (`hospital_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitals_supporting_clinical_trials`
--

LOCK TABLES `hospitals_supporting_clinical_trials` WRITE;
/*!40000 ALTER TABLE `hospitals_supporting_clinical_trials` DISABLE KEYS */;
INSERT INTO `hospitals_supporting_clinical_trials` VALUES ('HG1141',1),('HG1141',3),('HG8143',2),('HGG173',3);
/*!40000 ALTER TABLE `hospitals_supporting_clinical_trials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `patient_first_name` varchar(45) NOT NULL,
  `patient_last_name` varchar(45) NOT NULL,
  `patient_street` varchar(180) NOT NULL,
  `patient_city` varchar(64) NOT NULL,
  `patient_state` varchar(45) NOT NULL,
  `patient_zip` varchar(5) NOT NULL,
  `patient_sex` char(1) NOT NULL,
  `dob` date NOT NULL,
  `hospitals_hospital_id` int(11) NOT NULL,
  `clinical_trials_clinical_trial_id` varchar(10) NOT NULL,
  PRIMARY KEY (`patient_id`,`hospitals_hospital_id`,`clinical_trials_clinical_trial_id`),
  KEY `fk_patients_hospitals_idx` (`hospitals_hospital_id`),
  KEY `fk_patients_clinical_trials1_idx` (`clinical_trials_clinical_trial_id`),
  CONSTRAINT `fk_patients_clinical_trials1` FOREIGN KEY (`clinical_trials_clinical_trial_id`) REFERENCES `clinical_trials` (`clinical_trial_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patients_hospitals` FOREIGN KEY (`hospitals_hospital_id`) REFERENCES `hospitals` (`hospital_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (10001,'Gaviin','Jep',' 9020 Garland Rd','Dallas','TX','75218','M','2000-11-01',1,'HG1141'),(13001,'Herbie','Williams','2136 Murray Hill Rd','Cleveland','OH','44106','M','1995-09-21',2,'HG8143'),(38001,'Terry','Noel','502 Church St','Danville','PA','17821','F','2000-02-28',3,'HGG173'),(38002,'Paden','Heidi','331 W Mahoning St','Danville','PA','17821','F','1984-08-27',3,'HG1141');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-01  8:45:43
