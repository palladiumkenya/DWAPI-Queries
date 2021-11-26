-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: openmrs
-- ------------------------------------------------------
-- Server version	5.6.16-1~exp1

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
-- Table structure for table `allergy`
--

DROP TABLE IF EXISTS `allergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allergy` (
  `allergy_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `severity_concept_id` int(11) DEFAULT NULL,
  `coded_allergen` int(11) NOT NULL,
  `non_coded_allergen` varchar(255) DEFAULT NULL,
  `allergen_type` varchar(50) DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '1',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_id`),
  UNIQUE KEY `allergy_id` (`allergy_id`),
  KEY `allergy_patient_id_fk` (`patient_id`),
  KEY `allergy_coded_allergen_fk` (`coded_allergen`),
  KEY `allergy_severity_concept_id_fk` (`severity_concept_id`),
  KEY `allergy_creator_fk` (`creator`),
  KEY `allergy_changed_by_fk` (`changed_by`),
  KEY `allergy_voided_by_fk` (`voided_by`),
  CONSTRAINT `allergy_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `allergy_coded_allergen_fk` FOREIGN KEY (`coded_allergen`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `allergy_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `allergy_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `allergy_severity_concept_id_fk` FOREIGN KEY (`severity_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `allergy_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `allergy_reaction`
--

DROP TABLE IF EXISTS `allergy_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allergy_reaction` (
  `allergy_reaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `allergy_id` int(11) NOT NULL,
  `reaction_concept_id` int(11) NOT NULL,
  `reaction_non_coded` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_reaction_id`),
  UNIQUE KEY `allergy_reaction_id` (`allergy_reaction_id`),
  KEY `allergy_reaction_allergy_id_fk` (`allergy_id`),
  KEY `allergy_reaction_reaction_concept_id_fk` (`reaction_concept_id`),
  CONSTRAINT `allergy_reaction_allergy_id_fk` FOREIGN KEY (`allergy_id`) REFERENCES `allergy` (`allergy_id`),
  CONSTRAINT `allergy_reaction_reaction_concept_id_fk` FOREIGN KEY (`reaction_concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appframework_component_state`
--

DROP TABLE IF EXISTS `appframework_component_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appframework_component_state` (
  `component_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `component_id` varchar(255) DEFAULT NULL,
  `component_type` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`component_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appframework_user_app`
--

DROP TABLE IF EXISTS `appframework_user_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appframework_user_app` (
  `app_id` varchar(50) NOT NULL DEFAULT '',
  `json` mediumtext,
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_appointment`
--

DROP TABLE IF EXISTS `appointmentscheduling_appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_appointment` (
  `appointment_id` int(11) NOT NULL AUTO_INCREMENT,
  `time_slot_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_type_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `reason` varchar(1024) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `cancel_reason` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `appointment_creator` (`creator`),
  KEY `appointment_changed_by` (`changed_by`),
  KEY `appointment_voided_by` (`voided_by`),
  KEY `appointment_time_slot_id` (`time_slot_id`),
  KEY `appointment_appointment_type_id` (`appointment_type_id`),
  KEY `appointment_visit_id` (`visit_id`),
  KEY `appointment_patient_id` (`patient_id`),
  CONSTRAINT `appointment_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `appointmentscheduling_appointment_type` (`appointment_type_id`),
  CONSTRAINT `appointment_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `appointment_time_slot_id` FOREIGN KEY (`time_slot_id`) REFERENCES `appointmentscheduling_time_slot` (`time_slot_id`),
  CONSTRAINT `appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`),
  CONSTRAINT `appointment_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_appointment_block`
--

