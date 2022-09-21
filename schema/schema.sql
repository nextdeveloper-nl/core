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
-- Table structure for table `account_affiliation_rule`
--

DROP TABLE IF EXISTS `account_affiliation_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_affiliation_rule` (
  `affiliation_rule_id` int NOT NULL,
  `account_id` bigint NOT NULL,
  `start_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`affiliation_rule_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_balance_logs`
--

DROP TABLE IF EXISTS `account_balance_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_balance_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `invoice_id` bigint unsigned DEFAULT NULL,
  `loggable_id` bigint DEFAULT NULL,
  `loggable_type` varchar(1000) DEFAULT NULL,
  `loggable_created_at` timestamp NULL DEFAULT NULL,
  `reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `amount` double NOT NULL,
  `balance_before` double NOT NULL,
  `balance_after` double NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `operation` enum('add','deduct') NOT NULL,
  `is_taken_from_balance` tinyint(1) NOT NULL DEFAULT '0',
  `is_canceled` tinyint(1) NOT NULL DEFAULT '0',
  `cancelation_reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_balance_log_id_ref_unique` (`id_ref`),
  UNIQUE KEY `account_balance_logs_loggable_unique` (`loggable_id`,`loggable_type`),
  KEY `account_balance_log_account_id_foreign` (`account_id`),
  CONSTRAINT `account_balance_log_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=621827 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `abl_generate_uuid` BEFORE INSERT ON `account_balance_logs` FOR EACH ROW BEGIN
    set new.id_ref = uuid();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `account_channels`
--

DROP TABLE IF EXISTS `account_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_channels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_invites`
--

DROP TABLE IF EXISTS `account_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_invites` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  `code` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expires_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_types`
--

DROP TABLE IF EXISTS `account_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_types_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `account_usage_report_view`
--

DROP TABLE IF EXISTS `account_usage_report_view`;
/*!50001 DROP VIEW IF EXISTS `account_usage_report_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `account_usage_report_view` AS SELECT 
 1 AS `account_id`,
 1 AS `account_name`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_name`,
 1 AS `used_cpu`,
 1 AS `actual_cpu`,
 1 AS `used_ram`,
 1 AS `actual_ram`,
 1 AS `used_disk`,
 1 AS `actutal_disk`,
 1 AS `cpu_hourly_price`,
 1 AS `ram_hourly_price`,
 1 AS `hdd_hourly_price`,
 1 AS `used_cpu_hourly_price`,
 1 AS `used_ram_hourly_price`,
 1 AS `used_hdd_hourly_price`,
 1 AS `used_cpu_monthly_price`,
 1 AS `used_ram_monthly_price`,
 1 AS `used_hdd_monthly_price`,
 1 AS `currency_code`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `account_user`
--

DROP TABLE IF EXISTS `account_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_user` (
  `user_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`account_id`),
  CONSTRAINT `account_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `currency_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT 'TRY',
  `credit` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `credit_currency_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TRY',
  `risk_level` tinyint unsigned NOT NULL DEFAULT '70',
  `is_team` tinyint unsigned NOT NULL DEFAULT '0',
  `is_customer` tinyint unsigned NOT NULL DEFAULT '1',
  `is_supplier` tinyint unsigned NOT NULL DEFAULT '0',
  `is_partner` tinyint unsigned NOT NULL DEFAULT '0',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `iam_dn` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_id` bigint unsigned DEFAULT NULL,
  `account_type_id` int unsigned NOT NULL DEFAULT '1',
  `account_channel_id` int unsigned NOT NULL DEFAULT '1',
  `representative_id` bigint unsigned DEFAULT NULL COMMENT 'Temsil eden kullanıcı (müşteri temsilcisi)',
  `iam_service_id` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `tax_office` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tax_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'this is tax number or id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_id_ref_unique` (`id_ref`),
  UNIQUE KEY `accounts_domain_unique` (`domain`),
  UNIQUE KEY `iam_dn` (`iam_dn`),
  KEY `accounts_representative_id_foreign` (`representative_id`),
  KEY `accounts_iam_service_id_foreign` (`iam_service_id`),
  FULLTEXT KEY `fulltext_index` (`name`,`description`,`domain`,`phone`,`tax_office`),
  CONSTRAINT `accounts_iam_service_id_foreign` FOREIGN KEY (`iam_service_id`) REFERENCES `iam_services` (`id`) ON DELETE SET NULL,
  CONSTRAINT `accounts_representative_id_foreign` FOREIGN KEY (`representative_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8251 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `crm_create_account_data` AFTER INSERT ON `accounts` FOR EACH ROW begin
    insert into crm_account_data (account_id) values (new.id);
    
    insert into crm_user_data (account_id, user_id, crm_created_at, crm_updated_at)
    select
        a.id as account_id,
        u.id as user_id,
        a.created_at as created_at,
        a.updated_at as updated_at
    from accounts as a
             inner join account_user au on a.id = au.account_id
             inner join users u on au.user_id = u.id
    where account_id = new.id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `active_customers`
--

DROP TABLE IF EXISTS `active_customers`;
/*!50001 DROP VIEW IF EXISTS `active_customers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `active_customers` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `balance`,
 1 AS `currency_code`,
 1 AS `credit`,
 1 AS `credit_currency_code`,
 1 AS `risk_level`,
 1 AS `is_team`,
 1 AS `owner_id`,
 1 AS `owner_id_ref`,
 1 AS `owner_name`,
 1 AS `representative_account_name`,
 1 AS `representative_account_id_ref`,
 1 AS `representative_account_id`,
 1 AS `representative_user`,
 1 AS `representative_user_id_ref`,
 1 AS `representative_user_id`,
 1 AS `account_type_id`,
 1 AS `last_invoice_date`,
 1 AS `last_invoice_amount`,
 1 AS `suspended_at`,
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `addressable_id` int unsigned NOT NULL,
  `addressable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Primary Address',
  `line1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `line2` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_invoice_address` tinyint(1) NOT NULL DEFAULT '1',
  `country_id` int unsigned DEFAULT NULL,
  `email_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `addresses_id_ref_unique` (`id_ref`),
  KEY `addresses_addressable_id_addressable_type_index` (`addressable_id`,`addressable_type`),
  KEY `addresses_country_id_foreign` (`country_id`),
  CONSTRAINT `addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3070 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `affiliation_logs`
--

DROP TABLE IF EXISTS `affiliation_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `affiliation_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `old_balance` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `new_balance` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `revenue` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `percentage` double NOT NULL DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `invoice_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `affiliation_rules`
--

DROP TABLE IF EXISTS `affiliation_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `affiliation_rules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `revenue_type` tinyint NOT NULL COMMENT '0 : Yüzde cinsinden, 1 : Ücret cinsinden',
  `percentage` smallint NOT NULL,
  `price` decimal(13,4) NOT NULL,
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_once` tinyint(1) NOT NULL DEFAULT '0',
  `ttl` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `affiliation_rules_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreement_negotiations`
--

DROP TABLE IF EXISTS `agreement_negotiations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agreement_negotiations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) DEFAULT NULL,
  `agreement_id` bigint unsigned NOT NULL COMMENT 'Hangi anlaşmadan türüyorsa onun ID sini tutar',
  `account_id` bigint unsigned NOT NULL COMMENT 'Hangi account ile anlaşmanın imzalandığını tutar',
  `customer_id` bigint unsigned NOT NULL COMMENT 'Anlaşmanın yapıldığı kullanıcı',
  `parent_id` bigint unsigned DEFAULT NULL,
  `data` text COMMENT 'Anlaşmanın imzalandığı veya imzalanacağı dataları tutar',
  `is_signed` tinyint(1) NOT NULL DEFAULT '0',
  `version` int unsigned NOT NULL DEFAULT '1',
  `is_latest` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agreement_negotiations_id_ref_unique` (`id_ref`),
  KEY `agreement_negotiations_agreement_id_foreign` (`agreement_id`),
  KEY `agreement_negotiations_account_id_foreign` (`account_id`),
  KEY `agreement_negotiations_signed_by_account_foreign` (`customer_id`),
  CONSTRAINT `agreement_negotiations_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `agreement_negotiations_agreement_id_foreign` FOREIGN KEY (`agreement_id`) REFERENCES `agreements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `agreement_negotiations_signed_by_account_foreign` FOREIGN KEY (`customer_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreements`
--

DROP TABLE IF EXISTS `agreements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agreements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL COMMENT 'bir önceki sözleşmenin hangisi olduğunu tutar',
  `is_stable` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Sözleşmenin nihai sözleşme olup olmadığı bilgisini tutar',
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `agreement` text NOT NULL,
  `variables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `version` int unsigned NOT NULL DEFAULT '1' COMMENT 'İlgili sözleşmenin kaçıncı versiyonu olduğunu tutar',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agreements_id_ref_unique` (`id_ref`),
  KEY `agreements_parent_id_foreign` (`parent_id`),
  CONSTRAINT `agreements_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `agreements` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ansible_playbook_ansible_role`
--

DROP TABLE IF EXISTS `ansible_playbook_ansible_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_playbook_ansible_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ansible_playbook_id` bigint unsigned NOT NULL,
  `ansible_role_id` bigint unsigned NOT NULL,
  `order` smallint unsigned NOT NULL DEFAULT '0',
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_playbook_ansible_role_id_ref_unique` (`id_ref`),
  KEY `ansible_playbook_ansible_role_ansible_playbook_id_foreign` (`ansible_playbook_id`),
  KEY `ansible_playbook_ansible_role_ansible_role_id_foreign` (`ansible_role_id`),
  CONSTRAINT `ansible_playbook_ansible_role_ansible_playbook_id_foreign` FOREIGN KEY (`ansible_playbook_id`) REFERENCES `ansible_playbooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ansible_playbook_ansible_role_ansible_role_id_foreign` FOREIGN KEY (`ansible_role_id`) REFERENCES `ansible_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4042 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ansible_playbook_executions`
--

DROP TABLE IF EXISTS `ansible_playbook_executions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_playbook_executions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Playbook owner account id. Global if NULL',
  `playbook_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `ip_v4` varchar(50) DEFAULT '',
  `ip_v6` varchar(39) DEFAULT NULL,
  `port` varchar(5) NOT NULL,
  `credentials` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_execution_time` datetime NOT NULL,
  `execution_total_time` bigint unsigned NOT NULL DEFAULT '0',
  `last_output` longtext,
  `result_ok` int unsigned DEFAULT '0',
  `result_changed` int unsigned DEFAULT '0',
  `result_unreachable` int unsigned DEFAULT '0',
  `result_failed` int unsigned DEFAULT '0',
  `result_skipped` int unsigned DEFAULT '0',
  `result_rescued` int unsigned DEFAULT '0',
  `result_ignored` int unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_playbook_executions_id_ref_unique` (`id_ref`),
  KEY `ansible_playbook_executions_account_id_foreign` (`account_id`),
  KEY `ansible_playbook_executions_playbook_id_foreign` (`playbook_id`),
  KEY `ansible_playbook_executions_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `ansible_playbook_executions_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `ansible_playbook_executions_playbook_id_foreign` FOREIGN KEY (`playbook_id`) REFERENCES `ansible_playbooks` (`id`),
  CONSTRAINT `ansible_playbook_executions_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ansible_playbooks`
--

DROP TABLE IF EXISTS `ansible_playbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_playbooks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Playbook owner account id. Global if NULL',
  `ansible_server_id` bigint unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `is_public` tinyint NOT NULL DEFAULT '0',
  `is_procedure` tinyint unsigned NOT NULL DEFAULT '0',
  `delete_after_run` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `become` tinyint DEFAULT '0' COMMENT 'True if we want to run this code as root',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_playbooks_id_ref_unique` (`id_ref`),
  KEY `ansible_playbooks_account_id_foreign` (`account_id`),
  KEY `ansible_playbooks_ansible_server_id_foreign` (`ansible_server_id`),
  CONSTRAINT `ansible_playbooks_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `ansible_playbooks_ansible_server_id_foreign` FOREIGN KEY (`ansible_server_id`) REFERENCES `ansible_servers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9679 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ansible_roles`
--

DROP TABLE IF EXISTS `ansible_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ansible_server_id` bigint unsigned NOT NULL,
  `service_name` varchar(100) DEFAULT NULL COMMENT 'Application or service name',
  `service_version` varchar(10) DEFAULT NULL COMMENT 'Application or service version',
  `release_number` int unsigned DEFAULT '1',
  `name` varchar(500) NOT NULL,
  `default_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `hash` varchar(40) NOT NULL,
  `min_ansible_version` varchar(10) NOT NULL,
  `prerequisites` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_procedure` tinyint(1) NOT NULL DEFAULT '0',
  `is_tested` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_roles_id_ref_unique` (`id_ref`),
  KEY `ansible_roles_ansible_server_id_foreign` (`ansible_server_id`),
  CONSTRAINT `ansible_roles_ansible_server_id_foreign` FOREIGN KEY (`ansible_server_id`) REFERENCES `ansible_servers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1076 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_ansible_roles` BEFORE INSERT ON `ansible_roles` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ansible_servers`
--

DROP TABLE IF EXISTS `ansible_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Ansible Server owner account id. Global if NULL',
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `credentials` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ssh_user` varchar(50) NOT NULL,
  `ssh_password` varchar(1024) NOT NULL,
  `ip_v4` varchar(15) NOT NULL,
  `ip_v6` varchar(39) DEFAULT NULL,
  `ansible_version` varchar(255) NOT NULL,
  `roles_path` varchar(500) NOT NULL,
  `system_playbooks_path` varchar(500) NOT NULL,
  `execution_path` varchar(500) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_servers_id_ref_unique` (`id_ref`),
  KEY `ansible_servers_account_id_foreign` (`account_id`),
  CONSTRAINT `ansible_servers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ansible_system_playbook_executions`
--

DROP TABLE IF EXISTS `ansible_system_playbook_executions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_system_playbook_executions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Account id of executed playbook.',
  `system_playbooks_id` bigint unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `package` varchar(200) NOT NULL,
  `config` text,
  `execution_total_time` int unsigned NOT NULL DEFAULT '0',
  `last_output` longtext,
  `result_ok` int unsigned NOT NULL DEFAULT '0',
  `result_changed` int unsigned NOT NULL DEFAULT '0',
  `result_unreachable` int unsigned NOT NULL DEFAULT '0',
  `result_failed` int unsigned NOT NULL DEFAULT '0',
  `result_skipped` int unsigned NOT NULL DEFAULT '0',
  `result_rescued` int unsigned NOT NULL DEFAULT '0',
  `result_ignored` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_system_playbook_executions_id_ref_unique` (`id_ref`),
  KEY `ansible_system_playbook_executions_account_id_foreign` (`account_id`),
  KEY `ansible_system_playbook_executions_system_playbooks_id_foreign` (`system_playbooks_id`),
  CONSTRAINT `ansible_system_playbook_executions_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `ansible_system_playbook_executions_system_playbooks_id_foreign` FOREIGN KEY (`system_playbooks_id`) REFERENCES `ansible_system_playbooks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=411 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ansible_system_playbooks`
--

DROP TABLE IF EXISTS `ansible_system_playbooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_system_playbooks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `package` varchar(200) NOT NULL,
  `path` varchar(500) NOT NULL,
  `filename` varchar(500) NOT NULL,
  `slug` varchar(500) NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `is_procedure` tinyint(1) NOT NULL DEFAULT '0',
  `delete_after_run` tinyint(1) NOT NULL DEFAULT '0',
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Playbook owner account id. Global if NULL',
  `ansible_server_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_system_playbooks_id_ref_unique` (`id_ref`),
  KEY `ansible_system_playbooks_account_id_foreign` (`account_id`),
  KEY `ansible_system_playbooks_ansible_server_id_foreign` (`ansible_server_id`),
  CONSTRAINT `ansible_system_playbooks_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `ansible_system_playbooks_ansible_server_id_foreign` FOREIGN KEY (`ansible_server_id`) REFERENCES `ansible_servers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1897 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ansible_system_plays`
--

DROP TABLE IF EXISTS `ansible_system_plays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ansible_system_plays` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `system_playbooks_id` bigint unsigned NOT NULL,
  `name` varchar(500) NOT NULL,
  `hosts` varchar(500) NOT NULL,
  `roles` json NOT NULL,
  `config` json NOT NULL,
  `become` tinyint(1) NOT NULL,
  `gather_facts` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ansible_system_plays_id_ref_unique` (`id_ref`),
  KEY `ansible_system_plays_system_playbooks_id_foreign` (`system_playbooks_id`),
  CONSTRAINT `ansible_system_plays_system_playbooks_id_foreign` FOREIGN KEY (`system_playbooks_id`) REFERENCES `ansible_system_playbooks` (`id`),
  CONSTRAINT `ansible_system_plays_chk_1` CHECK (json_valid(`roles`)),
  CONSTRAINT `ansible_system_plays_chk_2` CHECK (json_valid(`config`))
) ENGINE=InnoDB AUTO_INCREMENT=3600 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `discussion_id` bigint unsigned NOT NULL,
  `answer` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `is_answer` tinyint(1) NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `answers_id_ref_unique` (`id_ref`),
  KEY `answers_user_id_foreign` (`user_id`),
  KEY `answers_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `answers_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_options`
--

DROP TABLE IF EXISTS `api_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(500) NOT NULL,
  `method` varchar(255) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `controller_description` text,
  `action` varchar(255) NOT NULL,
  `action_description` text,
  `middleware` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `filters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `requests` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `returns` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3216 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_clients`
--

DROP TABLE IF EXISTS `backup_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `backup_server_compute_pool_id` int unsigned DEFAULT NULL,
  `ip_addr` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `status` enum('initializing','running','stopped','error') COLLATE utf8_bin NOT NULL DEFAULT 'stopped',
  `config` text COLLATE utf8_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `backup_clients_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_screenshots`
--

DROP TABLE IF EXISTS `backup_screenshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_screenshots` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `screenshot_dir` char(128) COLLATE utf8_bin NOT NULL,
  `screenshot_size` int unsigned NOT NULL,
  `backup_client_id` bigint unsigned DEFAULT NULL,
  `status` enum('initializing','processing','stopped','error','completed') COLLATE utf8_bin NOT NULL DEFAULT 'initializing',
  `config` text COLLATE utf8_bin,
  `storage_volume_id` int unsigned NOT NULL,
  `connection_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `most_recent_restoration_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `backup_screenshots_id_ref_unique` (`id_ref`),
  KEY `backup_screenshots_connection_id_foreign` (`connection_id`),
  KEY `backup_screenshots_storage_volume_id_foreign` (`storage_volume_id`),
  CONSTRAINT `backup_screenshots_connection_id_foreign` FOREIGN KEY (`connection_id`) REFERENCES `storage_member_connections` (`id`),
  CONSTRAINT `backup_screenshots_storage_volume_id_foreign` FOREIGN KEY (`storage_volume_id`) REFERENCES `storage_volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_servers`
--

DROP TABLE IF EXISTS `backup_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `compute_member_id` int unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `status` enum('initializing','running','stopped','error') COLLATE utf8_bin NOT NULL DEFAULT 'stopped',
  `config` text COLLATE utf8_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `backup_servers_id_ref_unique` (`id_ref`),
  KEY `backup_servers_compute_member_id_foreign` (`compute_member_id`),
  CONSTRAINT `backup_servers_compute_member_id_foreign` FOREIGN KEY (`compute_member_id`) REFERENCES `compute_members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `badgables`
--

DROP TABLE IF EXISTS `badgables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badgables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `badge_id` bigint unsigned NOT NULL,
  `badgable_id` bigint unsigned NOT NULL,
  `badgable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `badges` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `abstract` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_catalog_metric_summary`
--

DROP TABLE IF EXISTS `billing_account_catalog_metric_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_catalog_metric_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `item_count` smallint unsigned NOT NULL DEFAULT '0',
  `event_data` text,
  `price` double DEFAULT NULL,
  `currency_code` varchar(191) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `catalog_id` bigint unsigned DEFAULT NULL,
  `summary_type` enum('daily','weekly','monthly') NOT NULL,
  `report_of_day` smallint unsigned NOT NULL,
  `report_of_week` smallint unsigned NOT NULL,
  `report_of_month` smallint unsigned NOT NULL,
  `report_of_year` smallint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_account_catalog_metric_summary_id_ref_unique` (`id_ref`),
  KEY `bacms_account_id` (`account_id`),
  KEY `bacms_catalog_id` (`catalog_id`),
  CONSTRAINT `bacms_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bacms_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `product_catalogs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_catalog_metrics`
--

DROP TABLE IF EXISTS `billing_account_catalog_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_catalog_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `item_count` smallint unsigned NOT NULL DEFAULT '0',
  `event_name` varchar(255) NOT NULL,
  `price` double unsigned DEFAULT NULL,
  `currency_code` varchar(50) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `catalog_id` bigint unsigned DEFAULT NULL,
  `discount_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bacm_account_id` (`account_id`),
  KEY `bacm_catalog_id` (`catalog_id`),
  KEY `bacm_discount_id` (`discount_id`),
  CONSTRAINT `bacm_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bacm_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `product_catalogs` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bacm_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_compute_resource_metric_summary`
--

DROP TABLE IF EXISTS `billing_account_compute_resource_metric_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_compute_resource_metric_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `cpu_usage` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'kontrat sonrası cpu kullanımı',
  `ram_usage` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'Kontrat sonrası ram kullanımı',
  `actual_cpu_usage` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'Kontrat öncesi cpu kullanımı',
  `actual_ram_usage` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'Kontrat öncesi ram kullanımı',
  `price` double DEFAULT NULL,
  `currency_code` varchar(191) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `resource_time` bigint unsigned NOT NULL DEFAULT '0',
  `report_of_day` smallint unsigned NOT NULL,
  `report_of_week` smallint unsigned NOT NULL,
  `report_of_month` smallint unsigned NOT NULL,
  `report_of_year` smallint unsigned NOT NULL,
  `summary_type` enum('daily','weekly','monthly') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_account_compute_resource_metric_summary_id_ref_unique` (`id_ref`),
  KEY `bacrms_account_id` (`account_id`),
  KEY `bacrms_dcnode_id` (`datacenter_node_id`),
  CONSTRAINT `bacrms_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bacrms_dcnode_id` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_compute_resource_metrics`
--

DROP TABLE IF EXISTS `billing_account_compute_resource_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_compute_resource_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cpu_usage` int unsigned NOT NULL DEFAULT '0',
  `ram_usage` bigint unsigned NOT NULL DEFAULT '0',
  `event_data` text NOT NULL,
  `actual_cpu_usage` int unsigned NOT NULL DEFAULT '0',
  `actual_ram_usage` bigint unsigned NOT NULL DEFAULT '0',
  `price` double unsigned DEFAULT NULL,
  `currency_code` varchar(50) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `previous_bill_id` bigint DEFAULT NULL,
  `timediff` bigint unsigned DEFAULT NULL,
  `timediff_minutes` int unsigned DEFAULT NULL,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `discount_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bacrm_account_id` (`account_id`),
  KEY `bacrm_dcnode_id` (`datacenter_node_id`),
  KEY `bacrm_discount_id` (`discount_id`),
  CONSTRAINT `bacrm_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bacrm_dcnode_id` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bacrm_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=175510 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_informations`
--

DROP TABLE IF EXISTS `billing_account_informations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_informations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL,
  `is_active_customer` tinyint(1) NOT NULL DEFAULT '0',
  `currency_code` varchar(3) DEFAULT 'TRY',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  UNIQUE KEY `billing_account_informations_unique` (`account_id`),
  KEY `account_billing_information_account_id_foreign` (`account_id`),
  KEY `billing_account_informations_account_index` (`account_id`),
  CONSTRAINT `account_billing_information_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5826 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_network_resource_metric_summary`
--

DROP TABLE IF EXISTS `billing_account_network_resource_metric_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_network_resource_metric_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `network_usage` bigint unsigned NOT NULL DEFAULT '0',
  `price` double DEFAULT NULL,
  `currency_code` varchar(191) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `network_id` int unsigned DEFAULT NULL,
  `summary_type` enum('daily','weekly','monthly') NOT NULL,
  `report_of_day` smallint unsigned NOT NULL,
  `report_of_week` smallint unsigned NOT NULL,
  `report_of_month` smallint unsigned NOT NULL,
  `report_of_year` smallint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_account_network_resource_metric_summary_id_ref_unique` (`id_ref`),
  KEY `banrms_account_id` (`account_id`),
  KEY `banrms_sv_id` (`network_id`),
  KEY `banrms_dcnode_id` (`datacenter_node_id`),
  CONSTRAINT `banrms_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `banrms_dcnode_id` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `banrms_sv_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_network_resource_metrics`
--

DROP TABLE IF EXISTS `billing_account_network_resource_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_network_resource_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `network_usage` bigint unsigned NOT NULL DEFAULT '0',
  `actual_network_usage` bigint unsigned NOT NULL DEFAULT '0',
  `event_name` varchar(255) NOT NULL,
  `price` double unsigned DEFAULT NULL,
  `currency_code` varchar(50) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `previous_bill_id` bigint unsigned DEFAULT NULL,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `network_id` int unsigned DEFAULT NULL,
  `discount_id` int unsigned DEFAULT NULL,
  `timediff` int unsigned NOT NULL DEFAULT '0',
  `timediff_minutes` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `banrm_account_id` (`account_id`),
  KEY `banrm_sv_id` (`network_id`),
  KEY `banrm_dcnode_id` (`datacenter_node_id`),
  KEY `banrm_discount_id` (`discount_id`),
  CONSTRAINT `banrm_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `banrm_dcnode_id` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `banrm_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `banrm_sv_id` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_storage_resource_metric_summary`
--

DROP TABLE IF EXISTS `billing_account_storage_resource_metric_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_storage_resource_metric_summary` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `disk_usage` bigint unsigned NOT NULL DEFAULT '0',
  `actual_disk_usage` bigint unsigned DEFAULT '0',
  `event_data` text,
  `resource_time` bigint unsigned DEFAULT '0',
  `price` double DEFAULT NULL,
  `currency_code` varchar(191) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `storage_volume_id` int unsigned DEFAULT NULL,
  `summary_type` enum('daily','weekly','monthly') NOT NULL,
  `report_of_day` smallint unsigned NOT NULL,
  `report_of_week` smallint unsigned NOT NULL,
  `report_of_month` smallint unsigned NOT NULL,
  `report_of_year` smallint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_account_storage_resource_metric_summary_id_ref_unique` (`id_ref`),
  KEY `basrms_account_id` (`account_id`),
  KEY `basrms_sv_id` (`storage_volume_id`),
  KEY `basrms_dcnode_id` (`datacenter_node_id`),
  CONSTRAINT `basrms_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `basrms_dcnode_id` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `basrms_sv_id` FOREIGN KEY (`storage_volume_id`) REFERENCES `storage_volumes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=397 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_account_storage_resource_metrics`
--

DROP TABLE IF EXISTS `billing_account_storage_resource_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_account_storage_resource_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `disk_usage` bigint unsigned NOT NULL DEFAULT '0',
  `actual_disk_usage` bigint unsigned NOT NULL DEFAULT '0',
  `event_data` text NOT NULL,
  `price` double unsigned DEFAULT NULL,
  `currency_code` varchar(50) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `previous_bill_id` bigint unsigned DEFAULT NULL,
  `timediff` int unsigned DEFAULT NULL,
  `timediff_minutes` int unsigned DEFAULT NULL,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `storage_volume_id` int unsigned DEFAULT NULL,
  `discount_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basrm_account_id` (`account_id`),
  KEY `basrm_sv_id` (`storage_volume_id`),
  KEY `basrm_dcnode_id` (`datacenter_node_id`),
  KEY `basrm_discount_id` (`discount_id`),
  CONSTRAINT `basrm_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `basrm_dcnode_id` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `basrm_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `basrm_sv_id` FOREIGN KEY (`storage_volume_id`) REFERENCES `storage_volumes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=453900 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_contract_compute_resource`
--

DROP TABLE IF EXISTS `billing_contract_compute_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_contract_compute_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contract_id` bigint unsigned NOT NULL,
  `cpu_usage` int unsigned NOT NULL DEFAULT '0',
  `ram_usage` bigint unsigned NOT NULL DEFAULT '0',
  `event_data` text,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_contract_compute_resource_id_ref_unique` (`id_ref`),
  KEY `billing_contract_compute_resource_contract_id_foreign` (`contract_id`),
  CONSTRAINT `billing_contract_compute_resource_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `billing_contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_contract_network_resource`
--

DROP TABLE IF EXISTS `billing_contract_network_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_contract_network_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contract_id` bigint unsigned NOT NULL,
  `network_usage` bigint unsigned NOT NULL DEFAULT '0',
  `event_data` text,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `network_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_contract_network_resource_id_ref_unique` (`id_ref`),
  KEY `billing_contract_network_resource_contract_id_foreign` (`contract_id`),
  CONSTRAINT `billing_contract_network_resource_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `billing_contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_contract_product_catalog`
--

DROP TABLE IF EXISTS `billing_contract_product_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_contract_product_catalog` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contract_id` bigint unsigned NOT NULL,
  `product_catalog_id` bigint unsigned NOT NULL DEFAULT '0',
  `subscription_amount` int unsigned NOT NULL DEFAULT '1',
  `event_data` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_contract_product_catalog_id_ref_unique` (`id_ref`),
  KEY `billing_contract_product_catalog_contract_id_foreign` (`contract_id`),
  KEY `billing_contract_product_catalog_product_catalog_id_foreign` (`product_catalog_id`),
  CONSTRAINT `billing_contract_product_catalog_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `billing_contracts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `billing_contract_product_catalog_product_catalog_id_foreign` FOREIGN KEY (`product_catalog_id`) REFERENCES `product_catalogs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_contract_storage_resource`
--

DROP TABLE IF EXISTS `billing_contract_storage_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_contract_storage_resource` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contract_id` bigint unsigned NOT NULL,
  `disk_usage` int unsigned NOT NULL DEFAULT '0',
  `event_data` text,
  `datacenter_node_id` int unsigned DEFAULT NULL,
  `storage_volume_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_contract_storage_resource_id_ref_unique` (`id_ref`),
  KEY `billing_contract_storage_resource_contract_id_foreign` (`contract_id`),
  CONSTRAINT `billing_contract_storage_resource_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `billing_contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_contracts`
--

DROP TABLE IF EXISTS `billing_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_contracts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `name` varchar(200) NOT NULL COMMENT 'Kontratın adı',
  `starts_at` timestamp NOT NULL,
  `ends_at` timestamp NOT NULL,
  `price` double(8,2) NOT NULL DEFAULT '0.00' COMMENT 'hourly price of the contract',
  `price_hourly` double(8,2) NOT NULL DEFAULT '0.00',
  `currency_code` varchar(191) NOT NULL DEFAULT 'usd',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_contracts_id_ref_unique` (`id_ref`),
  KEY `billing_contracts_account_id_foreign` (`account_id`),
  CONSTRAINT `billing_contracts_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_daily_reports`
--

DROP TABLE IF EXISTS `billing_daily_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_daily_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `report_of_day` datetime NOT NULL,
  `report_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `billing_daily_reports_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blitz`
--

DROP TABLE IF EXISTS `blitz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blitz` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `name` varchar(50) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `service_type` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `service_url` varchar(500) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `password` varchar(1024) DEFAULT NULL,
  `host_price` double NOT NULL DEFAULT '0',
  `item_price` double NOT NULL DEFAULT '0',
  `retention_multiplier` double NOT NULL DEFAULT '0',
  `currency_code` char(3) NOT NULL DEFAULT 'USD',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blitz_uuid_unique` (`uuid`),
  UNIQUE KEY `blitz_id_ref_unique` (`id_ref`),
  KEY `blitz_account_id_foreign` (`account_id`),
  CONSTRAINT `blitz_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blitz_service`
--

DROP TABLE IF EXISTS `blitz_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blitz_service` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `uuid` varchar(36) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(1024) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `blitz_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blitz_service_uuid_unique` (`uuid`),
  UNIQUE KEY `blitz_service_id_ref_unique` (`id_ref`),
  KEY `blitz_service_account_id_foreign` (`account_id`),
  KEY `blitz_service_blitz_id_foreign` (`blitz_id`),
  CONSTRAINT `blitz_service_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `blitz_service_blitz_id_foreign` FOREIGN KEY (`blitz_id`) REFERENCES `blitz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blitz_service_usage_history`
--

DROP TABLE IF EXISTS `blitz_service_usage_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blitz_service_usage_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sensor_count` int NOT NULL DEFAULT '0',
  `retention` int NOT NULL DEFAULT '30',
  `blitz_id` bigint unsigned NOT NULL,
  `blitz_service_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blitz_service_usage_history_account_id_foreign` (`account_id`),
  KEY `blitz_service_usage_history_blitz_id_foreign` (`blitz_id`),
  KEY `blitz_service_usage_history_blitz_service_id_foreign` (`blitz_service_id`),
  CONSTRAINT `blitz_service_usage_history_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `blitz_service_usage_history_blitz_id_foreign` FOREIGN KEY (`blitz_id`) REFERENCES `blitz` (`id`),
  CONSTRAINT `blitz_service_usage_history_blitz_service_id_foreign` FOREIGN KEY (`blitz_service_id`) REFERENCES `blitz_service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL COMMENT 'Takvim girdisini yaratan accountun IDsi',
  `user_id` bigint unsigned NOT NULL COMMENT 'Takvim girdisini yaratan userın IDsi',
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `rsvp` enum('yes','maybe','no') NOT NULL COMMENT 'Takvimi yaratan kişi toplantıya katılmayabilir',
  `name` varchar(150) NOT NULL,
  `address` varchar(250) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `meeting_type` enum('office','skype','hangouts','other-telconf','other-videoconf') NOT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `priority` enum('low','medium','high') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendar_id_ref_unique` (`id_ref`),
  KEY `calendar_account_id_foreign` (`account_id`),
  KEY `calendar_user_id_foreign` (`user_id`),
  CONSTRAINT `calendar_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `calendar_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_attendees`
--

DROP TABLE IF EXISTS `calendar_attendees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_attendees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Toplantıdaki kişinin hesap',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'Toplantıdaki kişinin IDsi',
  `lead_id` bigint unsigned DEFAULT NULL COMMENT 'Takvim girdisini yaratan lead IDsi',
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `rsvp` enum('yes','maybe','no') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendar_attendees_id_ref_unique` (`id_ref`),
  KEY `calendar_attendees_account_id_foreign` (`account_id`),
  KEY `calendar_attendees_user_id_foreign` (`user_id`),
  KEY `calendar_attendees_lead_id_foreign` (`lead_id`),
  CONSTRAINT `calendar_attendees_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `calendar_attendees_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  CONSTRAINT `calendar_attendees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calls`
--

DROP TABLE IF EXISTS `calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calls` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `caller_account_id` bigint unsigned DEFAULT NULL,
  `caller_user_id` bigint unsigned DEFAULT NULL,
  `caller_lead_id` bigint unsigned DEFAULT NULL,
  `source_number` varchar(40) DEFAULT NULL,
  `destination_number` varchar(40) DEFAULT NULL,
  `did` varchar(40) DEFAULT NULL,
  `comment` text,
  `recording_url` varchar(500) DEFAULT NULL COMMENT 'görüşmenin adresi',
  `disposition` enum('answered','no-answer','busy') DEFAULT 'answered',
  `call_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calls_id_ref_unique` (`id_ref`),
  KEY `calls_account_id_foreign` (`account_id`),
  KEY `calls_user_id_foreign` (`user_id`),
  KEY `calls_caller_account_id_foreign` (`caller_account_id`),
  KEY `calls_caller_user_id_foreign` (`caller_user_id`),
  CONSTRAINT `calls_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `calls_caller_account_id_foreign` FOREIGN KEY (`caller_account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `calls_caller_user_id_foreign` FOREIGN KEY (`caller_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `calls_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `domain_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `_lft` int unsigned NOT NULL,
  `_rgt` int unsigned NOT NULL,
  `order` int unsigned DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_id_ref_unique` (`id_ref`),
  UNIQUE KEY `categories_slug_domain_id_unique` (`slug`,`domain_id`),
  KEY `categories_domain_id_foreign` (`domain_id`),
  KEY `categories__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`),
  CONSTRAINT `categories_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificate_client`
--

DROP TABLE IF EXISTS `certificate_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificate_client` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` char(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `public_key` text CHARACTER SET utf8 COLLATE utf8_bin,
  `private_key` text CHARACTER SET utf8 COLLATE utf8_bin,
  PRIMARY KEY (`id`),
  KEY `vpn_servers_user_id_foreign` (`user_id`),
  KEY `vpn_servers_account_id_foreign` (`account_id`),
  CONSTRAINT `vpn_servers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vpn_servers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`semihyonet`@`%`*/ /*!50003 TRIGGER `before_insert_vpn_servers` BEFORE INSERT ON `certificate_client` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` char(64) COLLATE utf8_bin DEFAULT NULL,
  `CSR` text COLLATE utf8_bin,
  `CA` text COLLATE utf8_bin,
  `private_key` text COLLATE utf8_bin,
  `object_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `object_id` int NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_user_id_foreign` (`user_id`),
  KEY `certificates_account_id_foreign` (`account_id`),
  CONSTRAINT `certificates_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `certificates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`semihyonet`@`%`*/ /*!50003 TRIGGER `before_insert_certificates` BEFORE INSERT ON `certificates` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `commentable_id` int unsigned NOT NULL,
  `commentable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `_lft` int unsigned NOT NULL,
  `_rgt` int unsigned NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comments_id_ref_unique` (`id_ref`),
  KEY `comments__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=484 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `communication_messages`
--

DROP TABLE IF EXISTS `communication_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communication_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `user_channel_id` bigint unsigned DEFAULT NULL,
  `communication_session_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `contact_id` bigint unsigned DEFAULT NULL,
  `message_id` bigint unsigned DEFAULT NULL,
  `3rd_party_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `imap_id` bigint unsigned DEFAULT NULL,
  `type` enum('cell_phone','email','discord','teams','slack','telegram','mattermost','webhook','imap') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'imap',
  `message_text` text,
  `is_from_plusclouds` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cm_session_id` (`communication_session_id`),
  KEY `communication_messages_message_id_foreign` (`message_id`),
  CONSTRAINT `cm_session_id` FOREIGN KEY (`communication_session_id`) REFERENCES `communication_sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `communication_messages_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `communication_notification_messages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2835 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_communication_messages` BEFORE INSERT ON `communication_messages` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `communication_notification_messages`
--

DROP TABLE IF EXISTS `communication_notification_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communication_notification_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `notification_id` bigint unsigned DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text NOT NULL,
  `allowed_channels` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `direction` enum('single','bidirection','omni-direction') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'single' COMMENT 'Direction of the communication where it can be from Leo to Person, both ways or multiple people at the same time',
  `locale` varchar(3) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `event_name` varchar(200) DEFAULT NULL,
  `email_template_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communication_notification_messages_notification_id_foreign` (`notification_id`),
  KEY `communication_notification_messages_email_templates_fk` (`email_template_id`),
  CONSTRAINT `communication_notification_messages_email_templates_fk` FOREIGN KEY (`email_template_id`) REFERENCES `email_templates` (`id`),
  CONSTRAINT `communication_notification_messages_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `communication_notification_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_communication_notification_messages` BEFORE INSERT ON `communication_notification_messages` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `communication_notification_types`
--

DROP TABLE IF EXISTS `communication_notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communication_notification_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `enabled_channels` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_communication_notification_types` BEFORE INSERT ON `communication_notification_types` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `communication_sessions`
--

DROP TABLE IF EXISTS `communication_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communication_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `contact_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `support_ticket_id` bigint unsigned DEFAULT NULL,
  `direction` enum('single','bidirection','omni-direction') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'single' COMMENT 'Direction of the communication where it can be from Leo to Person, both ways or multiple people at the same time',
  `state` enum('expecting-reply','executing-job','closed') DEFAULT NULL,
  `job_count` mediumint unsigned NOT NULL,
  `message_count` mediumint unsigned NOT NULL,
  `notification_channel` enum('cell_phone','email','discord','teams','slack','telegram','mattermost','webhook') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cs_account_id` (`account_id`),
  KEY `cs_user_id` (`user_id`),
  CONSTRAINT `cs_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cs_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2622 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_communication_sessions` BEFORE INSERT ON `communication_sessions` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `communication_user_channels`
--

DROP TABLE IF EXISTS `communication_user_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communication_user_channels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `contact_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `type` enum('cell_phone','email','discord','teams','slack','telegram','mattermost','webhook','imap') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `channel_configuration` text NOT NULL,
  `last_connected_at` timestamp NULL DEFAULT NULL,
  `connection_error_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6593 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_communication_user_channels` BEFORE INSERT ON `communication_user_channels` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `communication_user_preferences`
--

DROP TABLE IF EXISTS `communication_user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communication_user_preferences` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `contact_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `notification_id` bigint unsigned NOT NULL,
  `is_sms_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_email_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_telegram_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_teams_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_discord_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_slack_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `communication_user_preferences_notification_id_foreign` (`notification_id`),
  CONSTRAINT `communication_user_preferences_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `communication_notification_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_communication_user_preferences` BEFORE INSERT ON `communication_user_preferences` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `compute_member_histories`
--

DROP TABLE IF EXISTS `compute_member_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compute_member_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compute_member_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2454 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compute_member_physical_interface_histories`
--

DROP TABLE IF EXISTS `compute_member_physical_interface_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compute_member_physical_interface_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compute_member_pi_histories_hid_htype_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compute_member_physical_interfaces`
--

DROP TABLE IF EXISTS `compute_member_physical_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compute_member_physical_interfaces` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `device` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mac_addr` char(17) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_physical` tinyint(1) NOT NULL DEFAULT '0',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `hypervisor_session_id` varchar(255) DEFAULT NULL,
  `hypervisor_data` text,
  `type` enum('network') NOT NULL,
  `compute_member_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compute_member_physical_interfaces_id_ref_unique` (`id_ref`),
  KEY `compute_member_physical_interfaces_compute_member_id_foreign` (`compute_member_id`),
  CONSTRAINT `compute_member_physical_interfaces_compute_member_id_foreign` FOREIGN KEY (`compute_member_id`) REFERENCES `compute_members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compute_member_repositories`
--

DROP TABLE IF EXISTS `compute_member_repositories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compute_member_repositories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `compute_member_id` int unsigned DEFAULT NULL,
  `repo_server_id` bigint unsigned DEFAULT NULL,
  `is_mounted` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compute_member_repositories_pk` (`compute_member_id`,`repo_server_id`),
  KEY `compute_member_repository_repo_server_id_foreign` (`repo_server_id`),
  CONSTRAINT `compute_member_repository_compute_member_id_foreign` FOREIGN KEY (`compute_member_id`) REFERENCES `compute_members` (`id`),
  CONSTRAINT `compute_member_repository_repo_server_id_foreign` FOREIGN KEY (`repo_server_id`) REFERENCES `repo_servers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compute_members`
--

DROP TABLE IF EXISTS `compute_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compute_members` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hostname` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ip_addr` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `management_url` varchar(2083) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `port` smallint unsigned DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `features` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `hypervisor_uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `hypervisor_session_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `hypervisor_data` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `total_cpu` int unsigned NOT NULL DEFAULT '0',
  `total_ram` int unsigned NOT NULL DEFAULT '0',
  `total_vm` int unsigned NOT NULL DEFAULT '0',
  `used_cpu` int unsigned NOT NULL DEFAULT '0',
  `used_ram` int unsigned NOT NULL DEFAULT '0',
  `overbooking_ratio` int unsigned DEFAULT '0',
  `cpu_flags` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `cpu_model` int unsigned DEFAULT '0',
  `cpu_model_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `cpu_mhz` int unsigned DEFAULT '0',
  `cpu_bugs` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `uptime` bigint unsigned NOT NULL DEFAULT '0',
  `idle_time` bigint unsigned NOT NULL DEFAULT '0',
  `benchmark_score` int unsigned NOT NULL DEFAULT '0',
  `has_maintenance` tinyint DEFAULT '0',
  `is_alive` tinyint(1) NOT NULL DEFAULT '0',
  `compute_pool_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compute_members_id_ref_unique` (`id_ref`),
  KEY `compute_members_compute_pool_id_foreign` (`compute_pool_id`),
  CONSTRAINT `compute_members_compute_pool_id_foreign` FOREIGN KEY (`compute_pool_id`) REFERENCES `compute_pools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `compute_members_overview`
--

DROP TABLE IF EXISTS `compute_members_overview`;
/*!50001 DROP VIEW IF EXISTS `compute_members_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `compute_members_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `hostname`,
 1 AS `ip_addr`,
 1 AS `management_url`,
 1 AS `port`,
 1 AS `hypervisor_uuid`,
 1 AS `total_cpu`,
 1 AS `total_ram`,
 1 AS `total_vm`,
 1 AS `used_cpu`,
 1 AS `used_ram`,
 1 AS `is_alive`,
 1 AS `compute_pool_id`,
 1 AS `compute_pool_id_ref`,
 1 AS `compute_pool_name`,
 1 AS `compute_pool_management_type`,
 1 AS `compute_pool_is_public`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_id_ref`,
 1 AS `datacenter_node_name`,
 1 AS `vendor_id`,
 1 AS `vendor_id_ref`,
 1 AS `vendor_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `compute_pool_histories`
--

DROP TABLE IF EXISTS `compute_pool_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compute_pool_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `compute_pool_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compute_pools`
--

DROP TABLE IF EXISTS `compute_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compute_pools` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cpu_hourly_price` decimal(13,8) NOT NULL,
  `ram_hourly_price` decimal(13,8) NOT NULL,
  `hdd_hourly_price` decimal(13,8) NOT NULL,
  `vm_cpu_step` int DEFAULT '1',
  `vm_ram_step` int DEFAULT '1',
  `vm_disk_step` int DEFAULT '10240',
  `cpu_ram_ratio` enum('variable','constant') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'constant' COMMENT 'Eğer CPU RAM Ratio''su variable ise bu demektir ki kişi istediği kadar ram''i istediği kadar cpu ile beraber alabilir. Ama eğer değilse o zaman CPU RAM ikilisi step''lerdeki gibi olabilir veya CPU step''den küçük olabilir.',
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `resource_validator` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Sunucuda kurulmak istenen CPU, RAM ve Harddisk değerlerinin doğruluğunu kontrol eden class.',
  `pool_type` enum('clustered','farm') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `master_ip_addr` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Pool master ip',
  `management_url` varchar(2083) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '',
  `port` smallint unsigned DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `management_type` enum('ssh','api') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ssh',
  `virtualization` enum('XenServer','KVM','VmWare','HyperV','DockerSwarm','UrBackup') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'XenServer',
  `virtualization_version` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `provisioning_alg` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `management_package_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The Ansible System Playbook Package that will be used to manage virtual machines',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_alive` tinyint(1) NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `datacenter_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `vendor_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compute_pools_id_ref_unique` (`id_ref`),
  KEY `compute_pools_vendor_id_foreign` (`vendor_id`),
  KEY `compute_pools_datacenter_id_foreign` (`datacenter_id`),
  KEY `compute_pools_product_id_foreign` (`product_id`),
  CONSTRAINT `compute_pools_datacenter_id_foreign` FOREIGN KEY (`datacenter_id`) REFERENCES `datacenters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compute_pools_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `compute_pools_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `accounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `compute_pools_overview`
--

DROP TABLE IF EXISTS `compute_pools_overview`;
/*!50001 DROP VIEW IF EXISTS `compute_pools_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `compute_pools_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `resource_validator`,
 1 AS `pool_type`,
 1 AS `master_ip_addr`,
 1 AS `management_url`,
 1 AS `port`,
 1 AS `management_type`,
 1 AS `virtualization`,
 1 AS `virtualization_version`,
 1 AS `provisioning_alg`,
 1 AS `management_package_name`,
 1 AS `is_active`,
 1 AS `is_alive`,
 1 AS `is_public`,
 1 AS `datacenter_id`,
 1 AS `datacenter_id_ref`,
 1 AS `datacenter_name`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_id_ref`,
 1 AS `datacenter_node_name`,
 1 AS `product_id`,
 1 AS `product_id_ref`,
 1 AS `product_name`,
 1 AS `vendor_id`,
 1 AS `vendor_id_ref`,
 1 AS `vendor_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `console_ports`
--

DROP TABLE IF EXISTS `console_ports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `console_ports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `source_port` smallint unsigned DEFAULT NULL COMMENT 'virtualization port',
  `destination_port` smallint unsigned NOT NULL COMMENT 'tunnel port',
  `socket_port` smallint unsigned NOT NULL COMMENT 'socket port',
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `console_ports_id_ref_unique` (`id_ref`),
  KEY `console_ports_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `console_ports_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_sent_notifications`
--

DROP TABLE IF EXISTS `contact_sent_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_sent_notifications` (
  `contact_id` bigint unsigned NOT NULL,
  `message_id` bigint unsigned NOT NULL,
  KEY `csn_c_id` (`contact_id`),
  KEY `csn_m_id` (`message_id`),
  CONSTRAINT `csn_c_id` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`),
  CONSTRAINT `csn_m_id` FOREIGN KEY (`message_id`) REFERENCES `communication_messages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL COMMENT 'Kontağın yaratan account',
  `user_id` bigint unsigned NOT NULL COMMENT 'Kontağı yaratan user',
  `lead_id` bigint unsigned DEFAULT NULL COMMENT 'Kontağın varsa lead_id si ',
  `customer_id` bigint unsigned DEFAULT NULL COMMENT 'Kontağın varsa customer_id si ',
  `customer_user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `surname` varchar(150) DEFAULT NULL,
  `full_name` varchar(300) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `position` varchar(150) DEFAULT NULL,
  `job` enum('manager','developer','designer','art_director','gamer','devops','network_engineer','other') DEFAULT NULL,
  `job_description` varchar(1000) DEFAULT NULL,
  `hobbies` varchar(500) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `biography` text,
  `email_risk` enum('low','medium','high') DEFAULT NULL,
  `has_teknosacell_subscription` tinyint DEFAULT '0',
  `is_disposable_email` tinyint DEFAULT '0',
  `last_mailgun_validator_check` timestamp NULL DEFAULT NULL,
  `is_email_opt_out` tinyint DEFAULT '0',
  `is_phone_opt_out` tinyint DEFAULT '0',
  `linkedin` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `github` varchar(100) DEFAULT NULL,
  `gitlab` varchar(100) DEFAULT NULL,
  `relationship_status` enum('aware_of_us','acquired','converted','retention','brand_advocator') DEFAULT NULL,
  `cellphone` varchar(20) DEFAULT NULL,
  `workphone` varchar(20) DEFAULT NULL,
  `workphone_extension` varchar(20) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `country_id` int unsigned DEFAULT NULL,
  `company` varchar(200) DEFAULT NULL,
  `is_evangelist` tinyint DEFAULT '0',
  `martial_status` enum('married','single') DEFAULT NULL,
  `education` enum('high_school','college','university','masters','doctorate','professor') DEFAULT NULL,
  `child_count` smallint DEFAULT NULL,
  `locale` varchar(2) DEFAULT NULL,
  `representative_user_id` bigint unsigned DEFAULT NULL COMMENT 'The representative of this contact',
  `representative_account_id` bigint unsigned DEFAULT NULL COMMENT 'Representative account of this contact',
  `organization_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contacts_id_ref_unique` (`id_ref`),
  UNIQUE KEY `contacts_email_uindex` (`email`),
  KEY `contacts_account_id_foreign` (`account_id`),
  KEY `contacts_customer_id_foreign` (`customer_id`),
  KEY `contacts_user_id_foreign` (`user_id`),
  KEY `contacts_lead_id_foreign` (`lead_id`),
  KEY `contacts_country_id_foreign` (`country_id`),
  KEY `contacts_customer_user_fk` (`customer_user_id`),
  CONSTRAINT `contacts_account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contacts_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `contacts_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `contacts_customer_user_fk` FOREIGN KEY (`customer_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `contacts_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  CONSTRAINT `contacts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26924 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_contacts` BEFORE INSERT ON `contacts` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` char(5) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT 'K.D.V.oranı',
  `percentage` double NOT NULL DEFAULT '0' COMMENT 'rate * 100',
  `continent_name` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `continent_code` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `geo_name_id` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country_products`
--

DROP TABLE IF EXISTS `country_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_products` (
  `product_id` int unsigned NOT NULL,
  `country_id` int unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`country_id`),
  KEY `country_products_country_id_foreign` (`country_id`),
  CONSTRAINT `country_products_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `country_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credit_cards`
--

DROP TABLE IF EXISTS `credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_cards` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cc_holder_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cc_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cc_month` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cc_year` char(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cc_cvv` char(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_valid` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `score` tinyint NOT NULL DEFAULT '0',
  `is_3d_secure_enabled` tinyint DEFAULT '0',
  `retry_count` tinyint unsigned NOT NULL DEFAULT '0',
  `owner_id` bigint unsigned DEFAULT NULL,
  `last_retry_date` timestamp NULL DEFAULT NULL,
  `verification_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credit_cards_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crm_account_data`
--

DROP TABLE IF EXISTS `crm_account_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crm_account_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL,
  `customer_of_account` bigint unsigned DEFAULT NULL,
  `customer_of_user` bigint unsigned DEFAULT NULL,
  `partnership_level` enum('not-partner','affiliate','bronze','silver','gold','distributor','hq') DEFAULT 'not-partner' COMMENT 'Partnerlik seviyesi',
  `revenue_percent` tinyint unsigned DEFAULT '5',
  `recurring_revenue_percent` tinyint unsigned DEFAULT '5',
  `segment_id` bigint unsigned DEFAULT NULL COMMENT 'Müşterinin hangi segmentte olduğu bilgisi',
  `is_bounty` tinyint(1) DEFAULT '0',
  `risk_level` tinyint unsigned DEFAULT '100',
  `credit_score` mediumint unsigned DEFAULT '0',
  `credit` mediumint unsigned DEFAULT '0',
  `credit_currency_code` varchar(3) DEFAULT '0',
  `credit_override` enum('Y','N') DEFAULT 'N',
  `last_invoice_amount` decimal(13,4) DEFAULT '0.0000',
  `last_invoice_date` timestamp NULL DEFAULT NULL,
  `mautic_id` bigint unsigned DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `last_risk_calculation` timestamp NULL DEFAULT NULL,
  `relationship_status` enum('aware-of-us','acquired','converted','retention','brand-advocator') DEFAULT NULL,
  `accounting_id` varchar(50) DEFAULT NULL,
  `gitlab_url` varchar(500) DEFAULT NULL,
  `gitlab_maintainer_token` varchar(100) DEFAULT NULL,
  `crm_created_at` timestamp NULL DEFAULT NULL,
  `crm_updated_at` timestamp NULL DEFAULT NULL,
  `crm_deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_account_data_account_id_uindex` (`account_id`),
  KEY `crm_account_data_account_id_foreign` (`account_id`),
  KEY `crm_account_data_account_id_foreign_2` (`customer_of_account`),
  KEY `crm_account_data_account_id_foreign_3` (`customer_of_user`),
  CONSTRAINT `crm_account_data_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `crm_account_data_account_id_foreign_2` FOREIGN KEY (`customer_of_account`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `crm_account_data_account_id_foreign_3` FOREIGN KEY (`customer_of_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8754 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crm_account_statistics`
--

DROP TABLE IF EXISTS `crm_account_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crm_account_statistics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL,
  `average_sales_amount` double DEFAULT '0' COMMENT 'Aylık ortalama kendi para birimi üzerinden ödeme hacmi',
  `latest_sales_amount` double DEFAULT '0' COMMENT 'Kendi para birimi üzerinden son ay yaptığı ödeme hacim',
  `last_years_sales_amount` double DEFAULT '0',
  `this_years_sales_amount` double DEFAULT '0',
  `total_sales_amount` double DEFAULT '0' COMMENT 'Kendi para birimi üzerinden toplam yaptığı harcama (kdv hariç)',
  `total_sales_count` int DEFAULT '0',
  `total_refund_amount` double DEFAULT '0',
  `total_refund_count` int DEFAULT '0',
  `sales_currency` varchar(3) DEFAULT 'USD',
  `payment_cycle` int DEFAULT '0' COMMENT 'Kaç günde bir ödeme yaptığı bilgisi',
  `average_ticket_count` double(8,2) unsigned DEFAULT '0.00' COMMENT 'Aylık toplam açtığı ticket sayısı',
  `average_ticket_time` double(8,2) unsigned DEFAULT '0.00' COMMENT 'Aylık toplam verilen destek süresi',
  `ticket_success_rate` double(8,2) unsigned DEFAULT '0.00' COMMENT 'Desteklerin puanlandırılma oranı',
  `user_count` double(8,2) unsigned DEFAULT '1.00' COMMENT 'Hesaba bağlı kullanıcı sayısı',
  `total_recommendation_sent` int unsigned DEFAULT '0' COMMENT 'Ayda kaç arkadaşına tavsiyede bulunduğu',
  `representative_success_rate` double(8,2) unsigned DEFAULT '0.00' COMMENT 'Müşteri temsilcisinin satış başarısı oranı, bu oran yaratılan opportunity''nin satışa dönme oranı aslında',
  `days_since_last_call` int unsigned DEFAULT '0' COMMENT 'Müşteri en son aranmasından itibaren kaç gün geçmiş.',
  `crm_created_at` timestamp NULL DEFAULT NULL,
  `crm_updated_at` timestamp NULL DEFAULT NULL,
  `crm_deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `crm_statistics_account_id_foreign` (`account_id`),
  CONSTRAINT `crm_statistics_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6735 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `crm_contact_overview`
--

DROP TABLE IF EXISTS `crm_contact_overview`;
/*!50001 DROP VIEW IF EXISTS `crm_contact_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crm_contact_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `account_id`,
 1 AS `user_id`,
 1 AS `customer_id`,
 1 AS `name`,
 1 AS `surname`,
 1 AS `full_name`,
 1 AS `position`,
 1 AS `email`,
 1 AS `cellphone`,
 1 AS `workphone`,
 1 AS `workphone_extension`,
 1 AS `address`,
 1 AS `gender`,
 1 AS `birthday`,
 1 AS `source`,
 1 AS `lead_source`,
 1 AS `lead_list_id`,
 1 AS `lead_list_name`,
 1 AS `state`,
 1 AS `is_marketing_qualified`,
 1 AS `is_sales_qualified`,
 1 AS `organization_name`,
 1 AS `organization_id`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `crm_created_customers_overview`
--

DROP TABLE IF EXISTS `crm_created_customers_overview`;
/*!50001 DROP VIEW IF EXISTS `crm_created_customers_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crm_created_customers_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `domain`,
 1 AS `phone_number`,
 1 AS `balance`,
 1 AS `currency_code`,
 1 AS `account_type`,
 1 AS `risk_level`,
 1 AS `credit_score`,
 1 AS `credit`,
 1 AS `credit_override`,
 1 AS `approved_at`,
 1 AS `suspended_at`,
 1 AS `created_at`,
 1 AS `deleted_at`,
 1 AS `user_email`,
 1 AS `user_username`,
 1 AS `user_gender`,
 1 AS `representative_user_name`,
 1 AS `representative_user_id`,
 1 AS `representative_account_name`,
 1 AS `representative_account_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `crm_customer_iaas_usage_report`
--

DROP TABLE IF EXISTS `crm_customer_iaas_usage_report`;
/*!50001 DROP VIEW IF EXISTS `crm_customer_iaas_usage_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crm_customer_iaas_usage_report` AS SELECT 
 1 AS `organization_id`,
 1 AS `organization_name`,
 1 AS `representative_account_id`,
 1 AS `account_id`,
 1 AS `account_balance`,
 1 AS `account_currency_code`,
 1 AS `account_credit`,
 1 AS `responsible_user_id`,
 1 AS `responsible_user`,
 1 AS `datacenter_node_name`,
 1 AS `vm_name`,
 1 AS `vm_cpu`,
 1 AS `vm_ram`,
 1 AS `vm_disk`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `crm_customer_overview`
--

DROP TABLE IF EXISTS `crm_customer_overview`;
/*!50001 DROP VIEW IF EXISTS `crm_customer_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crm_customer_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `domain`,
 1 AS `phone_number`,
 1 AS `balance`,
 1 AS `currency_code`,
 1 AS `account_type`,
 1 AS `risk_level`,
 1 AS `credit_score`,
 1 AS `credit`,
 1 AS `credit_override`,
 1 AS `approved_at`,
 1 AS `suspended_at`,
 1 AS `created_at`,
 1 AS `deleted_at`,
 1 AS `user_email`,
 1 AS `user_username`,
 1 AS `user_gender`,
 1 AS `representative_user_name`,
 1 AS `representative_user_id`,
 1 AS `representative_account_name`,
 1 AS `representative_account_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `crm_domain_details`
--

DROP TABLE IF EXISTS `crm_domain_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crm_domain_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) DEFAULT NULL,
  `domain_id` bigint unsigned NOT NULL,
  `is_registered` tinyint(1) DEFAULT NULL,
  `registration_data` text,
  `whois_data` text,
  `is_whois_checked` enum('Y','N') DEFAULT 'N',
  `dns_data` text,
  `is_dns_checked` enum('Y','N') DEFAULT 'N',
  `dns_error` text,
  `dns_blocks_error` text COMMENT 'ip kayıtlarına bakılırken çıkan hataları kayıt eder',
  `is_dns_blocks_checked` enum('Y','N') DEFAULT 'N',
  `dns_a_records` text,
  `dns_a_ip_block` varchar(50) DEFAULT NULL,
  `dns_a_ip_block_asn` varchar(50) DEFAULT NULL,
  `dns_a_ip_block_owner` varchar(200) DEFAULT NULL,
  `dns_a_ip_block_owner_website` varchar(200) DEFAULT NULL,
  `dns_mx_records` text,
  `dns_mx_ip_block` varchar(50) DEFAULT NULL,
  `dns_mx_ip_block_asn` varchar(50) DEFAULT NULL,
  `dns_mx_ip_block_owner` varchar(200) DEFAULT NULL,
  `dns_mx_ip_block_owner_website` varchar(200) DEFAULT NULL,
  `dns_ns_records` text,
  `dns_ns_ip_block` varchar(50) DEFAULT NULL,
  `dns_ns_ip_block_asn` varchar(50) DEFAULT NULL,
  `dns_ns_ip_block_owner` varchar(200) DEFAULT NULL,
  `dns_ns_ip_block_owner_website` varchar(200) DEFAULT NULL,
  `main_page_error` longtext,
  `main_page_content` longtext,
  `is_main_page_checked` enum('Y','N') DEFAULT 'N',
  `main_page_title` varchar(1000) DEFAULT NULL,
  `main_page_keywords` varchar(1000) DEFAULT NULL,
  `main_page_description` varchar(1000) DEFAULT NULL,
  `crm_created_at` timestamp NULL DEFAULT NULL,
  `crm_updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_domain_details_id_ref_unique` (`id_ref`),
  KEY `fk_crm_domain_details_domains` (`domain_id`),
  CONSTRAINT `fk_crm_domain_details_domains` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `crm_marketing_lists_contacts`
--

DROP TABLE IF EXISTS `crm_marketing_lists_contacts`;
/*!50001 DROP VIEW IF EXISTS `crm_marketing_lists_contacts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crm_marketing_lists_contacts` AS SELECT 
 1 AS `id`,
 1 AS `account_id`,
 1 AS `user_id`,
 1 AS `name`,
 1 AS `surname`,
 1 AS `full_name`,
 1 AS `email`,
 1 AS `marketing_list_id`,
 1 AS `marketing_list_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `crm_organizations_overview`
--

DROP TABLE IF EXISTS `crm_organizations_overview`;
/*!50001 DROP VIEW IF EXISTS `crm_organizations_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crm_organizations_overview` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `domain`,
 1 AS `website`,
 1 AS `phone_code`,
 1 AS `phone`,
 1 AS `country_name`,
 1 AS `source`,
 1 AS `lead_source`,
 1 AS `lead_list_id`,
 1 AS `lead_list_name`,
 1 AS `state`,
 1 AS `is_marketing_qualified`,
 1 AS `is_sales_qualified`,
 1 AS `segment_name`,
 1 AS `account_id`,
 1 AS `representative_account_id`,
 1 AS `representative_account_name`,
 1 AS `representative_user_name`,
 1 AS `representative_user_id`,
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `crm_registered_customers_overview`
--

DROP TABLE IF EXISTS `crm_registered_customers_overview`;
/*!50001 DROP VIEW IF EXISTS `crm_registered_customers_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crm_registered_customers_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `domain`,
 1 AS `phone_number`,
 1 AS `balance`,
 1 AS `currency_code`,
 1 AS `account_type`,
 1 AS `risk_level`,
 1 AS `credit_score`,
 1 AS `credit`,
 1 AS `credit_override`,
 1 AS `approved_at`,
 1 AS `suspended_at`,
 1 AS `created_at`,
 1 AS `deleted_at`,
 1 AS `user_email`,
 1 AS `user_username`,
 1 AS `user_gender`,
 1 AS `representative_user_name`,
 1 AS `representative_user_id`,
 1 AS `representative_account_name`,
 1 AS `representative_account_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `crm_sales_person_data`
--

DROP TABLE IF EXISTS `crm_sales_person_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crm_sales_person_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `total_lead_count` int unsigned DEFAULT '0',
  `total_account_count` int unsigned DEFAULT '0',
  `total_quote_count` int unsigned DEFAULT '0',
  `total_opportunity_count` int unsigned DEFAULT '0',
  `total_conversion_count` int unsigned DEFAULT '0',
  `total_project_count` int unsigned DEFAULT '0',
  `active_lead_count` int unsigned DEFAULT '0',
  `active_account_count` int unsigned DEFAULT '0',
  `active_quote_count` int unsigned DEFAULT '0',
  `active_opportunity_count` int unsigned DEFAULT '0',
  `active_project_count` int unsigned DEFAULT '0',
  `overdue_project_count` int unsigned DEFAULT '0',
  `successful_project_count` int unsigned DEFAULT '0',
  `crm_login_interval` int unsigned DEFAULT '0',
  `daily_call_count` int unsigned DEFAULT '0',
  `daily_meeting_count` int unsigned DEFAULT '0',
  `daily_event_count` int unsigned DEFAULT '0',
  `active_opportunity_amount` double DEFAULT '0',
  `account_payment_yearly` double DEFAULT '0',
  `account_payment_cumulative` double DEFAULT '0',
  `account_debt_cumulative` double DEFAULT '0',
  `sales_bonus_percent` double DEFAULT '0',
  `team_bonus_percent` double DEFAULT '0',
  `new_customer_bonus_cash` double DEFAULT '0',
  `new_customer_bonus_percent` double DEFAULT '0',
  `recuring_sales_bonus_percent` double DEFAULT '0',
  `recuring_sales_bonus_cash` double DEFAULT '0',
  `sales_statistics` json DEFAULT NULL,
  `total_organization_count` bigint unsigned DEFAULT '0',
  `total_contact_count` bigint unsigned DEFAULT '0',
  `crm_created_at` timestamp NULL DEFAULT NULL,
  `crm_updated_at` timestamp NULL DEFAULT NULL,
  `crm_deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `crm_sales_person_data_account_id_foreign` (`account_id`),
  KEY `crm_sales_person_data_user_id_foreign` (`user_id`),
  CONSTRAINT `crm_sales_person_data_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `crm_sales_person_data_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25480 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `crm_user_data`
--

DROP TABLE IF EXISTS `crm_user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crm_user_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `martial_status` enum('married','single') DEFAULT NULL COMMENT 'evlilik durumu',
  `birthday` date DEFAULT NULL,
  `child_count` enum('0','1','2','3','4','5','more') DEFAULT NULL COMMENT 'evlilik durumu',
  `education` enum('high_school','college','university','masters','doctorate','professor') DEFAULT NULL COMMENT 'eğitim durumu',
  `position` enum('head_of_board_member','board_member','c_level_executive','director','employee') DEFAULT NULL COMMENT 'şirketteki pozisyonu',
  `job` enum('manager','developer','designer','art_director','gamer','devops','network_engineer') DEFAULT NULL COMMENT 'şirketteki işi',
  `job_description` varchar(500) DEFAULT NULL,
  `hobbies` varchar(200) DEFAULT NULL COMMENT 'kişinin hobileri',
  `location` varchar(200) DEFAULT NULL COMMENT 'kişinin yaşadığı yer',
  `biography` varchar(500) DEFAULT NULL COMMENT 'kişinin biografisi',
  `mautic_id` bigint unsigned DEFAULT '0' COMMENT 'kişinin mautic''deki ID''si',
  `mautic_user_id` bigint unsigned DEFAULT '0' COMMENT 'kşinin mautic user id''si (eğer mautic user ise)',
  `email_risk` enum('low','medium','high') DEFAULT NULL,
  `has_teknosacell_subscription` tinyint NOT NULL DEFAULT '0',
  `is_disposable_email` enum('Y','N') DEFAULT 'N',
  `is_mailgun_checked` tinyint DEFAULT '0',
  `is_email_opt_out` enum('Y','N') DEFAULT 'N',
  `is_phone_opt_out` enum('Y','N') DEFAULT 'N',
  `gitlab_token` varchar(50) DEFAULT NULL,
  `linkedin` varchar(500) DEFAULT NULL,
  `facebook` varchar(500) DEFAULT NULL,
  `twitter` varchar(500) DEFAULT NULL,
  `github` varchar(500) DEFAULT NULL,
  `gitlab` varchar(500) DEFAULT NULL,
  `contact_id` bigint unsigned DEFAULT NULL,
  `relationship_status` enum('aware-of-us','acquired','converted','retention','brand-advocator') DEFAULT 'aware-of-us',
  `crm_created_at` timestamp NULL DEFAULT NULL,
  `crm_updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_user_data_unique` (`account_id`,`user_id`),
  KEY `crm_data_account_id_foreign` (`account_id`),
  KEY `crm_data_user_id_foreign` (`user_id`),
  KEY `crm_user_data_contacts_fk` (`contact_id`),
  CONSTRAINT `crm_data_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `crm_data_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `crm_user_data_contacts_fk` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8353 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cron_jobs`
--

DROP TABLE IF EXISTS `cron_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cron_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `url` varchar(2083) DEFAULT NULL,
  `headers` text,
  `parameters` text,
  `method` enum('GET','POST','PUT','PATCH','DELETE') DEFAULT 'GET',
  `schedule` varchar(50) DEFAULT '',
  `is_enabled` tinyint(1) DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cron_jobs_id_ref_unique` (`id_ref`),
  KEY `cron_jobs_account_id_foreign` (`account_id`),
  KEY `cron_jobs_user_id_foreign` (`user_id`),
  CONSTRAINT `cron_jobs_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cron_jobs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cron_reports`
--

DROP TABLE IF EXISTS `cron_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cron_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `run_at` datetime NOT NULL,
  `run_time` double NOT NULL,
  `output` longtext NOT NULL,
  `job_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cron_reports_id_ref_unique` (`id_ref`),
  KEY `cron_reports_job_id_foreign` (`job_id`),
  CONSTRAINT `cron_reports_job_id_foreign` FOREIGN KEY (`job_id`) REFERENCES `cron_jobs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170741 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `database_services`
--

DROP TABLE IF EXISTS `database_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `iam_service_id` bigint unsigned DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `database_version` varchar(250) DEFAULT NULL,
  `database_count` int unsigned NOT NULL DEFAULT '0',
  `database_configuration` json DEFAULT NULL COMMENT 'Stores database configuration',
  `connection_ip` varchar(50) DEFAULT NULL,
  `connection_port` int DEFAULT NULL,
  `type` enum('cassandra','elasticsearch','galera','mariadb','microsoftsql','mongodb','mysql','oracle','postgresql','redis') NOT NULL DEFAULT 'mysql',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `database_services_id_ref_unique` (`id_ref`),
  KEY `database_services_account_id_foreign` (`account_id`),
  KEY `database_services_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `database_services_iam_service_id_foreign` (`iam_service_id`),
  CONSTRAINT `database_services_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `database_services_iam_service_id_foreign` FOREIGN KEY (`iam_service_id`) REFERENCES `iam_services` (`id`),
  CONSTRAINT `database_services_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`),
  CONSTRAINT `database_services_chk_1` CHECK (((`database_configuration` is null) or json_valid(`database_configuration`)))
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `database_services_ha_peer`
--

DROP TABLE IF EXISTS `database_services_ha_peer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_services_ha_peer` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `database_services_id` bigint unsigned DEFAULT NULL,
  `database_configuration` json DEFAULT NULL COMMENT 'Stores database configuration',
  `connection_ip` varchar(50) DEFAULT NULL,
  `connection_port` int DEFAULT NULL,
  `peer_type` enum('active','passive','standby','standalone-replication') NOT NULL DEFAULT 'passive',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `database_services_ha_peer_id_ref_unique` (`id_ref`),
  KEY `database_services_ha_peer_database_services_id_foreign` (`database_services_id`),
  KEY `database_services_ha_peer_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `database_services_ha_peer_database_services_id_foreign` FOREIGN KEY (`database_services_id`) REFERENCES `database_services` (`id`),
  CONSTRAINT `database_services_ha_peer_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`),
  CONSTRAINT `database_services_ha_peer_chk_1` CHECK (((`database_configuration` is null) or json_valid(`database_configuration`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenter_histories`
--

DROP TABLE IF EXISTS `datacenter_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datacenter_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenter_node_histories`
--

DROP TABLE IF EXISTS `datacenter_node_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_node_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datacenter_node_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3329 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenter_node_network_pools`
--

DROP TABLE IF EXISTS `datacenter_node_network_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_node_network_pools` (
  `datacenter_node_id` int unsigned NOT NULL,
  `network_pool_id` int unsigned NOT NULL,
  UNIQUE KEY `dcnode_id_ntwpool_id_unique` (`datacenter_node_id`,`network_pool_id`),
  KEY `datacenter_node_network_pools_network_pool_id_foreign` (`network_pool_id`),
  CONSTRAINT `datacenter_node_network_pools_datacenter_node_id_foreign` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `datacenter_node_network_pools_network_pool_id_foreign` FOREIGN KEY (`network_pool_id`) REFERENCES `network_pools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenter_node_networks`
--

DROP TABLE IF EXISTS `datacenter_node_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_node_networks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `datacenter_node_id` int unsigned NOT NULL,
  `network_id` int unsigned NOT NULL,
  `compute_member_id` int unsigned DEFAULT NULL,
  `bridge` varchar(100) DEFAULT NULL,
  `vlan` varchar(100) DEFAULT NULL,
  `is_interconnected` tinyint(1) NOT NULL DEFAULT '0',
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `hypervisor_session_id` varchar(255) DEFAULT NULL,
  `hypervisor_data` text,
  PRIMARY KEY (`id`),
  KEY `datacenter_node_networks_network_id_foreign` (`network_id`),
  KEY `datacenter_node_networks_datacenter_node_id_foreign` (`datacenter_node_id`),
  KEY `datacenter_node_networks_unique_index` (`hypervisor_uuid`),
  CONSTRAINT `datacenter_node_networks_datacenter_node_id_foreign` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `datacenter_node_networks_network_id_foreign` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenter_node_storage_pools`
--

DROP TABLE IF EXISTS `datacenter_node_storage_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_node_storage_pools` (
  `datacenter_node_id` int unsigned NOT NULL,
  `storage_pool_id` int unsigned NOT NULL,
  UNIQUE KEY `dcnode_id_strpool_id_unique` (`datacenter_node_id`,`storage_pool_id`),
  KEY `datacenter_node_storage_pools_storage_pool_id_foreign` (`storage_pool_id`),
  CONSTRAINT `datacenter_node_storage_pools_datacenter_node_id_foreign` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `datacenter_node_storage_pools_storage_pool_id_foreign` FOREIGN KEY (`storage_pool_id`) REFERENCES `storage_pools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenter_node_storage_volumes`
--

DROP TABLE IF EXISTS `datacenter_node_storage_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_node_storage_volumes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `datacenter_node_id` int unsigned NOT NULL,
  `storage_volume_id` int unsigned NOT NULL,
  `compute_member_id` int unsigned DEFAULT NULL,
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `hypervisor_session_id` varchar(255) DEFAULT NULL,
  `hypervisor_data` text,
  `is_attached` tinyint(1) NOT NULL DEFAULT '1',
  `is_readonly` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `datacenter_node_storage_volumes_datacenter_node_id_foreign` (`datacenter_node_id`),
  KEY `datacenter_node_storage_volumes_storage_volume_id_foreign` (`storage_volume_id`),
  CONSTRAINT `datacenter_node_storage_volumes_datacenter_node_id_foreign` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `datacenter_node_storage_volumes_storage_volume_id_foreign` FOREIGN KEY (`storage_volume_id`) REFERENCES `storage_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenter_node_translations`
--

DROP TABLE IF EXISTS `datacenter_node_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_node_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(2000) NOT NULL,
  `features` varchar(191) DEFAULT NULL,
  `locale` char(2) NOT NULL DEFAULT 'tr',
  `datacenter_node_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datacenter_node_translations_datacenter_node_id_locale_unique` (`datacenter_node_id`,`locale`),
  KEY `datacenter_node_translations_locale_index` (`locale`),
  CONSTRAINT `datacenter_node_translations_datacenter_node_id_foreign` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `datacenter_node_usage_report_view`
--

DROP TABLE IF EXISTS `datacenter_node_usage_report_view`;
/*!50001 DROP VIEW IF EXISTS `datacenter_node_usage_report_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `datacenter_node_usage_report_view` AS SELECT 
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_name`,
 1 AS `running_vm`,
 1 AS `used_cpu`,
 1 AS `total_ram`,
 1 AS `used_ram`,
 1 AS `free_ram`,
 1 AS `cpu_hourly_price`,
 1 AS `ram_hourly_price`,
 1 AS `hdd_hourly_price`,
 1 AS `used_cpu_hourly_price`,
 1 AS `used_ram_hourly_price`,
 1 AS `used_cpu_monthly_price`,
 1 AS `used_ram_monthly_price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `datacenter_nodes`
--

DROP TABLE IF EXISTS `datacenter_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_nodes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pricing_model` enum('catalog','resource') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'resource',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_public` tinyint unsigned DEFAULT '0',
  `is_edge` tinyint(1) NOT NULL DEFAULT '1',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `is_alive` tinyint DEFAULT '1',
  `min_cpu_limit` smallint unsigned NOT NULL DEFAULT '0',
  `max_cpu_limit` smallint unsigned NOT NULL DEFAULT '0',
  `min_ram_limit` mediumint unsigned NOT NULL DEFAULT '0',
  `max_ram_limit` mediumint unsigned NOT NULL DEFAULT '0',
  `position` int unsigned DEFAULT NULL,
  `datacenter_id` int unsigned DEFAULT NULL,
  `compute_pool_id` int unsigned DEFAULT NULL,
  `proxy_server_id` bigint unsigned DEFAULT NULL,
  `nat_server_id` bigint unsigned DEFAULT NULL,
  `dhcp_server_id` bigint unsigned DEFAULT NULL,
  `vendor_id` bigint unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `ansible_playbook_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datacenter_nodes_id_ref_unique` (`id_ref`),
  KEY `datacenter_nodes_vendor_id_foreign` (`vendor_id`),
  KEY `datacenter_nodes_datacenter_id_foreign` (`datacenter_id`),
  KEY `datacenter_nodes_compute_pool_id_foreign` (`compute_pool_id`),
  KEY `datacenter_nodes_product_id_foreign` (`product_id`),
  KEY `datacenter_nodes_proxy_server_id_foreign` (`proxy_server_id`),
  KEY `datacenter_nodes_nat_server_id_foreign` (`nat_server_id`),
  KEY `datacenter_nodes_dhcp_server_id_foreign` (`dhcp_server_id`),
  CONSTRAINT `datacenter_nodes_compute_pool_id_foreign` FOREIGN KEY (`compute_pool_id`) REFERENCES `compute_pools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `datacenter_nodes_datacenter_id_foreign` FOREIGN KEY (`datacenter_id`) REFERENCES `datacenters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `datacenter_nodes_dhcp_server_id_foreign` FOREIGN KEY (`dhcp_server_id`) REFERENCES `dhcp_servers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `datacenter_nodes_nat_server_id_foreign` FOREIGN KEY (`nat_server_id`) REFERENCES `nat_servers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `datacenter_nodes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `datacenter_nodes_proxy_server_id_foreign` FOREIGN KEY (`proxy_server_id`) REFERENCES `proxy_servers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `datacenter_nodes_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `accounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `datacenter_nodes_overview`
--

DROP TABLE IF EXISTS `datacenter_nodes_overview`;
/*!50001 DROP VIEW IF EXISTS `datacenter_nodes_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `datacenter_nodes_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `slug`,
 1 AS `pricing_model`,
 1 AS `is_active`,
 1 AS `is_edge`,
 1 AS `is_public`,
 1 AS `maintenance_mode`,
 1 AS `min_cpu_limit`,
 1 AS `max_cpu_limit`,
 1 AS `min_ram_limit`,
 1 AS `max_ram_limit`,
 1 AS `position`,
 1 AS `description`,
 1 AS `features`,
 1 AS `locale`,
 1 AS `tags`,
 1 AS `datacenter_id`,
 1 AS `datacenter_name`,
 1 AS `datacenter_city`,
 1 AS `compute_pool_id`,
 1 AS `compute_pool_name`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `country_code`,
 1 AS `country_name`,
 1 AS `account_id`,
 1 AS `account_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `datacenter_translations`
--

DROP TABLE IF EXISTS `datacenter_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenter_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `security` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `electricity` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `generators` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `locale` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'tr',
  `datacenter_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `datacenter_translations_datacenter_id_locale_unique` (`datacenter_id`,`locale`),
  KEY `datacenter_translations_locale_index` (`locale`),
  CONSTRAINT `datacenter_translations_datacenter_id_foreign` FOREIGN KEY (`datacenter_id`) REFERENCES `datacenters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datacenters`
--

DROP TABLE IF EXISTS `datacenters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datacenters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uuid_prefix` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_edge` tinyint(1) NOT NULL DEFAULT '1',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `geo_latitude` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '0',
  `geo_longitude` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '0',
  `tier_level` enum('1','2','3','4','5') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_capacity` bigint unsigned DEFAULT NULL,
  `guaranteed_uptime` double DEFAULT NULL,
  `carrier_neutral` tinyint(1) DEFAULT NULL,
  `local_area_network_capacity` bigint unsigned DEFAULT NULL,
  `power_source` enum('redundant','single') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ups` enum('redundant','single') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `cooling` enum('redundant','single') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int unsigned,
  `vendor_id` bigint unsigned DEFAULT NULL,
  `country_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datacenters_id_ref_unique` (`id_ref`),
  KEY `datacenters_vendor_id_foreign` (`vendor_id`),
  KEY `datacenters_country_id_foreign` (`country_id`),
  CONSTRAINT `datacenters_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `datacenters_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `accounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `datacenters_overview`
--

DROP TABLE IF EXISTS `datacenters_overview`;
/*!50001 DROP VIEW IF EXISTS `datacenters_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `datacenters_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `slug`,
 1 AS `uuid_prefix`,
 1 AS `is_default`,
 1 AS `is_active`,
 1 AS `is_public`,
 1 AS `is_edge`,
 1 AS `maintenance_mode`,
 1 AS `country_name`,
 1 AS `city`,
 1 AS `description`,
 1 AS `security`,
 1 AS `electricity`,
 1 AS `generators`,
 1 AS `geo_latitude`,
 1 AS `geo_longitude`,
 1 AS `tier_level`,
 1 AS `total_capacity`,
 1 AS `guaranteed_uptime`,
 1 AS `carrier_neutral`,
 1 AS `local_area_network_capacity`,
 1 AS `power_source`,
 1 AS `ups`,
 1 AS `cooling`,
 1 AS `position`,
 1 AS `locale`,
 1 AS `vendor_id`,
 1 AS `vendor_id_ref`,
 1 AS `vendor_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dhcp_server_ip_lists`
--

DROP TABLE IF EXISTS `dhcp_server_ip_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dhcp_server_ip_lists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL COMMENT 'identifier',
  `dhcp_server_id` bigint unsigned NOT NULL,
  `mac` char(17) NOT NULL,
  `hostname` varchar(250) DEFAULT NULL,
  `ip` char(15) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dhcp_server_ip_lists_id_ref_unique` (`id_ref`),
  KEY `dhcp_server_ip_lists_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `dhcp_server_ip_lists_dhcp_server_id_foreign` (`dhcp_server_id`),
  KEY `dhcp_server_ip_lists_account_id_foreign` (`account_id`),
  CONSTRAINT `dhcp_server_ip_lists_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `dhcp_server_ip_lists_dhcp_server` FOREIGN KEY (`dhcp_server_id`) REFERENCES `dhcp_servers` (`id`),
  CONSTRAINT `dhcp_server_ip_lists_dhcp_server_id_foreign` FOREIGN KEY (`dhcp_server_id`) REFERENCES `dhcp_servers` (`id`),
  CONSTRAINT `dhcp_server_ip_lists_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=667 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dhcp_server_subnet_lists`
--

DROP TABLE IF EXISTS `dhcp_server_subnet_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dhcp_server_subnet_lists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `dhcp_server_id` bigint unsigned NOT NULL,
  `network_id` bigint unsigned DEFAULT NULL,
  `subnet` varchar(15) NOT NULL,
  `netmask` varchar(15) NOT NULL,
  `range_start` varchar(15) NOT NULL,
  `range_end` varchar(15) DEFAULT NULL,
  `broadcast` varchar(15) NOT NULL,
  `option_subnet_mask` varchar(15) DEFAULT NULL,
  `option_dns` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `option_domain` varchar(100) DEFAULT NULL,
  `option_routers` varchar(15) NOT NULL,
  `option_netbios_nameservers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `option_netbios_node_type` varchar(1) DEFAULT '8',
  `default_lease_time` mediumint unsigned NOT NULL DEFAULT '36000',
  `max_lease_time` mediumint unsigned NOT NULL DEFAULT '72000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dhcp_server_subnet_lists_id_ref_unique` (`id_ref`),
  KEY `dhcp_server_subnet_lists_dhcp_server_id_foreign` (`dhcp_server_id`),
  CONSTRAINT `dhcp_server_subnet_lists_dhcp_server_id_foreign` FOREIGN KEY (`dhcp_server_id`) REFERENCES `dhcp_servers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dhcp_servers`
--

DROP TABLE IF EXISTS `dhcp_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dhcp_servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` enum('isc','force10','juniper-srx-v1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `account_id` bigint unsigned NOT NULL COMMENT 'Owner of this dhcp server',
  `virtual_machine_id` bigint unsigned DEFAULT NULL COMMENT 'Virtual Machine ID of related DHCP server. NULL if server_type is hardware.',
  `is_alive` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dhcp_servers_id_ref_unique` (`id_ref`),
  KEY `dhcp_servers_account_id_foreign` (`account_id`),
  CONSTRAINT `dhcp_servers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discountables`
--

DROP TABLE IF EXISTS `discountables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discountables` (
  `discount_id` int NOT NULL,
  `discountable_id` int unsigned NOT NULL,
  `discountable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `custom_start_at` timestamp NULL DEFAULT NULL,
  `custom_expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `discount_type` tinyint NOT NULL COMMENT '0 : Yüzde cinsinden, 1 : Ücret cinsinden',
  `percentage` smallint DEFAULT '0',
  `price` decimal(13,4) DEFAULT '0.0000',
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `min_order_value` decimal(13,4) DEFAULT NULL COMMENT 'Minimum sipariş tutarı',
  `max_order_value` decimal(13,4) DEFAULT NULL COMMENT 'Maximum sipariş tutar',
  `min_order_count` int DEFAULT NULL COMMENT 'Minimum sipariş adedi',
  `max_order_count` int DEFAULT NULL COMMENT 'Maximum sipariş adedi',
  `account_id` bigint DEFAULT NULL COMMENT 'Müşteriye özel ise müşteri id',
  `country_id` int DEFAULT NULL COMMENT 'Ülkeye özel ise ülke id',
  `start_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discounts_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discussion_answers`
--

DROP TABLE IF EXISTS `discussion_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discussion_answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `discussion_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discussion_answers_id_ref_unique` (`id_ref`),
  KEY `discussion_answers_user_id_foreign` (`user_id`),
  KEY `discussion_answers_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `discussion_answers_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `discussion_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discussion_subscriptions`
--

DROP TABLE IF EXISTS `discussion_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discussion_subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `discussion_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `discussion_subscriptions_user_id_discussion_id_unique` (`user_id`,`discussion_id`),
  KEY `discussion_subscriptions_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `discussion_subscriptions_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discussions`
--

DROP TABLE IF EXISTS `discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discussions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `visits` bigint unsigned NOT NULL DEFAULT '0',
  `reply_count` bigint unsigned NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0',
  `meta_title` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `header_image` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bonus_points` int unsigned NOT NULL DEFAULT '0',
  `thread_type` enum('qa','blogpost','discussion','documentation') COLLATE utf8_unicode_ci NOT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `best_answer_id` bigint unsigned DEFAULT NULL,
  `domain_id` bigint unsigned DEFAULT NULL,
  `status` enum('draft','pending-approval','approved') COLLATE utf8_unicode_ci DEFAULT 'draft',
  `content_type` enum('html','markdown') COLLATE utf8_unicode_ci DEFAULT 'html',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `discussions_id_ref_unique` (`id_ref`),
  KEY `discussions_category_id_foreign` (`category_id`),
  KEY `discussions_user_id_foreign` (`user_id`),
  KEY `discussions_best_answer_id_foreign` (`best_answer_id`),
  CONSTRAINT `discussions_best_answer_id_foreign` FOREIGN KEY (`best_answer_id`) REFERENCES `discussion_answers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `discussions_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `disposable_emails`
--

DROP TABLE IF EXISTS `disposable_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disposable_emails` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `disposable_emails_domain_unique` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=89853 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dns_domain_records`
--

DROP TABLE IF EXISTS `dns_domain_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dns_domain_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `record` varchar(200) DEFAULT NULL,
  `record_type` varchar(50) DEFAULT NULL,
  `domain_id` bigint unsigned NOT NULL,
  `dns_server_ip` varchar(50) DEFAULT NULL,
  `ns_test_result` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dns_domain_records_id_ref_unique` (`id_ref`),
  KEY `dns_domain_records_domain_id_foreign` (`domain_id`),
  CONSTRAINT `dns_domain_records_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=399520 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_dns_domain_records` BEFORE INSERT ON `dns_domain_records` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dns_service_usage_history`
--

DROP TABLE IF EXISTS `dns_service_usage_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dns_service_usage_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `record_count` int NOT NULL DEFAULT '0',
  `dnssec_count` int NOT NULL DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `dns_service_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dns_service_usage_history_account_id_foreign` (`account_id`),
  KEY `dns_service_usage_history_dns_service_id_foreign` (`dns_service_id`),
  CONSTRAINT `dns_service_usage_history_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dns_service_usage_history_dns_service_id_foreign` FOREIGN KEY (`dns_service_id`) REFERENCES `dns_services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dns_services`
--

DROP TABLE IF EXISTS `dns_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dns_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `ipv4` varchar(45) DEFAULT NULL,
  `ipv6` varchar(45) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL COMMENT 'Used if service is not plusclouds_api',
  `password` varchar(60) DEFAULT NULL COMMENT 'Used if service is not plusclouds_api',
  `token` varchar(1024) DEFAULT NULL COMMENT 'Used if necessary',
  `domain_price` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `record_price` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `dnssec_price` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `currency_code` char(3) NOT NULL DEFAULT 'USD',
  `connection_type` enum('powerdns_database','plusclouds_api','bind-over-ssh','powerdns_api') NOT NULL DEFAULT 'plusclouds_api',
  `dns_type` enum('public','private') NOT NULL DEFAULT 'private',
  `default_nameservers` text,
  `account_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dns_services_id_ref_unique` (`id_ref`),
  UNIQUE KEY `dns_services_slug_unique` (`slug`),
  KEY `dns_services_account_id_foreign` (`account_id`),
  KEY `dns_services_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `dns_services_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dns_services_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domainables`
--

DROP TABLE IF EXISTS `domainables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domainables` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `domainable_id` bigint unsigned NOT NULL,
  `domainable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domains` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `name` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `iam_service_id` bigint unsigned DEFAULT NULL,
  `dns_domain_id` bigint unsigned DEFAULT NULL,
  `dns_service_id` bigint unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_local_domain` tinyint(1) NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_shared_domain` tinyint DEFAULT '0' COMMENT 'We are setting yes if this domain provides email service or shares domain with others.',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domains_name_unique` (`name`),
  UNIQUE KEY `domains_id_ref_unique` (`id_ref`),
  KEY `domains_account_id_foreign` (`account_id`),
  CONSTRAINT `domains_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=285579 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_marketings`
--

DROP TABLE IF EXISTS `email_marketings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_marketings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL COMMENT 'Email marketingin sahibi olan hesap',
  `user_id` bigint unsigned NOT NULL COMMENT 'Email marketingi yaratan kisi',
  `marketing_id` bigint unsigned NOT NULL COMMENT 'Bagli oldugu pazarlamanin idsi',
  `subject` char(10) NOT NULL,
  `body` varchar(100) NOT NULL,
  `template` varchar(500) NOT NULL,
  `variables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_marketings_id_ref_unique` (`id_ref`),
  KEY `email_marketings_account_id_foreign` (`account_id`),
  KEY `email_marketings_user_id_foreign` (`user_id`),
  KEY `email_marketings_marketing_id_foreign` (`marketing_id`),
  CONSTRAINT `email_marketings_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `email_marketings_marketing_id_foreign` FOREIGN KEY (`marketing_id`) REFERENCES `marketing_campaigns` (`id`),
  CONSTRAINT `email_marketings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'tr',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_templates_name_locale_unique` (`name`,`locale`),
  UNIQUE KEY `email_templates_id_ref_unique` (`id_ref`),
  KEY `email_templates_locale_index` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encryption_clusters`
--

DROP TABLE IF EXISTS `encryption_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encryption_clusters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `auth_method` varchar(32) DEFAULT 'default',
  `connection_method` varchar(32) DEFAULT 'default',
  `auth_credentials` json DEFAULT NULL,
  `configuration` json DEFAULT NULL,
  `type` tinyint NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_encryption_clusters` BEFORE INSERT ON `encryption_clusters` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `encryption_engine_usages`
--

DROP TABLE IF EXISTS `encryption_engine_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encryption_engine_usages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `engine_id` bigint unsigned NOT NULL,
  `transaction_type` enum('encrypt','decrypt') NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `payload_size` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `encryption_engine_usages_engine_id_foreign` (`engine_id`),
  KEY `encryption_engine_usages_accounts_fk` (`account_id`),
  KEY `encryption_engine_usages_users_fk` (`user_id`),
  CONSTRAINT `encryption_engine_usages_accounts_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `encryption_engine_usages_engine_id_foreign` FOREIGN KEY (`engine_id`) REFERENCES `encryption_engines` (`id`),
  CONSTRAINT `encryption_engine_usages_users_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_encryption_engine_usages` BEFORE INSERT ON `encryption_engine_usages` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `encryption_engines`
--

DROP TABLE IF EXISTS `encryption_engines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encryption_engines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `cluster_id` bigint unsigned DEFAULT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `auth_method` varchar(32) DEFAULT 'default',
  `auth_credentials` json DEFAULT NULL,
  `configuration` json DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `status` enum('operational','disabled','maintenance') NOT NULL DEFAULT 'operational',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `encryption_engines_enc_clusters_fk` (`cluster_id`),
  CONSTRAINT `encryption_engines_enc_clusters_fk` FOREIGN KEY (`cluster_id`) REFERENCES `encryption_clusters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_encryption_engines` BEFORE INSERT ON `encryption_engines` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `error_code_facilities`
--

DROP TABLE IF EXISTS `error_code_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `error_code_facilities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `error_code_index` int unsigned NOT NULL DEFAULT '1',
  `source` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `error_code_facilities_error_code_index` (`name`,`error_code_index`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `error_codes`
--

DROP TABLE IF EXISTS `error_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `error_codes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `error_code` char(10) DEFAULT NULL,
  `error_text` varchar(255) DEFAULT NULL,
  `exception` varchar(1000) DEFAULT NULL,
  `help_url` varchar(1000) DEFAULT NULL,
  `message` varchar(500) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `facility_id` int unsigned DEFAULT NULL,
  `deprecated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `error_codes_error_code_uindex` (`error_code`),
  UNIQUE KEY `error_codes_id_ref_uindex` (`id_ref`),
  UNIQUE KEY `error_codes_error_text_uindex` (`error_text`),
  KEY `error_codes_facility_id_fk` (`facility_id`),
  CONSTRAINT `error_codes_facility_id_fk` FOREIGN KEY (`facility_id`) REFERENCES `error_code_facilities` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_error_codes` BEFORE INSERT ON `error_codes` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `eventbrite_id` bigint DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Event owner',
  `category_id` bigint unsigned DEFAULT NULL,
  `order_count` int unsigned NOT NULL,
  `name` varchar(500) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `capacity` int unsigned NOT NULL COMMENT 'Maximum number of invitation',
  `is_online` tinyint(1) NOT NULL DEFAULT '0',
  `is_live` tinyint(1) NOT NULL DEFAULT '0',
  `online_url` varchar(200) DEFAULT NULL,
  `live_url` varchar(200) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  `start` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `events_id_ref_unique` (`id_ref`),
  KEY `events_category_id_foreign` (`category_id`),
  KEY `events_account_id_foreign` (`account_id`),
  CONSTRAINT `events_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `events_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_rates`
--

DROP TABLE IF EXISTS `exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_rates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `old_id` int unsigned DEFAULT NULL,
  `code` enum('USD','EUR','AUD','GBP','CAD','JPY','RUB') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `rate` decimal(13,4) NOT NULL,
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'TCMB son güncellenme tarihi',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exchange_rates_code_index` (`code`),
  KEY `exchange_rates__last_modifed_date_index` (`last_modified` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=886029 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1038702 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_codes`
--

DROP TABLE IF EXISTS `gift_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) COLLATE utf8_bin DEFAULT NULL,
  `code` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `order_number` bigint unsigned DEFAULT NULL,
  `line_number` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned NOT NULL,
  `product_catalog_id` bigint unsigned NOT NULL,
  `provider_account_id` bigint unsigned DEFAULT NULL,
  `gift_mode` enum('percentage','value') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'percentage',
  `gift_value` int unsigned NOT NULL DEFAULT '100',
  `currency_code` varchar(3) COLLATE utf8_bin DEFAULT 'USD',
  `partner_created_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_gift_cards` BEFORE INSERT ON `gift_codes` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `history_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1758365 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hook_logs`
--

DROP TABLE IF EXISTS `hook_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hook_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `hook_id` int unsigned NOT NULL,
  `logable_id` int unsigned NOT NULL,
  `logable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `payload` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `response` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `response_content_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `response_code` smallint unsigned NOT NULL,
  `state` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hookables`
--

DROP TABLE IF EXISTS `hookables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hookables` (
  `hook_id` int NOT NULL,
  `hookable_id` int unsigned NOT NULL,
  `hookable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hooks`
--

DROP TABLE IF EXISTS `hooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hooks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `http_verb` enum('GET','POST','PUT','PATCH','DELETE') NOT NULL DEFAULT 'POST',
  `uri` varchar(2083) NOT NULL,
  `payload` text,
  `verify` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'SSL Verify',
  `position` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hooks_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hosting_accounts`
--

DROP TABLE IF EXISTS `hosting_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosting_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `endpoint` varchar(2083) NOT NULL,
  `hosting_server_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `username` varchar(191) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `domain_id` bigint unsigned DEFAULT NULL,
  `package` varchar(191) DEFAULT NULL,
  `actual_ram` double(8,2) NOT NULL,
  `actual_cpu` double(8,2) NOT NULL,
  `total_traffic` double(8,2) NOT NULL,
  `status` enum('active','passive','suspended') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hosting_accounts_id_ref_unique` (`id_ref`),
  KEY `hosting_accounts_hosting_server_id_foreign` (`hosting_server_id`),
  KEY `hosting_accounts_account_id_foreign` (`account_id`),
  KEY `hosting_accounts_domain_id_foreign` (`domain_id`),
  CONSTRAINT `hosting_accounts_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hosting_accounts_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hosting_accounts_hosting_server_id_foreign` FOREIGN KEY (`hosting_server_id`) REFERENCES `hosting_servers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_hosting_accounts` BEFORE INSERT ON `hosting_accounts` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hosting_clusters`
--

DROP TABLE IF EXISTS `hosting_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosting_clusters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `description` text,
  `product_id` bigint unsigned DEFAULT NULL,
  `region` varchar(191) DEFAULT NULL,
  `provisioning_alg` varchar(500) DEFAULT NULL,
  `datacenter_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hosting_clusters_id_ref_unique` (`id_ref`),
  KEY `hosting_clusters_account_id_foreign` (`account_id`),
  KEY `hosting_clusters_user_id_foreign` (`user_id`),
  CONSTRAINT `hosting_clusters_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hosting_clusters_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_hosting_clusters` BEFORE INSERT ON `hosting_clusters` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hosting_package_histories`
--

DROP TABLE IF EXISTS `hosting_package_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosting_package_histories` (
  `hosting_server_id` bigint unsigned NOT NULL,
  `hosting_account_id` bigint unsigned NOT NULL,
  `package` varchar(191) DEFAULT NULL,
  `comment` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hosting_servers`
--

DROP TABLE IF EXISTS `hosting_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosting_servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `ip` varchar(25) NOT NULL,
  `whm_license_key` varchar(255) DEFAULT NULL,
  `cloudlinux_license_key` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `license_limit` int unsigned DEFAULT NULL,
  `used_license` int unsigned DEFAULT '0',
  `provider` enum('cpanel') NOT NULL DEFAULT 'cpanel',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hosting_servers_id_ref_unique` (`id_ref`),
  KEY `hosting_servers_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `hosting_servers_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `hosting_clusters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_hosting_servers` BEFORE INSERT ON `hosting_servers` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `iaas_event_logs`
--

DROP TABLE IF EXISTS `iaas_event_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iaas_event_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `eventable_id` bigint NOT NULL,
  `eventable_type` varchar(255) NOT NULL,
  `event_object` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26715 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iaas_meta`
--

DROP TABLE IF EXISTS `iaas_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iaas_meta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `metable_id` int NOT NULL,
  `metable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iaas_meta_metable_id_metable_type_key_unique` (`metable_id`,`metable_type`,`key`),
  KEY `iaas_meta_metable_id_index` (`metable_id`),
  KEY `iaas_meta_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=12685 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_service_mappings`
--

DROP TABLE IF EXISTS `iam_service_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iam_service_mappings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `iam_service_id` bigint unsigned NOT NULL,
  `iam_key` varchar(200) NOT NULL,
  `plusclouds_key` varchar(200) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iam_service_mappings_id_ref_unique` (`id_ref`),
  KEY `iam_service_mappings_iam_service_id_foreign` (`iam_service_id`),
  CONSTRAINT `iam_service_mappings_iam_service_id_foreign` FOREIGN KEY (`iam_service_id`) REFERENCES `iam_services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iam_services`
--

DROP TABLE IF EXISTS `iam_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iam_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('plusclouds-iam','ldap','active-directory') NOT NULL DEFAULT 'plusclouds-iam',
  `ldap_server_name` varchar(250) DEFAULT NULL,
  `ldap_server_url` varchar(250) DEFAULT NULL,
  `ldap_server_port` varchar(250) DEFAULT NULL,
  `ldap_base_dn` varchar(250) DEFAULT NULL,
  `ldap_bind_username` varchar(250) DEFAULT NULL,
  `ldap_bind_password` varchar(250) DEFAULT NULL,
  `default_filter` varchar(100) DEFAULT '(objectclass=*)',
  `default_memberof` varchar(100) DEFAULT NULL,
  `default_group` varchar(100) DEFAULT NULL,
  `default_userid_field` varchar(100) NOT NULL DEFAULT 'uid',
  `default_password_field` varchar(100) NOT NULL DEFAULT 'userPassword',
  `default_email_field` varchar(100) NOT NULL DEFAULT 'mail',
  `default_alias_field` varchar(100) NOT NULL DEFAULT 'cn',
  `default_first_name_field` varchar(100) NOT NULL DEFAULT 'givenName',
  `default_last_name_field` varchar(100) NOT NULL DEFAULT 'sn',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_connection_secure` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iam_services_id_ref_unique` (`id_ref`),
  KEY `iam_services_account_id_foreign` (`account_id`),
  KEY `iam_services_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `iam_services_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `iam_services_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `industries`
--

DROP TABLE IF EXISTS `industries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `industries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `industries_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_industries` BEFORE INSERT ON `industries` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `intelligence_domains`
--

DROP TABLE IF EXISTS `intelligence_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_domains` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `domain_id` bigint unsigned DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `is_alive` tinyint NOT NULL DEFAULT '1',
  `is_extracted` tinyint DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `intelligence_domains_id_ref_unique` (`id_ref`),
  KEY `intelligence_domains_domain_id_foreign` (`domain_id`),
  CONSTRAINT `intelligence_domains_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=485832 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_intelligence_domains` BEFORE INSERT ON `intelligence_domains` FOR EACH ROW SET new.id_ref = uuid() */;;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `intelligence_create_domain_dns_data` AFTER INSERT ON `intelligence_domains` FOR EACH ROW begin
    insert ignore into intelligence_domains_dns (intelligence_domain_id, created_at)
    select id, created_at from intelligence_domains;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `intelligence_domains_dns`
--

DROP TABLE IF EXISTS `intelligence_domains_dns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_domains_dns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `intelligence_domain_id` bigint unsigned NOT NULL,
  `a_records` json DEFAULT NULL,
  `ns_records` json DEFAULT NULL,
  `mx_records` json DEFAULT NULL,
  `dns_error` text,
  `is_worker_running` tinyint(1) NOT NULL DEFAULT '0',
  `is_alive` tinyint DEFAULT '0',
  `dns_hosted_at` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `intelligence_domains_dns_domain_id_index` (`intelligence_domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=259561 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intelligence_domains_ips`
--

DROP TABLE IF EXISTS `intelligence_domains_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_domains_ips` (
  `intelligence_domain_id` bigint unsigned NOT NULL,
  `intelligence_ip_id` bigint unsigned NOT NULL,
  KEY `fk_domain_id` (`intelligence_domain_id`),
  KEY `fk_ips` (`intelligence_ip_id`),
  CONSTRAINT `fk_domain_id` FOREIGN KEY (`intelligence_domain_id`) REFERENCES `intelligence_domains` (`id`),
  CONSTRAINT `fk_ips` FOREIGN KEY (`intelligence_ip_id`) REFERENCES `intelligence_ips` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intelligence_domains_whois`
--

DROP TABLE IF EXISTS `intelligence_domains_whois`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_domains_whois` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `intelligence_domain_id` bigint unsigned NOT NULL,
  `whois_data` json NOT NULL,
  `whois_error` text NOT NULL,
  `is_worker_running` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intelligence_email_addresses`
--

DROP TABLE IF EXISTS `intelligence_email_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_email_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `mailbox_user_id` bigint unsigned DEFAULT NULL COMMENT 'The user who contacted with this email',
  `user_id` bigint unsigned DEFAULT NULL,
  `intelligence_domain_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(300) NOT NULL,
  `status` enum('not-checked','alive','dead') DEFAULT 'not-checked',
  `email_risk` mediumint DEFAULT NULL,
  `is_disposable_email` tinyint DEFAULT '0',
  `is_worker_running` tinyint DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `intelligence_email_addresses_email_uindex` (`email`),
  UNIQUE KEY `intelligence_email_addresses_user_email_index` (`mailbox_user_id`,`email`),
  UNIQUE KEY `intelligence_email_addresses_id_ref_unique` (`id_ref`),
  CONSTRAINT `intelligence_email_addresses_intelligence_user_id_foreign` FOREIGN KEY (`mailbox_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113446 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_intelligence_email_addresses` BEFORE INSERT ON `intelligence_email_addresses` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `intelligence_ip_routes`
--

DROP TABLE IF EXISTS `intelligence_ip_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_ip_routes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` varchar(36) DEFAULT NULL,
  `network` varchar(50) DEFAULT NULL,
  `owner` varchar(250) NOT NULL COMMENT 'Owner of the IP subnet',
  `as_value` varchar(250) NOT NULL COMMENT 'AS value of maintainer',
  `ip_start` bigint unsigned NOT NULL,
  `ip_end` bigint unsigned NOT NULL,
  `error` text,
  `is_worker_running` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `intelligence_ip_routes_id_ref_index` (`id_ref`),
  KEY `intelligence_ip_routes_max_index` (`ip_end`),
  KEY `intelligence_ip_routes_min_index` (`ip_start`)
) ENGINE=InnoDB AUTO_INCREMENT=463662 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_intelligence_ip_routes` BEFORE INSERT ON `intelligence_ip_routes` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `intelligence_ips`
--

DROP TABLE IF EXISTS `intelligence_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_ips` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` varchar(36) DEFAULT NULL,
  `intelligence_ip_route_id` bigint unsigned DEFAULT NULL,
  `ip_v4` varchar(15) NOT NULL,
  `int_representation` bigint unsigned NOT NULL,
  `is_worker_running` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `intelligence_ips_id_ref_index` (`id_ref`),
  KEY `intelligence_ips_intelligence_ip_route_id_foreign` (`intelligence_ip_route_id`),
  KEY `intelligence_ips_ip_v4_index` (`ip_v4`)
) ENGINE=InnoDB AUTO_INCREMENT=3674 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_intelligence_ips` BEFORE INSERT ON `intelligence_ips` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `intelligence_mailboxes`
--

DROP TABLE IF EXISTS `intelligence_mailboxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_mailboxes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `communication_mailbox_id` bigint unsigned DEFAULT NULL,
  `crawled_to_number` bigint NOT NULL DEFAULT '0' COMMENT 'message number',
  `last_email_number` bigint DEFAULT '0',
  `last_scan` timestamp NULL DEFAULT NULL,
  `crawl_error` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `intelligence_user_mailboxes_id_ref_unique` (`id_ref`),
  UNIQUE KEY `intelligence_mailboxes_mailbox_id_uindex` (`communication_mailbox_id`),
  KEY `intelligence_user_mailboxes_intelligence_user_id_foreign` (`user_id`),
  CONSTRAINT `intelligence_user_mailboxes_intelligence_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_intelligence_user_mailboxes` BEFORE INSERT ON `intelligence_mailboxes` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `intelligence_social_media`
