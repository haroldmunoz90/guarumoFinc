-- phpMyAdmin SQL Dump
-- version 3.5.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 08, 2013 at 01:10 PM
-- Server version: 5.1.63-log
-- PHP Version: 5.3.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ctc`
--

-- --------------------------------------------------------

--
-- Table structure for table `ilg_area`
--

CREATE TABLE IF NOT EXISTS `ilg_area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `parent_area_id` bigint(20) DEFAULT NULL,
  `area_category_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `code` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `activation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `parent_area_id` (`parent_area_id`),
  KEY `area_category_id` (`area_category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ilg_area`
--

INSERT INTO `ilg_area` (`id`, `name`, `description`, `parent_area_id`, `area_category_id`, `status_id`, `enterprise_id`, `code`, `expiration_date`, `activation_date`) VALUES
(1, 'Empresa', NULL, NULL, 1, 1, 1, NULL, NULL, NULL),
(2, 'Altitek', 'Test', NULL, 1, 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_area_category`
--

CREATE TABLE IF NOT EXISTS `ilg_area_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ilg_area_category`
--

INSERT INTO `ilg_area_category` (`id`, `name`, `description`, `status_id`, `enterprise_id`) VALUES
(1, 'Por definir', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_area_person`
--

CREATE TABLE IF NOT EXISTS `ilg_area_person` (
  `area_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  PRIMARY KEY (`person_id`,`area_id`),
  KEY `area_id` (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_area_task`
--

CREATE TABLE IF NOT EXISTS `ilg_area_task` (
  `area_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  PRIMARY KEY (`task_id`,`area_id`),
  KEY `area_id` (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_attendance`
--

CREATE TABLE IF NOT EXISTS `ilg_attendance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  `time` datetime NOT NULL,
  `attendance_status_id` bigint(20) NOT NULL,
  `verification_mode_id` bigint(20) NOT NULL,
  `work_code` varchar(100) DEFAULT NULL,
  `reserved_1` varchar(20) DEFAULT NULL,
  `reserved_2` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `person_id_time` (`person_id`,`time`),
  KEY `attendance_status_id` (`attendance_status_id`),
  KEY `verification_mode_id` (`verification_mode_id`),
  KEY `device_id` (`device_id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=186 ;

--
-- Dumping data for table `ilg_attendance`
--

INSERT INTO `ilg_attendance` (`id`, `device_id`, `person_id`, `time`, `attendance_status_id`, `verification_mode_id`, `work_code`, `reserved_1`, `reserved_2`) VALUES
(9, 3, 6, '2013-01-18 06:35:32', 0, 0, NULL, NULL, NULL),
(10, 3, 7, '2013-04-04 08:24:46', 0, 0, NULL, NULL, NULL),
(12, 3, 18, '2013-04-04 15:10:56', 0, 0, NULL, NULL, NULL),
(18, 3, 7, '2013-04-05 10:15:16', 0, 0, NULL, NULL, NULL),
(25, 3, 7, '2013-04-05 10:41:33', 0, 0, NULL, NULL, NULL),
(43, 3, 7, '2013-04-05 11:27:14', 0, 0, NULL, NULL, NULL),
(44, 3, 7, '2013-04-05 12:11:09', 0, 0, NULL, NULL, NULL),
(45, 3, 7, '2013-04-05 12:12:53', 0, 0, NULL, NULL, NULL),
(46, 3, 18, '2013-04-05 12:12:57', 0, 0, NULL, NULL, NULL),
(47, 3, 7, '2013-04-05 12:19:37', 0, 0, NULL, NULL, NULL),
(48, 3, 7, '2013-04-05 12:32:12', 0, 0, NULL, NULL, NULL),
(49, 3, 18, '2013-04-05 12:32:17', 0, 0, NULL, NULL, NULL),
(50, 3, 25, '2013-04-05 12:32:24', 0, 0, NULL, NULL, NULL),
(51, 3, 7, '2013-04-05 12:46:03', 0, 0, NULL, NULL, NULL),
(52, 3, 18, '2013-04-05 12:46:06', 0, 0, NULL, NULL, NULL),
(53, 3, 6, '2013-01-18 06:39:54', 0, 0, NULL, NULL, NULL),
(54, 3, 6, '2013-01-18 06:41:01', 0, 0, NULL, NULL, NULL),
(55, 3, 6, '2013-01-18 06:42:08', 0, 0, NULL, NULL, NULL),
(56, 3, 6, '2013-01-18 06:46:20', 0, 0, NULL, NULL, NULL),
(57, 3, 6, '2013-01-18 06:47:08', 0, 0, NULL, NULL, NULL),
(58, 3, 6, '2013-01-18 07:17:00', 0, 0, NULL, NULL, NULL),
(59, 3, 6, '2013-01-18 09:06:42', 0, 0, NULL, NULL, NULL),
(60, 3, 6, '2013-01-18 09:53:08', 0, 0, NULL, NULL, NULL),
(61, 3, 6, '2013-01-18 09:56:52', 0, 0, NULL, NULL, NULL),
(62, 3, 6, '2013-01-18 09:57:47', 0, 0, NULL, NULL, NULL),
(63, 3, 6, '2013-01-18 09:58:06', 0, 0, NULL, NULL, NULL),
(64, 3, 6, '2013-01-19 01:10:52', 0, 0, NULL, NULL, NULL),
(65, 3, 6, '2013-01-19 01:26:49', 0, 0, NULL, NULL, NULL),
(66, 3, 6, '2013-01-19 01:27:26', 0, 0, NULL, NULL, NULL),
(67, 3, 6, '2013-01-19 01:27:32', 0, 0, NULL, NULL, NULL),
(68, 3, 6, '2013-01-19 01:28:17', 0, 0, NULL, NULL, NULL),
(69, 3, 6, '2013-01-19 01:28:25', 0, 0, NULL, NULL, NULL),
(70, 3, 6, '2013-01-19 01:28:29', 0, 0, NULL, NULL, NULL),
(71, 3, 6, '2013-01-19 01:28:47', 0, 0, NULL, NULL, NULL),
(72, 3, 7, '2013-01-19 01:30:24', 0, 0, NULL, NULL, NULL),
(73, 3, 7, '2013-01-19 01:30:28', 0, 0, NULL, NULL, NULL),
(74, 3, 7, '2013-01-19 01:30:37', 0, 0, NULL, NULL, NULL),
(75, 3, 7, '2013-01-19 01:30:47', 0, 0, NULL, NULL, NULL),
(76, 3, 7, '2013-01-19 01:30:50', 0, 0, NULL, NULL, NULL),
(77, 3, 7, '2013-01-19 01:33:16', 0, 0, NULL, NULL, NULL),
(78, 3, 7, '2013-01-19 01:33:20', 0, 0, NULL, NULL, NULL),
(79, 3, 7, '2013-01-19 01:33:24', 0, 0, NULL, NULL, NULL),
(80, 3, 7, '2013-01-19 01:58:29', 0, 0, NULL, NULL, NULL),
(81, 3, 6, '2013-01-19 01:58:35', 0, 0, NULL, NULL, NULL),
(82, 3, 6, '2013-01-19 01:59:00', 0, 0, NULL, NULL, NULL),
(83, 3, 7, '2013-01-19 01:59:21', 0, 0, NULL, NULL, NULL),
(84, 3, 7, '2013-02-23 09:53:54', 0, 0, NULL, NULL, NULL),
(85, 3, 7, '2013-02-23 10:02:12', 0, 0, NULL, NULL, NULL),
(86, 3, 7, '2013-02-23 10:07:06', 0, 0, NULL, NULL, NULL),
(87, 3, 29, '2013-02-23 10:11:06', 0, 0, NULL, NULL, NULL),
(89, 3, 25, '2013-03-02 12:54:07', 0, 0, NULL, NULL, NULL),
(90, 3, 7, '2013-03-02 12:54:21', 0, 0, NULL, NULL, NULL),
(91, 3, 33, '2013-03-03 07:57:38', 0, 0, NULL, NULL, NULL),
(92, 3, 7, '2013-04-04 00:15:48', 0, 0, NULL, NULL, NULL),
(93, 3, 7, '2013-04-04 00:27:08', 0, 0, NULL, NULL, NULL),
(94, 3, 25, '2013-04-04 15:11:10', 0, 0, NULL, NULL, NULL),
(95, 3, 7, '2013-04-04 15:11:31', 0, 0, NULL, NULL, NULL),
(96, 3, 25, '2013-04-05 10:41:58', 0, 0, NULL, NULL, NULL),
(97, 3, 7, '2013-04-05 10:42:17', 0, 0, NULL, NULL, NULL),
(98, 3, 7, '2013-04-05 11:04:01', 0, 0, NULL, NULL, NULL),
(99, 3, 18, '2013-04-05 11:04:04', 0, 0, NULL, NULL, NULL),
(100, 3, 25, '2013-04-05 12:13:06', 0, 0, NULL, NULL, NULL),
(101, 3, 7, '2013-04-05 12:46:10', 0, 0, NULL, NULL, NULL),
(102, 3, 18, '2013-04-05 12:46:11', 0, 0, NULL, NULL, NULL),
(103, 3, 7, '2013-04-05 12:46:14', 0, 0, NULL, NULL, NULL),
(104, 3, 22, '2013-04-05 12:46:26', 0, 0, NULL, NULL, NULL),
(105, 3, 22, '2013-04-05 12:46:27', 0, 0, NULL, NULL, NULL),
(106, 3, 22, '2013-04-04 12:46:28', 0, 0, NULL, NULL, NULL),
(107, 3, 24, '2013-04-01 08:06:29', 0, 0, NULL, NULL, NULL),
(108, 3, 25, '2013-04-01 08:46:30', 0, 0, NULL, NULL, NULL),
(109, 3, 25, '2013-04-01 07:35:03', 0, 0, NULL, NULL, NULL),
(110, 3, 29, '2013-04-01 07:56:02', 0, 0, NULL, NULL, NULL),
(111, 3, 30, '2013-04-01 10:46:34', 0, 0, NULL, NULL, NULL),
(112, 3, 32, '2013-04-01 09:06:32', 0, 0, NULL, NULL, NULL),
(113, 3, 34, '2013-04-05 07:15:36', 0, 0, NULL, NULL, NULL),
(114, 3, 37, '2013-04-02 07:46:37', 0, 0, NULL, NULL, NULL),
(115, 3, 24, '2013-04-02 09:11:38', 0, 0, NULL, NULL, NULL),
(116, 3, 25, '2013-04-02 10:01:39', 0, 0, NULL, NULL, NULL),
(117, 3, 24, '2013-04-03 09:02:40', 0, 0, NULL, NULL, NULL),
(118, 3, 25, '2013-04-03 07:57:27', 0, 0, NULL, NULL, NULL),
(119, 3, 22, '2013-04-03 08:09:35', 0, 0, NULL, NULL, NULL),
(120, 3, 29, '2013-04-03 06:51:09', 0, 0, NULL, NULL, NULL),
(121, 3, 6, '2013-04-06 04:44:18', 0, 0, NULL, NULL, NULL),
(122, 3, 6, '2013-04-06 04:57:22', 0, 0, NULL, NULL, NULL),
(123, 3, 6, '2013-04-06 04:57:30', 1, 0, NULL, NULL, NULL),
(124, 3, 26, '2013-02-28 10:11:10', 0, 0, NULL, NULL, NULL),
(125, 3, 26, '2013-04-15 10:11:10', 0, 0, NULL, NULL, NULL),
(126, 3, 26, '2013-04-14 10:11:10', 0, 0, NULL, NULL, NULL),
(127, 3, 26, '2013-04-14 10:12:10', 0, 0, NULL, NULL, NULL),
(128, 3, 26, '2013-04-14 10:13:10', 0, 0, NULL, NULL, NULL),
(129, 3, 26, '2013-04-14 10:14:10', 0, 0, NULL, NULL, NULL),
(130, 3, 26, '2013-04-14 10:15:10', 0, 0, NULL, NULL, NULL),
(131, 3, 26, '2013-04-14 10:16:10', 0, 0, NULL, NULL, NULL),
(132, 3, 26, '2013-04-14 10:17:10', 0, 0, NULL, NULL, NULL),
(133, 3, 26, '2013-04-14 10:18:10', 0, 0, NULL, NULL, NULL),
(134, 3, 26, '2013-04-14 10:19:10', 0, 0, NULL, NULL, NULL),
(135, 3, 26, '2013-04-14 10:20:10', 0, 0, NULL, NULL, NULL),
(136, 3, 26, '2013-04-14 10:21:10', 0, 0, NULL, NULL, NULL),
(137, 3, 26, '2013-04-14 10:22:10', 0, 0, NULL, NULL, NULL),
(138, 4, 39, '2013-03-03 05:57:48', 0, 0, NULL, NULL, NULL),
(139, 4, 39, '2013-03-03 05:59:29', 0, 0, NULL, NULL, NULL),
(140, 4, 22, '2013-03-13 21:24:53', 0, 0, NULL, NULL, NULL),
(141, 4, 22, '2013-03-13 21:25:26', 0, 0, NULL, NULL, NULL),
(142, 4, 22, '2013-03-13 21:25:42', 0, 0, NULL, NULL, NULL),
(143, 4, 22, '2013-03-13 21:28:47', 0, 0, NULL, NULL, NULL),
(144, 4, 22, '2013-03-13 21:29:04', 0, 0, NULL, NULL, NULL),
(145, 4, 22, '2013-03-13 21:31:09', 0, 0, NULL, NULL, NULL),
(146, 4, 22, '2013-03-13 21:31:57', 0, 0, NULL, NULL, NULL),
(147, 4, 22, '2013-03-13 21:32:14', 0, 0, NULL, NULL, NULL),
(148, 4, 22, '2013-03-13 21:32:41', 0, 0, NULL, NULL, NULL),
(149, 4, 22, '2013-03-13 23:05:37', 0, 0, NULL, NULL, NULL),
(150, 4, 22, '2013-03-13 23:06:00', 0, 0, NULL, NULL, NULL),
(151, 4, 40, '2013-03-13 23:12:50', 0, 0, NULL, NULL, NULL),
(152, 4, 40, '2013-03-13 23:12:56', 0, 0, NULL, NULL, NULL),
(153, 4, 40, '2013-03-13 23:15:12', 0, 0, NULL, NULL, NULL),
(154, 4, 39, '2013-04-09 00:43:48', 0, 0, NULL, NULL, NULL),
(155, 4, 39, '2013-04-09 00:43:54', 0, 0, NULL, NULL, NULL),
(156, 4, 39, '2013-04-09 00:46:26', 0, 0, NULL, NULL, NULL),
(157, 3, 26, '2013-04-14 10:24:10', 0, 0, NULL, NULL, NULL),
(158, 3, 26, '2013-04-14 10:25:10', 0, 0, NULL, NULL, NULL),
(159, 3, 26, '2013-04-14 10:26:10', 0, 0, NULL, NULL, NULL),
(160, 4, 6, '2013-04-14 10:27:10', 0, 0, NULL, NULL, NULL),
(161, 3, 6, '2013-05-26 10:29:10', 0, 0, NULL, NULL, NULL),
(162, 3, 6, '2013-05-27 10:29:10', 0, 0, NULL, NULL, NULL),
(163, 3, 6, '2013-05-28 10:29:10', 0, 0, NULL, NULL, NULL),
(164, 3, 6, '2013-05-29 10:29:10', 0, 0, NULL, NULL, NULL),
(165, 3, 6, '2013-06-30 10:29:10', 0, 0, NULL, NULL, NULL),
(166, 3, 6, '2013-06-30 10:29:11', 0, 0, NULL, NULL, NULL),
(167, 3, 6, '2013-06-30 10:29:12', 0, 0, NULL, NULL, NULL),
(168, 3, 6, '2013-06-30 10:29:13', 0, 0, NULL, NULL, NULL),
(169, 3, 6, '2013-06-30 10:29:14', 0, 0, NULL, NULL, NULL),
(170, 3, 6, '2013-06-30 10:29:15', 0, 0, NULL, NULL, NULL),
(171, 3, 6, '2013-06-30 10:29:16', 0, 0, NULL, NULL, NULL),
(174, 3, 6, '2013-07-01 19:20:16', 0, 0, NULL, NULL, NULL),
(175, 3, 6, '2013-07-02 09:40:16', 1, 0, NULL, NULL, NULL),
(176, 3, 6, '2013-07-03 19:20:16', 0, 0, NULL, NULL, NULL),
(179, 3, 6, '2013-07-04 07:40:16', 1, 0, NULL, NULL, NULL),
(180, 3, 24, '2013-06-01 19:40:16', 0, 0, NULL, NULL, NULL),
(181, 3, 24, '2013-06-02 07:40:16', 1, 0, NULL, NULL, NULL),
(182, 3, 7, '2013-06-01 19:40:16', 0, 0, NULL, NULL, NULL),
(183, 3, 7, '2013-06-02 09:40:16', 1, 0, NULL, NULL, NULL),
(184, 3, 25, '2013-06-01 19:40:16', 0, 0, NULL, NULL, NULL),
(185, 3, 25, '2013-06-02 09:40:16', 1, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_attendance_status`
--

CREATE TABLE IF NOT EXISTS `ilg_attendance_status` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilg_attendance_status`
--

INSERT INTO `ilg_attendance_status` (`id`, `name`, `description`) VALUES
(0, 'Entrada', 'Clock in'),
(1, 'Salida', 'Clock out'),
(2, 'Out', NULL),
(3, 'Return from an Out', NULL),
(4, 'Clock in for overtime', NULL),
(5, 'Clock out for overtime', NULL),
(8, 'Meal start', NULL),
(9, 'Meal end', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_attendance_type`
--

CREATE TABLE IF NOT EXISTS `ilg_attendance_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilg_attendance_type`
--

INSERT INTO `ilg_attendance_type` (`id`, `name`, `description`) VALUES
(0, 'A tiempo', NULL),
(1, 'Temprano', NULL),
(2, 'Tarde', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_att_report`
--

CREATE TABLE IF NOT EXISTS `ilg_att_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `attendance_id` bigint(20) DEFAULT NULL,
  `rule_id` bigint(20) DEFAULT NULL,
  `custom_int_1` bigint(20) DEFAULT NULL,
  `custom_int_2` bigint(20) DEFAULT NULL,
  `custom_int_3` bigint(20) DEFAULT NULL,
  `custom_str_1` varchar(2000) DEFAULT NULL,
  `custom_str_2` varchar(2000) DEFAULT NULL,
  `custom_str_3` varchar(2000) DEFAULT NULL,
  `custom_str_4` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `attendance_id` (`attendance_id`),
  KEY `rule_id` (`rule_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=53 ;

--
-- Dumping data for table `ilg_att_report`
--

INSERT INTO `ilg_att_report` (`id`, `person_id`, `attendance_id`, `rule_id`, `custom_int_1`, `custom_int_2`, `custom_int_3`, `custom_str_1`, `custom_str_2`, `custom_str_3`, `custom_str_4`) VALUES
(9, 24, 107, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(10, 25, 108, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(11, 25, 109, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(12, 29, 110, 1, 0, 1, NULL, NULL, NULL, NULL, NULL),
(13, 30, 111, 1, 0, 2, NULL, NULL, NULL, NULL, NULL),
(14, 32, 112, 1, 0, 1, NULL, NULL, NULL, NULL, NULL),
(15, 34, 113, 1, 0, 0, NULL, NULL, NULL, NULL, NULL),
(16, 37, 114, 1, 0, 1, NULL, NULL, NULL, NULL, NULL),
(17, 24, 115, 1, 0, 2, NULL, NULL, NULL, NULL, NULL),
(18, 25, 116, 1, 0, 2, NULL, NULL, NULL, NULL, NULL),
(19, 24, 117, 1, 0, 2, NULL, NULL, NULL, NULL, NULL),
(20, 25, 118, 1, 0, 0, NULL, NULL, NULL, NULL, NULL),
(21, 22, 119, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(22, 29, 120, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(23, 6, 121, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(24, 6, 122, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(25, 6, 123, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(26, 26, 126, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(27, 26, 127, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(28, 26, 128, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(29, 26, 135, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(30, 26, 136, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(31, 26, 137, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(32, 22, 140, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(33, 22, 141, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(34, 22, 142, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(35, 22, 143, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(36, 22, 144, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(37, 22, 145, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(38, 22, 146, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(39, 22, 147, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(40, 22, 148, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(41, 22, 149, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(42, 22, 150, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(43, 40, 151, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(44, 40, 152, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(45, 40, 153, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(46, 39, 154, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(47, 39, 155, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(48, 39, 156, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(49, 26, 157, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(50, 26, 158, 1, 1, 1, NULL, NULL, NULL, NULL, NULL),
(51, 26, 159, 1, 1, 2, NULL, NULL, NULL, NULL, NULL),
(52, 6, 160, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_calendar`
--

CREATE TABLE IF NOT EXISTS `ilg_calendar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `parent_calendar_id` bigint(20) DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `change_status_date` datetime DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `status_id` (`status_id`),
  KEY `parent_calendar_id` (`parent_calendar_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ilg_calendar`
--

INSERT INTO `ilg_calendar` (`id`, `name`, `description`, `parent_calendar_id`, `status_id`, `creation_date`, `change_status_date`, `enterprise_id`) VALUES
(1, 'Turnos', 'Turnos de la empresa', NULL, 1, '2013-06-14 00:00:00', '2013-06-14 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_calendar_date`
--

CREATE TABLE IF NOT EXISTS `ilg_calendar_date` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `end_entry_date` date DEFAULT NULL,
  `start_time` varchar(5) NOT NULL DEFAULT '00:00',
  `end_time` varchar(5) NOT NULL DEFAULT '23:59',
  `applies_all_years` char(1) DEFAULT 'f',
  `date_type_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `change_status_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_type_id` (`date_type_id`),
  KEY `calendar_id` (`calendar_id`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_calendar_time`
--

CREATE TABLE IF NOT EXISTS `ilg_calendar_time` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calendar_id` bigint(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `monday` char(1) DEFAULT NULL,
  `tuesday` char(1) DEFAULT NULL,
  `wednesday` char(1) DEFAULT NULL,
  `thursday` char(1) DEFAULT NULL,
  `friday` char(1) DEFAULT NULL,
  `saturday` char(1) DEFAULT NULL,
  `sunday` char(1) DEFAULT NULL,
  `initial_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `applies_all_years` char(1) DEFAULT 'f',
  `start_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `days_duration` int(8) DEFAULT NULL COMMENT 'Dias de duracion del periodo',
  `date_type_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `change_status_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date_type_id` (`date_type_id`),
  KEY `status_id` (`status_id`),
  KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `ilg_calendar_time`
--

INSERT INTO `ilg_calendar_time` (`id`, `calendar_id`, `name`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`, `sunday`, `initial_date`, `end_date`, `applies_all_years`, `start_time`, `end_time`, `days_duration`, `date_type_id`, `status_id`, `creation_date`, `change_status_date`) VALUES
(1, 1, 'Turno Mañana', 'T', 'T', 'T', 'T', 'T', 'T', 'T', NULL, NULL, 'T', '06:00', '12:00', NULL, 1, 1, '2013-06-14 00:00:00', '2013-06-14 00:00:00'),
(2, 1, 'Turno Almuerzo', 'T', 'T', 'T', 'T', 'T', 'T', 'T', NULL, NULL, 'T', '12:00', '13:00', 0, 1, 1, '2013-06-14 00:00:00', '2013-06-14 00:00:00'),
(3, 1, 'Turno tarde', 'T', 'T', 'T', 'T', 'T', 'T', 'T', NULL, NULL, 'T', '13:00', '19:00', 0, 1, 1, '2013-06-14 00:00:00', '2013-06-14 00:00:00'),
(4, 1, 'Turno Noche', 'T', 'T', 'T', 'T', 'T', 'T', 'T', NULL, NULL, 'T', '19:00', '07:00', 1, 1, 1, '2013-06-14 00:00:00', '2013-06-14 00:00:00'),
(5, 1, 'Turno Alternativo', 'T', 'T', 'T', 'T', 'T', 'T', 'T', NULL, NULL, 'T', '07:00', '15:00', 0, 1, 1, '2013-06-14 00:00:00', '2013-06-14 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `ilg_config`
--

CREATE TABLE IF NOT EXISTS `ilg_config` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT,
  `serial` varchar(80) NOT NULL,
  `sms` varchar(1) NOT NULL,
  `sms_audio` varchar(1) NOT NULL,
  `cell_phone` varchar(15) NOT NULL,
  `max_job_time` int(16) DEFAULT NULL COMMENT 'Tiempo maximo en horas de los turnos.',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ilg_config`
--

INSERT INTO `ilg_config` (`id`, `serial`, `sms`, `sms_audio`, `cell_phone`, `max_job_time`) VALUES
(1, 'X112345', 'T', 'F', '3155799894', 16);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_contract`
--

CREATE TABLE IF NOT EXISTS `ilg_contract` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status_id` bigint(20) NOT NULL,
  `url` varchar(2000) DEFAULT NULL,
  `accepted` char(1) NOT NULL,
  `acceptance_date` date DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_contract_detail`
--

CREATE TABLE IF NOT EXISTS `ilg_contract_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contract_id` bigint(20) NOT NULL,
  `order` bigint(20) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_id` (`contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_contract_type`
--

CREATE TABLE IF NOT EXISTS `ilg_contract_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` varchar(2000) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_date_type`
--

CREATE TABLE IF NOT EXISTS `ilg_date_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name_caldttype` (`name`,`enterprise_id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ilg_date_type`
--

INSERT INTO `ilg_date_type` (`id`, `name`, `description`, `status_id`, `enterprise_id`) VALUES
(1, 'Ordinario', NULL, 1, 1),
(2, 'Feriado', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_device`
--

CREATE TABLE IF NOT EXISTS `ilg_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_type_id` bigint(20) DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `ip_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `identification` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `location` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `device_status_id` bigint(20) NOT NULL,
  `status_id` bigint(20) DEFAULT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `LastActivity` datetime DEFAULT NULL,
  `TransTimes` varchar(50) DEFAULT '00:00;14:05',
  `TransInterval` int(11) DEFAULT '2',
  `LogStamp` varchar(20) DEFAULT 'None',
  `UpdateDB` varchar(10) DEFAULT '1111100000',
  `OpLogStamp` varchar(20) DEFAULT '0',
  `PhotoStamp` varchar(20) DEFAULT '0',
  `TZAdj` smallint(6) DEFAULT '5',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `device_type_id` (`device_type_id`),
  KEY `status_id` (`status_id`),
  KEY `device_status_id` (`device_status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ilg_device`
--

INSERT INTO `ilg_device` (`id`, `device_type_id`, `name`, `description`, `ip_address`, `identification`, `location`, `code`, `activation_date`, `expiration_date`, `device_status_id`, `status_id`, `enterprise_id`, `LastActivity`, `TransTimes`, `TransInterval`, `LogStamp`, `UpdateDB`, `OpLogStamp`, `PhotoStamp`, `TZAdj`) VALUES
(3, NULL, NULL, NULL, '192.168.0.199', '4224512440036', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2013-04-04 06:17:01', '00:00;14:05', 2, '423320061', '1111100000', '423369434', '0', 5),
(4, NULL, NULL, NULL, '192.168.0.199', '2786992090010', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2013-04-08 11:43:04', '00:00;14:05', 2, '423320061', '1111100000', '423369434', '0', 8);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_device_cmd`
--

CREATE TABLE IF NOT EXISTS `ilg_device_cmd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `CmdContent` longtext NOT NULL,
  `CmdCommitTime` datetime NOT NULL,
  `CmdTransTime` datetime DEFAULT NULL,
  `CmdOverTime` datetime DEFAULT NULL,
  `CmdReturn` int(11) DEFAULT NULL,
  `person_id` bigint(20) DEFAULT NULL COMMENT 'who run this command',
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=168 ;

--
-- Dumping data for table `ilg_device_cmd`
--

INSERT INTO `ilg_device_cmd` (`id`, `device_id`, `CmdContent`, `CmdCommitTime`, `CmdTransTime`, `CmdOverTime`, `CmdReturn`, `person_id`) VALUES
(28, 3, 'INFO', '2013-04-04 10:33:13', '2013-04-04 10:33:19', '2013-04-04 10:33:19', 0, NULL),
(29, 3, 'CHECK', '2013-04-04 10:33:13', '2013-04-04 10:33:21', '2013-04-04 10:33:21', 0, NULL),
(30, 3, 'INFO', '2013-04-04 10:33:23', '2013-04-04 10:33:23', '2013-04-04 10:33:23', 0, NULL),
(31, 3, 'CHECK', '2013-04-04 10:33:23', '2013-04-04 10:33:24', '2013-04-04 10:33:24', 0, NULL),
(35, 3, 'DATA USER PIN=1022	Name=Zapata	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-04 23:54:53', '2013-04-05 01:48:06', '2013-04-05 01:48:06', 0, 22),
(40, 3, 'DATA USER PIN=1024 	Name=Zapata	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 00:48:39', '2013-04-05 01:48:07', '2013-04-05 01:48:07', 0, 24),
(41, 3, 'INFO', '2013-04-05 01:20:20', '2013-04-05 01:48:08', '2013-04-05 01:48:08', 0, NULL),
(42, 3, 'CHECK', '2013-04-05 01:20:21', '2013-04-05 01:48:08', '2013-04-05 01:48:08', 0, NULL),
(43, 3, 'INFO', '2013-04-05 01:20:54', '2013-04-05 01:48:08', '2013-04-05 01:48:08', 0, NULL),
(44, 3, 'CHECK', '2013-04-05 01:20:54', '2013-04-05 01:48:09', '2013-04-05 01:48:09', 0, NULL),
(45, 3, 'DATA USER PIN=1025 	Name=Camila	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 01:34:37', '2013-04-05 01:48:16', '2013-04-05 01:48:16', 0, 25),
(46, 3, 'DATA USER PIN=1026 	Name=Homero	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 01:38:46', '2013-04-05 01:48:16', '2013-04-05 01:48:16', 0, 26),
(47, 3, 'INFO', '2013-04-05 01:48:14', '2013-04-05 01:48:17', '2013-04-05 01:48:17', 0, NULL),
(48, 3, 'CHECK', '2013-04-05 01:48:14', '2013-04-05 01:48:18', '2013-04-05 01:48:18', 0, NULL),
(49, 3, 'INFO', '2013-04-05 02:10:15', '2013-04-05 02:10:16', '2013-04-05 02:10:16', 0, NULL),
(50, 3, 'CHECK', '2013-04-05 02:10:15', '2013-04-05 02:10:17', '2013-04-05 02:10:17', 0, NULL),
(52, 3, 'INFO', '2013-04-05 02:28:13', '2013-04-05 02:28:14', '2013-04-05 02:28:14', 0, NULL),
(53, 3, 'CHECK', '2013-04-05 02:28:13', '2013-04-05 02:28:15', '2013-04-05 02:28:15', 0, NULL),
(54, 3, 'INFO', '2013-04-05 03:01:18', '2013-04-05 03:01:18', '2013-04-05 03:01:18', 0, NULL),
(55, 3, 'CHECK', '2013-04-05 03:01:18', '2013-04-05 03:01:19', '2013-04-05 03:01:19', 0, NULL),
(56, 3, 'INFO', '2013-04-05 03:21:16', '2013-04-05 03:21:17', '2013-04-05 03:21:17', 0, NULL),
(57, 3, 'CHECK', '2013-04-05 03:21:16', '2013-04-05 03:21:17', '2013-04-05 03:21:17', 0, NULL),
(58, 3, 'INFO', '2013-04-05 03:29:59', '2013-04-05 03:30:00', '2013-04-05 03:30:00', 0, NULL),
(59, 3, 'CHECK', '2013-04-05 03:29:59', '2013-04-05 03:30:01', '2013-04-05 03:30:01', 0, NULL),
(60, 3, 'INFO', '2013-04-05 04:11:07', '2013-04-05 04:11:08', '2013-04-05 04:11:08', 0, NULL),
(61, 3, 'CHECK', '2013-04-05 04:11:07', '2013-04-05 04:11:09', '2013-04-05 04:11:09', 0, NULL),
(62, 3, 'INFO', '2013-04-05 04:11:11', '2013-04-05 04:11:12', '2013-04-05 04:11:12', 0, NULL),
(63, 3, 'CHECK', '2013-04-05 04:11:11', '2013-04-05 04:11:12', '2013-04-05 04:11:12', 0, NULL),
(64, 3, 'INFO', '2013-04-05 04:12:56', '2013-04-05 04:12:57', '2013-04-05 04:12:57', 0, NULL),
(65, 3, 'CHECK', '2013-04-05 04:12:56', '2013-04-05 04:12:58', '2013-04-05 04:12:58', 0, NULL),
(66, 3, 'INFO', '2013-04-05 04:12:59', '2013-04-05 04:13:00', '2013-04-05 04:13:00', 0, NULL),
(67, 3, 'CHECK', '2013-04-05 04:13:00', '2013-04-05 04:13:01', '2013-04-05 04:13:01', 0, NULL),
(68, 3, 'INFO', '2013-04-05 04:28:55', '2013-04-05 04:28:56', '2013-04-05 04:28:56', 0, NULL),
(69, 3, 'CHECK', '2013-04-05 04:28:55', '2013-04-05 04:28:57', '2013-04-05 04:28:57', 0, NULL),
(70, 3, 'INFO', '2013-04-05 04:32:17', '2013-04-05 04:32:17', '2013-04-05 04:32:17', 0, NULL),
(71, 3, 'CHECK', '2013-04-05 04:32:17', '2013-04-05 04:32:18', '2013-04-05 04:32:18', 0, NULL),
(72, 3, 'INFO', '2013-04-05 04:32:20', '2013-04-05 04:32:21', '2013-04-05 04:32:21', 0, NULL),
(73, 3, 'CHECK', '2013-04-05 04:32:20', '2013-04-05 04:32:22', '2013-04-05 04:32:22', 0, NULL),
(74, 3, 'INFO', '2013-04-05 04:32:28', '2013-04-05 04:32:29', '2013-04-05 04:32:29', 0, NULL),
(75, 3, 'CHECK', '2013-04-05 04:32:28', '2013-04-05 04:32:29', '2013-04-05 04:32:29', 0, NULL),
(76, 3, 'INFO', '2013-04-05 04:33:27', '2013-04-05 04:33:27', '2013-04-05 04:33:27', 0, NULL),
(77, 3, 'CHECK', '2013-04-05 04:33:27', '2013-04-05 04:33:28', '2013-04-05 04:33:28', 0, NULL),
(78, 3, 'INFO', '2013-04-05 04:46:25', '2013-04-05 04:46:26', '2013-04-05 04:46:26', 0, NULL),
(79, 3, 'CHECK', '2013-04-05 04:46:25', '2013-04-05 04:46:28', '2013-04-05 04:46:28', 0, NULL),
(80, 3, 'INFO', '2013-04-05 05:08:54', '2013-04-05 05:08:54', '2013-04-05 05:08:54', 0, NULL),
(81, 3, 'CHECK', '2013-04-05 05:08:54', '2013-04-05 05:08:55', '2013-04-05 05:08:55', 0, NULL),
(82, 3, 'INFO', '2013-04-05 05:09:02', '2013-04-05 05:09:02', '2013-04-05 05:09:02', 0, NULL),
(83, 3, 'CHECK', '2013-04-05 05:09:02', '2013-04-05 05:09:03', '2013-04-05 05:09:03', 0, NULL),
(84, 3, 'INFO', '2013-04-05 05:10:22', '2013-04-05 05:10:22', '2013-04-05 05:10:22', 0, NULL),
(85, 3, 'CHECK', '2013-04-05 05:10:22', '2013-04-05 05:10:23', '2013-04-05 05:10:23', 0, NULL),
(86, 3, 'INFO', '2013-04-05 05:10:25', '2013-04-05 05:10:25', '2013-04-05 05:10:25', 0, NULL),
(87, 3, 'CHECK', '2013-04-05 05:10:25', '2013-04-05 05:10:26', '2013-04-05 05:10:26', 0, NULL),
(88, 3, 'INFO', '2013-04-05 05:14:51', '2013-04-05 05:14:52', '2013-04-05 05:14:52', 0, NULL),
(89, 3, 'CHECK', '2013-04-05 05:14:51', '2013-04-05 05:14:53', '2013-04-05 05:14:53', 0, NULL),
(90, 3, 'INFO', '2013-04-05 05:19:05', '2013-04-05 05:19:05', '2013-04-05 05:19:05', 0, NULL),
(91, 3, 'CHECK', '2013-04-05 05:19:05', '2013-04-05 05:19:06', '2013-04-05 05:19:06', 0, NULL),
(92, 3, 'DATA USER PIN=1038 	Name=Henry	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:30:17', '2013-04-05 05:30:29', '2013-04-05 05:30:29', 0, 38),
(93, 3, 'INFO', '2013-04-05 05:31:48', '2013-04-05 05:31:48', '2013-04-05 05:31:48', 0, NULL),
(94, 3, 'CHECK', '2013-04-05 05:31:48', '2013-04-05 05:31:49', '2013-04-05 05:31:49', 0, NULL),
(95, 3, 'DATA USER PIN=1018 	Name=Andrea	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:37:39', '2013-04-05 05:37:42', '2013-04-05 05:37:42', 0, 18),
(96, 3, 'DATA USER PIN=1024 	Name=Nicolas	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:37:54', '2013-04-05 05:38:00', '2013-04-05 05:38:00', 0, 24),
(97, 3, 'DATA USER PIN=1006 	Name=Ene	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:38:10', '2013-04-05 05:38:17', '2013-04-05 05:38:17', 0, 6),
(98, 3, 'DATA USER PIN=1025 	Name=Pedro	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:38:24', '2013-04-05 05:38:25', '2013-04-05 05:38:25', 0, 25),
(99, 3, 'DATA USER PIN=1026 	Name=Homero	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:40:17', '2013-04-05 05:40:36', '2013-04-05 05:40:36', 0, 26),
(101, 3, 'DATA USER PIN=1029 	Name=Angela	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:40:49', '2013-04-05 05:40:54', '2013-04-05 05:40:54', 0, 29),
(102, 3, 'DATA USER PIN=1030 	Name=fontanero	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:41:13', '2013-04-05 05:41:23', '2013-04-05 05:41:23', 0, 30),
(104, 3, 'DATA USER PIN=1032 	Name=Nuevo	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:41:32', '2013-04-05 05:41:35', '2013-04-05 05:41:35', 0, 32),
(105, 3, 'DATA USER PIN=1033 	Name=Nicolas	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:41:42', '2013-04-05 05:41:43', '2013-04-05 05:41:43', 0, 33),
(106, 3, 'DATA USER PIN=1034 	Name=Zapata	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:41:54', '2013-04-05 05:42:01', '2013-04-05 05:42:01', 0, 34),
(108, 3, 'DATA USER PIN=1036 	Name=Zapata	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:42:15', '2013-04-05 05:42:19', '2013-04-05 05:42:19', 0, 36),
(109, 3, 'DATA USER PIN=1037 	Name=Camila	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:42:25', '2013-04-05 05:42:27', '2013-04-05 05:42:27', 0, 37),
(110, 3, 'DATA USER PIN=1007 	Name=Administrador	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-05 05:43:03', '2013-04-05 05:43:10', '2013-04-05 05:43:10', 0, 7),
(111, 3, 'INFO', '2013-04-05 05:45:20', '2013-04-05 05:45:20', '2013-04-05 05:45:20', 0, NULL),
(112, 3, 'CHECK', '2013-04-05 05:45:20', '2013-04-05 05:45:21', '2013-04-05 05:45:21', 0, NULL),
(113, 3, 'INFO', '2013-04-05 05:46:02', '2013-04-05 05:46:02', '2013-04-05 05:46:02', 0, NULL),
(114, 3, 'CHECK', '2013-04-05 05:46:02', '2013-04-05 05:46:03', '2013-04-05 05:46:03', 0, NULL),
(115, 3, 'INFO', '2013-04-05 06:03:36', '2013-04-05 06:03:36', '2013-04-05 06:03:36', 0, NULL),
(116, 3, 'CHECK', '2013-04-05 06:03:36', '2013-04-05 06:03:37', '2013-04-05 06:03:37', 0, NULL),
(117, 3, 'INFO', '2013-04-05 06:10:20', '2013-04-05 06:10:21', '2013-04-05 06:10:21', 0, NULL),
(118, 3, 'CHECK', '2013-04-05 06:10:20', '2013-04-05 06:10:22', '2013-04-05 06:10:22', 0, NULL),
(119, 3, 'INFO', '2013-04-05 01:19:36', '2013-04-05 01:19:37', '2013-04-05 01:19:37', 0, NULL),
(120, 3, 'CHECK', '2013-04-05 01:19:36', '2013-04-05 01:19:38', '2013-04-05 01:19:38', 0, NULL),
(121, 3, 'INFO', '2013-04-05 01:20:55', '2013-04-05 01:20:55', '2013-04-05 01:20:55', 0, NULL),
(122, 3, 'CHECK', '2013-04-05 01:20:55', '2013-04-05 01:20:56', '2013-04-05 01:20:56', 0, NULL),
(123, 3, 'INFO', '2013-04-05 01:26:51', '2013-04-05 01:26:52', '2013-04-05 01:26:52', 0, NULL),
(124, 3, 'CHECK', '2013-04-05 01:26:51', '2013-04-05 01:26:53', '2013-04-05 01:26:53', 0, NULL),
(125, 3, 'INFO', '2013-04-05 01:27:52', '2013-04-05 01:27:53', '2013-04-05 01:27:53', 0, NULL),
(126, 3, 'CHECK', '2013-04-05 01:27:52', '2013-04-05 01:27:53', '2013-04-05 01:27:53', 0, NULL),
(127, 3, 'INFO', '2013-04-05 01:27:55', '2013-04-05 01:27:56', '2013-04-05 01:27:56', 0, NULL),
(128, 3, 'CHECK', '2013-04-05 01:27:55', '2013-04-05 01:27:57', '2013-04-05 01:27:57', 0, NULL),
(129, 3, 'INFO', '2013-04-05 01:28:05', '2013-04-05 01:28:06', '2013-04-05 01:28:06', 0, NULL),
(130, 3, 'CHECK', '2013-04-05 01:28:06', '2013-04-05 01:28:07', '2013-04-05 01:28:07', 0, NULL),
(131, 3, 'INFO', '2013-04-05 01:43:46', '2013-04-05 01:43:47', '2013-04-05 01:43:47', 0, NULL),
(132, 3, 'CHECK', '2013-04-05 01:43:46', '2013-04-05 01:43:48', '2013-04-05 01:43:48', 0, NULL),
(133, 3, 'INFO', '2013-04-05 02:07:38', '2013-04-05 02:07:39', '2013-04-05 02:07:39', 0, NULL),
(134, 3, 'CHECK', '2013-04-05 02:07:38', '2013-04-05 02:07:40', '2013-04-05 02:07:40', 0, NULL),
(135, 3, 'INFO', '2013-04-05 02:22:44', '2013-04-05 02:22:45', '2013-04-05 02:22:45', 0, NULL),
(136, 3, 'CHECK', '2013-04-05 02:22:44', '2013-04-05 02:22:46', '2013-04-05 02:22:46', 0, NULL),
(137, 3, 'INFO', '2013-04-05 02:29:11', '2013-04-05 02:29:12', '2013-04-05 02:29:12', 0, NULL),
(138, 3, 'CHECK', '2013-04-05 02:29:11', '2013-04-05 02:29:13', '2013-04-05 02:29:13', 0, NULL),
(139, 3, 'INFO', '2013-04-05 02:34:23', '2013-04-05 02:34:24', '2013-04-05 02:34:24', 0, NULL),
(140, 3, 'CHECK', '2013-04-05 02:34:23', '2013-04-05 02:34:24', '2013-04-05 02:34:24', 0, NULL),
(141, 3, 'INFO', '2013-04-05 02:43:27', '2013-04-05 02:43:27', '2013-04-05 02:43:27', 0, NULL),
(142, 3, 'CHECK', '2013-04-05 02:43:27', '2013-04-05 02:43:28', '2013-04-05 02:43:28', 0, NULL),
(143, 3, 'INFO', '2013-04-05 02:44:48', '2013-04-05 02:44:49', '2013-04-05 02:44:49', 0, NULL),
(144, 3, 'CHECK', '2013-04-05 02:44:48', '2013-04-05 02:44:50', '2013-04-05 02:44:50', 0, NULL),
(145, 3, 'INFO', '2013-04-05 02:57:48', '2013-04-05 02:57:49', '2013-04-05 02:57:49', 0, NULL),
(146, 3, 'CHECK', '2013-04-05 02:57:48', '2013-04-05 02:57:50', '2013-04-05 02:57:50', 0, NULL),
(147, 3, 'INFO', '2013-04-05 03:00:00', '2013-04-05 03:00:01', '2013-04-05 03:00:01', 0, NULL),
(148, 3, 'CHECK', '2013-04-05 03:00:00', '2013-04-05 03:00:02', '2013-04-05 03:00:02', 0, NULL),
(149, 3, 'INFO', '2013-04-05 03:01:21', '2013-04-05 03:01:22', '2013-04-05 03:01:22', 0, NULL),
(150, 3, 'CHECK', '2013-04-05 03:01:21', '2013-04-05 03:01:23', '2013-04-05 03:01:23', 0, NULL),
(151, 3, 'INFO', '2013-04-05 18:40:45', '2013-04-05 18:40:45', '2013-04-05 18:40:45', 0, NULL),
(152, 3, 'CHECK', '2013-04-05 18:40:45', '2013-04-05 18:40:46', '2013-04-05 18:40:46', 0, NULL),
(153, 3, 'INFO', '2013-04-05 18:40:48', '2013-04-05 18:40:49', '2013-04-05 18:40:49', 0, NULL),
(154, 3, 'CHECK', '2013-04-05 18:40:48', '2013-04-05 18:40:49', '2013-04-05 18:40:49', 0, NULL),
(155, 3, 'INFO', '2013-04-05 18:41:30', '2013-04-05 18:41:31', '2013-04-05 18:41:31', 0, NULL),
(156, 3, 'CHECK', '2013-04-05 18:41:30', '2013-04-05 18:41:31', '2013-04-05 18:41:31', 0, NULL),
(157, 3, 'INFO', '2013-04-05 18:44:43', '2013-04-05 18:44:44', '2013-04-05 18:44:44', 0, NULL),
(158, 3, 'CHECK', '2013-04-05 18:44:43', '2013-04-05 18:44:44', '2013-04-05 18:44:44', 0, NULL),
(159, 3, 'INFO', '2013-04-05 18:58:15', '2013-04-05 18:58:16', '2013-04-05 18:58:16', 0, NULL),
(160, 3, 'CHECK', '2013-04-05 18:58:15', '2013-04-05 18:58:16', '2013-04-05 18:58:16', 0, NULL),
(162, 3, 'DATA USER PIN=1040 	Name=Julian 	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-08 16:48:22', '2013-04-08 11:49:03', '2013-04-08 11:49:03', 0, 40),
(163, 3, 'DATA USER PIN=1041 	Name=Julian 	Pri=0	Passwd=1234	Card=[0000000000]	TZ=0000000000000000	Grp=1', '2013-04-08 16:49:45', '2013-04-08 11:49:47', '2013-04-08 11:49:47', 0, 41);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_device_data`
--

CREATE TABLE IF NOT EXISTS `ilg_device_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  `register_date` date DEFAULT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `device_id` (`device_id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_device_info`
--

CREATE TABLE IF NOT EXISTS `ilg_device_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) DEFAULT NULL,
  `Style` varchar(20) DEFAULT NULL,
  `FWVersion` varchar(30) DEFAULT NULL,
  `MainTime` varchar(20) DEFAULT NULL,
  `MaxFingerCount` int(11) DEFAULT NULL,
  `MaxAttLogCount` int(11) DEFAULT NULL,
  `DeviceName` varchar(30) DEFAULT NULL,
  `AlgVer` varchar(30) DEFAULT NULL,
  `FlashSize` varchar(10) DEFAULT NULL,
  `FreeFlashSize` varchar(10) DEFAULT NULL,
  `Language` varchar(30) DEFAULT NULL,
  `VOLUME` varchar(10) DEFAULT NULL,
  `DtFmt` varchar(10) DEFAULT NULL,
  `IsTFT` varchar(5) DEFAULT NULL,
  `Platform` varchar(20) DEFAULT NULL,
  `Brightness` varchar(5) DEFAULT NULL,
  `BackupDev` varchar(30) DEFAULT NULL,
  `OEMVendor` varchar(30) DEFAULT NULL,
  `AccFun` smallint(6) NOT NULL,
  `DelTag` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_device_person`
--

CREATE TABLE IF NOT EXISTS `ilg_device_person` (
  `device_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  PRIMARY KEY (`person_id`,`device_id`),
  KEY `device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ilg_device_person`
--

INSERT INTO `ilg_device_person` (`device_id`, `person_id`) VALUES
(3, 6),
(3, 7),
(3, 18),
(3, 22),
(3, 24),
(3, 25),
(3, 26),
(3, 29),
(3, 30),
(3, 32),
(3, 33),
(3, 34),
(3, 36),
(3, 37),
(3, 38),
(3, 39),
(3, 40),
(3, 41),
(4, 6),
(4, 22),
(4, 26),
(4, 42),
(4, 43),
(4, 44),
(4, 45),
(4, 47);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_device_status`
--

CREATE TABLE IF NOT EXISTS `ilg_device_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ilg_device_status`
--

INSERT INTO `ilg_device_status` (`id`, `name`, `description`, `enterprise_id`) VALUES
(1, 'ONLINE', 'Dispositivo se encuntra online', 1),
(2, 'OFFLINE', 'Dispositivo se encuntra offline', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_device_type`
--

CREATE TABLE IF NOT EXISTS `ilg_device_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ilg_device_type`
--

INSERT INTO `ilg_device_type` (`id`, `name`, `description`, `enterprise_id`) VALUES
(1, 'Huella', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_doc_type`
--

CREATE TABLE IF NOT EXISTS `ilg_doc_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ilg_doc_type`
--

INSERT INTO `ilg_doc_type` (`id`, `name`, `description`, `enterprise_id`) VALUES
(1, 'rut', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_enterprise`
--

CREATE TABLE IF NOT EXISTS `ilg_enterprise` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `identification` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `telephone` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `mail` varchar(100) NOT NULL,
  `initials` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `image_dir` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) DEFAULT NULL,
  `parent_enterprise_id` bigint(20) DEFAULT NULL,
  `activation_date` date NOT NULL,
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `parent_enterprise_id` (`parent_enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ilg_enterprise`
--

INSERT INTO `ilg_enterprise` (`id`, `name`, `description`, `address`, `identification`, `telephone`, `mail`, `initials`, `image_dir`, `status_id`, `parent_enterprise_id`, `activation_date`, `expiration_date`) VALUES
(1, 'CloudTimeControl', NULL, NULL, NULL, NULL, 'diana.dm3@gmail.com', NULL, NULL, NULL, NULL, '2013-02-27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_extra_hour_type`
--

CREATE TABLE IF NOT EXISTS `ilg_extra_hour_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ilg_extra_hour_type`
--

INSERT INTO `ilg_extra_hour_type` (`id`, `name`, `description`, `status_id`) VALUES
(1, 'Por día', NULL, 1),
(2, 'Por Semana', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_fingerprint`
--

CREATE TABLE IF NOT EXISTS `ilg_fingerprint` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL COMMENT 'owner of the fingerprint',
  `template` longtext NOT NULL,
  `FingerID` smallint(6) NOT NULL,
  `Valid` smallint(6) NOT NULL,
  `DelTag` smallint(6) DEFAULT NULL,
  `device_id` bigint(20) NOT NULL COMMENT 'device that take de fingerprint',
  `UTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `person_id_finger` (`person_id`,`FingerID`),
  KEY `device_id` (`device_id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `ilg_fingerprint`
--

INSERT INTO `ilg_fingerprint` (`id`, `person_id`, `template`, `FingerID`, `Valid`, `DelTag`, `device_id`, `UTime`) VALUES
(4, 6, 'TAVTUzIxAAAFRkYECAUHCc7QAAAdR2kBAAAAhes1PkYsAO0PaACPAAVJ4wBVACEPogBSRmIP2gBpAFkPLUZ+AEkPrQBKAJ5JwACVACsP6ACcRsgPeQCjAIYOl0anADEORABtAEJJuAC3ADYPZwC9RjgMcQC/APAPiUbJACkNpAAKALFKhgDYAC8PbwDbRrMNyADeAPwOaUbjADIPTgAgAD9JJwDqAEUP+QD2Rj8PkQD1AGoOt0b6AL8NaADEAS5J1AADAcIMewAARzwM4gAGAfoNtUYJAbwOXwDJASpJ8gASAcIOkgAdRzIMPAAcAf4OKUYgAUEO6QDkAbtISwAkATsMfQAvR0EPNgArAYQNgUYqAa8OUwD1ATRMIgAzAUQOWgA2Rz0NXAA2AXIKzUZAAUYOlACAAURKqgBHAb0NuQBNR7AMigBLAXoNxUZSAcYPhQCQAbRK3gBZAb4Pau6yyd6nxJ8bFiK7tMC2+7+L4Gd6e45ZtH47cUsDtINmQyLr8XFKbd9n5Nej9bf0cYMUh7rNQBaJE2oftPrQtJsJ0YPjAYoVzLirhBYNRQZAhuxMWA8Z924IYPxgMDzz/QSJfpyOGE7E/0Z8gQAXeAOyy4iifdqGhAfLvpcIrf5GCK8SSEw7Dm8OKQYU+oNAh4Da8bb9zQfYwnsMsfyx+9v4zcE8htIBvYAkgEQ4zX9dfXmDSf+4xv99LQSp/Hf0HENYhVIBJQR0+ZBAXACV/Ln8pAAwTpT9nf15g6v9aErcACkJtQes/5fC4AARCLH9GHcbRv9waH/1+NACFEMsBR4Jnf20gjy5YYtpfoaESIHkTbOIqIcVBViSTDhsgtn62fQ8AMg0FROsg0kQSIFUTMMIpPd5AGhyT75neFMCLgjkAWDyHCBIAQKl5RgMRpAWCUvA/4EJBRQZcMLC/8IEcAFGYhx6lQUA6yRswQIAEkVWwdUAbgD2KP/+wf6DSvpOAWNMbcHDBMCRSQFrTf3/Mjv/+nhaFwDeUZyqcseEbsF5wcFSBBMFJVRrlnt4UzrBxBwRAGtW/TM6//q4/sDCP/kZxfNT2Gp+d8T+wUDExcXBZwUA41niwSBUAWVbZMJ8mcHFLP5PEQDYZlt4e9fDwJDCCQDhgUmH/sFZ/gwA7INGAmVFwB0A+EypxS/AeMLBwMIHwYWHw2TD/m8WxaqP2MPCwsWjiwWFhrlLAwEAkSc4DAWCmS1J/8H7O8LFuQkAhZpQogZPDUaSniLA/vwFPQxGjaBDlf/+PsYRRkejxv7//gX8+73+/jD/wf4H/MZKAUCqSWvBOmh1QQF4qkPCfwcKBQCqQ8BZc8HNAL/6NTjBPQcAO8JGucDAPQcAcQY0bzYFAI3LJ8I8AwVFz0DBBQDxFEBdRQAJ0kbBGcVO5ftE/v///cE//SK4MMJDVgQADeMxuMMEAGznMbkGBQ3pQMLAYAfFUu18wX7BCAD/LDT4dHwFALbqNzh6EUa96rfATcIHw8GAxMLCwsLAB3IDRiTtQEDBCMXe8QY+w8P9AwD59z+GHRDWAMPEBFLFwsPDw8bDwgH/x4T+ecDA/gbUCgYA/8H+wwcQrAQuh/zC/MIDECcKRYQGEM0PQMAHwENDEWEQLVQD1ZcUcsEFEIQTNIUFFbUXTMCdAxAHHT+GBBBAHj3BBfsDVo4fNynFBdWVGnL8ZAYQOyCFwvt3BRAsJUbCOwUVDilAwh8EEIsoRYT+BRA2LkM6PABWtC5AZQMQeS44uQIQ4DE3wMAQZn4fMwYQp0N/WsVAAaP6LSn/xhDOAkHAAxBgVcb6AAAAAAAA', 0, 1, 0, 3, '2013-04-04 06:17:04'),
(5, 7, 'TTVTUzIxAAAEdnQECAUHCc7QAAAcd2kBAAAAhJsvjnYlAIQOOwCCAPZ5ggBWAAEPcgCKdhgNtACVANoNZ3aWAPMPGAByANZ5WAC4AOkOdwC8dikPpgDBAF4PTnbJAE8OngAMADJ5EQDNAM4PRgDRdk8PMwDWAI4PkHbWAIwPQQAlAMt44wDmADgPAQDrdkUPlQDxAAcOA3f8AC0PswDGAUt5jwAEAVwOLAANd0IP/gAQAf0PynYXAVMPTADZAdp5DgAgAccPrwAkd2UOdgAgARsOPHYnAdIPugDsAdR5ZwAxAWAOPQAxd04PcQA3AYQOSnY6AegOegD+AeB5XgBCAVUO4gBHd+QPzgBGAYsPU3ZNAWkO7wCJAdR4eABOAfQOFABXd8kPYgBYAYcOFnZaAeUPdgCYAdx4QoVvly9vXvN7Bb4DR33TE84TvIiv87eCMApj+avy2w3jprunOAbW/L6F9Z5m+Socufq89x4JRGcIdEVlEGqBg50H6Z+h2iwTgf6+hQYBPbIjGF6MUXzk/8YLeEDNWDXPiISF9YrovvSC9acPnYEzDHLyDWm4O24CpPXG7Or3yA9KisuN9Z2CgeMNSXiv8C4YHQ0Q9pafkIceEMoE1A6uCuP4wvbi5z7nGP1kBFEmJH/EgunonPbO7AbtVH/e82uCNCPp/LQNhfT7GaIDUF8R462bqJXFgYmL6aflhzCGiO/99Xht/nZzFZb+aIv/gd739Rc5KMWBRIIufjuF1RxREYS2dAmz+Gf44diMbf2YewBbI3cXtOQx72/1LTAS2VUNJEAAAh4bhgfFhiL1xcBpCgCx9IaABGgOAK87g73AxiTBwoUEACuOZH5kAdNRk4lpoXDHAgkAh1P6QAUmCHZ+Vnp7w2cEeAx2h1kDSv7BOxUExI2Xw8HDdblwdLdwCwC6jRDw/0A0BwCqjpDEBYgBdpySg4QLAHySHrY/PlUIAKRSFjJNCgC2mB7ABTVQthgBBJmcWQdcxAOF/8Nxwn3IAFvsZsCJWcL/pRYEVqbaQTg8Rob++7b/wBIAXbQi//lS/P7A//78BMD6Jg4ApLygxAHBwbbAxMHBwcE4wA52tLwkLsH9O//6dQEFwjf8GsUUyKU5wP//NUA7N/pLwP44CgCgCDT7i8EqNwQAERRJQH4BhtMi+P84/vuJBgCS057KbP0Ddn/YU8D//qkMBPPYQPz/K/8FwjB+ATLcTGL/8AwEkOY0YC7A/u4IBJboPcD/L//QAEqDyP8x/vv9Of76i/zA/MH//Tv/EXZU9dBB/vrSwPlN/8D/xacExcXxNTYEAFH9TPYDFXMBNMIEELPMUMSLBxDpDkD/Oz4HZgcQRsIGEccSNIj+IQgQ/BP/Qf8xCBDMG0818MAMZmQgacHD/DrAxnURayRiwAfVNi4oYYMIEGQ0pS3ESgUQnDVi/QEEFNZEaU4FEMqMXvtdBBBSTG3AqgMULEw9+AQQVpVW/ogpEARU10MEw3e3wB7B/v39B/v7iv9X/jDAOzv/+0gAAAAAAAA', 0, 1, 0, 3, '2013-04-04 06:17:04'),
(6, 26, 'TfVTUzIxAAAEtrUECAUHCc7QAAAct2kBAAAAhFsuv7ZHAIsPRwCNAHa5wABQABQPgQBTtvkPtwB4AEgPf7Z9AH0PXgC6APi42wCBAJ8OqQCLtngOVACRAD8PcradAAcOuQBbABy5lACmAIcP5QCwtl8OowC6AN4PD7e7ALUNSAAJAGG5ZADMAGwPywHKtrYOsgDPAFMP+rbQAKQODQAaANu5dwDfAAkPPQDmtqAOCQHoAHAOc7btAGMPTgA8AEu5egAIATkPdAAIt6AP+gAMAW8NVrYSAUEP/ADlAba4vQAmAagNAAAity4NoQAoAdgMELYsAWAOAQHrAba45gA3AaAOfQA9t6QMKgA+Af8OGbZBAUwNoQCAAZq6HQBPAUkNHQBVt4gOJgBUAfUN5bZcAZUPIHv+ASdZWHxDezP33Yu+PJp2UYiz/HoD+kczdr56YQZEg07O2AWphYGDqxVCPY6OLXSpfUCCWbeEgpb1IZCHjII2x/3ikSqO5G6CNvNxO/h3gMpnCSCMh0IFBQHkExqhHPtWG7MI/GaRvUMJQRSFBdQHlcmygJMR1ezsBQ1EdoCXf7OTcasdKLfSrf3t7QfsXaN4EpUD3F+cL85PbBMm7+7vxNsChL/7Efs2hMN0EU8P+ar2+ffzCydUAACNCS4UHXols1SP0Iqpjj+QZcF8e6WDURX4K16vgABBF4YJEPMyrsPwpf21eowLxEWk8o0OLBe8BOFb0Pulg8L6iRv9ShQSHfTO6Ffm4F0A5hn6kQx39o9EGjaPCJYV5TsFtGsgJQUAeeAAQb4Bei0DSv6kCwQPQIzAwmpzBAQE9UZ3bwkAS4L6xUhhUAMAv0jJwAC2RExtPgUAAFIUSBwRAEZT9DpLXEj9wv77wMU6BQT2WXBoDABInPrEdj//O8EPAHB0lHbDdItnbhDFFHJHWv9GwP87kwgEDXgTU/1rD8Wzfj/+eMPAwMGiwMS5AVeN90D/h/829wgAUJN0wjrC+nWkDAB6mQDuL8T0CwBynHrBvcHFd8AKALyfFwX/QEg2GAAJoOc6RllI/ME+wD3/OsElugGRqIPAhgTAenQKAJmoEMA7RsVJwf8DARKohv8dtgex3v4/wDr+ZEhNwDvC/v3/FASSsOvAPsAw6v3FSVXABAAcs6KuD7anuxr/wMA7XcRLCABMyfE7OsApsQFEymmAjssAZXxxwsCJwv8B/vrmEABpy/cuOzg6wi0QALHLmgXFdibAwYPCBgCD0G10ggsAYdBrBIDGSX4EAQ/SOvMJBADSHsA/VgnFetqwKzDDDQBzKW3BLcDCwcP/mc8ASUtSd8KgwgTF/vuLXRkQBQLMOv77SME7wf3+wjj/xEj/wP/AwDTBEQK0NjsFEH8Eyv37dxUQrRygaQDLm3TDjMF2wRLVrgwUeMLCxcPEBcDHd8OgDBB4C4bDx3fCeWYEEH7OOqS1EYUSEPwJ1YYQn8PA/cTEc8IQVa5CkYcSELvnqcd2wcCvxZbCB8KRsxHIKh7CPMIQooYmxsH/KhrV5DIq/jKHw8HDAcCZd4nAw8KXG9UqPXBD/f///v87KfhJ/z3B/3QzwRDUixIlBBAsQfGgB6YYQlfB', 0, 1, NULL, 3, '2013-04-05 05:08:00'),
(8, 38, 'SkNTUzIxAAADAAUECAUHCc7QAAAbAWkBAAAAgi0VkwBrAHIPsQC3AAMP1ACQAIQPYwClAP8P5gCqAEIPWQC2AOMP9QAUABQPrQDUAG8PHADnAIYP3QDxAN4OhwDzAOcPvwAzAHcP7QD9AJQOkgAJAUoPvgAYAZoPcwAcAUYPzADqAVAOvwBAATkOqwBIAUEP2QBSAeAOmwBYAb4PGnWGdyTzC5GffMsF4/yYhG6Jv5BzfYoBoQQvc0cDx/9S5+Cb05HG/h6T+/7McCLoLWwi9KcUGpSAieKo76BGeQSdB1j27E4VTHmRDLd/UgQjZa4PTg/n7WIq1vy6CAxgiB7Z92Ix4OphFAveTocD/DL39ewP1QvLUoNrh7ybIzACIC0BxOMYkwYAm0R6dKoDA21EccANANiNgF9rwcP/gQ0AJVF+ZXHAhcIRAC9dgMDDWf9xwv8HewoAjWpxaoXC1wD9bY14fnxkwgVvBAC0bv04cgzFrXB6isH/g2AHxbV3A1XA/wwAtb59wXh5wv/ABwB5fwM+RwoA0o+DBYuAwREBEJ6Wh7fAx8DDasIFAKtg/fw9FwEWr5qLQJDCeMDAd28WAcq1kGvAicLBbsC9fsIFAVe6XsJZ3gERwpLBwMJmwQTCwsHAwcF4wcAHQMb+GgETz5qDt8LDw33BwXh0SmQDA/nTF/8OAKkRcY1sZ1USARffZ8TDc4jCgHzBEMXU4IzCiMLAnmq2DQOG8eIz/f/9kUwaARTxnmuJwgTBk8PBg13BcQvFuvV3w8SRdcEYxBT5nMFvwInBwwTDwoTBamwQAOY7lsHCj6DBwmnBwQDz/xtZBRBTDonAVQYRWQ5JWMDQERUToXDBxE2WBsPDg3IHELkZZAGRwQYRbyBDVMLXERcnm1LDesLEBpaDEBAPMJ5qggbCx8PAw8DCDxHDNJ/AeI/FiHYD1cBHOsINEQdDogfAwsLAyMTCw5fOEPxHm8B9xsbEUAMTzkktwQkQ/pCiwf/DycyaAxAzWJ/ABRDRQiJc', 0, 1, NULL, 3, '2013-04-05 05:31:40'),
(9, 39, 'TT9TUzIxAAAEfH4ECAUHCc7QAAAcfWkBAAAAhKElynwTABQPwgDkAIlzfAAmAIAPXwBFfAoP2gBCAFQPMnxGAPIPoACRAIFzaQBnAHIN0AB0fFMPwgB3AOUPFnyBANQPZABGAAVzSQCEAGIO+QCLfOMO5AChAGEPTnyiAOwOHgB2AEtzegC3ACQOegC+fDEPlAC7AFoP5ny8AC8PcgAPACpzZADLADgP3QDdfM8PIwDdAI0P7HzuADMPyQDDAThzBwEaAb8PbQAifUoPZQAvAXoOOXwxAScPWwCFAa9yggBDAVsO7ABLfSwOegBPAR4O2HxOAc0PbACVAdVyyImnhNMLFHkeglqFInYn/4oTrfUXjluBlgZifEcP6qGng8eTdH0bGKIHVXNyE8bvcfxKcQthA5xCfjfvdIS+9+eFOKNB798WgYAdY5t4hfzE+pbjIXeDd4f6PA5SjHLuv4JqdyZksfllhgfsUn3TkzqPaX6XceYPFI/WAY/9FfshcUORRA8uFDZMxPd7gpPnyH8z+ytvt/oLBXd16wqjjFJ/a41Ph9r3E2ye8JtzGRU/8d4Zb32y/VpqaO3xomuFgYCRj3udKnVKhVdfJQxEgD5NUoeTE2uTaPhJVpx7dc2P1cogQH0DnSMxBgBPAQe8LgMAxAEPBAgEIgp6w/6Hws4Ac3H2McD9Yv/DAHpvAv9PCQBk03rEvsJRwwMAz9MewHIBbBcGWv86T06DCwB5IobCBMHHHsAIAIEmAzrBN7wNAHkpgIUBwV73CwCdQgb+OkQ6cQE4Q+3/PoH/MXgB3kUaTxLFOk2MQjb/wCvAOj4BfDNKaXcMAFhQjb7AbnyIBACpVARBCwBkVXHABITFJw0ApFYPwDtM+i/BEgBqWgMENjE8/sBY/QwApmhw98LAXMHBFcUYaZzB/v5M/sE7/cS9/8D+wP/AOgQEuXkiWRcAaLr6+bwrRf3A/leu/vuC+wkAYIZtTMNedQFohv39wDjA+YP+EABMnuI4/viC/i7A/v9gywB844GfgHCDFsXgpOJDwofCwXpVfn5qAU6j6f79OCr7ScFGVC4FACKkKb5PEABHplcFi20EgcMbACGvE0c1vP07PMD/UwU+a3EBd7SAxsJY/8KCw3gGABq1ln7FfwEgt0/BCsV/s2AyQEkSAJB8nMS6xMLDwcLBBMDAvMHCw8APAL67ID3+RP3/wP46+wh8wrsp/lRdOjMIfL+9NMFLwoNMCnyZvyf//sDy/z+C/gcA48ErOln7dQFqyykxVzgLBAnMKzVL/v06CgQlzkb/w2p0zABhrDX/RTADAMHVQr4fABzW08I6O/tB/TM7wEFVBv3GTggAFt1JVgaBDXwe4ElJk8DPACGdQv+Bw8DABgUElfIxRgMQ+PVG+3UBBP5DasUFYANsxwk9VCkH1c0NS/44/AMRFcg9+mgRZiq9ZEU+9/KCMEcqBBCl709NeBGrKkP9wMMQRU8mwsDBygTVOzBNngQRDTVT8QMU5F93/wUQX6d9UX8R32KAwQAAAAAAAAA', 0, 1, NULL, 4, '2013-04-08 11:43:10'),
(10, 22, 'TLFTUzIxAAAF8vEECAUHCc7QAAAd82kBAAAAhR9BW/IfAHwPGgDtAOr9SwBGAAEPgABR8mMPwQBWAOcP1PJZAJ8P3wCbALf9twBlAJ4PLgB38h4PigCGAF8Pm/KLAC4PVwBdAEH9bQCcAEcOLwCY8jcPJACiAIMPa/KoACoOjwBuADb8/ACtAK0PLAC18rUPTwC2APYPbPK/AB0M5QAEADX8jQDFALINoQDI8i0NiADQAGEN4PLRALENewARADf/nwDUADkPjgDe8jANLgDcAP4PaPLgAKwMHAAuAEX9UADrALMNbwD08i0PTAD8AOkOr/L+ACwNzADEAZ/8YQAGAawNvQAN8+MMhQAIAWcMlPIPAakMtADXAYv+HAAVAUkO9gAQ8zsO1gAWAUgPD/MXAZAOPQDSATn8oAAeAY8M/AAm804NYwAkASwODPMmAasOqwDoAXn8YQAxAdYNcQA28wAOzwA2AUUNOfI5AeIMTgD8Abv/VwA9Ae8NdwBF83cP1ABBATwNefJLAXoPsQCOAfr9LQBSAQIOugBX8/kPWgBTATgOX41WH4OPq/J2j4qFzKBWhxcWKGD2GcJ3ZYS5ha9w9B5ofFIAYRQ8ll9ivH3SAN7vyG4Hc6Pr8W1OVedp2Gen/SqTRf2cH4/idR/BBX4tSIVseJMJTxQ3BbIPFRWgDvHrkYMXCCf3TPlxejp80ISUc8gJWRsa8LcItAIs9vHvkYDcfDN2HRMxgu165BCAcGD+rPdRdCBulHKX/KoHQZB0iTRw0JblinoMRIA49cz7qf5FD5OKsI+Egkr4JQZH+2r6gIQZicIIUAADBouhIXlpgm/wEPKAocGHFQ6ID2+DaILZzhLEZUMkyKg7YMPw+z8Vafn4HmHLoWWYAkTlOBJO/DoMlQNwHsjyofY+DL8BMBZyBX/7zAdV7x/iGBXdApHqxRfk5mxt4Bft/z8snO5mIke3HH9o7TD7de8J6BkZ3YfBfcQGMIuFg7MMpNdYlaX31NKA3bQbJTJtGMn2iXvVhbz9NHsKhd/5PXR/faamRIuMAj92VyBmR4ME/YIPDysnPRIxQ4spWpIkYyAstFbFIE3zA78iOggAUgEDDsH//8L7A8WyBPv7GwEUCDo6VWEyWcFVwMDBlFjE9QGVCRA+TMsARvn8RED/PsAFAwXUFHDDBgBa3oDHMsLACgBiHsY4+sz+CABaIXoFwsR0EAAdJOf+Ozj6DUpEQBAATof9MMz8U1XACACDSHUxh4EQAFJIxsD6D8EwRUrAEMUDVLJkwF1iVMLBAOGjKHYRAElSMij7wv7AwGBdEcW+V2zAwIuAwcEEgMT5AUFTbZ12qggFN1cc/8D/wvQEBPWhQ5UPAEOdZJUwWcL+wmQIxcFf1lrBPRIAs6Six4qCxMCAwcJKAwUTYx7BFwAHqdP6D0ow/kH/QaBpEPKJgp7Dj8YEwsQwwMDBwMLABv/4MgYQTSq0wwX9V/8Bn44tZMAFxPsygQYAVZ1DB4MS8iSeyf9A/Dj9+w0rVkJiBQArnygNdwUAb6AnB/nD9gFmpTqpCsUgo7tqWVEOACZjQFQywkT/NRAASKeuZ8XIwcR9YjsIBWGsLf/Awv5jEAV8rjfAwfxtAMbCD//CNQQA63YkRvQBT7o0wcGTAwWZwCDEDQCJBL3BMcDEz8TCwgEwAfLowyTB/wTF6NbWhAUAi9Q9Onsc8izXwFj/Mzr7+Qz+/f02wGS5BQVt2Df+VwUA799FMMD/BQDk4eXBxggCAHDkNPzDANcdI8LBw/0DxRz0ssEIAKv3HgHA+zNxBBBPACfsIBWuAqL/KUv/O/35CP/+/f/9wQX/xA3CwcDBwcEG/gHiqwMaxMAD1XEV8v4DEBkYSToEFe0ZPS0EEI7fgMU1EhBkLuv9OF3FMCr69/b9/pIGFVUvfUnCBxB9MfIP/Or9/QcQdTNxMvxtBBCuPr9dBuJTP3f/BBB0RHG9BxB4SX3/BjoK4jFVA1pywAf+Pw0HEKlgA8CuBhVlYIBowQMQi2OFMAAAAAAAAA', 0, 1, NULL, 4, '2013-04-08 11:43:11'),
(11, 40, 'TVlTUzIxAAAEGh0ECAUHCc7QAAAcG2kBAAAAhMcmhBohABMOeQDnAIsUmAAoAJEP8ABGGoIPggBXAN0PKxqEAA4PDABiAAMVOwCtAIsPRQC1GpoPtgC1AOcPLhrVAH4PTAAjAJAVyQD5ADUO3gD+GjoPKgD8ANgPxxoHAagOFgDIATMVyAASAa8OmAAXGx0ObwAhAVkOMhojAZ0PYwDuAZIU3QAtAbMOegAqGywN+gAwAQUPohowAZ4OmwD9AZIUsAA6ASkL5AA/GwwNvwA9AdoM5Bo+AaoN+QCDAb8USwBHAYkPvABDG4wPnwBHAUoOrxpGAZwLGwCIAQgX6QBOAawOJYZ9na7+5H76AOp6eZl7BEN5Q3cq9w91PokjiisGb4bTEjaPg3xb+GaKqmRHD3+E63quE0MR4oqX75t/0+5CeFNGghpWetp4mZaIipMKTSBUBRKk6OTJ65qCwfutbh9+Ff0tH6eehBGQfiKEgYJYitKZSAiBghoSh5B6cJuCzfyhftcJARNMi9L0lRB8BdWIAAYuGEYMiQsFbhgG1PshCMz+8ZZgDKmMwQGXcIad6Pgh9NGGwACJ4+DzNRGJ/pQT0uyn74Z/mvkj+fIY8fep+NlqoQ+xboQKQQFzhIpxhR7E8a7tpsqJ3wM6OgECLxzlwACDHxJCGwEUCP//UX7BWMFVwMAEUVzbBwBYCAn+OlcMGnUIEEbARsEAThERVwQATxjMQgkaRB8MSf3/oGAWGgwkAP/B/jpgRlk8CAB9JRoH/sXaUREADiwDBf/72kv9w/5VQMMAmTYbYMARAAnyADhHOVHB/v8ExQg6HGwUAAlI/ZUr+tr+VcH+wMCbFQQdU/03QP89k//E2sD//hEAAZATwST+RP7AVcAFCgScWRrAwMD+OsJSDgEIZf1A/wU++09NwFMVAAiqAE/bMMH+VMFEBMDEDgEHev3//wQqXCxpwiwHADRGBi51AgAHhP3/ygA3kw44/8HBMgVYEBoJjvr+LsCdwPraW8DAYBQAwpf+58H8WEP//6FqxR4BwJgeXAXFB6Xn/v7+BAACbT1WHgEQq/0sEcU+tA1FVcDA/3EGJhYaE7QALv9VnVXF2sAEALq1Ho8FBK+4J8IkDwDXvgQwQ//AwMDAnAYEFsMTxPvB/sMADv7sJP4JAE8sHlJ/wQ4ADPTaP/z55EXA/4UMAOP5QqtuQ8EEABo4PasRAS79Ez9iB1sCCisAJID/A9QECSr9CRBZD56wwc3fwgkQFRIwA8Q6cwUQ5iY9f8EQdz8WVwgQGyvKwUF6BRAIOS1zxhAhIAf+BBCwPvTExB4RIj8XmQfVTk0TXEsEEH1JyUkCCjdQBsDAwTsDFAVQEMEFEPCYnDweEclBJMDByBDAeYFawMHA/AZdAAAAAAAA', 0, 1, NULL, 4, '2013-04-08 11:43:11'),
(12, 40, 'TZVTUzIxAAAE1tcECAUHCc7QAAAc12kBAAAAhHsrk9YTAPwPSADjAOrZxgBuAH4P8QB91uAPcQB/ADcP4daAAA4PfwBBAG3ZJgCGAF4PuQCK1vAP4QCTAEAPztanAA4PogB8AGzZYgDPAN0P0gDQ1lAPIADbABMOf9bdAOMPmQAYAPbZKQDlAFIPJwDj1pMPFwDxAAsPqNb+AAgPkwDFAerZcQAEAdsPxAED17IPqQAMAdkP59YMAaIPqgDSAWDZ/AAaAa8O2wAm188O+AAlAWEOM9Y1AVcNJgDzAdHbZQA3AdcPfwA81y4NHQA8AQcMB9c/AcIO5QD6AZDZtQBFAewN8QBC194MSwBGAR0O99ZHAagOxQCJARPY5gBVAZIPOhO3VdIPi/ffDwb/Hqcr+0NyAYVi86slnIi1ARcTeIkOR84AZHuleIYDAasib28PXIvwAbdcxHlieKYLk4jmfU4AZnkKX7qFvSnaBq/uTH+UAnVRRYfQh/kK9AumJusKEhDWBZ+N0KmUhdECLvLX4xsxmH2B+nV/Be+5cPgekeqp1nOMpjtz+vMFFQWDEB7GobssF/kyNPfeJgMA2EvhXnt4INmY/WUP5fowD8qurfcN56rwYIR1r0iDFBepgAj5EdUvgx/5pUS4GgYbqe/R5oH36B1p9T8wAewpBivUYWqk1U+IaYmADaXcKPpJg5UDqBTBPzQZ+S0V6p+FzTusAnp9FcWmDlHQIUMBAq4k3g4EQAF6eMHAxPrBf90BcAF3wsIHOsSsCACvA4DEh3AD1xUIOv9VwsAA3NqCwH4OAJPWdMSle1zAwQYAXhUEi/8TAOkhiQdmYr/BwMJwwBXF6i9ff2Z7wv+Qof7HwAH0OY+DwZ/CYqjAw/39kxHF9kdfcnf/jP+EBRgF31KJ/3jBwKx4dBbBxP5ZBwAGa4QWdsEaARFrYaLFp2fBeMHAeAXAxVIZAQptk8KjaXSha3j/fAYADm8H7sEHAMNxfa52HNcTfJfBw/4GWnpdw1l7ZQkAqIJtocDBQwQA6kcMP9wBfIRpwMIEwWIoDAB9iukrjkv7FgwAgJDwwDvAPyn+wMD+BABokAScDwB4kWfCmWvFF/92BwDNpMk8McIBxaaDi8QEwG0XwFM6zBsB1KmkQsDBwcNqwUl0Yo5bBwDMqhD5WRHXELOchIfBOpd4Ff/Adw4BFn1AxBbBwMDAwMAFwF3SAZ66aXgQxBDHccLAw8GFjAd+ANYX2FCDDABf2eMr/P4nL/4QxX/fMln8/Sr/wOv8Atac3vQu/grFeOSMwHtU/gQAUOFgqgQAJOhXbMAALj9N/oEZAQ4qsMcXwcHBw8DDBMLGFMHCwcDBwjjD+owJAJL85P07/fvKCwCw/wD9P2rFLPsQEG4A0+7B+SkgMicHEJfF8Cot/gUQjwRetgUUlwZWwGUGEKsIVxbBRwYQrg/W+sYSwQkQpxNwAMD6FMEvERD5F2JOwhaQw8LBwMGeCBRwG1f//sDC8wMUKB8t/AcQrOdP+If/BRC1LUA/LQDGujIJNQUQaDRT+wIRDjVQ/8AQDO4swMLABRCkO14q/voEELhCPyEWxvVCrcRewA3BxxDBwf/AwSrGEMydDv4DECpWycQHxqZY9/0NEABjh4pUwMHBZgAAAAAAAAA', 1, 1, NULL, 4, '2013-04-08 11:43:12'),
(13, 39, 'SqVTUzIxAAAD5uYECAUHCc7QAAAb52kBAAAAgwsgvuYsAIoPjwCAAIfpYQBgAP0PdwBl5hEPzABrAEoPLOZ+AGIP5wBPAJ3pvwCaAJkPvACf5m0P7QCqAOkPQOa/AN0PiQAWABzpmgDTAI4PrwDX5vAPVgDaABkPvObdAK0P4wAYALHptADnAKcPQQD65lYMlAAOAWMNyOYOAaEP6ADWAZrpJAAUAeQPuwAV5/ENuwAhAVMPmOYkAYgPFQDtAe3p1gAxAYUPiwAw5+YPuwBEAbsPKOZEAfMPQACSAfXpZgk/fy//2nToG2qKb3rvn3KTemUSjKt5eYPT8jweCmdThy/723SF9FcH2v+3DDJtSKhif3+TDpAmlZybzwG6749zpJHh1qvKdXEO6DvhBvOP1CYXme2LAaBbMAjW/V4hlwVE6pqJufx2GMIIUlVzaPI6TbrUIoK1PA7lCxIdqPs9814E+fvb8H79gqhbmKZoyfajEAH2rOb29I6YqA+5G5oLkvBmCRft6RQH9jcF6vkD6aEdrP82BXoO7AdZ9C4LowomDOU1AuRFITYGAJLXCUgmBwB3GQPAOF0E5mofCcH/UsoAas8HSlj//v+O/wXmwDATRv8OxWow5jNoQP9UBMVQNJyIAwBsPgA7BwOCPn2MWQ0AVkYFpj8+UwsAi42Dw25nahEAY2A/QDgnNv7/TwUAcGYVJPz/EQDJaVbD/iVrw3RzbxHFM38Pwf7//sD++0BI4gErfmeABcUugLjBWRoAAool/0cm/kH/RP8zBTf9jhIAvJWeiEHCwCaGa20TALpfmsImwsHDhovAB/7BqAwAdJ1ww7bD/CZh/wYAwZ3iR/3iAfGrJ0QGxe2t1sD/UxMARH/cNxn/IzHBUJXYAARd31bA/zX+O/87yf/B/f/A/wXBwyQFAJfPk6/YAAQ20TJg////OP8w2sH/QP//wwXBCOaE0XqeWyvCAI40F/1bwAsAndbZ3fseNgoAjBIiw7yNwhUAvthowX8iwsXBwsHABMDCGMD/LwwAex8P/9zBgIkPALEipPxpxKL/Xf4LxXjrgsJLwCvABcW46MFtCwB38VYF/zYZRwwAfPRMOD7DG/7BLBwABzrXWyf+Uykq/v87O0oZgQUQfghW9x4THQ+eT0JnwVeWwG7+wP7D/lnfEOXplv7/Q2eYAcKDoMH/SgcQitUX/X/DERC2HpM6/f4l/sXKw8L/Ov7DG8MJEJUjjAHEwiY3EBDTNYD7gMcZRTgQEOU8vzjCq8NRXgoQt4CAwhl5wMDBDhAgSIMmw1NSwUsJ1dxQZYZDwQUQr6R9UeMRdGN9/10', 1, 1, NULL, 4, '2013-04-08 11:43:43');

--
-- Triggers `ilg_fingerprint`
--
DROP TRIGGER IF EXISTS `TRIGGER_DELETE_FINGERPRINT`;
DELIMITER //
CREATE TRIGGER `TRIGGER_DELETE_FINGERPRINT` BEFORE DELETE ON `ilg_fingerprint`
 FOR EACH ROW BEGIN

UPDATE ilg_person SET fingerprint = '<center><img src=/libraries/janus/img/icons/24x24/cancel.png /></center>' WHERE id = OLD.person_id;

END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `TRIGGER_INSERT_FINGERPRINT`;
DELIMITER //
CREATE TRIGGER `TRIGGER_INSERT_FINGERPRINT` AFTER INSERT ON `ilg_fingerprint`
 FOR EACH ROW BEGIN

UPDATE ilg_person SET fingerprint = '<center><img src=/libraries/janus/img/icons/24x24/accept.png /></center>' WHERE id = NEW.person_id;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_hour_report`
--

CREATE TABLE IF NOT EXISTS `ilg_hour_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `worked_hours` decimal(10,2) DEFAULT NULL,
  `regular_hour` decimal(10,2) DEFAULT NULL,
  `night_recharge` decimal(10,2) DEFAULT NULL,
  `extra_hour_day` decimal(10,2) DEFAULT NULL,
  `extra_hour_night` decimal(10,2) DEFAULT NULL,
  `holiday_recharge` decimal(10,2) DEFAULT NULL,
  `holiday_night_recharge` decimal(10,2) DEFAULT NULL,
  `holiday_extra_hour_day` decimal(10,2) DEFAULT NULL,
  `holiday_extra_hour_night` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `attendance_id` (`start_time`),
  KEY `rule_id` (`end_time`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `ilg_hour_report`
--

INSERT INTO `ilg_hour_report` (`id`, `person_id`, `start_time`, `end_time`, `worked_hours`, `regular_hour`, `night_recharge`, `extra_hour_day`, `extra_hour_night`, `holiday_recharge`, `holiday_night_recharge`, `holiday_extra_hour_day`, `holiday_extra_hour_night`) VALUES
(1, 1, '2013-06-06 06:00:00', '2013-06-06 15:00:00', '8.00', '2.00', '1.00', '1.00', '1.00', '1.00', '1.00', '1.00', '1.00'),
(2, 6, '2013-07-01 19:20:16', '2013-07-02 09:40:16', '14.00', '2.00', '3.00', '2.00', '3.00', NULL, NULL, NULL, NULL),
(3, 6, '2013-07-03 19:20:16', '2013-07-04 07:40:16', '12.33', '2.66', '5.00', '1.67', '3.00', '0.00', '0.00', '0.00', '0.00'),
(4, 24, '2013-06-01 19:40:16', '2013-06-02 07:40:16', '12.00', '2.33', '5.00', '1.67', '3.00', '0.00', '0.00', '0.00', '0.00'),
(5, 7, '2013-06-01 19:40:16', '2013-06-02 09:40:16', '14.00', '2.33', '5.00', '3.67', '3.00', '0.00', '0.00', '0.00', '0.00'),
(6, 25, '2013-06-01 19:40:16', '2013-06-02 09:40:16', '14.00', '2.33', '2.00', '0.00', '0.00', '0.00', '3.00', '3.67', '3.00');

-- --------------------------------------------------------

--
-- Table structure for table `ilg_notification`
--

CREATE TABLE IF NOT EXISTS `ilg_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `option_id` bigint(20) NOT NULL,
  `status_id` bigint(20) DEFAULT NULL,
  `period_id` bigint(20) NOT NULL,
  `exclude_own` tinyint(1) NOT NULL,
  `mail` tinyint(1) NOT NULL,
  `sms` tinyint(1) NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `status_id` (`status_id`),
  KEY `period_id` (`period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_operation_log`
--

CREATE TABLE IF NOT EXISTS `ilg_operation_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_id` bigint(20) NOT NULL,
  `admin` int(11) NOT NULL,
  `OP` smallint(6) NOT NULL,
  `OPTime` datetime NOT NULL,
  `Object` int(11) DEFAULT NULL,
  `Param1` int(11) DEFAULT NULL,
  `Param2` int(11) DEFAULT NULL,
  `Param3` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_id_time` (`device_id`,`OPTime`),
  KEY `device_id` (`device_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=83 ;

--
-- Dumping data for table `ilg_operation_log`
--

INSERT INTO `ilg_operation_log` (`id`, `device_id`, `admin`, `OP`, `OPTime`, `Object`, `Param1`, `Param2`, `Param3`) VALUES
(25, 3, 0, 0, '2013-04-04 14:53:55', 0, 0, 0, 0),
(26, 3, 0, 30, '2013-04-04 15:07:01', 6, 0, 0, 0),
(27, 3, 0, 6, '2013-04-04 15:07:02', 6, 0, 0, 1014),
(34, 3, 0, 0, '2013-04-04 15:47:01', 0, 0, 0, 0),
(35, 3, 0, 0, '2013-04-04 16:14:33', 0, 0, 0, 0),
(36, 3, 0, 0, '2013-04-04 16:59:19', 0, 0, 0, 0),
(37, 3, 0, 0, '2013-04-04 17:42:08', 0, 0, 0, 0),
(38, 3, 0, 0, '2013-04-04 18:33:19', 0, 0, 0, 0),
(39, 3, 0, 0, '2013-04-05 08:39:12', 0, 0, 0, 0),
(40, 3, 0, 0, '2013-04-05 09:20:15', 0, 0, 0, 0),
(41, 3, 0, 7, '2013-04-05 09:49:00', 1026, 0, 0, 0),
(42, 3, 0, 7, '2013-04-05 10:16:00', 1027, 0, 0, 0),
(43, 3, 0, 3, '2013-04-05 12:33:00', 65535, 65535, 65535, 65535),
(44, 3, 0, 6, '2013-04-05 09:49:01', 1026, 0, 0, 1206),
(45, 3, 0, 6, '2013-04-05 10:16:01', 1027, 0, 0, 960),
(46, 3, 0, 3, '2013-04-05 12:33:01', 65535, 65535, 65535, 65535),
(47, 3, 0, 7, '2013-04-05 12:33:02', 1027, 0, 0, 0),
(48, 3, 0, 7, '2013-04-05 12:33:03', 1038, 0, 0, 0),
(49, 3, 0, 6, '2013-04-05 12:33:04', 1038, 0, 0, 768),
(50, 3, 0, 0, '2013-04-05 20:19:57', 0, 0, 0, 0),
(51, 3, 0, 0, '2013-04-05 20:53:52', 0, 0, 0, 0),
(52, 3, 0, 0, '2013-04-05 21:27:52', 0, 0, 0, 0),
(53, 3, 0, 0, '2013-04-05 22:01:48', 0, 0, 0, 0),
(54, 3, 0, 0, '2013-04-05 22:35:42', 0, 0, 0, 0),
(55, 3, 0, 0, '2013-04-05 23:09:42', 0, 0, 0, 0),
(56, 3, 0, 0, '2013-04-05 23:43:36', 0, 0, 0, 0),
(57, 3, 0, 0, '2013-04-06 00:17:36', 0, 0, 0, 0),
(58, 3, 0, 0, '2013-04-06 00:51:43', 0, 0, 0, 0),
(59, 3, 0, 0, '2013-04-06 01:26:03', 0, 0, 0, 0),
(60, 3, 0, 0, '2013-04-06 02:00:03', 0, 0, 0, 0),
(61, 3, 0, 0, '2013-04-06 02:34:02', 0, 0, 0, 0),
(62, 3, 0, 0, '2013-04-06 03:07:55', 0, 0, 0, 0),
(63, 3, 0, 0, '2013-04-06 03:41:58', 0, 0, 0, 0),
(64, 3, 0, 0, '2013-04-06 04:22:51', 0, 0, 0, 0),
(65, 3, 0, 1, '2013-04-06 04:33:00', 0, 0, 0, 0),
(66, 3, 0, 0, '2013-04-06 04:34:26', 0, 0, 0, 0),
(67, 3, 0, 1, '2013-04-06 04:36:00', 0, 0, 0, 0),
(68, 3, 0, 0, '2013-04-06 04:36:47', 0, 0, 0, 0),
(69, 3, 0, 1, '2013-04-06 04:39:00', 0, 0, 0, 0),
(70, 3, 0, 0, '2013-04-06 04:39:40', 0, 0, 0, 0),
(71, 3, 0, 1, '2013-04-06 04:40:14', 0, 0, 0, 0),
(72, 3, 0, 0, '2013-04-06 04:40:40', 0, 0, 0, 0),
(73, 4, 0, 3, '2013-04-09 00:43:25', 65535, 65535, 65535, 65535),
(74, 4, 0, 3, '2013-04-09 00:43:26', 55, 0, 0, 0),
(75, 4, 0, 6, '2013-04-09 00:43:27', 1, 0, 1, 998),
(76, 4, 0, 3, '2013-04-09 00:44:08', 65535, 65535, 65535, 65535),
(77, 4, 0, 3, '2013-04-09 00:44:09', 55, 0, 0, 0),
(78, 4, 0, 1, '2013-04-09 00:50:21', 0, 0, 0, 0),
(79, 4, 0, 0, '2013-04-09 00:51:11', 0, 0, 0, 0),
(80, 4, 0, 3, '2013-04-09 00:51:19', 55, 0, 0, 0),
(81, 4, 0, 3, '2013-04-09 00:58:45', 65535, 65535, 65535, 65535),
(82, 4, 0, 3, '2013-04-09 00:58:46', 55, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_period`
--

CREATE TABLE IF NOT EXISTS `ilg_period` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ilg_period`
--

INSERT INTO `ilg_period` (`id`, `name`, `description`) VALUES
(1, 'Cuando el evento suceda', NULL),
(2, 'Resumen diario', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_person`
--

CREATE TABLE IF NOT EXISTS `ilg_person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identification` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `last_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `address` text CHARACTER SET utf8 COLLATE utf8_bin,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  `telephone` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `cell_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `notes` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `status_id` bigint(20) NOT NULL DEFAULT '2',
  `change_status_date` datetime DEFAULT NULL,
  `doc_type_id` bigint(20) DEFAULT NULL,
  `profile_picture` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `nick` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `genre` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `birthplace` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `schedule_id` bigint(20) DEFAULT NULL,
  `device_user_id` varchar(20) NOT NULL COMMENT 'User Identification for device',
  `Card` varchar(20) DEFAULT NULL,
  `Privilege` int(11) DEFAULT NULL,
  `AccGroup` int(11) DEFAULT NULL,
  `TimeZones` varchar(20) DEFAULT NULL,
  `Image_id` int(11) DEFAULT NULL,
  `fingerprint` varchar(200) DEFAULT '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>',
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `doc_type_id` (`doc_type_id`),
  KEY `schedule_id` (`schedule_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=48 ;

--
-- Dumping data for table `ilg_person`
--

INSERT INTO `ilg_person` (`id`, `identification`, `password`, `name`, `last_name`, `address`, `enterprise_id`, `telephone`, `cell_phone`, `email`, `notes`, `creation_date`, `start_date`, `status_id`, `change_status_date`, `doc_type_id`, `profile_picture`, `nick`, `genre`, `birthday`, `birthplace`, `user_id`, `schedule_id`, `device_user_id`, `Card`, `Privilege`, `AccGroup`, `TimeZones`, `Image_id`, `fingerprint`) VALUES
(6, '123', '', '', 'Mesa', 'No se', 1, '456', NULL, 'gcarben@gmail.com', NULL, '2013-04-09 01:32:52', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '94310678', '[0000000000]', 0, 1, '0000000000000000', 0, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(7, NULL, '1234', 'Administrador', 'Munoz', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:29', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1007', '[0000000000]', 14, 1, '0000000000000000', 0, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(18, '123', '1234', 'Andrea', 'Serna', 'Cali', 1, '456', NULL, 'gcarben@gmail.com', NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1018', '[0000000000]', 0, 1, '0000000000000000', 0, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(22, '76326772', '1234', 'Administrador', 'Benavides', 'Pinar', 1, '3002010425', NULL, 'gcarben@gmail.com', NULL, '2013-04-09 01:32:53', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '[0000000000]', 14, 1, '0000000000000000', NULL, '<center><img src=/libraries/janus/img/icons/24x24/accept.png /></center>'),
(24, '123', NULL, 'Nicolas', 'Bolanos', '123', 1, '123', NULL, '123', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1024', NULL, NULL, NULL, NULL, NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(25, '123', '1234', 'Pedro', 'Perez', '123', 1, '123', NULL, '123', NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1025', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(26, '123', '1234', 'Angela Espitia', 'Bena', '123', 1, '123', NULL, '123', NULL, '2013-04-09 01:32:54', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(29, NULL, '1234', 'Angela', 'Espitia', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:29', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1029', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(30, NULL, '1234', 'fontanero', 'Gomez', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1030', '[0000000000]', 0, 66, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(32, NULL, '1234', 'Katherine', 'Melo', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1032', '[0000000000]', 0, 66, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(33, NULL, '1234', 'Nicolas', 'Maduro', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1033', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(34, NULL, '1234', 'Zapata', 'Garcia', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1034', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(36, NULL, '1234', 'Zapata', 'navia', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1036', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(37, NULL, '1234', 'Camila', 'cifuentes', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-05 04:46:30', '2013-04-05', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1037', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(38, '76314381', '1234', 'Henry', 'Fernandez', 'av boyaca', 1, '3138328475', NULL, 'henrfera@hotmail.com', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1038', NULL, NULL, NULL, NULL, NULL, '<center><img src=/libraries/janus/img/icons/24x24/accept.png /></center>'),
(39, '2580', '0852', 'Julian', 'Ledezma', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-08 11:43:09', '2013-04-08', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1039', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(40, '2580', '', 'Julian ', 'Ledezma 2580', NULL, 1, NULL, NULL, NULL, NULL, '2013-04-08 11:43:10', '2013-04-08', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1040', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(41, '2580', NULL, 'Julian ', 'Ledezma', '12', 1, '12', NULL, 'amhussein@proware.com.co', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1041', NULL, NULL, NULL, NULL, NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(42, NULL, '1234', 'Leonardo Bola09os', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2013-04-09 01:32:53', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', '[68042e0000]', 0, 13, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(43, NULL, '1234', '', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2013-04-09 01:32:54', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', '[0000000000]', 0, 55, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(44, NULL, '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2013-04-09 01:32:55', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4', '[b895f90000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(45, NULL, '', '', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2013-04-09 01:32:56', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '5', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(46, NULL, '1234', '', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2013-04-08 23:33:37', '2013-04-08', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '6', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>'),
(47, NULL, '1234', 'OtroNombre', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2013-04-09 01:32:56', '2013-04-09', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '9853692', '[0000000000]', 0, 1, '0000000000000000', NULL, '<center><img title=''Empleado no enrolado'' src=/libraries/janus/img/icons/24x24/cancel.png /></center>');

-- --------------------------------------------------------

--
-- Table structure for table `ilg_person_pto`
--

CREATE TABLE IF NOT EXISTS `ilg_person_pto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `pto_concept_id` bigint(20) DEFAULT NULL,
  `used_days` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `pto_concept_id` (`pto_concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_pto`
--

CREATE TABLE IF NOT EXISTS `ilg_pto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_pto_concept`
--

CREATE TABLE IF NOT EXISTS `ilg_pto_concept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pto_id` bigint(20) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `assigned_days` int(11) DEFAULT NULL,
  `period` int(11) DEFAULT NULL,
  `number_of_period` int(11) DEFAULT NULL,
  `is_cumulative` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pto_id` (`pto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_pto_report`
--

CREATE TABLE IF NOT EXISTS `ilg_pto_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `pto_concept_id` bigint(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `person_id` (`person_id`),
  KEY `pto_concept_id` (`pto_concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_rule`
--

CREATE TABLE IF NOT EXISTS `ilg_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL COMMENT 'Owner',
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL COMMENT 'Variables Description',
  `url` varchar(2000) DEFAULT NULL COMMENT 'Guvnor URL',
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ilg_rule`
--

INSERT INTO `ilg_rule` (`id`, `person_id`, `name`, `description`, `url`) VALUES
(1, 6, 'Primera regla', 'Primera regla', 'http://cloudtimecontrol.com:8082/reglas/org.drools.guvnor.Guvnor/package/timecontrol/LATEST');

-- --------------------------------------------------------

--
-- Table structure for table `ilg_rule_enterprise`
--

CREATE TABLE IF NOT EXISTS `ilg_rule_enterprise` (
  `rule_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`enterprise_id`,`rule_id`),
  KEY `rule_id` (`rule_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilg_rule_enterprise`
--

INSERT INTO `ilg_rule_enterprise` (`rule_id`, `enterprise_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_rule_person`
--

CREATE TABLE IF NOT EXISTS `ilg_rule_person` (
  `rule_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  PRIMARY KEY (`person_id`,`rule_id`),
  KEY `rule_id` (`rule_id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_schedule`
--

CREATE TABLE IF NOT EXISTS `ilg_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `apply_time_control` tinyint(1) NOT NULL,
  `time_calendar_id` bigint(20) DEFAULT NULL,
  `apply_tolerance` tinyint(1) DEFAULT NULL,
  `pre_tolerance` int(11) NOT NULL,
  `post_tolerance` int(11) NOT NULL,
  `apply_pto` tinyint(1) NOT NULL,
  `pto_id` bigint(20) NOT NULL,
  `extra_hour_type_id` bigint(20) NOT NULL,
  `extra_calendar_id` bigint(20) NOT NULL,
  `min_hours` int(11) NOT NULL,
  `apply_extra_vigency` tinyint(1) NOT NULL,
  `extra_vigency` int(11) NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time_calendar_id` (`time_calendar_id`),
  KEY `extra_hour_type_id` (`extra_hour_type_id`),
  KEY `extra_calendar_id` (`extra_calendar_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_status`
--

CREATE TABLE IF NOT EXISTS `ilg_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ilg_status`
--

INSERT INTO `ilg_status` (`id`, `name`, `description`) VALUES
(1, 'Activo', NULL),
(2, 'Inactivo', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ilg_task`
--

CREATE TABLE IF NOT EXISTS `ilg_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `parent_task_id` bigint(20) DEFAULT NULL,
  `task_type_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `code` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `activation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_task_id` (`parent_task_id`),
  KEY `task_type_id` (`task_type_id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_task_category`
--

CREATE TABLE IF NOT EXISTS `ilg_task_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_task_taskcategory`
--

CREATE TABLE IF NOT EXISTS `ilg_task_taskcategory` (
  `task_id` bigint(20) NOT NULL,
  `task_category_id` bigint(20) NOT NULL,
  PRIMARY KEY (`task_category_id`,`task_id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_task_type`
--

CREATE TABLE IF NOT EXISTS `ilg_task_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_time_report`
--

CREATE TABLE IF NOT EXISTS `ilg_time_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `task` varchar(200) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `person_id` (`person_id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ilg_verification_mode`
--

CREATE TABLE IF NOT EXISTS `ilg_verification_mode` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ilg_verification_mode`
--

INSERT INTO `ilg_verification_mode` (`id`, `name`, `description`) VALUES
(0, 'Password', 'Password'),
(1, 'Fingerprint', 'Fingerprint'),
(2, 'Card', 'Card'),
(9, 'Others', 'Others');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ilg_area`
--
ALTER TABLE `ilg_area`
  ADD CONSTRAINT `ilg_area_ibfk_1` FOREIGN KEY (`parent_area_id`) REFERENCES `ilg_area` (`id`),
  ADD CONSTRAINT `ilg_area_ibfk_2` FOREIGN KEY (`area_category_id`) REFERENCES `ilg_area_category` (`id`),
  ADD CONSTRAINT `ilg_area_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_area_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_area_category`
--
ALTER TABLE `ilg_area_category`
  ADD CONSTRAINT `ilg_area_category_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_area_category_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_area_person`
--
ALTER TABLE `ilg_area_person`
  ADD CONSTRAINT `ilg_area_person_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `ilg_area` (`id`),
  ADD CONSTRAINT `ilg_area_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_area_task`
--
ALTER TABLE `ilg_area_task`
  ADD CONSTRAINT `ilg_area_task_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `ilg_area` (`id`),
  ADD CONSTRAINT `ilg_area_task_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `ilg_task` (`id`);

--
-- Constraints for table `ilg_attendance`
--
ALTER TABLE `ilg_attendance`
  ADD CONSTRAINT `ilg_attendance_ibfk_2` FOREIGN KEY (`verification_mode_id`) REFERENCES `ilg_verification_mode` (`id`),
  ADD CONSTRAINT `ilg_attendance_ibfk_3` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`),
  ADD CONSTRAINT `ilg_attendance_ibfk_4` FOREIGN KEY (`attendance_status_id`) REFERENCES `ilg_attendance_status` (`id`),
  ADD CONSTRAINT `ilg_attendance_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_att_report`
--
ALTER TABLE `ilg_att_report`
  ADD CONSTRAINT `ilg_att_report_att_ibfk_3` FOREIGN KEY (`attendance_id`) REFERENCES `ilg_attendance` (`id`),
  ADD CONSTRAINT `ilg_att_report_ibfk_4` FOREIGN KEY (`rule_id`) REFERENCES `ilg_rule` (`id`),
  ADD CONSTRAINT `ilg_att_report_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_calendar`
--
ALTER TABLE `ilg_calendar`
  ADD CONSTRAINT `ilg_calendar_ibfk_1` FOREIGN KEY (`parent_calendar_id`) REFERENCES `ilg_calendar` (`id`),
  ADD CONSTRAINT `ilg_calendar_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_calendar_ibfk_3` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_calendar_date`
--
ALTER TABLE `ilg_calendar_date`
  ADD CONSTRAINT `ilg_calendar_date_ibfk_1` FOREIGN KEY (`calendar_id`) REFERENCES `ilg_calendar` (`id`),
  ADD CONSTRAINT `ilg_calendar_date_ibfk_2` FOREIGN KEY (`date_type_id`) REFERENCES `ilg_date_type` (`id`),
  ADD CONSTRAINT `ilg_calendar_date_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`);

--
-- Constraints for table `ilg_calendar_time`
--
ALTER TABLE `ilg_calendar_time`
  ADD CONSTRAINT `ilg_calendar_time_ibfk_1` FOREIGN KEY (`calendar_id`) REFERENCES `ilg_calendar` (`id`),
  ADD CONSTRAINT `ilg_calendar_time_ibfk_2` FOREIGN KEY (`date_type_id`) REFERENCES `ilg_date_type` (`id`),
  ADD CONSTRAINT `ilg_calendar_time_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`);

--
-- Constraints for table `ilg_contract`
--
ALTER TABLE `ilg_contract`
  ADD CONSTRAINT `ilg_contract_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_contract_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_contract_detail`
--
ALTER TABLE `ilg_contract_detail`
  ADD CONSTRAINT `ilg_contract_detail_ibfk_1` FOREIGN KEY (`contract_id`) REFERENCES `ilg_contract` (`id`);

--
-- Constraints for table `ilg_contract_type`
--
ALTER TABLE `ilg_contract_type`
  ADD CONSTRAINT `ilg_contract_type_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_date_type`
--
ALTER TABLE `ilg_date_type`
  ADD CONSTRAINT `ilg_date_type_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_date_type_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_device`
--
ALTER TABLE `ilg_device`
  ADD CONSTRAINT `ilg_device_ibfk_1` FOREIGN KEY (`device_type_id`) REFERENCES `ilg_device_type` (`id`),
  ADD CONSTRAINT `ilg_device_ibfk_2` FOREIGN KEY (`device_status_id`) REFERENCES `ilg_device_status` (`id`),
  ADD CONSTRAINT `ilg_device_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_device_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_device_cmd`
--
ALTER TABLE `ilg_device_cmd`
  ADD CONSTRAINT `ilg_device_cmd_ibfk_3` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`),
  ADD CONSTRAINT `ilg_device_cmd_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_device_data`
--
ALTER TABLE `ilg_device_data`
  ADD CONSTRAINT `ilg_device_data_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`),
  ADD CONSTRAINT `ilg_device_data_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  ADD CONSTRAINT `ilg_device_data_ibfk_3` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_device_info`
--
ALTER TABLE `ilg_device_info`
  ADD CONSTRAINT `ilg_device_ibfk_9` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`);

--
-- Constraints for table `ilg_device_person`
--
ALTER TABLE `ilg_device_person`
  ADD CONSTRAINT `ilg_device_person_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`),
  ADD CONSTRAINT `ilg_device_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_device_status`
--
ALTER TABLE `ilg_device_status`
  ADD CONSTRAINT `ilg_device_status_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_device_type`
--
ALTER TABLE `ilg_device_type`
  ADD CONSTRAINT `ilg_device_type_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_doc_type`
--
ALTER TABLE `ilg_doc_type`
  ADD CONSTRAINT `ilg_doc_type_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_doc_type` (`id`);

--
-- Constraints for table `ilg_enterprise`
--
ALTER TABLE `ilg_enterprise`
  ADD CONSTRAINT `ilg_enterprise_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_enterprise_ibfk_2` FOREIGN KEY (`parent_enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_extra_hour_type`
--
ALTER TABLE `ilg_extra_hour_type`
  ADD CONSTRAINT `ilg_extra_hour_type_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`);

--
-- Constraints for table `ilg_fingerprint`
--
ALTER TABLE `ilg_fingerprint`
  ADD CONSTRAINT `ilg_fingerprint_ibfk_3` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`),
  ADD CONSTRAINT `ilg_fingerprint_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_notification`
--
ALTER TABLE `ilg_notification`
  ADD CONSTRAINT `ilg_notification_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_notification_ibfk_2` FOREIGN KEY (`period_id`) REFERENCES `ilg_period` (`id`),
  ADD CONSTRAINT `ilg_notification_ibfk_3` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_operation_log`
--
ALTER TABLE `ilg_operation_log`
  ADD CONSTRAINT `ilg_operation_log_ibfk_3` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`);

--
-- Constraints for table `ilg_person`
--
ALTER TABLE `ilg_person`
  ADD CONSTRAINT `ilg_person_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_person_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  ADD CONSTRAINT `ilg_person_ibfk_3` FOREIGN KEY (`doc_type_id`) REFERENCES `ilg_doc_type` (`id`),
  ADD CONSTRAINT `ilg_person_ibfk_4` FOREIGN KEY (`schedule_id`) REFERENCES `ilg_schedule` (`id`);

--
-- Constraints for table `ilg_person_pto`
--
ALTER TABLE `ilg_person_pto`
  ADD CONSTRAINT `ilg_person_pto_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  ADD CONSTRAINT `ilg_person_pto_ibfk_2` FOREIGN KEY (`pto_concept_id`) REFERENCES `ilg_pto_concept` (`id`);

--
-- Constraints for table `ilg_pto`
--
ALTER TABLE `ilg_pto`
  ADD CONSTRAINT `ilg_pto_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_pto_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_pto_concept`
--
ALTER TABLE `ilg_pto_concept`
  ADD CONSTRAINT `ilg_pto_concept_ibfk_1` FOREIGN KEY (`pto_id`) REFERENCES `ilg_pto` (`id`);

--
-- Constraints for table `ilg_pto_report`
--
ALTER TABLE `ilg_pto_report`
  ADD CONSTRAINT `ilg_pto_report_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  ADD CONSTRAINT `ilg_pto_report_ibfk_2` FOREIGN KEY (`pto_concept_id`) REFERENCES `ilg_pto_concept` (`id`),
  ADD CONSTRAINT `ilg_pto_report_ibfk_3` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_rule`
--
ALTER TABLE `ilg_rule`
  ADD CONSTRAINT `ilg_rule_person_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_rule_enterprise`
--
ALTER TABLE `ilg_rule_enterprise`
  ADD CONSTRAINT `ilg_rule_enterprise_ibfk_5` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  ADD CONSTRAINT `ilg_rule_enterprise_ibfk_6` FOREIGN KEY (`rule_id`) REFERENCES `ilg_rule` (`id`);

--
-- Constraints for table `ilg_rule_person`
--
ALTER TABLE `ilg_rule_person`
  ADD CONSTRAINT `ilg_rule_personperson_ibfk_6` FOREIGN KEY (`rule_id`) REFERENCES `ilg_rule` (`id`),
  ADD CONSTRAINT `ilg_rule_person_ibfk_5` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

--
-- Constraints for table `ilg_schedule`
--
ALTER TABLE `ilg_schedule`
  ADD CONSTRAINT `ilg_schedule_ibfk_1` FOREIGN KEY (`time_calendar_id`) REFERENCES `ilg_calendar` (`id`),
  ADD CONSTRAINT `ilg_schedule_ibfk_2` FOREIGN KEY (`extra_hour_type_id`) REFERENCES `ilg_extra_hour_type` (`id`),
  ADD CONSTRAINT `ilg_schedule_ibfk_3` FOREIGN KEY (`extra_calendar_id`) REFERENCES `ilg_calendar` (`id`),
  ADD CONSTRAINT `ilg_schedule_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_task`
--
ALTER TABLE `ilg_task`
  ADD CONSTRAINT `ilg_task_ibfk_1` FOREIGN KEY (`parent_task_id`) REFERENCES `ilg_task` (`id`),
  ADD CONSTRAINT `ilg_task_ibfk_2` FOREIGN KEY (`task_type_id`) REFERENCES `ilg_task_type` (`id`),
  ADD CONSTRAINT `ilg_task_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_task_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_task_category`
--
ALTER TABLE `ilg_task_category`
  ADD CONSTRAINT `ilg_task_category_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_task_category_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_task_taskcategory`
--
ALTER TABLE `ilg_task_taskcategory`
  ADD CONSTRAINT `ilg_task_taskcategory_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `ilg_task` (`id`),
  ADD CONSTRAINT `ilg_task_taskcategory_ibfk_2` FOREIGN KEY (`task_category_id`) REFERENCES `ilg_task_category` (`id`);

--
-- Constraints for table `ilg_task_type`
--
ALTER TABLE `ilg_task_type`
  ADD CONSTRAINT `ilg_task_type_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  ADD CONSTRAINT `ilg_task_type_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

--
-- Constraints for table `ilg_time_report`
--
ALTER TABLE `ilg_time_report`
  ADD CONSTRAINT `ilg_time_report_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  ADD CONSTRAINT `ilg_time_report_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `ilg_task` (`id`),
  ADD CONSTRAINT `ilg_time_report_ibfk_3` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