DROP TABLE IF EXISTS `appointmentscheduling_appointment_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_appointment_block` (
  `appointment_block_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`appointment_block_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `appointment_block_creator` (`creator`),
  KEY `appointment_block_changed_by` (`changed_by`),
  KEY `appointment_block_voided_by` (`voided_by`),
  KEY `appointment_block_location_id` (`location_id`),
  KEY `appointment_block_provider_id` (`provider_id`),
  CONSTRAINT `appointment_block_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_block_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_block_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `appointment_block_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `appointment_block_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_appointment_request`
--

DROP TABLE IF EXISTS `appointmentscheduling_appointment_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_appointment_request` (
  `appointment_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `appointment_type_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `requested_by` int(11) DEFAULT NULL,
  `requested_on` datetime NOT NULL,
  `min_time_frame_value` int(11) DEFAULT NULL,
  `min_time_frame_units` varchar(255) DEFAULT NULL,
  `max_time_frame_value` int(11) DEFAULT NULL,
  `max_time_frame_units` varchar(255) DEFAULT NULL,
  `notes` varchar(1024) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`appointment_request_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `appointment_request_creator` (`creator`),
  KEY `appointment_request_changed_by` (`changed_by`),
  KEY `appointment_request_voided_by` (`voided_by`),
  KEY `appointment_request_appointment_type_id` (`appointment_type_id`),
  KEY `appointment_request_patient_id` (`patient_id`),
  KEY `appointment_request_provider_id` (`provider_id`),
  KEY `appointment_request_requested_by` (`requested_by`),
  CONSTRAINT `appointment_request_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `appointmentscheduling_appointment_type` (`appointment_type_id`),
  CONSTRAINT `appointment_request_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_request_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_request_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `appointment_request_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `appointment_request_requested_by` FOREIGN KEY (`requested_by`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `appointment_request_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_appointment_status_history`
--

DROP TABLE IF EXISTS `appointmentscheduling_appointment_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_appointment_status_history` (
  `appointment_status_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`appointment_status_history_id`),
  KEY `appointment_status_history_appointment` (`appointment_id`),
  CONSTRAINT `appointment_status_history_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointmentscheduling_appointment` (`appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_appointment_type`
--

DROP TABLE IF EXISTS `appointmentscheduling_appointment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_appointment_type` (
  `appointment_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `confidential` tinyint(4) NOT NULL DEFAULT '0',
  `visit_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`appointment_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `appointment_type_creator` (`creator`),
  KEY `appointment_type_changed_by` (`changed_by`),
  KEY `appointment_type_retired_by` (`retired_by`),
  KEY `appointment_type_visit_type_id` (`visit_type_id`),
  CONSTRAINT `appointment_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_type_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_type_visit_type_id` FOREIGN KEY (`visit_type_id`) REFERENCES `visit_type` (`visit_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_block_type_map`
--

DROP TABLE IF EXISTS `appointmentscheduling_block_type_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_block_type_map` (
  `appointment_type_id` int(11) NOT NULL,
  `appointment_block_id` int(11) NOT NULL,
  PRIMARY KEY (`appointment_type_id`,`appointment_block_id`),
  KEY `appointment_block_type_map_appointment_block_id` (`appointment_block_id`),
  CONSTRAINT `appointment_block_type_map_appointment_block_id` FOREIGN KEY (`appointment_block_id`) REFERENCES `appointmentscheduling_appointment_block` (`appointment_block_id`),
  CONSTRAINT `appointment_block_type_map_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `appointmentscheduling_appointment_type` (`appointment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_provider_schedule`
--

DROP TABLE IF EXISTS `appointmentscheduling_provider_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_provider_schedule` (
  `provider_schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '1',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`provider_schedule_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_schedule_creator` (`creator`),
  KEY `provider_schedule_changed_by` (`changed_by`),
  KEY `provider_schedule_voided_by` (`voided_by`),
  KEY `provider_schedule_location_id` (`location_id`),
  KEY `provider_schedule_provider_id` (`provider_id`),
  CONSTRAINT `provider_schedule_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_schedule_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `provider_schedule_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `provider_schedule_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_provider_type_map`
--

DROP TABLE IF EXISTS `appointmentscheduling_provider_type_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_provider_type_map` (
  `appointment_type_id` int(11) NOT NULL,
  `provider_schedule_id` int(11) NOT NULL,
  PRIMARY KEY (`appointment_type_id`,`provider_schedule_id`),
  KEY `appointmentscheduling_provider_type_map_provider_schedule_id` (`provider_schedule_id`),
  CONSTRAINT `appointmentscheduling_provider_type_map_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `appointmentscheduling_appointment_type` (`appointment_type_id`),
  CONSTRAINT `appointmentscheduling_provider_type_map_provider_schedule_id` FOREIGN KEY (`provider_schedule_id`) REFERENCES `appointmentscheduling_provider_schedule` (`provider_schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentscheduling_time_slot`
--

DROP TABLE IF EXISTS `appointmentscheduling_time_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointmentscheduling_time_slot` (
  `time_slot_id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_block_id` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`time_slot_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `appointment_slot_creator` (`creator`),
  KEY `appointment_slot__changed_by` (`changed_by`),
  KEY `appointment_slot_voided_by` (`voided_by`),
  KEY `appointment_slot_appointment_block_id` (`appointment_block_id`),
  CONSTRAINT `appointment_slot_appointment_block_id` FOREIGN KEY (`appointment_block_id`) REFERENCES `appointmentscheduling_appointment_block` (`appointment_block_id`),
  CONSTRAINT `appointment_slot_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_slot_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `appointment_slot__changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calculation_registration`
--

DROP TABLE IF EXISTS `calculation_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calculation_registration` (
  `calculation_registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `provider_class_name` varchar(512) DEFAULT NULL,
  `calculation_name` varchar(512) DEFAULT NULL,
  `configuration` text,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`calculation_registration_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `care_setting`
--

DROP TABLE IF EXISTS `care_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `care_setting` (
  `care_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `care_setting_type` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`care_setting_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `name` (`name`),
  KEY `care_setting_creator` (`creator`),
  KEY `care_setting_retired_by` (`retired_by`),
  KEY `care_setting_changed_by` (`changed_by`),
  CONSTRAINT `care_setting_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `care_setting_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `care_setting_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clob_datatype_storage`
--

DROP TABLE IF EXISTS `clob_datatype_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clob_datatype_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `value` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `clob_datatype_storage_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cohort`
--

DROP TABLE IF EXISTS `cohort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cohort` (
  `cohort_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`cohort_id`),
  UNIQUE KEY `cohort_uuid_index` (`uuid`),
  KEY `user_who_changed_cohort` (`changed_by`),
  KEY `cohort_creator` (`creator`),
  KEY `user_who_voided_cohort` (`voided_by`),
  CONSTRAINT `cohort_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_cohort` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_cohort` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cohort_member`
--

DROP TABLE IF EXISTS `cohort_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cohort_member` (
  `cohort_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `cohort_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`cohort_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `member_patient` (`patient_id`),
  KEY `cohort_member_creator` (`creator`),
  KEY `parent_cohort` (`cohort_id`),
  CONSTRAINT `cohort_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `member_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `parent_cohort` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept`
--

DROP TABLE IF EXISTS `concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept` (
  `concept_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `short_name` varchar(255) DEFAULT NULL,
  `description` text,
  `form_text` text,
  `datatype_id` int(11) NOT NULL DEFAULT '0',
  `class_id` int(11) NOT NULL DEFAULT '0',
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `version` varchar(50) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  UNIQUE KEY `concept_uuid_index` (`uuid`),
  KEY `concept_classes` (`class_id`),
  KEY `concept_creator` (`creator`),
  KEY `concept_datatypes` (`datatype_id`),
  KEY `user_who_changed_concept` (`changed_by`),
  KEY `concept_code` (`version`),
  KEY `concept_ndx` (`version`),
  KEY `user_who_retired_concept` (`retired_by`),
  CONSTRAINT `concept_classes` FOREIGN KEY (`class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `concept_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_datatypes` FOREIGN KEY (`datatype_id`) REFERENCES `concept_datatype` (`concept_datatype_id`),
  CONSTRAINT `user_who_changed_concept` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=165380 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_answer`
--

DROP TABLE IF EXISTS `concept_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_answer` (
  `concept_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `answer_concept` int(11) DEFAULT NULL,
  `answer_drug` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uuid` char(38) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  PRIMARY KEY (`concept_answer_id`),
  UNIQUE KEY `concept_answer_uuid_index` (`uuid`),
  KEY `answer_creator` (`creator`),
  KEY `answer` (`answer_concept`),
  KEY `answers_for_concept` (`concept_id`),
  KEY `answer_answer_drug_fk` (`answer_drug`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_concept`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answers_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_answer_drug_fk` FOREIGN KEY (`answer_drug`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `answer_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7142 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_attribute`
--

DROP TABLE IF EXISTS `concept_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_attribute` (
  `concept_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_concept_fk` (`concept_id`),
  KEY `concept_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `concept_attribute_creator_fk` (`creator`),
  KEY `concept_attribute_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `concept_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `concept_attribute_type` (`concept_attribute_type_id`),
  CONSTRAINT `concept_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_concept_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `concept_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_attribute_type`
--

DROP TABLE IF EXISTS `concept_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_attribute_type` (
  `concept_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_type_creator_fk` (`creator`),
  KEY `concept_attribute_type_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `concept_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_class`
--

DROP TABLE IF EXISTS `concept_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_class` (
  `concept_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_class_id`),
  UNIQUE KEY `concept_class_uuid_index` (`uuid`),
  KEY `concept_class_creator` (`creator`),
  KEY `user_who_retired_concept_class` (`retired_by`),
  KEY `concept_class_retired_status` (`retired`),
  KEY `concept_class_name_index` (`name`),
  KEY `concept_class_changed_by` (`changed_by`),
  CONSTRAINT `concept_class_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_class_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_class` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_complex`
--

DROP TABLE IF EXISTS `concept_complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_complex` (
  `concept_id` int(11) NOT NULL,
  `handler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `concept_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_datatype`
--

DROP TABLE IF EXISTS `concept_datatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_datatype` (
  `concept_datatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `hl7_abbreviation` varchar(3) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_datatype_id`),
  UNIQUE KEY `concept_datatype_uuid_index` (`uuid`),
  KEY `concept_datatype_creator` (`creator`),
  KEY `user_who_retired_concept_datatype` (`retired_by`),
  KEY `concept_datatype_retired_status` (`retired`),
  KEY `concept_datatype_name_index` (`name`),
  CONSTRAINT `concept_datatype_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_datatype` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_description`
--

DROP TABLE IF EXISTS `concept_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_description` (
  `concept_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `locale` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_description_id`),
  UNIQUE KEY `concept_description_uuid_index` (`uuid`),
  KEY `concept_being_described` (`concept_id`),
  KEY `user_who_created_description` (`creator`),
  KEY `user_who_changed_description` (`changed_by`),
  CONSTRAINT `description_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_description` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_description` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18581 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_map_type`
--

DROP TABLE IF EXISTS `concept_map_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_map_type` (
  `concept_map_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_map_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `name` (`name`),
  KEY `mapped_user_creator_concept_map_type` (`creator`),
  KEY `mapped_user_changed_concept_map_type` (`changed_by`),
  KEY `mapped_user_retired_concept_map_type` (`retired_by`),
  CONSTRAINT `mapped_user_changed_concept_map_type` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator_concept_map_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_retired_concept_map_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_name`
--

DROP TABLE IF EXISTS `concept_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_name` (
  `concept_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `locale` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `concept_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `concept_name_type` varchar(50) DEFAULT NULL,
  `locale_preferred` tinyint(1) DEFAULT '0',
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_id`),
  UNIQUE KEY `concept_name_id` (`concept_name_id`),
  UNIQUE KEY `concept_name_uuid_index` (`uuid`),
  KEY `user_who_created_name` (`creator`),
  KEY `name_of_concept` (`name`),
  KEY `concept_id` (`concept_id`),
  KEY `unique_concept_name_id` (`concept_id`),
  KEY `user_who_voided_name` (`voided_by`),
  KEY `concept_name_changed_by` (`changed_by`),
  CONSTRAINT `concept_name_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `name_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_this_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141929 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_name_tag`
--

DROP TABLE IF EXISTS `concept_name_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_name_tag` (
  `concept_name_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) DEFAULT NULL,
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_tag_id`),
  UNIQUE KEY `concept_name_tag_id` (`concept_name_tag_id`),
  UNIQUE KEY `concept_name_tag_id_2` (`concept_name_tag_id`),
  UNIQUE KEY `concept_name_tag_uuid_index` (`uuid`),
  UNIQUE KEY `concept_name_tag_unique_tags` (`tag`),
  KEY `user_who_created_name_tag` (`creator`),
  KEY `user_who_voided_name_tag` (`voided_by`),
  KEY `concept_name_tag_changed_by` (`changed_by`),
  CONSTRAINT `concept_name_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_name_tag_map`
--

DROP TABLE IF EXISTS `concept_name_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_name_tag_map` (
  `concept_name_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `map_name` (`concept_name_id`),
  KEY `map_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `mapped_concept_name_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_numeric`
--

DROP TABLE IF EXISTS `concept_numeric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_numeric` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `hi_absolute` double DEFAULT NULL,
  `hi_critical` double DEFAULT NULL,
  `hi_normal` double DEFAULT NULL,
  `low_absolute` double DEFAULT NULL,
  `low_critical` double DEFAULT NULL,
  `low_normal` double DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `allow_decimal` tinyint(1) DEFAULT NULL,
  `display_precision` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `numeric_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_proposal`
--

DROP TABLE IF EXISTS `concept_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_proposal` (
  `concept_proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `original_text` varchar(255) DEFAULT NULL,
  `final_text` varchar(255) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `obs_concept_id` int(11) DEFAULT NULL,
  `state` varchar(32) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale` varchar(50) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_proposal_id`),
  UNIQUE KEY `concept_proposal_uuid_index` (`uuid`),
  KEY `user_who_changed_proposal` (`changed_by`),
  KEY `concept_for_proposal` (`concept_id`),
  KEY `user_who_created_proposal` (`creator`),
  KEY `encounter_for_proposal` (`encounter_id`),
  KEY `proposal_obs_concept_id` (`obs_concept_id`),
  KEY `proposal_obs_id` (`obs_id`),
  CONSTRAINT `concept_for_proposal` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `encounter_for_proposal` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `proposal_obs_concept_id` FOREIGN KEY (`obs_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `proposal_obs_id` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_changed_proposal` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_proposal` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_proposal_tag_map`
--

DROP TABLE IF EXISTS `concept_proposal_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_proposal_tag_map` (
  `concept_proposal_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_proposal_tag` (`concept_name_tag_id`),
  KEY `mapped_concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal` FOREIGN KEY (`concept_proposal_id`) REFERENCES `concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_reference_map`
--

DROP TABLE IF EXISTS `concept_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_reference_map` (
  `concept_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `uuid` char(38) DEFAULT NULL,
  `concept_reference_term_id` int(11) NOT NULL,
  `concept_map_type_id` int(11) NOT NULL DEFAULT '1',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`concept_map_id`),
  UNIQUE KEY `concept_map_uuid_index` (`uuid`),
  UNIQUE KEY `concept_reference_map_uuid_id` (`uuid`),
  KEY `map_creator` (`creator`),
  KEY `map_for_concept` (`concept_id`),
  KEY `mapped_concept_map_type` (`concept_map_type_id`),
  KEY `mapped_user_changed_ref_term` (`changed_by`),
  KEY `mapped_concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_concept_map_type` FOREIGN KEY (`concept_map_type_id`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `mapped_concept_reference_term` FOREIGN KEY (`concept_reference_term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_user_changed_ref_term` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `map_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=282934 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_reference_source`
--

DROP TABLE IF EXISTS `concept_reference_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_reference_source` (
  `concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `hl7_code` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `unique_id` varchar(250) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_source_id`),
  UNIQUE KEY `concept_source_uuid_index` (`uuid`),
  UNIQUE KEY `concept_reference_source_uuid_id` (`uuid`),
  UNIQUE KEY `concept_source_unique_hl7_codes` (`hl7_code`),
  UNIQUE KEY `concept_reference_source_unique_id_unique` (`unique_id`),
  KEY `concept_source_creator` (`creator`),
  KEY `user_who_voided_concept_source` (`retired_by`),
  KEY `unique_hl7_code` (`hl7_code`,`retired`),
  KEY `concept_reference_source_changed_by` (`changed_by`),
  CONSTRAINT `concept_reference_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_reference_term`
--

DROP TABLE IF EXISTS `concept_reference_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_reference_term` (
  `concept_reference_term_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_reference_term_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_creator` (`creator`),
  KEY `mapped_user_changed` (`changed_by`),
  KEY `mapped_user_retired` (`retired_by`),
  KEY `mapped_concept_source` (`concept_source_id`),
  KEY `idx_code_concept_reference_term` (`code`),
  CONSTRAINT `mapped_concept_source` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`),
  CONSTRAINT `mapped_user_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_retired` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=282933 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_reference_term_map`
--

DROP TABLE IF EXISTS `concept_reference_term_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_reference_term_map` (
  `concept_reference_term_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `term_a_id` int(11) NOT NULL,
  `term_b_id` int(11) NOT NULL,
  `a_is_to_b_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_reference_term_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_term_a` (`term_a_id`),
  KEY `mapped_term_b` (`term_b_id`),
  KEY `mapped_concept_map_type_ref_term_map` (`a_is_to_b_id`),
  KEY `mapped_user_creator_ref_term_map` (`creator`),
  KEY `mapped_user_changed_ref_term_map` (`changed_by`),
  CONSTRAINT `mapped_concept_map_type_ref_term_map` FOREIGN KEY (`a_is_to_b_id`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `mapped_term_a` FOREIGN KEY (`term_a_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_term_b` FOREIGN KEY (`term_b_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_user_changed_ref_term_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator_ref_term_map` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_set`
--

DROP TABLE IF EXISTS `concept_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_set` (
  `concept_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_set_id`),
  UNIQUE KEY `concept_set_uuid_index` (`uuid`),
  KEY `has_a` (`concept_set`),
  KEY `user_who_created` (`creator`),
  KEY `idx_concept_set_concept` (`concept_id`),
  CONSTRAINT `has_a` FOREIGN KEY (`concept_set`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `is_a` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2440 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_state_conversion`
--

DROP TABLE IF EXISTS `concept_state_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_state_conversion` (
  `concept_state_conversion_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT '0',
  `program_workflow_id` int(11) DEFAULT '0',
  `program_workflow_state_id` int(11) DEFAULT '0',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_state_conversion_id`),
  UNIQUE KEY `concept_state_conversion_uuid_index` (`uuid`),
  UNIQUE KEY `unique_workflow_concept_in_conversion` (`program_workflow_id`,`concept_id`),
  KEY `triggering_concept` (`concept_id`),
  KEY `affected_workflow` (`program_workflow_id`),
  KEY `resulting_state` (`program_workflow_state_id`),
  CONSTRAINT `concept_triggers_conversion` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `conversion_involves_workflow` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`),
  CONSTRAINT `conversion_to_state` FOREIGN KEY (`program_workflow_state_id`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concept_stop_word`
--

DROP TABLE IF EXISTS `concept_stop_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concept_stop_word` (
  `concept_stop_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) DEFAULT NULL,
  `locale` varchar(50) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`concept_stop_word_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `Unique_StopWord_Key` (`word`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conditions` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `additional_detail` varchar(255) DEFAULT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `condition_coded` int(11) DEFAULT NULL,
  `condition_non_coded` varchar(255) DEFAULT NULL,
  `condition_coded_name` int(11) DEFAULT NULL,
  `clinical_status` varchar(50) DEFAULT NULL,
  `verification_status` varchar(50) DEFAULT NULL,
  `onset_date` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`condition_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `condition_previous_version_fk` (`previous_version`),
  KEY `condition_condition_coded_fk` (`condition_coded`),
  KEY `condition_condition_coded_name_fk` (`condition_coded_name`),
  KEY `condition_creator_fk` (`creator`),
  KEY `condition_changed_by_fk` (`changed_by`),
  KEY `condition_voided_by_fk` (`voided_by`),
  KEY `condition_patient_fk` (`patient_id`),
  KEY `conditions_encounter_id_fk` (`encounter_id`),
  CONSTRAINT `conditions_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `condition_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `condition_condition_coded_fk` FOREIGN KEY (`condition_coded`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `condition_condition_coded_name_fk` FOREIGN KEY (`condition_coded_name`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `condition_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `condition_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `condition_previous_version_fk` FOREIGN KEY (`previous_version`) REFERENCES `conditions` (`condition_id`),
  CONSTRAINT `condition_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `combination` tinyint(1) NOT NULL DEFAULT '0',
  `dosage_form` int(11) DEFAULT NULL,
  `maximum_daily_dose` double DEFAULT NULL,
  `minimum_daily_dose` double DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `strength` varchar(255) DEFAULT NULL,
  `dose_limit_units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `drug_uuid_index` (`uuid`),
  KEY `primary_drug_concept` (`concept_id`),
  KEY `drug_creator` (`creator`),
  KEY `drug_changed_by` (`changed_by`),
  KEY `dosage_form_concept` (`dosage_form`),
  KEY `drug_retired_by` (`retired_by`),
  KEY `route_concept` (`route`),
  KEY `drug_dose_limit_units_fk` (`dose_limit_units`),
  CONSTRAINT `dosage_form_concept` FOREIGN KEY (`dosage_form`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `drug_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `drug_dose_limit_units_fk` FOREIGN KEY (`dose_limit_units`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `primary_drug_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `route_concept` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2226 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_ingredient`
--

DROP TABLE IF EXISTS `drug_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_ingredient` (
  `drug_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `strength` double DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`,`ingredient_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `drug_ingredient_units_fk` (`units`),
  KEY `drug_ingredient_ingredient_id_fk` (`ingredient_id`),
  CONSTRAINT `drug_ingredient_drug_id_fk` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `drug_ingredient_ingredient_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_ingredient_units_fk` FOREIGN KEY (`units`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_order`
--

DROP TABLE IF EXISTS `drug_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `drug_inventory_id` int(11) DEFAULT NULL,
  `dose` double DEFAULT NULL,
  `as_needed` tinyint(1) DEFAULT NULL,
  `dosing_type` varchar(255) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `as_needed_condition` varchar(255) DEFAULT NULL,
  `num_refills` int(11) DEFAULT NULL,
  `dosing_instructions` text,
  `duration` int(11) DEFAULT NULL,
  `duration_units` int(11) DEFAULT NULL,
  `quantity_units` int(11) DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `dose_units` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `dispense_as_written` tinyint(1) NOT NULL DEFAULT '0',
  `drug_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `inventory_item` (`drug_inventory_id`),
  KEY `drug_order_duration_units_fk` (`duration_units`),
  KEY `drug_order_quantity_units` (`quantity_units`),
  KEY `drug_order_route_fk` (`route`),
  KEY `drug_order_dose_units` (`dose_units`),
  KEY `drug_order_frequency_fk` (`frequency`),
  CONSTRAINT `drug_order_dose_units` FOREIGN KEY (`dose_units`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_order_duration_units_fk` FOREIGN KEY (`duration_units`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`),
  CONSTRAINT `drug_order_quantity_units` FOREIGN KEY (`quantity_units`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_order_route_fk` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `extends_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `inventory_item` FOREIGN KEY (`drug_inventory_id`) REFERENCES `drug` (`drug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_reference_map`
--

DROP TABLE IF EXISTS `drug_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_reference_map` (
  `drug_reference_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `concept_map_type` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`drug_reference_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `drug_for_drug_reference_map` (`drug_id`),
  KEY `concept_reference_term_for_drug_reference_map` (`term_id`),
  KEY `concept_map_type_for_drug_reference_map` (`concept_map_type`),
  KEY `user_who_changed_drug_reference_map` (`changed_by`),
  KEY `drug_reference_map_creator` (`creator`),
  KEY `user_who_retired_drug_reference_map` (`retired_by`),
  CONSTRAINT `concept_map_type_for_drug_reference_map` FOREIGN KEY (`concept_map_type`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `concept_reference_term_for_drug_reference_map` FOREIGN KEY (`term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `drug_for_drug_reference_map` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `drug_reference_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_drug_reference_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_drug_reference_map` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `encounter_datetime` datetime NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `encounter_uuid_index` (`uuid`),
  KEY `encounter_datetime_idx` (`encounter_datetime`),
  KEY `encounter_ibfk_1` (`creator`),
  KEY `encounter_type_id` (`encounter_type`),
  KEY `encounter_form` (`form_id`),
  KEY `encounter_location` (`location_id`),
  KEY `encounter_patient` (`patient_id`),
  KEY `user_who_voided_encounter` (`voided_by`),
  KEY `encounter_changed_by` (`changed_by`),
  KEY `encounter_visit_id_fk` (`visit_id`),
  CONSTRAINT `encounter_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_form` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `encounter_type_id` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `encounter_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`),
  CONSTRAINT `user_who_voided_encounter` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12478 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounter_diagnosis`
--

DROP TABLE IF EXISTS `encounter_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter_diagnosis` (
  `diagnosis_id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_coded` int(11) DEFAULT NULL,
  `diagnosis_non_coded` varchar(255) DEFAULT NULL,
  `diagnosis_coded_name` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `condition_id` int(11) DEFAULT NULL,
  `certainty` varchar(255) DEFAULT NULL,
  `rank` int(11) NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_diagnosis_encounter_id_fk` (`encounter_id`),
  KEY `encounter_diagnosis_condition_id_fk` (`condition_id`),
  KEY `encounter_diagnosis_creator_fk` (`creator`),
  KEY `encounter_diagnosis_voided_by_fk` (`voided_by`),
  KEY `encounter_diagnosis_changed_by_fk` (`changed_by`),
  KEY `encounter_diagnosis_coded_fk` (`diagnosis_coded`),
  KEY `encounter_diagnosis_coded_name_fk` (`diagnosis_coded_name`),
  KEY `encounter_diagnosis_patient_fk` (`patient_id`),
  CONSTRAINT `encounter_diagnosis_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_diagnosis_coded_fk` FOREIGN KEY (`diagnosis_coded`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `encounter_diagnosis_coded_name_fk` FOREIGN KEY (`diagnosis_coded_name`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `encounter_diagnosis_condition_id_fk` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`),
  CONSTRAINT `encounter_diagnosis_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_diagnosis_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `encounter_diagnosis_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `encounter_diagnosis_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `encounter_diagnosis_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounter_provider`
--

DROP TABLE IF EXISTS `encounter_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter_provider` (
  `encounter_provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `encounter_role_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`encounter_provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_id_fk` (`encounter_id`),
  KEY `provider_id_fk` (`provider_id`),
  KEY `encounter_role_id_fk` (`encounter_role_id`),
  KEY `encounter_provider_creator` (`creator`),
  KEY `encounter_provider_changed_by` (`changed_by`),
  KEY `encounter_provider_voided_by` (`voided_by`),
  CONSTRAINT `encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `encounter_provider_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_provider_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_provider_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_id_fk` FOREIGN KEY (`encounter_role_id`) REFERENCES `encounter_role` (`encounter_role_id`),
  CONSTRAINT `provider_id_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11531 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounter_role`
--

DROP TABLE IF EXISTS `encounter_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter_role` (
  `encounter_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`encounter_role_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `encounter_role_unique_name` (`name`),
  KEY `encounter_role_creator_fk` (`creator`),
  KEY `encounter_role_changed_by_fk` (`changed_by`),
  KEY `encounter_role_retired_by_fk` (`retired_by`),
  CONSTRAINT `encounter_role_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounter_type`
--

DROP TABLE IF EXISTS `encounter_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter_type` (
  `encounter_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `view_privilege` varchar(255) DEFAULT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_type_id`),
  UNIQUE KEY `encounter_type_uuid_index` (`uuid`),
  UNIQUE KEY `encounter_type_unique_name` (`name`),
  KEY `encounter_type_retired_status` (`retired`),
  KEY `user_who_created_type` (`creator`),
  KEY `user_who_retired_encounter_type` (`retired_by`),
  KEY `privilege_which_can_view_encounter_type` (`view_privilege`),
  KEY `privilege_which_can_edit_encounter_type` (`edit_privilege`),
  KEY `encounter_type_changed_by` (`changed_by`),
  CONSTRAINT `encounter_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `privilege_which_can_edit_encounter_type` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `privilege_which_can_view_encounter_type` FOREIGN KEY (`view_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `user_who_created_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_encounter_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expanded_cohort_definition`
--

DROP TABLE IF EXISTS `expanded_cohort_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expanded_cohort_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cohort_id` int(11) DEFAULT NULL,
  `sql_definition` text,
  `is_scheduled` tinyint(4) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `enable_member_addition` tinyint(4) NOT NULL DEFAULT '0',
  `enable_member_removal` tinyint(4) NOT NULL DEFAULT '0',
  `enable_filter_by_provider` tinyint(4) NOT NULL DEFAULT '0',
  `enable_filter_by_location` tinyint(4) NOT NULL DEFAULT '0',
  `filter_query` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expanded_cohort_update_history`
--

DROP TABLE IF EXISTS `expanded_cohort_update_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expanded_cohort_update_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cohort_id` int(11) NOT NULL,
  `members_added` longtext,
  `date_updated` datetime NOT NULL,
  `members_removed` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `field_type` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `default_value` text,
  `select_multiple` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `field_uuid_index` (`uuid`),
  KEY `field_retired_status` (`retired`),
  KEY `user_who_changed_field` (`changed_by`),
  KEY `concept_for_field` (`concept_id`),
  KEY `user_who_created_field` (`creator`),
  KEY `type_of_field` (`field_type`),
  KEY `user_who_retired_field` (`retired_by`),
  CONSTRAINT `concept_for_field` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `type_of_field` FOREIGN KEY (`field_type`) REFERENCES `field_type` (`field_type_id`),
  CONSTRAINT `user_who_changed_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_field` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_answer`
--

DROP TABLE IF EXISTS `field_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_answer` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `answer_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`field_id`,`answer_id`),
  UNIQUE KEY `field_answer_uuid_index` (`uuid`),
  KEY `field_answer_concept` (`answer_id`),
  KEY `user_who_created_field_answer` (`creator`),
  CONSTRAINT `answers_for_field` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `field_answer_concept` FOREIGN KEY (`answer_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_field_answer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_type` (
  `field_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`field_type_id`),
  UNIQUE KEY `field_type_uuid_index` (`uuid`),
  KEY `user_who_created_field_type` (`creator`),
  CONSTRAINT `user_who_created_field_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `build` int(11) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `xslt` text,
  `template` text,
  `description` text,
  `encounter_type` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `form_uuid_index` (`uuid`),
  KEY `form_published_index` (`published`),
  KEY `form_retired_index` (`retired`),
  KEY `form_published_and_retired_index` (`published`,`retired`),
  KEY `user_who_last_changed_form` (`changed_by`),
  KEY `user_who_created_form` (`creator`),
  KEY `form_encounter_type` (`encounter_type`),
  KEY `user_who_retired_form` (`retired_by`),
  CONSTRAINT `form_encounter_type` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `user_who_created_form` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_field` (
  `form_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL DEFAULT '0',
  `field_number` int(11) DEFAULT NULL,
  `field_part` varchar(5) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `parent_form_field` int(11) DEFAULT NULL,
  `min_occurs` int(11) DEFAULT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`form_field_id`),
  UNIQUE KEY `form_field_uuid_index` (`uuid`),
  KEY `user_who_last_changed_form_field` (`changed_by`),
  KEY `user_who_created_form_field` (`creator`),
  KEY `field_within_form` (`field_id`),
  KEY `form_containing_field` (`form_id`),
  KEY `form_field_hierarchy` (`parent_form_field`),
  CONSTRAINT `field_within_form` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `form_containing_field` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `form_field_hierarchy` FOREIGN KEY (`parent_form_field`) REFERENCES `form_field` (`form_field_id`),
  CONSTRAINT `user_who_created_form_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_resource`
--

DROP TABLE IF EXISTS `form_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_resource` (
  `form_resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value_reference` text,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `uuid` char(38) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`form_resource_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_form_and_name` (`form_id`,`name`),
  KEY `form_resource_changed_by` (`changed_by`),
  CONSTRAINT `form_resource_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `form_resource_form_fk` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_property`
--

DROP TABLE IF EXISTS `global_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_property` (
  `property` varchar(255) NOT NULL DEFAULT '',
  `property_value` text,
  `description` text,
  `uuid` char(38) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`property`),
  UNIQUE KEY `global_property_uuid_index` (`uuid`),
  KEY `global_property_property_index` (`property`),
  KEY `global_property_changed_by` (`changed_by`),
  CONSTRAINT `global_property_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groovy_scripts`
--

DROP TABLE IF EXISTS `groovy_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groovy_scripts` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `script` mediumtext,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `User who wrote this script` (`creator`),
  KEY `User who changed this script` (`changed_by`),
  CONSTRAINT `User who changed this script` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `User who wrote this script` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hl7_in_archive`
--

DROP TABLE IF EXISTS `hl7_in_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hl7_in_archive` (
  `hl7_in_archive_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` varchar(255) DEFAULT NULL,
  `hl7_data` text,
  `date_created` datetime NOT NULL,
  `message_state` int(11) DEFAULT '2',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_in_archive_id`),
  UNIQUE KEY `hl7_in_archive_uuid_index` (`uuid`),
  KEY `hl7_in_archive_message_state_idx` (`message_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hl7_in_error`
--

DROP TABLE IF EXISTS `hl7_in_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hl7_in_error` (
  `hl7_in_error_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text,
  `error` varchar(255) DEFAULT NULL,
  `error_details` mediumtext,
  `date_created` datetime NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_in_error_id`),
  UNIQUE KEY `hl7_in_error_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hl7_in_queue`
--

DROP TABLE IF EXISTS `hl7_in_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hl7_in_queue` (
  `hl7_in_queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text,
  `message_state` int(11) NOT NULL DEFAULT '0',
  `date_processed` datetime DEFAULT NULL,
  `error_msg` text,
  `date_created` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_in_queue_id`),
  UNIQUE KEY `hl7_in_queue_uuid_index` (`uuid`),
  KEY `hl7_source_with_queue` (`hl7_source`),
  CONSTRAINT `hl7_source_with_queue` FOREIGN KEY (`hl7_source`) REFERENCES `hl7_source` (`hl7_source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hl7_source`
--

DROP TABLE IF EXISTS `hl7_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hl7_source` (
  `hl7_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`hl7_source_id`),
  UNIQUE KEY `hl7_source_uuid_index` (`uuid`),
  KEY `user_who_created_hl7_source` (`creator`),
  CONSTRAINT `user_who_created_hl7_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `html5forms_form`
--

DROP TABLE IF EXISTS `html5forms_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `html5forms_form` (
  `form_id` int(11) NOT NULL DEFAULT '0',
  `model` longtext,
  `form` longtext,
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `html5forms_form_tag_mapping`
--

DROP TABLE IF EXISTS `html5forms_form_tag_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `html5forms_form_tag_mapping` (
  `form_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`form_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `html5forms_tag`
--

DROP TABLE IF EXISTS `html5forms_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `html5forms_tag` (
  `html5forms_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`html5forms_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `htmlformentry_html_form`
--

DROP TABLE IF EXISTS `htmlformentry_html_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `htmlformentry_html_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `xml_data` mediumtext,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `uuid` char(38) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `htmlformentry_html_form_uuid_index` (`uuid`),
  KEY `User who created htmlformentry_htmlform` (`creator`),
  KEY `Form with which this htmlform is related` (`form_id`),
  KEY `User who changed htmlformentry_htmlform` (`changed_by`),
  KEY `user_who_retired_html_form` (`retired_by`),
  CONSTRAINT `Form with which this htmlform is related` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `User who changed htmlformentry_htmlform` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `User who created htmlformentry_htmlform` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_html_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_auto_generation_option`
--

DROP TABLE IF EXISTS `idgen_auto_generation_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_auto_generation_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier_type` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `manual_entry_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `automatic_generation_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `location` int(11) DEFAULT NULL,
  `uuid` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idgen_auto_generation_option_uuid_index` (`uuid`),
  KEY `source for idgen_auto_generation_option` (`source`),
  KEY `location_for_auto_generation_option` (`location`),
  KEY `identifier_type for idgen_auto_generation_option` (`identifier_type`),
  CONSTRAINT `identifier_type for idgen_auto_generation_option` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `location_for_auto_generation_option` FOREIGN KEY (`location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `source for idgen_auto_generation_option` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_id_pool`
--

DROP TABLE IF EXISTS `idgen_id_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_id_pool` (
  `id` int(11) NOT NULL,
  `source` int(11) DEFAULT NULL,
  `batch_size` int(11) DEFAULT NULL,
  `min_pool_size` int(11) DEFAULT NULL,
  `sequential` tinyint(1) NOT NULL DEFAULT '0',
  `refill_with_scheduled_task` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `source for idgen_id_pool` (`source`),
  CONSTRAINT `id for idgen_id_pool` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`),
  CONSTRAINT `source for idgen_id_pool` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_identifier_source`
--

DROP TABLE IF EXISTS `idgen_identifier_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_identifier_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_identifier_source` (`id`),
  KEY `identifier_type for idgen_identifier_source` (`identifier_type`),
  KEY `creator for idgen_identifier_source` (`creator`),
  KEY `changed_by for idgen_identifier_source` (`changed_by`),
  KEY `retired_by for idgen_identifier_source` (`retired_by`),
  CONSTRAINT `changed_by for idgen_identifier_source` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator for idgen_identifier_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `identifier_type for idgen_identifier_source` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `retired_by for idgen_identifier_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_log_entry`
--

DROP TABLE IF EXISTS `idgen_log_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_log_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `date_generated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `generated_by` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_log` (`id`),
  KEY `source for idgen_log` (`source`),
  KEY `generated_by for idgen_log` (`generated_by`),
  CONSTRAINT `generated_by for idgen_log` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `source for idgen_log` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=490 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_pooled_identifier`
--

DROP TABLE IF EXISTS `idgen_pooled_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_pooled_identifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `pool_id` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `date_used` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_id for idgen_pooled_identifier` (`pool_id`),
  CONSTRAINT `pool_id for idgen_pooled_identifier` FOREIGN KEY (`pool_id`) REFERENCES `idgen_id_pool` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_remote_source`
--

DROP TABLE IF EXISTS `idgen_remote_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_remote_source` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id for idgen_remote_source` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_reserved_identifier`
--

DROP TABLE IF EXISTS `idgen_reserved_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_reserved_identifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_reserved_identifier` (`id`),
  KEY `source for idgen_reserved_identifier` (`source`),
  CONSTRAINT `source for idgen_reserved_identifier` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idgen_seq_id_gen`
--

DROP TABLE IF EXISTS `idgen_seq_id_gen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idgen_seq_id_gen` (
  `id` int(11) NOT NULL,
  `next_sequence_value` int(11) NOT NULL DEFAULT '-1',
  `base_character_set` varchar(255) DEFAULT NULL,
  `first_identifier_base` varchar(50) DEFAULT NULL,
  `prefix` varchar(100) DEFAULT NULL,
  `suffix` varchar(20) DEFAULT NULL,
  `min_length` int(11) DEFAULT NULL,
  `max_length` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id for idgen_seq_id_gen` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `il_message`
--

DROP TABLE IF EXISTS `il_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `il_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `creator` int(11) DEFAULT NULL,
  `message_type` int(11) DEFAULT NULL,
  `hl7_type` varchar(20) DEFAULT NULL,
  `retired` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `uuid` varchar(38) DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `il_message_archive`
--

DROP TABLE IF EXISTS `il_message_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `il_message_archive` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `creator` int(11) DEFAULT NULL,
  `message_type` int(11) DEFAULT NULL,
  `hl7_type` varchar(20) DEFAULT NULL,
  `retired` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `uuid` varchar(38) DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `il_message_error_queue`
--

DROP TABLE IF EXISTS `il_message_error_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `il_message_error_queue` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `creator` int(11) DEFAULT NULL,
  `message_type` int(11) DEFAULT NULL,
  `hl7_type` varchar(20) DEFAULT NULL,
  `retired` int(11) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `uuid` varchar(38) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `il_registration`
--

DROP TABLE IF EXISTS `il_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `il_registration` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `message` text,
  `creator` int(11) DEFAULT NULL,
  `message_type` int(11) DEFAULT NULL,
  `hl7_type` varchar(20) DEFAULT NULL,
  `retired` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `uuid` varchar(38) DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_aop_encounter_entry`
--

DROP TABLE IF EXISTS `kenyaemr_aop_encounter_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_aop_encounter_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_uuid` varchar(50) DEFAULT NULL,
  `form_uuid` varchar(50) DEFAULT NULL,
  `target_module` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_facilityreporting_data`
--

DROP TABLE IF EXISTS `kenyaemr_facilityreporting_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_facilityreporting_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_id` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `value` text,
  `date_created` datetime NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT '1',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kenyaemr_facilityreporting_report_data_constraint` (`report_id`),
  KEY `kenyaemr_facilityreporting_dataset_data_constraint` (`dataset_id`),
  CONSTRAINT `kenyaemr_facilityreporting_dataset_data_constraint` FOREIGN KEY (`dataset_id`) REFERENCES `kenyaemr_facilityreporting_dataset` (`id`),
  CONSTRAINT `kenyaemr_facilityreporting_report_data_constraint` FOREIGN KEY (`report_id`) REFERENCES `kenyaemr_facilityreporting_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_facilityreporting_dataset`
--

DROP TABLE IF EXISTS `kenyaemr_facilityreporting_dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_facilityreporting_dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `report_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `mapping` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mapping` (`mapping`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_facilityreporting_indicator`
--

DROP TABLE IF EXISTS `kenyaemr_facilityreporting_indicator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_facilityreporting_indicator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dataset_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `mapping` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mapping` (`mapping`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `kenyaemr_facilityreporting_dataset_constraint` (`dataset_id`),
  CONSTRAINT `kenyaemr_facilityreporting_dataset_constraint` FOREIGN KEY (`dataset_id`) REFERENCES `kenyaemr_facilityreporting_dataset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_facilityreporting_report`
--

DROP TABLE IF EXISTS `kenyaemr_facilityreporting_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_facilityreporting_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `mapping` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mapping` (`mapping`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_hiv_testing_client_trace`
--

DROP TABLE IF EXISTS `kenyaemr_hiv_testing_client_trace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_hiv_testing_client_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `contact_type` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `unique_patient_no` varchar(50) DEFAULT NULL,
  `facility_linked_to` varchar(255) DEFAULT NULL,
  `health_worker_handed_to` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  `encounter_date` datetime DEFAULT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `reason_uncontacted` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `tracing_related_patient_contact` (`client_id`),
  CONSTRAINT `tracing_related_patient_contact` FOREIGN KEY (`client_id`) REFERENCES `kenyaemr_hiv_testing_patient_contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_hiv_testing_patient_contact`
--

DROP TABLE IF EXISTS `kenyaemr_hiv_testing_patient_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_hiv_testing_patient_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `obs_group_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `birth_date` datetime DEFAULT NULL,
  `physical_address` varchar(255) DEFAULT NULL,
  `phone_contact` varchar(255) DEFAULT NULL,
  `patient_related_to` int(11) NOT NULL,
  `relationship_type` int(11) DEFAULT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `baseline_hiv_status` varchar(255) DEFAULT NULL,
  `ipv_outcome` varchar(255) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `living_with_patient` varchar(50) DEFAULT NULL,
  `pns_approach` varchar(50) DEFAULT NULL,
  `contact_listing_decline_reason` varchar(255) DEFAULT NULL,
  `consented_contact_listing` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `kemr_patient_contact_related_patient` (`patient_related_to`),
  KEY `kemr_list_group_id` (`obs_group_id`),
  CONSTRAINT `kemr_list_group_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `kemr_patient_contact_related_patient` FOREIGN KEY (`patient_related_to`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_order_entry_lab_manifest`
--

DROP TABLE IF EXISTS `kenyaemr_order_entry_lab_manifest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_order_entry_lab_manifest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `dispatch_date` datetime DEFAULT NULL,
  `courier` varchar(255) DEFAULT NULL,
  `courier_officer` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `facility_county` varchar(255) DEFAULT NULL,
  `facility_sub_county` varchar(255) DEFAULT NULL,
  `facility_email` varchar(255) DEFAULT NULL,
  `facility_phone_contact` varchar(255) DEFAULT NULL,
  `clinician_name` varchar(255) DEFAULT NULL,
  `clinician_phone_contact` varchar(255) DEFAULT NULL,
  `lab_poc_phone_number` varchar(255) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `index_manifest_status` (`status`,`voided`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_order_entry_lab_manifest_order`
--

DROP TABLE IF EXISTS `kenyaemr_order_entry_lab_manifest_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_order_entry_lab_manifest_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manifest_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `sample_type` varchar(255) DEFAULT NULL,
  `payload` text,
  `date_sent` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `result_date` date DEFAULT NULL,
  `sample_collection_date` date DEFAULT NULL,
  `sample_separation_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `last_status_check_date` datetime DEFAULT NULL,
  `date_sample_received` date DEFAULT NULL,
  `date_sample_tested` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `manifest_reference` (`manifest_id`),
  KEY `manifest_order_reference` (`order_id`),
  KEY `index_manifest_order_status` (`status`,`voided`),
  CONSTRAINT `manifest_order_reference` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `manifest_reference` FOREIGN KEY (`manifest_id`) REFERENCES `kenyaemr_order_entry_lab_manifest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_vdot_nimeconfirm_enrolment`
--

DROP TABLE IF EXISTS `kenyaemr_vdot_nimeconfirm_enrolment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_vdot_nimeconfirm_enrolment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `payload` text,
  `status` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `reason_other` varchar(300) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kenyaemr_patient` (`patient_id`),
  CONSTRAINT `kenyaemr_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kenyaemr_vdot_nimeconfirm_video_obs`
--

DROP TABLE IF EXISTS `kenyaemr_vdot_nimeconfirm_video_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kenyaemr_vdot_nimeconfirm_video_obs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `score` double DEFAULT NULL,
  `timestamp` text,
  `patient_status` varchar(255) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `voided_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_for_video_obs` (`patient_id`),
  CONSTRAINT `patient_for_video_obs` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liquibasechangelog`
--

DROP TABLE IF EXISTS `liquibasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liquibasechangelog` (
  `ID` varchar(63) NOT NULL DEFAULT '',
  `AUTHOR` varchar(63) NOT NULL DEFAULT '',
  `FILENAME` varchar(200) NOT NULL DEFAULT '',
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) DEFAULT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liquibasechangeloglock`
--

DROP TABLE IF EXISTS `liquibasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liquibasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `parent_location` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_uuid_index` (`uuid`),
  KEY `name_of_location` (`name`),
  KEY `location_retired_status` (`retired`),
  KEY `user_who_created_location` (`creator`),
  KEY `user_who_retired_location` (`retired_by`),
  KEY `parent_location` (`parent_location`),
  KEY `location_changed_by` (`changed_by`),
  CONSTRAINT `location_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `parent_location` FOREIGN KEY (`parent_location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `user_who_created_location` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_location` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13703 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_attribute`
--

DROP TABLE IF EXISTS `location_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_attribute` (
  `location_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_location_fk` (`location_id`),
  KEY `location_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `location_attribute_creator_fk` (`creator`),
  KEY `location_attribute_changed_by_fk` (`changed_by`),
  KEY `location_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `location_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `location_attribute_type` (`location_attribute_type_id`),
  CONSTRAINT `location_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13703 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_attribute_type`
--

DROP TABLE IF EXISTS `location_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_attribute_type` (
  `location_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`location_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `location_attribute_type_unique_name` (`name`),
  KEY `location_attribute_type_creator_fk` (`creator`),
  KEY `location_attribute_type_changed_by_fk` (`changed_by`),
  KEY `location_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `location_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_tag`
--

DROP TABLE IF EXISTS `location_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_tag` (
  `location_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`location_tag_id`),
  UNIQUE KEY `location_tag_uuid_index` (`uuid`),
  KEY `location_tag_creator` (`creator`),
  KEY `location_tag_retired_by` (`retired_by`),
  KEY `location_tag_changed_by` (`changed_by`),
  CONSTRAINT `location_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_tag_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_tag_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_tag_map`
--

DROP TABLE IF EXISTS `location_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_tag_map` (
  `location_id` int(11) NOT NULL,
  `location_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`location_tag_id`),
  KEY `location_tag_map_tag` (`location_tag_id`),
  CONSTRAINT `location_tag_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_tag_map_tag` FOREIGN KEY (`location_tag_id`) REFERENCES `location_tag` (`location_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_rule_definition`
--

DROP TABLE IF EXISTS `logic_rule_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic_rule_definition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `rule_content` varchar(2048) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `creator_idx` (`creator`),
  KEY `changed_by_idx` (`changed_by`),
  KEY `retired_by_idx` (`retired_by`),
  CONSTRAINT `changed_by_for_rule_definition` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_rule_definition` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `retired_by_for_rule_definition` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_rule_token`
--

DROP TABLE IF EXISTS `logic_rule_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic_rule_token` (
  `logic_rule_token_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `token` varchar(512) DEFAULT NULL,
  `class_name` varchar(512) DEFAULT NULL,
  `state` varchar(512) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`logic_rule_token_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `token_creator` (`creator`),
  KEY `token_changed_by` (`changed_by`),
  CONSTRAINT `token_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `person` (`person_id`),
  CONSTRAINT `token_creator` FOREIGN KEY (`creator`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_rule_token_tag`
--

DROP TABLE IF EXISTS `logic_rule_token_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic_rule_token_tag` (
  `logic_rule_token_id` int(11) NOT NULL,
  `tag` varchar(512) DEFAULT NULL,
  KEY `token_tag` (`logic_rule_token_id`),
  CONSTRAINT `token_tag` FOREIGN KEY (`logic_rule_token_id`) REFERENCES `logic_rule_token` (`logic_rule_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_token_registration`
--

DROP TABLE IF EXISTS `logic_token_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic_token_registration` (
  `token_registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0002-11-30 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `token` varchar(512) DEFAULT NULL,
  `provider_class_name` varchar(512) DEFAULT NULL,
  `provider_token` varchar(512) DEFAULT NULL,
  `configuration` varchar(2000) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`token_registration_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `token_registration_creator` (`creator`),
  KEY `token_registration_changed_by` (`changed_by`),
  CONSTRAINT `token_registration_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `token_registration_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logic_token_registration_tag`
--

DROP TABLE IF EXISTS `logic_token_registration_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logic_token_registration_tag` (
  `token_registration_id` int(11) NOT NULL,
  `tag` varchar(512) DEFAULT NULL,
  KEY `token_registration_tag` (`token_registration_id`),
  CONSTRAINT `token_registration_tag` FOREIGN KEY (`token_registration_id`) REFERENCES `logic_token_registration` (`token_registration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medic_archive_data`
--

DROP TABLE IF EXISTS `medic_archive_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_archive_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discriminator` varchar(255) DEFAULT NULL,
  `data_source` int(11) NOT NULL,
  `payload` mediumtext,
  `message` varchar(1024) DEFAULT NULL,
  `form_data_uuid` varchar(255) DEFAULT NULL,
  `date_archived` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `patient_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `medic_archive_data_creator` (`creator`),
  KEY `medic_archive_data_changed_by` (`changed_by`),
  KEY `medic_archive_data_data_source` (`data_source`),
  CONSTRAINT `medic_archive_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_archive_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_archive_data_data_source` FOREIGN KEY (`data_source`) REFERENCES `medic_data_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medic_data_source`
--

DROP TABLE IF EXISTS `medic_data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `medic_data_source_creator` (`creator`),
  KEY `medic_data_source_changed_by` (`changed_by`),
  KEY `medic_data_source_retired_by` (`retired_by`),
  CONSTRAINT `medic_data_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_data_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_data_source_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medic_error_data`
--

DROP TABLE IF EXISTS `medic_error_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_error_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discriminator` varchar(255) DEFAULT NULL,
  `data_source` int(11) NOT NULL,
  `payload` mediumtext,
  `message` varchar(1024) DEFAULT NULL,
  `date_processed` datetime NOT NULL,
  `location` int(11) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `form_name` varchar(255) DEFAULT NULL,
  `form_data_uuid` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `patient_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `medic_error_data_creator` (`creator`),
  KEY `medic_error_data_changed_by` (`changed_by`),
  KEY `medic_error_data_data_source` (`data_source`),
  KEY `medic_error_data_location` (`location`),
  CONSTRAINT `medic_error_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_error_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_error_data_data_source` FOREIGN KEY (`data_source`) REFERENCES `medic_data_source` (`id`),
  CONSTRAINT `medic_error_data_location` FOREIGN KEY (`location`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medic_error_message`
--

DROP TABLE IF EXISTS `medic_error_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_error_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `medic_error_data_id` int(11) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `medic_error_message_creator` (`creator`),
  KEY `medic_error_message_changed_by` (`changed_by`),
  KEY `medic_error_message_data` (`medic_error_data_id`),
  CONSTRAINT `medic_error_message_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_error_message_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_error_message_data` FOREIGN KEY (`medic_error_data_id`) REFERENCES `medic_error_data` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medic_notification_data`
--

DROP TABLE IF EXISTS `medic_notification_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_notification_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(1024) DEFAULT NULL,
  `payload` varchar(1024) DEFAULT NULL,
  `receiver` int(11) DEFAULT NULL,
  `sender` int(11) NOT NULL,
  `patient` int(11) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `medic_notification_data_creator` (`creator`),
  KEY `medic_notification_data_changed_by` (`changed_by`),
  KEY `medic_notification_data_voided_by` (`voided_by`),
  KEY `medic_notification_data_sender` (`sender`),
  KEY `medic_notification_data_receiver` (`receiver`),
  KEY `medic_notification_patient` (`patient`),
  CONSTRAINT `medic_notification_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_notification_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_notification_data_receiver` FOREIGN KEY (`receiver`) REFERENCES `person` (`person_id`),
  CONSTRAINT `medic_notification_data_sender` FOREIGN KEY (`sender`) REFERENCES `person` (`person_id`),
  CONSTRAINT `medic_notification_data_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_notification_patient` FOREIGN KEY (`patient`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medic_queue_data`
--

DROP TABLE IF EXISTS `medic_queue_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_queue_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discriminator` varchar(255) DEFAULT NULL,
  `data_source` int(11) NOT NULL,
  `payload` mediumtext,
  `creator` int(11) NOT NULL,
  `location` int(11) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `form_name` varchar(255) DEFAULT NULL,
  `form_data_uuid` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `patient_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `medic_queue_data_creator` (`creator`),
  KEY `medic_queue_data_changed_by` (`changed_by`),
  KEY `medic_queue_data_data_source` (`data_source`),
  KEY `medic_queue_data_location` (`location`),
  CONSTRAINT `medic_queue_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_queue_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_queue_data_data_source` FOREIGN KEY (`data_source`) REFERENCES `medic_data_source` (`id`),
  CONSTRAINT `medic_queue_data_location` FOREIGN KEY (`location`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medic_registration_data`
--

DROP TABLE IF EXISTS `medic_registration_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medic_registration_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temporary_uuid` char(38) DEFAULT NULL,
  `assigned_uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `temporary_uuid` (`temporary_uuid`),
  KEY `medic_registration_data_creator` (`creator`),
  KEY `medic_registration_data_changed_by` (`changed_by`),
  KEY `medic_registration_data_voided_by` (`voided_by`),
  CONSTRAINT `medic_registration_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_registration_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `medic_registration_data_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadatamapping_metadata_set`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadatamapping_metadata_set` (
  `metadata_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`metadata_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `metadatamapping_metadata_set_creator` (`creator`),
  KEY `metadatamapping_metadata_set_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_set_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_set_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadatamapping_metadata_set_member`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadatamapping_metadata_set_member` (
  `metadata_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `metadata_set_id` int(11) NOT NULL,
  `metadata_class` varchar(1024) DEFAULT NULL,
  `metadata_uuid` varchar(38) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`metadata_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_set_member_term_unique_within_set` (`metadata_set_id`,`metadata_uuid`),
  KEY `metadatamapping_metadata_set_member_creator` (`creator`),
  KEY `metadatamapping_metadata_set_member_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_set_member_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_set_member_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_metadata_set_id` FOREIGN KEY (`metadata_set_id`) REFERENCES `metadatamapping_metadata_set` (`metadata_set_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadatamapping_metadata_source`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadatamapping_metadata_source` (
  `metadata_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`metadata_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_source_name_unique` (`name`),
  KEY `metadatamapping_metadata_source_creator` (`creator`),
  KEY `metadatamapping_metadata_source_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_source_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_source_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadatamapping_metadata_term_mapping`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_term_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadatamapping_metadata_term_mapping` (
  `metadata_term_mapping_id` int(11) NOT NULL AUTO_INCREMENT,
  `metadata_source_id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `metadata_class` varchar(1024) DEFAULT NULL,
  `metadata_uuid` varchar(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`metadata_term_mapping_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_term_code_unique_within_source` (`metadata_source_id`,`code`),
  KEY `metadatamapping_metadata_term_mapping_creator` (`creator`),
  KEY `metadatamapping_metadata_term_mapping_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_term_mapping_retired_by` (`retired_by`),
  KEY `metadatamapping_idx_mdtm_retired` (`retired`),
  KEY `metadatamapping_idx_mdtm_mdclass` (`metadata_class`(255)),
  KEY `metadatamapping_idx_mdtm_mdsource` (`metadata_source_id`),
  KEY `metadatamapping_idx_mdtm_code` (`code`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_metadata_source_id` FOREIGN KEY (`metadata_source_id`) REFERENCES `metadatamapping_metadata_source` (`metadata_source_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadatasharing_exported_package`
--

DROP TABLE IF EXISTS `metadatasharing_exported_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadatasharing_exported_package` (
  `exported_package_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `group_uuid` char(38) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `date_created` datetime NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `content` longblob,
  PRIMARY KEY (`exported_package_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `group_uuid` (`group_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadatasharing_imported_item`
--

DROP TABLE IF EXISTS `metadatasharing_imported_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadatasharing_imported_item` (
  `imported_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `classname` varchar(256) DEFAULT NULL,
  `existing_uuid` char(38) DEFAULT NULL,
  `date_imported` datetime DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `import_type` tinyint(4) DEFAULT '0',
  `assessed` tinyint(1) NOT NULL,
  PRIMARY KEY (`imported_item_id`),
  KEY `uuid` (`uuid`),
  KEY `existing_uuid` (`existing_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=654 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadatasharing_imported_package`
--

DROP TABLE IF EXISTS `metadatasharing_imported_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadatasharing_imported_package` (
  `imported_package_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `group_uuid` char(38) DEFAULT NULL,
  `subscription_url` varchar(512) DEFAULT NULL,
  `subscription_status` tinyint(4) DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_imported` datetime DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `import_config` varchar(1024) DEFAULT NULL,
  `remote_version` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`imported_package_id`),
  KEY `uuid` (`uuid`),
  KEY `group_uuid` (`group_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_archive_data`
--

DROP TABLE IF EXISTS `muzima_archive_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_archive_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discriminator` varchar(255) DEFAULT NULL,
  `data_source` int(11) NOT NULL,
  `payload` longtext,
  `message` varchar(1024) DEFAULT NULL,
  `date_archived` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `patient_uuid` varchar(255) DEFAULT NULL,
  `patientUuid` varchar(255) DEFAULT NULL,
  `form_data_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_archive_data_creator` (`creator`),
  KEY `muzima_archive_data_changed_by` (`changed_by`),
  KEY `muzima_archive_data_data_source` (`data_source`),
  CONSTRAINT `muzima_archive_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_archive_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_archive_data_data_source` FOREIGN KEY (`data_source`) REFERENCES `muzima_data_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_cohort_metadata`
--

DROP TABLE IF EXISTS `muzima_cohort_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_cohort_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cohort_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_cohort_metadata_creator` (`creator`),
  KEY `muzima_cohort_metadata_changed_by` (`changed_by`),
  KEY `muzima_cohort_metadata_voided_by` (`voided_by`),
  KEY `muzima_cohort_metadata_cohort_id` (`cohort_id`),
  KEY `muzima_cohort_metadata_patient_id` (`patient_id`),
  KEY `muzima_cohort_metadata_location_id` (`location_id`),
  KEY `muzima_cohort_metadata_provider_id` (`provider_id`),
  CONSTRAINT `muzima_cohort_metadata_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_cohort_metadata_cohort_id` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`),
  CONSTRAINT `muzima_cohort_metadata_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_cohort_metadata_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `muzima_cohort_metadata_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `muzima_cohort_metadata_provider_id` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `muzima_cohort_metadata_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_cohort_report_config`
--

DROP TABLE IF EXISTS `muzima_cohort_report_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_cohort_report_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cohort_uuid` char(38) DEFAULT NULL,
  `report_designs` longtext,
  `priority` tinyint(4) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_cohort_report_config_creator` (`creator`),
  KEY `muzima_cohort_report_config_changed_by` (`changed_by`),
  KEY `muzima_cohort_report_config_retired_by` (`retired_by`),
  CONSTRAINT `muzima_cohort_report_config_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_cohort_report_config_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_cohort_report_config_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_config`
--

DROP TABLE IF EXISTS `muzima_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `config_json` longtext,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_config_creator` (`creator`),
  KEY `muzima_config_changed_by` (`changed_by`),
  KEY `muzima_config_retired_by` (`retired_by`),
  CONSTRAINT `muzima_config_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_config_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_config_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_data_source`
--

DROP TABLE IF EXISTS `muzima_data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_data_source_creator` (`creator`),
  KEY `muzima_data_source_changed_by` (`changed_by`),
  KEY `muzima_data_source_retired_by` (`retired_by`),
  CONSTRAINT `muzima_data_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_data_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_data_source_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_error_data`
--

DROP TABLE IF EXISTS `muzima_error_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_error_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discriminator` varchar(255) DEFAULT NULL,
  `data_source` int(11) NOT NULL,
  `payload` longtext,
  `message` varchar(1024) DEFAULT NULL,
  `date_processed` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `form_name` varchar(255) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_uuid` varchar(255) DEFAULT NULL,
  `location_id` varchar(255) DEFAULT NULL,
  `location_name` varchar(255) DEFAULT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `provider_name` varchar(255) DEFAULT NULL,
  `patientUuid` varchar(255) DEFAULT NULL,
  `form_data_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_error_data_creator` (`creator`),
  KEY `muzima_error_data_changed_by` (`changed_by`),
  KEY `muzima_error_data_data_source` (`data_source`),
  KEY `muzima_error_data_location` (`location`),
  KEY `muzima_error_data_provider` (`provider`),
  CONSTRAINT `muzima_error_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_error_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_error_data_data_source` FOREIGN KEY (`data_source`) REFERENCES `muzima_data_source` (`id`),
  CONSTRAINT `muzima_error_data_location` FOREIGN KEY (`location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `muzima_error_data_provider` FOREIGN KEY (`provider`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_error_message`
--

DROP TABLE IF EXISTS `muzima_error_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_error_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `muzima_error_data_id` int(11) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_error_message_creator` (`creator`),
  KEY `muzima_error_message_changed_by` (`changed_by`),
  KEY `muzima_error_message_data` (`muzima_error_data_id`),
  CONSTRAINT `muzima_error_message_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_error_message_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_error_message_data` FOREIGN KEY (`muzima_error_data_id`) REFERENCES `muzima_error_data` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_form`
--

DROP TABLE IF EXISTS `muzima_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_form` (
  `form_id` int(11) NOT NULL DEFAULT '0',
  `model_xml` longtext,
  `form_html` longtext,
  `model_json` longtext,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` date DEFAULT NULL,
  `retired` tinyint(1) DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` date DEFAULT NULL,
  `retire_reason` mediumtext,
  `uuid` char(38) DEFAULT NULL,
  `discriminator` varchar(255) DEFAULT NULL,
  `form` char(38) DEFAULT NULL,
  `meta_json` longtext,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `unique-muzima-form-uuid` (`uuid`),
  KEY `muzima_form_openmrs_form` (`form`),
  CONSTRAINT `muzima_form_openmrs_form` FOREIGN KEY (`form`) REFERENCES `form` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_form_tag`
--

DROP TABLE IF EXISTS `muzima_form_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_form_tag` (
  `muzima_form_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` date DEFAULT NULL,
  `retired` tinyint(1) DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` date DEFAULT NULL,
  `retire_reason` text,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`muzima_form_tag_id`),
  UNIQUE KEY `unique-muzima-form-tag-uuid` (`uuid`),
  UNIQUE KEY `unique-muzima-form-tag-name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_form_tag_map`
--

DROP TABLE IF EXISTS `muzima_form_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_form_tag_map` (
  `form_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` date DEFAULT NULL,
  `retired` tinyint(1) DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` date DEFAULT NULL,
  `retire_reason` text,
  PRIMARY KEY (`form_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_generated_report`
--

DROP TABLE IF EXISTS `muzima_generated_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_generated_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cohort_report_config_id` int(11) DEFAULT NULL,
  `report_request_uuid` char(38) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `report_json` longblob,
  `priority` tinyint(4) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_notification_data`
--

DROP TABLE IF EXISTS `muzima_notification_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_notification_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(1024) DEFAULT NULL,
  `payload` varchar(1024) DEFAULT NULL,
  `receiver` int(11) DEFAULT NULL,
  `sender` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_notification_data_creator` (`creator`),
  KEY `muzima_notification_data_changed_by` (`changed_by`),
  KEY `muzima_notification_data_voided_by` (`voided_by`),
  KEY `muzima_notification_data_sender` (`sender`),
  KEY `muzima_notification_data_receiver` (`receiver`),
  KEY `muzima_notification_data_role` (`role`),
  CONSTRAINT `muzima_notification_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_notification_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_notification_data_receiver` FOREIGN KEY (`receiver`) REFERENCES `person` (`person_id`),
  CONSTRAINT `muzima_notification_data_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`),
  CONSTRAINT `muzima_notification_data_sender` FOREIGN KEY (`sender`) REFERENCES `person` (`person_id`),
  CONSTRAINT `muzima_notification_data_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_patient_report`
--

DROP TABLE IF EXISTS `muzima_patient_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_patient_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cohort_report_config_id` int(11) DEFAULT NULL,
  `report_request_uuid` char(38) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `report_json` longblob,
  `priority` tinyint(4) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_queue_data`
--

DROP TABLE IF EXISTS `muzima_queue_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_queue_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discriminator` varchar(255) DEFAULT NULL,
  `data_source` int(11) NOT NULL,
  `payload` longtext,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `form_name` varchar(255) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_uuid` varchar(255) DEFAULT NULL,
  `location_id` varchar(255) DEFAULT NULL,
  `location_name` varchar(255) DEFAULT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `provider_name` varchar(255) DEFAULT NULL,
  `patientUuid` varchar(255) DEFAULT NULL,
  `form_data_uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `muzima_queue_data_creator` (`creator`),
  KEY `muzima_queue_data_changed_by` (`changed_by`),
  KEY `muzima_queue_data_data_source` (`data_source`),
  KEY `muzima_queue_data_location` (`location`),
  KEY `muzima_queue_data_provider` (`provider`),
  CONSTRAINT `muzima_queue_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_queue_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_queue_data_data_source` FOREIGN KEY (`data_source`) REFERENCES `muzima_data_source` (`id`),
  CONSTRAINT `muzima_queue_data_location` FOREIGN KEY (`location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `muzima_queue_data_provider` FOREIGN KEY (`provider`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_registration_data`
--

DROP TABLE IF EXISTS `muzima_registration_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_registration_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temporary_uuid` char(38) DEFAULT NULL,
  `assigned_uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `temporary_uuid` (`temporary_uuid`),
  KEY `muzima_registration_data_creator` (`creator`),
  KEY `muzima_registration_data_changed_by` (`changed_by`),
  KEY `muzima_registration_data_voided_by` (`voided_by`),
  CONSTRAINT `muzima_registration_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_registration_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_registration_data_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzima_setting`
--

DROP TABLE IF EXISTS `muzima_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzima_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `value_boolean` tinyint(4) DEFAULT NULL,
  `value_string` varchar(255) DEFAULT NULL,
  `setting_data_type` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `property` (`property`),
  KEY `muzima_setting_creator` (`creator`),
  KEY `muzima_setting_changed_by` (`changed_by`),
  KEY `muzima_setting_retired_by` (`retired_by`),
  CONSTRAINT `muzima_setting_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_setting_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzima_setting_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzimaforms_form`
--

DROP TABLE IF EXISTS `muzimaforms_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzimaforms_form` (
  `form_id` int(11) NOT NULL DEFAULT '0',
  `model_xml` longtext,
  `form_html` longtext,
  `model_json` longtext,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` date DEFAULT NULL,
  `retired` tinyint(1) DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` date DEFAULT NULL,
  `retire_reason` text,
  `uuid` char(38) DEFAULT NULL,
  `discriminator` varchar(255) DEFAULT NULL,
  `form` char(38) DEFAULT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `unique-muzimaforms-form-uuid` (`uuid`),
  KEY `fk_muzimaforms_form_openmrs_form` (`form`),
  CONSTRAINT `fk_muzimaforms_form_openmrs_form` FOREIGN KEY (`form`) REFERENCES `form` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzimaforms_tag`
--

DROP TABLE IF EXISTS `muzimaforms_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzimaforms_tag` (
  `name` varchar(255) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` date DEFAULT NULL,
  `retired` tinyint(1) DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` date DEFAULT NULL,
  `retire_reason` text,
  `uuid` char(38) DEFAULT NULL,
  `muzimaforms_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`muzimaforms_tag_id`),
  UNIQUE KEY `unique-muzimaforms-tag-uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzimaforms_tag_map`
--

DROP TABLE IF EXISTS `muzimaforms_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzimaforms_tag_map` (
  `form_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` date DEFAULT NULL,
  `retired` tinyint(1) DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` date DEFAULT NULL,
  `retire_reason` text,
  PRIMARY KEY (`form_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `muzimaregistration_registration_data`
--

DROP TABLE IF EXISTS `muzimaregistration_registration_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muzimaregistration_registration_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temporary_uuid` char(38) DEFAULT NULL,
  `assigned_uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(4) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `temporary_uuid` (`temporary_uuid`),
  KEY `muzimaregistration_registration_data_creator` (`creator`),
  KEY `muzimaregistration_registration_data_changed_by` (`changed_by`),
  KEY `muzimaregistration_registration_data_voided_by` (`voided_by`),
  CONSTRAINT `muzimaregistration_registration_data_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzimaregistration_registration_data_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `muzimaregistration_registration_data_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL DEFAULT '0',
  `note_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `text` text,
  `priority` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `note_uuid_index` (`uuid`),
  KEY `user_who_changed_note` (`changed_by`),
  KEY `user_who_created_note` (`creator`),
  KEY `encounter_note` (`encounter_id`),
  KEY `obs_note` (`obs_id`),
  KEY `note_hierarchy` (`parent`),
  KEY `patient_note` (`patient_id`),
  CONSTRAINT `encounter_note` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `note_hierarchy` FOREIGN KEY (`parent`) REFERENCES `note` (`note_id`),
  CONSTRAINT `obs_note` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `patient_note` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_note` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_note` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_alert`
--

DROP TABLE IF EXISTS `notification_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(512) DEFAULT NULL,
  `satisfied_by_any` tinyint(1) NOT NULL DEFAULT '0',
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_to_expire` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `notification_alert_uuid_index` (`uuid`),
  KEY `alert_date_to_expire_idx` (`date_to_expire`),
  KEY `user_who_changed_alert` (`changed_by`),
  KEY `alert_creator` (`creator`),
  CONSTRAINT `alert_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_alert` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_alert_recipient`
--

DROP TABLE IF EXISTS `notification_alert_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_alert_recipient` (
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`alert_id`,`user_id`),
  KEY `alert_read_by_user` (`user_id`),
  CONSTRAINT `alert_read_by_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `id_of_alert` FOREIGN KEY (`alert_id`) REFERENCES `notification_alert` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `template` text,
  `subject` varchar(100) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `recipients` varchar(512) DEFAULT NULL,
  `ordinal` int(11) DEFAULT '0',
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `notification_template_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `obs`
--

DROP TABLE IF EXISTS `obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obs` (
  `obs_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `obs_datetime` datetime NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `obs_group_id` int(11) DEFAULT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `value_group_id` int(11) DEFAULT NULL,
  `value_coded` int(11) DEFAULT NULL,
  `value_coded_name_id` int(11) DEFAULT NULL,
  `value_drug` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_modifier` varchar(2) DEFAULT NULL,
  `value_text` text,
  `value_complex` varchar(1000) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `interpretation` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  UNIQUE KEY `obs_uuid_index` (`uuid`),
  KEY `obs_datetime_idx` (`obs_datetime`),
  KEY `obs_concept` (`concept_id`),
  KEY `obs_enterer` (`creator`),
  KEY `encounter_observations` (`encounter_id`),
  KEY `obs_location` (`location_id`),
  KEY `obs_grouping_id` (`obs_group_id`),
  KEY `obs_order` (`order_id`),
  KEY `person_obs` (`person_id`),
  KEY `answer_concept` (`value_coded`),
  KEY `obs_name_of_coded_value` (`value_coded_name_id`),
  KEY `answer_concept_drug` (`value_drug`),
  KEY `user_who_voided_obs` (`voided_by`),
  KEY `previous_version` (`previous_version`),
  CONSTRAINT `answer_concept` FOREIGN KEY (`value_coded`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_concept_drug` FOREIGN KEY (`value_drug`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `encounter_observations` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `obs_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `obs_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `obs_grouping_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `obs_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `obs_name_of_coded_value` FOREIGN KEY (`value_coded_name_id`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `obs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `person_obs` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `previous_version` FOREIGN KEY (`previous_version`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_voided_obs` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=133604 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_frequency`
--

DROP TABLE IF EXISTS `order_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_frequency` (
  `order_frequency_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `frequency_per_day` double DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`order_frequency_id`),
  UNIQUE KEY `concept_id` (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_frequency_creator_fk` (`creator`),
  KEY `order_frequency_retired_by_fk` (`retired_by`),
  KEY `order_frequency_changed_by_fk` (`changed_by`),
  CONSTRAINT `order_frequency_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_frequency_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `order_frequency_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_frequency_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_group`
--

DROP TABLE IF EXISTS `order_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_group` (
  `order_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_set_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`order_group_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_patient_id_fk` (`patient_id`),
  KEY `order_group_encounter_id_fk` (`encounter_id`),
  KEY `order_group_creator_fk` (`creator`),
  KEY `order_group_set_id_fk` (`order_set_id`),
  KEY `order_group_voided_by_fk` (`voided_by`),
  KEY `order_group_changed_by_fk` (`changed_by`),
  CONSTRAINT `order_group_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `order_group_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `order_group_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`),
  CONSTRAINT `order_group_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_set`
--

DROP TABLE IF EXISTS `order_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_set` (
  `order_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_creator_fk` (`creator`),
  KEY `order_set_retired_by_fk` (`retired_by`),
  KEY `order_set_changed_by_fk` (`changed_by`),
  KEY `category_order_set_fk` (`category`),
  CONSTRAINT `category_order_set_fk` FOREIGN KEY (`category`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `order_set_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_set_member`
--

DROP TABLE IF EXISTS `order_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_set_member` (
  `order_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type` int(11) NOT NULL,
  `order_template` text,
  `order_template_type` varchar(1024) DEFAULT NULL,
  `order_set_id` int(11) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`order_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_member_creator_fk` (`creator`),
  KEY `order_set_member_order_set_id_fk` (`order_set_id`),
  KEY `order_set_member_concept_id_fk` (`concept_id`),
  KEY `order_set_member_order_type_fk` (`order_type`),
  KEY `order_set_member_retired_by_fk` (`retired_by`),
  KEY `order_set_member_changed_by_fk` (`changed_by`),
  CONSTRAINT `order_set_member_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_member_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `order_set_member_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_member_order_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`),
  CONSTRAINT `order_set_member_order_type_fk` FOREIGN KEY (`order_type`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `order_set_member_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_type`
--

DROP TABLE IF EXISTS `order_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `java_class_name` varchar(255) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`order_type_id`),
  UNIQUE KEY `order_type_uuid_index` (`uuid`),
  UNIQUE KEY `name` (`name`),
  KEY `order_type_retired_status` (`retired`),
  KEY `type_created_by` (`creator`),
  KEY `user_who_retired_order_type` (`retired_by`),
  KEY `order_type_changed_by` (`changed_by`),
  KEY `order_type_parent_order_type` (`parent`),
  CONSTRAINT `order_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_type_parent_order_type` FOREIGN KEY (`parent`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `type_created_by` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_order_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_type_class_map`
--

DROP TABLE IF EXISTS `order_type_class_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_type_class_map` (
  `order_type_id` int(11) NOT NULL,
  `concept_class_id` int(11) NOT NULL,
  PRIMARY KEY (`order_type_id`,`concept_class_id`),
  UNIQUE KEY `concept_class_id` (`concept_class_id`),
  CONSTRAINT `fk_order_type_class_map_concept_class_concept_class_id` FOREIGN KEY (`concept_class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `fk_order_type_order_type_id` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `orderer` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `instructions` text,
  `date_activated` datetime DEFAULT NULL,
  `auto_expire_date` datetime DEFAULT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `order_reason` int(11) DEFAULT NULL,
  `order_reason_non_coded` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `urgency` varchar(50) DEFAULT NULL,
  `order_number` varchar(50) DEFAULT NULL,
  `previous_order_id` int(11) DEFAULT NULL,
  `order_action` varchar(50) DEFAULT NULL,
  `comment_to_fulfiller` varchar(1024) DEFAULT NULL,
  `care_setting` int(11) NOT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `order_group_id` int(11) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `fulfiller_comment` varchar(1024) DEFAULT NULL,
  `fulfiller_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `orders_uuid_index` (`uuid`),
  KEY `order_creator` (`creator`),
  KEY `discontinued_because` (`order_reason`),
  KEY `orders_in_encounter` (`encounter_id`),
  KEY `type_of_order` (`order_type_id`),
  KEY `orderer_not_drug` (`orderer`),
  KEY `order_for_patient` (`patient_id`),
  KEY `user_who_voided_order` (`voided_by`),
  KEY `previous_order_id_order_id` (`previous_order_id`),
  KEY `orders_care_setting` (`care_setting`),
  KEY `orders_order_group_id_fk` (`order_group_id`),
  KEY `orders_order_number` (`order_number`),
  KEY `orders_accession_number` (`accession_number`),
  CONSTRAINT `discontinued_because` FOREIGN KEY (`order_reason`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `fk_orderer_provider` FOREIGN KEY (`orderer`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `orders_care_setting` FOREIGN KEY (`care_setting`) REFERENCES `care_setting` (`care_setting_id`),
  CONSTRAINT `orders_in_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `orders_order_group_id_fk` FOREIGN KEY (`order_group_id`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `order_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `previous_order_id_order_id` FOREIGN KEY (`previous_order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `type_of_order` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `user_who_voided_order` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `allergy_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `user_who_changed_pat` (`changed_by`),
  KEY `user_who_created_patient` (`creator`),
  KEY `user_who_voided_patient` (`voided_by`),
  CONSTRAINT `person_id_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_pat` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_patient` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_identifier`
--

DROP TABLE IF EXISTS `patient_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_identifier` (
  `patient_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `identifier` varchar(50) DEFAULT NULL,
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_id`),
  UNIQUE KEY `patient_identifier_uuid_index` (`uuid`),
  KEY `identifier_name` (`identifier`),
  KEY `idx_patient_identifier_patient` (`patient_id`),
  KEY `identifier_creator` (`creator`),
  KEY `defines_identifier_type` (`identifier_type`),
  KEY `patient_identifier_ibfk_2` (`location_id`),
  KEY `identifier_voider` (`voided_by`),
  KEY `patient_identifier_changed_by` (`changed_by`),
  CONSTRAINT `defines_identifier_type` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `fk_patient_id_patient_identifier` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `identifier_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `identifier_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_identifier_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_identifier_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1772 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_identifier_type`
--

DROP TABLE IF EXISTS `patient_identifier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_identifier_type` (
  `patient_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `format` varchar(255) DEFAULT NULL,
  `check_digit` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `format_description` varchar(255) DEFAULT NULL,
  `validator` varchar(200) DEFAULT NULL,
  `location_behavior` varchar(50) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `uniqueness_behavior` varchar(50) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_type_id`),
  UNIQUE KEY `patient_identifier_type_uuid_index` (`uuid`),
  KEY `patient_identifier_type_retired_status` (`retired`),
  KEY `type_creator` (`creator`),
  KEY `user_who_retired_patient_identifier_type` (`retired_by`),
  KEY `patient_identifier_type_changed_by` (`changed_by`),
  CONSTRAINT `patient_identifier_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_patient_identifier_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_program`
--

DROP TABLE IF EXISTS `patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_program` (
  `patient_program_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `program_id` int(11) NOT NULL DEFAULT '0',
  `date_enrolled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `outcome_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`patient_program_id`),
  UNIQUE KEY `patient_program_uuid_index` (`uuid`),
  KEY `user_who_changed` (`changed_by`),
  KEY `patient_program_creator` (`creator`),
  KEY `patient_in_program` (`patient_id`),
  KEY `program_for_patient` (`program_id`),
  KEY `user_who_voided_patient_program` (`voided_by`),
  KEY `patient_program_location_id` (`location_id`),
  KEY `patient_program_outcome_concept_id_fk` (`outcome_concept_id`),
  CONSTRAINT `patient_in_program` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_program_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `patient_program_outcome_concept_id_fk` FOREIGN KEY (`outcome_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `program_for_patient` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `user_who_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient_program` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=904 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_program_attribute`
--

DROP TABLE IF EXISTS `patient_program_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_program_attribute` (
  `patient_program_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_program_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_attribute_programid_fk` (`patient_program_id`),
  KEY `patient_program_attribute_attributetype_fk` (`attribute_type_id`),
  KEY `patient_program_attribute_creator_fk` (`creator`),
  KEY `patient_program_attribute_changed_by_fk` (`changed_by`),
  KEY `patient_program_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `patient_program_attribute_attributetype_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `program_attribute_type` (`program_attribute_type_id`),
  CONSTRAINT `patient_program_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_program_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_program_attribute_programid_fk` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`),
  CONSTRAINT `patient_program_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_state`
--

DROP TABLE IF EXISTS `patient_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_state` (
  `patient_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`patient_state_id`),
  UNIQUE KEY `patient_state_uuid_index` (`uuid`),
  KEY `patient_state_changer` (`changed_by`),
  KEY `patient_state_creator` (`creator`),
  KEY `patient_program_for_state` (`patient_program_id`),
  KEY `state_for_patient` (`state`),
  KEY `patient_state_voider` (`voided_by`),
  CONSTRAINT `patient_program_for_state` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`),
  CONSTRAINT `patient_state_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_for_patient` FOREIGN KEY (`state`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `birthdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `dead` tinyint(1) NOT NULL DEFAULT '0',
  `death_date` datetime DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `deathdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `birthtime` time DEFAULT NULL,
  `cause_of_death_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `person_uuid_index` (`uuid`),
  KEY `person_birthdate` (`birthdate`),
  KEY `person_death_date` (`death_date`),
  KEY `person_died_because` (`cause_of_death`),
  KEY `user_who_changed_person` (`changed_by`),
  KEY `user_who_created_person` (`creator`),
  KEY `user_who_voided_person` (`voided_by`),
  CONSTRAINT `person_died_because` FOREIGN KEY (`cause_of_death`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_person` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_person` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_person` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=484 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_address` (
  `person_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_address_id`),
  UNIQUE KEY `person_address_uuid_index` (`uuid`),
  KEY `patient_address_creator` (`creator`),
  KEY `address_for_person` (`person_id`),
  KEY `patient_address_void` (`voided_by`),
  KEY `person_address_changed_by` (`changed_by`),
  CONSTRAINT `address_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_address_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_address_void` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_address_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=471 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_attribute`
--

DROP TABLE IF EXISTS `person_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_attribute` (
  `person_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(50) DEFAULT NULL,
  `person_attribute_type_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_attribute_id`),
  UNIQUE KEY `person_attribute_uuid_index` (`uuid`),
  KEY `attribute_changer` (`changed_by`),
  KEY `attribute_creator` (`creator`),
  KEY `defines_attribute_type` (`person_attribute_type_id`),
  KEY `identifies_person` (`person_id`),
  KEY `attribute_voider` (`voided_by`),
  CONSTRAINT `attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`),
  CONSTRAINT `identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1623 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_attribute_type`
--

DROP TABLE IF EXISTS `person_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_attribute_type` (
  `person_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `format` varchar(50) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_attribute_type_id`),
  UNIQUE KEY `person_attribute_type_uuid_index` (`uuid`),
  KEY `attribute_is_searchable` (`searchable`),
  KEY `name_of_attribute` (`name`),
  KEY `person_attribute_type_retired_status` (`retired`),
  KEY `attribute_type_changer` (`changed_by`),
  KEY `attribute_type_creator` (`creator`),
  KEY `user_who_retired_person_attribute_type` (`retired_by`),
  KEY `privilege_which_can_edit` (`edit_privilege`),
  CONSTRAINT `attribute_type_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `privilege_which_can_edit` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `user_who_retired_person_attribute_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_merge_log`
--

DROP TABLE IF EXISTS `person_merge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_merge_log` (
  `person_merge_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `winner_person_id` int(11) NOT NULL,
  `loser_person_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `merged_data` longtext,
  `uuid` char(38) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_merge_log_id`),
  UNIQUE KEY `person_merge_log_unique_uuid` (`uuid`),
  KEY `person_merge_log_winner` (`winner_person_id`),
  KEY `person_merge_log_loser` (`loser_person_id`),
  KEY `person_merge_log_creator` (`creator`),
  KEY `person_merge_log_changed_by_fk` (`changed_by`),
  KEY `person_merge_log_voided_by_fk` (`voided_by`),
  CONSTRAINT `person_merge_log_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_loser` FOREIGN KEY (`loser_person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_merge_log_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_winner` FOREIGN KEY (`winner_person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `given_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name_prefix` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `family_name2` varchar(50) DEFAULT NULL,
  `family_name_suffix` varchar(50) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`person_name_id`),
  UNIQUE KEY `person_name_uuid_index` (`uuid`),
  KEY `first_name` (`given_name`),
  KEY `last_name` (`family_name`),
  KEY `middle_name` (`middle_name`),
  KEY `family_name2` (`family_name2`),
  KEY `user_who_made_name` (`creator`),
  KEY `name_for_person` (`person_id`),
  KEY `user_who_voided_name` (`voided_by`),
  CONSTRAINT `name_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_made_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privilege` (
  `privilege` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`privilege`),
  UNIQUE KEY `privilege_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `outcomes_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `program_uuid_index` (`uuid`),
  KEY `user_who_changed_program` (`changed_by`),
  KEY `program_concept` (`concept_id`),
  KEY `program_creator` (`creator`),
  KEY `program_outcomes_concept_id_fk` (`outcomes_concept_id`),
  CONSTRAINT `program_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_outcomes_concept_id_fk` FOREIGN KEY (`outcomes_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_program` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_attribute_type`
--

DROP TABLE IF EXISTS `program_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_attribute_type` (
  `program_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`program_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `name` (`name`),
  KEY `program_attribute_type_creator_fk` (`creator`),
  KEY `program_attribute_type_changed_by_fk` (`changed_by`),
  KEY `program_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `program_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_workflow`
--

DROP TABLE IF EXISTS `program_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_workflow` (
  `program_workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`program_workflow_id`),
  UNIQUE KEY `program_workflow_uuid_index` (`uuid`),
  KEY `workflow_changed_by` (`changed_by`),
  KEY `workflow_concept` (`concept_id`),
  KEY `workflow_creator` (`creator`),
  KEY `program_for_workflow` (`program_id`),
  CONSTRAINT `program_for_workflow` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `workflow_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `workflow_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_workflow_state`
--

DROP TABLE IF EXISTS `program_workflow_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program_workflow_state` (
  `program_workflow_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_workflow_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `initial` tinyint(1) NOT NULL DEFAULT '0',
  `terminal` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`program_workflow_state_id`),
  UNIQUE KEY `program_workflow_state_uuid_index` (`uuid`),
  KEY `state_changed_by` (`changed_by`),
  KEY `state_concept` (`concept_id`),
  KEY `state_creator` (`creator`),
  KEY `workflow_for_state` (`program_workflow_id`),
  CONSTRAINT `state_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_for_state` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_changed_by_fk` (`changed_by`),
  KEY `provider_person_id_fk` (`person_id`),
  KEY `provider_retired_by_fk` (`retired_by`),
  KEY `provider_creator_fk` (`creator`),
  KEY `provider_role_id_fk` (`role_id`),
  KEY `provider_speciality_id_fk` (`speciality_id`),
  CONSTRAINT `provider_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_person_id_fk` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `provider_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `provider_speciality_id_fk` FOREIGN KEY (`speciality_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider_attribute`
--

DROP TABLE IF EXISTS `provider_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_attribute` (
  `provider_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`provider_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_provider_fk` (`provider_id`),
  KEY `provider_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `provider_attribute_creator_fk` (`creator`),
  KEY `provider_attribute_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `provider_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `provider_attribute_type` (`provider_attribute_type_id`),
  CONSTRAINT `provider_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_provider_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `provider_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider_attribute_type`
--

DROP TABLE IF EXISTS `provider_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_attribute_type` (
  `provider_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`provider_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_type_creator_fk` (`creator`),
  KEY `provider_attribute_type_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `provider_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `psmart_store`
--

DROP TABLE IF EXISTS `psmart_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `psmart_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `shr` text,
  `date_created` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `status_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_a` int(11) NOT NULL,
  `relationship` int(11) NOT NULL DEFAULT '0',
  `person_b` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `relationship_uuid_index` (`uuid`),
  KEY `relation_creator` (`creator`),
  KEY `person_a_is_person` (`person_a`),
  KEY `person_b_is_person` (`person_b`),
  KEY `relationship_type_id` (`relationship`),
  KEY `relation_voider` (`voided_by`),
  KEY `relationship_changed_by` (`changed_by`),
  CONSTRAINT `person_a_is_person` FOREIGN KEY (`person_a`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_b_is_person` FOREIGN KEY (`person_b`) REFERENCES `person` (`person_id`),
  CONSTRAINT `relationship_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relationship_type_id` FOREIGN KEY (`relationship`) REFERENCES `relationship_type` (`relationship_type_id`),
  CONSTRAINT `relation_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relation_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship_type` (
  `relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_is_to_b` varchar(50) DEFAULT NULL,
  `b_is_to_a` varchar(50) DEFAULT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `weight` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_id`),
  UNIQUE KEY `relationship_type_uuid_index` (`uuid`),
  KEY `user_who_created_rel` (`creator`),
  KEY `user_who_retired_relationship_type` (`retired_by`),
  KEY `relationship_type_changed_by` (`changed_by`),
  CONSTRAINT `relationship_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_rel` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_relationship_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_object_type` varchar(255) DEFAULT NULL,
  `report_object_sub_type` varchar(255) DEFAULT NULL,
  `xml_data` text,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`report_object_id`),
  UNIQUE KEY `report_object_uuid_index` (`uuid`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_voided_report_object` (`voided_by`),
  CONSTRAINT `report_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_report_object` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_report_object` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_schema_xml`
--

DROP TABLE IF EXISTS `report_schema_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_schema_xml` (
  `report_schema_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `xml_data` text,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`report_schema_id`),
  UNIQUE KEY `report_schema_xml_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reporting_report_design`
--

DROP TABLE IF EXISTS `reporting_report_design`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporting_report_design` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `renderer_type` varchar(255) DEFAULT NULL,
  `properties` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `report_definition_uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `creator for reporting_report_design` (`creator`),
  KEY `changed_by for reporting_report_design` (`changed_by`),
  KEY `retired_by for reporting_report_design` (`retired_by`),
  KEY `report_definition_uuid_for_reporting_report_design` (`report_definition_uuid`),
  CONSTRAINT `changed_by_for_reporting_report_design` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_reporting_report_design` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `retired_by_for_reporting_report_design` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reporting_report_design_resource`
--

DROP TABLE IF EXISTS `reporting_report_design_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporting_report_design_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_design_id` int(11) NOT NULL DEFAULT '0',
  `content_type` varchar(50) DEFAULT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `contents` longblob,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `report_design_id for reporting_report_design_resource` (`report_design_id`),
  KEY `creator for reporting_report_design_resource` (`creator`),
  KEY `changed_by for reporting_report_design_resource` (`changed_by`),
  KEY `retired_by for reporting_report_design_resource` (`retired_by`),
  CONSTRAINT `changed_by_for_reporting_report_design_resource` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_reporting_report_design_resource` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `report_design_id_for_reporting_report_design_resource` FOREIGN KEY (`report_design_id`) REFERENCES `reporting_report_design` (`id`),
  CONSTRAINT `retired_by_for_reporting_report_design_resource` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reporting_report_processor`
--

DROP TABLE IF EXISTS `reporting_report_processor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporting_report_processor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `processor_type` varchar(255) DEFAULT NULL,
  `configuration` mediumtext,
  `run_on_success` tinyint(1) NOT NULL DEFAULT '1',
  `run_on_error` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `report_design_id` int(11) DEFAULT NULL,
  `processor_mode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `creator for reporting_report_processor` (`creator`),
  KEY `changed_by for reporting_report_processor` (`changed_by`),
  KEY `retired_by for reporting_report_processor` (`retired_by`),
  KEY `reporting_report_processor_report_design` (`report_design_id`),
  CONSTRAINT `changed_by_for_reporting_report_processor` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_reporting_report_processor` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `reporting_report_processor_report_design` FOREIGN KEY (`report_design_id`) REFERENCES `reporting_report_design` (`id`),
  CONSTRAINT `retired_by_for_reporting_report_processor` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reporting_report_request`
--

DROP TABLE IF EXISTS `reporting_report_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporting_report_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `base_cohort_uuid` char(38) DEFAULT NULL,
  `base_cohort_parameters` text,
  `report_definition_uuid` char(38) DEFAULT NULL,
  `report_definition_parameters` text,
  `renderer_type` varchar(255) DEFAULT NULL,
  `renderer_argument` varchar(255) DEFAULT NULL,
  `requested_by` int(11) NOT NULL DEFAULT '0',
  `request_datetime` datetime NOT NULL,
  `priority` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `evaluation_start_datetime` datetime DEFAULT NULL,
  `evaluation_complete_datetime` datetime DEFAULT NULL,
  `render_complete_datetime` datetime DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `schedule` varchar(100) DEFAULT NULL,
  `process_automatically` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_days_to_preserve` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `requested_by for reporting_report_request` (`requested_by`),
  CONSTRAINT `requested_by_for_reporting_report_request` FOREIGN KEY (`requested_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `role_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_privilege` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `privilege` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`privilege`,`role`),
  KEY `role_privilege_to_role` (`role`),
  CONSTRAINT `privilege_definitions` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `role_privilege_to_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_role`
--

DROP TABLE IF EXISTS `role_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_role` (
  `parent_role` varchar(50) NOT NULL DEFAULT '',
  `child_role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`parent_role`,`child_role`),
  KEY `inherited_role` (`child_role`),
  CONSTRAINT `inherited_role` FOREIGN KEY (`child_role`) REFERENCES `role` (`role`),
  CONSTRAINT `parent_role` FOREIGN KEY (`parent_role`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduler_task_config`
--

DROP TABLE IF EXISTS `scheduler_task_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_task_config` (
  `task_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `schedulable_class` text,
  `start_time` datetime DEFAULT NULL,
  `start_time_pattern` varchar(50) DEFAULT NULL,
  `repeat_interval` int(11) NOT NULL DEFAULT '0',
  `start_on_startup` tinyint(1) NOT NULL DEFAULT '0',
  `started` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT '0',
  `date_created` datetime DEFAULT '2005-01-01 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `last_execution_time` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`task_config_id`),
  UNIQUE KEY `scheduler_task_config_uuid_index` (`uuid`),
  KEY `scheduler_changer` (`changed_by`),
  KEY `scheduler_creator` (`created_by`),
  CONSTRAINT `scheduler_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `scheduler_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduler_task_config_property`
--

DROP TABLE IF EXISTS `scheduler_task_config_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduler_task_config_property` (
  `task_config_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `value` text,
  `task_config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_config_property_id`),
  KEY `task_config_for_property` (`task_config_id`),
  CONSTRAINT `task_config_for_property` FOREIGN KEY (`task_config_id`) REFERENCES `scheduler_task_config` (`task_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serialized_object`
--

DROP TABLE IF EXISTS `serialized_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serialized_object` (
  `serialized_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `subtype` varchar(255) DEFAULT NULL,
  `serialization_class` varchar(255) DEFAULT NULL,
  `serialized_data` mediumtext,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(1000) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`serialized_object_id`),
  UNIQUE KEY `serialized_object_uuid_index` (`uuid`),
  KEY `serialized_object_creator` (`creator`),
  KEY `serialized_object_changed_by` (`changed_by`),
  KEY `serialized_object_retired_by` (`retired_by`),
  CONSTRAINT `serialized_object_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spreadsheetimport_template`
--

DROP TABLE IF EXISTS `spreadsheetimport_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spreadsheetimport_template` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `encounter` tinyint(1) DEFAULT '0',
  `target_form` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `User who wrote this template` (`creator`),
  KEY `User who changed this template` (`changed_by`),
  CONSTRAINT `User who changed this template` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `User who wrote this template` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spreadsheetimport_template_column`
--

DROP TABLE IF EXISTS `spreadsheetimport_template_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spreadsheetimport_template_column` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `template_id` int(32) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `database_table_dot_column` varchar(1000) DEFAULT NULL,
  `database_table_dataset_index` int(11) DEFAULT NULL,
  `column_import_index` int(32) NOT NULL,
  `disallow_duplicate_value` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Template to which this column belongs` (`template_id`),
  CONSTRAINT `Template to which this column belongs` FOREIGN KEY (`template_id`) REFERENCES `spreadsheetimport_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spreadsheetimport_template_column_column`
--

DROP TABLE IF EXISTS `spreadsheetimport_template_column_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spreadsheetimport_template_column_column` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `template_column_id_import_first` int(32) NOT NULL,
  `template_column_id_import_next` int(32) NOT NULL,
  `foreign_key_column_name` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Template column which must be imported first` (`template_column_id_import_first`),
  KEY `Template column which must be imported next` (`template_column_id_import_next`),
  CONSTRAINT `Template column which must be imported first` FOREIGN KEY (`template_column_id_import_first`) REFERENCES `spreadsheetimport_template_column` (`id`),
  CONSTRAINT `Template column which must be imported next` FOREIGN KEY (`template_column_id_import_next`) REFERENCES `spreadsheetimport_template_column` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spreadsheetimport_template_column_prespecified_value`
--

DROP TABLE IF EXISTS `spreadsheetimport_template_column_prespecified_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spreadsheetimport_template_column_prespecified_value` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `template_column_id` int(32) NOT NULL,
  `template_prespecified_value_id` int(32) NOT NULL,
  `foreign_key_column_name` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Template column which is being mapped to a pre-specified value` (`template_column_id`),
  KEY `Pre-specified value which is being mapped to a template column` (`template_prespecified_value_id`),
  CONSTRAINT `Pre-specifived value which is being mapped to a template column` FOREIGN KEY (`template_prespecified_value_id`) REFERENCES `spreadsheetimport_template_prespecified_value` (`id`),
  CONSTRAINT `Template column which is being mapped to a pre-specified value` FOREIGN KEY (`template_column_id`) REFERENCES `spreadsheetimport_template_column` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spreadsheetimport_template_prespecified_value`
--

DROP TABLE IF EXISTS `spreadsheetimport_template_prespecified_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spreadsheetimport_template_prespecified_value` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `template_id` int(32) NOT NULL,
  `database_table_dot_column` varchar(1000) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Template to which this pre-specified value belongs` (`template_id`),
  CONSTRAINT `Template to which this pre-specified value belongs` FOREIGN KEY (`template_id`) REFERENCES `spreadsheetimport_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sync_class`
--

DROP TABLE IF EXISTS `sync_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `default_send_to` tinyint(1) NOT NULL,
  `default_receive_from` tinyint(1) NOT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sync_import`
--

DROP TABLE IF EXISTS `sync_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_import` (
  `sync_import_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(36) DEFAULT NULL,
  `creator` char(36) DEFAULT NULL,
  `database_version` char(20) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `state` char(32) DEFAULT NULL,
  `payload` longtext,
  `error_message` text,
  `source_server_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sync_import_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `sync_import_source_server` (`source_server_id`),
  CONSTRAINT `sync_import_source_server` FOREIGN KEY (`source_server_id`) REFERENCES `sync_server` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sync_record`
--

DROP TABLE IF EXISTS `sync_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(36) DEFAULT NULL,
  `creator` char(36) DEFAULT NULL,
  `database_version` char(20) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `state` char(32) DEFAULT NULL,
  `payload` longtext,
  `contained_classes` varchar(1000) DEFAULT NULL,
  `original_uuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `original_uuid` (`original_uuid`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `timestamp` (`timestamp`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sync_server`
--

DROP TABLE IF EXISTS `sync_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_server` (
  `server_id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `server_type` varchar(20) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `uuid` char(36) DEFAULT NULL,
  `last_sync` datetime DEFAULT NULL,
  `last_sync_state` varchar(50) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL,
  `child_username` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sync_server_class`
--

DROP TABLE IF EXISTS `sync_server_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_server_class` (
  `server_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `send_to` tinyint(1) NOT NULL,
  `receive_from` tinyint(1) NOT NULL,
  PRIMARY KEY (`server_class_id`),
  KEY `server_class_class` (`class_id`),
  KEY `server_class_server` (`server_id`),
  CONSTRAINT `server_class_class` FOREIGN KEY (`class_id`) REFERENCES `sync_class` (`class_id`),
  CONSTRAINT `server_class_server` FOREIGN KEY (`server_id`) REFERENCES `sync_server` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sync_server_record`
--

DROP TABLE IF EXISTS `sync_server_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_server_record` (
  `server_record_id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `state` char(32) DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `error_message` text,
  PRIMARY KEY (`server_record_id`),
  KEY `server_record_server` (`server_id`),
  KEY `server_record_record` (`record_id`),
  KEY `server_id` (`server_id`),
  KEY `state` (`state`),
  CONSTRAINT `server_record_record` FOREIGN KEY (`record_id`) REFERENCES `sync_record` (`record_id`),
  CONSTRAINT `server_record_server` FOREIGN KEY (`server_id`) REFERENCES `sync_server` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_order`
--

DROP TABLE IF EXISTS `test_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `specimen_source` int(11) DEFAULT NULL,
  `laterality` varchar(20) DEFAULT NULL,
  `clinical_history` text,
  `frequency` int(11) DEFAULT NULL,
  `number_of_repeats` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `test_order_specimen_source_fk` (`specimen_source`),
  KEY `test_order_frequency_fk` (`frequency`),
  CONSTRAINT `test_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`),
  CONSTRAINT `test_order_order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `test_order_specimen_source_fk` FOREIGN KEY (`specimen_source`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uiframework_user_defined_page_view`
--

DROP TABLE IF EXISTS `uiframework_user_defined_page_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uiframework_user_defined_page_view` (
  `page_view_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `template_type` varchar(50) DEFAULT NULL,
  `template_text` mediumtext,
  `uuid` varchar(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`page_view_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_property`
--

DROP TABLE IF EXISTS `user_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(100) NOT NULL DEFAULT '',
  `property_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`property`),
  CONSTRAINT `user_property_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`role`,`user_id`),
  KEY `user_role_to_users` (`user_id`),
  CONSTRAINT `role_definitions` FOREIGN KEY (`role`) REFERENCES `role` (`role`),
  CONSTRAINT `user_role_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `activation_key` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `user_who_changed_user` (`changed_by`),
  KEY `user_creator` (`creator`),
  KEY `user_who_retired_this_user` (`retired_by`),
  KEY `person_id_for_user` (`person_id`),
  CONSTRAINT `person_id_for_user` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_this_user` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit` (
  `visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `visit_type_id` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `indication_concept_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`visit_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_patient_index` (`patient_id`),
  KEY `visit_type_fk` (`visit_type_id`),
  KEY `visit_location_fk` (`location_id`),
  KEY `visit_creator_fk` (`creator`),
  KEY `visit_voided_by_fk` (`voided_by`),
  KEY `visit_changed_by_fk` (`changed_by`),
  KEY `visit_indication_concept_fk` (`indication_concept_id`),
  CONSTRAINT `visit_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_indication_concept_fk` FOREIGN KEY (`indication_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `visit_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `visit_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `visit_type_fk` FOREIGN KEY (`visit_type_id`) REFERENCES `visit_type` (`visit_type_id`),
  CONSTRAINT `visit_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3479 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visit_attribute`
--

DROP TABLE IF EXISTS `visit_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_attribute` (
  `visit_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`visit_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_visit_fk` (`visit_id`),
  KEY `visit_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `visit_attribute_creator_fk` (`creator`),
  KEY `visit_attribute_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `visit_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `visit_attribute_type` (`visit_attribute_type_id`),
  CONSTRAINT `visit_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_visit_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`),
  CONSTRAINT `visit_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visit_attribute_type`
--

DROP TABLE IF EXISTS `visit_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_attribute_type` (
  `visit_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`visit_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_type_creator_fk` (`creator`),
  KEY `visit_attribute_type_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `visit_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `visit_type`
--

DROP TABLE IF EXISTS `visit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_type` (
  `visit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`visit_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_type_creator` (`creator`),
  KEY `visit_type_changed_by` (`changed_by`),
  KEY `visit_type_retired_by` (`retired_by`),
  CONSTRAINT `visit_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_type_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-26 11:47:12
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: kenyaemr_datatools
-- ------------------------------------------------------
-- Server version	5.6.16-1~exp1

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
-- Table structure for table `adverse_events`
--

DROP TABLE IF EXISTS `adverse_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adverse_events` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  `cause` varchar(39) CHARACTER SET utf8 DEFAULT NULL,
  `adverse_event` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `severity` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `action_taken` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `adverse_events_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alcohol_drug_abuse_screening`
--

DROP TABLE IF EXISTS `alcohol_drug_abuse_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcohol_drug_abuse_screening` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `alcohol_drinking_frequency` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `smoking_frequency` varchar(28) CHARACTER SET utf8 DEFAULT NULL,
  `drugs_use_frequency` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `alcohol_drug_abuse_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `allergy_chronic_illness`
--

DROP TABLE IF EXISTS `allergy_chronic_illness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allergy_chronic_illness` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  `chronic_illness` varchar(43) CHARACTER SET utf8 DEFAULT NULL,
  `chronic_illness_onset_date` date DEFAULT NULL,
  `allergy_causative_agent` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `allergy_reaction` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `allergy_severity` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `allergy_onset_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `allergy_chronic_illness_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `art_preparation`
--

DROP TABLE IF EXISTS `art_preparation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `art_preparation` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `understands_hiv_art_benefits` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `screened_negative_substance_abuse` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `screened_negative_psychiatric_illness` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `HIV_status_disclosure` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `trained_drug_admin` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `caregiver_committed` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `adherance_barriers_identified` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `caregiver_location_contacts_known` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `ready_to_start_art` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `identified_drug_time` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `treatment_supporter_engaged` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `support_grp_meeting_awareness` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `enrolled_in_reminder_system` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `ready_to_start_art` (`ready_to_start_art`),
  CONSTRAINT `art_preparation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_trace`
--

DROP TABLE IF EXISTS `client_trace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_trace` (
  `id` int(11) DEFAULT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `encounter_date` datetime DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `contact_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `unique_patient_no` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `facility_linked_to` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `health_worker_handed_to` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `client_id` (`client_id`),
  KEY `date_created` (`date_created`),
  CONSTRAINT `client_trace_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `patient_contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `covid_19_assessment`
--

DROP TABLE IF EXISTS `covid_19_assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covid_19_assessment` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `ever_vaccinated` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `first_vaccine_type` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `second_vaccine_type` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `first_dose` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `second_dose` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `first_dose_date` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `second_dose_date` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `first_vaccination_verified` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `second_vaccination_verified` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `final_vaccination_status` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `ever_received_booster` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `booster_vaccine_taken` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `date_taken_booster_vaccine` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `booster_sequence` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `booster_dose_verified` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `ever_tested_covid_19_positive` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `symptomatic` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `date_tested_positive` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `hospital_admission` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `admission_unit` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `on_ventillator` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `on_oxygen_supplement` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `covid_19_assessment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `current_in_care`
--

DROP TABLE IF EXISTS `current_in_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `current_in_care` (
  `visit_date` date DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `enroll_date` date DEFAULT NULL,
  `latest_enrolment_date` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `latest_vis_date` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `latest_tca` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `stability` varchar(53) CHARACTER SET utf8 DEFAULT NULL,
  `disc_patient` int(11),
  `effective_disc_date` date DEFAULT NULL,
  `date_discontinued` datetime DEFAULT NULL,
  `started_on_drugs` int(11),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `current_in_care_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `default_facility_info`
--

DROP TABLE IF EXISTS `default_facility_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_facility_info` (
  `siteCode` mediumtext CHARACTER SET utf8,
  `FacilityName` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `depression_screening`
--

DROP TABLE IF EXISTS `depression_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `depression_screening` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `PHQ_9_rating` varchar(26) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `depression_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_event`
--

DROP TABLE IF EXISTS `drug_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_event` (
  `uuid` char(38) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `patient_id` int(11) NOT NULL,
  `date_started` date DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `program` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `regimen` mediumtext CHARACTER SET utf8,
  `regimen_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `regimen_line` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `discontinued` int(11) DEFAULT NULL,
  `regimen_stopped` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `regimen_discontinued` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `date_discontinued` date DEFAULT NULL,
  `reason_discontinued` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `reason_discontinued_other` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `drug_event_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enhanced_adherence`
--

DROP TABLE IF EXISTS `enhanced_adherence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enhanced_adherence` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `session_number` int(11) DEFAULT NULL,
  `first_session_date` date DEFAULT NULL,
  `pill_count` int(11) DEFAULT NULL,
  `arv_adherence` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `has_vl_results` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `vl_results_suppressed` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `vl_results_feeling` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `cause_of_high_vl` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `way_forward` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_hiv_knowledge` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_drugs_uptake` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_drugs_reminder_tools` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_drugs_uptake_during_travels` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_drugs_side_effects_response` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_drugs_uptake_most_difficult_times` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_drugs_daily_uptake_feeling` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_ambitions` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_has_people_to_talk` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `patient_enlisting_social_support` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_income_sources` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_challenges_reaching_clinic` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `patient_worried_of_accidental_disclosure` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `patient_treated_differently` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `stigma_hinders_adherence` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `patient_tried_faith_healing` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `patient_adherence_improved` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `patient_doses_missed` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `review_and_barriers_to_adherence` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `other_referrals` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `appointments_honoured` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `referral_experience` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `home_visit_benefit` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `adherence_plan` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `enhanced_adherence_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gbv_screening`
--

DROP TABLE IF EXISTS `gbv_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gbv_screening` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `ipv` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `physical_ipv` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `emotional_ipv` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `sexual_ipv` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `ipv_relationship` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `gbv_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gbv_screening_action`
--

DROP TABLE IF EXISTS `gbv_screening_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gbv_screening_action` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `obs_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `help_provider` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `action_taken` varchar(27) CHARACTER SET utf8 DEFAULT NULL,
  `reason_for_not_reporting` varchar(43) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `gbv_screening_action_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hei_enrollment`
--

DROP TABLE IF EXISTS `hei_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hei_enrollment` (
  `serial_no` int(11) NOT NULL DEFAULT '0',
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `child_exposed` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `spd_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `birth_weight` double DEFAULT NULL,
  `gestation_at_birth` double DEFAULT NULL,
  `birth_type` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  `date_first_seen` date DEFAULT NULL,
  `birth_notification_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `birth_certificate_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `need_for_special_care` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `reason_for_special_care` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `referral_source` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `transfer_in` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `transfer_in_date` date DEFAULT NULL,
  `facility_transferred_from` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `district_transferred_from` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `date_first_enrolled_in_hei_care` date DEFAULT NULL,
  `mother_breastfeeding` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `TB_contact_history_in_household` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `mother_alive` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `mother_on_pmtct_drugs` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `mother_on_drug` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  `mother_on_art_at_infant_enrollment` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `mother_drug_regimen` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `infant_prophylaxis` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `parent_ccc_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `mode_of_delivery` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `place_of_delivery` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `birth_length` int(11) DEFAULT NULL,
  `birth_order` int(11) DEFAULT NULL,
  `health_facility_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `date_of_birth_notification` date DEFAULT NULL,
  `date_of_birth_registration` date DEFAULT NULL,
  `birth_registration_place` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `permanent_registration_serial` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `mother_facility_registered` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `exit_date` date DEFAULT NULL,
  `exit_reason` varchar(29) CHARACTER SET utf8 DEFAULT NULL,
  `hiv_status_at_exit` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `hei_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hei_follow_up_visit`
--

DROP TABLE IF EXISTS `hei_follow_up_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hei_follow_up_visit` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `muac` varchar(6) CHARACTER SET utf8 DEFAULT NULL,
  `primary_caregiver` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `infant_feeding` varchar(28) CHARACTER SET utf8 DEFAULT NULL,
  `stunted` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `tb_assessment_outcome` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `social_smile_milestone` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `head_control_milestone` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `response_to_sound_milestone` varchar(33) CHARACTER SET utf8 DEFAULT NULL,
  `hand_extension_milestone` varchar(27) CHARACTER SET utf8 DEFAULT NULL,
  `sitting_milestone` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `walking_milestone` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `standing_milestone` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `talking_milestone` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `review_of_systems_developmental` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `weight_category` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `dna_pcr_sample_date` date DEFAULT NULL,
  `dna_pcr_contextual_status` varchar(36) CHARACTER SET utf8 DEFAULT NULL,
  `dna_pcr_result` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `azt_given` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `nvp_given` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `ctx_given` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `multi_vitamin_given` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `first_antibody_result` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `final_antibody_result` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `tetracycline_ointment_given` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `pupil_examination` varchar(5) CHARACTER SET utf8 DEFAULT NULL,
  `sight_examination` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `squint` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `deworming_drug` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  `dosage` int(11) DEFAULT NULL,
  `unit` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `vitaminA_given` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `disability` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `referred_from` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `referred_to` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `MNPS_Supplementation` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `comments` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `infant_feeding` (`infant_feeding`),
  CONSTRAINT `hei_follow_up_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hei_immunization`
--

DROP TABLE IF EXISTS `hei_immunization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hei_immunization` (
  `patient_id` int(11) NOT NULL,
  `visit_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `BCG` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `OPV_birth` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `OPV_1` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `OPV_2` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `OPV_3` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `IPV` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `DPT_Hep_B_Hib_1` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `DPT_Hep_B_Hib_2` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `DPT_Hep_B_Hib_3` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `PCV_10_1` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `PCV_10_2` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `PCV_10_3` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `ROTA_1` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `ROTA_2` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `Measles_rubella_1` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `Measles_rubella_2` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `Yellow_fever` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `Measles_6_months` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `VitaminA_6_months` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `VitaminA_1_yr` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `VitaminA_1_and_half_yr` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `VitaminA_2_yr` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `VitaminA_2_to_5_yr` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `fully_immunized` date DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `hei_immunization_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hiv_enrollment`
--

DROP TABLE IF EXISTS `hiv_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hiv_enrollment` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `patient_type` int(11) DEFAULT NULL,
  `date_first_enrolled_in_care` date DEFAULT NULL,
  `entry_point` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `transfer_in_date` date DEFAULT NULL,
  `facility_transferred_from` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `district_transferred_from` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `previous_regimen` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `date_started_art_at_transferring_facility` date DEFAULT NULL,
  `date_confirmed_hiv_positive` date DEFAULT NULL,
  `facility_confirmed_hiv_positive` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `arv_status` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `name_of_treatment_supporter` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `relationship_of_treatment_supporter` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  `treatment_supporter_telephone` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `treatment_supporter_address` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `in_school` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `orphan` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `date_of_discontinuation` datetime DEFAULT NULL,
  `discontinuation_reason` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `arv_status` (`arv_status`),
  KEY `date_confirmed_hiv_positive` (`date_confirmed_hiv_positive`),
  KEY `entry_point` (`entry_point`),
  CONSTRAINT `hiv_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hiv_followup`
--

DROP TABLE IF EXISTS `hiv_followup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hiv_followup` (
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `visit_scheduled` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  `person_present` varchar(24) CHARACTER SET utf8 DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `systolic_pressure` double DEFAULT NULL,
  `diastolic_pressure` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `nutritional_status` varchar(27) CHARACTER SET utf8 DEFAULT NULL,
  `population_type` varchar(18) CHARACTER SET utf8 DEFAULT NULL,
  `key_population_type` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `who_stage` varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `presenting_complaints` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `clinical_notes` varchar(600) CHARACTER SET utf8 DEFAULT NULL,
  `on_anti_tb_drugs` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `on_ipt` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `ever_on_ipt` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `cough` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `fever` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `weight_loss_poor_gain` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `night_sweats` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `tb_case_contact` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `lethargy` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `screened_for_tb` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `spatum_smear_ordered` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `chest_xray_ordered` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `genexpert_ordered` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `spatum_smear_result` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `chest_xray_result` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `genexpert_result` varchar(74) CHARACTER SET utf8 DEFAULT NULL,
  `referral` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `clinical_tb_diagnosis` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `contact_invitation` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `evaluated_for_ipt` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `has_known_allergies` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `has_chronic_illnesses_cormobidities` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `has_adverse_drug_reaction` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `pregnancy_status` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `wants_pregnancy` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `pregnancy_outcome` varchar(55) CHARACTER SET utf8 DEFAULT NULL,
  `anc_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `ever_had_menses` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `last_menstrual_period` date DEFAULT NULL,
  `menopausal` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `gravida` int(11) DEFAULT NULL,
  `parity` int(11) DEFAULT NULL,
  `full_term_pregnancies` int(11) DEFAULT NULL,
  `abortion_miscarriages` int(11) DEFAULT NULL,
  `family_planning_status` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `family_planning_method` varchar(29) CHARACTER SET utf8 DEFAULT NULL,
  `reason_not_using_family_planning` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `tb_status` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `tb_treatment_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `general_examination` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `system_examination` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `skin_findings` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `eyes_findings` varchar(18) CHARACTER SET utf8 DEFAULT NULL,
  `ent_findings` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `chest_findings` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `cvs_findings` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `abdomen_findings` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `cns_findings` varchar(18) CHARACTER SET utf8 DEFAULT NULL,
  `genitourinary_findings` varchar(18) CHARACTER SET utf8 DEFAULT NULL,
  `prophylaxis_given` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `ctx_adherence` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `ctx_dispensed` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `dapsone_adherence` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `dapsone_dispensed` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `inh_dispensed` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `arv_adherence` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `poor_arv_adherence_reason` varchar(66) CHARACTER SET utf8 DEFAULT NULL,
  `poor_arv_adherence_reason_other` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `pwp_disclosure` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `pwp_partner_tested` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `condom_provided` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `substance_abuse_screening` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `screened_for_sti` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `cacx_screening` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `sti_partner_notification` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `at_risk_population` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `system_review_finding` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  `refill_date` date DEFAULT NULL,
  `next_appointment_reason` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `stability` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `differentiated_care` varchar(37) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `pregnancy_status` (`pregnancy_status`),
  KEY `family_planning_status` (`family_planning_status`),
  KEY `tb_status` (`tb_status`),
  KEY `ctx_dispensed` (`ctx_dispensed`),
  KEY `population_type` (`population_type`),
  KEY `on_anti_tb_drugs` (`on_anti_tb_drugs`),
  KEY `stability` (`stability`),
  KEY `differentiated_care` (`differentiated_care`),
  CONSTRAINT `hiv_followup_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hts_referral`
--

DROP TABLE IF EXISTS `hts_referral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hts_referral` (
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `encounter_location` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `facility_referred_to` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `date_to_enrol` date DEFAULT NULL,
  `remarks` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hts_referral_and_linkage`
--

DROP TABLE IF EXISTS `hts_referral_and_linkage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hts_referral_and_linkage` (
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `encounter_location` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `tracing_type` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `tracing_status` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `ccc_number` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `referral_facility` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `facility_linked_to` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `enrollment_date` date DEFAULT NULL,
  `art_start_date` date DEFAULT NULL,
  `provider_handed_to` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `cadre` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `hts_referral_and_linkage_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hts_test`
--

DROP TABLE IF EXISTS `hts_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hts_test` (
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `encounter_location` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `test_type` int(11) DEFAULT NULL,
  `population_type` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `key_population_type` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `ever_tested_for_hiv` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `months_since_last_test` int(11) DEFAULT NULL,
  `patient_disabled` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `disability_type` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_consented` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `client_tested_as` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `setting` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `approach` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_strategy` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `hts_entry_point` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_1_kit_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_1_kit_lot_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_1_kit_expiry` date DEFAULT NULL,
  `test_1_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_2_kit_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_2_kit_lot_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_2_kit_expiry` date DEFAULT NULL,
  `test_2_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `final_test_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `patient_given_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `couple_discordant` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `referral_for` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `referral_facility` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `other_referral_facility` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `tb_screening` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `patient_had_hiv_self_test` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `population_type` (`population_type`),
  KEY `final_test_result` (`final_test_result`),
  CONSTRAINT `hts_test_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ipt_followup`
--

DROP TABLE IF EXISTS `ipt_followup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ipt_followup` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `ipt_due_date` date DEFAULT NULL,
  `date_collected_ipt` date DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `hepatotoxity` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `peripheral_neuropathy` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `rash` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `adherence` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `action_taken` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `ipt_followup_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ipt_screening`
--

DROP TABLE IF EXISTS `ipt_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ipt_screening` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `obs_id` int(11) NOT NULL,
  `cough` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `fever` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `weight_loss_poor_gain` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `night_sweats` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `contact_with_tb_case` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `lethargy` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `yellow_urine` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `numbness_bs_hands_feet` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `eyes_yellowness` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `upper_rightQ_abdomen_tenderness` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `ipt_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `laboratory_extract`
--

DROP TABLE IF EXISTS `laboratory_extract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratory_extract` (
  `uuid` char(38) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `encounter_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `lab_test` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `urgency` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `order_reason` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `test_result` varchar(180) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `lab_test` (`lab_test`),
  KEY `test_result` (`test_result`),
  CONSTRAINT `laboratory_extract_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mch_antenatal_visit`
--

DROP TABLE IF EXISTS `mch_antenatal_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mch_antenatal_visit` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `anc_visit_number` int(11) DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `systolic_bp` double DEFAULT NULL,
  `diastolic_bp` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `hemoglobin` double DEFAULT NULL,
  `breast_exam_done` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `pallor` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `maturity` int(11) DEFAULT NULL,
  `fundal_height` double DEFAULT NULL,
  `fetal_presentation` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `lie` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `fetal_heart_rate` int(11) DEFAULT NULL,
  `fetal_movement` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `who_stage` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `cd4` int(11) DEFAULT NULL,
  `vl_sample_taken` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `viral_load` int(11) DEFAULT NULL,
  `ldl` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `arv_status` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `final_test_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `patient_given_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `partner_hiv_tested` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `partner_hiv_status` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `prophylaxis_given` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `date_given_haart` date DEFAULT NULL,
  `baby_azt_dispensed` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `baby_nvp_dispensed` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `TTT` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `IPT_malaria` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `iron_supplement` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `deworming` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `bed_nets` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `urine_microscopy` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `urinary_albumin` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `glucose_measurement` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `urine_ph` int(11) DEFAULT NULL,
  `urine_gravity` int(11) DEFAULT NULL,
  `urine_nitrite_test` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `urine_leukocyte_esterace_test` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `urinary_ketone` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `urine_bile_salt_test` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `urine_bile_pigment_test` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `urine_colour` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `urine_turbidity` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `urine_dipstick_for_blood` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `syphilis_test_status` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `syphilis_treated_status` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `bs_mps` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `anc_exercises` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `tb_screening` varchar(27) CHARACTER SET utf8 DEFAULT NULL,
  `cacx_screening` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `cacx_screening_method` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `has_other_illnes` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_birth_plans` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_danger_signs` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_family_planning` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_hiv` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_supplimental_feeding` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_breast_care` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_infant_feeding` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_treated_nets` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `referred_from` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `referred_to` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  `clinical_notes` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `mch_antenatal_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mch_delivery`
--

DROP TABLE IF EXISTS `mch_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mch_delivery` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `admission_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `duration_of_pregnancy` double DEFAULT NULL,
  `mode_of_delivery` varchar(36) CHARACTER SET utf8 DEFAULT NULL,
  `date_of_delivery` datetime DEFAULT NULL,
  `blood_loss` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `condition_of_mother` varchar(5) CHARACTER SET utf8 DEFAULT NULL,
  `delivery_outcome` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `apgar_score_1min` double DEFAULT NULL,
  `apgar_score_5min` double DEFAULT NULL,
  `apgar_score_10min` double DEFAULT NULL,
  `resuscitation_done` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `place_of_delivery` varchar(27) CHARACTER SET utf8 DEFAULT NULL,
  `delivery_assistant` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `counseling_on_infant_feeding` varchar(41) CHARACTER SET utf8 DEFAULT NULL,
  `counseling_on_exclusive_breastfeeding` varchar(38) CHARACTER SET utf8 DEFAULT NULL,
  `counseling_on_infant_feeding_for_hiv_infected` varchar(54) CHARACTER SET utf8 DEFAULT NULL,
  `mother_decision` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `placenta_complete` varchar(31) CHARACTER SET utf8 DEFAULT NULL,
  `maternal_death_audited` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `cadre` varchar(29) CHARACTER SET utf8 DEFAULT NULL,
  `delivery_complications` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `coded_delivery_complications` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `other_delivery_complications` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `duration_of_labor` int(11) DEFAULT NULL,
  `baby_sex` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `baby_condition` varchar(54) CHARACTER SET utf8 DEFAULT NULL,
  `teo_given` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `birth_weight` int(11) DEFAULT NULL,
  `bf_within_one_hour` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `birth_with_deformity` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `final_test_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `patient_given_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `partner_hiv_tested` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `partner_hiv_status` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `prophylaxis_given` varchar(31) CHARACTER SET utf8 DEFAULT NULL,
  `baby_azt_dispensed` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `baby_nvp_dispensed` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `clinical_notes` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `mch_delivery_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mch_discharge`
--

DROP TABLE IF EXISTS `mch_discharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mch_discharge` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `counselled_on_feeding` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `baby_status` varchar(5) CHARACTER SET utf8 DEFAULT NULL,
  `vitamin_A_dispensed` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `birth_notification_number` int(50) DEFAULT NULL,
  `condition_of_mother` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `discharge_date` date DEFAULT NULL,
  `referred_from` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `referred_to` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `clinical_notes` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `mch_discharge_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mch_enrollment`
--

DROP TABLE IF EXISTS `mch_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mch_enrollment` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `service_type` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `anc_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `first_anc_visit_date` date DEFAULT NULL,
  `gravida` int(11) DEFAULT NULL,
  `parity` int(11) DEFAULT NULL,
  `parity_abortion` int(11) DEFAULT NULL,
  `age_at_menarche` int(11) DEFAULT NULL,
  `lmp` date DEFAULT NULL,
  `lmp_estimated` int(11) DEFAULT NULL,
  `edd_ultrasound` date DEFAULT NULL,
  `blood_group` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  `serology` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `tb_screening` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `bs_for_mps` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `hiv_status` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `hiv_test_date` date DEFAULT NULL,
  `partner_hiv_status` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `partner_hiv_test_date` date DEFAULT NULL,
  `urine_microscopy` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `urinary_albumin` varchar(22) CHARACTER SET utf8 DEFAULT NULL,
  `glucose_measurement` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `urine_ph` int(11) DEFAULT NULL,
  `urine_gravity` int(11) DEFAULT NULL,
  `urine_nitrite_test` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `urine_leukocyte_esterace_test` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `urinary_ketone` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `urine_bile_salt_test` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `urine_bile_pigment_test` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `urine_colour` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `urine_turbidity` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `urine_dipstick_for_blood` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `discontinuation_reason` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `mch_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mch_postnatal_visit`
--

DROP TABLE IF EXISTS `mch_postnatal_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mch_postnatal_visit` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `pnc_register_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `pnc_visit_no` int(11) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `mode_of_delivery` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `place_of_delivery` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `delivery_outcome` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `systolic_bp` double DEFAULT NULL,
  `diastolic_bp` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `hemoglobin` double DEFAULT NULL,
  `arv_status` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `general_condition` varchar(4) CHARACTER SET utf8 DEFAULT NULL,
  `breast` varchar(4) CHARACTER SET utf8 DEFAULT NULL,
  `cs_scar` varchar(37) CHARACTER SET utf8 DEFAULT NULL,
  `gravid_uterus` varchar(42) CHARACTER SET utf8 DEFAULT NULL,
  `episiotomy` varchar(29) CHARACTER SET utf8 DEFAULT NULL,
  `lochia` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `counselled_on_infant_feeding` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `pallor` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `pph` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `mother_hiv_status` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `condition_of_baby` varchar(35) CHARACTER SET utf8 DEFAULT NULL,
  `baby_feeding_method` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `umblical_cord` varchar(34) CHARACTER SET utf8 DEFAULT NULL,
  `baby_immunization_started` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `family_planning_counseling` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `uterus_examination` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `uterus_cervix_examination` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `vaginal_examination` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `parametrial_examination` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `external_genitalia_examination` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `ovarian_examination` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `pelvic_lymph_node_exam` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `final_test_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `patient_given_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `partner_hiv_tested` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `partner_hiv_status` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `prophylaxis_given` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `baby_azt_dispensed` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `baby_nvp_dispensed` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `pnc_exercises` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `maternal_condition` varchar(35) CHARACTER SET utf8 DEFAULT NULL,
  `iron_supplementation` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `fistula_screening` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `cacx_screening` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `cacx_screening_method` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `family_planning_status` varchar(25) CHARACTER SET utf8 DEFAULT NULL,
  `family_planning_method` varchar(29) CHARACTER SET utf8 DEFAULT NULL,
  `referred_from` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `referred_to` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `clinical_notes` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `mch_postnatal_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_contact`
--

DROP TABLE IF EXISTS `patient_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_contact` (
  `id` int(11) NOT NULL DEFAULT '0',
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `middle_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `sex` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `birth_date` datetime DEFAULT NULL,
  `physical_address` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `phone_contact` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `patient_related_to` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `relationship_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `baseline_hiv_status` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ipv_outcome` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `marital_status` varchar(18) CHARACTER SET utf8 DEFAULT NULL,
  `living_with_patient` varchar(18) CHARACTER SET utf8 DEFAULT NULL,
  `pns_approach` varchar(17) CHARACTER SET utf8 DEFAULT NULL,
  `contact_listing_decline_reason` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `consented_contact_listing` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_related_to` (`patient_related_to`),
  KEY `date_created` (`date_created`),
  CONSTRAINT `patient_contact_ibfk_1` FOREIGN KEY (`patient_related_to`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_demographics`
--

DROP TABLE IF EXISTS `patient_demographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_demographics` (
  `patient_id` int(11) NOT NULL,
  `given_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `middle_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `family_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `national_id_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `unique_patient_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `patient_clinic_number` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `Tb_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `CPIMS_unique_identifier` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `openmrs_id` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `district_reg_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `hei_no` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `cwc_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `phone_number` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `birth_place` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `citizenship` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `email_address` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `occupation` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `next_of_kin` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `next_of_kin_relationship` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `marital_status` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `education_level` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `dead` varchar(3) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `death_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `Gender` (`Gender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_program_discontinuation`
--

DROP TABLE IF EXISTS `patient_program_discontinuation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_program_discontinuation` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` datetime DEFAULT NULL,
  `program_uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `program_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `discontinuation_reason` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `date_died` date DEFAULT NULL,
  `transfer_facility` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `transfer_date` date DEFAULT NULL,
  `death_reason` varchar(76) CHARACTER SET utf8 DEFAULT NULL,
  `specific_death_cause` varchar(182) CHARACTER SET utf8 DEFAULT NULL,
  `natural_causes` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `non_natural_cause` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `discontinuation_reason` (`discontinuation_reason`),
  CONSTRAINT `patient_program_discontinuation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_address` (
  `uuid` char(38) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `patient_id` int(11) NOT NULL,
  `county` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `sub_county` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `ward` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `sub_location` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `village` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `postal_address` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `land_mark` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pharmacy_extract`
--

DROP TABLE IF EXISTS `pharmacy_extract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacy_extract` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `encounter_name` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `drug` int(11) DEFAULT NULL,
  `drug_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `is_arv` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `is_ctx` varchar(37) CHARACTER SET utf8 DEFAULT NULL,
  `is_dapsone` varchar(7) CHARACTER SET utf8 DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `duration_units` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `date_voided` date DEFAULT NULL,
  `dispensing_provider` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `pharmacy_extract_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pre_hiv_enrollment_art`
--

DROP TABLE IF EXISTS `pre_hiv_enrollment_art`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pre_hiv_enrollment_art` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  `PMTCT` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `PMTCT_regimen` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `PEP` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `PEP_regimen` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `PrEP` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `PrEP_regimen` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `HAART` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `HAART_regimen` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `pre_hiv_enrollment_art_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_enrollment`
--

DROP TABLE IF EXISTS `tb_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_enrollment` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_treatment_started` date DEFAULT NULL,
  `district` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `referred_by` varchar(28) CHARACTER SET utf8 DEFAULT NULL,
  `referral_date` date DEFAULT NULL,
  `date_transferred_in` date DEFAULT NULL,
  `facility_transferred_from` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `district_transferred_from` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `date_first_enrolled_in_tb_care` date DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `treatment_supporter` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `relation_to_patient` varchar(17) CHARACTER SET utf8 DEFAULT NULL,
  `treatment_supporter_address` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `treatment_supporter_phone_contact` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `disease_classification` varchar(18) CHARACTER SET utf8 DEFAULT NULL,
  `patient_classification` varchar(34) CHARACTER SET utf8 DEFAULT NULL,
  `pulmonary_smear_result` varchar(14) CHARACTER SET utf8 DEFAULT NULL,
  `has_extra_pulmonary_pleurial_effusion` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `has_extra_pulmonary_milliary` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `has_extra_pulmonary_lymph_node` varchar(11) CHARACTER SET utf8 DEFAULT NULL,
  `has_extra_pulmonary_menengitis` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `has_extra_pulmonary_skeleton` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `has_extra_pulmonary_abdominal` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `tb_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_follow_up_visit`
--

DROP TABLE IF EXISTS `tb_follow_up_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_follow_up_visit` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `spatum_test` varchar(23) CHARACTER SET utf8 DEFAULT NULL,
  `spatum_result` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `result_serial_number` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `date_test_done` date DEFAULT NULL,
  `bacterial_colonie_growth` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `number_of_colonies` double DEFAULT NULL,
  `resistant_s` varchar(1) CHARACTER SET utf8 DEFAULT NULL,
  `resistant_r` varchar(1) CHARACTER SET utf8 DEFAULT NULL,
  `resistant_inh` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `resistant_e` varchar(1) CHARACTER SET utf8 DEFAULT NULL,
  `sensitive_s` varchar(1) CHARACTER SET utf8 DEFAULT NULL,
  `sensitive_r` varchar(1) CHARACTER SET utf8 DEFAULT NULL,
  `sensitive_inh` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `sensitive_e` varchar(1) CHARACTER SET utf8 DEFAULT NULL,
  `test_date` date DEFAULT NULL,
  `hiv_status` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `hiv_status` (`hiv_status`),
  CONSTRAINT `tb_follow_up_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_screening`
--

DROP TABLE IF EXISTS `tb_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_screening` (
  `patient_id` int(11) NOT NULL,
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `cough_for_2wks_or_more` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `confirmed_tb_contact` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `fever_for_2wks_or_more` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `noticeable_weight_loss` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `night_sweat_for_2wks_or_more` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `lethargy` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `spatum_smear_ordered` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `chest_xray_ordered` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `genexpert_ordered` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `spatum_smear_result` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `chest_xray_result` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `genexpert_result` varchar(74) CHARACTER SET utf8 DEFAULT NULL,
  `referral` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `clinical_tb_diagnosis` varchar(8) CHARACTER SET utf8 DEFAULT NULL,
  `contact_invitation` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `evaluated_for_ipt` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `resulting_tb_status` varchar(21) CHARACTER SET utf8 DEFAULT NULL,
  `tb_treatment_start_date` date DEFAULT NULL,
  `tb_prophylaxis` varchar(13) CHARACTER SET utf8 DEFAULT NULL,
  `notes` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `person_present` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `tb_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `triage`
--

DROP TABLE IF EXISTS `triage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `triage` (
  `uuid` char(38) CHARACTER SET utf8 DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `visit_reason` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `systolic_pressure` double DEFAULT NULL,
  `diastolic_pressure` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `nutritional_status` varchar(27) CHARACTER SET utf8 DEFAULT NULL,
  `last_menstrual_period` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  CONSTRAINT `triage_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-26 11:47:12
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: kenyaemr_etl
-- ------------------------------------------------------
-- Server version	5.6.16-1~exp1

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
-- Table structure for table `etl_ART_preparation`
--

DROP TABLE IF EXISTS `etl_ART_preparation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_ART_preparation` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `understands_hiv_art_benefits` varchar(10) DEFAULT NULL,
  `screened_negative_substance_abuse` varchar(10) DEFAULT NULL,
  `screened_negative_psychiatric_illness` varchar(10) DEFAULT NULL,
  `HIV_status_disclosure` varchar(10) DEFAULT NULL,
  `trained_drug_admin` varchar(10) DEFAULT NULL,
  `informed_drug_side_effects` varchar(10) DEFAULT NULL,
  `caregiver_committed` varchar(10) DEFAULT NULL,
  `adherance_barriers_identified` varchar(10) DEFAULT NULL,
  `caregiver_location_contacts_known` varchar(10) DEFAULT NULL,
  `ready_to_start_art` varchar(10) DEFAULT NULL,
  `identified_drug_time` varchar(10) DEFAULT NULL,
  `treatment_supporter_engaged` varchar(10) DEFAULT NULL,
  `support_grp_meeting_awareness` varchar(10) DEFAULT NULL,
  `enrolled_in_reminder_system` varchar(10) DEFAULT NULL,
  `other_support_systems` varchar(10) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `ready_to_start_art` (`ready_to_start_art`),
  CONSTRAINT `etl_ART_preparation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_PrEP_verification`
--

DROP TABLE IF EXISTS `etl_PrEP_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_PrEP_verification` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_enrolled` date DEFAULT NULL,
  `health_facility_accessing_PrEP` varchar(100) DEFAULT NULL,
  `is_pepfar_site` varchar(11) DEFAULT NULL,
  `date_initiated_PrEP` date DEFAULT NULL,
  `PrEP_regimen` varchar(100) DEFAULT NULL,
  `information_source` varchar(100) DEFAULT NULL,
  `PrEP_status` varchar(100) DEFAULT NULL,
  `verification_date` date DEFAULT NULL,
  `discontinuation_reason` varchar(100) DEFAULT NULL,
  `other_discontinuation_reason` varchar(100) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `etl_PrEP_verification_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_adverse_events`
--

DROP TABLE IF EXISTS `etl_adverse_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_adverse_events` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  `cause` int(11) DEFAULT NULL,
  `adverse_event` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `action_taken` int(11) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  KEY `visit_date` (`visit_date`),
  KEY `patient_id` (`patient_id`),
  KEY `encounter_id` (`encounter_id`),
  KEY `obs_id` (`obs_id`),
  CONSTRAINT `etl_adverse_events_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_alcohol_drug_abuse_screening`
--

DROP TABLE IF EXISTS `etl_alcohol_drug_abuse_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_alcohol_drug_abuse_screening` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `alcohol_drinking_frequency` varchar(50) DEFAULT NULL,
  `smoking_frequency` varchar(50) DEFAULT NULL,
  `drugs_use_frequency` varchar(50) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `etl_alcohol_drug_abuse_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_allergy_chronic_illness`
--

DROP TABLE IF EXISTS `etl_allergy_chronic_illness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_allergy_chronic_illness` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  `chronic_illness` int(11) DEFAULT NULL,
  `chronic_illness_onset_date` date DEFAULT NULL,
  `allergy_causative_agent` int(11) DEFAULT NULL,
  `allergy_reaction` int(11) DEFAULT NULL,
  `allergy_severity` int(11) DEFAULT NULL,
  `allergy_onset_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  KEY `visit_date` (`visit_date`),
  KEY `patient_id` (`patient_id`),
  KEY `encounter_id` (`encounter_id`),
  KEY `obs_id` (`obs_id`),
  CONSTRAINT `etl_allergy_chronic_illness_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_ccc_defaulter_tracing`
--

DROP TABLE IF EXISTS `etl_ccc_defaulter_tracing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_ccc_defaulter_tracing` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `tracing_type` int(11) DEFAULT NULL,
  `reason_for_missed_appointment` int(11) DEFAULT NULL,
  `non_coded_missed_appointment_reason` varchar(100) DEFAULT NULL,
  `tracing_outcome` int(11) DEFAULT NULL,
  `attempt_number` int(11) DEFAULT NULL,
  `is_final_trace` int(11) DEFAULT NULL,
  `true_status` int(11) DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `true_status` (`true_status`),
  KEY `cause_of_death` (`cause_of_death`),
  KEY `tracing_type` (`tracing_type`),
  CONSTRAINT `etl_ccc_defaulter_tracing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_cervical_cancer_screening`
--

DROP TABLE IF EXISTS `etl_cervical_cancer_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_cervical_cancer_screening` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_type` varchar(255) DEFAULT NULL,
  `screening_type` varchar(255) DEFAULT NULL,
  `post_treatment_complication_cause` varchar(255) DEFAULT NULL,
  `post_treatment_complication_other` varchar(255) DEFAULT NULL,
  `screening_number` int(11) DEFAULT NULL,
  `screening_method` varchar(255) DEFAULT NULL,
  `screening_result` varchar(255) DEFAULT NULL,
  `previous_screening_method` varchar(255) DEFAULT NULL,
  `previous_screening_date` date DEFAULT NULL,
  `previous_screening_result` varchar(255) DEFAULT NULL,
  `treatment_method` varchar(255) DEFAULT NULL,
  `treatment_method_other` varchar(255) DEFAULT NULL,
  `referred_out` varchar(100) DEFAULT NULL,
  `referral_facility` varchar(100) DEFAULT NULL,
  `referral_reason` varchar(255) DEFAULT NULL,
  `next_appointment_date` datetime DEFAULT NULL,
  `encounter_type` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `screening_number` (`screening_number`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_cervical_cancer_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_client_enrollment`
--

DROP TABLE IF EXISTS `etl_client_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_client_enrollment` (
  `uuid` char(38) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `contacted_for_prevention` varchar(10) DEFAULT NULL,
  `has_regular_free_sex_partner` varchar(10) DEFAULT NULL,
  `year_started_sex_work` varchar(10) DEFAULT NULL,
  `year_started_sex_with_men` varchar(10) DEFAULT NULL,
  `year_started_drugs` varchar(10) DEFAULT NULL,
  `has_expereienced_sexual_violence` varchar(10) DEFAULT NULL,
  `has_expereienced_physical_violence` varchar(10) DEFAULT NULL,
  `ever_tested_for_hiv` varchar(10) DEFAULT NULL,
  `test_type` varchar(255) DEFAULT NULL,
  `share_test_results` varchar(100) DEFAULT NULL,
  `willing_to_test` varchar(10) DEFAULT NULL,
  `test_decline_reason` varchar(255) DEFAULT NULL,
  `receiving_hiv_care` varchar(10) DEFAULT NULL,
  `care_facility_name` varchar(100) DEFAULT NULL,
  `ccc_number` varchar(100) DEFAULT NULL,
  `vl_test_done` varchar(10) DEFAULT NULL,
  `vl_results_date` date DEFAULT NULL,
  `contact_for_appointment` varchar(10) DEFAULT NULL,
  `contact_method` varchar(255) DEFAULT NULL,
  `buddy_name` varchar(255) DEFAULT NULL,
  `buddy_phone_number` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `etl_client_enrollment_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_client_trace`
--

DROP TABLE IF EXISTS `etl_client_trace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_client_trace` (
  `id` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `encounter_date` datetime DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `contact_type` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `unique_patient_no` varchar(255) DEFAULT NULL,
  `facility_linked_to` varchar(255) DEFAULT NULL,
  `health_worker_handed_to` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `client_id` (`client_id`),
  KEY `date_created` (`date_created`),
  KEY `id` (`id`),
  KEY `id_2` (`id`,`date_created`),
  CONSTRAINT `etl_client_trace_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_clinical_visit`
--

DROP TABLE IF EXISTS `etl_clinical_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_clinical_visit` (
  `uuid` char(38) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `implementing_partner` varchar(255) DEFAULT NULL,
  `type_of_visit` varchar(255) DEFAULT NULL,
  `visit_reason` varchar(255) DEFAULT NULL,
  `service_delivery_model` varchar(255) DEFAULT NULL,
  `sti_screened` varchar(10) DEFAULT NULL,
  `sti_results` varchar(255) DEFAULT NULL,
  `sti_treated` varchar(10) DEFAULT NULL,
  `sti_referred` varchar(10) DEFAULT NULL,
  `sti_referred_text` varchar(255) DEFAULT NULL,
  `tb_screened` varchar(10) DEFAULT NULL,
  `tb_results` varchar(255) DEFAULT NULL,
  `tb_treated` varchar(10) DEFAULT NULL,
  `tb_referred` varchar(10) DEFAULT NULL,
  `tb_referred_text` varchar(255) DEFAULT NULL,
  `hepatitisB_screened` varchar(10) DEFAULT NULL,
  `hepatitisB_results` varchar(255) DEFAULT NULL,
  `hepatitisB_treated` varchar(10) DEFAULT NULL,
  `hepatitisB_referred` varchar(10) DEFAULT NULL,
  `hepatitisB_text` varchar(255) DEFAULT NULL,
  `hepatitisC_screened` varchar(10) DEFAULT NULL,
  `hepatitisC_results` varchar(255) DEFAULT NULL,
  `hepatitisC_treated` varchar(10) DEFAULT NULL,
  `hepatitisC_referred` varchar(10) DEFAULT NULL,
  `hepatitisC_text` varchar(255) DEFAULT NULL,
  `overdose_screened` varchar(10) DEFAULT NULL,
  `overdose_results` varchar(255) DEFAULT NULL,
  `overdose_treated` varchar(10) DEFAULT NULL,
  `received_naloxone` varchar(10) DEFAULT NULL,
  `overdose_referred` varchar(10) DEFAULT NULL,
  `overdose_text` varchar(255) DEFAULT NULL,
  `abscess_screened` varchar(10) DEFAULT NULL,
  `abscess_results` varchar(255) DEFAULT NULL,
  `abscess_treated` varchar(10) DEFAULT NULL,
  `abscess_referred` varchar(10) DEFAULT NULL,
  `abscess_text` varchar(255) DEFAULT NULL,
  `alcohol_screened` varchar(10) DEFAULT NULL,
  `alcohol_results` varchar(255) DEFAULT NULL,
  `alcohol_treated` varchar(10) DEFAULT NULL,
  `alcohol_referred` varchar(10) DEFAULT NULL,
  `alcohol_text` varchar(255) DEFAULT NULL,
  `cerv_cancer_screened` varchar(10) DEFAULT NULL,
  `cerv_cancer_results` varchar(255) DEFAULT NULL,
  `cerv_cancer_treated` varchar(10) DEFAULT NULL,
  `cerv_cancer_referred` varchar(10) DEFAULT NULL,
  `cerv_cancer_text` varchar(255) DEFAULT NULL,
  `prep_screened` varchar(10) DEFAULT NULL,
  `prep_results` varchar(255) DEFAULT NULL,
  `prep_treated` varchar(10) DEFAULT NULL,
  `prep_referred` varchar(10) DEFAULT NULL,
  `prep_text` varchar(255) DEFAULT NULL,
  `violence_screened` varchar(10) DEFAULT NULL,
  `violence_results` varchar(255) DEFAULT NULL,
  `violence_treated` varchar(10) DEFAULT NULL,
  `violence_referred` varchar(10) DEFAULT NULL,
  `violence_text` varchar(255) DEFAULT NULL,
  `risk_red_counselling_screened` varchar(10) DEFAULT NULL,
  `risk_red_counselling_eligibility` varchar(255) DEFAULT NULL,
  `risk_red_counselling_support` varchar(10) DEFAULT NULL,
  `risk_red_counselling_ebi_provided` varchar(10) DEFAULT NULL,
  `risk_red_counselling_text` varchar(255) DEFAULT NULL,
  `fp_screened` varchar(10) DEFAULT NULL,
  `fp_eligibility` varchar(255) DEFAULT NULL,
  `fp_treated` varchar(10) DEFAULT NULL,
  `fp_referred` varchar(10) DEFAULT NULL,
  `fp_text` varchar(255) DEFAULT NULL,
  `mental_health_screened` varchar(10) DEFAULT NULL,
  `mental_health_results` varchar(255) DEFAULT NULL,
  `mental_health_support` varchar(100) DEFAULT NULL,
  `mental_health_referred` varchar(10) DEFAULT NULL,
  `mental_health_text` varchar(255) DEFAULT NULL,
  `hiv_self_rep_status` varchar(50) DEFAULT NULL,
  `last_hiv_test_setting` varchar(100) DEFAULT NULL,
  `counselled_for_hiv` varchar(10) DEFAULT NULL,
  `hiv_tested` varchar(10) DEFAULT NULL,
  `test_frequency` varchar(100) DEFAULT NULL,
  `received_results` varchar(10) DEFAULT NULL,
  `test_results` varchar(100) DEFAULT NULL,
  `linked_to_art` varchar(10) DEFAULT NULL,
  `facility_linked_to` varchar(10) DEFAULT NULL,
  `self_test_education` varchar(10) DEFAULT NULL,
  `self_test_kits_given` varchar(100) DEFAULT NULL,
  `self_use_kits` varchar(10) DEFAULT NULL,
  `distribution_kits` varchar(10) DEFAULT NULL,
  `self_tested` varchar(10) DEFAULT NULL,
  `self_test_date` date DEFAULT NULL,
  `self_test_frequency` varchar(100) DEFAULT NULL,
  `self_test_results` varchar(100) DEFAULT NULL,
  `test_confirmatory_results` varchar(100) DEFAULT NULL,
  `confirmatory_facility` varchar(100) DEFAULT NULL,
  `offsite_confirmatory_facility` varchar(100) DEFAULT NULL,
  `self_test_linked_art` varchar(10) DEFAULT NULL,
  `self_test_link_facility` varchar(255) DEFAULT NULL,
  `hiv_care_facility` varchar(255) DEFAULT NULL,
  `other_hiv_care_facility` varchar(255) DEFAULT NULL,
  `initiated_art_this_month` varchar(10) DEFAULT NULL,
  `active_art` varchar(10) DEFAULT NULL,
  `eligible_vl` varchar(50) DEFAULT NULL,
  `vl_test_done` varchar(100) DEFAULT NULL,
  `vl_results` varchar(100) DEFAULT NULL,
  `received_vl_results` varchar(100) DEFAULT NULL,
  `condom_use_education` varchar(10) DEFAULT NULL,
  `post_abortal_care` varchar(10) DEFAULT NULL,
  `linked_to_psychosocial` varchar(10) DEFAULT NULL,
  `male_condoms_no` varchar(10) DEFAULT NULL,
  `female_condoms_no` varchar(10) DEFAULT NULL,
  `lubes_no` varchar(10) DEFAULT NULL,
  `syringes_needles_no` varchar(10) DEFAULT NULL,
  `pep_eligible` varchar(10) DEFAULT NULL,
  `exposure_type` varchar(100) DEFAULT NULL,
  `other_exposure_type` varchar(100) DEFAULT NULL,
  `clinical_notes` varchar(255) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `client_id` (`client_id`),
  KEY `client_id_2` (`client_id`,`visit_date`),
  CONSTRAINT `etl_clinical_visit_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_contact`
--

DROP TABLE IF EXISTS `etl_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_contact` (
  `uuid` char(38) DEFAULT NULL,
  `unique_identifier` varchar(50) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `key_population_type` varchar(255) DEFAULT NULL,
  `contacted_by_peducator` varchar(10) DEFAULT NULL,
  `program_name` varchar(255) DEFAULT NULL,
  `frequent_hotspot_name` varchar(255) DEFAULT NULL,
  `frequent_hotspot_type` varchar(255) DEFAULT NULL,
  `year_started_sex_work` varchar(10) DEFAULT NULL,
  `year_started_sex_with_men` varchar(10) DEFAULT NULL,
  `year_started_drugs` varchar(10) DEFAULT NULL,
  `avg_weekly_sex_acts` int(11) DEFAULT NULL,
  `avg_weekly_anal_sex_acts` int(11) DEFAULT NULL,
  `avg_daily_drug_injections` int(11) DEFAULT NULL,
  `contact_person_name` varchar(255) DEFAULT NULL,
  `contact_person_alias` varchar(255) DEFAULT NULL,
  `contact_person_phone` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `client_id` (`client_id`),
  KEY `unique_identifier` (`unique_identifier`),
  KEY `key_population_type` (`key_population_type`),
  CONSTRAINT `etl_contact_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_contacts_linked`
--

DROP TABLE IF EXISTS `etl_contacts_linked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_contacts_linked` (
  `id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `relationship_type` int(11) DEFAULT NULL,
  `baseline_hiv_status` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `final_test_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  KEY `id` (`id`),
  KEY `visit_date` (`visit_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_covid19_assessment`
--

DROP TABLE IF EXISTS `etl_covid19_assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_covid19_assessment` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` varchar(10) DEFAULT NULL,
  `ever_vaccinated` varchar(10) DEFAULT NULL,
  `first_vaccine_type` varchar(10) DEFAULT NULL,
  `second_vaccine_type` varchar(10) DEFAULT NULL,
  `first_dose` varchar(10) DEFAULT NULL,
  `second_dose` varchar(10) DEFAULT NULL,
  `first_dose_date` varchar(10) DEFAULT NULL,
  `second_dose_date` varchar(10) DEFAULT NULL,
  `first_vaccination_verified` varchar(10) DEFAULT NULL,
  `second_vaccination_verified` varchar(10) DEFAULT NULL,
  `final_vaccination_status` varchar(10) DEFAULT NULL,
  `ever_received_booster` varchar(10) DEFAULT NULL,
  `booster_vaccine_taken` varchar(10) DEFAULT NULL,
  `date_taken_booster_vaccine` varchar(10) DEFAULT NULL,
  `booster_sequence` varchar(10) DEFAULT NULL,
  `booster_dose_verified` varchar(10) DEFAULT NULL,
  `ever_tested_covid_19_positive` varchar(10) DEFAULT NULL,
  `symptomatic` varchar(10) DEFAULT NULL,
  `date_tested_positive` varchar(10) DEFAULT NULL,
  `hospital_admission` varchar(10) DEFAULT NULL,
  `admission_unit` varchar(50) DEFAULT NULL,
  `on_ventillator` varchar(10) DEFAULT NULL,
  `on_oxygen_supplement` varchar(10) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `patient_id` (`patient_id`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_covid19_assessment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_current_in_care`
--

DROP TABLE IF EXISTS `etl_current_in_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_current_in_care` (
  `visit_date` date DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `Gender` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `enroll_date` date DEFAULT NULL,
  `latest_enrolment_date` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `latest_vis_date` varchar(19) CHARACTER SET utf8 DEFAULT NULL,
  `latest_tca` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `stability` varchar(53) CHARACTER SET utf8 DEFAULT NULL,
  `disc_patient` int(11),
  `effective_disc_date` date DEFAULT NULL,
  `date_discontinued` datetime DEFAULT NULL,
  `started_on_drugs` int(11),
  KEY `enroll_date` (`enroll_date`),
  KEY `latest_vis_date` (`latest_vis_date`),
  KEY `latest_tca` (`latest_tca`),
  KEY `started_on_drugs` (`started_on_drugs`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_default_facility_info`
--

DROP TABLE IF EXISTS `etl_default_facility_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_default_facility_info` (
  `siteCode` mediumtext CHARACTER SET utf8,
  `FacilityName` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_depression_screening`
--

DROP TABLE IF EXISTS `etl_depression_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_depression_screening` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `PHQ_9_rating` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `etl_depression_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_drug_event`
--

DROP TABLE IF EXISTS `etl_drug_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_drug_event` (
  `uuid` char(38) NOT NULL DEFAULT '',
  `patient_id` int(11) NOT NULL,
  `date_started` date DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `program` varchar(50) DEFAULT NULL,
  `regimen` mediumtext,
  `regimen_name` varchar(100) DEFAULT NULL,
  `regimen_line` varchar(50) DEFAULT NULL,
  `discontinued` int(11) DEFAULT NULL,
  `regimen_discontinued` varchar(255) DEFAULT NULL,
  `regimen_stopped` int(11) DEFAULT NULL,
  `date_discontinued` date DEFAULT NULL,
  `reason_discontinued` int(11) DEFAULT NULL,
  `reason_discontinued_other` varchar(100) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `date_started` (`date_started`),
  KEY `date_discontinued` (`date_discontinued`),
  KEY `patient_id_2` (`patient_id`,`date_started`),
  CONSTRAINT `etl_drug_event_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_enhanced_adherence`
--

DROP TABLE IF EXISTS `etl_enhanced_adherence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_enhanced_adherence` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `session_number` int(11) DEFAULT NULL,
  `first_session_date` date DEFAULT NULL,
  `pill_count` int(11) DEFAULT NULL,
  `arv_adherence` varchar(50) DEFAULT NULL,
  `has_vl_results` varchar(10) DEFAULT NULL,
  `vl_results_suppressed` varchar(10) DEFAULT NULL,
  `vl_results_feeling` varchar(255) DEFAULT NULL,
  `cause_of_high_vl` varchar(255) DEFAULT NULL,
  `way_forward` varchar(255) DEFAULT NULL,
  `patient_hiv_knowledge` varchar(255) DEFAULT NULL,
  `patient_drugs_uptake` varchar(255) DEFAULT NULL,
  `patient_drugs_reminder_tools` varchar(255) DEFAULT NULL,
  `patient_drugs_uptake_during_travels` varchar(255) DEFAULT NULL,
  `patient_drugs_side_effects_response` varchar(255) DEFAULT NULL,
  `patient_drugs_uptake_most_difficult_times` varchar(255) DEFAULT NULL,
  `patient_drugs_daily_uptake_feeling` varchar(255) DEFAULT NULL,
  `patient_ambitions` varchar(255) DEFAULT NULL,
  `patient_has_people_to_talk` varchar(10) DEFAULT NULL,
  `patient_enlisting_social_support` varchar(255) DEFAULT NULL,
  `patient_income_sources` varchar(255) DEFAULT NULL,
  `patient_challenges_reaching_clinic` varchar(10) DEFAULT NULL,
  `patient_worried_of_accidental_disclosure` varchar(10) DEFAULT NULL,
  `patient_treated_differently` varchar(10) DEFAULT NULL,
  `stigma_hinders_adherence` varchar(10) DEFAULT NULL,
  `patient_tried_faith_healing` varchar(10) DEFAULT NULL,
  `patient_adherence_improved` varchar(10) DEFAULT NULL,
  `patient_doses_missed` varchar(10) DEFAULT NULL,
  `review_and_barriers_to_adherence` varchar(255) DEFAULT NULL,
  `other_referrals` varchar(10) DEFAULT NULL,
  `appointments_honoured` varchar(10) DEFAULT NULL,
  `referral_experience` varchar(255) DEFAULT NULL,
  `home_visit_benefit` varchar(10) DEFAULT NULL,
  `adherence_plan` varchar(255) DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_enhanced_adherence_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_gbv_screening`
--

DROP TABLE IF EXISTS `etl_gbv_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_gbv_screening` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `ipv` varchar(50) DEFAULT NULL,
  `physical_ipv` varchar(50) DEFAULT NULL,
  `emotional_ipv` varchar(50) DEFAULT NULL,
  `sexual_ipv` varchar(50) DEFAULT NULL,
  `ipv_relationship` varchar(50) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `etl_gbv_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_gbv_screening_action`
--

DROP TABLE IF EXISTS `etl_gbv_screening_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_gbv_screening_action` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `obs_id` int(11) NOT NULL,
  `help_provider` varchar(100) DEFAULT NULL,
  `action_taken` varchar(100) DEFAULT NULL,
  `reason_for_not_reporting` varchar(100) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  KEY `visit_date` (`visit_date`),
  KEY `obs_id` (`obs_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `etl_gbv_screening_action_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hei_enrollment`
--

DROP TABLE IF EXISTS `etl_hei_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hei_enrollment` (
  `serial_no` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `child_exposed` int(11) DEFAULT NULL,
  `hei_id_number` varchar(50) DEFAULT NULL,
  `spd_number` varchar(50) DEFAULT NULL,
  `birth_weight` double DEFAULT NULL,
  `gestation_at_birth` double DEFAULT NULL,
  `birth_type` varchar(50) DEFAULT NULL,
  `date_first_seen` date DEFAULT NULL,
  `birth_notification_number` varchar(50) DEFAULT NULL,
  `birth_certificate_number` varchar(50) DEFAULT NULL,
  `need_for_special_care` int(11) DEFAULT NULL,
  `reason_for_special_care` int(11) DEFAULT NULL,
  `referral_source` int(11) DEFAULT NULL,
  `transfer_in` int(11) DEFAULT NULL,
  `transfer_in_date` date DEFAULT NULL,
  `facility_transferred_from` varchar(50) DEFAULT NULL,
  `district_transferred_from` varchar(50) DEFAULT NULL,
  `date_first_enrolled_in_hei_care` date DEFAULT NULL,
  `arv_prophylaxis` int(11) DEFAULT NULL,
  `mother_breastfeeding` int(11) DEFAULT NULL,
  `mother_on_NVP_during_breastfeeding` int(11) DEFAULT NULL,
  `TB_contact_history_in_household` int(11) DEFAULT NULL,
  `infant_mother_link` int(11) DEFAULT NULL,
  `mother_alive` int(11) DEFAULT NULL,
  `mother_on_pmtct_drugs` int(11) DEFAULT NULL,
  `mother_on_drug` int(11) DEFAULT NULL,
  `mother_on_art_at_infant_enrollment` int(11) DEFAULT NULL,
  `mother_drug_regimen` int(11) DEFAULT NULL,
  `infant_prophylaxis` int(11) DEFAULT NULL,
  `parent_ccc_number` varchar(50) DEFAULT NULL,
  `mode_of_delivery` int(11) DEFAULT NULL,
  `place_of_delivery` int(11) DEFAULT NULL,
  `birth_length` int(11) DEFAULT NULL,
  `birth_order` int(11) DEFAULT NULL,
  `health_facility_name` varchar(50) DEFAULT NULL,
  `date_of_birth_notification` date DEFAULT NULL,
  `date_of_birth_registration` date DEFAULT NULL,
  `birth_registration_place` varchar(50) DEFAULT NULL,
  `permanent_registration_serial` varchar(50) DEFAULT NULL,
  `mother_facility_registered` varchar(50) DEFAULT NULL,
  `exit_date` date DEFAULT NULL,
  `exit_reason` int(11) DEFAULT NULL,
  `hiv_status_at_exit` varchar(50) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `transfer_in` (`transfer_in`),
  KEY `child_exposed` (`child_exposed`),
  KEY `need_for_special_care` (`need_for_special_care`),
  KEY `reason_for_special_care` (`reason_for_special_care`),
  KEY `referral_source` (`referral_source`),
  KEY `transfer_in_2` (`transfer_in`),
  KEY `serial_no` (`serial_no`),
  CONSTRAINT `etl_hei_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hei_follow_up_visit`
--

DROP TABLE IF EXISTS `etl_hei_follow_up_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hei_follow_up_visit` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `muac` int(11) DEFAULT NULL,
  `primary_caregiver` int(11) DEFAULT NULL,
  `infant_feeding` int(11) DEFAULT NULL,
  `stunted` int(11) DEFAULT NULL,
  `tb_assessment_outcome` int(11) DEFAULT NULL,
  `social_smile_milestone` int(11) DEFAULT NULL,
  `head_control_milestone` int(11) DEFAULT NULL,
  `response_to_sound_milestone` int(11) DEFAULT NULL,
  `hand_extension_milestone` int(11) DEFAULT NULL,
  `sitting_milestone` int(11) DEFAULT NULL,
  `walking_milestone` int(11) DEFAULT NULL,
  `standing_milestone` int(11) DEFAULT NULL,
  `talking_milestone` int(11) DEFAULT NULL,
  `review_of_systems_developmental` int(11) DEFAULT NULL,
  `weight_category` int(11) DEFAULT NULL,
  `dna_pcr_sample_date` date DEFAULT NULL,
  `dna_pcr_contextual_status` int(11) DEFAULT NULL,
  `dna_pcr_result` int(11) DEFAULT NULL,
  `dna_pcr_dbs_sample_code` varchar(100) DEFAULT NULL,
  `dna_pcr_results_date` date DEFAULT NULL,
  `azt_given` int(11) DEFAULT NULL,
  `nvp_given` int(11) DEFAULT NULL,
  `ctx_given` int(11) DEFAULT NULL,
  `multi_vitamin_given` int(11) DEFAULT NULL,
  `first_antibody_sample_date` date DEFAULT NULL,
  `first_antibody_result` int(11) DEFAULT NULL,
  `first_antibody_dbs_sample_code` varchar(100) DEFAULT NULL,
  `first_antibody_result_date` date DEFAULT NULL,
  `final_antibody_sample_date` date DEFAULT NULL,
  `final_antibody_result` int(11) DEFAULT NULL,
  `final_antibody_dbs_sample_code` varchar(100) DEFAULT NULL,
  `final_antibody_result_date` date DEFAULT NULL,
  `tetracycline_ointment_given` int(11) DEFAULT NULL,
  `pupil_examination` int(11) DEFAULT NULL,
  `sight_examination` int(11) DEFAULT NULL,
  `squint` int(11) DEFAULT NULL,
  `deworming_drug` int(11) DEFAULT NULL,
  `dosage` int(11) DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `vitaminA_given` int(11) DEFAULT NULL,
  `disability` int(11) DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  `referred_from` int(11) DEFAULT NULL,
  `referred_to` int(11) DEFAULT NULL,
  `counselled_on` int(11) DEFAULT NULL,
  `MNPS_Supplementation` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `infant_feeding` (`infant_feeding`),
  CONSTRAINT `etl_hei_follow_up_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hei_immunization`
--

DROP TABLE IF EXISTS `etl_hei_immunization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hei_immunization` (
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `BCG` varchar(50) DEFAULT NULL,
  `OPV_birth` varchar(50) DEFAULT NULL,
  `OPV_1` varchar(50) DEFAULT NULL,
  `OPV_2` varchar(50) DEFAULT NULL,
  `OPV_3` varchar(50) DEFAULT NULL,
  `IPV` varchar(50) DEFAULT NULL,
  `DPT_Hep_B_Hib_1` varchar(50) DEFAULT NULL,
  `DPT_Hep_B_Hib_2` varchar(50) DEFAULT NULL,
  `DPT_Hep_B_Hib_3` varchar(50) DEFAULT NULL,
  `PCV_10_1` varchar(50) DEFAULT NULL,
  `PCV_10_2` varchar(50) DEFAULT NULL,
  `PCV_10_3` varchar(50) DEFAULT NULL,
  `ROTA_1` varchar(50) DEFAULT NULL,
  `ROTA_2` varchar(50) DEFAULT NULL,
  `Measles_rubella_1` varchar(50) DEFAULT NULL,
  `Measles_rubella_2` varchar(50) DEFAULT NULL,
  `Yellow_fever` varchar(50) DEFAULT NULL,
  `Measles_6_months` varchar(50) DEFAULT NULL,
  `VitaminA_6_months` varchar(50) DEFAULT NULL,
  `VitaminA_1_yr` varchar(50) DEFAULT NULL,
  `VitaminA_1_and_half_yr` varchar(50) DEFAULT NULL,
  `VitaminA_2_yr` varchar(50) DEFAULT NULL,
  `VitaminA_2_to_5_yr` varchar(50) DEFAULT NULL,
  `fully_immunized` date DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_hei_immunization_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hiv_enrollment`
--

DROP TABLE IF EXISTS `etl_hiv_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hiv_enrollment` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `patient_type` int(11) DEFAULT NULL,
  `date_first_enrolled_in_care` date DEFAULT NULL,
  `entry_point` int(11) DEFAULT NULL,
  `transfer_in_date` date DEFAULT NULL,
  `facility_transferred_from` varchar(255) DEFAULT NULL,
  `district_transferred_from` varchar(255) DEFAULT NULL,
  `date_started_art_at_transferring_facility` date DEFAULT NULL,
  `date_confirmed_hiv_positive` date DEFAULT NULL,
  `facility_confirmed_hiv_positive` varchar(255) DEFAULT NULL,
  `previous_regimen` varchar(255) DEFAULT NULL,
  `arv_status` int(11) DEFAULT NULL,
  `name_of_treatment_supporter` varchar(255) DEFAULT NULL,
  `relationship_of_treatment_supporter` int(11) DEFAULT NULL,
  `treatment_supporter_telephone` varchar(100) DEFAULT NULL,
  `treatment_supporter_address` varchar(100) DEFAULT NULL,
  `in_school` int(11) DEFAULT NULL,
  `orphan` int(11) DEFAULT NULL,
  `date_of_discontinuation` datetime DEFAULT NULL,
  `discontinuation_reason` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_id` (`visit_id`),
  KEY `visit_date` (`visit_date`),
  KEY `date_started_art_at_transferring_facility` (`date_started_art_at_transferring_facility`),
  KEY `arv_status` (`arv_status`),
  KEY `date_confirmed_hiv_positive` (`date_confirmed_hiv_positive`),
  KEY `entry_point` (`entry_point`),
  KEY `transfer_in_date` (`transfer_in_date`),
  KEY `date_first_enrolled_in_care` (`date_first_enrolled_in_care`),
  KEY `entry_point_2` (`entry_point`,`transfer_in_date`,`visit_date`,`patient_id`),
  CONSTRAINT `etl_hiv_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hts_contacts`
--

DROP TABLE IF EXISTS `etl_hts_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hts_contacts` (
  `id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `relationship_type` int(11) DEFAULT NULL,
  `baseline_hiv_status` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `test_type` int(11) DEFAULT NULL,
  `test_1_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `test_2_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `final_test_result` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  KEY `id` (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hts_linkage_tracing`
--

DROP TABLE IF EXISTS `etl_hts_linkage_tracing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hts_linkage_tracing` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `tracing_type` int(11) DEFAULT NULL,
  `tracing_outcome` int(11) DEFAULT NULL,
  `reason_not_contacted` int(11) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `tracing_type` (`tracing_type`),
  KEY `tracing_outcome` (`tracing_outcome`),
  KEY `reason_not_contacted` (`reason_not_contacted`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_hts_linkage_tracing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hts_referral`
--

DROP TABLE IF EXISTS `etl_hts_referral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hts_referral` (
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_uuid` char(38) DEFAULT NULL,
  `encounter_location` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `facility_referred_to` varchar(50) DEFAULT NULL,
  `date_to_enrol` date DEFAULT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hts_referral_and_linkage`
--

DROP TABLE IF EXISTS `etl_hts_referral_and_linkage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hts_referral_and_linkage` (
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_uuid` char(38) DEFAULT NULL,
  `encounter_location` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `tracing_type` varchar(50) DEFAULT NULL,
  `tracing_status` varchar(100) DEFAULT NULL,
  `ccc_number` varchar(100) DEFAULT NULL,
  `referral_facility` varchar(200) DEFAULT NULL,
  `facility_linked_to` varchar(100) DEFAULT NULL,
  `enrollment_date` date DEFAULT NULL,
  `art_start_date` date DEFAULT NULL,
  `provider_handed_to` varchar(100) DEFAULT NULL,
  `cadre` varchar(100) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `tracing_type` (`tracing_type`),
  KEY `tracing_status` (`tracing_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_hts_test`
--

DROP TABLE IF EXISTS `etl_hts_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_hts_test` (
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `encounter_uuid` char(38) DEFAULT NULL,
  `encounter_location` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `test_type` int(11) DEFAULT NULL,
  `population_type` varchar(50) DEFAULT NULL,
  `key_population_type` varchar(50) DEFAULT NULL,
  `ever_tested_for_hiv` varchar(10) DEFAULT NULL,
  `months_since_last_test` int(11) DEFAULT NULL,
  `patient_disabled` varchar(50) DEFAULT NULL,
  `disability_type` varchar(255) DEFAULT NULL,
  `patient_consented` varchar(50) DEFAULT NULL,
  `client_tested_as` varchar(50) DEFAULT NULL,
  `setting` varchar(50) DEFAULT NULL,
  `approach` varchar(50) DEFAULT NULL,
  `test_strategy` varchar(50) DEFAULT NULL,
  `hts_entry_point` varchar(50) DEFAULT NULL,
  `test_1_kit_name` varchar(50) DEFAULT NULL,
  `test_1_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_1_kit_expiry` date DEFAULT NULL,
  `test_1_result` varchar(50) DEFAULT NULL,
  `test_2_kit_name` varchar(50) DEFAULT NULL,
  `test_2_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_2_kit_expiry` date DEFAULT NULL,
  `test_2_result` varchar(50) DEFAULT NULL,
  `final_test_result` varchar(50) DEFAULT NULL,
  `patient_given_result` varchar(50) DEFAULT NULL,
  `couple_discordant` varchar(100) DEFAULT NULL,
  `referral_for` varchar(100) DEFAULT NULL,
  `referral_facility` varchar(200) DEFAULT NULL,
  `other_referral_facility` varchar(200) DEFAULT NULL,
  `tb_screening` varchar(20) DEFAULT NULL,
  `patient_had_hiv_self_test` varchar(50) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_id` (`visit_id`),
  KEY `tb_screening` (`tb_screening`),
  KEY `visit_date` (`visit_date`),
  KEY `population_type` (`population_type`),
  KEY `test_type` (`test_type`),
  KEY `final_test_result` (`final_test_result`),
  KEY `couple_discordant` (`couple_discordant`),
  KEY `test_1_kit_name` (`test_1_kit_name`),
  KEY `test_2_kit_name` (`test_2_kit_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_ipt_follow_up`
--

DROP TABLE IF EXISTS `etl_ipt_follow_up`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_ipt_follow_up` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `ipt_due_date` date DEFAULT NULL,
  `date_collected_ipt` date DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `hepatotoxity` varchar(100) DEFAULT NULL,
  `peripheral_neuropathy` varchar(100) DEFAULT NULL,
  `rash` varchar(100) DEFAULT NULL,
  `adherence` varchar(100) DEFAULT NULL,
  `action_taken` varchar(100) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `hepatotoxity` (`hepatotoxity`),
  KEY `peripheral_neuropathy` (`peripheral_neuropathy`),
  KEY `rash` (`rash`),
  KEY `adherence` (`adherence`),
  CONSTRAINT `etl_ipt_follow_up_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_ipt_initiation`
--

DROP TABLE IF EXISTS `etl_ipt_initiation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_ipt_initiation` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `ipt_indication` int(11) DEFAULT NULL,
  `sub_county_reg_number` varchar(255) DEFAULT NULL,
  `sub_county_reg_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_ipt_initiation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_ipt_outcome`
--

DROP TABLE IF EXISTS `etl_ipt_outcome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_ipt_outcome` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `outcome` int(11) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `outcome` (`outcome`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_ipt_outcome_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_ipt_screening`
--

DROP TABLE IF EXISTS `etl_ipt_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_ipt_screening` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `obs_id` int(11) NOT NULL,
  `cough` int(11) DEFAULT NULL,
  `fever` int(11) DEFAULT NULL,
  `weight_loss_poor_gain` int(11) DEFAULT NULL,
  `night_sweats` int(11) DEFAULT NULL,
  `contact_with_tb_case` int(11) DEFAULT NULL,
  `lethargy` int(11) DEFAULT NULL,
  `yellow_urine` int(11) DEFAULT NULL,
  `numbness_bs_hands_feet` int(11) DEFAULT NULL,
  `eyes_yellowness` int(11) DEFAULT NULL,
  `upper_rightQ_abdomen_tenderness` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  KEY `visit_date` (`visit_date`),
  KEY `patient_id` (`patient_id`),
  KEY `obs_id` (`obs_id`),
  KEY `visit_date_2` (`visit_date`,`patient_id`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_ipt_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_laboratory_extract`
--

DROP TABLE IF EXISTS `etl_laboratory_extract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_laboratory_extract` (
  `uuid` char(38) NOT NULL DEFAULT '',
  `encounter_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `order_id` varchar(200) DEFAULT NULL,
  `lab_test` varchar(180) DEFAULT NULL,
  `urgency` varchar(50) DEFAULT NULL,
  `order_reason` varchar(180) DEFAULT NULL,
  `test_result` varchar(180) DEFAULT NULL,
  `date_test_requested` date DEFAULT NULL,
  `date_test_result_received` date DEFAULT NULL,
  `test_requested_by` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `lab_test` (`lab_test`),
  KEY `test_result` (`test_result`),
  CONSTRAINT `etl_laboratory_extract_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_last_month_newly_enrolled_in_care`
--

DROP TABLE IF EXISTS `etl_last_month_newly_enrolled_in_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_last_month_newly_enrolled_in_care` (
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_last_month_newly_on_art`
--

DROP TABLE IF EXISTS `etl_last_month_newly_on_art`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_last_month_newly_on_art` (
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_mch_antenatal_visit`
--

DROP TABLE IF EXISTS `etl_mch_antenatal_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_mch_antenatal_visit` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `anc_visit_number` int(11) DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `systolic_bp` double DEFAULT NULL,
  `diastolic_bp` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `hemoglobin` double DEFAULT NULL,
  `breast_exam_done` int(11) DEFAULT NULL,
  `pallor` int(11) DEFAULT NULL,
  `maturity` int(11) DEFAULT NULL,
  `fundal_height` double DEFAULT NULL,
  `fetal_presentation` int(11) DEFAULT NULL,
  `lie` int(11) DEFAULT NULL,
  `fetal_heart_rate` int(11) DEFAULT NULL,
  `fetal_movement` int(11) DEFAULT NULL,
  `who_stage` int(11) DEFAULT NULL,
  `cd4` int(11) DEFAULT NULL,
  `vl_sample_taken` int(11) DEFAULT NULL,
  `viral_load` int(11) DEFAULT NULL,
  `ldl` int(11) DEFAULT NULL,
  `arv_status` int(11) DEFAULT NULL,
  `test_1_kit_name` varchar(50) DEFAULT NULL,
  `test_1_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_1_kit_expiry` date DEFAULT NULL,
  `test_1_result` varchar(50) DEFAULT NULL,
  `test_2_kit_name` varchar(50) DEFAULT NULL,
  `test_2_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_2_kit_expiry` date DEFAULT NULL,
  `test_2_result` varchar(50) DEFAULT NULL,
  `final_test_result` varchar(50) DEFAULT NULL,
  `patient_given_result` varchar(50) DEFAULT NULL,
  `partner_hiv_tested` int(11) DEFAULT NULL,
  `partner_hiv_status` int(11) DEFAULT NULL,
  `prophylaxis_given` int(11) DEFAULT NULL,
  `date_given_haart` date DEFAULT NULL,
  `baby_azt_dispensed` int(11) DEFAULT NULL,
  `baby_nvp_dispensed` int(11) DEFAULT NULL,
  `TTT` varchar(50) DEFAULT NULL,
  `IPT_malaria` varchar(50) DEFAULT NULL,
  `iron_supplement` varchar(50) DEFAULT NULL,
  `deworming` varchar(50) DEFAULT NULL,
  `bed_nets` varchar(50) DEFAULT NULL,
  `urine_microscopy` varchar(100) DEFAULT NULL,
  `urinary_albumin` int(11) DEFAULT NULL,
  `glucose_measurement` int(11) DEFAULT NULL,
  `urine_ph` int(11) DEFAULT NULL,
  `urine_gravity` int(11) DEFAULT NULL,
  `urine_nitrite_test` int(11) DEFAULT NULL,
  `urine_leukocyte_esterace_test` int(11) DEFAULT NULL,
  `urinary_ketone` int(11) DEFAULT NULL,
  `urine_bile_salt_test` int(11) DEFAULT NULL,
  `urine_bile_pigment_test` int(11) DEFAULT NULL,
  `urine_colour` int(11) DEFAULT NULL,
  `urine_turbidity` int(11) DEFAULT NULL,
  `urine_dipstick_for_blood` int(11) DEFAULT NULL,
  `syphilis_test_status` int(11) DEFAULT NULL,
  `syphilis_treated_status` int(11) DEFAULT NULL,
  `bs_mps` int(11) DEFAULT NULL,
  `anc_exercises` int(11) DEFAULT NULL,
  `tb_screening` int(11) DEFAULT NULL,
  `cacx_screening` int(11) DEFAULT NULL,
  `cacx_screening_method` int(11) DEFAULT NULL,
  `has_other_illnes` int(11) DEFAULT NULL,
  `counselled` int(11) DEFAULT NULL,
  `counselled_on_birth_plans` int(11) DEFAULT NULL,
  `counselled_on_danger_signs` int(11) DEFAULT NULL,
  `counselled_on_family_planning` int(11) DEFAULT NULL,
  `counselled_on_hiv` int(11) DEFAULT NULL,
  `counselled_on_supplimental_feeding` int(11) DEFAULT NULL,
  `counselled_on_breast_care` int(11) DEFAULT NULL,
  `counselled_on_infant_feeding` int(11) DEFAULT NULL,
  `counselled_on_treated_nets` int(11) DEFAULT NULL,
  `referred_from` int(11) DEFAULT NULL,
  `referred_to` int(11) DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  `clinical_notes` varchar(200) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `who_stage` (`who_stage`),
  KEY `anc_visit_number` (`anc_visit_number`),
  KEY `final_test_result` (`final_test_result`),
  KEY `tb_screening` (`tb_screening`),
  KEY `syphilis_test_status` (`syphilis_test_status`),
  KEY `cacx_screening` (`cacx_screening`),
  KEY `next_appointment_date` (`next_appointment_date`),
  KEY `arv_status` (`arv_status`),
  CONSTRAINT `etl_mch_antenatal_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_mch_enrollment`
--

DROP TABLE IF EXISTS `etl_mch_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_mch_enrollment` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `service_type` int(11) DEFAULT NULL,
  `anc_number` varchar(50) DEFAULT NULL,
  `first_anc_visit_date` date DEFAULT NULL,
  `gravida` int(11) DEFAULT NULL,
  `parity` int(11) DEFAULT NULL,
  `parity_abortion` int(11) DEFAULT NULL,
  `age_at_menarche` int(11) DEFAULT NULL,
  `lmp` date DEFAULT NULL,
  `lmp_estimated` int(11) DEFAULT NULL,
  `edd_ultrasound` date DEFAULT NULL,
  `blood_group` int(11) DEFAULT NULL,
  `serology` int(11) DEFAULT NULL,
  `tb_screening` int(11) DEFAULT NULL,
  `bs_for_mps` int(11) DEFAULT NULL,
  `hiv_status` int(11) DEFAULT NULL,
  `hiv_test_date` date DEFAULT NULL,
  `partner_hiv_status` int(11) DEFAULT NULL,
  `partner_hiv_test_date` date DEFAULT NULL,
  `urine_microscopy` varchar(100) DEFAULT NULL,
  `urinary_albumin` int(11) DEFAULT NULL,
  `glucose_measurement` int(11) DEFAULT NULL,
  `urine_ph` int(11) DEFAULT NULL,
  `urine_gravity` int(11) DEFAULT NULL,
  `urine_nitrite_test` int(11) DEFAULT NULL,
  `urine_leukocyte_esterace_test` int(11) DEFAULT NULL,
  `urinary_ketone` int(11) DEFAULT NULL,
  `urine_bile_salt_test` int(11) DEFAULT NULL,
  `urine_bile_pigment_test` int(11) DEFAULT NULL,
  `urine_colour` int(11) DEFAULT NULL,
  `urine_turbidity` int(11) DEFAULT NULL,
  `urine_dipstick_for_blood` int(11) DEFAULT NULL,
  `date_of_discontinuation` datetime DEFAULT NULL,
  `discontinuation_reason` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `tb_screening` (`tb_screening`),
  KEY `hiv_status` (`hiv_status`),
  KEY `hiv_test_date` (`hiv_test_date`),
  KEY `partner_hiv_status` (`partner_hiv_status`),
  CONSTRAINT `etl_mch_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_mch_postnatal_visit`
--

DROP TABLE IF EXISTS `etl_mch_postnatal_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_mch_postnatal_visit` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `pnc_register_no` varchar(50) DEFAULT NULL,
  `pnc_visit_no` int(11) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `mode_of_delivery` int(11) DEFAULT NULL,
  `place_of_delivery` int(11) DEFAULT NULL,
  `delivery_outcome` int(11) DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `systolic_bp` double DEFAULT NULL,
  `diastolic_bp` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `hemoglobin` double DEFAULT NULL,
  `arv_status` int(11) DEFAULT NULL,
  `general_condition` int(11) DEFAULT NULL,
  `breast` int(11) DEFAULT NULL,
  `cs_scar` int(11) DEFAULT NULL,
  `gravid_uterus` int(11) DEFAULT NULL,
  `episiotomy` int(11) DEFAULT NULL,
  `lochia` int(11) DEFAULT NULL,
  `counselled_on_infant_feeding` int(11) DEFAULT NULL,
  `pallor` int(11) DEFAULT NULL,
  `pph` int(11) DEFAULT NULL,
  `mother_hiv_status` int(11) DEFAULT NULL,
  `condition_of_baby` int(11) DEFAULT NULL,
  `baby_feeding_method` int(11) DEFAULT NULL,
  `umblical_cord` int(11) DEFAULT NULL,
  `baby_immunization_started` int(11) DEFAULT NULL,
  `family_planning_counseling` int(11) DEFAULT NULL,
  `uterus_examination` varchar(100) DEFAULT NULL,
  `uterus_cervix_examination` varchar(100) DEFAULT NULL,
  `vaginal_examination` varchar(100) DEFAULT NULL,
  `parametrial_examination` varchar(100) DEFAULT NULL,
  `external_genitalia_examination` varchar(100) DEFAULT NULL,
  `ovarian_examination` varchar(100) DEFAULT NULL,
  `pelvic_lymph_node_exam` varchar(100) DEFAULT NULL,
  `test_1_kit_name` varchar(50) DEFAULT NULL,
  `test_1_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_1_kit_expiry` date DEFAULT NULL,
  `test_1_result` varchar(50) DEFAULT NULL,
  `test_2_kit_name` varchar(50) DEFAULT NULL,
  `test_2_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_2_kit_expiry` date DEFAULT NULL,
  `test_2_result` varchar(50) DEFAULT NULL,
  `final_test_result` varchar(50) DEFAULT NULL,
  `patient_given_result` varchar(50) DEFAULT NULL,
  `partner_hiv_tested` int(11) DEFAULT NULL,
  `partner_hiv_status` int(11) DEFAULT NULL,
  `prophylaxis_given` int(11) DEFAULT NULL,
  `baby_azt_dispensed` int(11) DEFAULT NULL,
  `baby_nvp_dispensed` int(11) DEFAULT NULL,
  `pnc_exercises` int(11) DEFAULT NULL,
  `maternal_condition` int(11) DEFAULT NULL,
  `iron_supplementation` int(11) DEFAULT NULL,
  `fistula_screening` int(11) DEFAULT NULL,
  `cacx_screening` int(11) DEFAULT NULL,
  `cacx_screening_method` int(11) DEFAULT NULL,
  `family_planning_status` int(11) DEFAULT NULL,
  `family_planning_method` int(11) DEFAULT NULL,
  `referred_from` int(11) DEFAULT NULL,
  `referred_to` int(11) DEFAULT NULL,
  `clinical_notes` varchar(200) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `arv_status` (`arv_status`),
  KEY `mother_hiv_status` (`mother_hiv_status`),
  KEY `arv_status_2` (`arv_status`),
  CONSTRAINT `etl_mch_postnatal_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_mchs_delivery`
--

DROP TABLE IF EXISTS `etl_mchs_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_mchs_delivery` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `admission_number` varchar(50) DEFAULT NULL,
  `duration_of_pregnancy` double DEFAULT NULL,
  `mode_of_delivery` int(11) DEFAULT NULL,
  `date_of_delivery` datetime DEFAULT NULL,
  `blood_loss` int(11) DEFAULT NULL,
  `condition_of_mother` int(11) DEFAULT NULL,
  `delivery_outcome` varchar(255) DEFAULT NULL,
  `apgar_score_1min` double DEFAULT NULL,
  `apgar_score_5min` double DEFAULT NULL,
  `apgar_score_10min` double DEFAULT NULL,
  `resuscitation_done` int(11) DEFAULT NULL,
  `place_of_delivery` int(11) DEFAULT NULL,
  `delivery_assistant` varchar(100) DEFAULT NULL,
  `counseling_on_infant_feeding` int(11) DEFAULT NULL,
  `counseling_on_exclusive_breastfeeding` int(11) DEFAULT NULL,
  `counseling_on_infant_feeding_for_hiv_infected` int(11) DEFAULT NULL,
  `mother_decision` int(11) DEFAULT NULL,
  `placenta_complete` int(11) DEFAULT NULL,
  `maternal_death_audited` int(11) DEFAULT NULL,
  `cadre` int(11) DEFAULT NULL,
  `delivery_complications` int(11) DEFAULT NULL,
  `coded_delivery_complications` int(11) DEFAULT NULL,
  `other_delivery_complications` varchar(100) DEFAULT NULL,
  `duration_of_labor` int(11) DEFAULT NULL,
  `baby_sex` int(11) DEFAULT NULL,
  `baby_condition` int(11) DEFAULT NULL,
  `teo_given` int(11) DEFAULT NULL,
  `birth_weight` int(11) DEFAULT NULL,
  `bf_within_one_hour` int(11) DEFAULT NULL,
  `birth_with_deformity` int(11) DEFAULT NULL,
  `test_1_kit_name` varchar(50) DEFAULT NULL,
  `test_1_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_1_kit_expiry` date DEFAULT NULL,
  `test_1_result` varchar(50) DEFAULT NULL,
  `test_2_kit_name` varchar(50) DEFAULT NULL,
  `test_2_kit_lot_no` varchar(50) DEFAULT NULL,
  `test_2_kit_expiry` date DEFAULT NULL,
  `test_2_result` varchar(50) DEFAULT NULL,
  `final_test_result` varchar(50) DEFAULT NULL,
  `patient_given_result` varchar(50) DEFAULT NULL,
  `partner_hiv_tested` int(11) DEFAULT NULL,
  `partner_hiv_status` int(11) DEFAULT NULL,
  `prophylaxis_given` int(11) DEFAULT NULL,
  `baby_azt_dispensed` int(11) DEFAULT NULL,
  `baby_nvp_dispensed` int(11) DEFAULT NULL,
  `clinical_notes` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `final_test_result` (`final_test_result`),
  KEY `baby_sex` (`baby_sex`),
  KEY `partner_hiv_tested` (`partner_hiv_tested`),
  KEY `partner_hiv_status` (`partner_hiv_status`),
  CONSTRAINT `etl_mchs_delivery_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_mchs_discharge`
--

DROP TABLE IF EXISTS `etl_mchs_discharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_mchs_discharge` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `counselled_on_feeding` int(11) DEFAULT NULL,
  `baby_status` int(11) DEFAULT NULL,
  `vitamin_A_dispensed` int(11) DEFAULT NULL,
  `birth_notification_number` int(50) DEFAULT NULL,
  `condition_of_mother` varchar(100) DEFAULT NULL,
  `discharge_date` date DEFAULT NULL,
  `referred_from` int(11) DEFAULT NULL,
  `referred_to` int(11) DEFAULT NULL,
  `clinical_notes` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `baby_status` (`baby_status`),
  KEY `discharge_date` (`discharge_date`),
  CONSTRAINT `etl_mchs_discharge_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_missed_appointments`
--

DROP TABLE IF EXISTS `etl_missed_appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_missed_appointments` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `last_tca_date` date DEFAULT NULL,
  `last_visit_date` date DEFAULT NULL,
  `last_encounter_type` varchar(100) DEFAULT NULL,
  `days_since_last_visit` int(11) DEFAULT NULL,
  `date_table_created` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `etl_missed_appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_otz_activity`
--

DROP TABLE IF EXISTS `etl_otz_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_otz_activity` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `orientation` varchar(11) DEFAULT NULL,
  `leadership` varchar(11) DEFAULT NULL,
  `participation` varchar(11) DEFAULT NULL,
  `treatment_literacy` varchar(11) DEFAULT NULL,
  `transition_to_adult_care` varchar(11) DEFAULT NULL,
  `making_decision_future` varchar(11) DEFAULT NULL,
  `srh` varchar(11) DEFAULT NULL,
  `beyond_third_ninety` varchar(11) DEFAULT NULL,
  `attended_support_group` varchar(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_otz_activity_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_otz_enrollment`
--

DROP TABLE IF EXISTS `etl_otz_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_otz_enrollment` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `orientation` varchar(11) DEFAULT NULL,
  `leadership` varchar(11) DEFAULT NULL,
  `participation` varchar(11) DEFAULT NULL,
  `treatment_literacy` varchar(11) DEFAULT NULL,
  `transition_to_adult_care` varchar(11) DEFAULT NULL,
  `making_decision_future` varchar(11) DEFAULT NULL,
  `srh` varchar(11) DEFAULT NULL,
  `beyond_third_ninety` varchar(11) DEFAULT NULL,
  `transfer_in` varchar(11) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_otz_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_ovc_enrolment`
--

DROP TABLE IF EXISTS `etl_ovc_enrolment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_ovc_enrolment` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `caregiver_enrolled_here` varchar(11) DEFAULT NULL,
  `caregiver_name` varchar(11) DEFAULT NULL,
  `caregiver_gender` varchar(255) DEFAULT NULL,
  `relationship_to_client` varchar(255) DEFAULT NULL,
  `caregiver_phone_number` varchar(255) DEFAULT NULL,
  `client_enrolled_cpims` varchar(11) DEFAULT NULL,
  `partner_offering_ovc` varchar(255) DEFAULT NULL,
  `ovc_comprehensive_program` varchar(255) DEFAULT NULL,
  `dreams_program` varchar(255) DEFAULT NULL,
  `ovc_preventive_program` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_ovc_enrolment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_patient_contact`
--

DROP TABLE IF EXISTS `etl_patient_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_patient_contact` (
  `id` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `birth_date` datetime DEFAULT NULL,
  `physical_address` varchar(255) DEFAULT NULL,
  `phone_contact` varchar(255) DEFAULT NULL,
  `patient_related_to` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `relationship_type` int(11) DEFAULT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `baseline_hiv_status` varchar(255) DEFAULT NULL,
  `ipv_outcome` varchar(255) DEFAULT NULL,
  `marital_status` varchar(100) DEFAULT NULL,
  `living_with_patient` varchar(100) DEFAULT NULL,
  `pns_approach` varchar(100) DEFAULT NULL,
  `contact_listing_decline_reason` varchar(255) DEFAULT NULL,
  `consented_contact_listing` varchar(100) DEFAULT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_related_to` (`patient_related_to`),
  KEY `date_created` (`date_created`),
  KEY `id` (`id`),
  KEY `id_2` (`id`,`date_created`),
  CONSTRAINT `etl_patient_contact_ibfk_1` FOREIGN KEY (`patient_related_to`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_patient_demographics`
--

DROP TABLE IF EXISTS `etl_patient_demographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_patient_demographics` (
  `patient_id` int(11) NOT NULL,
  `given_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `family_name` varchar(255) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `national_id_no` varchar(50) DEFAULT NULL,
  `unique_patient_no` varchar(50) DEFAULT NULL,
  `patient_clinic_number` varchar(15) DEFAULT NULL,
  `Tb_no` varchar(50) DEFAULT NULL,
  `CPIMS_unique_identifier` varchar(50) DEFAULT NULL,
  `openmrs_id` varchar(50) DEFAULT NULL,
  `district_reg_no` varchar(50) DEFAULT NULL,
  `hei_no` varchar(50) DEFAULT NULL,
  `cwc_number` varchar(50) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `birth_place` varchar(50) DEFAULT NULL,
  `citizenship` varchar(50) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `next_of_kin` varchar(255) DEFAULT NULL,
  `next_of_kin_phone` varchar(100) DEFAULT NULL,
  `next_of_kin_relationship` varchar(100) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `education_level` varchar(50) DEFAULT NULL,
  `kdod_service_number` varchar(50) DEFAULT NULL,
  `cadre` varchar(100) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `dead` int(11) DEFAULT NULL,
  `death_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `patient_id` (`patient_id`),
  KEY `Gender` (`Gender`),
  KEY `unique_patient_no` (`unique_patient_no`),
  KEY `DOB` (`DOB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_patient_hiv_followup`
--

DROP TABLE IF EXISTS `etl_patient_hiv_followup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_patient_hiv_followup` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_scheduled` int(11) DEFAULT NULL,
  `person_present` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `systolic_pressure` double DEFAULT NULL,
  `diastolic_pressure` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `nutritional_status` int(11) DEFAULT NULL,
  `population_type` int(11) DEFAULT NULL,
  `key_population_type` int(11) DEFAULT NULL,
  `who_stage` int(11) DEFAULT NULL,
  `presenting_complaints` int(11) DEFAULT NULL,
  `clinical_notes` varchar(600) DEFAULT NULL,
  `on_anti_tb_drugs` int(11) DEFAULT NULL,
  `on_ipt` int(11) DEFAULT NULL,
  `ever_on_ipt` int(11) DEFAULT NULL,
  `cough` int(11) DEFAULT '-1',
  `fever` int(11) DEFAULT '-1',
  `weight_loss_poor_gain` int(11) DEFAULT '-1',
  `night_sweats` int(11) DEFAULT '-1',
  `tb_case_contact` int(11) DEFAULT '-1',
  `lethargy` int(11) DEFAULT '-1',
  `screened_for_tb` varchar(50) DEFAULT NULL,
  `spatum_smear_ordered` int(11) DEFAULT NULL,
  `chest_xray_ordered` int(11) DEFAULT NULL,
  `genexpert_ordered` int(11) DEFAULT NULL,
  `spatum_smear_result` int(11) DEFAULT NULL,
  `chest_xray_result` int(11) DEFAULT NULL,
  `genexpert_result` int(11) DEFAULT NULL,
  `referral` int(11) DEFAULT NULL,
  `clinical_tb_diagnosis` int(11) DEFAULT NULL,
  `contact_invitation` int(11) DEFAULT NULL,
  `evaluated_for_ipt` int(11) DEFAULT NULL,
  `has_known_allergies` int(11) DEFAULT NULL,
  `has_chronic_illnesses_cormobidities` int(11) DEFAULT NULL,
  `has_adverse_drug_reaction` int(11) DEFAULT NULL,
  `substitution_first_line_regimen_date` date DEFAULT NULL,
  `substitution_first_line_regimen_reason` int(11) DEFAULT NULL,
  `substitution_second_line_regimen_date` date DEFAULT NULL,
  `substitution_second_line_regimen_reason` int(11) DEFAULT NULL,
  `second_line_regimen_change_date` date DEFAULT NULL,
  `second_line_regimen_change_reason` int(11) DEFAULT NULL,
  `pregnancy_status` int(11) DEFAULT NULL,
  `wants_pregnancy` int(11) DEFAULT NULL,
  `pregnancy_outcome` int(11) DEFAULT NULL,
  `anc_number` varchar(50) DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `ever_had_menses` int(11) DEFAULT NULL,
  `last_menstrual_period` date DEFAULT NULL,
  `menopausal` int(11) DEFAULT NULL,
  `gravida` int(11) DEFAULT NULL,
  `parity` int(11) DEFAULT NULL,
  `full_term_pregnancies` int(11) DEFAULT NULL,
  `abortion_miscarriages` int(11) DEFAULT NULL,
  `family_planning_status` int(11) DEFAULT NULL,
  `family_planning_method` int(11) DEFAULT NULL,
  `reason_not_using_family_planning` int(11) DEFAULT NULL,
  `tb_status` int(11) DEFAULT NULL,
  `started_anti_TB` int(11) DEFAULT NULL,
  `tb_rx_date` date DEFAULT NULL,
  `tb_treatment_no` varchar(50) DEFAULT NULL,
  `general_examination` varchar(255) DEFAULT NULL,
  `system_examination` int(11) DEFAULT NULL,
  `skin_findings` int(11) DEFAULT NULL,
  `eyes_findings` int(11) DEFAULT NULL,
  `ent_findings` int(11) DEFAULT NULL,
  `chest_findings` int(11) DEFAULT NULL,
  `cvs_findings` int(11) DEFAULT NULL,
  `abdomen_findings` int(11) DEFAULT NULL,
  `cns_findings` int(11) DEFAULT NULL,
  `genitourinary_findings` int(11) DEFAULT NULL,
  `prophylaxis_given` varchar(50) DEFAULT NULL,
  `ctx_adherence` int(11) DEFAULT NULL,
  `ctx_dispensed` int(11) DEFAULT NULL,
  `dapsone_adherence` int(11) DEFAULT NULL,
  `dapsone_dispensed` int(11) DEFAULT NULL,
  `inh_dispensed` int(11) DEFAULT NULL,
  `arv_adherence` int(11) DEFAULT NULL,
  `poor_arv_adherence_reason` int(11) DEFAULT NULL,
  `poor_arv_adherence_reason_other` varchar(200) DEFAULT NULL,
  `pwp_disclosure` int(11) DEFAULT NULL,
  `pwp_partner_tested` int(11) DEFAULT NULL,
  `condom_provided` int(11) DEFAULT NULL,
  `substance_abuse_screening` int(11) DEFAULT NULL,
  `screened_for_sti` int(11) DEFAULT NULL,
  `cacx_screening` int(11) DEFAULT NULL,
  `sti_partner_notification` int(11) DEFAULT NULL,
  `at_risk_population` int(11) DEFAULT NULL,
  `system_review_finding` int(11) DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  `refill_date` date DEFAULT NULL,
  `next_appointment_reason` int(11) DEFAULT NULL,
  `stability` int(11) DEFAULT NULL,
  `differentiated_care` int(11) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  KEY `who_stage` (`who_stage`),
  KEY `pregnancy_status` (`pregnancy_status`),
  KEY `pregnancy_outcome` (`pregnancy_outcome`),
  KEY `family_planning_status` (`family_planning_status`),
  KEY `family_planning_method` (`family_planning_method`),
  KEY `tb_status` (`tb_status`),
  KEY `condom_provided` (`condom_provided`),
  KEY `ctx_dispensed` (`ctx_dispensed`),
  KEY `inh_dispensed` (`inh_dispensed`),
  KEY `at_risk_population` (`at_risk_population`),
  KEY `population_type` (`population_type`),
  KEY `key_population_type` (`key_population_type`),
  KEY `on_anti_tb_drugs` (`on_anti_tb_drugs`),
  KEY `on_ipt` (`on_ipt`),
  KEY `ever_on_ipt` (`ever_on_ipt`),
  KEY `differentiated_care` (`differentiated_care`),
  KEY `visit_date_2` (`visit_date`,`patient_id`),
  KEY `visit_date_3` (`visit_date`,`condom_provided`),
  KEY `visit_date_4` (`visit_date`,`family_planning_method`),
  CONSTRAINT `etl_patient_hiv_followup_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_patient_program`
--

DROP TABLE IF EXISTS `etl_patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_patient_program` (
  `uuid` char(38) NOT NULL DEFAULT '',
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `date_enrolled` date NOT NULL,
  `date_completed` date DEFAULT NULL,
  `outcome` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `date_enrolled` (`date_enrolled`),
  KEY `date_completed` (`date_completed`),
  KEY `patient_id` (`patient_id`),
  KEY `outcome` (`outcome`),
  CONSTRAINT `etl_patient_program_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_patient_program_discontinuation`
--

DROP TABLE IF EXISTS `etl_patient_program_discontinuation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_patient_program_discontinuation` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `program_uuid` char(38) DEFAULT NULL,
  `program_name` varchar(50) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `discontinuation_reason` int(11) DEFAULT NULL,
  `effective_discontinuation_date` date DEFAULT NULL,
  `trf_out_verified` int(11) DEFAULT NULL,
  `trf_out_verification_date` date DEFAULT NULL,
  `date_died` date DEFAULT NULL,
  `transfer_facility` varchar(100) DEFAULT NULL,
  `transfer_date` date DEFAULT NULL,
  `death_reason` int(11) DEFAULT NULL,
  `specific_death_cause` int(11) DEFAULT NULL,
  `natural_causes` varchar(200) DEFAULT NULL,
  `non_natural_cause` varchar(200) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `visit_date_2` (`visit_date`,`program_name`,`patient_id`),
  KEY `visit_date_3` (`visit_date`,`patient_id`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `discontinuation_reason` (`discontinuation_reason`),
  KEY `date_died` (`date_died`),
  KEY `transfer_date` (`transfer_date`),
  CONSTRAINT `etl_patient_program_discontinuation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_patient_triage`
--

DROP TABLE IF EXISTS `etl_patient_triage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_patient_triage` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_reason` varchar(255) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `systolic_pressure` double DEFAULT NULL,
  `diastolic_pressure` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `pulse_rate` double DEFAULT NULL,
  `respiratory_rate` double DEFAULT NULL,
  `oxygen_saturation` double DEFAULT NULL,
  `muac` double DEFAULT NULL,
  `nutritional_status` int(11) DEFAULT NULL,
  `last_menstrual_period` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_patient_triage_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_patients_booked_today`
--

DROP TABLE IF EXISTS `etl_patients_booked_today`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_patients_booked_today` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `last_visit_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `etl_patients_booked_today_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_peer_calendar`
--

DROP TABLE IF EXISTS `etl_peer_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_peer_calendar` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `hotspot_name` varchar(255) DEFAULT NULL,
  `typology` varchar(255) DEFAULT NULL,
  `other_hotspots` varchar(255) DEFAULT NULL,
  `weekly_sex_acts` int(10) DEFAULT NULL,
  `monthly_condoms_required` int(10) DEFAULT NULL,
  `weekly_anal_sex_acts` int(10) DEFAULT NULL,
  `monthly_lubes_required` int(10) DEFAULT NULL,
  `daily_injections` int(10) DEFAULT NULL,
  `monthly_syringes_required` int(10) DEFAULT NULL,
  `years_in_sexwork_drugs` int(10) DEFAULT NULL,
  `experienced_violence` varchar(10) DEFAULT NULL,
  `service_provided_within_last_month` varchar(255) DEFAULT NULL,
  `monthly_n_and_s_distributed` int(10) DEFAULT NULL,
  `monthly_male_condoms_distributed` int(10) DEFAULT NULL,
  `monthly_lubes_distributed` int(10) DEFAULT NULL,
  `monthly_female_condoms_distributed` int(10) DEFAULT NULL,
  `monthly_self_test_kits_distributed` int(10) DEFAULT NULL,
  `received_clinical_service` varchar(10) DEFAULT NULL,
  `violence_reported` varchar(10) DEFAULT NULL,
  `referred` varchar(10) DEFAULT NULL,
  `health_edu` varchar(10) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `client_id` (`client_id`,`visit_date`),
  CONSTRAINT `etl_peer_calendar_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_peer_tracking`
--

DROP TABLE IF EXISTS `etl_peer_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_peer_tracking` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `tracing_attempted` varchar(10) DEFAULT NULL,
  `tracing_not_attempted_reason` varchar(100) DEFAULT NULL,
  `attempt_number` varchar(11) DEFAULT NULL,
  `tracing_date` date DEFAULT NULL,
  `tracing_type` varchar(100) DEFAULT NULL,
  `tracing_outcome` varchar(100) DEFAULT NULL,
  `is_final_trace` varchar(10) DEFAULT NULL,
  `tracing_outcome_status` varchar(100) DEFAULT NULL,
  `voluntary_exit_comment` varchar(255) DEFAULT NULL,
  `status_in_program` varchar(100) DEFAULT NULL,
  `source_of_information` varchar(100) DEFAULT NULL,
  `other_informant` varchar(100) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `client_id` (`client_id`),
  KEY `status_in_program` (`status_in_program`),
  KEY `tracing_type` (`tracing_type`),
  CONSTRAINT `etl_peer_tracking_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_person_address`
--

DROP TABLE IF EXISTS `etl_person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_person_address` (
  `uuid` char(38) NOT NULL DEFAULT '',
  `patient_id` int(11) NOT NULL,
  `county` varchar(100) DEFAULT NULL,
  `sub_county` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `ward` varchar(100) DEFAULT NULL,
  `sub_location` varchar(100) DEFAULT NULL,
  `village` varchar(100) DEFAULT NULL,
  `postal_address` varchar(100) DEFAULT NULL,
  `land_mark` varchar(100) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `etl_person_address_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_pharmacy_extract`
--

DROP TABLE IF EXISTS `etl_pharmacy_extract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_pharmacy_extract` (
  `obs_group_id` int(11) NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `encounter_name` varchar(100) DEFAULT NULL,
  `drug` int(11) DEFAULT NULL,
  `is_arv` int(11) DEFAULT NULL,
  `is_ctx` int(11) DEFAULT NULL,
  `is_dapsone` int(11) DEFAULT NULL,
  `drug_name` varchar(255) DEFAULT NULL,
  `dose` int(11) DEFAULT NULL,
  `unit` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `duration_units` varchar(20) DEFAULT NULL,
  `duration_in_days` int(11) DEFAULT NULL,
  `prescription_provider` varchar(50) DEFAULT NULL,
  `dispensing_provider` varchar(50) DEFAULT NULL,
  `regimen` mediumtext,
  `adverse_effects` varchar(100) DEFAULT NULL,
  `date_of_refill` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `date_voided` date DEFAULT NULL,
  PRIMARY KEY (`obs_group_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `drug` (`drug`),
  KEY `is_arv` (`is_arv`),
  CONSTRAINT `etl_pharmacy_extract_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_pre_hiv_enrollment_art`
--

DROP TABLE IF EXISTS `etl_pre_hiv_enrollment_art`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_pre_hiv_enrollment_art` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  `PMTCT` int(11) DEFAULT NULL,
  `PMTCT_regimen` int(11) DEFAULT NULL,
  `PEP` int(11) DEFAULT NULL,
  `PEP_regimen` int(11) DEFAULT NULL,
  `PrEP` int(11) DEFAULT NULL,
  `PrEP_regimen` int(11) DEFAULT NULL,
  `HAART` int(11) DEFAULT NULL,
  `HAART_regimen` int(11) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  KEY `visit_date` (`visit_date`),
  KEY `patient_id` (`patient_id`),
  KEY `encounter_id` (`encounter_id`),
  KEY `obs_id` (`obs_id`),
  CONSTRAINT `etl_pre_hiv_enrollment_art_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_prep_behaviour_risk_assessment`
--

DROP TABLE IF EXISTS `etl_prep_behaviour_risk_assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_prep_behaviour_risk_assessment` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `sexual_partner_hiv_status` varchar(255) DEFAULT NULL,
  `sexual_partner_on_art` varchar(10) DEFAULT NULL,
  `risk` varchar(255) DEFAULT NULL,
  `high_risk_partner` varchar(10) DEFAULT NULL,
  `sex_with_multiple_partners` varchar(10) DEFAULT NULL,
  `ipv_gbv` varchar(10) DEFAULT NULL,
  `transactional_sex` varchar(10) DEFAULT NULL,
  `recent_sti_infected` varchar(10) DEFAULT NULL,
  `recurrent_pep_use` varchar(10) DEFAULT NULL,
  `recurrent_sex_under_influence` varchar(10) DEFAULT NULL,
  `inconsistent_no_condom_use` varchar(10) DEFAULT NULL,
  `sharing_drug_needles` varchar(255) DEFAULT NULL,
  `assessment_outcome` varchar(255) DEFAULT NULL,
  `risk_education_offered` varchar(10) DEFAULT NULL,
  `risk_reduction` varchar(10) DEFAULT NULL,
  `willing_to_take_prep` varchar(10) DEFAULT NULL,
  `reason_not_willing` varchar(255) DEFAULT NULL,
  `risk_edu_offered` varchar(10) DEFAULT NULL,
  `risk_education` varchar(255) DEFAULT NULL,
  `referral_for_prevention_services` varchar(255) DEFAULT NULL,
  `referral_facility` varchar(255) DEFAULT NULL,
  `time_partner_hiv_positive_known` varchar(255) DEFAULT NULL,
  `partner_enrolled_ccc` varchar(255) DEFAULT NULL,
  `partner_ccc_number` varchar(255) DEFAULT NULL,
  `partner_art_start_date` date DEFAULT NULL,
  `serodiscordant_confirmation_date` date DEFAULT NULL,
  `recent_unprotected_sex_with_positive_partner` varchar(10) DEFAULT NULL,
  `children_with_hiv_positive_partner` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_prep_behaviour_risk_assessment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_prep_discontinuation`
--

DROP TABLE IF EXISTS `etl_prep_discontinuation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_prep_discontinuation` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `discontinue_reason` varchar(255) DEFAULT NULL,
  `care_end_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `discontinue_reason` (`discontinue_reason`),
  KEY `care_end_date` (`care_end_date`),
  CONSTRAINT `etl_prep_discontinuation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_prep_enrolment`
--

DROP TABLE IF EXISTS `etl_prep_enrolment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_prep_enrolment` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `patient_type` varchar(255) DEFAULT NULL,
  `transfer_in_entry_point` varchar(255) DEFAULT NULL,
  `referred_from` varchar(255) DEFAULT NULL,
  `transit_from` varchar(255) DEFAULT NULL,
  `transfer_in_date` date DEFAULT NULL,
  `transfer_from` varchar(255) DEFAULT NULL,
  `initial_enrolment_date` date DEFAULT NULL,
  `date_started_prep_trf_facility` date DEFAULT NULL,
  `previously_on_prep` varchar(10) DEFAULT NULL,
  `regimen` varchar(255) DEFAULT NULL,
  `prep_last_date` date DEFAULT NULL,
  `in_school` varchar(10) DEFAULT NULL,
  `buddy_name` varchar(255) DEFAULT NULL,
  `buddy_alias` varchar(255) DEFAULT NULL,
  `buddy_relationship` varchar(255) DEFAULT NULL,
  `buddy_phone` varchar(255) DEFAULT NULL,
  `buddy_alt_phone` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_prep_enrolment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_prep_followup`
--

DROP TABLE IF EXISTS `etl_prep_followup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_prep_followup` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `sti_screened` varchar(10) DEFAULT NULL,
  `genital_ulcer_desease` varchar(255) DEFAULT NULL,
  `vaginal_discharge` varchar(255) DEFAULT NULL,
  `cervical_discharge` varchar(255) DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL,
  `urethral_discharge` varchar(255) DEFAULT NULL,
  `anal_discharge` varchar(255) DEFAULT NULL,
  `other_sti_symptoms` varchar(255) DEFAULT NULL,
  `sti_treated` varchar(10) DEFAULT NULL,
  `vmmc_screened` varchar(10) DEFAULT NULL,
  `vmmc_status` varchar(255) DEFAULT NULL,
  `vmmc_referred` varchar(255) DEFAULT NULL,
  `lmp` date DEFAULT NULL,
  `pregnant` varchar(10) DEFAULT NULL,
  `edd` date DEFAULT NULL,
  `planned_pregnancy` varchar(10) DEFAULT NULL,
  `wanted_pregnancy` varchar(10) DEFAULT NULL,
  `breastfeeding` varchar(10) DEFAULT NULL,
  `fp_status` varchar(255) DEFAULT NULL,
  `fp_method` varchar(255) DEFAULT NULL,
  `ended_pregnancy` varchar(255) DEFAULT NULL,
  `pregnancy_outcome` varchar(10) DEFAULT NULL,
  `outcome_date` date DEFAULT NULL,
  `defects` varchar(10) DEFAULT NULL,
  `has_chronic_illness` varchar(10) DEFAULT NULL,
  `chronic_illness` varchar(255) DEFAULT NULL,
  `chronic_illness_onset_date` date DEFAULT NULL,
  `chronic_illness_drug` varchar(255) DEFAULT NULL,
  `chronic_illness_dose` varchar(255) DEFAULT NULL,
  `chronic_illness_units` varchar(255) DEFAULT NULL,
  `chronic_illness_frequency` varchar(255) DEFAULT NULL,
  `chronic_illness_duration` varchar(255) DEFAULT NULL,
  `chronic_illness_duration_units` varchar(255) DEFAULT NULL,
  `adverse_reactions` varchar(255) DEFAULT NULL,
  `medicine_reactions` varchar(255) DEFAULT NULL,
  `reaction` varchar(255) DEFAULT NULL,
  `severity` varchar(255) DEFAULT NULL,
  `action_taken` varchar(255) DEFAULT NULL,
  `known_allergies` varchar(10) DEFAULT NULL,
  `allergen` varchar(255) DEFAULT NULL,
  `allergy_reaction` varchar(255) DEFAULT NULL,
  `allergy_severity` varchar(255) DEFAULT NULL,
  `allergy_date` date DEFAULT NULL,
  `hiv_signs` varchar(10) DEFAULT NULL,
  `adherence_counselled` varchar(10) DEFAULT NULL,
  `prep_contraindicatios` varchar(255) DEFAULT NULL,
  `treatment_plan` varchar(255) DEFAULT NULL,
  `condoms_issued` varchar(10) DEFAULT NULL,
  `number_of_condoms` varchar(10) DEFAULT NULL,
  `appointment_given` varchar(10) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `reason_no_appointment` varchar(255) DEFAULT NULL,
  `clinical_notes` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_prep_followup_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_prep_monthly_refill`
--

DROP TABLE IF EXISTS `etl_prep_monthly_refill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_prep_monthly_refill` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `risk_for_hiv_positive_partner` varchar(255) DEFAULT NULL,
  `client_assessment` varchar(255) DEFAULT NULL,
  `adherence_assessment` varchar(255) DEFAULT NULL,
  `poor_adherence_reasons` varchar(255) DEFAULT NULL,
  `other_poor_adherence_reasons` varchar(255) DEFAULT NULL,
  `adherence_counselling_done` varchar(10) DEFAULT NULL,
  `prep_status` varchar(255) DEFAULT NULL,
  `prescribed_prep_today` varchar(10) DEFAULT NULL,
  `prescribed_regimen` varchar(10) DEFAULT NULL,
  `prescribed_regimen_months` varchar(10) DEFAULT NULL,
  `prep_discontinue_reasons` varchar(255) DEFAULT NULL,
  `prep_discontinue_other_reasons` varchar(255) DEFAULT NULL,
  `appointment_given` varchar(10) DEFAULT NULL,
  `next_appointment` date DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_prep_monthly_refill_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_progress_note`
--

DROP TABLE IF EXISTS `etl_progress_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_progress_note` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `patient_id` (`patient_id`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  CONSTRAINT `etl_progress_note_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_script_status`
--

DROP TABLE IF EXISTS `etl_script_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_script_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `script_name` varchar(50) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `stop_time` datetime DEFAULT NULL,
  `error` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_sti_treatment`
--

DROP TABLE IF EXISTS `etl_sti_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_sti_treatment` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `encounter_provider` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `visit_reason` varchar(255) DEFAULT NULL,
  `syndrome` varchar(10) DEFAULT NULL,
  `other_syndrome` varchar(255) DEFAULT NULL,
  `drug_prescription` varchar(10) DEFAULT NULL,
  `other_drug_prescription` varchar(255) DEFAULT NULL,
  `genital_exam_done` varchar(10) DEFAULT NULL,
  `lab_referral` varchar(10) DEFAULT NULL,
  `lab_form_number` varchar(100) DEFAULT NULL,
  `referred_to_facility` varchar(10) DEFAULT NULL,
  `facility_name` varchar(255) DEFAULT NULL,
  `partner_referral_done` varchar(10) DEFAULT NULL,
  `given_lubes` varchar(10) DEFAULT NULL,
  `no_of_lubes` int(10) DEFAULT NULL,
  `given_condoms` varchar(10) DEFAULT NULL,
  `no_of_condoms` int(10) DEFAULT NULL,
  `provider_comments` varchar(255) DEFAULT NULL,
  `provider_name` varchar(255) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `client_id` (`client_id`),
  KEY `visit_reason` (`visit_reason`),
  KEY `given_lubes` (`given_lubes`),
  KEY `given_condoms` (`given_condoms`),
  CONSTRAINT `etl_sti_treatment_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_tb_enrollment`
--

DROP TABLE IF EXISTS `etl_tb_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_tb_enrollment` (
  `uuid` char(38) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `provider` int(11) DEFAULT NULL,
  `date_treatment_started` date DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `district_registration_number` varchar(20) DEFAULT NULL,
  `referred_by` int(11) DEFAULT NULL,
  `referral_date` date DEFAULT NULL,
  `date_transferred_in` date DEFAULT NULL,
  `facility_transferred_from` varchar(100) DEFAULT NULL,
  `district_transferred_from` varchar(100) DEFAULT NULL,
  `date_first_enrolled_in_tb_care` date DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `treatment_supporter` varchar(100) DEFAULT NULL,
  `relation_to_patient` int(11) DEFAULT NULL,
  `treatment_supporter_address` varchar(100) DEFAULT NULL,
  `treatment_supporter_phone_contact` varchar(100) DEFAULT NULL,
  `disease_classification` int(11) DEFAULT NULL,
  `patient_classification` int(11) DEFAULT NULL,
  `pulmonary_smear_result` int(11) DEFAULT NULL,
  `has_extra_pulmonary_pleurial_effusion` int(11) DEFAULT NULL,
  `has_extra_pulmonary_milliary` int(11) DEFAULT NULL,
  `has_extra_pulmonary_lymph_node` int(11) DEFAULT NULL,
  `has_extra_pulmonary_menengitis` int(11) DEFAULT NULL,
  `has_extra_pulmonary_skeleton` int(11) DEFAULT NULL,
  `has_extra_pulmonary_abdominal` int(11) DEFAULT NULL,
  `has_extra_pulmonary_other` varchar(100) DEFAULT NULL,
  `treatment_outcome` int(11) DEFAULT NULL,
  `treatment_outcome_date` date DEFAULT NULL,
  `date_of_discontinuation` datetime DEFAULT NULL,
  `discontinuation_reason` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `disease_classification` (`disease_classification`),
  KEY `patient_classification` (`patient_classification`),
  KEY `pulmonary_smear_result` (`pulmonary_smear_result`),
  KEY `date_first_enrolled_in_tb_care` (`date_first_enrolled_in_tb_care`),
  CONSTRAINT `etl_tb_enrollment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_tb_follow_up_visit`
--

DROP TABLE IF EXISTS `etl_tb_follow_up_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_tb_follow_up_visit` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `spatum_test` int(11) DEFAULT NULL,
  `spatum_result` int(11) DEFAULT NULL,
  `result_serial_number` varchar(20) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `date_test_done` date DEFAULT NULL,
  `bacterial_colonie_growth` int(11) DEFAULT NULL,
  `number_of_colonies` double DEFAULT NULL,
  `resistant_s` int(11) DEFAULT NULL,
  `resistant_r` int(11) DEFAULT NULL,
  `resistant_inh` int(11) DEFAULT NULL,
  `resistant_e` int(11) DEFAULT NULL,
  `sensitive_s` int(11) DEFAULT NULL,
  `sensitive_r` int(11) DEFAULT NULL,
  `sensitive_inh` int(11) DEFAULT NULL,
  `sensitive_e` int(11) DEFAULT NULL,
  `test_date` date DEFAULT NULL,
  `hiv_status` int(11) DEFAULT NULL,
  `next_appointment_date` date DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `hiv_status` (`hiv_status`),
  CONSTRAINT `etl_tb_follow_up_visit_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_tb_screening`
--

DROP TABLE IF EXISTS `etl_tb_screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_tb_screening` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `cough_for_2wks_or_more` int(11) DEFAULT NULL,
  `confirmed_tb_contact` int(11) DEFAULT NULL,
  `fever_for_2wks_or_more` int(11) DEFAULT NULL,
  `noticeable_weight_loss` int(11) DEFAULT NULL,
  `night_sweat_for_2wks_or_more` int(11) DEFAULT NULL,
  `lethargy` int(11) DEFAULT NULL,
  `spatum_smear_ordered` int(11) DEFAULT NULL,
  `chest_xray_ordered` int(11) DEFAULT NULL,
  `genexpert_ordered` int(11) DEFAULT NULL,
  `spatum_smear_result` int(11) DEFAULT NULL,
  `chest_xray_result` int(11) DEFAULT NULL,
  `genexpert_result` int(11) DEFAULT NULL,
  `referral` int(11) DEFAULT NULL,
  `clinical_tb_diagnosis` int(11) DEFAULT NULL,
  `resulting_tb_status` int(11) DEFAULT NULL,
  `contact_invitation` int(11) DEFAULT NULL,
  `evaluated_for_ipt` int(11) DEFAULT NULL,
  `started_anti_TB` int(11) DEFAULT NULL,
  `tb_treatment_start_date` date DEFAULT NULL,
  `tb_prophylaxis` varchar(50) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `person_present` int(11) DEFAULT '978',
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `cough_for_2wks_or_more` (`cough_for_2wks_or_more`),
  KEY `confirmed_tb_contact` (`confirmed_tb_contact`),
  KEY `noticeable_weight_loss` (`noticeable_weight_loss`),
  KEY `night_sweat_for_2wks_or_more` (`night_sweat_for_2wks_or_more`),
  KEY `resulting_tb_status` (`resulting_tb_status`),
  CONSTRAINT `etl_tb_screening_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_treatment_verification`
--

DROP TABLE IF EXISTS `etl_treatment_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_treatment_verification` (
  `uuid` char(38) DEFAULT NULL,
  `provider` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `date_diagnosed_with_hiv` date DEFAULT NULL,
  `art_health_facility` varchar(100) DEFAULT NULL,
  `ccc_number` varchar(100) DEFAULT NULL,
  `is_pepfar_site` varchar(11) DEFAULT NULL,
  `date_initiated_art` date DEFAULT NULL,
  `current_regimen` varchar(100) DEFAULT NULL,
  `information_source` varchar(100) DEFAULT NULL,
  `cd4_test_date` date DEFAULT NULL,
  `cd4` varchar(100) DEFAULT NULL,
  `vl_test_date` date DEFAULT NULL,
  `viral_load` varchar(100) DEFAULT NULL,
  `disclosed_status` varchar(11) DEFAULT NULL,
  `person_disclosed_to` varchar(100) DEFAULT NULL,
  `other_person_disclosed_to` varchar(100) DEFAULT NULL,
  `IPT_start_date` date DEFAULT NULL,
  `IPT_completion_date` date DEFAULT NULL,
  `on_diff_care` varchar(11) DEFAULT NULL,
  `in_support_group` varchar(11) DEFAULT NULL,
  `support_group_name` varchar(100) DEFAULT NULL,
  `opportunistic_infection` varchar(100) DEFAULT NULL,
  `oi_diagnosis_date` date DEFAULT NULL,
  `oi_treatment_start_date` date DEFAULT NULL,
  `oi_treatment_end_date` date DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `etl_treatment_verification_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_viral_load`
--

DROP TABLE IF EXISTS `etl_viral_load`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_viral_load` (
  `uuid` char(38) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `date_of_result` date DEFAULT NULL,
  `order_reason` varchar(255) DEFAULT NULL,
  `previous_vl_result` varchar(50) DEFAULT NULL,
  `current_vl_result` varchar(50) DEFAULT NULL,
  `previous_vl_date` date DEFAULT NULL,
  `previous_vl_reason` varchar(255) DEFAULT NULL,
  `vl_months_since_hiv_enrollment` int(11) DEFAULT NULL,
  `vl_months_since_otz_enrollment` int(11) DEFAULT NULL,
  `eligibility` varchar(50) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_last_modified` datetime DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `unique_uuid` (`uuid`),
  KEY `visit_date` (`visit_date`),
  KEY `encounter_id` (`encounter_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_id_2` (`patient_id`,`visit_date`),
  CONSTRAINT `etl_viral_load_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `etl_patient_demographics` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etl_viral_load_tracker`
--

DROP TABLE IF EXISTS `etl_viral_load_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_viral_load_tracker` (
  `patient_id` int(11) NOT NULL,
  `vl_date` date DEFAULT NULL,
  `vl_result` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `urgency` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `patient_id` (`patient_id`),
  KEY `vl_date` (`vl_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-26 11:47:12