--

DROP TABLE IF EXISTS `intelligence_social_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_social_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `intelligence_user_id` bigint unsigned NOT NULL,
  `social_media_facebook` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_linkedin` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_instagram` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_twitter` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_gitlab` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_github` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_stackoverflow` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_reddit` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_youtube` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_vk` varchar(200) NOT NULL COMMENT 'Facebook account',
  `social_media_weibo` varchar(200) NOT NULL COMMENT 'Facebook account',
  PRIMARY KEY (`id`),
  UNIQUE KEY `intelligence_social_media_id_ref_unique` (`id_ref`),
  KEY `intelligence_social_media_intelligence_user_id_foreign` (`intelligence_user_id`),
  CONSTRAINT `intelligence_social_media_intelligence_user_id_foreign` FOREIGN KEY (`intelligence_user_id`) REFERENCES `intelligence_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intelligence_user_domains`
--

DROP TABLE IF EXISTS `intelligence_user_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_user_domains` (
  `intelligence_domain_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  KEY `intelligence_user_domains_intelligence_domain_id_foreign` (`intelligence_domain_id`),
  KEY `intelligence_user_domains_intelligence_user_id_foreign` (`user_id`),
  CONSTRAINT `intelligence_user_domains_intelligence_domain_id_foreign` FOREIGN KEY (`intelligence_domain_id`) REFERENCES `intelligence_domains` (`id`),
  CONSTRAINT `intelligence_user_domains_intelligence_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intelligence_users`
--

DROP TABLE IF EXISTS `intelligence_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `intelligence_users_id_ref_unique` (`id_ref`),
  KEY `intelligence_users_user_id_foreign` (`user_id`),
  CONSTRAINT `intelligence_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intelligence_website_contents`
--

DROP TABLE IF EXISTS `intelligence_website_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_website_contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `intelligence_domain_id` bigint unsigned NOT NULL,
  `url` varchar(191) NOT NULL,
  `content` json DEFAULT NULL,
  `error` text,
  `is_worker_running` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `intelligence_website_contents_intelligence_domain_id_foreign` (`intelligence_domain_id`),
  CONSTRAINT `intelligence_website_contents_intelligence_domain_id_foreign` FOREIGN KEY (`intelligence_domain_id`) REFERENCES `intelligence_domains` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intelligence_websites`
--

DROP TABLE IF EXISTS `intelligence_websites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `intelligence_websites` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `intelligence_domain_id` bigint unsigned NOT NULL,
  `title` text NOT NULL,
  `error` text,
  `keywords` json NOT NULL,
  `description` json NOT NULL,
  `urls` json NOT NULL,
  `is_worker_running` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `intelligence_websites_intelligence_domain_id_foreign` (`intelligence_domain_id`),
  CONSTRAINT `intelligence_websites_intelligence_domain_id_foreign` FOREIGN KEY (`intelligence_domain_id`) REFERENCES `intelligence_domains` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` int unsigned DEFAULT NULL,
  `old_order_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `amount` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `vat` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `exchange_rate` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `currency_code` char(3) NOT NULL DEFAULT '',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `is_refund` tinyint(1) NOT NULL DEFAULT '0',
  `custom_invoice_number` varchar(10) DEFAULT NULL,
  `invoice_number` varchar(20) DEFAULT NULL,
  `parent_id` bigint DEFAULT NULL COMMENT 'Refund olduğunda bu alan ilişkili olduğu fatura id''sini tutar',
  `invoice_date` timestamp NULL DEFAULT NULL,
  `invoice_due_date` timestamp NULL DEFAULT NULL,
  `invoice_paid_date` timestamp NULL DEFAULT NULL,
  `note` text,
  `detailed_report` text,
  `gift_code_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoices_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=14327 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `invoices_overview`
--

DROP TABLE IF EXISTS `invoices_overview`;
/*!50001 DROP VIEW IF EXISTS `invoices_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `invoices_overview` AS SELECT 
 1 AS `invoice_id`,
 1 AS `invoice_id_ref`,
 1 AS `account_id`,
 1 AS `customer_id`,
 1 AS `account_id_ref`,
 1 AS `customer_id_ref`,
 1 AS `customer_name`,
 1 AS `amount`,
 1 AS `vat`,
 1 AS `currency_code`,
 1 AS `exchange_rate`,
 1 AS `is_paid`,
 1 AS `is_refund`,
 1 AS `note`,
 1 AS `custom_invoice_number`,
 1 AS `invoice_number`,
 1 AS `detailed_report`,
 1 AS `invoice_date`,
 1 AS `invoice_due_date`,
 1 AS `invoice_paid_date`,
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ip2location`
--

DROP TABLE IF EXISTS `ip2location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ip2location` (
  `ip_from` int unsigned DEFAULT NULL,
  `ip_to` int unsigned DEFAULT NULL,
  `country_code` char(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `country_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `region_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `city_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `zip_code` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  KEY `idx_ip_from` (`ip_from`),
  KEY `idx_ip_to` (`ip_to`),
  KEY `idx_ip_from_to` (`ip_from`,`ip_to`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_address_histories`
--

DROP TABLE IF EXISTS `ip_address_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ip_address_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip_address_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1432 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip_addresses`
--

DROP TABLE IF EXISTS `ip_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ip_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ip_addr` varchar(45) NOT NULL,
  `version` enum('v4','v6','mapped') NOT NULL,
  `is_reserved` tinyint(1) NOT NULL DEFAULT '0',
  `is_reachable` tinyint(1) NOT NULL DEFAULT '1',
  `is_public` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Eğer is_public true ise o zaman bu IP internete çıkabiliyor demektir.',
  `account_id` bigint unsigned NOT NULL,
  `network_id` int unsigned NOT NULL,
  `virtual_network_card_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_addresses_id_ref_unique` (`ip_addr`,`network_id`),
  UNIQUE KEY `id_ref` (`id_ref`),
  KEY `ip_addresses_account_id_foreign` (`account_id`),
  KEY `ip_addresses_network_id_foreign` (`network_id`),
  KEY `ip_addresses_virtual_network_card_id_foreign` (`virtual_network_card_id`),
  CONSTRAINT `ip_addresses_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ip_addresses_network_id_foreign` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ip_addresses_virtual_network_card_id_foreign` FOREIGN KEY (`virtual_network_card_id`) REFERENCES `virtual_network_cards` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1661 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_ip_addresses` BEFORE INSERT ON `ip_addresses` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `ip_addresses_overview`
--

DROP TABLE IF EXISTS `ip_addresses_overview`;
/*!50001 DROP VIEW IF EXISTS `ip_addresses_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ip_addresses_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `ip_addr`,
 1 AS `version`,
 1 AS `is_reserved`,
 1 AS `is_reachable`,
 1 AS `is_public`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_id_ref`,
 1 AS `datacenter_node_name`,
 1 AS `network_id`,
 1 AS `network_id_ref`,
 1 AS `network_name`,
 1 AS `network_vlan`,
 1 AS `network_ip_addr`,
 1 AS `network_ip_range_start`,
 1 AS `network_ip_range_end`,
 1 AS `network_gateway`,
 1 AS `network_subnet`,
 1 AS `network_netmask`,
 1 AS `network_network`,
 1 AS `network_dns_nameservers`,
 1 AS `network_mtu`,
 1 AS `vif_id`,
 1 AS `vif_id_ref`,
 1 AS `vif_name`,
 1 AS `vif_device_number`,
 1 AS `vif_mac_addr`,
 1 AS `vif_is_attached`,
 1 AS `vm_id`,
 1 AS `vm_id_ref`,
 1 AS `vm_name`,
 1 AS `vm_os`,
 1 AS `vm_distro`,
 1 AS `vm_version`,
 1 AS `vm_status`,
 1 AS `vm_total_cpu`,
 1 AS `vm_total_ram`,
 1 AS `vm_total_disk`,
 1 AS `vm_total_network`,
 1 AS `vm_actual_cpu`,
 1 AS `vm_actual_ram`,
 1 AS `vm_actual_disk`,
 1 AS `vm_actual_network`,
 1 AS `vm_domain_type`,
 1 AS `vm_is_template`,
 1 AS `vm_is_snapshot`,
 1 AS `vm_is_locked`,
 1 AS `vm_is_lost`,
 1 AS `account_id`,
 1 AS `account_id_ref`,
 1 AS `account_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `job_statuses`
--

DROP TABLE IF EXISTS `job_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_statuses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job_id` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `queue` varchar(255) DEFAULT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `progress_now` int NOT NULL DEFAULT '0',
  `progress_max` int NOT NULL DEFAULT '0',
  `status` varchar(16) NOT NULL DEFAULT 'queued',
  `input` longtext,
  `output` longtext,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `finished_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `job_statuses_job_id_index` (`job_id`),
  KEY `job_statuses_type_index` (`type`),
  KEY `job_statuses_queue_index` (`queue`),
  KEY `job_statuses_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved` tinyint unsigned DEFAULT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_reserved_reserved_at_index` (`queue`,`reserved`,`reserved_at`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs_ph4`
--

DROP TABLE IF EXISTS `jobs_ph4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs_ph4` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  `version` int unsigned NOT NULL DEFAULT '0',
  `delete_mark` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `jobs_ph4_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=7035021 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_admin_nodes`
--

DROP TABLE IF EXISTS `kubernetes_admin_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kubernetes_admin_nodes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `node_version` varchar(250) DEFAULT NULL,
  `running_pod_count` int unsigned NOT NULL DEFAULT '0',
  `admin_configuration` text COMMENT 'Stores admin configuration',
  `type` enum('plusclouds-kubespray') NOT NULL DEFAULT 'plusclouds-kubespray',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kubernetes_admin_nodes_id_ref_unique` (`id_ref`),
  KEY `kubernetes_admin_nodes_account_id_foreign` (`account_id`),
  KEY `kubernetes_admin_nodes_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `kubernetes_admin_nodes_kubernetes_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `kubernetes_admin_nodes_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `kubernetes_admin_nodes_kubernetes_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `kubernetes_clusters` (`id`),
  CONSTRAINT `kubernetes_admin_nodes_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_clusters`
--

DROP TABLE IF EXISTS `kubernetes_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kubernetes_clusters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `node_version` varchar(250) DEFAULT NULL,
  `dashboard_url` varchar(1000) DEFAULT NULL,
  `total_ram` bigint unsigned NOT NULL DEFAULT '0',
  `total_cpu` bigint unsigned NOT NULL DEFAULT '0',
  `running_pod_count` int unsigned NOT NULL DEFAULT '0',
  `pod_count` int unsigned NOT NULL DEFAULT '0',
  `worker_count` int unsigned NOT NULL DEFAULT '0',
  `admin_count` int unsigned NOT NULL DEFAULT '0',
  `master_count` int unsigned NOT NULL DEFAULT '0',
  `cluster_configuration` text COMMENT 'Stores cluster configuration',
  `kubectl_yaml` text COMMENT 'Stores cluster configuration',
  `is_helm_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `is_dashboard_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `is_cert_manager_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_ingress_nginx_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_metrics_server_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_cluster_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_monitored_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_dns_cache_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_network_visible` tinyint(1) NOT NULL DEFAULT '0',
  `version` varchar(20) NOT NULL DEFAULT '0',
  `type` enum('plusclouds-kubespray') NOT NULL DEFAULT 'plusclouds-kubespray',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kubernetes_clusters_id_ref_unique` (`id_ref`),
  KEY `kubernetes_clusters_account_id_foreign` (`account_id`),
  CONSTRAINT `kubernetes_clusters_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_ingress`
--

DROP TABLE IF EXISTS `kubernetes_ingress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kubernetes_ingress` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `ingress_configuration` text COMMENT 'Stores ingress configuration',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `version` varchar(20) NOT NULL DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kubernetes_ingress_id_ref_unique` (`id_ref`),
  KEY `kubernetes_ingress_account_id_foreign` (`account_id`),
  KEY `kubernetes_ingress_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `kubernetes_ingress_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `kubernetes_ingress_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `kubernetes_ingress_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `kubernetes_clusters` (`id`),
  CONSTRAINT `kubernetes_ingress_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_master_nodes`
--

DROP TABLE IF EXISTS `kubernetes_master_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kubernetes_master_nodes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `node_version` varchar(250) DEFAULT NULL,
  `running_pod_count` int unsigned NOT NULL DEFAULT '0',
  `master_configuration` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'Stores worker configuration',
  `type` enum('plusclouds-kubespray') NOT NULL DEFAULT 'plusclouds-kubespray',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kubernetes_master_nodes_id_ref_unique` (`id_ref`),
  KEY `kubernetes_master_nodes_account_id_foreign` (`account_id`),
  KEY `kubernetes_master_nodes_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `kubernetes_master_nodes_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `kubernetes_master_nodes_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `kubernetes_master_nodes_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `kubernetes_clusters` (`id`),
  CONSTRAINT `kubernetes_master_nodes_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kubernetes_worker_nodes`
--

DROP TABLE IF EXISTS `kubernetes_worker_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kubernetes_worker_nodes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `node_version` varchar(250) DEFAULT NULL,
  `running_pod_count` int unsigned NOT NULL DEFAULT '0',
  `worker_configuration` text COMMENT 'Stores worker configuration',
  `type` enum('plusclouds-kubespray') NOT NULL DEFAULT 'plusclouds-kubespray',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `account_id` bigint unsigned NOT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kubernetes_worker_nodes_id_ref_unique` (`id_ref`),
  KEY `kubernetes_worker_nodes_account_id_foreign` (`account_id`),
  KEY `kubernetes_worker_nodes_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `kubernetes_worker_nodes_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `kubernetes_worker_nodes_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `kubernetes_worker_nodes_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `kubernetes_clusters` (`id`),
  CONSTRAINT `kubernetes_worker_nodes_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `code` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `languages_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lead_lists`
--

DROP TABLE IF EXISTS `lead_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_lists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'List owner account id. Global if NULL',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'List owner user id. Global if NULL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_shared` tinyint DEFAULT '0',
  `list_type` enum('general','floating','custom','intelligence','churn') DEFAULT 'general',
  `is_default` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lead_lists_id_ref_unique` (`id_ref`),
  KEY `lead_lists_account_id_foreign` (`account_id`),
  CONSTRAINT `lead_lists_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_lead_lists` BEFORE INSERT ON `lead_lists` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `leads`
--

DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lead_list_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `contact_id` bigint unsigned DEFAULT NULL COMMENT 'If null, is not related with any contact',
  `lead_assigned_id` bigint unsigned DEFAULT NULL,
  `organization_id` bigint unsigned DEFAULT NULL,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `surname` varchar(500) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `company` varchar(150) DEFAULT NULL,
  `position` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `extension` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `is_callable` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Müşteri aranabilir mi?',
  `gender` enum('male','female') DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `country_id` int unsigned DEFAULT NULL,
  `lead_quality` int unsigned NOT NULL DEFAULT '0',
  `mautic_user_id` bigint unsigned DEFAULT '0',
  `mautic_company_id` bigint unsigned DEFAULT '0',
  `lead_source` enum('sales','marketing','robot','website','other') DEFAULT NULL,
  `state` enum('created','contacted','nurturing','unqualified','converted') DEFAULT 'created',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_marketing_qualified` tinyint DEFAULT '0',
  `is_sales_qualified` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `leads_id_ref_unique` (`id_ref`),
  KEY `leads_lead_list_id_foreign` (`lead_list_id`),
  CONSTRAINT `leads_lead_list_id_foreign` FOREIGN KEY (`lead_list_id`) REFERENCES `lead_lists` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9236 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `marketing_campaign_contacts`
--

DROP TABLE IF EXISTS `marketing_campaign_contacts`;
/*!50001 DROP VIEW IF EXISTS `marketing_campaign_contacts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `marketing_campaign_contacts` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `surname`,
 1 AS `fullname`,
 1 AS `email`,
 1 AS `cellphone`,
 1 AS `workphone`,
 1 AS `campaign_id`,
 1 AS `campaign_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `marketing_campaign_marketing_lists`
--

DROP TABLE IF EXISTS `marketing_campaign_marketing_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketing_campaign_marketing_lists` (
  `mc_id` bigint unsigned NOT NULL COMMENT 'marketing_campaing_id',
  `ml_id` bigint unsigned NOT NULL COMMENT 'marketing_list_id',
  PRIMARY KEY (`mc_id`,`ml_id`),
  KEY `campaign_marketing_lists_ml_id_foreign` (`ml_id`),
  CONSTRAINT `campaign_marketing_lists_mc_id_foreign` FOREIGN KEY (`mc_id`) REFERENCES `marketing_campaigns` (`id`),
  CONSTRAINT `campaign_marketing_lists_ml_id_foreign` FOREIGN KEY (`ml_id`) REFERENCES `marketing_lists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marketing_campaign_notification_messages`
--

DROP TABLE IF EXISTS `marketing_campaign_notification_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketing_campaign_notification_messages` (
  `marketing_campaign_id` bigint unsigned DEFAULT NULL,
  `notification_message_id` bigint unsigned DEFAULT NULL,
  KEY `marketing_campaign_notification_messages_mc_fk` (`marketing_campaign_id`),
  KEY `marketing_campaign_notification_messages_cm_fk` (`notification_message_id`),
  CONSTRAINT `marketing_campaign_notification_messages_cm_fk` FOREIGN KEY (`notification_message_id`) REFERENCES `communication_notification_messages` (`id`),
  CONSTRAINT `marketing_campaign_notification_messages_mc_fk` FOREIGN KEY (`marketing_campaign_id`) REFERENCES `marketing_campaigns` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marketing_campaigns`
--

DROP TABLE IF EXISTS `marketing_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketing_campaigns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `cost` double NOT NULL DEFAULT '0',
  `budget` double DEFAULT NULL,
  `start` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marketing_campaigns_id_ref_unique` (`id_ref`),
  KEY `marketing_campaigns_account_id_foreign` (`account_id`),
  KEY `marketing_campaigns_user_id_foreign` (`user_id`),
  CONSTRAINT `marketing_campaigns_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `marketing_campaigns_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_marketing_campaigns` BEFORE INSERT ON `marketing_campaigns` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `marketing_lists`
--

DROP TABLE IF EXISTS `marketing_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketing_lists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'If NULL lead is global, can be acquired',
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `is_system_list` tinyint(1) NOT NULL DEFAULT '0',
  `object_type` varchar(1000) DEFAULT NULL,
  `object_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `marketing_lists_id_ref_unique` (`id_ref`),
  KEY `marketing_lists_account_id_foreign` (`account_id`),
  KEY `marketing_lists_user_id_foreign` (`user_id`),
  CONSTRAINT `marketing_lists_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `marketing_lists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=528 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_marketing_lists` BEFORE INSERT ON `marketing_lists` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `marketing_lists_contacts`
--

DROP TABLE IF EXISTS `marketing_lists_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketing_lists_contacts` (
  `ml_id` bigint unsigned NOT NULL,
  `contact_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`ml_id`,`contact_id`),
  KEY `marketing_lists_users_user_id_foreign` (`contact_id`),
  CONSTRAINT `marketing_lists_contacts_fk` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`),
  CONSTRAINT `marketing_lists_users_ml_id_foreign` FOREIGN KEY (`ml_id`) REFERENCES `marketing_lists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `model_id` int unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `size` int unsigned NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `order_column` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_brokers`
--

DROP TABLE IF EXISTS `message_brokers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_brokers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(32) COLLATE utf8_bin NOT NULL,
  `name` char(64) COLLATE utf8_bin NOT NULL,
  `type` enum('rabbitmq') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'rabbitmq',
  `virtual_machine_id` bigint unsigned NOT NULL,
  `ip_addr` char(32) COLLATE utf8_bin NOT NULL,
  `port` char(4) COLLATE utf8_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`semihyonet`@`%`*/ /*!50003 TRIGGER `before_insert_message_brookers` BEFORE INSERT ON `message_brokers` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `message_queues`
--

DROP TABLE IF EXISTS `message_queues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_queues` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `name` varchar(250) NOT NULL,
  `type` enum('kafka','activemq','rabbitmq') NOT NULL DEFAULT 'kafka',
  `queue_version` varchar(250) NOT NULL DEFAULT '1',
  `queue_count` int unsigned NOT NULL DEFAULT '0',
  `queue_configuration` json DEFAULT NULL COMMENT 'Stores queue configuration',
  `connection_ip` varchar(50) DEFAULT NULL,
  `connection_port` int unsigned DEFAULT NULL,
  `is_awaiting_commit` tinyint(1) NOT NULL DEFAULT '0',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `message_queues_id_ref_unique` (`id_ref`),
  KEY `message_queues_account_id_foreign` (`account_id`),
  KEY `message_queues_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `message_queues_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `message_queues_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`),
  CONSTRAINT `message_queues_chk_1` CHECK (((`queue_configuration` is null) or json_valid(`queue_configuration`)))
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meta`
--

DROP TABLE IF EXISTS `meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `metable_id` int NOT NULL,
  `metable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `meta_metable_id_metable_type_key_unique` (`metable_id`,`metable_type`,`key`),
  KEY `meta_metable_id_index` (`metable_id`),
  KEY `meta_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=34349 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `migration` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nat_records`
--

DROP TABLE IF EXISTS `nat_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nat_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL,
  `incoming_port` int NOT NULL,
  `outgoing_ip` varchar(15) NOT NULL,
  `outgoing_port` int NOT NULL,
  `nat_servers_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'List owner account id. Global if NULL',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'List owner user id. Global if NULL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nat_records_id_ref_unique` (`id_ref`),
  KEY `nat_records_nat_server_id_foreign` (`nat_servers_id`),
  KEY `nat_records_account_id_foreign` (`account_id`),
  KEY `nat_records_user_id_foreign` (`user_id`),
  CONSTRAINT `nat_records_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `nat_records_nat_server_id_foreign` FOREIGN KEY (`nat_servers_id`) REFERENCES `nat_servers` (`id`),
  CONSTRAINT `nat_records_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nat_servers`
--

DROP TABLE IF EXISTS `nat_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nat_servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `credentials` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `is_public` tinyint unsigned DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'List owner account id. Global if NULL',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'List owner user id. Global if NULL',
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nat_servers_id_ref_unique` (`id_ref`),
  KEY `nat_servers_account_id_foreign` (`account_id`),
  KEY `nat_servers_user_id_foreign` (`user_id`),
  KEY `nat_servers_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `nat_servers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `nat_servers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `nat_servers_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `netgateway_loadbalancer_domains`
--

DROP TABLE IF EXISTS `netgateway_loadbalancer_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `netgateway_loadbalancer_domains` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `domain_id` bigint unsigned NOT NULL,
  `nodes` json NOT NULL,
  `balancing_method` enum('least_conn') COLLATE utf8_bin NOT NULL DEFAULT 'least_conn',
  `netgateway_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_bin */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`semihyonet`@`%`*/ /*!50003 TRIGGER `before_insert_netgateway_loadbalancer_domains` BEFORE INSERT ON `netgateway_loadbalancer_domains` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `netgateways`
--

DROP TABLE IF EXISTS `netgateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `netgateways` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `public_ip_address_id` bigint unsigned DEFAULT NULL,
  `proxy_configuration` json DEFAULT NULL COMMENT 'Stores proxy configuration',
  `nat_configuration` json DEFAULT NULL COMMENT 'Stores nat configuration',
  `firewall_configuration` json DEFAULT NULL COMMENT 'Stores fw configuration',
  `load_balancer_configuration` json DEFAULT NULL COMMENT 'Stores LB configuration',
  `vpn_configuration` json DEFAULT NULL COMMENT 'Stores vpn configuration',
  `vpn_client_configurations` json DEFAULT NULL,
  `network_configuration` json DEFAULT NULL COMMENT 'Stores network configuration',
  `rsyslog_configuration` json DEFAULT NULL COMMENT 'Stores rsyslog configuration',
  `ntp_configuration` json DEFAULT NULL,
  `vpn_certificate_id` int DEFAULT NULL,
  `is_dhcp_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_proxy_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_nat_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_firewall_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_load_balancer_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_vpn_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_rsyslog_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_ntp_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `type` enum('plusclouds-netgateway','juniper-srx') NOT NULL DEFAULT 'plusclouds-netgateway',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `is_connection_secure` tinyint(1) NOT NULL DEFAULT '0',
  `is_usable` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `netgateways_id_ref_unique` (`id_ref`),
  KEY `netgateways_account_id_foreign` (`account_id`),
  KEY `netgateways_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `netgateways_ip_address_fk` (`public_ip_address_id`),
  CONSTRAINT `netgateways_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `netgateways_ip_address_fk` FOREIGN KEY (`public_ip_address_id`) REFERENCES `ip_addresses` (`id`),
  CONSTRAINT `netgateways_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`),
  CONSTRAINT `netgateways_chk_1` CHECK (((`proxy_configuration` is null) or json_valid(`proxy_configuration`))),
  CONSTRAINT `netgateways_chk_2` CHECK (((`nat_configuration` is null) or json_valid(`nat_configuration`))),
  CONSTRAINT `netgateways_chk_3` CHECK (((`firewall_configuration` is null) or json_valid(`firewall_configuration`))),
  CONSTRAINT `netgateways_chk_4` CHECK (((`load_balancer_configuration` is null) or json_valid(`load_balancer_configuration`))),
  CONSTRAINT `netgateways_chk_5` CHECK (((`vpn_configuration` is null) or json_valid(`vpn_configuration`))),
  CONSTRAINT `netgateways_chk_6` CHECK (((`network_configuration` is null) or json_valid(`network_configuration`))),
  CONSTRAINT `netgateways_chk_7` CHECK (((`rsyslog_configuration` is null) or json_valid(`rsyslog_configuration`)))
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `netgateways_overview`
--

DROP TABLE IF EXISTS `netgateways_overview`;
/*!50001 DROP VIEW IF EXISTS `netgateways_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `netgateways_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `managed_network`,
 1 AS `type`,
 1 AS `account_id`,
 1 AS `account_id_ref`,
 1 AS `virtual_machine_id`,
 1 AS `virtual_machine_id_ref`,
 1 AS `is_locked`,
 1 AS `status`,
 1 AS `is_connected`,
 1 AS `is_usable`,
 1 AS `is_connection_secure`,
 1 AS `ip_addr`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `network_histories`
--

DROP TABLE IF EXISTS `network_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `network_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `network_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=740 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `network_pool_histories`
--

DROP TABLE IF EXISTS `network_pool_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `network_pool_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `network_pool_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `network_pools`
--

DROP TABLE IF EXISTS `network_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `network_pools` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ip_addr` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `management_url` varchar(2083) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `port` smallint unsigned DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `management_type` enum('api','ssh') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ssh',
  `interroutable_vlan_start` int unsigned NOT NULL DEFAULT '1000',
  `interroutable_vlan_end` int unsigned NOT NULL DEFAULT '4000',
  `interroutable_vxlan_start` int unsigned NOT NULL DEFAULT '1000',
  `interroutable_vxlan_end` int unsigned NOT NULL DEFAULT '65000',
  `has_vlan_support` tinyint(1) NOT NULL DEFAULT '1',
  `has_vxlan_support` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `datacenter_id` int unsigned DEFAULT NULL,
  `vendor_id` bigint unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `provisioning_alg` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `management_package_name` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `resource_validator` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_pools_id_ref_unique` (`id_ref`),
  KEY `network_pools_vendor_id_foreign` (`vendor_id`),
  KEY `network_pools_datacenter_id_foreign` (`datacenter_id`),
  KEY `network_pools_product_id_foreign` (`product_id`),
  CONSTRAINT `network_pools_datacenter_id_foreign` FOREIGN KEY (`datacenter_id`) REFERENCES `datacenters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `network_pools_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `network_pools_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `accounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `networks` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `uuid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vlan` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pergb_price` decimal(13,8) NOT NULL DEFAULT '0.00000000',
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bandwidth` int DEFAULT '0',
  `network_type` enum('public','private','vpn','core','management','storage') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'private',
  `ip_addr` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_range_start` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_range_end` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gateway` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `subnet` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `netmask` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `network` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dns_nameservers` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `mtu` int NOT NULL DEFAULT '0',
  `local_domain` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_bridge` tinyint(1) NOT NULL DEFAULT '0',
  `is_virtual_network` tinyint(1) NOT NULL DEFAULT '0',
  `is_interroutable` tinyint(1) NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `is_default_pif` tinyint(1) NOT NULL DEFAULT '0',
  `is_master_record` tinyint(1) NOT NULL DEFAULT '0',
  `network_pool_id` int unsigned DEFAULT NULL,
  `dhcp_server_id` bigint unsigned DEFAULT NULL,
  `dns_service_id` bigint unsigned DEFAULT NULL,
  `proxy_server_id` bigint unsigned DEFAULT NULL,
  `nat_server_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `domain_id` bigint unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `networks_id_ref_unique` (`id_ref`),
  KEY `networks_network_pool_id_foreign` (`network_pool_id`),
  KEY `networks_dhcp_server_id_foreign` (`dhcp_server_id`),
  KEY `networks_domain_id_foreign` (`domain_id`),
  KEY `networks_dns_service_id_foreign` (`dns_service_id`),
  KEY `networks_proxy_server_id_foreign` (`proxy_server_id`),
  KEY `networks_nat_server_id_foreign` (`nat_server_id`),
  KEY `networks_products_id_foreign` (`product_id`),
  CONSTRAINT `networks_dhcp_server_id_foreign` FOREIGN KEY (`dhcp_server_id`) REFERENCES `dhcp_servers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `networks_dns_service_id_foreign` FOREIGN KEY (`dns_service_id`) REFERENCES `dns_services` (`id`) ON DELETE SET NULL,
  CONSTRAINT `networks_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networks_nat_server_id_foreign` FOREIGN KEY (`nat_server_id`) REFERENCES `nat_servers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `networks_network_pool_id_foreign` FOREIGN KEY (`network_pool_id`) REFERENCES `network_pools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networks_products_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `networks_proxy_server_id_foreign` FOREIGN KEY (`proxy_server_id`) REFERENCES `proxy_servers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_networks` BEFORE INSERT ON `networks` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `networks_overview`
--

DROP TABLE IF EXISTS `networks_overview`;
/*!50001 DROP VIEW IF EXISTS `networks_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `networks_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `vlan`,
 1 AS `mtu`,
 1 AS `network_type`,
 1 AS `ip_addr`,
 1 AS `ip_range_start`,
 1 AS `ip_range_end`,
 1 AS `gateway`,
 1 AS `subnet`,
 1 AS `netmask`,
 1 AS `network`,
 1 AS `dns_nameservers`,
 1 AS `local_domain`,
 1 AS `is_bridge`,
 1 AS `is_virtual_network`,
 1 AS `is_interroutable`,
 1 AS `is_default_pif`,
 1 AS `is_master_record`,
 1 AS `is_visible`,
 1 AS `network_pool_id`,
 1 AS `network_pool_id_ref`,
 1 AS `network_pool_name`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_id_ref`,
 1 AS `datacenter_node_name`,
 1 AS `dhcp_server_id`,
 1 AS `dhcp_server_id_ref`,
 1 AS `dhcp_server_name`,
 1 AS `proxy_server_id`,
 1 AS `proxy_server_id_ref`,
 1 AS `proxy_server_name`,
 1 AS `nat_server_id`,
 1 AS `nat_server_id_ref`,
 1 AS `nat_server_name`,
 1 AS `domain_id`,
 1 AS `domain_id_ref`,
 1 AS `domain_name`,
 1 AS `account_id`,
 1 AS `account_id_ref`,
 1 AS `account_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_id` int unsigned NOT NULL,
  `notifiable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `data` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` int DEFAULT NULL,
  `client_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  `client_id` int NOT NULL,
  `scopes` text,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) NOT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `old_products`
--

DROP TABLE IF EXISTS `old_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `old_products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `old_product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `one_time_passwords`
--

DROP TABLE IF EXISTS `one_time_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `one_time_passwords` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `access_token_id` varchar(100) DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `one_time_passwords_user_id_foreign` (`user_id`),
  CONSTRAINT `one_time_passwords_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opportunities`
--

DROP TABLE IF EXISTS `opportunities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned DEFAULT NULL,
  `lead_id` bigint unsigned DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `responsible_user_id` bigint unsigned DEFAULT NULL COMMENT 'User who is responsible from the opportunity',
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `stage` enum('P','Q','NA','VP','IDM','PQ','NR','CW','CL') NOT NULL DEFAULT 'P',
  `probability` tinyint unsigned NOT NULL COMMENT 'işin olma olasılığı',
  `reason` varchar(255) DEFAULT NULL,
  `source` varchar(500) DEFAULT NULL COMMENT 'Source of the opportunity',
  `income` decimal(13,4) NOT NULL,
  `deadline` date DEFAULT NULL,
  `next_action_date` date DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `next_action` varchar(100) DEFAULT NULL,
  `country_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `opportunities_id_ref_unique` (`id_ref`),
  KEY `opportunities_account_id_foreign` (`account_id`),
  KEY `opportunities_responsible_user_id_foreign` (`responsible_user_id`),
  CONSTRAINT `opportunities_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `opportunities_responsible_user_id_foreign` FOREIGN KEY (`responsible_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `description` text,
  `domain` varchar(100) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `website` varchar(150) DEFAULT NULL,
  `phone_code` varchar(5) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `risk_level` tinyint unsigned DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country_id` int unsigned DEFAULT NULL,
  `lead_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `representative_account_id` bigint unsigned NOT NULL,
  `representative_user_id` bigint unsigned NOT NULL,
  `industry_id` bigint unsigned DEFAULT NULL,
  `organization_type` enum('personal','limited','anonymous','other') DEFAULT NULL,
  `tax_office` varchar(100) DEFAULT NULL,
  `tax_number` varchar(100) DEFAULT NULL,
  `linkedin` varchar(200) DEFAULT NULL,
  `facebook` varchar(200) DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `github` varchar(200) DEFAULT NULL,
  `gitlab` varchar(200) DEFAULT NULL,
  `accounting_id` varchar(50) DEFAULT NULL,
  `segment_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm_organizations_id_ref_unique` (`id_ref`),
  KEY `organizations_industries_fk` (`industry_id`),
  KEY `organizations_account_fk` (`account_id`),
  KEY `organizations_lead_fk` (`lead_id`),
  KEY `organizations_country_fk` (`country_id`),
  KEY `organizations_representative_account_fk` (`representative_account_id`),
  KEY `organizations_representative_user_fk` (`representative_user_id`),
  CONSTRAINT `organizations_account_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `organizations_country_fk` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `organizations_industries_fk` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`id`),
  CONSTRAINT `organizations_lead_fk` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  CONSTRAINT `organizations_representative_account_fk` FOREIGN KEY (`representative_account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `organizations_representative_user_fk` FOREIGN KEY (`representative_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4345 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_crm_organizations` BEFORE INSERT ON `organizations` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `partners_teknosa_customers`
--

DROP TABLE IF EXISTS `partners_teknosa_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partners_teknosa_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'List owner account id. Global if NULL',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'List owner user id. Global if NULL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `partners_teknosa_customers_account_id_foreign` (`account_id`),
  KEY `partners_teknosa_customers_user_id_foreign` (`user_id`),
  CONSTRAINT `partners_teknosa_customers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `partners_teknosa_customers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partners_teknosacell_customers`
--

DROP TABLE IF EXISTS `partners_teknosacell_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partners_teknosacell_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'List owner user id. Global if NULL',
  `tariff_id` int unsigned NOT NULL DEFAULT '0',
  `tariff_name` varchar(300) DEFAULT NULL,
  `service_id` int unsigned NOT NULL DEFAULT '0',
  `service_name` varchar(500) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `partners_teknosacell_customers_user_id_foreign` (`user_id`),
  KEY `partners_teknosacell_customers_account_id_foreign` (`account_id`),
  CONSTRAINT `partners_teknosacell_customers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_role` (
  `permission_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(8) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `prefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_prefix_name_unique` (`prefix`,`name`),
  UNIQUE KEY `permissions_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=604 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_catalog_translations`
--

DROP TABLE IF EXISTS `product_catalog_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_catalog_translations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(500) NOT NULL,
  `locale` char(2) NOT NULL DEFAULT 'tr',
  `catalog_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_catalog_translations_catalog_id_locale_unique` (`catalog_id`,`locale`),
  KEY `product_catalog_translations_locale_index` (`locale`),
  CONSTRAINT `product_catalog_translations_catalog_id_foreign` FOREIGN KEY (`catalog_id`) REFERENCES `product_catalogs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_catalogs`
--

DROP TABLE IF EXISTS `product_catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_catalogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `agreement` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `args` text,
  `price` decimal(20,8) NOT NULL,
  `currency_code` char(3) NOT NULL,
  `country_code` varchar(3) NOT NULL DEFAULT 'TR',
  `subscription_type` enum('hourly','daily','monthly','yearly','2yearly','3yearly','4yearly','5yearly','once') NOT NULL DEFAULT 'hourly',
  `trial_period` tinyint unsigned DEFAULT NULL,
  `trial_period_type` enum('hour','week','month','year') DEFAULT NULL,
  `position` int unsigned NOT NULL DEFAULT '0',
  `product_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_catalogs_id_ref_unique` (`id_ref`),
  KEY `product_catalogs_product_id_foreign` (`product_id`),
  CONSTRAINT `product_catalogs_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_subscriptions`
--

DROP TABLE IF EXISTS `product_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `subscription_count` int unsigned NOT NULL COMMENT 'How many items did the customer subscribed.',
  `subscription_price` decimal(13,4) NOT NULL COMMENT 'Price that was valid while the customer is subscribed',
  `currency_code` char(3) NOT NULL,
  `subscription_type` enum('hourly','monthly','yearly','once') NOT NULL DEFAULT 'hourly',
  `is_renewable` tinyint(1) NOT NULL DEFAULT '0',
  `trial_ends` timestamp NULL DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `product_id` int unsigned NOT NULL,
  `product_catalog_id` bigint unsigned NOT NULL,
  `gift_code_id` bigint unsigned DEFAULT NULL,
  `status` enum('active','pending_payment','cancelled','passive') DEFAULT 'pending_payment',
  `subscription_terms` json DEFAULT NULL,
  `subscription_ends` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_subscriptions_id_ref_unique` (`id_ref`),
  KEY `product_subscriptions_account_id_foreign` (`account_id`),
  KEY `product_subscriptions_product_id_foreign` (`product_id`),
  KEY `product_subscriptions_product_catalog_id_foreign` (`product_catalog_id`),
  KEY `product_subscriptions_users_fk` (`user_id`),
  CONSTRAINT `product_subscriptions_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_subscriptions_product_catalog_id_foreign` FOREIGN KEY (`product_catalog_id`) REFERENCES `product_catalogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_subscriptions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_subscriptions_users_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_translations`
--

DROP TABLE IF EXISTS `product_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_translations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `highlights` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `after_sales_introduction` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `support_content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `refund_policy` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `eula` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `locale` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'tr',
  `country_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_translations_product_id_locale_unique` (`product_id`,`locale`),
  KEY `product_translations_locale_index` (`locale`),
  CONSTRAINT `product_translations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_product_translations` BEFORE INSERT ON `product_translations` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product_types`
--

DROP TABLE IF EXISTS `product_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_types_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(13,8) NOT NULL,
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `subscription_type` enum('hourly','monthly','yearly','once') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `args` text COLLATE utf8_unicode_ci,
  `price_calculator` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `has_campaign` tinyint DEFAULT '0',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `is_invisible` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `trial_period` tinyint unsigned DEFAULT NULL,
  `trial_period_type` enum('hour','week','month','year') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int unsigned NOT NULL DEFAULT '0',
  `category_id` bigint unsigned NOT NULL,
  `product_type_id` int unsigned NOT NULL,
  `vendor_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_id_ref_unique` (`id_ref`),
  KEY `products_product_type_id_index` (`product_type_id`),
  KEY `products_category_id_foreign` (`category_id`),
  KEY `products_vendor_id_foreign` (`vendor_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_product_type_id_foreign` FOREIGN KEY (`product_type_id`) REFERENCES `product_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile_change_requests`
--

DROP TABLE IF EXISTS `profile_change_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_change_requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL COMMENT 'Which account openned this request?',
  `user_id` bigint unsigned NOT NULL COMMENT 'Which user openned this request?',
  `for_account_id` bigint unsigned NOT NULL COMMENT 'ID of account for the related request',
  `for_user_id` bigint unsigned DEFAULT NULL COMMENT 'ID of user for the related request',
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reason` text NOT NULL,
  `status` enum('approved','denied','pending') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_change_requests_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_users`
--

DROP TABLE IF EXISTS `project_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_users` (
  `project_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  UNIQUE KEY `project_users_project_id_user_id_account_id_unique` (`project_id`,`user_id`,`account_id`),
  UNIQUE KEY `project_users_unique` (`project_id`,`user_id`,`account_id`),
  KEY `project_users_user_id_foreign` (`user_id`),
  KEY `project_users_account_id_foreign` (`account_id`),
  CONSTRAINT `project_users_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_users_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'project owner',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'project user',
  `customer_id` bigint unsigned DEFAULT NULL COMMENT 'ID of customer',
  `lead_id` bigint unsigned DEFAULT NULL COMMENT 'ID of lead',
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `namespace` varchar(500) DEFAULT NULL,
  `namespace_url` varchar(500) DEFAULT NULL,
  `description` varchar(2000) NOT NULL,
  `type` enum('iaas','devops','software','mixed','quotation') DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `status` enum('open','in-progress','waiting-feedback','on-hold','completed','delivered','archived') DEFAULT NULL,
  `priority` enum('low','medium','high') NOT NULL,
  `is_knowledgebase` tinyint DEFAULT '0',
  `gitlab_id` bigint unsigned DEFAULT NULL,
  `gitlab_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `projects_id_ref_unique` (`id_ref`),
  KEY `projects_account_id_foreign` (`account_id`),
  KEY `projects_user_id_foreign` (`user_id`),
  KEY `projects_customer_id_foreign` (`customer_id`),
  KEY `projects_lead_id_foreign` (`lead_id`),
  CONSTRAINT `projects_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `projects_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `projects_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`),
  CONSTRAINT `projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1163 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_create_project` BEFORE INSERT ON `projects` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `projects_overview`
--

DROP TABLE IF EXISTS `projects_overview`;
/*!50001 DROP VIEW IF EXISTS `projects_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `projects_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `description`,
 1 AS `start`,
 1 AS `end`,
 1 AS `status`,
 1 AS `gitlab_url`,
 1 AS `priority`,
 1 AS `type`,
 1 AS `account_name`,
 1 AS `customer_name`,
 1 AS `leads_name`,
 1 AS `created_by`,
 1 AS `user_id`,
 1 AS `user_id_ref`,
 1 AS `customer_id`,
 1 AS `customer_id_ref`,
 1 AS `lead_id`,
 1 AS `lead_id_ref`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `proxy_records`
--

DROP TABLE IF EXISTS `proxy_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL,
  `domain` varchar(200) NOT NULL,
  `ip` varchar(15) NOT NULL,
  `port` int NOT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'List owner account id. Global if NULL',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'List owner user id. Global if NULL',
  `proxy_servers_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proxy_records_id_ref_unique` (`id_ref`),
  KEY `proxy_records_account_id_foreign` (`account_id`),
  KEY `proxy_records_user_id_foreign` (`user_id`),
  KEY `proxy_records_proxy_server_id_foreign` (`proxy_servers_id`),
  CONSTRAINT `proxy_records_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `proxy_records_proxy_server_id_foreign` FOREIGN KEY (`proxy_servers_id`) REFERENCES `proxy_servers` (`id`),
  CONSTRAINT `proxy_records_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proxy_servers`
--

DROP TABLE IF EXISTS `proxy_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proxy_servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `howto` text,
  `credentials` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `type` enum('nginx','openresty') DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `port` varchar(5) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'List owner account id. Global if NULL',
  `user_id` bigint unsigned DEFAULT NULL COMMENT 'List owner user id. Global if NULL',
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proxy_servers_id_ref_unique` (`id_ref`),
  KEY `proxy_servers_account_id_foreign` (`account_id`),
  KEY `proxy_servers_user_id_foreign` (`user_id`),
  KEY `proxy_servers_virtual_machine_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `proxy_servers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `proxy_servers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `proxy_servers_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quote_iaas_resource_lines`
--

DROP TABLE IF EXISTS `quote_iaas_resource_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quote_iaas_resource_lines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `quote_id` bigint unsigned NOT NULL COMMENT 'Teklif IDsi',
  `product_id` int unsigned DEFAULT NULL COMMENT 'Ürün IDsi',
  `datacenter_node_id` int unsigned DEFAULT NULL COMMENT 'Datacenter Node ID',
  `compute_pool_id` int unsigned DEFAULT NULL COMMENT 'Compute Pool ID',
  `storage_pool_id` int unsigned DEFAULT NULL COMMENT 'Storage Pool ID',
  `network_pool_id` int unsigned DEFAULT NULL COMMENT 'Network Pool ID',
  `network_id` int unsigned DEFAULT NULL COMMENT 'Network ID',
  `cpu` int unsigned DEFAULT NULL COMMENT 'Toplam CPU miktarı',
  `ram` int unsigned DEFAULT NULL COMMENT 'Toplam RAM miktarı',
  `harddisk` int unsigned DEFAULT NULL COMMENT 'Toplam CPU sayısı',
  `network_ip` int unsigned DEFAULT NULL COMMENT 'Toplam CPU sayısı',
  `network_bw` int unsigned DEFAULT NULL COMMENT 'Toplam CPU sayısı',
  `amount` int unsigned NOT NULL DEFAULT '1',
  `discount` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quote_iaas_resource_lines_id_ref_unique` (`id_ref`),
  KEY `quote_iaas_resource_lines_quote_id_foreign` (`quote_id`),
  KEY `quote_iaas_resource_lines_product_id_foreign` (`product_id`),
  KEY `quote_iaas_resource_lines_datacenter_node_id_foreign` (`datacenter_node_id`),
  KEY `quote_iaas_resource_lines_compute_pool_id_foreign` (`compute_pool_id`),
  KEY `quote_iaas_resource_lines_storage_pool_id_foreign` (`storage_pool_id`),
  KEY `quote_iaas_resource_lines_network_pool_id_foreign` (`network_pool_id`),
  KEY `quote_iaas_resource_lines_network_id_foreign` (`network_id`),
  CONSTRAINT `quote_iaas_resource_lines_compute_pool_id_foreign` FOREIGN KEY (`compute_pool_id`) REFERENCES `compute_pools` (`id`),
  CONSTRAINT `quote_iaas_resource_lines_datacenter_node_id_foreign` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`),
  CONSTRAINT `quote_iaas_resource_lines_network_id_foreign` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `quote_iaas_resource_lines_network_pool_id_foreign` FOREIGN KEY (`network_pool_id`) REFERENCES `network_pools` (`id`),
  CONSTRAINT `quote_iaas_resource_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `quote_iaas_resource_lines_quote_id_foreign` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`id`),
  CONSTRAINT `quote_iaas_resource_lines_storage_pool_id_foreign` FOREIGN KEY (`storage_pool_id`) REFERENCES `storage_pools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quote_product_lines`
--

DROP TABLE IF EXISTS `quote_product_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quote_product_lines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `quote_id` bigint unsigned NOT NULL COMMENT 'Teklif IDsi',
  `product_id` int unsigned NOT NULL COMMENT 'Ürün IDsi',
  `product_catalog_id` bigint unsigned DEFAULT NULL COMMENT 'Ürün Kalaoğunun IDsi',
  `amount` int unsigned NOT NULL DEFAULT '1',
  `discount` int unsigned NOT NULL DEFAULT '0',
  `total` float unsigned DEFAULT '0',
  `subscription_type` enum('hourly','monthly','yearly','once','2yearly','3yearly','4yearly','5yearly') DEFAULT 'once',
  `currency_code` varchar(3) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quote_lines_id_ref_unique` (`id_ref`),
  KEY `quote_lines_product_id_foreign` (`product_id`),
  KEY `quote_lines_quote_id_foreign` (`quote_id`),
  CONSTRAINT `quote_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `quote_lines_quote_id_foreign` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quotes`
--

DROP TABLE IF EXISTS `quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL COMMENT 'Takvim girdisini yaratan accountun IDsi',
  `customer_id` bigint unsigned DEFAULT NULL COMMENT 'ID of account for the related request',
  `user_id` bigint unsigned NOT NULL,
  `project_id` bigint unsigned DEFAULT NULL COMMENT 'ID of account for the related request',
  `lead_id` bigint unsigned DEFAULT NULL,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `amount` double unsigned NOT NULL DEFAULT '0',
  `detailed_amount` text,
  `currency_code` char(3) NOT NULL DEFAULT 'USD',
  `suggested_price` float DEFAULT NULL,
  `suggested_currency_code` char(3) DEFAULT 'USD',
  `status` enum('draft','pending-approval','approved','not-approved') DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quotes_id_ref_unique` (`id_ref`),
  KEY `quotes_account_id_foreign` (`account_id`),
  KEY `quotes_project_id_foreign` (`project_id`),
  KEY `quotes_customer_id_foreign` (`customer_id`),
  KEY `quotes_user_id_foreign` (`user_id`),
  CONSTRAINT `quotes_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `quotes_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `quotes_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `quotes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registries`
--

DROP TABLE IF EXISTS `registries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registries` (
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remindables`
--

DROP TABLE IF EXISTS `remindables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remindables` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `remindable_id` bigint unsigned NOT NULL,
  `remindable_object_type` varchar(191) NOT NULL,
  `remind_datetime` datetime DEFAULT NULL,
  `snooze_datetime` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `note` text,
  `status` int NOT NULL DEFAULT '0' COMMENT '0 bekliyor,1 hatırlatıyor,2 görüldü,3 ertelendi bekliyor,4 iptal edildi',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remindables_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_remindables` BEFORE INSERT ON `remindables` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `remindables_contacts`
--

DROP TABLE IF EXISTS `remindables_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remindables_contacts` (
  `remindable_id` bigint unsigned NOT NULL,
  `contact_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `remindables_contacts_contact_id_foreign` (`contact_id`),
  KEY `remindables_contacts_remindable_id_foreign` (`remindable_id`),
  CONSTRAINT `remindables_contacts_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`),
  CONSTRAINT `remindables_contacts_remindable_id_foreign` FOREIGN KEY (`remindable_id`) REFERENCES `remindables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_event_execution_logs`
--

DROP TABLE IF EXISTS `remote_event_execution_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remote_event_execution_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `event` text NOT NULL,
  `is_parsed` tinyint(1) NOT NULL DEFAULT '0',
  `is_executed` tinyint(1) NOT NULL DEFAULT '0',
  `has_errors` tinyint(1) NOT NULL DEFAULT '0',
  `error` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_event_execution_logs_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_event_logs`
--

DROP TABLE IF EXISTS `remote_event_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remote_event_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `event` text NOT NULL,
  `log` text NOT NULL,
  `hash` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_event_logs_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_event_tasks`
--

DROP TABLE IF EXISTS `remote_event_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remote_event_tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `task_uuid` varchar(200) DEFAULT NULL,
  `task_session_identifier` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `source` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `events` text,
  `progress` double DEFAULT '0',
  `status` enum('created','pending','finished') NOT NULL DEFAULT 'created',
  `error_info` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_session_identifier` (`task_session_identifier`),
  UNIQUE KEY `remote_event_tasks_id_ref_unique` (`id_ref`),
  UNIQUE KEY `remote_event_tasks_task_uuid_unique` (`task_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=80071 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_events`
--

DROP TABLE IF EXISTS `remote_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remote_events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `event` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_events_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_events_engines`
--

DROP TABLE IF EXISTS `remote_events_engines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remote_events_engines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `type` enum('plusclouds') NOT NULL,
  `default_email` varchar(255) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(500) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_events_engines_id_ref_unique` (`id_ref`),
  KEY `remote_events_engines_account_id_foreign` (`account_id`),
  CONSTRAINT `remote_events_engines_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remote_events_flows`
--

DROP TABLE IF EXISTS `remote_events_flows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remote_events_flows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `engine_id` bigint unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `source` varchar(100) NOT NULL,
  `port` mediumint unsigned NOT NULL,
  `type` varchar(100) NOT NULL,
  `default_email` varchar(255) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_events_engine_id_ref_unique` (`id_ref`),
  KEY `remote_events_engine_account_id_foreign` (`account_id`),
  CONSTRAINT `remote_events_engine_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repo_isos`
--

DROP TABLE IF EXISTS `repo_isos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repo_isos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `repo_server_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `credentials` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `hash` varchar(32) NOT NULL,
  `path` varchar(500) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `repo_isos_id_ref_unique` (`id_ref`),
  KEY `repo_isos_repo_server_id_foreign` (`repo_server_id`),
  KEY `repo_isos_account_id_foreign` (`account_id`),
  CONSTRAINT `repo_isos_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `repo_isos_repo_server_id_foreign` FOREIGN KEY (`repo_server_id`) REFERENCES `repo_servers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repo_servers`
--

DROP TABLE IF EXISTS `repo_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repo_servers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `username` varchar(1000) DEFAULT NULL,
  `password` varchar(1000) DEFAULT NULL,
  `credentials` varchar(1000) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `ip_v4` varchar(15) NOT NULL,
  `ip_v6` varchar(39) DEFAULT NULL,
  `images_path` varchar(500) DEFAULT NULL,
  `iso_path` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `last_hash` varchar(100) DEFAULT NULL,
  `docker_registry_port` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `repo_servers_id_ref_unique` (`id_ref`),
  KEY `repo_servers_account_id_foreign` (`account_id`),
  KEY `repo_servers_virtual_machines_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `repo_servers_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `repo_servers_virtual_machines_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_repo_servers` BEFORE INSERT ON `repo_servers` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `repo_virtual_machine_images`
--

DROP TABLE IF EXISTS `repo_virtual_machine_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repo_virtual_machine_images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `repo_server_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  `name` varchar(500) NOT NULL,
  `os` varchar(100) NOT NULL,
  `distro` varchar(100) DEFAULT NULL,
  `version` varchar(100) DEFAULT NULL,
  `release_version` int unsigned DEFAULT '0',
  `is_latest` tinyint unsigned DEFAULT '0',
  `description` text,
  `extra` varchar(100) DEFAULT NULL,
  `cpu_type` varchar(10) DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'xenserver-6.2',
  `image_type` varchar(50) NOT NULL DEFAULT 'xenserver-6.2',
  `image_source` varchar(50) DEFAULT NULL,
  `credentials` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `hash` varchar(32) NOT NULL,
  `path` varchar(500) NOT NULL,
  `filename` varchar(500) DEFAULT NULL,
  `image_size` bigint unsigned DEFAULT NULL COMMENT 'Size of the image file in megabytes',
  `is_public` tinyint unsigned DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned DEFAULT NULL,
  `product_catalog_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `repo_images_id_ref_unique` (`id_ref`),
  KEY `repo_images_repo_server_id_foreign` (`repo_server_id`),
  KEY `repo_images_account_id_foreign` (`account_id`),
  CONSTRAINT `repo_images_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `repo_images_repo_server_id_foreign` FOREIGN KEY (`repo_server_id`) REFERENCES `repo_servers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=447 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_repo_virtual_machine_images` BEFORE INSERT ON `repo_virtual_machine_images` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL COMMENT 'Which account openned this request?',
  `user_id` bigint unsigned NOT NULL COMMENT 'Which user openned this request?',
  `customer_id` bigint unsigned NOT NULL COMMENT 'ID of account for the related request',
  `customer_user_id` bigint unsigned DEFAULT NULL COMMENT 'ID of user for the related request',
  `request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(500) NOT NULL,
  `response` varchar(500) DEFAULT NULL,
  `type` enum('credit','convert-to-vip','account-removal','other') DEFAULT NULL,
  `status` enum('approved','denied','pending') DEFAULT 'pending',
  `priority` enum('low','medium','high') NOT NULL DEFAULT 'low',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `requests_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_user` (
  `role_id` int unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned DEFAULT NULL COMMENT 'Team Id',
  UNIQUE KEY `role_user_role_id_user_id_account_id_unique` (`role_id`,`user_id`,`account_id`),
  KEY `role_user_user_id_foreign` (`user_id`),
  KEY `role_user_account_id_foreign` (`account_id`),
  CONSTRAINT `role_user_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(8) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `level` tinyint NOT NULL,
  `is_system_role` tinyint DEFAULT '1',
  `owner_id` bigint unsigned DEFAULT NULL COMMENT 'Account Id (Team)',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_owner_id_unique` (`name`,`owner_id`),
  UNIQUE KEY `roles_id_ref_unique` (`id_ref`),
  KEY `roles_owner_id_foreign` (`owner_id`),
  CONSTRAINT `roles_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `accounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `s3_clusters`
--

DROP TABLE IF EXISTS `s3_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s3_clusters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `s3_id` varchar(191) NOT NULL,
  `s3_secret` varchar(1024) NOT NULL,
  `endpoint` varchar(2083) NOT NULL,
  `region` varchar(191) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `s3_services_id_ref_unique` (`id_ref`),
  KEY `s3_services_account_id_foreign` (`account_id`),
  KEY `s3_services_user_id_foreign` (`user_id`),
  CONSTRAINT `s3_services_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `s3_services_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `segment_types`
--

DROP TABLE IF EXISTS `segment_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `segment_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `is_system_segment` tinyint DEFAULT '1',
  `account_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `segment_type_id_ref_unique` (`id_ref`),
  UNIQUE KEY `segment_type_name_uindex` (`name`),
  KEY `segment_type_ccounts_fk` (`account_id`),
  CONSTRAINT `segment_type_ccounts_fk` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_segment_type` BEFORE INSERT ON `segment_types` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `segments`
--

DROP TABLE IF EXISTS `segments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `segments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_id` bigint DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `is_system_segment` tinyint NOT NULL DEFAULT '0',
  `segment_type_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `segments_id_ref_unique` (`id_ref`),
  KEY `segments_types_fk` (`segment_type_id`),
  CONSTRAINT `segments_types_fk` FOREIGN KEY (`segment_type_id`) REFERENCES `segment_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_segments` BEFORE INSERT ON `segments` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `service_roles`
--

DROP TABLE IF EXISTS `service_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) COLLATE utf8_bin DEFAULT NULL,
  `name` char(64) COLLATE utf8_bin NOT NULL,
  `url` text COLLATE utf8_bin,
  `service_status` enum('not-started','starting','downloading','failed','initiating','completed') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'not-started',
  `ansible_status` enum('not-started','starting','failed','completed') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'not-started',
  `service_report` text CHARACTER SET utf8 COLLATE utf8_bin,
  `ansible_report` text CHARACTER SET utf8 COLLATE utf8_bin,
  `has_update` tinyint(1) NOT NULL DEFAULT '0',
  `version` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '1.0.0',
  `release_date` timestamp NULL DEFAULT NULL,
  `object_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'virtual_machine',
  `object_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2838 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_service_roles` BEFORE INSERT ON `service_roles` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `token_id` varchar(100) DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` text NOT NULL,
  `last_activity` int NOT NULL,
  UNIQUE KEY `sessions_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ssh_keys`
--

DROP TABLE IF EXISTS `ssh_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ssh_keys` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) COLLATE utf8_bin DEFAULT NULL,
  `name` char(64) COLLATE utf8_bin NOT NULL,
  `public_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `ssh_encryption_type` char(64) COLLATE utf8_bin NOT NULL,
  `email` char(128) COLLATE utf8_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ssh_keys_user_id_foreign` (`user_id`),
  KEY `ssh_keys_account_id_foreign` (`account_id`),
  CONSTRAINT `ssh_keys_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ssh_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_ssh_keys` BEFORE INSERT ON `ssh_keys` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stash_accounts`
--

DROP TABLE IF EXISTS `stash_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stash_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `stash_service_id` bigint unsigned NOT NULL,
  `account_id` bigint unsigned NOT NULL COMMENT 'Owner of the stash account',
  `group_id` varchar(255) NOT NULL COMMENT 'Stash accounts are actually groups in NextCloud or other stash service.',
  `name` varchar(100) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `metrics` json DEFAULT NULL,
  `used_mb` int unsigned NOT NULL DEFAULT '0',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT 'Stash service default quota is 5GB',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_lost` tinyint(1) NOT NULL DEFAULT '0',
  `suspended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `product_subscription_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stash_accounts_id_ref_unique` (`id_ref`),
  KEY `stash_accounts_account_id_foreign` (`account_id`),
  KEY `stash_accounts_stash_service_id_foreign` (`stash_service_id`),
  CONSTRAINT `stash_accounts_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stash_accounts_stash_service_id_foreign` FOREIGN KEY (`stash_service_id`) REFERENCES `stash_services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_stash_accounts` BEFORE INSERT ON `stash_accounts` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stash_services`
--

DROP TABLE IF EXISTS `stash_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stash_services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `url` varchar(300) NOT NULL,
  `type` enum('nextcloud') NOT NULL DEFAULT 'nextcloud',
  `version` varchar(10) NOT NULL COMMENT 'Version of stash service',
  `credentials` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `account_id` bigint unsigned NOT NULL COMMENT 'Owner of the stash service',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stash_services_id_ref_unique` (`id_ref`),
  KEY `stash_services_account_id_foreign` (`account_id`),
  CONSTRAINT `stash_services_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stash_users`
--

DROP TABLE IF EXISTS `stash_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stash_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `stash_service_id` bigint unsigned NOT NULL,
  `stash_account_id` bigint unsigned NOT NULL COMMENT 'Relation to stash account',
  `account_id` bigint unsigned NOT NULL COMMENT 'Owner of the stash account',
  `user_id` bigint DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `salt_hash` varchar(32) DEFAULT NULL,
  `is_lost` tinyint(1) NOT NULL DEFAULT '0',
  `metrics` json DEFAULT NULL,
  `used_mb` int unsigned NOT NULL DEFAULT '0',
  `quota` int unsigned NOT NULL DEFAULT '5120' COMMENT 'Stash service default quota is 5GB',
  `product_catalog_id` bigint unsigned NOT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stash_users_id_ref_unique` (`id_ref`),
  KEY `stash_users_stash_service_id_foreign` (`stash_service_id`),
  KEY `stash_users_account_id_foreign` (`account_id`),
  KEY `stash_users_stash_account_id_foreign` (`stash_account_id`),
  CONSTRAINT `stash_users_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stash_users_stash_account_id_foreign` FOREIGN KEY (`stash_account_id`) REFERENCES `stash_accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stash_users_stash_service_id_foreign` FOREIGN KEY (`stash_service_id`) REFERENCES `stash_services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_stash_users` BEFORE INSERT ON `stash_users` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `states` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `value` text,
  `reason` text,
  `model_id` int unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `states_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB AUTO_INCREMENT=72966 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_member_connections`
--

DROP TABLE IF EXISTS `storage_member_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_member_connections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `storage_member_id` int unsigned NOT NULL,
  `storage_volume_id` bigint unsigned DEFAULT NULL,
  `connection_name` varchar(100) NOT NULL COMMENT 'we store iqn number here.',
  `tpg_id` int unsigned NOT NULL DEFAULT '0',
  `allowed_portal_ips` text,
  `status` enum('connected','connecting','corrupted','stopped') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'connecting',
  `type` enum('iscsi','nfs','smb') NOT NULL DEFAULT 'iscsi',
  `connection_parameters` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_member_connections_id_ref_unique` (`id_ref`),
  KEY `storage_member_connections_storage_member_id_foreign` (`storage_member_id`),
  CONSTRAINT `storage_member_connections_storage_member_id_foreign` FOREIGN KEY (`storage_member_id`) REFERENCES `storage_members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_storage_member_connections` BEFORE INSERT ON `storage_member_connections` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `storage_member_data`
--

DROP TABLE IF EXISTS `storage_member_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_member_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `storage_member_id` int unsigned NOT NULL,
  `type` enum('zfs') NOT NULL DEFAULT 'zfs',
  `configuration` json DEFAULT NULL,
  `health_state` enum('healthy','not-healthy') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_member_data_id_ref_unique` (`id_ref`),
  KEY `storage_member_data_storage_member_id_foreign` (`storage_member_id`),
  CONSTRAINT `storage_member_data_storage_member_id_foreign` FOREIGN KEY (`storage_member_id`) REFERENCES `storage_members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_storage_member_data` BEFORE INSERT ON `storage_member_data` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `storage_member_devices`
--

DROP TABLE IF EXISTS `storage_member_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_member_devices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `storage_member_id` int unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `device_id` varchar(100) NOT NULL,
  `information` json NOT NULL,
  `detailed_information` json NOT NULL,
  `health_state` enum('healthy','not-healthy','not_responding') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `health_information` json NOT NULL,
  `type` enum('hdd','ssd','pcie','nvme','vdev') NOT NULL,
  `parent_vdev_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_member_devices_id_ref_unique` (`id_ref`),
  KEY `storage_member_devices_storage_member_id_foreign` (`storage_member_id`),
  KEY `storage_member_devices_parent_vdev_id_foreign` (`parent_vdev_id`),
  CONSTRAINT `storage_member_devices_parent_vdev_id_foreign` FOREIGN KEY (`parent_vdev_id`) REFERENCES `storage_member_devices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `storage_member_devices_storage_member_id_foreign` FOREIGN KEY (`storage_member_id`) REFERENCES `storage_members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_storage_member_devices` BEFORE INSERT ON `storage_member_devices` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `storage_member_histories`
--

DROP TABLE IF EXISTS `storage_member_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_member_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `storage_member_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1043 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_members`
--

DROP TABLE IF EXISTS `storage_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_members` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ip_addr` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `port` smallint unsigned DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `bios_id` varchar(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('running','creating','unaccessible') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'creating',
  `storage_type` enum('nas','sds','local','plusclouds-sn') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'local',
  `device_type` enum('sn10-ff','sn22-ff','sn44-ff','other') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'other',
  `member_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `network_uplink_type` enum('fiber','1G','10G','25G','100G','local') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'local',
  `controller` enum('single','active-passive','active-active','local') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'local',
  `total_hdd` bigint unsigned NOT NULL COMMENT 'GB cinsinden disk alanı',
  `hourly_price` decimal(13,4) NOT NULL,
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USD',
  `datacenter_id` int unsigned DEFAULT NULL,
  `storage_pool_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_members_id_ref_unique` (`id_ref`),
  KEY `storage_members_datacenter_id_foreign` (`datacenter_id`),
  KEY `storage_members_storage_pool_id_foreign` (`storage_pool_id`),
  CONSTRAINT `storage_members_datacenter_id_foreign` FOREIGN KEY (`datacenter_id`) REFERENCES `datacenters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_storage_members` BEFORE INSERT ON `storage_members` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `storage_pool_histories`
--

DROP TABLE IF EXISTS `storage_pool_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_pool_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `storage_pool_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_pools`
--

DROP TABLE IF EXISTS `storage_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_pools` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hourly_price` decimal(13,8) NOT NULL,
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ip_addr` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `port` smallint unsigned DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `connection_type` enum('iscsi','nfs','cifs','local') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'local',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `datacenter_id` int unsigned DEFAULT NULL,
  `vendor_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_pools_id_ref_unique` (`id_ref`),
  KEY `storage_pools_vendor_id_foreign` (`vendor_id`),
  KEY `storage_pools_datacenter_id_foreign` (`datacenter_id`),
  CONSTRAINT `storage_pools_datacenter_id_foreign` FOREIGN KEY (`datacenter_id`) REFERENCES `datacenters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `storage_pools_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `accounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage_volume_histories`
--

DROP TABLE IF EXISTS `storage_volume_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_volume_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `storage_volume_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2207 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `storage_volume_usage_report_view`
--

DROP TABLE IF EXISTS `storage_volume_usage_report_view`;
/*!50001 DROP VIEW IF EXISTS `storage_volume_usage_report_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `storage_volume_usage_report_view` AS SELECT 
 1 AS `storage_volume_id`,
 1 AS `storage_volume_name`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_name`,
 1 AS `total_hdd`,
 1 AS `used_hdd`,
 1 AS `free_hdd`,
 1 AS `hdd_hourly_price`,
 1 AS `used_hdd_hourly_price`,
 1 AS `used_hdd_monthly_price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `storage_volumes`
--

DROP TABLE IF EXISTS `storage_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_volumes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hourly_price` float unsigned DEFAULT NULL,
  `currency_code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT 'USD',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_addr` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `port` smallint unsigned DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `disk_physical_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `connection_type` enum('iscsi','nfs','cifs','local','lvmohba','iso') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'local',
  `total_hdd` bigint unsigned NOT NULL DEFAULT '0',
  `used_hdd` bigint unsigned NOT NULL DEFAULT '0',
  `is_master_record` tinyint(1) NOT NULL DEFAULT '0',
  `master_volume_id` int DEFAULT NULL,
  `storage_pool_id` int unsigned DEFAULT NULL,
  `resident_id` int DEFAULT NULL COMMENT 'Compute member alanını temsil eder.',
  `product_id` int unsigned DEFAULT NULL,
  `storage_member_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `storage_volumes_id_ref_unique` (`id_ref`),
  KEY `storage_volumes_storage_pool_id_foreign` (`storage_pool_id`),
  KEY `storage_volumes_product_id_foreign` (`product_id`),
  KEY `storage_volumes_storage_member_fk` (`storage_member_id`),
  CONSTRAINT `storage_volumes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `storage_volumes_storage_member_fk` FOREIGN KEY (`storage_member_id`) REFERENCES `storage_members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `storage_volumes_storage_pool_id_foreign` FOREIGN KEY (`storage_pool_id`) REFERENCES `storage_pools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_storage_volumes` BEFORE INSERT ON `storage_volumes` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stream_clusters`
--

DROP TABLE IF EXISTS `stream_clusters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_clusters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `service_type` enum('webrtc','rtmp','vod') DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `incoming_router_ip` varchar(15) DEFAULT NULL COMMENT 'We can create a proxy table and store its id here',
  `username` varchar(30) NOT NULL DEFAULT 'admin' COMMENT 'May not be necessary since its only usefull when loging in antmedias dashboard, we can instead set a default value for each Antmedia accounts (username: admin, pass:123123123)s',
  `password` varchar(1024) DEFAULT NULL COMMENT 'Condition of username(written above) applies to password as well',
  `features` text,
  `access_token` varchar(1024) DEFAULT NULL,
  `account_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `datacenter_id` int unsigned NOT NULL,
  `domain_id` bigint unsigned DEFAULT NULL,
  `db_vm_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` enum('running','preparing','halted','shutdown') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'preparing',
  PRIMARY KEY (`id`),
  KEY `stream_clusters_account_id_foreign` (`account_id`),
  KEY `stream_clusters_user_id_foreign` (`user_id`),
  KEY `stream_clusters_domain_id_foreign` (`domain_id`),
  CONSTRAINT `stream_clusters_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `stream_clusters_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`),
  CONSTRAINT `stream_clusters_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_stream_clusters` BEFORE INSERT ON `stream_clusters` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stream_edges`
--

DROP TABLE IF EXISTS `stream_edges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_edges` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `vm_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` enum('running','preparing','halted','shutdown') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'preparing',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stream_edges_vm_id_uindex` (`vm_id`),
  KEY `stream_edges_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `stream_edges_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `stream_clusters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_stream_edges` BEFORE INSERT ON `stream_edges` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stream_folder_bitrates`
--

DROP TABLE IF EXISTS `stream_folder_bitrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_folder_bitrates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `storage_member_id` bigint unsigned DEFAULT NULL,
  `device_id` varchar(50) DEFAULT NULL,
  `type` enum('disk','vdev') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `parent_vdev_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_stream_folder_bitrates` BEFORE INSERT ON `stream_folder_bitrates` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stream_folder_settings`
--

DROP TABLE IF EXISTS `stream_folder_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_folder_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stream_folder_id` bigint unsigned NOT NULL,
  `is_H264` tinyint(1) NOT NULL,
  `is_vp8` tinyint(1) NOT NULL,
  `segment_list_size` int DEFAULT NULL,
  `segment_duration` int DEFAULT NULL,
  `is_record_livestream` tinyint(1) NOT NULL,
  `webrtc_data_channel` enum('none','publisher','all') NOT NULL,
  `fps` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stream_folder_settings_stream_folder_id_foreign` (`stream_folder_id`),
  CONSTRAINT `stream_folder_settings_stream_folder_id_foreign` FOREIGN KEY (`stream_folder_id`) REFERENCES `stream_folders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stream_folder_vod_destinations`
--

DROP TABLE IF EXISTS `stream_folder_vod_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_folder_vod_destinations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stream_folder_id` bigint unsigned NOT NULL,
  `destination` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stream_folder_vod_destinations_stream_folder_id_foreign` (`stream_folder_id`),
  CONSTRAINT `stream_folder_vod_destinations_stream_folder_id_foreign` FOREIGN KEY (`stream_folder_id`) REFERENCES `stream_folders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stream_folders`
--

DROP TABLE IF EXISTS `stream_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_folders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `id_ref` char(36) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `access_token` varchar(1024) DEFAULT NULL COMMENT ' We will store the JWT for AntMedia in this column. We will use it for accessing Dashboard routes',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stream_folders_account_id_foreign` (`account_id`),
  KEY `stream_folders_user_id_foreign` (`user_id`),
  KEY `stream_folders_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `stream_folders_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `stream_folders_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `stream_clusters` (`id`),
  CONSTRAINT `stream_folders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_stream_folders` BEFORE INSERT ON `stream_folders` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stream_origins`
--

DROP TABLE IF EXISTS `stream_origins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_origins` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `cluster_id` bigint unsigned NOT NULL,
  `vm_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` enum('running','preparing','halted','shutdown') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'preparing',
  PRIMARY KEY (`id`),
  UNIQUE KEY `stream_origins_vm_id_uindex` (`vm_id`),
  KEY `stream_origins_cluster_id_foreign` (`cluster_id`),
  CONSTRAINT `stream_origins_cluster_id_foreign` FOREIGN KEY (`cluster_id`) REFERENCES `stream_clusters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_stream_origins` BEFORE INSERT ON `stream_origins` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stream_rtmp_links`
--

DROP TABLE IF EXISTS `stream_rtmp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_rtmp_links` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `social_type` enum('Twitch','Youtube','Facebook','Twitter','Steam','Custom') NOT NULL,
  `url` varchar(2083) NOT NULL,
  `stream_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `antmedia_id` varchar(30) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `streams`
--

DROP TABLE IF EXISTS `streams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streams` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(36) DEFAULT NULL,
  `status` enum('scheduled','active','inactive','preparing','done') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'scheduled',
  `type` enum('conference_call','live_stream','webcam') NOT NULL,
  `name` varchar(300) DEFAULT NULL,
  `cluster_id` bigint unsigned DEFAULT NULL,
  `origin_id` bigint unsigned DEFAULT NULL,
  `folder_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `stream_started_at` timestamp NULL DEFAULT NULL,
  `stream_ended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `public_key` varchar(25) DEFAULT NULL,
  `webhook_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `streams_folder_id_foreign` (`folder_id`),
  KEY `streams_origin_id_foreign` (`origin_id`),
  KEY `streams_user_id_foreign` (`user_id`),
  KEY `streams_stream_clusters_id_fk` (`cluster_id`),
  CONSTRAINT `streams_folder_id_foreign` FOREIGN KEY (`folder_id`) REFERENCES `stream_folders` (`id`),
  CONSTRAINT `streams_origin_id_foreign` FOREIGN KEY (`origin_id`) REFERENCES `stream_origins` (`id`),
  CONSTRAINT `streams_stream_clusters_id_fk` FOREIGN KEY (`cluster_id`) REFERENCES `stream_clusters` (`id`),
  CONSTRAINT `streams_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_streams` BEFORE INSERT ON `streams` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `swarm_compute_members`
--

DROP TABLE IF EXISTS `swarm_compute_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swarm_compute_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `type` enum('worker','manager') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_leader` tinyint(1) NOT NULL DEFAULT '0',
  `compute_pool_id` int unsigned DEFAULT NULL COMMENT 'relationship with the iaas compute_pools table',
  `compute_member_id` int unsigned DEFAULT NULL COMMENT 'relationship with the iaas compute_members table',
  `virtual_machine_id` bigint unsigned DEFAULT NULL COMMENT 'relationship with the iaas virtual_machines table',
  `swarm_compute_pool_id` bigint unsigned DEFAULT NULL,
  `docker_node_id` varchar(255) DEFAULT NULL,
  `port` char(4) DEFAULT NULL,
  `status` enum('running','preparing','stopped','unattached') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'unattached',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `swarm_compute_members_id_ref_unique` (`id_ref`),
  KEY `swarm_compute_members_compute_member_id_foreign` (`compute_member_id`),
  KEY `swarm_compute_members_compute_pool_id_foreign` (`compute_pool_id`),
  KEY `swarm_compute_members_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `swarm_compute_members_swarm_compute_pool_id_foreign` (`swarm_compute_pool_id`),
  CONSTRAINT `swarm_compute_members_swarm_compute_pool_id_foreign` FOREIGN KEY (`swarm_compute_pool_id`) REFERENCES `swarm_compute_pools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `swarm_compute_members_overview`
--

DROP TABLE IF EXISTS `swarm_compute_members_overview`;
/*!50001 DROP VIEW IF EXISTS `swarm_compute_members_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `swarm_compute_members_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `hostname`,
 1 AS `ip_addr`,
 1 AS `swarm_compute_member_status`,
 1 AS `swarm_compute_member_type`,
 1 AS `swarm_compute_member_port`,
 1 AS `is_leader`,
 1 AS `management_url`,
 1 AS `port`,
 1 AS `hypervisor_uuid`,
 1 AS `total_cpu`,
 1 AS `total_ram`,
 1 AS `total_vm`,
 1 AS `used_cpu`,
 1 AS `used_ram`,
 1 AS `is_alive`,
 1 AS `compute_pool_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `swarm_compute_pool_overview`
--

DROP TABLE IF EXISTS `swarm_compute_pool_overview`;
/*!50001 DROP VIEW IF EXISTS `swarm_compute_pool_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `swarm_compute_pool_overview` AS SELECT 
 1 AS `id`,
 1 AS `listen_addr`,
 1 AS `listen_port`,
 1 AS `advertise_addr`,
 1 AS `advertise_port`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `resource_validator`,
 1 AS `pool_type`,
 1 AS `master_ip_addr`,
 1 AS `management_url`,
 1 AS `port`,
 1 AS `management_type`,
 1 AS `virtualization`,
 1 AS `virtualization_version`,
 1 AS `provisioning_alg`,
 1 AS `management_package_name`,
 1 AS `is_active`,
 1 AS `is_alive`,
 1 AS `is_public`,
 1 AS `datacenter_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `swarm_compute_pools`
--

DROP TABLE IF EXISTS `swarm_compute_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swarm_compute_pools` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `listen_addr` varchar(45) NOT NULL,
  `listen_port` int DEFAULT NULL,
  `advertise_addr` varchar(45) NOT NULL,
  `advertise_port` int DEFAULT NULL,
  `manager_token` varchar(255) DEFAULT NULL,
  `worker_token` varchar(255) DEFAULT NULL,
  `compute_pool_id` int unsigned NOT NULL COMMENT 'relationship with the iaas compute_pools table',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `swarm_compute_pools_id_ref_unique` (`id_ref`),
  KEY `swarm_compute_pools_compute_pool_id_foreign` (`compute_pool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `swarm_compute_pools_overview`
--

DROP TABLE IF EXISTS `swarm_compute_pools_overview`;
/*!50001 DROP VIEW IF EXISTS `swarm_compute_pools_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `swarm_compute_pools_overview` AS SELECT 
 1 AS `id`,
 1 AS `listen_addr`,
 1 AS `listen_port`,
 1 AS `advertise_addr`,
 1 AS `advertise_port`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `resource_validator`,
 1 AS `pool_type`,
 1 AS `master_ip_addr`,
 1 AS `management_url`,
 1 AS `port`,
 1 AS `management_type`,
 1 AS `virtualization`,
 1 AS `virtualization_version`,
 1 AS `provisioning_alg`,
 1 AS `management_package_name`,
 1 AS `is_active`,
 1 AS `is_alive`,
 1 AS `is_public`,
 1 AS `datacenter_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `swarm_images`
--

DROP TABLE IF EXISTS `swarm_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swarm_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `image_file` text COLLATE utf8_bin NOT NULL,
  `project_url` varchar(191) COLLATE utf8_bin DEFAULT NULL,
  `swarm_compute_pool_id` bigint unsigned NOT NULL,
  `is_built` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `swarm_images_FK` (`swarm_compute_pool_id`),
  CONSTRAINT `swarm_images_FK` FOREIGN KEY (`swarm_compute_pool_id`) REFERENCES `swarm_compute_pools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `swarm_network_overview`
--

DROP TABLE IF EXISTS `swarm_network_overview`;
/*!50001 DROP VIEW IF EXISTS `swarm_network_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `swarm_network_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `docker_network_id`,
 1 AS `vlan`,
 1 AS `mtu`,
 1 AS `network_type`,
 1 AS `ip_addr`,
 1 AS `ip_range_start`,
 1 AS `ip_range_end`,
 1 AS `gateway`,
 1 AS `subnet`,
 1 AS `netmask`,
 1 AS `network`,
 1 AS `dns_nameservers`,
 1 AS `local_domain`,
 1 AS `is_bridge`,
 1 AS `is_virtual_network`,
 1 AS `is_interroutable`,
 1 AS `is_default_pif`,
 1 AS `is_master_record`,
 1 AS `is_visible`,
 1 AS `network_pool_id`,
 1 AS `network_pool_id_ref`,
 1 AS `network_pool_name`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_id_ref`,
 1 AS `datacenter_node_name`,
 1 AS `dhcp_server_id`,
 1 AS `dhcp_server_id_ref`,
 1 AS `dhcp_server_name`,
 1 AS `proxy_server_id`,
 1 AS `proxy_server_id_ref`,
 1 AS `proxy_server_name`,
 1 AS `nat_server_id`,
 1 AS `nat_server_id_ref`,
 1 AS `nat_server_name`,
 1 AS `domain_id`,
 1 AS `domain_id_ref`,
 1 AS `domain_name`,
 1 AS `account_id`,
 1 AS `account_id_ref`,
 1 AS `account_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `swarm_networks`
--

DROP TABLE IF EXISTS `swarm_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swarm_networks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `driver_type` enum('bridge','host','overlay') DEFAULT NULL,
  `scope` enum('local','swarm') NOT NULL DEFAULT 'local',
  `network_id` int unsigned NOT NULL COMMENT 'relationship with the iaas networks table',
  `swarm_compute_pool_id` bigint unsigned NOT NULL,
  `docker_network_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `docker_response` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `config` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'This request was made for storing the values sent to swarm',
  `status` enum('preparing','running','failed','scheduled') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'preparing',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `swarm_networks_id_ref_unique` (`id_ref`),
  KEY `swarm_networks_network_id_foreign` (`network_id`),
  KEY `swarm_networks_swarm_compute_pool_id_foreign` (`swarm_compute_pool_id`),
  CONSTRAINT `swarm_networks_swarm_compute_pool_id_foreign` FOREIGN KEY (`swarm_compute_pool_id`) REFERENCES `swarm_compute_pools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `swarm_networks_overview`
--

DROP TABLE IF EXISTS `swarm_networks_overview`;
/*!50001 DROP VIEW IF EXISTS `swarm_networks_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `swarm_networks_overview` AS SELECT 
 1 AS `swarm_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `swarm_replicas`
--

DROP TABLE IF EXISTS `swarm_replicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swarm_replicas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `replicas` int NOT NULL DEFAULT '0',
  `image_url` varchar(255) NOT NULL,
  `command` text,
  `distributing_port` int DEFAULT NULL,
  `swarm_service_id` varchar(255) DEFAULT NULL,
  `status` enum('preparing','running','shutdown','scheduled') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'preparing',
  `swarm_compute_pool_id` bigint unsigned DEFAULT NULL,
  `swarm_network_id` bigint unsigned DEFAULT NULL,
  `service_version` varchar(4) DEFAULT NULL,
  `tags` text,
  `config` text COMMENT 'This is the config sent to the swarm instance',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `swarm_replicas_id_ref_unique` (`id_ref`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `swarm_virtual_machines`
--

DROP TABLE IF EXISTS `swarm_virtual_machines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swarm_virtual_machines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL COMMENT 'relationship with the iaas virtual_machines table',
  `replica_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `swarm_compute_pool_id` bigint unsigned DEFAULT NULL,
  `index` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `swarm_virtual_machines_id_ref_unique` (`id_ref`),
  KEY `swarm_virtual_machines_virtual_machine_id_foreign` (`virtual_machine_id`),
  KEY `swarm_virtual_machines_replica_id_foreign` (`replica_id`),
  CONSTRAINT `swarm_virtual_machines_replica_id_foreign` FOREIGN KEY (`replica_id`) REFERENCES `swarm_replicas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `swarm_virtual_machines_overview`
--

DROP TABLE IF EXISTS `swarm_virtual_machines_overview`;
/*!50001 DROP VIEW IF EXISTS `swarm_virtual_machines_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `swarm_virtual_machines_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `replica_name`,
 1 AS `image_url`,
 1 AS `hostname`,
 1 AS `os`,
 1 AS `distro`,
 1 AS `domain_type`,
 1 AS `winrm_enabled`,
 1 AS `is_locked`,
 1 AS `is_lost`,
 1 AS `status`,
 1 AS `actual_cpu`,
 1 AS `actual_ram`,
 1 AS `actual_disk`,
 1 AS `actual_network`,
 1 AS `product_id`,
 1 AS `product_catalog_id`,
 1 AS `ip_addr`,
 1 AS `network_count`,
 1 AS `connected_to`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_name`,
 1 AS `account_id`,
 1 AS `user_id`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `taggables`
--

DROP TABLE IF EXISTS `taggables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taggables` (
  `tag_id` int NOT NULL,
  `taggable_id` int unsigned NOT NULL,
  `taggable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  KEY `taggables_taggable_id_taggable_type_index` (`taggable_id`,`taggable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('system','common','user','application') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `account_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tags_account_id_foreign` (`account_id`),
  CONSTRAINT `tags_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint unsigned NOT NULL,
  `assigned_user_id` bigint unsigned NOT NULL COMMENT 'User who is responsible from the task',
  `gitlab_id` bigint DEFAULT NULL,
  `gitlab_iid` bigint DEFAULT NULL,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `task` varchar(250) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `status` enum('open','in-progress','waiting-feedback','on-hold','completed','delivered','archived') DEFAULT NULL,
  `priority` enum('low','medium','high') NOT NULL,
  `time_estimated` int DEFAULT '0' COMMENT 'Time in minutes',
  `time_spent` int NOT NULL DEFAULT '0' COMMENT 'Time spent for the related task',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tasks_id_ref_unique` (`id_ref`),
  KEY `tasks_project_id_foreign` (`project_id`),
  CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticket_answers`
--

DROP TABLE IF EXISTS `ticket_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `ticket_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_answers_id_ref_unique` (`id_ref`),
  KEY `ticket_answers_user_id_foreign` (`user_id`),
  KEY `ticket_answers_ticket_id_foreign` (`ticket_id`),
  CONSTRAINT `ticket_answers_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8290 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `body` longtext NOT NULL,
  `priority` enum('LOW','MEDIUM','HIGH') NOT NULL DEFAULT 'LOW',
  `status` enum('OPEN','PENDING','CLOSED') NOT NULL DEFAULT 'OPEN',
  `answer_count` bigint unsigned NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `account_id` bigint DEFAULT NULL,
  `project_id` bigint unsigned DEFAULT NULL,
  `task_id` bigint unsigned DEFAULT NULL,
  `assigned_user_id` bigint unsigned DEFAULT NULL,
  `best_answer_id` bigint unsigned DEFAULT NULL,
  `deadline` timestamp NULL DEFAULT NULL,
  `assigned_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_id_ref_unique` (`id_ref`),
  KEY `tickets_category_id_foreign` (`category_id`),
  KEY `tickets_user_id_foreign` (`user_id`),
  KEY `tickets_assigned_user_id_foreign` (`assigned_user_id`),
  KEY `tickets_best_answer_id_foreign` (`best_answer_id`),
  CONSTRAINT `tickets_assigned_user_id_foreign` FOREIGN KEY (`assigned_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `tickets_best_answer_id_foreign` FOREIGN KEY (`best_answer_id`) REFERENCES `ticket_answers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2212 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NOT NULL DEFAULT '0',
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ext_ref` varchar(100) DEFAULT NULL,
  `order_ref` varchar(100) NOT NULL,
  `amount` decimal(13,4) NOT NULL DEFAULT '0.0000',
  `currency_code` char(3) NOT NULL,
  `payment_type` varchar(20) DEFAULT NULL,
  `extra` text,
  `response` text,
  `hash` varchar(32) DEFAULT NULL,
  `status_code` smallint unsigned NOT NULL,
  `cc_number` varchar(255) DEFAULT NULL,
  `gateway` varchar(100) NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `transaction_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactions_id_ref_unique` (`id_ref`),
  KEY `transactions_account_id_foreign` (`account_id`),
  KEY `transactions_user_id_foreign` (`user_id`),
  CONSTRAINT `transactions_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations` (
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `1` (`locale`,`key`),
  KEY `translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_follows_tag`
--

DROP TABLE IF EXISTS `user_follows_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_follows_tag` (
  `users_id` bigint unsigned NOT NULL,
  `tags_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`users_id`,`tags_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `surname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `fullname` varchar(101) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `about` text COLLATE utf8_unicode_ci,
  `gender` enum('male','female') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `nin` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Kimlik numarası',
  `cell_phone_code` varchar(4) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `cell_phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_locale` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'tr' COMMENT 'Varsayılan sistem dili',
  `iam_dn` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `iam_uid` int unsigned DEFAULT NULL,
  `country_id` int unsigned DEFAULT '1',
  `email_verification_date` timestamp NULL DEFAULT NULL,
  `cellphone_verification_date` timestamp NULL DEFAULT NULL,
  `nin_verification_date` timestamp NULL DEFAULT NULL,
  `password_last_changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password_expiry_notification_sent_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_id_ref_unique` (`id_ref`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_country_id_foreign` (`country_id`),
  KEY `users_default_locale_index` (`default_locale`),
  CONSTRAINT `users_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16736 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_personality`
--

DROP TABLE IF EXISTS `users_personality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_personality` (
  `user_id` bigint unsigned NOT NULL,
  `personality` varchar(10) DEFAULT NULL COMMENT '16 mbti kişilik türünü gösterir',
  `extraversion` smallint NOT NULL DEFAULT '0' COMMENT '(-100) İçe dönük- Dışa dönük (+100) özelliğini gösterir.',
  `sensing` smallint NOT NULL DEFAULT '0' COMMENT '(-100) Sezgisel - Duyusal  (+100) özelliğini gösterir ',
  `thinking` smallint NOT NULL DEFAULT '0' COMMENT '(-100)  Hissetme - Düşünme (+100) özelliğini gösterir ',
  `judging` smallint NOT NULL DEFAULT '0' COMMENT '(-100)  Algısal - Yargısal (+100) özelliğini gösterir ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `users_personality_user_id_index` (`user_id`),
  CONSTRAINT `users_personality_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_disk_histories`
--

DROP TABLE IF EXISTS `virtual_disk_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_disk_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `virtual_disk_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=228539 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_disks`
--

DROP TABLE IF EXISTS `virtual_disks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_disks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `uuid` varchar(255) NOT NULL DEFAULT '',
  `disk_type` enum('disk','cdrom','iso') DEFAULT NULL,
  `total_disk` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_attached` tinyint(1) NOT NULL DEFAULT '0',
  `is_snapshot` tinyint(1) DEFAULT '0',
  `features` text,
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `hypervisor_session_id` varchar(255) DEFAULT NULL,
  `hypervisor_data` text,
  `metrics` text COMMENT 'metric bilgilerinin bulunduğu sütun.',
  `storage_volume_id` int unsigned DEFAULT NULL,
  `snapshot_parent_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL COMMENT 'Disk''in ne zaman suspend edildiği bilgisi',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtual_disks_id_ref_unique` (`id_ref`),
  KEY `virtual_disks_storage_volume_id_foreign` (`storage_volume_id`),
  KEY `virtual_disks_account_id_foreign` (`account_id`),
  KEY `virtual_disks_user_id_foreign` (`user_id`),
  CONSTRAINT `virtual_disks_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `virtual_disks_storage_volume_id_foreign` FOREIGN KEY (`storage_volume_id`) REFERENCES `storage_volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `virtual_disks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2682 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_machine_histories`
--

DROP TABLE IF EXISTS `virtual_machine_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_machine_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `virtual_machine_histories_historyable_id_historyable_type_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=199231 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_machine_virtual_disks`
--

DROP TABLE IF EXISTS `virtual_machine_virtual_disks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_machine_virtual_disks` (
  `virtual_machine_id` bigint unsigned NOT NULL,
  `virtual_disk_id` bigint unsigned NOT NULL,
  `device_number` tinyint unsigned NOT NULL DEFAULT '0',
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `hypervisor_session_id` varchar(255) DEFAULT NULL,
  `hypervisor_data` text,
  PRIMARY KEY (`virtual_machine_id`,`virtual_disk_id`),
  KEY `virtual_machine_virtual_disks_virtual_disk_id_foreign` (`virtual_disk_id`),
  CONSTRAINT `virtual_machine_virtual_disks_virtual_disk_id_foreign` FOREIGN KEY (`virtual_disk_id`) REFERENCES `virtual_disks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `virtual_machine_virtual_disks_virtual_machine_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_machines`
--

DROP TABLE IF EXISTS `virtual_machines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_machines` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `old_id` bigint unsigned DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(1024) DEFAULT NULL,
  `uuid` varchar(255) NOT NULL DEFAULT '',
  `hostname` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `os` varchar(30) DEFAULT NULL,
  `distro` varchar(30) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `domain_type` enum('PV','HVM','PVHVM') DEFAULT NULL,
  `status` enum('running','halted','paused','preparing','importing','configuring','exporting') NOT NULL DEFAULT 'preparing',
  `total_cpu` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'takılı toplam cpu miktarı. bilgi amaçlı sütun.',
  `total_ram` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'takılı toplam ram miktarı. bilgi amaçlı sütun.',
  `total_disk` int unsigned NOT NULL DEFAULT '0' COMMENT 'takılı toplam disk miktarı. bilgi amaçlı sütun.',
  `total_network` int unsigned NOT NULL DEFAULT '0' COMMENT 'takılı toplam network miktarı. bilgi amaçlı sütun.',
  `actual_cpu` mediumint unsigned DEFAULT '0',
  `actual_ram` mediumint unsigned DEFAULT '0',
  `actual_disk` int unsigned DEFAULT '0',
  `actual_network` int unsigned DEFAULT '0',
  `minimum_mhz` bigint unsigned NOT NULL DEFAULT '0',
  `maximum_mhz` bigint unsigned NOT NULL DEFAULT '0',
  `actual_mhz` bigint unsigned NOT NULL DEFAULT '0',
  `cpu_cap` double unsigned NOT NULL DEFAULT '0',
  `ha_priority` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Sunucuların kurtarılma önceliği',
  `winrm_enabled` tinyint unsigned NOT NULL DEFAULT '0',
  `is_template` tinyint(1) NOT NULL DEFAULT '0',
  `is_snapshot` tinyint(1) NOT NULL DEFAULT '0',
  `is_lost` tinyint(1) NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `last_metadata_request` timestamp NULL DEFAULT NULL,
  `features` text,
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `hypervisor_session_id` varchar(255) DEFAULT NULL,
  `hypervisor_data` text,
  `metrics` text COMMENT 'metric bilgilerinin bulunduğu sütun.',
  `template_info` text,
  `datacenter_node_id` int unsigned NOT NULL,
  `compute_member_id` int unsigned DEFAULT NULL,
  `resident_on_id` int unsigned DEFAULT NULL,
  `snapshot_parent_id` bigint unsigned DEFAULT NULL,
  `product_id` int unsigned DEFAULT NULL,
  `product_catalog_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL COMMENT 'Sunucunun ne zaman suspend edildiği bilgisi',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtual_machines_uuid_datacenter_node_id_unique` (`uuid`,`datacenter_node_id`),
  UNIQUE KEY `virtual_machines_id_ref_unique` (`id_ref`),
  KEY `virtual_machines_compute_member_id_foreign` (`compute_member_id`),
  KEY `virtual_machines_account_id_foreign` (`account_id`),
  KEY `virtual_machines_user_id_foreign` (`user_id`),
  KEY `virtual_machines_datacenter_node_id_foreign` (`datacenter_node_id`),
  KEY `virtual_machines_resident_on_id_foreign` (`resident_on_id`),
  CONSTRAINT `virtual_machines_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `virtual_machines_compute_member_id_foreign` FOREIGN KEY (`compute_member_id`) REFERENCES `compute_members` (`id`),
  CONSTRAINT `virtual_machines_datacenter_node_id_foreign` FOREIGN KEY (`datacenter_node_id`) REFERENCES `datacenter_nodes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `virtual_machines_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2980 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `virtual_machines_overview`
--

DROP TABLE IF EXISTS `virtual_machines_overview`;
/*!50001 DROP VIEW IF EXISTS `virtual_machines_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `virtual_machines_overview` AS SELECT 
 1 AS `id`,
 1 AS `id_ref`,
 1 AS `name`,
 1 AS `hostname`,
 1 AS `os`,
 1 AS `distro`,
 1 AS `domain_type`,
 1 AS `winrm_enabled`,
 1 AS `is_locked`,
 1 AS `is_lost`,
 1 AS `status`,
 1 AS `actual_cpu`,
 1 AS `actual_ram`,
 1 AS `actual_disk`,
 1 AS `actual_network`,
 1 AS `product_id`,
 1 AS `product_catalog_id`,
 1 AS `ip_addr`,
 1 AS `network_count`,
 1 AS `connected_to`,
 1 AS `datacenter_node_id`,
 1 AS `datacenter_node_name`,
 1 AS `account_id`,
 1 AS `user_id`,
 1 AS `last_metadata_request`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `virtual_network_card_histories`
--

DROP TABLE IF EXISTS `virtual_network_card_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_network_card_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `historyable_id` bigint unsigned NOT NULL,
  `historyable_type` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `body` longtext NOT NULL,
  `hash` varchar(44) NOT NULL,
  `operation` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `virtual_network_card_histories_hid_htype_index` (`historyable_id`,`historyable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6978 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `virtual_network_cards`
--

DROP TABLE IF EXISTS `virtual_network_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `virtual_network_cards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `uuid` varchar(255) NOT NULL DEFAULT '',
  `device_number` tinyint unsigned NOT NULL DEFAULT '0',
  `mac_addr` char(17) DEFAULT NULL,
  `bandwidth_limit` int unsigned NOT NULL DEFAULT '0',
  `is_attached` tinyint(1) NOT NULL DEFAULT '0',
  `ha_priority` tinyint unsigned NOT NULL DEFAULT '0',
  `features` text,
  `hypervisor_uuid` varchar(255) DEFAULT NULL,
  `hypervisor_session_id` varchar(255) DEFAULT NULL,
  `hypervisor_data` text,
  `metrics` text COMMENT 'metric bilgilerinin bulunduğu sütun.',
  `network_id` int unsigned NOT NULL,
  `virtual_machine_id` bigint unsigned DEFAULT NULL,
  `account_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtual_network_cards_uuid_unique` (`uuid`),
  UNIQUE KEY `virtual_network_cards_id_ref_unique` (`id_ref`),
  KEY `virtual_network_cards_network_id_foreign` (`network_id`),
  KEY `virtual_network_cards_account_id_foreign` (`account_id`),
  KEY `virtual_network_cards_user_id_foreign` (`user_id`),
  KEY `virtual_network_cards_vm_id_foreign` (`virtual_machine_id`),
  CONSTRAINT `virtual_network_cards_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `virtual_network_cards_network_id_foreign` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `virtual_network_cards_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `virtual_network_cards_vm_id_foreign` FOREIGN KEY (`virtual_machine_id`) REFERENCES `virtual_machines` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2505 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `votes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `value` tinyint NOT NULL,
  `voteable_id` int unsigned NOT NULL,
  `voteable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `voter` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `votes_voter_foreign` (`voter`),
  CONSTRAINT `votes_voter_foreign` FOREIGN KEY (`voter`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_objects`
--

DROP TABLE IF EXISTS `web_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_objects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned DEFAULT NULL COMMENT 'If optimized, original file id.',
  `domain_id` bigint unsigned DEFAULT NULL,
  `id_ref` char(36) DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `alt` varchar(500) DEFAULT NULL,
  `filename` varchar(500) NOT NULL,
  `mime` varchar(50) DEFAULT NULL,
  `is_optimized` tinyint(1) NOT NULL DEFAULT '0',
  `width` mediumint DEFAULT NULL,
  `height` mediumint DEFAULT NULL,
  `other_information` json DEFAULT NULL,
  `hash` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `web_objects_domain_id_foreign` (`domain_id`),
  CONSTRAINT `web_objects_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1077 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`10.100.0.105`*/ /*!50003 TRIGGER `before_insert_web_objects` BEFORE INSERT ON `web_objects` FOR EACH ROW SET new.id_ref = uuid() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `web_page_block_contents`
--

DROP TABLE IF EXISTS `web_page_block_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_page_block_contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `web_page_block_id` bigint unsigned NOT NULL,
  `content` json NOT NULL,
  `extraversion` smallint NOT NULL DEFAULT '0',
  `sensing` smallint NOT NULL DEFAULT '0',
  `thinking` smallint NOT NULL DEFAULT '0',
  `judging` smallint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_page_block_contents_id_ref_unique` (`id_ref`),
  KEY `web_page_block_contents_web_page_block_id_foreign` (`web_page_block_id`),
  CONSTRAINT `web_page_block_contents_web_page_block_id_foreign` FOREIGN KEY (`web_page_block_id`) REFERENCES `web_page_blocks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=699 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_page_blocks`
--

DROP TABLE IF EXISTS `web_page_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_page_blocks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `web_page_id` bigint unsigned NOT NULL,
  `web_site_component_id` bigint unsigned NOT NULL,
  `order` mediumint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_page_blocks_id_ref_unique` (`id_ref`),
  KEY `web_page_blocks_web_page_id_foreign` (`web_page_id`),
  KEY `web_page_blocks_web_site_component_id_foreign` (`web_site_component_id`),
  CONSTRAINT `web_page_blocks_web_page_id_foreign` FOREIGN KEY (`web_page_id`) REFERENCES `web_pages` (`id`),
  CONSTRAINT `web_page_blocks_web_site_component_id_foreign` FOREIGN KEY (`web_site_component_id`) REFERENCES `web_site_components` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=740 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_pages`
--

DROP TABLE IF EXISTS `web_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `web_site_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned DEFAULT NULL COMMENT 'category id',
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `description` varchar(500) NOT NULL,
  `keywords` varchar(500) NOT NULL,
  `og_image` varchar(500) NOT NULL,
  `og_url` varchar(500) NOT NULL,
  `slug` varchar(1000) NOT NULL,
  `meta_title` varchar(500) DEFAULT NULL,
  `meta_keywords` varchar(500) DEFAULT NULL,
  `meta_description` varchar(500) DEFAULT NULL,
  `meta_robots` varchar(200) DEFAULT NULL,
  `meta_viewport` varchar(500) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `order` smallint unsigned NOT NULL DEFAULT '1',
  `is_published` tinyint DEFAULT '0',
  `comments` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_pages_id_ref_unique` (`id_ref`),
  KEY `web_pages_web_site_id_foreign` (`web_site_id`),
  KEY `web_pages_user_id_foreign` (`user_id`),
  KEY `web_pages_category_id_fk` (`category_id`),
  CONSTRAINT `web_pages_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `web_pages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `web_pages_web_site_id_foreign` FOREIGN KEY (`web_site_id`) REFERENCES `web_sites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_site_components`
--

DROP TABLE IF EXISTS `web_site_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_site_components` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `web_site_id` bigint unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `default_content` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_site_components_id_ref_unique` (`id_ref`),
  KEY `web_site_components_web_site_id_foreign` (`web_site_id`),
  CONSTRAINT `web_site_components_web_site_id_foreign` FOREIGN KEY (`web_site_id`) REFERENCES `web_sites` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_sites`
--

DROP TABLE IF EXISTS `web_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_sites` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` bigint unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `gitlab_url` varchar(1000) NOT NULL,
  `gitlab_project_url` int unsigned NOT NULL,
  `gitlab_private_token` varchar(50) NOT NULL,
  `components_path` varchar(500) NOT NULL,
  `homepage_id` bigint unsigned DEFAULT NULL,
  `locale` varchar(3) DEFAULT 'en',
  `hreflang` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `seo_robots_txt` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`),
  KEY `web_sites_homepage_fk` (`homepage_id`),
  CONSTRAINT `web_sites_domain_id_foreign` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`),
  CONSTRAINT `web_sites_homepage_fk` FOREIGN KEY (`homepage_id`) REFERENCES `web_pages` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_visitors`
--

DROP TABLE IF EXISTS `web_visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_visitors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_ref` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `matomo_visitor_id` char(50) DEFAULT NULL,
  `unique_visitor_id` char(50) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `web_visitors_id_ref_unique` (`id_ref`),
  KEY `web_visitors_user_id_foreign` (`user_id`),
  CONSTRAINT `web_visitors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=700 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_visitors_personality`
--

DROP TABLE IF EXISTS `web_visitors_personality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_visitors_personality` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `web_visitor_id` bigint unsigned NOT NULL,
  `personality` varchar(10) DEFAULT NULL COMMENT '16 mbti kişilik türünü gösterir',
  `extraversion` smallint NOT NULL DEFAULT '0' COMMENT '(-100) İçe dönük- Dışa dönük (+100) özelliğini gösterir.',
  `sensing` smallint NOT NULL DEFAULT '0' COMMENT '(-100) Sezgisel - Duyusal  (+100) özelliğini gösterir ',
  `thinking` smallint NOT NULL DEFAULT '0' COMMENT '(-100)  Hissetme - Düşünme (+100) özelliğini gösterir ',
  `judging` smallint NOT NULL DEFAULT '0' COMMENT '(-100)  Algısal - Yargısal (+100) özelliğini gösterir ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `web_visitors_personality_web_visitor_id_index` (`web_visitor_id`),
  CONSTRAINT `web_visitors_personality_web_visitor_id_foreign` FOREIGN KEY (`web_visitor_id`) REFERENCES `web_visitors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=584 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `account_usage_report_view`
--

/*!50001 DROP VIEW IF EXISTS `account_usage_report_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `account_usage_report_view` AS select `A`.`id_ref` AS `account_id`,`A`.`name` AS `account_name`,`DN`.`id_ref` AS `datacenter_node_id`,`DN`.`name` AS `datacenter_node_name`,sum(`VM`.`total_cpu`) AS `used_cpu`,sum(`VM`.`actual_cpu`) AS `actual_cpu`,sum(`VM`.`total_ram`) AS `used_ram`,sum(`VM`.`actual_ram`) AS `actual_ram`,sum(`VM`.`total_disk`) AS `used_disk`,sum(`VM`.`actual_disk`) AS `actutal_disk`,`CP`.`cpu_hourly_price` AS `cpu_hourly_price`,`CP`.`ram_hourly_price` AS `ram_hourly_price`,`CP`.`hdd_hourly_price` AS `hdd_hourly_price`,(sum(`VM`.`total_cpu`) * `CP`.`cpu_hourly_price`) AS `used_cpu_hourly_price`,(sum(`VM`.`total_ram`) * `CP`.`ram_hourly_price`) AS `used_ram_hourly_price`,(sum(`VM`.`actual_disk`) * `CP`.`hdd_hourly_price`) AS `used_hdd_hourly_price`,(((sum(`VM`.`total_cpu`) * `CP`.`cpu_hourly_price`) * 24) * 30) AS `used_cpu_monthly_price`,(((sum(`VM`.`total_ram`) * `CP`.`ram_hourly_price`) * 24) * 30) AS `used_ram_monthly_price`,(((sum(`VM`.`actual_disk`) * `CP`.`hdd_hourly_price`) * 24) * 30) AS `used_hdd_monthly_price`,`CP`.`currency_code` AS `currency_code` from (((`accounts` `A` join `virtual_machines` `VM` on(((`VM`.`account_id` = `A`.`id`) and (`VM`.`deleted_at` is null)))) join `datacenter_nodes` `DN` on(((`DN`.`id` = `VM`.`datacenter_node_id`) and (`DN`.`deleted_at` is null)))) join `compute_pools` `CP` on(((`CP`.`id` = `DN`.`compute_pool_id`) and (`CP`.`deleted_at` is null)))) where (`A`.`deleted_at` is null) group by `A`.`id`,`VM`.`datacenter_node_id` order by `A`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `active_customers`
--

/*!50001 DROP VIEW IF EXISTS `active_customers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `active_customers` AS select `accounts`.`id` AS `id`,`accounts`.`id_ref` AS `id_ref`,`accounts`.`name` AS `name`,`accounts`.`balance` AS `balance`,`accounts`.`currency_code` AS `currency_code`,`accounts`.`credit` AS `credit`,`accounts`.`credit_currency_code` AS `credit_currency_code`,`accounts`.`risk_level` AS `risk_level`,`accounts`.`is_team` AS `is_team`,(select `u`.`id` from `users` `u` where (`u`.`id` = `accounts`.`owner_id`)) AS `owner_id`,(select `u`.`id_ref` from `users` `u` where (`u`.`id` = `accounts`.`owner_id`)) AS `owner_id_ref`,(select `u`.`fullname` from `users` `u` where (`u`.`id` = `accounts`.`owner_id`)) AS `owner_name`,`acc`.`name` AS `representative_account_name`,`acc`.`id_ref` AS `representative_account_id_ref`,`acc`.`id` AS `representative_account_id`,`usr`.`fullname` AS `representative_user`,`usr`.`id_ref` AS `representative_user_id_ref`,`usr`.`id` AS `representative_user_id`,`accounts`.`account_type_id` AS `account_type_id`,`cad`.`last_invoice_date` AS `last_invoice_date`,`cad`.`last_invoice_amount` AS `last_invoice_amount`,`accounts`.`suspended_at` AS `suspended_at`,`accounts`.`created_at` AS `created_at` from ((((`accounts` join `crm_account_data` `cad` on((`accounts`.`id` = `cad`.`account_id`))) join `billing_account_informations` `bai` on((`accounts`.`id` = `bai`.`account_id`))) join `accounts` `acc` on((`acc`.`id` = `cad`.`customer_of_account`))) join `users` `usr` on((`usr`.`id` = `cad`.`customer_of_user`))) where (`bai`.`is_active_customer` = true) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `compute_members_overview`
--

/*!50001 DROP VIEW IF EXISTS `compute_members_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `compute_members_overview` AS select `C`.`id` AS `id`,`C`.`id_ref` AS `id_ref`,`C`.`name` AS `name`,`C`.`hostname` AS `hostname`,`C`.`ip_addr` AS `ip_addr`,`C`.`management_url` AS `management_url`,`C`.`port` AS `port`,`C`.`hypervisor_uuid` AS `hypervisor_uuid`,`C`.`total_cpu` AS `total_cpu`,`C`.`total_ram` AS `total_ram`,`C`.`total_vm` AS `total_vm`,`C`.`used_cpu` AS `used_cpu`,`C`.`used_ram` AS `used_ram`,`C`.`is_alive` AS `is_alive`,`C`.`compute_pool_id` AS `compute_pool_id`,`CP`.`id_ref` AS `compute_pool_id_ref`,`CP`.`name` AS `compute_pool_name`,`CP`.`management_type` AS `compute_pool_management_type`,`CP`.`is_public` AS `compute_pool_is_public`,`DN`.`id` AS `datacenter_node_id`,`DN`.`id_ref` AS `datacenter_node_id_ref`,`DN`.`name` AS `datacenter_node_name`,`A`.`id` AS `vendor_id`,`A`.`id_ref` AS `vendor_id_ref`,`A`.`name` AS `vendor_name` from (((`compute_members` `C` join `compute_pools` `CP` on((`CP`.`id` = `C`.`compute_pool_id`))) left join `datacenter_nodes` `DN` on((`DN`.`compute_pool_id` = `CP`.`id`))) join `accounts` `A` on((`A`.`id` = `CP`.`vendor_id`))) where (`C`.`deleted_at` is null) order by `C`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `compute_pools_overview`
--

/*!50001 DROP VIEW IF EXISTS `compute_pools_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `compute_pools_overview` AS select `C`.`id` AS `id`,`C`.`id_ref` AS `id_ref`,`C`.`name` AS `name`,`C`.`resource_validator` AS `resource_validator`,`C`.`pool_type` AS `pool_type`,`C`.`master_ip_addr` AS `master_ip_addr`,`C`.`management_url` AS `management_url`,`C`.`port` AS `port`,`C`.`management_type` AS `management_type`,`C`.`virtualization` AS `virtualization`,`C`.`virtualization_version` AS `virtualization_version`,`C`.`provisioning_alg` AS `provisioning_alg`,`C`.`management_package_name` AS `management_package_name`,`C`.`is_active` AS `is_active`,`C`.`is_alive` AS `is_alive`,`C`.`is_public` AS `is_public`,`C`.`datacenter_id` AS `datacenter_id`,`D`.`id_ref` AS `datacenter_id_ref`,`D`.`name` AS `datacenter_name`,`DN`.`id` AS `datacenter_node_id`,`DN`.`id_ref` AS `datacenter_node_id_ref`,`DN`.`name` AS `datacenter_node_name`,`C`.`product_id` AS `product_id`,`P`.`id_ref` AS `product_id_ref`,`P`.`name` AS `product_name`,`C`.`vendor_id` AS `vendor_id`,`A`.`id_ref` AS `vendor_id_ref`,`A`.`name` AS `vendor_name` from ((((`compute_pools` `C` join `accounts` `A` on((`A`.`id` = `C`.`vendor_id`))) join `datacenters` `D` on((`D`.`id` = `C`.`datacenter_id`))) left join `products` `P` on((`P`.`id` = `C`.`product_id`))) left join `datacenter_nodes` `DN` on((`DN`.`compute_pool_id` = `C`.`id`))) where (`C`.`deleted_at` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crm_contact_overview`
--

/*!50001 DROP VIEW IF EXISTS `crm_contact_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `crm_contact_overview` AS select `c`.`id` AS `id`,`c`.`id_ref` AS `id_ref`,`c`.`account_id` AS `account_id`,`c`.`user_id` AS `user_id`,`c`.`customer_id` AS `customer_id`,`c`.`name` AS `name`,`c`.`surname` AS `surname`,`c`.`full_name` AS `full_name`,`c`.`position` AS `position`,`c`.`email` AS `email`,`c`.`cellphone` AS `cellphone`,`c`.`workphone` AS `workphone`,`c`.`workphone_extension` AS `workphone_extension`,`c`.`address` AS `address`,`c`.`gender` AS `gender`,`c`.`birthday` AS `birthday`,`l`.`source` AS `source`,`l`.`lead_source` AS `lead_source`,`l`.`lead_list_id` AS `lead_list_id`,`ll`.`name` AS `lead_list_name`,`l`.`state` AS `state`,`l`.`is_marketing_qualified` AS `is_marketing_qualified`,`l`.`is_sales_qualified` AS `is_sales_qualified`,`o`.`name` AS `organization_name`,`o`.`id_ref` AS `organization_id`,`c`.`created_at` AS `created_at`,`c`.`updated_at` AS `updated_at` from (((`contacts` `c` left join `leads` `l` on((`c`.`lead_id` = `l`.`id`))) left join `lead_lists` `ll` on((`l`.`lead_list_id` = `ll`.`id`))) left join `organizations` `o` on((`c`.`organization_id` = `o`.`id`))) order by `c`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crm_created_customers_overview`
--

/*!50001 DROP VIEW IF EXISTS `crm_created_customers_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `crm_created_customers_overview` AS select `a`.`id` AS `id`,`a`.`id_ref` AS `id_ref`,`a`.`name` AS `name`,`a`.`domain` AS `domain`,concat(`a`.`phone_code`,' ',`a`.`phone`) AS `phone_number`,`a`.`balance` AS `balance`,`a`.`currency_code` AS `currency_code`,`at`.`name` AS `account_type`,`cad`.`risk_level` AS `risk_level`,`cad`.`credit_score` AS `credit_score`,`cad`.`credit` AS `credit`,`cad`.`credit_override` AS `credit_override`,`a`.`approved_at` AS `approved_at`,`a`.`suspended_at` AS `suspended_at`,`a`.`created_at` AS `created_at`,`a`.`deleted_at` AS `deleted_at`,'unknown@unknown.com' AS `user_email`,'unknown' AS `user_username`,'unknown' AS `user_gender`,concat(`urep`.`name`,' ',`urep`.`surname`) AS `representative_user_name`,`urep`.`id` AS `representative_user_id`,concat(`arep`.`name`) AS `representative_account_name`,`arep`.`id` AS `representative_account_id` from (((((`accounts` `a` join `users` `rep` on((`rep`.`id` = `a`.`representative_id`))) join `account_types` `at` on((`a`.`account_type_id` = `at`.`id`))) join `crm_account_data` `cad` on((`a`.`id` = `cad`.`account_id`))) join `accounts` `arep` on((`cad`.`customer_of_account` = `arep`.`id`))) join `users` `urep` on((`cad`.`customer_of_user` = `urep`.`id`))) where ((`a`.`account_type_id` <> 8) and (`a`.`owner_id` is null)) order by `a`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crm_customer_iaas_usage_report`
--

/*!50001 DROP VIEW IF EXISTS `crm_customer_iaas_usage_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `crm_customer_iaas_usage_report` AS select `o`.`id_ref` AS `organization_id`,`o`.`name` AS `organization_name`,`o`.`representative_account_id` AS `representative_account_id`,`a`.`id_ref` AS `account_id`,(select sum(`i`.`amount`) from `invoices` `i` where ((`i`.`customer_id` = `a`.`id`) and (`i`.`is_paid` = 0))) AS `account_balance`,`a`.`currency_code` AS `account_currency_code`,`a`.`credit` AS `account_credit`,`u`.`id_ref` AS `responsible_user_id`,`u`.`fullname` AS `responsible_user`,`dn`.`name` AS `datacenter_node_name`,`vm`.`name` AS `vm_name`,`vm`.`actual_cpu` AS `vm_cpu`,`vm`.`actual_ram` AS `vm_ram`,`vm`.`actual_disk` AS `vm_disk`,`vm`.`status` AS `status` from ((((`accounts` `a` join `organizations` `o` on((`a`.`id` = `o`.`account_id`))) join `virtual_machines` `vm` on((`a`.`id` = `vm`.`account_id`))) join `datacenter_nodes` `dn` on((`vm`.`datacenter_node_id` = `dn`.`id`))) join `users` `u` on((`o`.`representative_user_id` = `u`.`id`))) where ((`vm`.`deleted_at` is null) and (`vm`.`is_template` = 0)) order by `a`.`id_ref` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crm_customer_overview`
--

/*!50001 DROP VIEW IF EXISTS `crm_customer_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `crm_customer_overview` AS select `crm_registered_customers_overview`.`id` AS `id`,`crm_registered_customers_overview`.`id_ref` AS `id_ref`,`crm_registered_customers_overview`.`name` AS `name`,`crm_registered_customers_overview`.`domain` AS `domain`,`crm_registered_customers_overview`.`phone_number` AS `phone_number`,`crm_registered_customers_overview`.`balance` AS `balance`,`crm_registered_customers_overview`.`currency_code` AS `currency_code`,`crm_registered_customers_overview`.`account_type` AS `account_type`,`crm_registered_customers_overview`.`risk_level` AS `risk_level`,`crm_registered_customers_overview`.`credit_score` AS `credit_score`,`crm_registered_customers_overview`.`credit` AS `credit`,`crm_registered_customers_overview`.`credit_override` AS `credit_override`,`crm_registered_customers_overview`.`approved_at` AS `approved_at`,`crm_registered_customers_overview`.`suspended_at` AS `suspended_at`,`crm_registered_customers_overview`.`created_at` AS `created_at`,`crm_registered_customers_overview`.`deleted_at` AS `deleted_at`,`crm_registered_customers_overview`.`user_email` AS `user_email`,`crm_registered_customers_overview`.`user_username` AS `user_username`,`crm_registered_customers_overview`.`user_gender` AS `user_gender`,`crm_registered_customers_overview`.`representative_user_name` AS `representative_user_name`,`crm_registered_customers_overview`.`representative_user_id` AS `representative_user_id`,`crm_registered_customers_overview`.`representative_account_name` AS `representative_account_name`,`crm_registered_customers_overview`.`representative_account_id` AS `representative_account_id` from `crm_registered_customers_overview` union select `crm_created_customers_overview`.`id` AS `id`,`crm_created_customers_overview`.`id_ref` AS `id_ref`,`crm_created_customers_overview`.`name` AS `name`,`crm_created_customers_overview`.`domain` AS `domain`,`crm_created_customers_overview`.`phone_number` AS `phone_number`,`crm_created_customers_overview`.`balance` AS `balance`,`crm_created_customers_overview`.`currency_code` AS `currency_code`,`crm_created_customers_overview`.`account_type` AS `account_type`,`crm_created_customers_overview`.`risk_level` AS `risk_level`,`crm_created_customers_overview`.`credit_score` AS `credit_score`,`crm_created_customers_overview`.`credit` AS `credit`,`crm_created_customers_overview`.`credit_override` AS `credit_override`,`crm_created_customers_overview`.`approved_at` AS `approved_at`,`crm_created_customers_overview`.`suspended_at` AS `suspended_at`,`crm_created_customers_overview`.`created_at` AS `created_at`,`crm_created_customers_overview`.`deleted_at` AS `deleted_at`,`crm_created_customers_overview`.`user_email` AS `user_email`,`crm_created_customers_overview`.`user_username` AS `user_username`,`crm_created_customers_overview`.`user_gender` AS `user_gender`,`crm_created_customers_overview`.`representative_user_name` AS `representative_user_name`,`crm_created_customers_overview`.`representative_user_id` AS `representative_user_id`,`crm_created_customers_overview`.`representative_account_name` AS `representative_account_name`,`crm_created_customers_overview`.`representative_account_id` AS `representative_account_id` from `crm_created_customers_overview` order by `id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crm_marketing_lists_contacts`
--

/*!50001 DROP VIEW IF EXISTS `crm_marketing_lists_contacts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `crm_marketing_lists_contacts` AS select `c`.`id_ref` AS `id`,`c`.`account_id` AS `account_id`,`c`.`user_id` AS `user_id`,`c`.`name` AS `name`,`c`.`surname` AS `surname`,`c`.`full_name` AS `full_name`,`c`.`email` AS `email`,`ml`.`id_ref` AS `marketing_list_id`,`ml`.`name` AS `marketing_list_name` from ((`contacts` `c` join `marketing_lists_contacts` `mlc` on((`c`.`id` = `mlc`.`contact_id`))) join `marketing_lists` `ml` on((`mlc`.`ml_id` = `ml`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crm_organizations_overview`
--

/*!50001 DROP VIEW IF EXISTS `crm_organizations_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `crm_organizations_overview` AS select `o`.`id_ref` AS `id`,`o`.`name` AS `name`,`o`.`domain` AS `domain`,`o`.`website` AS `website`,`o`.`phone_code` AS `phone_code`,`o`.`phone` AS `phone`,`c`.`name` AS `country_name`,`l`.`source` AS `source`,`l`.`lead_source` AS `lead_source`,`ll`.`id_ref` AS `lead_list_id`,`ll`.`name` AS `lead_list_name`,`l`.`state` AS `state`,`l`.`is_marketing_qualified` AS `is_marketing_qualified`,`l`.`is_sales_qualified` AS `is_sales_qualified`,`s`.`name` AS `segment_name`,`o`.`account_id` AS `account_id`,`a`.`id_ref` AS `representative_account_id`,`a`.`name` AS `representative_account_name`,`u`.`fullname` AS `representative_user_name`,`u`.`id_ref` AS `representative_user_id`,`o`.`created_at` AS `created_at` from ((((((`organizations` `o` left join `countries` `c` on((`o`.`country_id` = `c`.`id`))) left join `leads` `l` on((`o`.`lead_id` = `l`.`id`))) left join `lead_lists` `ll` on((`l`.`lead_list_id` = `ll`.`id`))) left join `segments` `s` on((`o`.`segment_id` = `s`.`id`))) join `accounts` `a` on((`o`.`representative_account_id` = `a`.`id`))) join `users` `u` on((`o`.`representative_user_id` = `u`.`id`))) where (`o`.`deleted_at` is null) order by `o`.`created_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crm_registered_customers_overview`
--

/*!50001 DROP VIEW IF EXISTS `crm_registered_customers_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `crm_registered_customers_overview` AS select `a`.`id` AS `id`,`a`.`id_ref` AS `id_ref`,`a`.`name` AS `name`,`a`.`domain` AS `domain`,concat(`a`.`phone_code`,' ',`a`.`phone`) AS `phone_number`,`a`.`balance` AS `balance`,`a`.`currency_code` AS `currency_code`,`at`.`name` AS `account_type`,`cad`.`risk_level` AS `risk_level`,`cad`.`credit_score` AS `credit_score`,`cad`.`credit` AS `credit`,`cad`.`credit_override` AS `credit_override`,`a`.`approved_at` AS `approved_at`,`a`.`suspended_at` AS `suspended_at`,`a`.`created_at` AS `created_at`,`a`.`deleted_at` AS `deleted_at`,`u`.`email` AS `user_email`,`u`.`username` AS `user_username`,`u`.`gender` AS `user_gender`,concat(`urep`.`name`,' ',`urep`.`surname`) AS `representative_user_name`,`urep`.`id` AS `representative_user_id`,concat(`arep`.`name`) AS `representative_account_name`,`arep`.`id` AS `representative_account_id` from (((((((`accounts` `a` join `users` `rep` on((`rep`.`id` = `a`.`representative_id`))) join `account_types` `at` on((`a`.`account_type_id` = `at`.`id`))) join `crm_account_data` `cad` on((`a`.`id` = `cad`.`account_id`))) join `accounts` `arep` on((`cad`.`customer_of_account` = `arep`.`id`))) join `users` `urep` on((`cad`.`customer_of_user` = `urep`.`id`))) join `account_user` `au` on((`a`.`id` = `au`.`account_id`))) join `users` `u` on((`au`.`user_id` = `u`.`id`))) where (`a`.`account_type_id` <> 8) order by `a`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `datacenter_node_usage_report_view`
--

/*!50001 DROP VIEW IF EXISTS `datacenter_node_usage_report_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `datacenter_node_usage_report_view` AS select `DN`.`id_ref` AS `datacenter_node_id`,`DN`.`name` AS `datacenter_node_name`,sum(`CM`.`total_vm`) AS `running_vm`,sum(`CM`.`used_cpu`) AS `used_cpu`,sum(`CM`.`total_ram`) AS `total_ram`,sum(`CM`.`used_ram`) AS `used_ram`,sum((`CM`.`total_ram` - `CM`.`used_ram`)) AS `free_ram`,`CP`.`cpu_hourly_price` AS `cpu_hourly_price`,`CP`.`ram_hourly_price` AS `ram_hourly_price`,`CP`.`hdd_hourly_price` AS `hdd_hourly_price`,(sum(`CM`.`used_cpu`) * `CP`.`cpu_hourly_price`) AS `used_cpu_hourly_price`,(sum(`CM`.`used_ram`) * `CP`.`ram_hourly_price`) AS `used_ram_hourly_price`,(((sum(`CM`.`used_cpu`) * `CP`.`cpu_hourly_price`) * 24) * 30) AS `used_cpu_monthly_price`,(((sum(`CM`.`used_ram`) * `CP`.`ram_hourly_price`) * 24) * 30) AS `used_ram_monthly_price` from ((`datacenter_nodes` `DN` join `compute_pools` `CP` on(((`CP`.`id` = `DN`.`compute_pool_id`) and (`CP`.`deleted_at` is null)))) join `compute_members` `CM` on(((`CM`.`compute_pool_id` = `CP`.`id`) and (`CM`.`deleted_at` is null)))) where (`DN`.`deleted_at` is null) group by `DN`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `datacenter_nodes_overview`
--

/*!50001 DROP VIEW IF EXISTS `datacenter_nodes_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `datacenter_nodes_overview` AS select `DN`.`id` AS `id`,`DN`.`id_ref` AS `id_ref`,`DN`.`name` AS `name`,`DN`.`slug` AS `slug`,`DN`.`pricing_model` AS `pricing_model`,`DN`.`is_active` AS `is_active`,`DN`.`is_edge` AS `is_edge`,`DN`.`is_public` AS `is_public`,`DN`.`maintenance_mode` AS `maintenance_mode`,`DN`.`min_cpu_limit` AS `min_cpu_limit`,`DN`.`max_cpu_limit` AS `max_cpu_limit`,`DN`.`min_ram_limit` AS `min_ram_limit`,`DN`.`max_ram_limit` AS `max_ram_limit`,`DN`.`position` AS `position`,`DNT`.`description` AS `description`,`DNT`.`features` AS `features`,`DNT`.`locale` AS `locale`,(select group_concat(`T`.`slug`,',' separator ',') AS `tag` from (`tags` `T` join `taggables` `TA` on(((`TA`.`tag_id` = `T`.`id`) and (`TA`.`taggable_type` = 'PlusClouds\\IAAS\\Database\\Models\\DatacenterNode')))) where (`TA`.`taggable_id` = `DN`.`id`)) AS `tags`,`D`.`id_ref` AS `datacenter_id`,`D`.`name` AS `datacenter_name`,`D`.`city` AS `datacenter_city`,`CP`.`id_ref` AS `compute_pool_id`,`CP`.`name` AS `compute_pool_name`,`P`.`id_ref` AS `product_id`,`P`.`name` AS `product_name`,`C`.`code` AS `country_code`,`C`.`name` AS `country_name`,`A`.`id_ref` AS `account_id`,`A`.`name` AS `account_name` from ((((((`datacenter_nodes` `DN` left join `datacenter_node_translations` `DNT` on((`DNT`.`datacenter_node_id` = `DN`.`id`))) join `accounts` `A` on((`A`.`id` = `DN`.`vendor_id`))) join `datacenters` `D` on((`D`.`id` = `DN`.`datacenter_id`))) left join `compute_pools` `CP` on((`CP`.`id` = `DN`.`compute_pool_id`))) left join `products` `P` on((`P`.`id` = `DN`.`product_id`))) left join `countries` `C` on((`C`.`id` = `D`.`country_id`))) where (`DN`.`deleted_at` is null) order by (`DN`.`position` is null),`DN`.`position`,`DN`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `datacenters_overview`
--

/*!50001 DROP VIEW IF EXISTS `datacenters_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `datacenters_overview` AS select `D`.`id` AS `id`,`D`.`id_ref` AS `id_ref`,`D`.`name` AS `name`,`D`.`slug` AS `slug`,`D`.`uuid_prefix` AS `uuid_prefix`,`D`.`is_default` AS `is_default`,`D`.`is_active` AS `is_active`,`D`.`is_public` AS `is_public`,`D`.`is_edge` AS `is_edge`,`D`.`maintenance_mode` AS `maintenance_mode`,(select `C`.`name` from `countries` `C` where (`C`.`id` = `D`.`country_id`)) AS `country_name`,`D`.`city` AS `city`,`DT`.`description` AS `description`,`DT`.`security` AS `security`,`DT`.`electricity` AS `electricity`,`DT`.`generators` AS `generators`,`D`.`geo_latitude` AS `geo_latitude`,`D`.`geo_longitude` AS `geo_longitude`,`D`.`tier_level` AS `tier_level`,`D`.`total_capacity` AS `total_capacity`,`D`.`guaranteed_uptime` AS `guaranteed_uptime`,`D`.`carrier_neutral` AS `carrier_neutral`,`D`.`local_area_network_capacity` AS `local_area_network_capacity`,`D`.`power_source` AS `power_source`,`D`.`ups` AS `ups`,`D`.`cooling` AS `cooling`,`D`.`position` AS `position`,`DT`.`locale` AS `locale`,`D`.`vendor_id` AS `vendor_id`,`A`.`id_ref` AS `vendor_id_ref`,`A`.`name` AS `vendor_name` from ((`datacenters` `D` left join `datacenter_translations` `DT` on((`DT`.`datacenter_id` = `D`.`id`))) join `accounts` `A` on((`A`.`id` = `D`.`vendor_id`))) where (`D`.`deleted_at` is null) order by (`D`.`position` is null),`D`.`position`,`D`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `invoices_overview`
--

/*!50001 DROP VIEW IF EXISTS `invoices_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `invoices_overview` AS select `invoices`.`id` AS `invoice_id`,`invoices`.`id_ref` AS `invoice_id_ref`,`a`.`id` AS `account_id`,`c`.`id` AS `customer_id`,`a`.`id_ref` AS `account_id_ref`,`c`.`id_ref` AS `customer_id_ref`,`c`.`name` AS `customer_name`,`invoices`.`amount` AS `amount`,`invoices`.`vat` AS `vat`,`invoices`.`currency_code` AS `currency_code`,`invoices`.`exchange_rate` AS `exchange_rate`,`invoices`.`is_paid` AS `is_paid`,`invoices`.`is_refund` AS `is_refund`,`invoices`.`note` AS `note`,`invoices`.`custom_invoice_number` AS `custom_invoice_number`,`invoices`.`invoice_number` AS `invoice_number`,`invoices`.`detailed_report` AS `detailed_report`,`invoices`.`invoice_date` AS `invoice_date`,`invoices`.`invoice_due_date` AS `invoice_due_date`,`invoices`.`invoice_paid_date` AS `invoice_paid_date`,`invoices`.`created_at` AS `created_at` from ((`invoices` join `accounts` `a` on((`invoices`.`account_id` = `a`.`id`))) join `accounts` `c` on((`c`.`id` = `invoices`.`customer_id`))) order by `invoices`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ip_addresses_overview`
--

/*!50001 DROP VIEW IF EXISTS `ip_addresses_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `ip_addresses_overview` AS select distinct `ip`.`id` AS `id`,`ip`.`id_ref` AS `id_ref`,`ip`.`ip_addr` AS `ip_addr`,`ip`.`version` AS `version`,`ip`.`is_reserved` AS `is_reserved`,`ip`.`is_reachable` AS `is_reachable`,`ip`.`is_public` AS `is_public`,`dn`.`id` AS `datacenter_node_id`,`dn`.`id_ref` AS `datacenter_node_id_ref`,`dn`.`name` AS `datacenter_node_name`,`ntw`.`id` AS `network_id`,`ntw`.`id_ref` AS `network_id_ref`,`ntw`.`name` AS `network_name`,`ntw`.`vlan` AS `network_vlan`,`ntw`.`ip_addr` AS `network_ip_addr`,`ntw`.`ip_range_start` AS `network_ip_range_start`,`ntw`.`ip_range_end` AS `network_ip_range_end`,`ntw`.`gateway` AS `network_gateway`,`ntw`.`subnet` AS `network_subnet`,`ntw`.`netmask` AS `network_netmask`,`ntw`.`network` AS `network_network`,`ntw`.`dns_nameservers` AS `network_dns_nameservers`,`ntw`.`mtu` AS `network_mtu`,`vif`.`id` AS `vif_id`,`vif`.`id_ref` AS `vif_id_ref`,`vif`.`name` AS `vif_name`,`vif`.`device_number` AS `vif_device_number`,`vif`.`mac_addr` AS `vif_mac_addr`,`vif`.`is_attached` AS `vif_is_attached`,`vm`.`id` AS `vm_id`,`vm`.`id_ref` AS `vm_id_ref`,`vm`.`name` AS `vm_name`,`vm`.`os` AS `vm_os`,`vm`.`distro` AS `vm_distro`,`vm`.`version` AS `vm_version`,`vm`.`status` AS `vm_status`,`vm`.`total_cpu` AS `vm_total_cpu`,`vm`.`total_ram` AS `vm_total_ram`,`vm`.`total_disk` AS `vm_total_disk`,`vm`.`total_network` AS `vm_total_network`,`vm`.`actual_cpu` AS `vm_actual_cpu`,`vm`.`actual_ram` AS `vm_actual_ram`,`vm`.`actual_disk` AS `vm_actual_disk`,`vm`.`actual_network` AS `vm_actual_network`,`vm`.`domain_type` AS `vm_domain_type`,`vm`.`is_template` AS `vm_is_template`,`vm`.`is_snapshot` AS `vm_is_snapshot`,`vm`.`is_locked` AS `vm_is_locked`,`vm`.`is_lost` AS `vm_is_lost`,`ip`.`account_id` AS `account_id`,`A`.`id_ref` AS `account_id_ref`,`A`.`name` AS `account_name` from ((((((`ip_addresses` `ip` left join `networks` `ntw` on((`ntw`.`id` = `ip`.`network_id`))) left join `datacenter_node_networks` `dnn` on((`dnn`.`network_id` = `ntw`.`id`))) left join `datacenter_nodes` `dn` on((`dn`.`id` = `dnn`.`datacenter_node_id`))) left join `virtual_network_cards` `vif` on((`vif`.`id` = `ip`.`virtual_network_card_id`))) left join `virtual_machines` `vm` on((`vm`.`id` = `vif`.`virtual_machine_id`))) join `accounts` `A` on((`A`.`id` = `ip`.`account_id`))) where ((`dn`.`deleted_at` is null) and (`vm`.`deleted_at` is null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `marketing_campaign_contacts`
--

/*!50001 DROP VIEW IF EXISTS `marketing_campaign_contacts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `marketing_campaign_contacts` AS select `c`.`id_ref` AS `id`,`c`.`name` AS `name`,`c`.`surname` AS `surname`,`c`.`full_name` AS `fullname`,`c`.`email` AS `email`,`c`.`cellphone` AS `cellphone`,`c`.`workphone` AS `workphone`,`mc`.`id_ref` AS `campaign_id`,`mc`.`name` AS `campaign_name` from ((((`marketing_campaigns` `mc` join `marketing_campaign_marketing_lists` `mcml` on((`mc`.`id` = `mcml`.`mc_id`))) join `marketing_lists` `ml` on((`mcml`.`ml_id` = `ml`.`id`))) join `marketing_lists_contacts` `mlc` on((`ml`.`id` = `mlc`.`ml_id`))) join `contacts` `c` on((`mlc`.`contact_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `netgateways_overview`
--

/*!50001 DROP VIEW IF EXISTS `netgateways_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `netgateways_overview` AS select distinct `ngw`.`id` AS `id`,`ngw`.`id_ref` AS `id_ref`,`ngw`.`name` AS `name`,`net`.`name` AS `managed_network`,`ngw`.`type` AS `type`,`a`.`id` AS `account_id`,`a`.`id_ref` AS `account_id_ref`,`ngw`.`virtual_machine_id` AS `virtual_machine_id`,`vm`.`id_ref` AS `virtual_machine_id_ref`,`vm`.`is_locked` AS `is_locked`,`vm`.`status` AS `status`,`ngw`.`is_connected` AS `is_connected`,`ngw`.`is_usable` AS `is_usable`,`ngw`.`is_connection_secure` AS `is_connection_secure`,(select `ipa`.`ip_addr` from (((`netgateways` `ngw2` join `virtual_machines` `vm2` on((`ngw2`.`virtual_machine_id` = `vm2`.`id`))) join `virtual_network_cards` `vnc2` on((`vm2`.`id` = `vnc2`.`virtual_machine_id`))) join `ip_addresses` `ipa` on((`vnc2`.`id` = `ipa`.`virtual_network_card_id`))) where ((`ngw2`.`id` = `ngw`.`id`) and (`vnc2`.`device_number` = 0))) AS `ip_addr` from ((((`netgateways` `ngw` join `virtual_machines` `vm` on((`ngw`.`virtual_machine_id` = `vm`.`id`))) join `virtual_network_cards` `vnc` on((`vm`.`id` = `vnc`.`virtual_machine_id`))) join `networks` `net` on((`vnc`.`network_id` = `net`.`id`))) join `accounts` `a` on((`ngw`.`account_id` = `a`.`id`))) where ((`ngw`.`deleted_at` is null) and (`vnc`.`device_number` = 1) and (`vnc`.`deleted_at` is null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `networks_overview`
--

/*!50001 DROP VIEW IF EXISTS `networks_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `networks_overview` AS select `N`.`id` AS `id`,`N`.`id_ref` AS `id_ref`,if((`DN`.`name` is not null),concat(`N`.`name`,' on ',`DN`.`name`),`N`.`name`) AS `name`,`N`.`vlan` AS `vlan`,`N`.`mtu` AS `mtu`,`N`.`network_type` AS `network_type`,`N`.`ip_addr` AS `ip_addr`,`N`.`ip_range_start` AS `ip_range_start`,`N`.`ip_range_end` AS `ip_range_end`,`N`.`gateway` AS `gateway`,`N`.`subnet` AS `subnet`,`N`.`netmask` AS `netmask`,`N`.`network` AS `network`,`N`.`dns_nameservers` AS `dns_nameservers`,`N`.`local_domain` AS `local_domain`,`N`.`is_bridge` AS `is_bridge`,`N`.`is_virtual_network` AS `is_virtual_network`,`N`.`is_interroutable` AS `is_interroutable`,`N`.`is_default_pif` AS `is_default_pif`,`N`.`is_master_record` AS `is_master_record`,`N`.`is_visible` AS `is_visible`,`N`.`network_pool_id` AS `network_pool_id`,`NP`.`id_ref` AS `network_pool_id_ref`,`NP`.`name` AS `network_pool_name`,`DN`.`id` AS `datacenter_node_id`,`DN`.`id_ref` AS `datacenter_node_id_ref`,`DN`.`name` AS `datacenter_node_name`,`N`.`dhcp_server_id` AS `dhcp_server_id`,`DS`.`id_ref` AS `dhcp_server_id_ref`,`DS`.`name` AS `dhcp_server_name`,`N`.`proxy_server_id` AS `proxy_server_id`,`PS`.`id_ref` AS `proxy_server_id_ref`,`PS`.`name` AS `proxy_server_name`,`N`.`nat_server_id` AS `nat_server_id`,`NS`.`id_ref` AS `nat_server_id_ref`,`NS`.`name` AS `nat_server_name`,`N`.`domain_id` AS `domain_id`,`D`.`id_ref` AS `domain_id_ref`,`D`.`name` AS `domain_name`,`N`.`account_id` AS `account_id`,`A`.`id_ref` AS `account_id_ref`,`A`.`name` AS `account_name` from ((((((((`networks` `N` join `network_pools` `NP` on((`NP`.`id` = `N`.`network_pool_id`))) left join `dhcp_servers` `DS` on((`DS`.`id` = `N`.`dhcp_server_id`))) left join `proxy_servers` `PS` on((`PS`.`id` = `N`.`proxy_server_id`))) left join `nat_servers` `NS` on((`NS`.`id` = `N`.`nat_server_id`))) left join `domains` `D` on((`D`.`id` = `N`.`domain_id`))) join `accounts` `A` on((`A`.`id` = `N`.`account_id`))) left join `datacenter_node_networks` `DNN` on((`DNN`.`network_id` = `N`.`id`))) left join `datacenter_nodes` `DN` on((`DN`.`id` = `DNN`.`datacenter_node_id`))) where (`N`.`deleted_at` is null) group by `N`.`id`,`DNN`.`datacenter_node_id` order by `N`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `projects_overview`
--

/*!50001 DROP VIEW IF EXISTS `projects_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `projects_overview` AS select `p`.`id` AS `id`,`p`.`id_ref` AS `id_ref`,`p`.`name` AS `name`,`p`.`description` AS `description`,`p`.`start` AS `start`,`p`.`end` AS `end`,`p`.`status` AS `status`,`p`.`gitlab_url` AS `gitlab_url`,`p`.`priority` AS `priority`,`p`.`type` AS `type`,`a`.`name` AS `account_name`,`c`.`name` AS `customer_name`,`l`.`name` AS `leads_name`,`u`.`fullname` AS `created_by`,`u`.`id` AS `user_id`,`u`.`id_ref` AS `user_id_ref`,`c`.`id` AS `customer_id`,`c`.`id_ref` AS `customer_id_ref`,`l`.`id` AS `lead_id`,`l`.`id_ref` AS `lead_id_ref`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at` from ((((`projects` `p` left join `accounts` `a` on((`p`.`account_id` = `a`.`id`))) left join `accounts` `c` on((`p`.`customer_id` = `c`.`id`))) left join `leads` `l` on((`p`.`lead_id` = `l`.`id`))) left join `users` `u` on((`p`.`user_id` = `u`.`id`))) where (`p`.`deleted_at` is null) order by `p`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `storage_volume_usage_report_view`
--

/*!50001 DROP VIEW IF EXISTS `storage_volume_usage_report_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `storage_volume_usage_report_view` AS select `SV`.`id_ref` AS `storage_volume_id`,`SV`.`name` AS `storage_volume_name`,`DN`.`id_ref` AS `datacenter_node_id`,`DN`.`name` AS `datacenter_node_name`,sum(`SV`.`total_hdd`) AS `total_hdd`,sum(`SV`.`used_hdd`) AS `used_hdd`,sum((`SV`.`total_hdd` - `SV`.`used_hdd`)) AS `free_hdd`,`CP`.`hdd_hourly_price` AS `hdd_hourly_price`,(sum(`SV`.`used_hdd`) * `CP`.`hdd_hourly_price`) AS `used_hdd_hourly_price`,(((sum(`SV`.`used_hdd`) * `CP`.`hdd_hourly_price`) * 24) * 30) AS `used_hdd_monthly_price` from (((`storage_volumes` `SV` join `datacenter_node_storage_volumes` `DNSV` on((`DNSV`.`storage_volume_id` = `SV`.`id`))) join `datacenter_nodes` `DN` on(((`DN`.`id` = `DNSV`.`datacenter_node_id`) and (`DN`.`deleted_at` is null)))) join `compute_pools` `CP` on(((`CP`.`id` = `DN`.`compute_pool_id`) and (`CP`.`deleted_at` is null)))) where ((`SV`.`deleted_at` is null) and (`CP`.`pool_type` <> 'FARM') and (`SV`.`connection_type` <> 'local')) group by `SV`.`id`,`DN`.`id` order by `DN`.`id`,`SV`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `swarm_compute_members_overview`
--

/*!50001 DROP VIEW IF EXISTS `swarm_compute_members_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`semihyonet`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `swarm_compute_members_overview` AS select `C`.`id` AS `id`,`C`.`id_ref` AS `id_ref`,`C`.`name` AS `name`,`C`.`hostname` AS `hostname`,`C`.`ip_addr` AS `ip_addr`,`scm`.`status` AS `swarm_compute_member_status`,`scm`.`type` AS `swarm_compute_member_type`,`scm`.`port` AS `swarm_compute_member_port`,`scm`.`is_leader` AS `is_leader`,`C`.`management_url` AS `management_url`,`C`.`port` AS `port`,`C`.`hypervisor_uuid` AS `hypervisor_uuid`,`C`.`total_cpu` AS `total_cpu`,`C`.`total_ram` AS `total_ram`,`C`.`total_vm` AS `total_vm`,`C`.`used_cpu` AS `used_cpu`,`C`.`used_ram` AS `used_ram`,`C`.`is_alive` AS `is_alive`,`C`.`compute_pool_id` AS `compute_pool_id` from (`swarm_compute_members` `scm` join `compute_members` `C` on((`scm`.`compute_member_id` = `C`.`id`))) where (`C`.`deleted_at` is null) order by `C`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `swarm_compute_pool_overview`
--

/*!50001 DROP VIEW IF EXISTS `swarm_compute_pool_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`semihyonet`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `swarm_compute_pool_overview` AS select `C`.`id` AS `id`,`SCP`.`listen_addr` AS `listen_addr`,`SCP`.`listen_port` AS `listen_port`,`SCP`.`advertise_addr` AS `advertise_addr`,`SCP`.`advertise_port` AS `advertise_port`,`C`.`id_ref` AS `id_ref`,`C`.`name` AS `name`,`C`.`resource_validator` AS `resource_validator`,`C`.`pool_type` AS `pool_type`,`C`.`master_ip_addr` AS `master_ip_addr`,`C`.`management_url` AS `management_url`,`C`.`port` AS `port`,`C`.`management_type` AS `management_type`,`C`.`virtualization` AS `virtualization`,`C`.`virtualization_version` AS `virtualization_version`,`C`.`provisioning_alg` AS `provisioning_alg`,`C`.`management_package_name` AS `management_package_name`,`C`.`is_active` AS `is_active`,`C`.`is_alive` AS `is_alive`,`C`.`is_public` AS `is_public`,`C`.`datacenter_id` AS `datacenter_id` from (`swarm_compute_pools` `SCP` join `compute_pools` `C` on((`SCP`.`compute_pool_id` = `C`.`id`))) where (`C`.`deleted_at` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `swarm_compute_pools_overview`
--

/*!50001 DROP VIEW IF EXISTS `swarm_compute_pools_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`semihyonet`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `swarm_compute_pools_overview` AS select `C`.`id` AS `id`,`SCP`.`listen_addr` AS `listen_addr`,`SCP`.`listen_port` AS `listen_port`,`SCP`.`advertise_addr` AS `advertise_addr`,`SCP`.`advertise_port` AS `advertise_port`,`C`.`id_ref` AS `id_ref`,`C`.`name` AS `name`,`C`.`resource_validator` AS `resource_validator`,`C`.`pool_type` AS `pool_type`,`C`.`master_ip_addr` AS `master_ip_addr`,`C`.`management_url` AS `management_url`,`C`.`port` AS `port`,`C`.`management_type` AS `management_type`,`C`.`virtualization` AS `virtualization`,`C`.`virtualization_version` AS `virtualization_version`,`C`.`provisioning_alg` AS `provisioning_alg`,`C`.`management_package_name` AS `management_package_name`,`C`.`is_active` AS `is_active`,`C`.`is_alive` AS `is_alive`,`C`.`is_public` AS `is_public`,`C`.`datacenter_id` AS `datacenter_id` from (`swarm_compute_pools` `SCP` join `compute_pools` `C` on((`SCP`.`compute_pool_id` = `C`.`id`))) where (`C`.`deleted_at` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `swarm_network_overview`
--

/*!50001 DROP VIEW IF EXISTS `swarm_network_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`semihyonet`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `swarm_network_overview` AS select `N`.`id` AS `id`,`N`.`id_ref` AS `id_ref`,if((`DN`.`name` is not null),concat(`N`.`name`,' on ',`DN`.`name`),`N`.`name`) AS `name`,`SN`.`docker_network_id` AS `docker_network_id`,`N`.`vlan` AS `vlan`,`N`.`mtu` AS `mtu`,`N`.`network_type` AS `network_type`,`N`.`ip_addr` AS `ip_addr`,`N`.`ip_range_start` AS `ip_range_start`,`N`.`ip_range_end` AS `ip_range_end`,`N`.`gateway` AS `gateway`,`N`.`subnet` AS `subnet`,`N`.`netmask` AS `netmask`,`N`.`network` AS `network`,`N`.`dns_nameservers` AS `dns_nameservers`,`N`.`local_domain` AS `local_domain`,`N`.`is_bridge` AS `is_bridge`,`N`.`is_virtual_network` AS `is_virtual_network`,`N`.`is_interroutable` AS `is_interroutable`,`N`.`is_default_pif` AS `is_default_pif`,`N`.`is_master_record` AS `is_master_record`,`N`.`is_visible` AS `is_visible`,`N`.`network_pool_id` AS `network_pool_id`,`NP`.`id_ref` AS `network_pool_id_ref`,`NP`.`name` AS `network_pool_name`,`DN`.`id` AS `datacenter_node_id`,`DN`.`id_ref` AS `datacenter_node_id_ref`,`DN`.`name` AS `datacenter_node_name`,`N`.`dhcp_server_id` AS `dhcp_server_id`,`DS`.`id_ref` AS `dhcp_server_id_ref`,`DS`.`name` AS `dhcp_server_name`,`N`.`proxy_server_id` AS `proxy_server_id`,`PS`.`id_ref` AS `proxy_server_id_ref`,`PS`.`name` AS `proxy_server_name`,`N`.`nat_server_id` AS `nat_server_id`,`NS`.`id_ref` AS `nat_server_id_ref`,`NS`.`name` AS `nat_server_name`,`N`.`domain_id` AS `domain_id`,`D`.`id_ref` AS `domain_id_ref`,`D`.`name` AS `domain_name`,`N`.`account_id` AS `account_id`,`A`.`id_ref` AS `account_id_ref`,`A`.`name` AS `account_name` from (((((((((`swarm_networks` `SN` left join `networks` `N` on((`SN`.`network_id` = `N`.`id`))) join `network_pools` `NP` on((`NP`.`id` = `N`.`network_pool_id`))) left join `dhcp_servers` `DS` on((`DS`.`id` = `N`.`dhcp_server_id`))) left join `proxy_servers` `PS` on((`PS`.`id` = `N`.`proxy_server_id`))) left join `nat_servers` `NS` on((`NS`.`id` = `N`.`nat_server_id`))) left join `domains` `D` on((`D`.`id` = `N`.`domain_id`))) join `accounts` `A` on((`A`.`id` = `N`.`account_id`))) left join `datacenter_node_networks` `DNN` on((`DNN`.`network_id` = `N`.`id`))) left join `datacenter_nodes` `DN` on((`DN`.`id` = `DNN`.`datacenter_node_id`))) where (`N`.`deleted_at` is null) group by `N`.`id`,`DNN`.`datacenter_node_id`,`SN`.`id` order by `N`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `swarm_networks_overview`
--

/*!50001 DROP VIEW IF EXISTS `swarm_networks_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`semihyonet`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `swarm_networks_overview` AS select `sn`.`id` AS `swarm_id` from (`swarm_networks` `sn` join `networks` `n` on((`sn`.`network_id` = `n`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `swarm_virtual_machines_overview`
--

/*!50001 DROP VIEW IF EXISTS `swarm_virtual_machines_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`semihyonet`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `swarm_virtual_machines_overview` AS select `vm`.`id` AS `id`,`vm`.`id_ref` AS `id_ref`,`vm`.`name` AS `name`,`sr`.`name` AS `replica_name`,`sr`.`image_url` AS `image_url`,`vm`.`hostname` AS `hostname`,`vm`.`os` AS `os`,`vm`.`distro` AS `distro`,`vm`.`domain_type` AS `domain_type`,`vm`.`winrm_enabled` AS `winrm_enabled`,`vm`.`is_locked` AS `is_locked`,`vm`.`is_lost` AS `is_lost`,`vm`.`status` AS `status`,`vm`.`actual_cpu` AS `actual_cpu`,`vm`.`actual_ram` AS `actual_ram`,`vm`.`actual_disk` AS `actual_disk`,`vm`.`actual_network` AS `actual_network`,`vm`.`product_id` AS `product_id`,`vm`.`product_catalog_id` AS `product_catalog_id`,(select `ip_addresses`.`ip_addr` from (`ip_addresses` join `virtual_network_cards` `vnc` on((`ip_addresses`.`virtual_network_card_id` = `vnc`.`id`))) where ((`vnc`.`virtual_machine_id` = `vm`.`id`) and (`ip_addresses`.`is_reachable` = true)) limit 1) AS `ip_addr`,(select count(`v`.`id`) from (`virtual_machines` `v` join `virtual_network_cards` `c` on((`v`.`id` = `c`.`virtual_machine_id`))) where ((`v`.`id` = `vm`.`id`) and (`c`.`deleted_at` is null))) AS `network_count`,(select `n`.`name` from ((`networks` `n` join `virtual_network_cards` `vnc2` on((`n`.`id` = `vnc2`.`network_id`))) join `virtual_machines` `m` on((`vnc2`.`virtual_machine_id` = `m`.`id`))) where ((`m`.`id` = `vm`.`id`) and (`vnc2`.`deleted_at` is null)) limit 1) AS `connected_to`,`dn`.`id_ref` AS `datacenter_node_id`,`dn`.`name` AS `datacenter_node_name`,`a`.`id_ref` AS `account_id`,`u`.`id_ref` AS `user_id`,`vm`.`created_at` AS `created_at`,`vm`.`updated_at` AS `updated_at` from (((((`swarm_virtual_machines` `svm` join `virtual_machines` `vm` on((`vm`.`id` = `svm`.`virtual_machine_id`))) join `datacenter_nodes` `dn` on((`vm`.`datacenter_node_id` = `dn`.`id`))) join `accounts` `a` on((`vm`.`account_id` = `a`.`id`))) join `users` `u` on((`vm`.`user_id` = `u`.`id`))) join `swarm_replicas` `sr` on((`sr`.`id` = `svm`.`replica_id`))) where ((`vm`.`deleted_at` is null) and (`vm`.`is_template` = 0) and (`vm`.`is_snapshot` = 0) and exists(select 1 from `netgateways` `ng` where (`ng`.`virtual_machine_id` = `vm`.`id`)) is false) order by `vm`.`created_at` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `virtual_machines_overview`
--

/*!50001 DROP VIEW IF EXISTS `virtual_machines_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`10.100.0.105` SQL SECURITY DEFINER */
/*!50001 VIEW `virtual_machines_overview` AS select `vm`.`id` AS `id`,`vm`.`id_ref` AS `id_ref`,`vm`.`name` AS `name`,`vm`.`hostname` AS `hostname`,`vm`.`os` AS `os`,`vm`.`distro` AS `distro`,`vm`.`domain_type` AS `domain_type`,`vm`.`winrm_enabled` AS `winrm_enabled`,`vm`.`is_locked` AS `is_locked`,`vm`.`is_lost` AS `is_lost`,`vm`.`status` AS `status`,`vm`.`actual_cpu` AS `actual_cpu`,`vm`.`actual_ram` AS `actual_ram`,`vm`.`actual_disk` AS `actual_disk`,`vm`.`actual_network` AS `actual_network`,`vm`.`product_id` AS `product_id`,`vm`.`product_catalog_id` AS `product_catalog_id`,(select `ip_addresses`.`ip_addr` from (`ip_addresses` join `virtual_network_cards` `vnc` on((`ip_addresses`.`virtual_network_card_id` = `vnc`.`id`))) where ((`vnc`.`virtual_machine_id` = `vm`.`id`) and (`ip_addresses`.`is_reachable` = true)) limit 1) AS `ip_addr`,(select count(`v`.`id`) from (`virtual_machines` `v` join `virtual_network_cards` `c` on((`v`.`id` = `c`.`virtual_machine_id`))) where ((`v`.`id` = `vm`.`id`) and (`c`.`deleted_at` is null))) AS `network_count`,(select `n`.`name` from ((`networks` `n` join `virtual_network_cards` `vnc2` on((`n`.`id` = `vnc2`.`network_id`))) join `virtual_machines` `m` on((`vnc2`.`virtual_machine_id` = `m`.`id`))) where ((`m`.`id` = `vm`.`id`) and (`vnc2`.`deleted_at` is null)) limit 1) AS `connected_to`,`dn`.`id_ref` AS `datacenter_node_id`,`dn`.`name` AS `datacenter_node_name`,`a`.`id_ref` AS `account_id`,`u`.`id_ref` AS `user_id`,`vm`.`last_metadata_request` AS `last_metadata_request`,`vm`.`created_at` AS `created_at`,`vm`.`updated_at` AS `updated_at` from (((`virtual_machines` `vm` join `datacenter_nodes` `dn` on((`vm`.`datacenter_node_id` = `dn`.`id`))) join `accounts` `a` on((`vm`.`account_id` = `a`.`id`))) join `users` `u` on((`vm`.`user_id` = `u`.`id`))) where ((`vm`.`deleted_at` is null) and (`vm`.`is_template` = 0) and (`vm`.`is_snapshot` = 0) and exists(select 1 from `netgateways` `ng` where (`ng`.`virtual_machine_id` = `vm`.`id`)) is false) order by `vm`.`created_at` desc */;
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

-- Dump completed on 2022-09-21 13:19:40
