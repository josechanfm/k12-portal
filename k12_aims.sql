-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 10, 2023 at 05:41 PM
-- Server version: 10.3.37-MariaDB-0ubuntu0.20.04.1
-- PHP Version: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `k12_aims`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `addressable_id` bigint(20) NOT NULL,
  `addressable_type` varchar(255) NOT NULL,
  `zone` varchar(255) NOT NULL,
  `road` varchar(255) NOT NULL,
  `building` varchar(255) NOT NULL,
  `overnight` varchar(255) NOT NULL,
  `overnight_address` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bankable_id` bigint(20) NOT NULL,
  `bankable_type` varchar(255) NOT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `behaviours`
--

CREATE TABLE `behaviours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `behaviours`
--

INSERT INTO `behaviours` (`id`, `klass_student_id`, `term_id`, `genre`, `qty`, `date`, `description`, `remark`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'ABSENT', 1, '2023-02-09', '54', '454', '2023-02-10 01:36:22', '2023-02-10 01:36:22');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `configs`
--

CREATE TABLE `configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `remark` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `configs`
--

INSERT INTO `configs` (`id`, `key`, `value`, `remark`, `created_at`, `updated_at`) VALUES
(1, 'grade_categories', '[{\"value\":\"K\",\"label\":\"K\"},{\"value\":\"P\",\"label\":\"P\"},{\"value\":\"S\",\"label\":\"S\"}]', NULL, NULL, NULL),
(2, 'student_state', '{\"ACT\": \"Active\",\"RES\": \"Resigned\"}', NULL, NULL, NULL),
(3, 'score_template', '{\"TERMS\":[{\"term_id\":\"1\",\"value\":\"term1\",\"label\":\"上學期\"},{\"term_id\":\"2\",\"value\":\"term2\",\"label\":\"下學期\"}],\"COMMENT\":[{\"term_id\":\"1\",\"value\":\"comment\",\"label\":\"描述\"}]}', NULL, NULL, NULL),
(4, 'year_creation', '{ \"kgrade\":3, \"kklass\":3, \"kgradeDefault\":0, \"kklassDefault\":0, \"pgrade\":6, \"pklass\":5, \"pgradeDefault\":6, \"pklassDefault\":4, \"sgrade\":6, \"sklass\":5, \"sgradeDefault\":6, \"sklassDefault\":4 }', NULL, NULL, NULL),
(5, 'klass_letters', '[{\"value\":\"A\",\"label\":\"A\"},{\"value\":\"B\",\"label\":\"B\"},{\"value\":\"C\",\"label\":\"C\"},{\"value\":\"D\",\"label\":\"D\"},{\"value\":\"E\",\"label\":\"E\"},{\"value\":\"F\",\"label\":\"F\"}]', NULL, NULL, NULL),
(6, 'score_columns', '[{\"REG\":\"平時分\"},{\"TST\":\"測驗分\"},{\"CLS\":\"課堂表現\"},{\"EXM\":\"考試分\"}]', NULL, NULL, NULL),
(7, 'subject_types', '[{\"value\":\"SUB\",\"label\":\"學科\"},{\"value\":\"ATT\",\"label\":\"生活習慣和態度\"},{\"value\":\"RPAL\",\"label\":\"獎懲遲缺\"},{\"value\":\"LES\",\"label\":\"餘暇活動\"},{\"value\":\"OVA\",\"label\":\"總體評分\"}]', NULL, NULL, NULL),
(8, 'study_streams', '[{\"value\":\"ALL\",\"label\":\"全科\"},{\"value\":\"ART\",\"label\":\"文科\"},{\"value\":\"SCI\",\"label\":\"理科\"},{\"value\":\"AAS\",\"label\":\"文理科\"}]', NULL, NULL, NULL),
(9, 'year_terms', '[{\"value\":1,\"label\":\"上學期\"},{\"value\":2,\"label\":\"下學期\"}]', NULL, NULL, NULL),
(10, 'habit_columns', '[\r\n{\"name\":\"health_1\",\"label\":\"衣服鞋襪整齊清潔\",\"short\":\"整潔\"},\r\n{\"name\":\"health_2\",\"label\":\"常剪指甲\",\"short\":\"指甲\"},\r\n{\"name\":\"health_3\",\"label\":\"懂得使用手帕或紙巾\",\"short\":\"紙巾\"},\r\n{\"name\":\"health_4\",\"label\":\"不把手指雜物放進口裡\",\"short\":\"手指\"},\r\n{\"name\":\"health_5\",\"label\":\"能把癈物投入癈紙箱內\",\"short\":\"癈物\"},\r\n{\"name\":\"behaviour_1\",\"label\":\"守秩序不喧嚷\",\"short\":\"喧讓\"},\r\n{\"name\":\"behaviour_2\",\"label\":\"留心聽講\",\"short\":\"聽講\"},\r\n{\"name\":\"behaviour_3\",\"label\":\"坐立行走姿勢正確\",\"short\":\"姿勢\"},\r\n{\"name\":\"behaviour_4\",\"label\":\"離開座位把物件桌椅整理好\",\"short\":\"桌椅\"},\r\n{\"name\":\"behaviour_5\",\"label\":\"愛護公物用後放回原處\",\"short\":\"公物\"},\r\n{\"name\":\"behaviour_6\",\"label\":\"遵守校規\",\"short\":\"校規\"},\r\n{\"name\":\"social_1\",\"label\":\"守時\",\"short\":\"守時\"},\r\n{\"name\":\"social_2\",\"label\":\"尊敬師長,友愛和睦\",\"short\":\"尊敬\"},\r\n{\"name\":\"social_3\",\"label\":\"樂於助人\",\"short\":\"助人\"},\r\n{\"name\":\"social_4\",\"label\":\"會和別人分享及輪候\",\"short\":\"分享\"},\r\n{\"name\":\"social_5\",\"label\":\"誠實坦白肯認錯\",\"short\":\"誠實\"}\r\n]', NULL, NULL, NULL),
(11, 'behaviour_genres', '[\r\n{\"value\":\"LATE\",\"label\":\"遲到\"},\r\n{\"value\":\"ABSENT\",\"label\":\"缺席\"},\r\n{\"value\":\"DEMERIT\",\"label\":\"缺點\"},\r\n{\"value\":\"FAULT_BIG\",\"label\":\"大過\"},\r\n{\"value\":\"FAULT_SMALL\",\"label\":\"小過\"},\r\n{\"value\":\"CREDIT_BIG\",\"label\":\"大功\"},\r\n{\"value\":\"CREDIT_SMALL\",\"label\":\"小功\"},\r\n{\"value\":\"MERIT\",\"label\":\"優點\"}\r\n]\r\n', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) NOT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `stream` varchar(6) DEFAULT NULL,
  `elective` varchar(6) DEFAULT NULL,
  `score_column` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `study_id` bigint(20) DEFAULT NULL,
  `score_column_template` varchar(255) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `socre_scheme` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `klass_id`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `score_column`, `description`, `study_id`, `score_column_template`, `active`, `socre_scheme`, `created_at`, `updated_at`) VALUES
(1, 1, 'CHN', '中文', 'Chinese', NULL, 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 1, 'ENG', '英文', 'English', NULL, 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, 1, 'MAT', '數學', 'Mathematic', NULL, 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, 1, 'PHY', '物理', 'Physics', NULL, 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, 1, 'GEN', '常識', 'General', NULL, 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, 2, 'CHN', '中文', 'Chinese', NULL, 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, 2, 'ENG', '英文', 'English', NULL, 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, 2, 'MAT', '數學', 'Mathematic', NULL, 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, 2, 'PHY', '物理', 'Physics', NULL, 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, 2, 'GEN', '常識', 'General', NULL, 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, 63, 'CHN', '中文', 'Chinese', '', 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(12, 63, 'ENG', '英文', 'English', '', 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(13, 63, 'MAT', '數學', 'Mathematic', '', 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(14, 63, 'PHY', '物理', 'Physics', '', 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(15, 63, 'GEN', '常識', 'General', '', 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-05 17:01:21', '2023-02-05 17:01:21'),
(16, 64, 'CHN', '中文', 'Chinese', '', 'ART', '0', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(17, 64, 'ENG', '英文', 'English', '', 'ART', '0', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(18, 64, 'MAT', '數學', 'Mathematic', '', 'SCI', '0', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(19, 64, 'PHY', '物理', 'Physics', '', 'SCI', '1', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(20, 64, 'GEN', '常識', 'General', '', 'ART', '1', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(21, 65, 'REL', '宗教', 'Relegion', 'SUB', 'AAS', 'COP', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(22, 65, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, NULL, 2, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(23, 65, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, NULL, 3, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(24, 65, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, NULL, 4, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(25, 65, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, NULL, 5, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(26, 65, 'ELT', '英文', 'English Literature', 'SUB', 'LIB', 'COP', NULL, NULL, 6, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(27, 65, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, NULL, 7, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(28, 65, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, NULL, 8, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(29, 65, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, NULL, 9, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(30, 65, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, NULL, 10, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(31, 65, 'PLA', '唱遊', 'Playgroup', 'SUB', 'LIB', 'COP', NULL, NULL, 11, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(32, 65, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, NULL, 12, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(33, 65, 'health_1', '衣服鞋襪整齊清潔', NULL, 'ATT', NULL, NULL, NULL, NULL, 13, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(34, 65, 'health_2', '常剪指甲', NULL, 'ATT', NULL, NULL, NULL, NULL, 14, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(35, 65, 'health_3', '懂得使用手帕或紙巾', NULL, 'ATT', NULL, NULL, NULL, NULL, 15, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(36, 65, 'health_4', '不把手指雜物放進口裡', NULL, 'ATT', NULL, NULL, NULL, NULL, 16, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(37, 65, 'health_5', '能把癈物投入廢紙箱內', NULL, 'ATT', NULL, NULL, NULL, NULL, 17, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(38, 65, 'behaviour_1', '守秩序不喧嚷', NULL, 'ATT', NULL, NULL, NULL, NULL, 18, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(39, 65, 'behaviour_2', '留心聽講', NULL, 'ATT', NULL, NULL, NULL, NULL, 19, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(40, 65, 'behaviour_3', '坐立行走姿勢正確', NULL, 'ATT', NULL, NULL, NULL, NULL, 20, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(41, 65, 'behaviour_4', '離開坐位把物件桌椅整理好', NULL, 'ATT', NULL, NULL, NULL, NULL, 21, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(42, 65, 'behaviour_5', '愛護公物用後放回原處', NULL, 'ATT', NULL, NULL, NULL, NULL, 22, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(43, 65, 'behaviour_6', '遵守校規', NULL, 'ATT', NULL, NULL, NULL, NULL, 23, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(44, 65, 'social_1', '守時', NULL, 'ATT', NULL, NULL, NULL, NULL, 24, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(45, 65, 'social_2', '尊敬師長,友愛和睦', NULL, 'ATT', NULL, NULL, NULL, NULL, 25, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(46, 65, 'social_3', '樂於助人', NULL, 'ATT', NULL, NULL, NULL, NULL, 26, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(47, 65, 'social_4', '會和別人分享及輪侯', NULL, 'ATT', NULL, NULL, NULL, NULL, 27, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(48, 65, 'social_5', '誠實坦白肯認錯', NULL, 'ATT', NULL, NULL, NULL, NULL, 28, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(49, 65, 'total_score', '總分', NULL, 'SUM', NULL, NULL, NULL, NULL, 29, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(50, 65, 'average_score', '平均分', NULL, 'SUM', NULL, NULL, NULL, NULL, 30, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(51, 65, 'class_size', '全班人數', NULL, 'SUM', NULL, NULL, NULL, NULL, 31, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(52, 65, 'ranking', '考列名次', NULL, 'SUM', NULL, NULL, NULL, NULL, 32, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(53, 65, 'late', '遲到次數', NULL, 'SUM', NULL, NULL, NULL, NULL, 33, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(54, 65, 'absent', '缺席節數', NULL, 'SUM', NULL, NULL, NULL, NULL, 34, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(55, 65, 'comment', '評語', NULL, 'SUM', NULL, NULL, NULL, NULL, 35, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(56, 65, 'reward_punishment', '奬懲記錄', NULL, 'GEN', NULL, NULL, NULL, NULL, 36, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(57, 65, 'leisure_name', '餘暇活動名稱', NULL, 'GEN', NULL, NULL, NULL, NULL, 37, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(58, 65, 'leisure_performance', '餘暇活動表現', NULL, 'GEN', NULL, NULL, NULL, NULL, 38, 'TERMS', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(59, 65, 'remark', '備註', NULL, 'GEN', NULL, NULL, NULL, NULL, 39, 'COMMENT', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(60, 65, 'appraisal', '學年評定', NULL, 'GEN', NULL, NULL, NULL, NULL, 40, 'COMMENT', 1, NULL, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(341, 74, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(342, 74, 'PHY', '體能', 'Physic', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(343, 74, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(344, 74, 'STY', '故事', 'Stry', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(345, 74, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(346, 74, 'ELT', '英文', 'English Literature', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(347, 74, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(348, 74, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(349, 74, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(350, 74, 'COM', '電腦', 'Computer', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(351, 74, 'PLA', '唱遊', 'Playgroup', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(352, 74, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(353, 74, 'health_1', '衣服鞋襪整齊清潔', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(354, 74, 'health_2', '常剪指甲', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(355, 74, 'health_3', '懂得使用手帕或紙巾', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(356, 74, 'health_4', '不把手指雜物放進口裡', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(357, 74, 'health_5', '能把癈物投入廢紙箱內', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(358, 74, 'behaviour_1', '守秩序不喧嚷', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(359, 74, 'behaviour_2', '留心聽講', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(360, 74, 'behaviour_3', '坐立行走姿勢正確', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(361, 74, 'behaviour_4', '離開坐位把物件桌椅整理好', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(362, 74, 'behaviour_5', '愛護公物用後放回原處', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(363, 74, 'behaviour_6', '遵守校規', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(364, 74, 'social_1', '守時', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(365, 74, 'social_2', '尊敬師長,友愛和睦', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(366, 74, 'social_3', '樂於助人', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(367, 74, 'social_4', '會和別人分享及輪侯', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(368, 74, 'social_5', '誠實坦白肯認錯', NULL, 'ATT', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(369, 74, 'total_score', '總分', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(370, 74, 'average_score', '平均分', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(371, 74, 'class_size', '全班人數', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(372, 74, 'ranking', '考列名次', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(373, 74, 'late', '遲到次數', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(374, 74, 'absent', '缺席節數', NULL, 'SUM', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(375, 74, 'comment', '評語', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(376, 74, 'reward_punishment', '奬懲記錄', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(377, 74, 'leisure_name', '餘暇活動名稱', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(378, 74, 'leisure_performance', '餘暇活動表現', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'TERMS', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(379, 74, 'remark', '備註', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'COMMENT', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(380, 74, 'appraisal', '學年評定', NULL, 'GEN', 'LIB', '1', NULL, NULL, 1, 'COMMENT', 1, NULL, '2023-02-07 19:01:07', '2023-02-07 19:01:07');

-- --------------------------------------------------------

--
-- Table structure for table `course_scores`
--

CREATE TABLE `course_scores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_label` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `for_transcript` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course_scores`
--

INSERT INTO `course_scores` (`id`, `term_id`, `course_id`, `sequence`, `field_name`, `field_label`, `type`, `scheme`, `description`, `for_transcript`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 2, 1, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, 1, 2, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, 2, 2, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, 1, 3, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, 2, 3, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, 1, 4, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, 2, 4, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, 1, 5, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, 2, 5, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, 1, 6, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(12, 2, 6, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(13, 1, 7, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(14, 2, 7, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(15, 1, 8, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(16, 2, 8, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(17, 1, 9, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(18, 2, 9, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(19, 1, 10, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(20, 2, 10, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(21, 1, 1, 1, '', 'Test1', NULL, NULL, NULL, 0, NULL, NULL),
(22, 1, 1, 2, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(23, 2, 1, 3, '', 'Test2', NULL, NULL, NULL, 0, NULL, NULL),
(24, 2, 1, 4, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(255, 1, 341, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(256, 2, 341, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(257, 1, 342, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(258, 2, 342, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(259, 1, 343, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(260, 2, 343, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(261, 1, 344, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(262, 2, 344, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(263, 1, 345, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(264, 2, 345, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(265, 1, 346, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(266, 2, 346, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(267, 1, 347, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(268, 2, 347, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(269, 1, 348, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(270, 2, 348, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(271, 1, 349, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(272, 2, 349, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(273, 1, 350, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(274, 2, 350, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(275, 1, 351, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(276, 2, 351, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(277, 1, 352, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(278, 2, 352, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(279, 1, 353, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(280, 2, 353, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(281, 1, 354, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(282, 2, 354, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(283, 1, 355, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(284, 2, 355, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(285, 1, 356, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(286, 2, 356, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(287, 1, 357, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(288, 2, 357, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(289, 1, 358, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(290, 2, 358, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(291, 1, 359, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(292, 2, 359, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(293, 1, 360, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(294, 2, 360, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(295, 1, 361, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(296, 2, 361, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(297, 1, 362, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(298, 2, 362, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(299, 1, 363, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(300, 2, 363, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(301, 1, 364, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(302, 2, 364, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(303, 1, 365, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(304, 2, 365, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(305, 1, 366, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(306, 2, 366, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(307, 1, 367, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(308, 2, 367, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(309, 1, 368, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(310, 2, 368, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(311, 1, 369, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(312, 2, 369, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(313, 1, 370, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(314, 2, 370, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(315, 1, 371, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(316, 2, 371, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(317, 1, 372, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(318, 2, 372, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(319, 1, 373, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(320, 2, 373, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(321, 1, 374, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(322, 2, 374, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(323, 1, 375, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(324, 2, 375, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(325, 1, 376, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(326, 2, 376, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(327, 1, 377, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(328, 2, 377, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(329, 1, 378, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(330, 2, 378, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(331, 1, 379, NULL, 'comment', '描述', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(332, 1, 380, NULL, 'comment', '描述', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08');

-- --------------------------------------------------------

--
-- Table structure for table `course_teachers`
--

CREATE TABLE `course_teachers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) NOT NULL,
  `is_head` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `disciplines`
--

CREATE TABLE `disciplines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gardians`
--

CREATE TABLE `gardians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_fn` varchar(255) NOT NULL,
  `gender` char(1) NOT NULL,
  `dob` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `year_id` bigint(20) NOT NULL,
  `rank` int(11) NOT NULL,
  `initial` char(2) NOT NULL,
  `level` int(11) NOT NULL,
  `tag` varchar(5) DEFAULT NULL,
  `byname` varchar(5) DEFAULT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `klass_num` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`id`, `year_id`, `rank`, `initial`, `level`, `tag`, `byname`, `title_zh`, `title_en`, `klass_num`, `description`, `version`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'P', 1, 'P1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(2, 1, 2, 'P', 2, 'P2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(3, 1, 3, 'P', 3, 'P3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(4, 1, 4, 'P', 4, 'P4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(5, 1, 5, 'P', 5, 'P5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(6, 1, 6, 'P', 6, 'P6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(7, 1, 7, 'S', 1, 'S1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(8, 1, 8, 'S', 2, 'S2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(9, 1, 9, 'S', 3, 'S3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(10, 1, 10, 'S', 4, 'S4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(11, 1, 11, 'S', 5, 'S5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(12, 1, 12, 'S', 6, 'S6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(13, 2, 1, 'P', 1, 'P1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(14, 2, 2, 'P', 2, 'P2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(15, 2, 3, 'P', 3, 'P3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(16, 2, 4, 'P', 4, 'P4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(17, 2, 5, 'P', 5, 'P5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(18, 2, 6, 'P', 6, 'P6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(19, 2, 7, 'S', 1, 'S1', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(20, 2, 8, 'S', 2, 'S2', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(21, 2, 9, 'S', 3, 'S3', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(22, 2, 10, 'S', 4, 'S4', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(23, 2, 11, 'S', 5, 'S5', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL),
(24, 2, 12, 'S', 6, 'S6', NULL, NULL, NULL, 0, NULL, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `guardians`
--

CREATE TABLE `guardians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `relation` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `organization_phone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `stay_together` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `road` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `post_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `habits`
--

CREATE TABLE `habits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `health_1` char(1) DEFAULT NULL,
  `health_2` char(1) DEFAULT NULL,
  `health_3` char(1) DEFAULT NULL,
  `health_4` char(1) DEFAULT NULL,
  `health_5` char(1) DEFAULT NULL,
  `behaviour_1` char(1) DEFAULT NULL,
  `behaviour_2` char(1) DEFAULT NULL,
  `behaviour_3` char(1) DEFAULT NULL,
  `behaviour_4` char(1) DEFAULT NULL,
  `behaviour_5` char(1) DEFAULT NULL,
  `behaviour_6` char(1) DEFAULT NULL,
  `social_1` char(1) DEFAULT NULL,
  `social_2` char(1) DEFAULT NULL,
  `social_3` char(1) DEFAULT NULL,
  `social_4` char(1) DEFAULT NULL,
  `social_5` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `habits`
--

INSERT INTO `habits` (`id`, `klass_student_id`, `term_id`, `health_1`, `health_2`, `health_3`, `health_4`, `health_5`, `behaviour_1`, `behaviour_2`, `behaviour_3`, `behaviour_4`, `behaviour_5`, `behaviour_6`, `social_1`, `social_2`, `social_3`, `social_4`, `social_5`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '1', '1', '2', '4', '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(2, 22, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:17:34'),
(3, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(4, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(5, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:17:34', '2023-02-09 01:52:59'),
(6, 2, 1, NULL, NULL, '4', '5', '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-09 01:44:37', '2023-02-09 01:52:59');

-- --------------------------------------------------------

--
-- Table structure for table `healthcares`
--

CREATE TABLE `healthcares` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `hospital` varchar(255) NOT NULL,
  `health_state` varchar(255) NOT NULL,
  `vaccinated` date NOT NULL,
  `last_vaccine` int(11) NOT NULL,
  `vaccine count` varchar(255) NOT NULL,
  `covid_19` int(11) NOT NULL,
  `illness` varchar(255) NOT NULL,
  `trauma` varchar(255) NOT NULL,
  `trauma_treatment` varchar(255) NOT NULL,
  `food_allergy` varchar(255) NOT NULL,
  `medicine_allergy` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `identity_documents`
--

CREATE TABLE `identity_documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `identity_documentable_id` bigint(20) NOT NULL,
  `identity_documentable_type` varchar(255) NOT NULL,
  `residentship` varchar(255) DEFAULT NULL,
  `issue_place` varchar(255) DEFAULT NULL,
  `issue_date` varchar(255) DEFAULT NULL,
  `expiry_date` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `home_return` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `klasses`
--

CREATE TABLE `klasses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grade_id` bigint(20) NOT NULL,
  `letter` char(5) DEFAULT NULL,
  `tag` char(5) DEFAULT NULL,
  `byname` varchar(255) DEFAULT NULL,
  `stream` varchar(5) NOT NULL,
  `room` varchar(255) DEFAULT NULL,
  `study_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `klasses`
--

INSERT INTO `klasses` (`id`, `grade_id`, `letter`, `tag`, `byname`, `stream`, `room`, `study_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'A', 'P1A', NULL, 'AAS', NULL, 1, NULL, '2023-02-05 22:48:04'),
(2, 1, 'B', 'P1B', NULL, 'SCI', NULL, 1, NULL, '2023-02-05 22:48:37'),
(3, 1, 'C', 'P1C', NULL, '', NULL, 1, NULL, NULL),
(4, 1, 'D', 'P1D', NULL, '', NULL, 1, NULL, NULL),
(5, 1, 'E', 'P1E', NULL, '', NULL, 1, NULL, NULL),
(6, 2, 'A', 'P2A', NULL, '', NULL, 1, NULL, NULL),
(7, 2, 'B', 'P2B', NULL, '', NULL, 1, NULL, NULL),
(8, 2, 'C', 'P2C', NULL, '', NULL, 1, NULL, NULL),
(9, 2, 'D', 'P2D', NULL, '', NULL, 1, NULL, NULL),
(10, 2, 'E', 'P2E', NULL, '', NULL, 1, NULL, NULL),
(11, 3, 'A', 'P3A', NULL, '', NULL, 1, NULL, NULL),
(12, 3, 'B', 'P3B', NULL, '', NULL, 1, NULL, NULL),
(13, 3, 'C', 'P3C', NULL, '', NULL, 1, NULL, NULL),
(14, 3, 'D', 'P3D', NULL, '', NULL, 1, NULL, NULL),
(15, 3, 'E', 'P3E', NULL, '', NULL, 1, NULL, NULL),
(16, 4, 'A', 'P4A', NULL, '', NULL, 1, NULL, NULL),
(17, 4, 'B', 'P4B', NULL, '', NULL, 1, NULL, NULL),
(18, 4, 'C', 'P4C', NULL, '', NULL, 1, NULL, NULL),
(19, 4, 'D', 'P4D', NULL, '', NULL, 1, NULL, NULL),
(20, 4, 'E', 'P4E', NULL, '', NULL, 1, NULL, NULL),
(21, 5, 'A', 'P5A', NULL, '', NULL, 1, NULL, NULL),
(22, 5, 'B', 'P5B', NULL, '', NULL, 1, NULL, NULL),
(23, 5, 'C', 'P5C', NULL, '', NULL, 1, NULL, NULL),
(24, 5, 'D', 'P5D', NULL, '', NULL, 1, NULL, NULL),
(25, 5, 'E', 'P5E', NULL, '', NULL, 1, NULL, NULL),
(26, 6, 'A', 'P6A', NULL, '', NULL, 1, NULL, NULL),
(27, 6, 'B', 'P6B', NULL, '', NULL, 1, NULL, NULL),
(28, 6, 'C', 'P6C', NULL, '', NULL, 1, NULL, NULL),
(29, 6, 'D', 'P6D', NULL, '', NULL, 1, NULL, NULL),
(30, 6, 'E', 'P6E', NULL, '', NULL, 1, NULL, NULL),
(31, 7, 'A', 'S1A', NULL, '', NULL, 2, NULL, NULL),
(32, 7, 'B', 'S1B', NULL, '', NULL, 2, NULL, NULL),
(33, 7, 'C', 'S1C', NULL, '', NULL, 2, NULL, NULL),
(34, 7, 'D', 'S1D', NULL, '', NULL, 2, NULL, NULL),
(35, 7, 'E', 'S1E', NULL, '', NULL, 2, NULL, NULL),
(36, 8, 'A', 'S2A', NULL, '', NULL, 2, NULL, NULL),
(37, 8, 'B', 'S2B', NULL, '', NULL, 2, NULL, NULL),
(38, 8, 'C', 'S2C', NULL, '', NULL, 2, NULL, NULL),
(39, 8, 'D', 'S2D', NULL, '', NULL, 2, NULL, NULL),
(40, 8, 'E', 'S2E', NULL, '', NULL, 2, NULL, NULL),
(41, 9, 'A', 'S3A', NULL, '', NULL, 2, NULL, NULL),
(42, 9, 'B', 'S3B', NULL, '', NULL, 2, NULL, NULL),
(43, 9, 'C', 'S3C', NULL, '', NULL, 2, NULL, NULL),
(44, 9, 'D', 'S3D', NULL, '', NULL, 2, NULL, NULL),
(45, 9, 'E', 'S3E', NULL, '', NULL, 2, NULL, NULL),
(46, 10, 'A', 'S4A', NULL, '', NULL, 2, NULL, NULL),
(47, 10, 'B', 'S4B', NULL, '', NULL, 2, NULL, NULL),
(48, 10, 'C', 'S4C', NULL, '', NULL, 2, NULL, NULL),
(49, 10, 'D', 'S4D', NULL, '', NULL, 2, NULL, NULL),
(50, 10, 'E', 'S4E', NULL, '', NULL, 2, NULL, NULL),
(51, 11, 'A', 'S5A', NULL, '', NULL, 2, NULL, NULL),
(52, 11, 'B', 'S5B', NULL, '', NULL, 2, NULL, NULL),
(53, 11, 'C', 'S5C', NULL, '', NULL, 2, NULL, NULL),
(54, 11, 'D', 'S5D', NULL, '', NULL, 2, NULL, NULL),
(55, 11, 'E', 'S5E', NULL, '', NULL, 2, NULL, NULL),
(56, 12, 'A', 'S6A', NULL, 'AAS', NULL, 2, NULL, '2023-02-06 20:05:19'),
(57, 12, 'B', 'S6B', NULL, 'AAS', NULL, 2, NULL, '2023-02-06 20:04:06'),
(58, 12, 'C', 'S6C', NULL, '', NULL, 2, NULL, NULL),
(59, 12, 'D', 'S6D', NULL, '', NULL, 2, NULL, NULL),
(60, 12, 'E', 'S6E', NULL, '', NULL, 2, NULL, NULL),
(64, 1, 'F', 'P1F', NULL, '', '123', 2, '2023-02-05 17:03:12', '2023-02-05 17:03:12'),
(65, 2, 'F', 'P2F', NULL, 'AAS', NULL, 1, '2023-02-06 20:51:45', '2023-02-06 20:51:45'),
(74, 3, 'F', 'P3F', NULL, 'ALL', NULL, 1, '2023-02-07 19:01:07', '2023-02-07 19:01:07');

-- --------------------------------------------------------

--
-- Table structure for table `klass_student`
--

CREATE TABLE `klass_student` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `student_number` int(11) NOT NULL DEFAULT 0,
  `state` char(3) NOT NULL DEFAULT 'ACT',
  `stream` char(3) NOT NULL DEFAULT 'ART',
  `promote` bigint(20) NOT NULL DEFAULT 0,
  `promote_to` bigint(20) NOT NULL DEFAULT 0,
  `score_scheme` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `klass_student`
--

INSERT INTO `klass_student` (`id`, `klass_id`, `student_id`, `student_number`, `state`, `stream`, `promote`, `promote_to`, `score_scheme`, `created_at`, `updated_at`) VALUES
(1, 74, 1, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(2, 74, 2, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(3, 74, 3, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(4, 74, 4, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(5, 74, 5, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(6, 1, 6, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(7, 1, 7, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(8, 1, 8, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(9, 1, 9, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(10, 1, 10, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(11, 1, 11, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(12, 1, 12, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(13, 1, 13, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(14, 1, 14, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(15, 1, 15, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(16, 1, 16, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(17, 1, 17, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(18, 1, 18, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(19, 1, 19, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(20, 1, 20, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(21, 1, 21, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(22, 2, 22, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(23, 2, 23, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(24, 2, 24, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(25, 2, 25, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(26, 2, 26, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(27, 2, 27, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(28, 2, 28, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(29, 2, 29, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(30, 2, 30, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(31, 2, 31, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(32, 2, 32, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(33, 2, 33, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(34, 2, 34, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(35, 2, 35, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(36, 2, 36, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(37, 2, 37, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(38, 2, 38, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(39, 2, 39, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(40, 2, 40, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(41, 2, 41, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(42, 2, 42, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(43, 3, 43, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(44, 3, 44, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(45, 3, 45, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(46, 3, 46, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(47, 3, 47, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(48, 3, 48, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(49, 3, 49, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(50, 3, 50, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(51, 3, 51, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(52, 3, 52, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(53, 3, 53, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(54, 3, 54, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(55, 3, 55, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(56, 3, 56, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(57, 3, 57, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(58, 3, 58, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(59, 3, 59, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(60, 3, 60, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(61, 3, 61, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(62, 3, 62, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(63, 3, 63, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(64, 4, 64, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(65, 4, 65, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(66, 4, 66, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(67, 4, 67, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(68, 4, 68, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(69, 4, 69, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(70, 4, 70, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(71, 4, 71, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(72, 4, 72, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(73, 4, 73, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(74, 4, 74, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(75, 4, 75, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(76, 4, 76, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(77, 4, 77, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(78, 4, 78, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(79, 4, 79, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(80, 4, 80, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(81, 4, 81, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(82, 4, 82, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(83, 4, 83, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(84, 4, 84, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(85, 5, 85, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(86, 5, 86, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(87, 5, 87, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(88, 5, 88, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(89, 5, 89, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(90, 5, 90, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(91, 5, 91, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(92, 5, 92, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(93, 5, 93, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(94, 5, 94, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(95, 5, 95, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(96, 5, 96, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(97, 5, 97, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(98, 5, 98, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(99, 5, 99, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(100, 5, 100, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(101, 5, 101, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(102, 5, 102, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(103, 5, 103, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(104, 5, 104, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(105, 5, 105, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(106, 6, 106, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(107, 6, 107, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(108, 6, 108, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(109, 6, 109, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(110, 6, 110, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(111, 6, 111, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(112, 6, 112, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(113, 6, 113, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(114, 6, 114, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(115, 6, 115, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(116, 6, 116, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(117, 6, 117, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(118, 6, 118, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(119, 6, 119, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(120, 6, 120, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(121, 6, 121, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(122, 6, 122, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(123, 6, 123, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(124, 6, 124, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(125, 6, 125, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(126, 6, 126, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(127, 7, 127, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(128, 7, 128, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(129, 7, 129, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(130, 7, 130, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(131, 7, 131, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(132, 7, 132, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(133, 7, 133, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(134, 7, 134, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(135, 7, 135, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(136, 7, 136, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(137, 7, 137, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(138, 7, 138, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(139, 7, 139, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(140, 7, 140, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(141, 7, 141, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(142, 7, 142, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(143, 7, 143, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(144, 7, 144, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(145, 7, 145, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(146, 7, 146, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(147, 7, 147, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(148, 8, 148, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(149, 8, 149, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(150, 8, 150, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(151, 8, 151, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(152, 8, 152, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(153, 8, 153, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(154, 8, 154, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(155, 8, 155, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(156, 8, 156, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(157, 8, 157, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(158, 8, 158, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(159, 8, 159, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(160, 8, 160, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(161, 8, 161, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(162, 8, 162, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(163, 8, 163, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(164, 8, 164, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(165, 8, 165, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(166, 8, 166, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(167, 8, 167, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(168, 8, 168, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(169, 9, 169, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(170, 9, 170, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(171, 9, 171, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(172, 9, 172, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(173, 9, 173, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(174, 9, 174, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(175, 9, 175, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(176, 9, 176, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(177, 9, 177, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(178, 9, 178, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(179, 9, 179, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(180, 9, 180, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(181, 9, 181, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(182, 9, 182, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(183, 9, 183, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(184, 9, 184, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(185, 9, 185, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(186, 9, 186, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(187, 9, 187, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(188, 9, 188, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(189, 9, 189, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(190, 10, 190, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(191, 10, 191, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(192, 10, 192, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(193, 10, 193, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(194, 10, 194, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(195, 10, 195, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(196, 10, 196, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(197, 10, 197, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(198, 10, 198, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(199, 10, 199, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(200, 10, 200, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(201, 10, 201, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(202, 10, 202, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(203, 10, 203, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(204, 10, 204, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(205, 10, 205, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(206, 10, 206, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(207, 10, 207, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(208, 10, 208, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(209, 10, 209, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(210, 10, 210, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(211, 11, 211, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(212, 11, 212, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(213, 11, 213, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(214, 11, 214, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(215, 11, 215, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(216, 11, 216, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(217, 11, 217, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(218, 11, 218, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(219, 11, 219, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(220, 11, 220, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(221, 11, 221, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(222, 11, 222, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(223, 11, 223, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(224, 11, 224, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(225, 11, 225, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(226, 11, 226, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(227, 11, 227, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(228, 11, 228, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(229, 11, 229, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(230, 11, 230, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(231, 11, 231, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(232, 12, 232, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(233, 12, 233, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(234, 12, 234, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(235, 12, 235, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(236, 12, 236, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(237, 12, 237, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(238, 12, 238, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(239, 12, 239, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(240, 12, 240, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(241, 12, 241, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(242, 12, 242, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(243, 12, 243, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(244, 12, 244, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(245, 12, 245, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(246, 12, 246, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(247, 12, 247, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(248, 12, 248, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(249, 12, 249, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(250, 12, 250, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(251, 12, 251, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(252, 12, 252, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(253, 13, 253, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(254, 13, 254, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(255, 13, 255, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(256, 13, 256, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(257, 13, 257, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(258, 13, 258, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(259, 13, 259, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(260, 13, 260, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(261, 13, 261, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(262, 13, 262, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(263, 13, 263, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(264, 13, 264, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(265, 13, 265, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(266, 13, 266, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(267, 13, 267, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(268, 13, 268, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(269, 13, 269, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(270, 13, 270, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(271, 13, 271, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(272, 13, 272, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(273, 13, 273, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(274, 14, 274, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(275, 14, 275, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(276, 14, 276, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(277, 14, 277, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(278, 14, 278, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(279, 14, 279, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(280, 14, 280, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(281, 14, 281, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(282, 14, 282, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(283, 14, 283, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(284, 14, 284, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(285, 14, 285, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(286, 14, 286, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(287, 14, 287, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(288, 14, 288, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(289, 14, 289, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(290, 14, 290, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(291, 14, 291, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(292, 14, 292, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(293, 14, 293, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(294, 14, 294, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(295, 15, 295, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(296, 15, 296, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(297, 15, 297, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(298, 15, 298, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(299, 15, 299, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(300, 15, 300, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(301, 15, 301, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(302, 15, 302, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(303, 15, 303, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(304, 15, 304, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(305, 15, 305, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(306, 15, 306, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(307, 15, 307, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(308, 15, 308, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(309, 15, 309, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(310, 15, 310, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(311, 15, 311, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(312, 15, 312, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(313, 15, 313, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(314, 15, 314, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(315, 15, 315, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(316, 16, 316, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(317, 16, 317, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(318, 16, 318, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(319, 16, 319, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(320, 16, 320, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(321, 16, 321, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(322, 16, 322, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(323, 16, 323, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(324, 16, 324, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(325, 16, 325, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(326, 16, 326, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(327, 16, 327, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(328, 16, 328, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(329, 16, 329, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(330, 16, 330, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(331, 16, 331, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(332, 16, 332, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(333, 16, 333, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(334, 16, 334, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(335, 16, 335, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(336, 16, 336, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(337, 17, 337, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(338, 17, 338, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(339, 17, 339, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(340, 17, 340, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(341, 17, 341, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(342, 17, 342, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(343, 17, 343, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(344, 17, 344, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(345, 17, 345, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(346, 17, 346, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(347, 17, 347, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(348, 17, 348, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(349, 17, 349, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(350, 17, 350, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(351, 17, 351, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(352, 17, 352, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(353, 17, 353, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(354, 17, 354, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(355, 17, 355, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(356, 17, 356, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(357, 17, 357, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(358, 18, 358, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(359, 18, 359, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(360, 18, 360, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(361, 18, 361, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(362, 18, 362, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(363, 18, 363, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(364, 18, 364, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(365, 18, 365, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(366, 18, 366, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(367, 18, 367, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(368, 18, 368, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(369, 18, 369, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(370, 18, 370, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(371, 18, 371, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(372, 18, 372, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(373, 18, 373, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(374, 18, 374, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(375, 18, 375, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(376, 18, 376, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(377, 18, 377, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(378, 18, 378, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(379, 19, 379, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(380, 19, 380, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(381, 19, 381, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(382, 19, 382, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(383, 19, 383, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(384, 19, 384, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(385, 19, 385, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(386, 19, 386, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(387, 19, 387, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(388, 19, 388, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(389, 19, 389, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(390, 19, 390, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(391, 19, 391, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(392, 19, 392, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(393, 19, 393, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(394, 19, 394, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(395, 19, 395, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(396, 19, 396, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(397, 19, 397, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(398, 19, 398, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(399, 19, 399, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(400, 20, 400, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(401, 20, 401, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(402, 20, 402, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(403, 20, 403, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(404, 20, 404, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(405, 20, 405, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(406, 20, 406, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(407, 20, 407, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(408, 20, 408, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(409, 20, 409, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(410, 20, 410, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(411, 20, 411, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(412, 20, 412, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(413, 20, 413, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(414, 20, 414, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(415, 20, 415, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(416, 20, 416, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(417, 20, 417, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(418, 20, 418, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(419, 20, 419, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(420, 20, 420, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(421, 21, 421, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(422, 21, 422, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(423, 21, 423, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(424, 21, 424, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(425, 21, 425, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(426, 21, 426, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(427, 21, 427, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(428, 21, 428, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(429, 21, 429, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(430, 21, 430, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(431, 21, 431, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(432, 21, 432, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(433, 21, 433, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(434, 21, 434, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(435, 21, 435, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(436, 21, 436, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(437, 21, 437, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(438, 21, 438, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(439, 21, 439, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(440, 21, 440, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(441, 21, 441, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(442, 22, 442, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(443, 22, 443, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(444, 22, 444, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(445, 22, 445, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(446, 22, 446, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(447, 22, 447, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(448, 22, 448, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(449, 22, 449, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(450, 22, 450, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(451, 22, 451, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(452, 22, 452, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(453, 22, 453, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(454, 22, 454, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(455, 22, 455, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(456, 22, 456, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(457, 22, 457, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(458, 22, 458, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(459, 22, 459, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(460, 22, 460, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(461, 22, 461, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(462, 22, 462, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(463, 23, 463, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(464, 23, 464, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(465, 23, 465, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(466, 23, 466, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(467, 23, 467, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(468, 23, 468, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(469, 23, 469, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(470, 23, 470, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(471, 23, 471, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(472, 23, 472, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(473, 23, 473, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(474, 23, 474, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(475, 23, 475, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(476, 23, 476, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(477, 23, 477, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(478, 23, 478, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(479, 23, 479, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(480, 23, 480, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(481, 23, 481, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(482, 23, 482, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(483, 23, 483, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(484, 24, 484, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(485, 24, 485, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(486, 24, 486, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(487, 24, 487, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(488, 24, 488, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(489, 24, 489, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(490, 24, 490, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(491, 24, 491, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(492, 24, 492, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(493, 24, 493, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(494, 24, 494, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(495, 24, 495, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(496, 24, 496, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(497, 24, 497, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(498, 24, 498, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(499, 24, 499, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(500, 24, 500, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(501, 24, 501, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(502, 24, 502, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(503, 24, 503, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(504, 24, 504, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(505, 25, 505, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(506, 25, 506, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(507, 25, 507, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(508, 25, 508, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(509, 25, 509, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(510, 25, 510, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(511, 25, 511, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(512, 25, 512, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(513, 25, 513, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(514, 25, 514, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(515, 25, 515, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(516, 25, 516, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(517, 25, 517, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(518, 25, 518, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(519, 25, 519, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(520, 25, 520, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(521, 25, 521, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(522, 25, 522, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(523, 25, 523, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(524, 25, 524, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(525, 25, 525, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(526, 26, 526, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(527, 26, 527, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(528, 26, 528, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(529, 26, 529, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(530, 26, 530, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(531, 26, 531, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(532, 26, 532, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(533, 26, 533, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(534, 26, 534, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(535, 26, 535, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(536, 26, 536, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(537, 26, 537, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(538, 26, 538, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(539, 26, 539, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(540, 26, 540, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(541, 26, 541, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(542, 26, 542, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(543, 26, 543, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(544, 26, 544, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(545, 26, 545, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(546, 26, 546, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(547, 27, 547, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(548, 27, 548, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(549, 27, 549, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(550, 27, 550, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(551, 27, 551, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(552, 27, 552, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(553, 27, 553, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(554, 27, 554, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(555, 27, 555, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(556, 27, 556, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(557, 27, 557, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(558, 27, 558, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(559, 27, 559, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(560, 27, 560, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(561, 27, 561, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(562, 27, 562, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(563, 27, 563, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(564, 27, 564, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(565, 27, 565, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(566, 27, 566, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(567, 27, 567, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(568, 28, 568, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(569, 28, 569, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(570, 28, 570, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(571, 28, 571, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(572, 28, 572, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(573, 28, 573, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(574, 28, 574, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(575, 28, 575, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(576, 28, 576, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(577, 28, 577, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(578, 28, 578, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(579, 28, 579, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(580, 28, 580, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(581, 28, 581, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(582, 28, 582, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(583, 28, 583, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(584, 28, 584, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(585, 28, 585, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(586, 28, 586, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(587, 28, 587, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(588, 28, 588, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(589, 29, 589, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(590, 29, 590, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(591, 29, 591, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(592, 29, 592, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(593, 29, 593, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(594, 29, 594, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(595, 29, 595, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(596, 29, 596, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(597, 29, 597, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(598, 29, 598, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(599, 29, 599, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(600, 29, 600, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(601, 29, 601, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(602, 29, 602, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(603, 29, 603, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(604, 29, 604, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(605, 29, 605, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(606, 29, 606, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(607, 29, 607, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(608, 29, 608, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(609, 29, 609, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(610, 30, 610, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(611, 30, 611, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(612, 30, 612, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(613, 30, 613, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(614, 30, 614, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(615, 30, 615, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(616, 30, 616, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(617, 30, 617, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(618, 30, 618, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(619, 30, 619, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(620, 30, 620, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(621, 30, 621, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(622, 30, 622, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(623, 30, 623, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(624, 30, 624, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(625, 30, 625, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(626, 30, 626, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(627, 30, 627, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(628, 30, 628, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(629, 30, 629, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(630, 30, 630, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(631, 31, 631, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(632, 31, 632, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(633, 31, 633, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(634, 31, 634, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(635, 31, 635, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(636, 31, 636, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(637, 31, 637, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(638, 31, 638, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(639, 31, 639, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(640, 31, 640, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(641, 31, 641, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(642, 31, 642, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(643, 31, 643, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(644, 31, 644, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(645, 31, 645, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(646, 31, 646, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(647, 31, 647, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(648, 31, 648, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(649, 31, 649, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(650, 31, 650, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(651, 31, 651, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(652, 32, 652, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(653, 32, 653, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(654, 32, 654, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(655, 32, 655, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(656, 32, 656, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(657, 32, 657, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(658, 32, 658, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(659, 32, 659, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(660, 32, 660, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(661, 32, 661, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(662, 32, 662, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(663, 32, 663, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(664, 32, 664, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(665, 32, 665, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(666, 32, 666, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(667, 32, 667, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(668, 32, 668, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(669, 32, 669, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(670, 32, 670, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(671, 32, 671, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(672, 32, 672, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(673, 33, 673, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(674, 33, 674, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(675, 33, 675, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(676, 33, 676, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(677, 33, 677, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(678, 33, 678, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(679, 33, 679, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(680, 33, 680, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(681, 33, 681, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(682, 33, 682, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(683, 33, 683, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(684, 33, 684, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(685, 33, 685, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(686, 33, 686, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(687, 33, 687, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(688, 33, 688, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(689, 33, 689, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(690, 33, 690, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(691, 33, 691, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(692, 33, 692, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(693, 33, 693, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(694, 34, 694, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(695, 34, 695, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(696, 34, 696, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(697, 34, 697, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(698, 34, 698, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(699, 34, 699, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(700, 34, 700, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(701, 34, 701, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(702, 34, 702, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(703, 34, 703, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(704, 34, 704, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(705, 34, 705, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(706, 34, 706, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(707, 34, 707, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(708, 34, 708, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(709, 34, 709, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(710, 34, 710, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(711, 34, 711, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(712, 34, 712, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(713, 34, 713, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(714, 34, 714, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(715, 35, 715, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(716, 35, 716, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(717, 35, 717, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(718, 35, 718, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(719, 35, 719, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(720, 35, 720, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(721, 35, 721, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(722, 35, 722, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(723, 35, 723, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(724, 35, 724, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(725, 35, 725, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(726, 35, 726, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(727, 35, 727, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(728, 35, 728, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(729, 35, 729, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(730, 35, 730, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(731, 35, 731, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(732, 35, 732, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(733, 35, 733, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(734, 35, 734, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(735, 35, 735, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(736, 36, 736, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(737, 36, 737, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(738, 36, 738, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(739, 36, 739, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(740, 36, 740, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(741, 36, 741, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(742, 36, 742, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(743, 36, 743, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(744, 36, 744, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(745, 36, 745, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(746, 36, 746, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(747, 36, 747, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(748, 36, 748, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(749, 36, 749, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(750, 36, 750, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(751, 36, 751, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(752, 36, 752, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(753, 36, 753, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(754, 36, 754, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(755, 36, 755, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(756, 36, 756, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(757, 37, 757, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(758, 37, 758, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(759, 37, 759, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(760, 37, 760, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(761, 37, 761, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(762, 37, 762, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(763, 37, 763, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(764, 37, 764, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(765, 37, 765, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(766, 37, 766, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(767, 37, 767, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(768, 37, 768, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(769, 37, 769, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(770, 37, 770, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(771, 37, 771, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(772, 37, 772, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(773, 37, 773, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(774, 37, 774, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(775, 37, 775, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(776, 37, 776, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(777, 37, 777, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(778, 38, 778, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(779, 38, 779, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(780, 38, 780, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(781, 38, 781, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(782, 38, 782, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(783, 38, 783, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(784, 38, 784, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(785, 38, 785, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(786, 38, 786, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(787, 38, 787, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(788, 38, 788, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(789, 38, 789, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(790, 38, 790, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(791, 38, 791, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(792, 38, 792, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(793, 38, 793, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(794, 38, 794, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(795, 38, 795, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(796, 38, 796, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(797, 38, 797, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(798, 38, 798, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(799, 39, 799, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(800, 39, 800, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(801, 39, 801, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(802, 39, 802, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(803, 39, 803, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(804, 39, 804, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(805, 39, 805, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(806, 39, 806, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(807, 39, 807, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(808, 39, 808, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(809, 39, 809, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(810, 39, 810, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(811, 39, 811, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(812, 39, 812, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(813, 39, 813, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(814, 39, 814, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(815, 39, 815, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(816, 39, 816, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(817, 39, 817, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(818, 39, 818, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(819, 39, 819, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(820, 40, 820, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(821, 40, 821, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(822, 40, 822, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(823, 40, 823, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(824, 40, 824, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(825, 40, 825, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(826, 40, 826, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(827, 40, 827, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(828, 40, 828, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(829, 40, 829, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(830, 40, 830, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(831, 40, 831, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(832, 40, 832, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(833, 40, 833, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(834, 40, 834, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(835, 40, 835, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(836, 40, 836, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(837, 40, 837, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(838, 40, 838, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(839, 40, 839, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(840, 40, 840, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(841, 41, 841, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(842, 41, 842, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(843, 41, 843, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(844, 41, 844, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(845, 41, 845, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(846, 41, 846, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(847, 41, 847, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(848, 41, 848, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(849, 41, 849, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(850, 41, 850, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(851, 41, 851, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(852, 41, 852, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(853, 41, 853, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(854, 41, 854, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(855, 41, 855, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(856, 41, 856, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(857, 41, 857, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(858, 41, 858, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(859, 41, 859, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(860, 41, 860, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(861, 41, 861, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(862, 42, 862, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(863, 42, 863, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(864, 42, 864, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(865, 42, 865, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(866, 42, 866, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(867, 42, 867, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(868, 42, 868, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(869, 42, 869, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(870, 42, 870, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(871, 42, 871, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(872, 42, 872, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(873, 42, 873, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(874, 42, 874, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(875, 42, 875, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(876, 42, 876, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(877, 42, 877, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(878, 42, 878, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(879, 42, 879, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(880, 42, 880, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(881, 42, 881, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(882, 42, 882, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(883, 43, 883, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(884, 43, 884, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(885, 43, 885, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(886, 43, 886, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(887, 43, 887, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(888, 43, 888, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(889, 43, 889, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(890, 43, 890, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(891, 43, 891, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(892, 43, 892, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(893, 43, 893, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(894, 43, 894, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(895, 43, 895, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(896, 43, 896, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(897, 43, 897, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(898, 43, 898, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(899, 43, 899, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(900, 43, 900, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(901, 43, 901, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(902, 43, 902, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(903, 43, 903, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL);
INSERT INTO `klass_student` (`id`, `klass_id`, `student_id`, `student_number`, `state`, `stream`, `promote`, `promote_to`, `score_scheme`, `created_at`, `updated_at`) VALUES
(904, 44, 904, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(905, 44, 905, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(906, 44, 906, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(907, 44, 907, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(908, 44, 908, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(909, 44, 909, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(910, 44, 910, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(911, 44, 911, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(912, 44, 912, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(913, 44, 913, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(914, 44, 914, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(915, 44, 915, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(916, 44, 916, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(917, 44, 917, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(918, 44, 918, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(919, 44, 919, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(920, 44, 920, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(921, 44, 921, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(922, 44, 922, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(923, 44, 923, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(924, 44, 924, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(925, 45, 925, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(926, 45, 926, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(927, 45, 927, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(928, 45, 928, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(929, 45, 929, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(930, 45, 930, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(931, 45, 931, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(932, 45, 932, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(933, 45, 933, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(934, 45, 934, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(935, 45, 935, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(936, 45, 936, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(937, 45, 937, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(938, 45, 938, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(939, 45, 939, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(940, 45, 940, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(941, 45, 941, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(942, 45, 942, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(943, 45, 943, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(944, 45, 944, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(945, 45, 945, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(946, 46, 946, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(947, 46, 947, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(948, 46, 948, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(949, 46, 949, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(950, 46, 950, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(951, 46, 951, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(952, 46, 952, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(953, 46, 953, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(954, 46, 954, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(955, 46, 955, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(956, 46, 956, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(957, 46, 957, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(958, 46, 958, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(959, 46, 959, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(960, 46, 960, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(961, 46, 961, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(962, 46, 962, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(963, 46, 963, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(964, 46, 964, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(965, 46, 965, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(966, 46, 966, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(967, 47, 967, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(968, 47, 968, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(969, 47, 969, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(970, 47, 970, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(971, 47, 971, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(972, 47, 972, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(973, 47, 973, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(974, 47, 974, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(975, 47, 975, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(976, 47, 976, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(977, 47, 977, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(978, 47, 978, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(979, 47, 979, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(980, 47, 980, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(981, 47, 981, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(982, 47, 982, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(983, 47, 983, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(984, 47, 984, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(985, 47, 985, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(986, 47, 986, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(987, 47, 987, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(988, 48, 988, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(989, 48, 989, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(990, 48, 990, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(991, 48, 991, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(992, 48, 992, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(993, 48, 993, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(994, 48, 994, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(995, 48, 995, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(996, 48, 996, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(997, 48, 997, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(998, 48, 998, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(999, 48, 999, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1000, 48, 1000, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1001, 48, 1001, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1002, 48, 1002, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1003, 48, 1003, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1004, 48, 1004, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1005, 48, 1005, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1006, 48, 1006, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1007, 48, 1007, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1008, 48, 1008, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1009, 49, 1009, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1010, 49, 1010, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1011, 49, 1011, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1012, 49, 1012, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1013, 49, 1013, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1014, 49, 1014, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1015, 49, 1015, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1016, 49, 1016, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1017, 49, 1017, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1018, 49, 1018, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1019, 49, 1019, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1020, 49, 1020, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1021, 49, 1021, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1022, 49, 1022, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1023, 49, 1023, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1024, 49, 1024, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1025, 49, 1025, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1026, 49, 1026, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1027, 49, 1027, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1028, 49, 1028, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1029, 49, 1029, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1030, 50, 1030, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1031, 50, 1031, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1032, 50, 1032, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1033, 50, 1033, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1034, 50, 1034, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1035, 50, 1035, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1036, 50, 1036, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1037, 50, 1037, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1038, 50, 1038, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1039, 50, 1039, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1040, 50, 1040, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1041, 50, 1041, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1042, 50, 1042, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1043, 50, 1043, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1044, 50, 1044, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1045, 50, 1045, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1046, 50, 1046, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1047, 50, 1047, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1048, 50, 1048, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1049, 50, 1049, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1050, 50, 1050, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1051, 51, 1051, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1052, 51, 1052, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1053, 51, 1053, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1054, 51, 1054, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1055, 51, 1055, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1056, 51, 1056, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1057, 51, 1057, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1058, 51, 1058, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1059, 51, 1059, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1060, 51, 1060, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1061, 51, 1061, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1062, 51, 1062, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1063, 51, 1063, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1064, 51, 1064, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1065, 51, 1065, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1066, 51, 1066, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1067, 51, 1067, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1068, 51, 1068, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1069, 51, 1069, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1070, 51, 1070, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1071, 51, 1071, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1072, 52, 1072, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1073, 52, 1073, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1074, 52, 1074, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1075, 52, 1075, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1076, 52, 1076, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1077, 52, 1077, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1078, 52, 1078, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1079, 52, 1079, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1080, 52, 1080, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1081, 52, 1081, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1082, 52, 1082, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1083, 52, 1083, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1084, 52, 1084, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1085, 52, 1085, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1086, 52, 1086, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1087, 52, 1087, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1088, 52, 1088, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1089, 52, 1089, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1090, 52, 1090, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1091, 52, 1091, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1092, 52, 1092, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1093, 53, 1093, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1094, 53, 1094, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1095, 53, 1095, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1096, 53, 1096, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1097, 53, 1097, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1098, 53, 1098, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1099, 53, 1099, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1100, 53, 1100, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1101, 53, 1101, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1102, 53, 1102, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1103, 53, 1103, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1104, 53, 1104, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1105, 53, 1105, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1106, 53, 1106, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1107, 53, 1107, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1108, 53, 1108, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1109, 53, 1109, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1110, 53, 1110, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1111, 53, 1111, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1112, 53, 1112, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1113, 53, 1113, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1114, 54, 1114, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1115, 54, 1115, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1116, 54, 1116, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1117, 54, 1117, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1118, 54, 1118, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1119, 54, 1119, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1120, 54, 1120, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1121, 54, 1121, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1122, 54, 1122, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1123, 54, 1123, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1124, 54, 1124, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1125, 54, 1125, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1126, 54, 1126, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1127, 54, 1127, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1128, 54, 1128, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1129, 54, 1129, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1130, 54, 1130, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1131, 54, 1131, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1132, 54, 1132, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1133, 54, 1133, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1134, 54, 1134, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1135, 55, 1135, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1136, 55, 1136, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1137, 55, 1137, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1138, 55, 1138, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1139, 55, 1139, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1140, 55, 1140, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1141, 55, 1141, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1142, 55, 1142, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1143, 55, 1143, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1144, 55, 1144, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1145, 55, 1145, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1146, 55, 1146, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1147, 55, 1147, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1148, 55, 1148, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1149, 55, 1149, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1150, 55, 1150, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1151, 55, 1151, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1152, 55, 1152, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1153, 55, 1153, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1154, 55, 1154, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1155, 55, 1155, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1156, 56, 1156, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1157, 56, 1157, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1158, 56, 1158, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1159, 56, 1159, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1160, 56, 1160, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1161, 56, 1161, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1162, 56, 1162, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1163, 56, 1163, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1164, 56, 1164, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1165, 56, 1165, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1166, 56, 1166, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1167, 56, 1167, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1168, 56, 1168, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1169, 56, 1169, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1170, 56, 1170, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1171, 56, 1171, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1172, 56, 1172, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1173, 56, 1173, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1174, 56, 1174, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1175, 56, 1175, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1176, 56, 1176, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1177, 57, 1177, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1178, 57, 1178, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1179, 57, 1179, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1180, 57, 1180, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1181, 57, 1181, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1182, 57, 1182, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1183, 57, 1183, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1184, 57, 1184, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1185, 57, 1185, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1186, 57, 1186, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1187, 57, 1187, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1188, 57, 1188, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1189, 57, 1189, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1190, 57, 1190, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1191, 57, 1191, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1192, 57, 1192, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1193, 57, 1193, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1194, 57, 1194, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1195, 57, 1195, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1196, 57, 1196, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1197, 57, 1197, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1198, 58, 1198, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1199, 58, 1199, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1200, 58, 1200, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1201, 58, 1201, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1202, 58, 1202, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1203, 58, 1203, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1204, 58, 1204, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1205, 58, 1205, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1206, 58, 1206, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1207, 58, 1207, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1208, 58, 1208, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1209, 58, 1209, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1210, 58, 1210, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1211, 58, 1211, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1212, 58, 1212, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1213, 58, 1213, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1214, 58, 1214, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1215, 58, 1215, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1216, 58, 1216, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1217, 58, 1217, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1218, 58, 1218, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1219, 59, 1219, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1220, 59, 1220, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1221, 59, 1221, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1222, 59, 1222, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1223, 59, 1223, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1224, 59, 1224, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1225, 59, 1225, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1226, 59, 1226, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1227, 59, 1227, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1228, 59, 1228, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1229, 59, 1229, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1230, 59, 1230, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1231, 59, 1231, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1232, 59, 1232, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1233, 59, 1233, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1234, 59, 1234, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1235, 59, 1235, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1236, 59, 1236, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1237, 59, 1237, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1238, 59, 1238, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1239, 59, 1239, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1240, 60, 1240, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1241, 60, 1241, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1242, 60, 1242, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1243, 60, 1243, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1244, 60, 1244, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1245, 60, 1245, 6, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1246, 60, 1246, 7, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1247, 60, 1247, 8, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1248, 60, 1248, 9, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1249, 60, 1249, 10, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1250, 60, 1250, 11, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1251, 60, 1251, 12, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1252, 60, 1252, 13, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1253, 60, 1253, 14, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1254, 60, 1254, 15, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1255, 60, 1255, 16, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1256, 60, 1256, 17, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1257, 60, 1257, 18, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1258, 60, 1258, 19, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1259, 60, 1259, 20, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(1260, 60, 1260, 21, 'ACT', 'ART', 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2020_05_21_100000_create_teams_table', 1),
(7, '2020_05_21_200000_create_team_user_table', 1),
(8, '2020_05_21_300000_create_team_invitations_table', 1),
(9, '2022_10_25_012240_create_sessions_table', 1),
(10, '2022_10_25_101518_create_suppliers_table', 1),
(11, '2022_10_25_101531_create_categories_table', 1),
(12, '2022_10_25_101544_create_locations_table', 1),
(13, '2022_11_24_064103_create_years_table', 1),
(14, '2022_11_25_025230_create_subjects_table', 1),
(15, '2022_11_25_025324_create_courses_table', 1),
(16, '2022_11_25_025738_create_klasses_table', 1),
(17, '2022_11_25_031010_create_staff_table', 1),
(18, '2022_11_25_031020_create_students_table', 1),
(19, '2022_11_25_031818_create_gardians_table', 1),
(20, '2022_11_25_031922_create_student_gardians_table', 1),
(21, '2022_11_28_044957_create_disciplines_table', 1),
(22, '2022_11_29_035409_create_configs_table', 1),
(23, '2022_11_30_090054_create_scores_table', 1),
(24, '2022_12_01_075920_create_grades_table', 1),
(25, '2022_12_02_011550_create_klass_student_table', 1),
(26, '2022_12_09_071744_create_teachers_table', 1),
(27, '2022_12_12_141100_create_course_scores_table', 1),
(28, '2023_01_07_152244_create_transcripts_table', 1),
(29, '2023_01_07_162945_create_transcript_templates_table', 1),
(30, '2023_01_09_033255_create_score_columns_table', 1),
(31, '2023_01_11_023007_create_course_teachers_table', 1),
(32, '2023_01_11_064535_create_permission_tables', 1),
(33, '2023_01_14_024917_create_addresses_table', 1),
(34, '2023_01_14_133306_create_identity_documents_table', 1),
(35, '2023_01_14_141228_create_banks_table', 1),
(36, '2023_01_14_142338_create_student_details_table', 1),
(37, '2023_01_14_150126_create_parentals_table', 1),
(38, '2023_01_14_151709_create_guardians_table', 1),
(39, '2023_01_14_161817_create_healthcares_table', 1),
(40, '2023_01_18_083745_create_subject_templates_table', 1),
(41, '2023_02_03_013106_create_score_templates_table', 1),
(42, '2023_02_06_084919_create_studies_table', 2),
(43, '2023_02_06_084931_create_study_subjects_table', 2),
(44, '2023_01_09_033255_create_course_scores_table', 3),
(45, '2023_02_09_014246_create_habits_table', 4),
(46, '2023_02_09_014659_create_outcomes_table', 5),
(47, '2023_02_10_033535_create_behaviours_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2);

-- --------------------------------------------------------

--
-- Table structure for table `outcomes`
--

CREATE TABLE `outcomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `terim_id` bigint(20) NOT NULL,
  `late` int(11) NOT NULL,
  `absent` int(11) NOT NULL,
  `reward` varchar(255) NOT NULL,
  `leisure_name` varchar(255) NOT NULL,
  `leisure_perform` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `appraisal` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parentals`
--

CREATE TABLE `parentals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `father_phone` varchar(255) DEFAULT NULL,
  `father_organization` varchar(255) DEFAULT NULL,
  `father_job` varchar(255) DEFAULT NULL,
  `father_address` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mother_phone` varchar(255) DEFAULT NULL,
  `mother_organization` varchar(255) DEFAULT NULL,
  `mother_job` varchar(255) DEFAULT NULL,
  `mother_address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'master', 'web', '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 'admin', 'web', '2023-02-03 01:27:29', '2023-02-03 01:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

CREATE TABLE `scores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `course_score_id` bigint(20) NOT NULL,
  `point` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `scores`
--

INSERT INTO `scores` (`id`, `klass_student_id`, `course_score_id`, `point`, `remark`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '100', NULL, NULL, '2023-02-03 01:34:23'),
(2, 5, 1, '80', NULL, NULL, '2023-02-03 01:34:23'),
(3, 3, 2, '90', NULL, NULL, '2023-02-03 01:34:23'),
(4, 1, 21, '1', NULL, '2023-02-03 01:28:45', '2023-02-03 01:34:23'),
(256, 1, 22, '2', NULL, '2023-02-03 01:30:42', '2023-02-03 01:34:23'),
(392, 1, 23, '3', NULL, '2023-02-03 01:34:23', '2023-02-03 01:34:23');

-- --------------------------------------------------------

--
-- Table structure for table `score_columns2`
--

CREATE TABLE `score_columns2` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_label` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `for_transcript` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `score_columns2`
--

INSERT INTO `score_columns2` (`id`, `term_id`, `course_id`, `sequence`, `field_name`, `field_label`, `type`, `scheme`, `description`, `for_transcript`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, 2, 1, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, 1, 2, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, 2, 2, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, 1, 3, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, 2, 3, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, 1, 4, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, 2, 4, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, 1, 5, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, 2, 5, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, 1, 6, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(12, 2, 6, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(13, 1, 7, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(14, 2, 7, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(15, 1, 8, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(16, 2, 8, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(17, 1, 9, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(18, 2, 9, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(19, 1, 10, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(20, 2, 10, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(21, 1, 1, 1, '', 'Test1', NULL, NULL, NULL, 0, NULL, NULL),
(22, 1, 1, 2, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(23, 2, 1, 3, '', 'Test2', NULL, NULL, NULL, 0, NULL, NULL),
(24, 2, 1, 4, '', 'Exam', NULL, NULL, NULL, 0, NULL, NULL),
(255, 1, 341, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(256, 2, 341, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(257, 1, 342, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(258, 2, 342, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(259, 1, 343, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(260, 2, 343, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(261, 1, 344, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(262, 2, 344, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(263, 1, 345, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(264, 2, 345, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(265, 1, 346, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(266, 2, 346, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(267, 1, 347, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(268, 2, 347, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(269, 1, 348, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(270, 2, 348, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(271, 1, 349, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(272, 2, 349, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(273, 1, 350, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(274, 2, 350, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(275, 1, 351, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(276, 2, 351, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(277, 1, 352, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(278, 2, 352, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(279, 1, 353, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(280, 2, 353, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:07', '2023-02-07 19:01:07'),
(281, 1, 354, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(282, 2, 354, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(283, 1, 355, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(284, 2, 355, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(285, 1, 356, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(286, 2, 356, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(287, 1, 357, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(288, 2, 357, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(289, 1, 358, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(290, 2, 358, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(291, 1, 359, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(292, 2, 359, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(293, 1, 360, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(294, 2, 360, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(295, 1, 361, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(296, 2, 361, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(297, 1, 362, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(298, 2, 362, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(299, 1, 363, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(300, 2, 363, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(301, 1, 364, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(302, 2, 364, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(303, 1, 365, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(304, 2, 365, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(305, 1, 366, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(306, 2, 366, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(307, 1, 367, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(308, 2, 367, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(309, 1, 368, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(310, 2, 368, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(311, 1, 369, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(312, 2, 369, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(313, 1, 370, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(314, 2, 370, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(315, 1, 371, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(316, 2, 371, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(317, 1, 372, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(318, 2, 372, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(319, 1, 373, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(320, 2, 373, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(321, 1, 374, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(322, 2, 374, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(323, 1, 375, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(324, 2, 375, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(325, 1, 376, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(326, 2, 376, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(327, 1, 377, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(328, 2, 377, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(329, 1, 378, NULL, 'term1', '上學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(330, 2, 378, NULL, 'term2', '下學期', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(331, 1, 379, NULL, 'comment', '描述', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08'),
(332, 1, 380, NULL, 'comment', '描述', NULL, NULL, NULL, 0, '2023-02-07 19:01:08', '2023-02-07 19:01:08');

-- --------------------------------------------------------

--
-- Table structure for table `score_templates`
--

CREATE TABLE `score_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch` varchar(255) DEFAULT NULL,
  `type` varchar(6) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_label` varchar(255) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `for_transcript` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `score_templates`
--

INSERT INTO `score_templates` (`id`, `batch`, `type`, `term_id`, `field_name`, `field_label`, `sequence`, `scheme`, `for_transcript`, `created_at`, `updated_at`) VALUES
(1, 'TERMS', 'SUB', 1, '', '上學期', 1, NULL, 1, NULL, NULL),
(2, 'TERMS', 'SUB', 2, '', '上學期', 2, NULL, 1, NULL, NULL),
(3, 'COMMENT', 'ATT', 0, '', '描述', 1, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('zn1YMqjxyGSn5TsMm3LNiGjmbyb4xBBKQa6eHtuE', 2, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTk80THkyQXM0ODZWc3pKMWJzZ1lxV3kyVUJMdTN2RFBwbGhpcUwzViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tYW5hZ2UvYmVoYXZpb3Vycz9rc2lkPTEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO3M6MjE6InBhc3N3b3JkX2hhc2hfc2FuY3R1bSI7czo2MDoiJDJ5JDEwJFRhblBJNXZ6aEQ1MjUxWnpva2g4dy5vR0FzVlM2S1FuSmN2cXJNaG1sZTJieHpmQlBuUWJxIjt9', 1676021997);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_fn` varchar(255) DEFAULT NULL,
  `gender` char(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `sector` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `code`, `name_zh`, `name_fn`, `gender`, `dob`, `mobile`, `sector`, `created_at`, `updated_at`) VALUES
(1, NULL, '丁娟庭', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(2, NULL, '洪樺', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(3, NULL, '后雯淑', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(4, NULL, '第五瑜', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(5, NULL, '樂冠', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(6, NULL, '蓋偉', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(7, NULL, '紀君', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(8, NULL, '蒼銘', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(9, NULL, '海鈺', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(10, NULL, '萬傑佳', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(11, NULL, '尉遲賢', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(12, NULL, '督佩蓉', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(13, NULL, '喻慧', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(14, NULL, '諸詩宜', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(15, NULL, '甘芳佳', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(16, NULL, '司空思信', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(17, NULL, '郜婉萱', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(18, NULL, '鬱瑋', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(19, NULL, '璩郁', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(20, NULL, '融詩瑋', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(21, NULL, '鄂娟', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(22, NULL, '房華怡', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(23, NULL, '伍庭宏', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(24, NULL, '呂翰', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(25, NULL, '茅詩', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(26, NULL, '段干詩信', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(27, NULL, '繆宏冠', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(28, NULL, '翟嘉', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(29, NULL, '凌樺俊', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(30, NULL, '哈冠琪', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(31, NULL, '東方儀', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(32, NULL, '慎慧', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(33, NULL, '仰哲承', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(34, NULL, '閆宗心', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(35, NULL, '章萍', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(36, NULL, '公冶家信', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(37, NULL, '沈琪怡', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(38, NULL, '榮穎鈺', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(39, NULL, '濮陽筱琬', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(40, NULL, '平承', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(41, NULL, '郤華建', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(42, NULL, '邊信', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(43, NULL, '郤賢', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(44, NULL, '竺玲', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(45, NULL, '東門華鈺', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(46, NULL, '東方筑蓉', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(47, NULL, '公羊翰', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(48, NULL, '烏志嘉', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(49, NULL, '雍瑋', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(50, NULL, '艾柏', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(51, NULL, '孔家琬', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(52, NULL, '藍慧涵', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(53, NULL, '鄢儀玲', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(54, NULL, '姬琬欣', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(55, NULL, '乜筑慧', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(56, NULL, '慕怡佳', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(57, NULL, '巢佩貞', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(58, NULL, '軒轅琪怡', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(59, NULL, '拓跋哲', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(60, NULL, '任如穎', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(61, NULL, '秋如', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(62, NULL, '隗穎銘', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(63, NULL, '堵穎琪', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(64, NULL, '扈心', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(65, NULL, '沙美霖', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(66, NULL, '凌傑', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(67, NULL, '米心', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(68, NULL, '談佳', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(69, NULL, '佘美', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(70, NULL, '赫連詩安', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(71, NULL, '應宜貞', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(72, NULL, '桑冠', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(73, NULL, '鞠怡', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(74, NULL, '厙建庭', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(75, NULL, '幸宇', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(76, NULL, '宮志心', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(77, NULL, '竇美筱', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(78, NULL, '申軒', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(79, NULL, '姜思', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(80, NULL, '皮雅惠', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(81, NULL, '夔翰豪', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(82, NULL, '郗貞', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(83, NULL, '雙如芳', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(84, NULL, '趙賢軒', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(85, NULL, '充琪', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(86, NULL, '安軒', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(87, NULL, '懷萍珊', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(88, NULL, '陶涵', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(89, NULL, '焦心冠', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(90, NULL, '伯華', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(91, NULL, '臧哲', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(92, NULL, '余詩宇', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(93, NULL, '段干君', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(94, NULL, '衛萱琪', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(95, NULL, '榮承冠', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(96, NULL, '孫庭思', NULL, 'M', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(97, NULL, '干穎', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(98, NULL, '韶蓉筱', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(99, NULL, '暨穎', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29'),
(100, NULL, '呼延美軒', NULL, 'F', NULL, NULL, NULL, '2023-02-03 01:27:29', '2023-02-03 01:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_fn` varchar(255) DEFAULT NULL,
  `name_display` varchar(255) DEFAULT NULL,
  `gender` char(1) NOT NULL,
  `dob` date DEFAULT NULL,
  `pob` varchar(255) DEFAULT NULL,
  `start_letter` varchar(255) DEFAULT NULL,
  `start_grade` varchar(255) DEFAULT NULL,
  `sic` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `dsej_num` varchar(255) DEFAULT NULL,
  `medical_num` varchar(255) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `past_school_name` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `phone_sms` varchar(255) DEFAULT NULL,
  `phone_home` varchar(255) DEFAULT NULL,
  `carer` varchar(255) DEFAULT NULL,
  `parent` text DEFAULT NULL,
  `garidan` text DEFAULT NULL,
  `liaison` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(1, '饒宜威', '宜君', NULL, 'F', '2010-10-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(2, '卜冠', '蓉', NULL, 'F', '2014-10-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(3, '葉蓉庭', '銘', NULL, 'M', '2013-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(4, '上官華', '傑詩', NULL, 'M', '2003-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(5, '曹萍', '娟冠', NULL, 'F', '2012-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(6, '利軒翰', '貞', NULL, 'F', '2006-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(7, '雙哲', '宜', NULL, 'F', '2003-03-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(8, '柳宜軒', '雯宜', NULL, 'F', '2014-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(9, '端木霖威', '宏', NULL, 'F', '2006-04-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(10, '熊霖宜', '涵', NULL, 'F', '2002-09-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(11, '賴筑萱', '俊', NULL, 'M', '2008-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(12, '柴貞', '威', NULL, 'F', '2009-04-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(13, '成婷靜', '儀依', NULL, 'M', '2013-08-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(14, '卓建宏', '豪樺', NULL, 'M', '2006-08-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(15, '何涵君', '嘉', NULL, 'F', '2001-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(16, '邢雅', '哲佳', NULL, 'M', '2004-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(17, '紅冠', '如', NULL, 'F', '2011-09-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(18, '周安偉', '穎軒', NULL, 'F', '2012-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(19, '赫連柏霖', '宏冠', NULL, 'F', '2009-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(20, '邢威瑋', '儀', NULL, 'F', '2007-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(21, '關雯伶', '志美', NULL, 'F', '2004-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(22, '廉豪', '樺', NULL, 'F', '2009-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(23, '奚筱', '偉安', NULL, 'F', '2005-10-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(24, '養承', '傑威', NULL, 'F', '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(25, '倪萍惠', '宜穎', NULL, 'F', '2005-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(26, '邊筑', '華', NULL, 'M', '2015-05-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(27, '宰父芬', '穎承', NULL, 'F', '2001-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(28, '仲孫傑穎', '芬佳', NULL, 'M', '2002-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(29, '榮宗柏', '靜欣', NULL, 'M', '2007-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(30, '沈家家', '文', NULL, 'F', '2006-10-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(31, '高鈺', '筱', NULL, 'F', '2014-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(32, '烏家樺', '嘉宏', NULL, 'M', '2010-09-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(33, '盛宇詩', '思', NULL, 'M', '2008-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(34, '太叔怡萍', '雯雅', NULL, 'M', '2015-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(35, '司徒翰豪', '惠', NULL, 'F', '2002-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(36, '苗翰', '思', NULL, 'F', '2001-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(37, '劉美蓉', '安宜', NULL, 'M', '2012-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(38, '鄒承', '琪婉', NULL, 'M', '2004-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(39, '郟嘉思', '宇', NULL, 'F', '2004-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(40, '籍娟', '冠', NULL, 'F', '2013-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(41, '晁霖詩', '心', NULL, 'F', '2008-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(42, '聞玲', '俊', NULL, 'M', '2007-02-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(43, '馮瑜欣', '翰思', NULL, 'F', '2005-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(44, '谷玲穎', '琪瑜', NULL, 'M', '2008-07-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(45, '汲柏安', '筱', NULL, 'F', '2006-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(46, '伊宏', '思', NULL, 'M', '2012-10-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(47, '程詩宜', '佳', NULL, 'F', '2009-05-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(48, '弓廷哲', '儀', NULL, 'M', '2011-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(49, '柏翰廷', '冠心', NULL, 'M', '2007-01-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(50, '陽安', '豪', NULL, 'F', '2008-01-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(51, '東豪', '冠', NULL, 'M', '2014-03-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(52, '東思', '淑', NULL, 'F', '2009-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(53, '陽俊', '庭', NULL, 'F', '2000-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(54, '南宮瑜怡', '怡', NULL, 'M', '2006-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(55, '陸君', '欣郁', NULL, 'F', '2006-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(56, '蔣冠', '偉', NULL, 'M', '2006-09-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(57, '毛萍珊', '婷', NULL, 'M', '2001-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(58, '謝玲', '筑', NULL, 'M', '2014-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(59, '褚志文', '安', NULL, 'M', '2012-02-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(60, '霍心', '慧', NULL, 'M', '2011-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(61, '蓋志宏', '嘉', NULL, 'M', '2004-07-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(62, '龐郁', '佳郁', NULL, 'M', '2014-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(63, '孟美', '偉', NULL, 'F', '2005-04-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(64, '章華', '軒', NULL, 'M', '2005-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(65, '淳于家', '美美', NULL, 'F', '2013-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(66, '洪雅', '俊', NULL, 'F', '2006-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(67, '慕庭', '伶慧', NULL, 'F', '2007-09-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(68, '郟萍華', '琪', NULL, 'M', '2006-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(69, '甄美郁', '家偉', NULL, 'M', '2010-06-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(70, '甯威嘉', '威', NULL, 'F', '2009-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(71, '賈庭信', '豪安', NULL, 'M', '2006-04-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(72, '伍宇', '郁心', NULL, 'M', '2002-05-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(73, '督如', '宏', NULL, 'F', '2014-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(74, '梅宏冠', '銘', NULL, 'M', '2001-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(75, '沙淑庭', '欣婷', NULL, 'F', '2010-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(76, '夏怡', '馨', NULL, 'M', '2009-02-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(77, '陸偉瑋', '家哲', NULL, 'M', '2012-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(78, '陰思', '雯', NULL, 'F', '2001-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(79, '郁佳佩', '詩', NULL, 'F', '2002-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(80, '伊婉', '瑋', NULL, 'M', '2001-06-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(81, '微生思', '文', NULL, 'F', '2004-03-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(82, '暨心琪', '霖軒', NULL, 'M', '2006-03-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(83, '佘翰家', '依雅', NULL, 'M', '2002-06-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(84, '白筑詩', '豪豪', NULL, 'F', '2013-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(85, '尹承文', '彥志', NULL, 'F', '2002-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(86, '穆娟佳', '伶', NULL, 'M', '2002-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(87, '終廷', '筱佩', NULL, 'F', '2008-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(88, '夏文', '霖', NULL, 'M', '2007-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(89, '海嘉', '如', NULL, 'F', '2009-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(90, '勾思霖', '宏', NULL, 'F', '2001-06-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(91, '林雅', '文琪', NULL, 'M', '2015-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(92, '能冠', '美', NULL, 'M', '2010-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(93, '軒轅琬', '君惠', NULL, 'F', '2011-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(94, '牧冠', '如', NULL, 'F', '2007-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(95, '公羊如君', '翰承', NULL, 'M', '2007-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(96, '彭宇銘', '慧', NULL, 'F', '2007-12-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(97, '倪安', '宜', NULL, 'F', '2001-01-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(98, '福心', '承柏', NULL, 'M', '2004-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(99, '羿柏瑋', '翰俊', NULL, 'F', '2002-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(100, '藍儀芬', '家翰', NULL, 'M', '2009-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(101, '查佳', '詩', NULL, 'F', '2005-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(102, '鞏佳', '心雯', NULL, 'F', '2014-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(103, '應文', '依', NULL, 'F', '2004-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(104, '郎威', '俊', NULL, 'M', '2004-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(105, '戚婷', '豪', NULL, 'M', '2004-09-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(106, '濮萱萍', '伶怡', NULL, 'M', '2010-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(107, '祝芬', '淑', NULL, 'M', '2002-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(108, '司寇雅伶', '蓉', NULL, 'F', '2007-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(109, '壽馨筱', '筑', NULL, 'F', '2013-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(110, '宰父俊', '君筑', NULL, 'F', '2010-12-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(111, '岳琬琪', '家', NULL, 'M', '2014-02-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(112, '督嘉霖', '伶', NULL, 'F', '2001-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(113, '曹婷娟', '玲佩', NULL, 'F', '2010-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(114, '郟瑋', '志俊', NULL, 'M', '2005-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(115, '龔琪淑', '嘉思', NULL, 'M', '2007-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(116, '南宮哲', '蓉依', NULL, 'M', '2011-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(117, '邵涵筑', '思信', NULL, 'M', '2011-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(118, '牛筑', '靜', NULL, 'M', '2011-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(119, '陳華', '承', NULL, 'F', '2008-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(120, '晉馨', '伶筑', NULL, 'M', '2002-05-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(121, '卞冠柏', '如', NULL, 'F', '2007-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(122, '茹庭', '穎宏', NULL, 'M', '2006-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(123, '昝宗', '琪', NULL, 'F', '2008-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(124, '關萱佳', '銘', NULL, 'M', '2007-05-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(125, '年樺心', '馨欣', NULL, 'M', '2013-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(126, '殷承銘', '俊志', NULL, 'M', '2007-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(127, '別冠', '美', NULL, 'M', '2015-06-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(128, '鄧哲', '志', NULL, 'M', '2004-12-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(129, '漆雕婷文', '婷依', NULL, 'F', '2009-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(130, '郭佩玲', '萱', NULL, 'M', '2013-06-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(131, '白偉樺', '哲', NULL, 'F', '2008-06-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(132, '烏君思', '樺穎', NULL, 'M', '2013-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(133, '鄭文宏', '瑋', NULL, 'F', '2004-05-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(134, '萬思威', '文', NULL, 'F', '2002-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(135, '魯慧宜', '宜心', NULL, 'M', '2008-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(136, '松銘', '宗', NULL, 'M', '2002-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(137, '東信賢', '宗', NULL, 'M', '2008-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(138, '季家宏', '伶萍', NULL, 'M', '2005-12-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(139, '伍俊', '佳', NULL, 'F', '2008-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(140, '水冠', '芳', NULL, 'F', '2012-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(141, '鄒彥詩', '志', NULL, 'F', '2013-06-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(142, '奚安佳', '哲家', NULL, 'M', '2015-08-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(143, '郭心萍', '宇', NULL, 'M', '2007-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(144, '逯郁', '佳', NULL, 'F', '2004-10-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(145, '相萱', '宜美', NULL, 'F', '2007-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(146, '蔣哲彥', '琪', NULL, 'F', '2003-11-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(147, '宣哲思', '柏美', NULL, 'M', '2012-04-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(148, '呂宜信', '鈺欣', NULL, 'M', '2012-01-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(149, '宦芬', '宜軒', NULL, 'F', '2003-05-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(150, '郗伶思', '惠玲', NULL, 'F', '2001-06-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(151, '令狐哲建', '心華', NULL, 'M', '2005-09-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(152, '蔡宇', '文穎', NULL, 'M', '2012-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(153, '豐宗佳', '涵婷', NULL, 'F', '2002-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(154, '司徒馨', '佩', NULL, 'M', '2014-05-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(155, '鄔宜郁', '銘', NULL, 'F', '2002-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(156, '狄佳庭', '怡冠', NULL, 'F', '2001-11-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(157, '林蓉佩', '建銘', NULL, 'F', '2005-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(158, '欽軒承', '軒嘉', NULL, 'F', '2001-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(159, '蒲宜', '心', NULL, 'M', '2009-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(160, '利華思', '彥', NULL, 'F', '2015-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(161, '酈華傑', '安文', NULL, 'F', '2010-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(162, '裘哲瑋', '俊君', NULL, 'M', '2012-10-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(163, '符君', '瑋', NULL, 'M', '2002-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(164, '平鈺娟', '嘉萱', NULL, 'F', '2014-06-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(165, '仉華', '芳怡', NULL, 'F', '2005-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(166, '薊貞婉', '家', NULL, 'F', '2011-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(167, '汝如', '芬萱', NULL, 'M', '2009-03-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(168, '甯建俊', '志嘉', NULL, 'M', '2009-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(169, '法哲嘉', '馨', NULL, 'M', '2009-09-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(170, '后蓉雯', '芳詩', NULL, 'F', '2006-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(171, '亓官穎', '建霖', NULL, 'M', '2015-03-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(172, '顓孫庭', '信君', NULL, 'M', '2003-11-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:25', '2023-02-03 01:27:25'),
(173, '杭安', '嘉彥', NULL, 'F', '2004-04-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(174, '沈思穎', '偉霖', NULL, 'F', '2003-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(175, '費琪涵', '美', NULL, 'M', '2005-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(176, '范心', '郁穎', NULL, 'F', '2009-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(177, '苗文瑋', '筑玲', NULL, 'F', '2007-02-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(178, '堵雅', '哲華', NULL, 'F', '2009-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(179, '明嘉', '銘美', NULL, 'M', '2013-08-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(180, '班承', '瑜佳', NULL, 'M', '2003-09-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(181, '寇軒', '廷', NULL, 'F', '2004-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(182, '危瑋', '美庭', NULL, 'M', '2012-05-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(183, '空怡娟', '廷', NULL, 'M', '2012-09-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(184, '畢瑋', '宗庭', NULL, 'M', '2013-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(185, '欒宗', '娟貞', NULL, 'M', '2007-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(186, '璩承', '慧', NULL, 'M', '2010-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(187, '盧珊', '蓉', NULL, 'M', '2008-05-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(188, '言瑋佳', '美穎', NULL, 'F', '2007-07-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(189, '蒙嘉', '瑜', NULL, 'F', '2014-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(190, '沈安信', '慧', NULL, 'F', '2009-05-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(191, '潘穎宇', '佩', NULL, 'M', '2014-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(192, '司空依庭', '郁靜', NULL, 'M', '2013-06-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(193, '宇文傑銘', '宇', NULL, 'F', '2013-01-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(194, '鄭君萍', '傑豪', NULL, 'F', '2004-05-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(195, '戴霖霖', '廷俊', NULL, 'F', '2000-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(196, '蒼婷', '銘廷', NULL, 'M', '2006-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(197, '璩嘉建', '佳宏', NULL, 'F', '2013-09-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(198, '蓬君哲', '詩美', NULL, 'M', '2009-12-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(199, '戴宜婷', '嘉', NULL, 'F', '2013-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(200, '滑彥偉', '華', NULL, 'F', '2005-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(201, '羊雯鈺', '慧', NULL, 'M', '2005-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(202, '湯筱', '佳俊', NULL, 'M', '2005-05-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(203, '班穎', '雅', NULL, 'F', '2007-12-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(204, '鄒萱涵', '淑儀', NULL, 'M', '2007-10-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(205, '惠偉', '威', NULL, 'F', '2006-12-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(206, '亢文玲', '宏建', NULL, 'F', '2009-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(207, '袁庭詩', '庭軒', NULL, 'M', '2007-05-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(208, '柏詩心', '威銘', NULL, 'M', '2001-05-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(209, '顧哲', '婉', NULL, 'F', '2005-03-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(210, '顓孫芬', '萍', NULL, 'M', '2006-06-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(211, '祁琬', '宜賢', NULL, 'M', '2005-09-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(212, '張翰', '偉', NULL, 'F', '2015-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(213, '盛儀', '惠如', NULL, 'F', '2002-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(214, '段干君慧', '哲', NULL, 'F', '2008-09-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(215, '沈靜佳', '家安', NULL, 'F', '2014-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(216, '太叔玲', '萱心', NULL, 'F', '2002-09-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(217, '陸華文', '宜', NULL, 'F', '2009-06-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(218, '百里樺思', '芬雯', NULL, 'M', '2010-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(219, '鮮于心', '宜婉', NULL, 'M', '2007-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(220, '麴思銘', '詩', NULL, 'M', '2008-03-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(221, '卞嘉宗', '萍貞', NULL, 'M', '2015-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(222, '藍宏宏', '慧', NULL, 'M', '2001-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(223, '酆芳', '傑傑', NULL, 'M', '2001-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(224, '逯銘', '惠', NULL, 'M', '2003-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(225, '太叔信信', '貞筱', NULL, 'F', '2012-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(226, '薄心', '哲霖', NULL, 'M', '2008-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(227, '陰鈺', '宗思', NULL, 'M', '2013-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(228, '公孫承宇', '雯', NULL, 'F', '2005-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(229, '巫琪安', '穎賢', NULL, 'F', '2010-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(230, '段干偉安', '慧瑜', NULL, 'M', '2007-10-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(231, '閆柏', '銘建', NULL, 'M', '2004-05-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(232, '孫琪君', '庭', NULL, 'F', '2013-06-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(233, '夾谷詩玲', '蓉', NULL, 'M', '2003-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(234, '薊靜筱', '穎', NULL, 'M', '2012-02-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(235, '禹欣家', '家', NULL, 'F', '2006-07-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(236, '仲孫霖', '如', NULL, 'M', '2005-12-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(237, '康郁', '儀', NULL, 'M', '2010-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(238, '牧冠', '鈺', NULL, 'M', '2014-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(239, '水建廷', '靜鈺', NULL, 'M', '2005-09-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(240, '馮嘉佳', '思', NULL, 'F', '2015-05-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(241, '帥宗宏', '銘瑋', NULL, 'M', '2012-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(242, '季詩翰', '君', NULL, 'M', '2005-01-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(243, '聞宜', '佳美', NULL, 'M', '2010-07-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(244, '柏銘穎', '安瑋', NULL, 'F', '2006-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(245, '韶郁', '建軒', NULL, 'F', '2011-05-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(246, '烏筱玲', '威', NULL, 'M', '2003-03-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(247, '甄穎', '娟婷', NULL, 'M', '2001-01-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(248, '蔚萱', '廷', NULL, 'M', '2012-04-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(249, '聞柏', '宏', NULL, 'F', '2007-01-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(250, '經嘉', '穎', NULL, 'M', '2003-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(251, '司文', '思佳', NULL, 'F', '2012-01-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(252, '雍傑哲', '銘心', NULL, 'M', '2004-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(253, '麻琬琪', '怡佳', NULL, 'M', '2015-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(254, '芮軒冠', '靜華', NULL, 'F', '2007-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(255, '容文', '詩思', NULL, 'M', '2012-06-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(256, '滑穎', '雅佳', NULL, 'F', '2011-10-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(257, '翁婉', '雅芳', NULL, 'M', '2005-12-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(258, '邰君靜', '信瑋', NULL, 'M', '2007-10-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(259, '晉銘志', '安偉', NULL, 'F', '2010-05-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(260, '公冶志俊', '翰', NULL, 'M', '2012-08-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(261, '暨俊', '庭靜', NULL, 'M', '2004-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(262, '督家穎', '雯', NULL, 'M', '2007-03-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(263, '顧傑俊', '怡', NULL, 'M', '2008-10-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(264, '通文宇', '婷琪', NULL, 'F', '2014-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(265, '匡軒', '俊彥', NULL, 'M', '2002-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(266, '鮮于依', '伶', NULL, 'F', '2005-08-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(267, '莊伶', '廷佳', NULL, 'F', '2012-07-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(268, '山嘉', '鈺', NULL, 'M', '2012-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(269, '蓋冠雅', '承', NULL, 'M', '2012-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(270, '盛雯', '信美', NULL, 'M', '2005-09-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26');
INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(271, '池俊軒', '雅欣', NULL, 'F', '2001-02-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(272, '鄭怡欣', '哲', NULL, 'M', '2012-08-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(273, '巫思佩', '傑偉', NULL, 'M', '2012-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(274, '賞廷安', '婷', NULL, 'M', '2003-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(275, '麻偉', '賢彥', NULL, 'M', '2012-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(276, '年安俊', '廷', NULL, 'F', '2004-06-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(277, '后家哲', '宏信', NULL, 'M', '2003-11-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(278, '巫慧涵', '琬', NULL, 'F', '2008-05-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(279, '應萱', '冠珊', NULL, 'M', '2015-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(280, '施宇君', '雯', NULL, 'F', '2015-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(281, '龍銘傑', '俊', NULL, 'M', '2010-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(282, '甘欣筱', '冠心', NULL, 'F', '2013-08-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(283, '晉娟儀', '銘偉', NULL, 'M', '2005-05-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(284, '奚偉心', '馨', NULL, 'F', '2004-12-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(285, '寇宏', '思佳', NULL, 'F', '2012-02-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(286, '莊君建', '思', NULL, 'F', '2008-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(287, '羿文琪', '文', NULL, 'M', '2010-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(288, '蕭芳萱', '宜柏', NULL, 'M', '2011-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(289, '陸琬', '瑋詩', NULL, 'M', '2004-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(290, '駱伶蓉', '文筑', NULL, 'M', '2013-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(291, '司徒依', '廷霖', NULL, 'M', '2003-05-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(292, '貝君', '安宗', NULL, 'M', '2010-04-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(293, '韋軒宗', '銘', NULL, 'F', '2007-02-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(294, '季琬', '庭', NULL, 'M', '2002-02-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(295, '慕哲美', '詩', NULL, 'F', '2007-11-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(296, '欒柏', '瑋賢', NULL, 'M', '2015-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(297, '太叔詩嘉', '淑貞', NULL, 'M', '2001-03-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(298, '帥蓉', '如', NULL, 'M', '2009-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(299, '仇佳志', '文', NULL, 'F', '2003-06-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(300, '繆芳', '俊', NULL, 'F', '2006-08-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(301, '舒儀安', '翰建', NULL, 'F', '2004-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(302, '閻家', '慧筱', NULL, 'F', '2001-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(303, '周貞', '芳珊', NULL, 'F', '2002-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(304, '邵慧', '偉', NULL, 'M', '2013-06-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(305, '曹霖翰', '筑', NULL, 'F', '2011-07-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(306, '淳于思嘉', '宇銘', NULL, 'M', '2014-04-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(307, '古貞', '筑欣', NULL, 'M', '2002-01-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(308, '尹美靜', '翰', NULL, 'M', '2008-08-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(309, '賴瑋', '萱雯', NULL, 'F', '2009-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(310, '徐家', '樺信', NULL, 'F', '2006-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(311, '諸華心', '文庭', NULL, 'F', '2001-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(312, '蔡思', '佩', NULL, 'M', '2003-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(313, '易淑思', '娟穎', NULL, 'F', '2015-03-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(314, '應馨怡', '筑', NULL, 'M', '2004-07-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(315, '璩美', '樺霖', NULL, 'M', '2003-01-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(316, '戚嘉萱', '柏柏', NULL, 'F', '2011-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(317, '邢彥宇', '蓉', NULL, 'F', '2004-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(318, '佴庭', '信', NULL, 'F', '2001-06-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(319, '艾文', '傑宏', NULL, 'F', '2004-10-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(320, '宮芳鈺', '宇霖', NULL, 'M', '2005-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(321, '倪君', '玲', NULL, 'M', '2007-09-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(322, '龍銘', '涵冠', NULL, 'M', '2012-12-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(323, '於宗', '穎軒', NULL, 'F', '2014-03-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(324, '鮮于君筱', '淑', NULL, 'M', '2000-09-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(325, '荊豪', '傑', NULL, 'F', '2008-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(326, '柯馨', '嘉穎', NULL, 'F', '2005-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(327, '陳儀馨', '庭哲', NULL, 'F', '2011-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(328, '平慧伶', '蓉', NULL, 'F', '2003-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(329, '張雅怡', '華琪', NULL, 'M', '2010-04-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(330, '能承彥', '信賢', NULL, 'F', '2006-12-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(331, '查雯', '淑', NULL, 'M', '2003-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(332, '屈宏', '佩', NULL, 'F', '2010-04-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(333, '申慧詩', '心佳', NULL, 'M', '2006-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(334, '蒯依', '安', NULL, 'M', '2014-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(335, '有萱婉', '詩', NULL, 'M', '2012-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(336, '那娟', '琬婉', NULL, 'M', '2015-04-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(337, '仲君琪', '宏偉', NULL, 'F', '2013-06-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(338, '夔安萱', '貞佩', NULL, 'M', '2008-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(339, '夔詩', '穎', NULL, 'F', '2007-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(340, '利翰', '郁萍', NULL, 'F', '2014-09-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(341, '吉芬萱', '芬心', NULL, 'F', '2013-06-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(342, '緱軒', '安蓉', NULL, 'F', '2005-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(343, '郎慧', '嘉家', NULL, 'F', '2015-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(344, '壤駟琪', '佩', NULL, 'M', '2003-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(345, '饒嘉', '家', NULL, 'M', '2013-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(346, '福萍', '傑哲', NULL, 'M', '2003-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(347, '巫欣芳', '雅', NULL, 'M', '2005-01-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(348, '牧翰宏', '芬', NULL, 'M', '2002-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(349, '龔郁美', '嘉佳', NULL, 'F', '2012-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(350, '公宜', '玲', NULL, 'F', '2008-05-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(351, '堵筱慧', '冠', NULL, 'F', '2001-06-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(352, '言君', '豪軒', NULL, 'M', '2005-11-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(353, '應詩', '瑋', NULL, 'F', '2002-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(354, '姜琪', '惠琬', NULL, 'M', '2015-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(355, '曾霖文', '雅怡', NULL, 'M', '2011-09-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(356, '柴美靜', '貞', NULL, 'M', '2011-07-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(357, '厙承', '庭', NULL, 'M', '2013-10-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(358, '凌穎', '芬', NULL, 'M', '2011-12-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(359, '逄詩', '瑋俊', NULL, 'F', '2001-09-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(360, '舒廷宏', '娟', NULL, 'M', '2010-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(361, '安佩', '翰賢', NULL, 'M', '2009-04-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(362, '沈華', '馨娟', NULL, 'F', '2003-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(363, '越廷', '珊蓉', NULL, 'F', '2002-07-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(364, '冀君廷', '怡', NULL, 'M', '2004-06-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(365, '卓婷安', '伶萱', NULL, 'M', '2003-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(366, '陳筱雯', '冠', NULL, 'F', '2004-05-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(367, '厙宜', '宇', NULL, 'M', '2000-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(368, '屈穎', '俊', NULL, 'M', '2007-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(369, '有萱君', '如淑', NULL, 'M', '2013-04-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(370, '麴宇穎', '蓉', NULL, 'F', '2011-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(371, '刁柏文', '承', NULL, 'M', '2011-07-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(372, '韓欣琪', '玲貞', NULL, 'F', '2007-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(373, '陰彥', '詩芬', NULL, 'F', '2010-08-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(374, '法心', '穎傑', NULL, 'M', '2005-12-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(375, '荀伶冠', '君雯', NULL, 'M', '2014-04-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(376, '尚彥', '軒', NULL, 'M', '2002-12-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(377, '虞馨', '冠', NULL, 'F', '2011-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(378, '須佩詩', '靜思', NULL, 'F', '2005-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(379, '盛筱', '佩', NULL, 'F', '2002-10-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(380, '沈馨玲', '文', NULL, 'F', '2007-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(381, '司馬華', '怡佩', NULL, 'M', '2001-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(382, '庾俊', '美郁', NULL, 'F', '2002-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(383, '農心', '惠', NULL, 'M', '2002-05-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(384, '宓依', '思', NULL, 'M', '2007-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(385, '況樺', '哲賢', NULL, 'M', '2014-04-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(386, '公良詩', '心', NULL, 'F', '2011-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(387, '鈕馨琪', '怡', NULL, 'F', '2015-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(388, '翁美文', '俊樺', NULL, 'M', '2015-07-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(389, '張穎君', '婉', NULL, 'F', '2010-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(390, '莫翰文', '華', NULL, 'F', '2007-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(391, '諸葛佩', '安', NULL, 'M', '2003-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(392, '百里筑', '家威', NULL, 'M', '2002-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(393, '周彥', '心', NULL, 'F', '2014-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(394, '白萱玲', '筑君', NULL, 'F', '2015-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(395, '空冠珊', '銘哲', NULL, 'F', '2003-08-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(396, '鬱穎', '信思', NULL, 'F', '2010-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(397, '仲孫婷鈺', '冠庭', NULL, 'M', '2008-05-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(398, '甘萱美', '依伶', NULL, 'F', '2014-09-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(399, '歐娟貞', '文', NULL, 'M', '2010-11-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(400, '關庭', '軒', NULL, 'M', '2012-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(401, '陶豪翰', '建', NULL, 'M', '2007-07-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(402, '連思', '儀', NULL, 'F', '2002-12-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(403, '楊霖', '詩文', NULL, 'F', '2007-11-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(404, '姬嘉宇', '琬', NULL, 'M', '2007-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(405, '紅玲穎', '嘉宜', NULL, 'F', '2006-12-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(406, '戎庭琬', '霖豪', NULL, 'M', '2010-07-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(407, '楚娟琬', '琬思', NULL, 'F', '2013-11-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(408, '魚萱', '儀', NULL, 'F', '2013-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(409, '郤萱', '安', NULL, 'F', '2012-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(410, '闕蓉', '庭宜', NULL, 'F', '2002-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(411, '應淑雯', '威', NULL, 'F', '2005-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(412, '靳美彥', '琪美', NULL, 'F', '2002-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(413, '姚承', '佩瑜', NULL, 'M', '2009-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(414, '穀梁安', '萍珊', NULL, 'F', '2009-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(415, '向宗威', '慧穎', NULL, 'M', '2004-05-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(416, '費宏', '淑', NULL, 'F', '2009-02-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(417, '龍霖建', '建家', NULL, 'M', '2003-06-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(418, '屠詩', '志', NULL, 'F', '2010-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(419, '拓跋冠詩', '冠', NULL, 'M', '2006-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(420, '於婉', '宗', NULL, 'F', '2014-12-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(421, '徐萍', '雯', NULL, 'F', '2003-10-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(422, '訾柏豪', '婉庭', NULL, 'F', '2007-12-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(423, '百里婉庭', '庭', NULL, 'F', '2005-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(424, '家宜', '嘉', NULL, 'F', '2002-11-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(425, '酆雯娟', '伶依', NULL, 'F', '2009-12-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(426, '聶承', '玲', NULL, 'M', '2010-11-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(427, '范心', '軒穎', NULL, 'M', '2007-02-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(428, '胡偉', '貞', NULL, 'M', '2011-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(429, '宗政雯淑', '霖', NULL, 'F', '2004-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(430, '蔚佳庭', '偉', NULL, 'F', '2002-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(431, '衡琬', '心', NULL, 'F', '2008-08-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(432, '閭丘穎', '婉', NULL, 'M', '2003-06-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(433, '滑佳傑', '軒', NULL, 'M', '2003-03-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(434, '庾琬君', '志', NULL, 'M', '2001-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(435, '夾谷慧婉', '君', NULL, 'M', '2003-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(436, '郭建', '安娟', NULL, 'M', '2005-05-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(437, '宗政瑜', '哲', NULL, 'M', '2005-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(438, '東方芳美', '雯萍', NULL, 'M', '2014-06-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(439, '鮑安賢', '嘉', NULL, 'F', '2015-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(440, '麴美君', '建承', NULL, 'F', '2014-03-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(441, '藍建承', '郁詩', NULL, 'M', '2011-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(442, '夏萱', '哲樺', NULL, 'F', '2012-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(443, '靳承建', '伶穎', NULL, 'M', '2011-08-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(444, '養安彥', '鈺慧', NULL, 'M', '2012-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(445, '都怡', '庭瑋', NULL, 'M', '2000-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(446, '闞哲', '志', NULL, 'M', '2004-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(447, '融瑋廷', '君', NULL, 'M', '2012-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(448, '茹瑋穎', '貞', NULL, 'F', '2004-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(449, '雲娟雯', '思', NULL, 'F', '2013-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(450, '宦庭佳', '嘉銘', NULL, 'F', '2004-10-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(451, '何慧心', '君', NULL, 'M', '2007-01-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(452, '茅玲', '馨', NULL, 'M', '2009-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(453, '郤琬慧', '娟', NULL, 'M', '2014-01-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(454, '陰冠安', '婉鈺', NULL, 'F', '2009-09-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(455, '歐陽惠', '蓉靜', NULL, 'F', '2015-03-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(456, '茅儀庭', '嘉', NULL, 'F', '2007-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(457, '戎穎', '惠伶', NULL, 'F', '2005-03-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(458, '仲孫樺銘', '偉信', NULL, 'F', '2014-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(459, '賀郁', '靜', NULL, 'F', '2001-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(460, '巴嘉', '婉琪', NULL, 'F', '2004-07-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(461, '柴佳', '建賢', NULL, 'M', '2010-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(462, '萬馨雅', '琪', NULL, 'F', '2011-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(463, '蔚娟', '雅', NULL, 'F', '2007-11-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(464, '顓孫宗', '樺', NULL, 'F', '2012-11-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(465, '談淑芳', '傑豪', NULL, 'M', '2010-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(466, '勞信', '芬貞', NULL, 'F', '2001-10-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(467, '郟萍婉', '雅家', NULL, 'F', '2004-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(468, '公孫君心', '琪', NULL, 'F', '2003-09-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(469, '蒲詩安', '佩家', NULL, 'F', '2010-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(470, '洪詩', '婷蓉', NULL, 'F', '2004-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(471, '逄筑', '冠', NULL, 'M', '2001-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(472, '崔心', '建', NULL, 'F', '2007-12-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(473, '樂正俊', '慧嘉', NULL, 'F', '2015-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(474, '仲芬伶', '嘉詩', NULL, 'F', '2013-08-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(475, '禹如玲', '安', NULL, 'F', '2010-07-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(476, '趙靜珊', '詩萍', NULL, 'M', '2013-10-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(477, '井慧儀', '宜', NULL, 'M', '2006-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(478, '竺家柏', '嘉', NULL, 'M', '2008-04-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(479, '暴霖彥', '信俊', NULL, 'F', '2005-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(480, '哈軒銘', '嘉', NULL, 'F', '2000-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(481, '車淑', '鈺文', NULL, 'M', '2003-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(482, '楚心冠', '雅靜', NULL, 'F', '2001-02-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(483, '杜美', '翰', NULL, 'F', '2002-11-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(484, '亓官庭安', '銘', NULL, 'F', '2012-08-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(485, '榮廷', '萱靜', NULL, 'M', '2005-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(486, '厲鈺芳', '佳穎', NULL, 'F', '2004-03-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(487, '歐儀玲', '婉', NULL, 'F', '2002-10-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(488, '聶芬瑜', '偉', NULL, 'F', '2009-01-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(489, '游信', '貞', NULL, 'M', '2005-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(490, '司寇筱萱', '翰', NULL, 'F', '2002-02-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(491, '國偉哲', '樺', NULL, 'M', '2002-12-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(492, '牧承', '安翰', NULL, 'M', '2010-01-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(493, '雲文筱', '偉宏', NULL, 'F', '2011-09-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(494, '子車柏', '儀娟', NULL, 'F', '2008-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(495, '邢文', '思彥', NULL, 'F', '2009-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(496, '孟玲', '志君', NULL, 'M', '2015-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(497, '聞人佩', '淑如', NULL, 'M', '2010-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(498, '宿萱心', '思', NULL, 'M', '2006-09-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(499, '韶心筑', '文珊', NULL, 'M', '2008-07-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(500, '經如', '文美', NULL, 'F', '2005-12-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(501, '漆雕萍', '蓉如', NULL, 'F', '2009-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(502, '璩銘豪', '志傑', NULL, 'F', '2014-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(503, '皇甫庭', '庭詩', NULL, 'F', '2005-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(504, '芮文佳', '思涵', NULL, 'M', '2001-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(505, '黨霖', '文宗', NULL, 'F', '2004-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(506, '和伶', '穎', NULL, 'M', '2010-04-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(507, '酈佩', '建樺', NULL, 'M', '2010-07-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(508, '司空彥', '冠彥', NULL, 'F', '2001-08-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(509, '廣君', '君美', NULL, 'F', '2008-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(510, '余家', '佳芳', NULL, 'F', '2009-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(511, '巢琬筑', '玲', NULL, 'M', '2013-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(512, '麻美賢', '淑', NULL, 'M', '2013-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(513, '傅玲', '哲豪', NULL, 'F', '2005-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(514, '弘宇', '貞', NULL, 'M', '2013-08-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(515, '廣雅', '郁', NULL, 'M', '2010-03-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(516, '楊詩', '樺', NULL, 'F', '2005-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(517, '費文傑', '庭', NULL, 'M', '2008-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(518, '巫馬琬瑜', '依', NULL, 'F', '2004-07-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(519, '于詩', '靜雅', NULL, 'M', '2015-05-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(520, '姬伶心', '瑋', NULL, 'F', '2007-03-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(521, '項怡伶', '郁', NULL, 'M', '2013-11-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(522, '戴嘉', '美', NULL, 'F', '2008-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(523, '仲鈺', '家', NULL, 'M', '2008-05-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(524, '壤駟華', '宗威', NULL, 'F', '2009-01-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(525, '步翰', '琪', NULL, 'F', '2011-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(526, '逄美傑', '宏', NULL, 'M', '2010-03-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(527, '姬銘君', '家家', NULL, 'M', '2007-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(528, '支郁華', '雯', NULL, 'M', '2013-06-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(529, '梁丘庭', '賢銘', NULL, 'F', '2001-07-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(530, '公西偉庭', '穎', NULL, 'M', '2007-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(531, '東君', '詩冠', NULL, 'M', '2011-09-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(532, '尹承', '詩宗', NULL, 'M', '2013-02-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(533, '夾谷怡鈺', '鈺', NULL, 'M', '2011-03-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(534, '顏郁', '佳', NULL, 'M', '2006-10-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(535, '聞信', '佳鈺', NULL, 'M', '2005-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(536, '閆承賢', '筱馨', NULL, 'M', '2004-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(537, '柴馨', '伶筑', NULL, 'M', '2012-04-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(538, '楚銘', '婷', NULL, 'M', '2004-12-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(539, '季心', '涵靜', NULL, 'F', '2004-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26');
INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(540, '程佳', '君', NULL, 'F', '2006-12-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(541, '楚雯佳', '鈺', NULL, 'M', '2011-11-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(542, '章佳', '琬芬', NULL, 'M', '2013-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(543, '宦華', '瑜', NULL, 'F', '2007-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(544, '方傑', '思華', NULL, 'F', '2013-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(545, '欽珊', '偉美', NULL, 'F', '2007-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(546, '樊心', '欣', NULL, 'F', '2006-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(547, '高芬淑', '婉', NULL, 'M', '2006-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(548, '豐銘柏', '穎華', NULL, 'M', '2000-12-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(549, '許美', '萱', NULL, 'M', '2012-10-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(550, '支俊安', '承庭', NULL, 'F', '2011-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(551, '皇甫華', '筑', NULL, 'F', '2004-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(552, '茹柏宇', '賢志', NULL, 'F', '2013-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(553, '終慧珊', '安文', NULL, 'F', '2008-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(554, '閻娟萱', '嘉美', NULL, 'F', '2014-08-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(555, '連霖華', '馨玲', NULL, 'F', '2013-08-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(556, '廉佩', '靜嘉', NULL, 'F', '2012-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(557, '鈕文', '威', NULL, 'M', '2008-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(558, '龔思', '瑋', NULL, 'M', '2010-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(559, '欽瑋', '庭嘉', NULL, 'F', '2015-06-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(560, '段俊', '心廷', NULL, 'M', '2013-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(561, '武詩', '萍', NULL, 'F', '2004-04-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(562, '狄志信', '珊', NULL, 'F', '2007-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(563, '緱思俊', '佳伶', NULL, 'M', '2015-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(564, '馮筱', '哲', NULL, 'M', '2008-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(565, '何宇冠', '庭詩', NULL, 'M', '2010-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(566, '梁淑芳', '貞依', NULL, 'M', '2012-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(567, '楊宗', '儀君', NULL, 'M', '2015-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(568, '強依宜', '君', NULL, 'M', '2013-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(569, '嚴瑋', '豪思', NULL, 'F', '2010-05-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(570, '湯君', '鈺', NULL, 'M', '2009-10-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(571, '奚儀', '翰', NULL, 'F', '2013-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(572, '萬儀', '儀郁', NULL, 'F', '2009-08-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(573, '濮陽承柏', '宗', NULL, 'M', '2006-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(574, '顓孫慧', '賢柏', NULL, 'M', '2003-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(575, '侯郁依', '慧', NULL, 'F', '2001-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(576, '匡廷冠', '嘉宏', NULL, 'M', '2001-01-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(577, '符文', '建家', NULL, 'F', '2012-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(578, '司家', '家', NULL, 'M', '2005-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(579, '孫儀穎', '婷', NULL, 'M', '2012-03-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(580, '雙信', '郁宜', NULL, 'M', '2012-07-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(581, '宓欣', '欣', NULL, 'M', '2004-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(582, '宗政靜庭', '文筱', NULL, 'M', '2008-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(583, '簡宜貞', '豪', NULL, 'M', '2007-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(584, '荀宇', '玲華', NULL, 'M', '2010-10-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(585, '段宏', '庭', NULL, 'M', '2011-03-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(586, '拓跋美', '美', NULL, 'M', '2009-05-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(587, '駱軒', '宜', NULL, 'F', '2011-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(588, '米庭瑋', '淑', NULL, 'F', '2010-10-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(589, '太叔宏穎', '蓉佳', NULL, 'F', '2010-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(590, '胥翰', '庭惠', NULL, 'M', '2005-02-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(591, '長孫宗文', '淑', NULL, 'F', '2010-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(592, '尉遲宇文', '文', NULL, 'M', '2009-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(593, '公羊文', '思', NULL, 'M', '2007-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(594, '祝樺', '軒', NULL, 'M', '2001-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(595, '公西慧宜', '婉如', NULL, 'M', '2002-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(596, '法心', '偉', NULL, 'M', '2004-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(597, '趙彥威', '傑文', NULL, 'F', '2007-09-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(598, '濮陽嘉柏', '家', NULL, 'F', '2009-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(599, '闞霖', '慧', NULL, 'F', '2007-11-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(600, '冀怡', '家志', NULL, 'M', '2012-10-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(601, '康穎銘', '美賢', NULL, 'M', '2013-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(602, '徐瑋', '貞淑', NULL, 'M', '2005-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(603, '佟宗霖', '庭', NULL, 'F', '2011-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(604, '佟穎婉', '依', NULL, 'F', '2011-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(605, '邊銘', '筱', NULL, 'M', '2008-03-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(606, '韓佳廷', '文', NULL, 'M', '2014-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(607, '年貞', '佳哲', NULL, 'F', '2011-12-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(608, '白依如', '美柏', NULL, 'F', '2014-08-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(609, '吉文', '穎穎', NULL, 'F', '2009-03-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(610, '第五宇建', '宜娟', NULL, 'F', '2001-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(611, '柴君哲', '瑜芬', NULL, 'F', '2006-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(612, '顏佳', '宗', NULL, 'F', '2009-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(613, '愛美建', '貞華', NULL, 'M', '2003-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(614, '席婷', '婷', NULL, 'M', '2005-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(615, '佘穎', '欣華', NULL, 'M', '2006-07-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(616, '步珊婉', '芬怡', NULL, 'F', '2004-06-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(617, '查宜庭', '琪', NULL, 'F', '2008-06-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(618, '鄢芬', '嘉', NULL, 'M', '2007-07-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(619, '法廷宇', '佳', NULL, 'F', '2006-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(620, '仇雯鈺', '淑庭', NULL, 'F', '2005-12-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(621, '令狐傑', '嘉', NULL, 'M', '2008-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(622, '庾郁', '華', NULL, 'M', '2008-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(623, '查信宏', '賢', NULL, 'M', '2011-09-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(624, '俞廷', '嘉', NULL, 'F', '2013-09-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(625, '孔俊銘', '如文', NULL, 'M', '2014-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(626, '汲瑜', '冠芳', NULL, 'M', '2007-05-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(627, '麴如嘉', '宏', NULL, 'M', '2010-07-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(628, '單詩', '涵', NULL, 'M', '2003-01-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(629, '仉柏', '佳', NULL, 'F', '2011-03-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(630, '邢賢', '雅安', NULL, 'F', '2015-02-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(631, '秋詩', '賢', NULL, 'M', '2010-02-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(632, '巴筑美', '郁', NULL, 'F', '2006-02-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(633, '藍廷', '家', NULL, 'F', '2006-07-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(634, '溫婷', '軒', NULL, 'F', '2001-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(635, '端木安', '冠佳', NULL, 'M', '2014-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(636, '蕭雅雯', '宇庭', NULL, 'M', '2009-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(637, '蕭美', '鈺', NULL, 'M', '2004-07-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(638, '澹臺承', '建信', NULL, 'M', '2007-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(639, '井如', '珊佩', NULL, 'M', '2014-10-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(640, '水萱', '惠', NULL, 'F', '2004-01-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(641, '慕容建瑋', '美', NULL, 'M', '2012-06-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(642, '勾瑜筱', '宏傑', NULL, 'M', '2003-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(643, '舒志心', '柏', NULL, 'M', '2003-09-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(644, '狄惠心', '嘉翰', NULL, 'M', '2011-10-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(645, '那琬佩', '雅', NULL, 'M', '2003-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(646, '涂詩華', '美珊', NULL, 'F', '2006-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(647, '衛樺賢', '華承', NULL, 'M', '2014-09-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(648, '太叔貞', '霖', NULL, 'M', '2003-03-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(649, '商承文', '思', NULL, 'F', '2013-08-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(650, '申傑', '玲蓉', NULL, 'F', '2011-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(651, '齊冠', '嘉涵', NULL, 'F', '2012-04-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(652, '庾銘', '君', NULL, 'F', '2014-06-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(653, '井安宗', '瑜', NULL, 'F', '2006-06-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(654, '吉涵', '玲萱', NULL, 'M', '2011-02-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(655, '笪安郁', '珊', NULL, 'F', '2004-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(656, '冷承承', '依', NULL, 'M', '2008-08-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(657, '雙琬萱', '翰樺', NULL, 'F', '2000-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(658, '伏家', '傑思', NULL, 'F', '2011-01-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(659, '謝霖', '美廷', NULL, 'F', '2002-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(660, '駱銘美', '嘉', NULL, 'M', '2003-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(661, '宿柏', '宇宗', NULL, 'M', '2002-04-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(662, '辛佩', '冠', NULL, 'F', '2009-07-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(663, '子車安', '翰', NULL, 'M', '2011-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(664, '牛思', '婷芬', NULL, 'M', '2011-06-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(665, '殷軒', '信', NULL, 'F', '2012-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(666, '戎瑜', '欣', NULL, 'F', '2014-03-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(667, '凌詩君', '涵伶', NULL, 'F', '2005-03-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(668, '充婷慧', '儀雅', NULL, 'M', '2003-04-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(669, '董惠', '萱', NULL, 'F', '2006-03-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(670, '曾豪豪', '信', NULL, 'M', '2002-07-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(671, '駱霖安', '宜霖', NULL, 'F', '2006-05-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(672, '穆冠廷', '珊', NULL, 'F', '2013-06-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(673, '咸翰宇', '冠偉', NULL, 'M', '2014-04-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(674, '淳于美', '鈺嘉', NULL, 'M', '2013-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(675, '夏芬', '儀如', NULL, 'F', '2010-06-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(676, '駱柏俊', '穎雯', NULL, 'M', '2010-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(677, '終萱雯', '宜', NULL, 'F', '2014-02-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(678, '奚家貞', '萱', NULL, 'F', '2003-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(679, '湛華靜', '庭穎', NULL, 'M', '2008-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(680, '梁華宗', '婉思', NULL, 'M', '2003-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(681, '索建', '娟婉', NULL, 'F', '2010-02-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(682, '桂筑', '靜', NULL, 'F', '2009-11-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(683, '公冶思', '穎', NULL, 'M', '2012-04-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(684, '安穎', '君', NULL, 'M', '2004-04-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(685, '殳欣筱', '欣庭', NULL, 'F', '2005-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(686, '申屠威銘', '銘', NULL, 'M', '2008-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(687, '雙如瑜', '家', NULL, 'M', '2011-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(688, '甯家美', '嘉嘉', NULL, 'F', '2011-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(689, '闕安銘', '蓉郁', NULL, 'F', '2013-07-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(690, '衡馨嘉', '思冠', NULL, 'M', '2002-10-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(691, '伯美', '文彥', NULL, 'F', '2000-10-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(692, '宰父庭', '宜心', NULL, 'F', '2006-08-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(693, '步儀華', '怡珊', NULL, 'M', '2010-11-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(694, '東門美家', '穎', NULL, 'M', '2012-03-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(695, '傅霖廷', '琬', NULL, 'M', '2006-01-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(696, '譙琪', '信霖', NULL, 'F', '2006-02-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(697, '郝傑威', '俊', NULL, 'F', '2015-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(698, '禹宏', '豪宜', NULL, 'F', '2001-11-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(699, '段干柏', '家', NULL, 'F', '2006-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(700, '戴佩', '庭', NULL, 'M', '2012-09-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(701, '藍佳', '婷', NULL, 'M', '2005-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(702, '滕瑋', '宇', NULL, 'M', '2006-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(703, '馬鈺雅', '志俊', NULL, 'F', '2010-07-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(704, '危欣芳', '筱婉', NULL, 'F', '2013-08-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(705, '和志哲', '筑', NULL, 'M', '2005-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(706, '嵇文穎', '俊柏', NULL, 'F', '2005-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(707, '翁豪', '玲貞', NULL, 'F', '2012-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(708, '孫軒', '依', NULL, 'M', '2001-01-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(709, '褚珊君', '欣', NULL, 'F', '2012-10-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(710, '劉君華', '志', NULL, 'F', '2011-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(711, '貢心', '建', NULL, 'M', '2008-03-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(712, '岑美佳', '鈺', NULL, 'F', '2007-11-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(713, '黃琪欣', '佩安', NULL, 'F', '2007-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(714, '柳廷豪', '建', NULL, 'F', '2013-03-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(715, '毛思', '嘉君', NULL, 'F', '2004-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(716, '游威', '宗', NULL, 'F', '2007-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(717, '段軒', '彥俊', NULL, 'F', '2014-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(718, '喻賢文', '威', NULL, 'M', '2012-10-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(719, '呂翰承', '佳貞', NULL, 'M', '2001-02-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(720, '東門安', '銘彥', NULL, 'F', '2010-10-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(721, '扶冠', '萱琬', NULL, 'M', '2003-12-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(722, '宦筱慧', '銘君', NULL, 'F', '2005-11-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(723, '厲文翰', '筑心', NULL, 'F', '2004-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(724, '史信宏', '芬筱', NULL, 'F', '2012-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(725, '上官珊', '穎君', NULL, 'M', '2002-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(726, '汲華', '淑馨', NULL, 'F', '2004-12-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(727, '蓬冠', '廷心', NULL, 'M', '2012-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(728, '佴霖威', '穎威', NULL, 'F', '2008-10-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(729, '婁賢建', '芳', NULL, 'M', '2009-10-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(730, '宗美心', '宏俊', NULL, 'F', '2006-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(731, '百里儀依', '雅庭', NULL, 'F', '2003-12-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(732, '辛樺華', '珊萍', NULL, 'M', '2009-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(733, '魯馨', '哲', NULL, 'M', '2004-12-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(734, '通婷', '宜', NULL, 'M', '2014-12-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(735, '顓孫慧琪', '樺', NULL, 'F', '2006-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(736, '都豪', '欣', NULL, 'F', '2010-08-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(737, '翟如', '萱萱', NULL, 'F', '2008-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(738, '李冠芳', '偉', NULL, 'M', '2004-07-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(739, '穀梁貞儀', '郁', NULL, 'M', '2013-05-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(740, '萬珊郁', '冠', NULL, 'M', '2003-10-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(741, '龔鈺淑', '芬儀', NULL, 'F', '2013-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(742, '隗宗賢', '冠', NULL, 'F', '2014-11-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(743, '匡君', '建華', NULL, 'M', '2009-07-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(744, '能庭', '慧涵', NULL, 'M', '2003-12-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(745, '萬柏軒', '傑', NULL, 'M', '2007-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(746, '喬雯庭', '如慧', NULL, 'F', '2008-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(747, '羊霖', '淑', NULL, 'F', '2009-10-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(748, '施安', '俊', NULL, 'M', '2002-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(749, '愛宗', '穎涵', NULL, 'F', '2010-11-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(750, '賁婷嘉', '建', NULL, 'F', '2007-11-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(751, '厲郁', '宇', NULL, 'F', '2004-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(752, '奚志', '佩芬', NULL, 'F', '2006-07-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(753, '利賢宏', '郁', NULL, 'F', '2002-12-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(754, '水嘉嘉', '淑婉', NULL, 'F', '2001-10-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(755, '瞿怡雯', '俊', NULL, 'M', '2014-11-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(756, '金穎', '心廷', NULL, 'M', '2002-05-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(757, '邴柏', '佳', NULL, 'F', '2005-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(758, '師豪', '宏廷', NULL, 'F', '2001-08-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(759, '平庭美', '筑', NULL, 'F', '2005-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(760, '敖賢嘉', '華', NULL, 'F', '2010-05-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(761, '梁丘志', '君婉', NULL, 'F', '2011-09-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(762, '晉華', '佩', NULL, 'M', '2015-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(763, '璩萍', '瑋哲', NULL, 'M', '2004-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(764, '秋萍美', '宗', NULL, 'M', '2010-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(765, '經美穎', '賢承', NULL, 'M', '2008-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(766, '儲萱惠', '廷美', NULL, 'M', '2006-07-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(767, '丘思華', '安嘉', NULL, 'F', '2011-01-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(768, '譚蓉淑', '承', NULL, 'F', '2000-10-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(769, '尉遲文', '萍', NULL, 'F', '2003-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:26', '2023-02-03 01:27:26'),
(770, '璩穎', '美婉', NULL, 'M', '2001-04-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(771, '干美豪', '儀', NULL, 'M', '2012-03-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(772, '章靜美', '冠穎', NULL, 'F', '2004-02-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(773, '言宗文', '思志', NULL, 'F', '2010-07-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(774, '乜軒', '穎', NULL, 'F', '2012-12-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(775, '宗軒軒', '哲俊', NULL, 'F', '2006-02-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(776, '師宜建', '蓉琪', NULL, 'M', '2008-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(777, '郤冠冠', '依鈺', NULL, 'F', '2001-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(778, '閆樺翰', '雅貞', NULL, 'M', '2002-12-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(779, '巢瑋翰', '詩', NULL, 'M', '2010-07-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(780, '第五宇', '宜宏', NULL, 'M', '2010-10-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(781, '閻庭銘', '萍', NULL, 'M', '2001-06-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(782, '韋樺霖', '淑筱', NULL, 'F', '2004-09-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(783, '司空佳', '靜瑜', NULL, 'F', '2006-08-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(784, '陶安華', '佳雯', NULL, 'M', '2000-12-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(785, '禹宏冠', '淑怡', NULL, 'F', '2008-02-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(786, '甄宇', '庭君', NULL, 'M', '2012-06-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(787, '阮建', '穎賢', NULL, 'F', '2000-10-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(788, '端木伶雅', '怡', NULL, 'F', '2008-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(789, '干銘宗', '琬', NULL, 'M', '2005-01-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(790, '鄂華', '思', NULL, 'F', '2015-04-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(791, '白安彥', '冠', NULL, 'M', '2012-01-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(792, '督志', '宗', NULL, 'M', '2008-03-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(793, '靳佩', '偉宇', NULL, 'F', '2002-01-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(794, '黃筑', '文', NULL, 'F', '2014-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(795, '郭宗', '美志', NULL, 'F', '2008-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(796, '郗伶', '心', NULL, 'M', '2005-10-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(797, '耿傑', '庭宗', NULL, 'M', '2007-11-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(798, '闕依', '華', NULL, 'M', '2010-09-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(799, '衛文廷', '君', NULL, 'M', '2014-07-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(800, '柯瑋豪', '信', NULL, 'M', '2001-02-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(801, '亢宜', '霖美', NULL, 'M', '2001-10-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(802, '艾樺', '婷伶', NULL, 'F', '2008-02-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(803, '班思琬', '宗', NULL, 'M', '2006-03-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(804, '師柏', '心霖', NULL, 'F', '2015-03-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(805, '伍瑜婉', '安', NULL, 'F', '2002-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(806, '柴欣', '佳', NULL, 'M', '2000-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(807, '貢馨君', '豪', NULL, 'M', '2012-10-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(808, '李如', '思哲', NULL, 'M', '2015-03-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27');
INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `name_display`, `gender`, `dob`, `pob`, `start_letter`, `start_grade`, `sic`, `phone`, `dsej_num`, `medical_num`, `entry_date`, `past_school_name`, `religion`, `phone_sms`, `phone_home`, `carer`, `parent`, `garidan`, `liaison`, `created_at`, `updated_at`) VALUES
(809, '璩佩琪', '安', NULL, 'M', '2008-09-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(810, '聞穎宏', '婉雯', NULL, 'M', '2002-01-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(811, '西門美欣', '伶安', NULL, 'F', '2011-03-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(812, '丁樺威', '家思', NULL, 'M', '2008-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(813, '逄俊', '如', NULL, 'F', '2014-03-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(814, '湛庭馨', '偉', NULL, 'M', '2015-01-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(815, '蒼琪佳', '雯', NULL, 'F', '2012-07-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(816, '成詩', '安宇', NULL, 'M', '2005-10-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(817, '糜承志', '詩玲', NULL, 'F', '2007-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(818, '向靜', '俊偉', NULL, 'M', '2008-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(819, '束靜', '蓉', NULL, 'F', '2012-03-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(820, '黎筑', '承宏', NULL, 'M', '2004-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(821, '鮑文琬', '嘉欣', NULL, 'M', '2013-01-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(822, '蔚筑', '宇詩', NULL, 'M', '2007-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(823, '祁涵', '穎', NULL, 'M', '2006-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(824, '東瑜', '慧', NULL, 'M', '2010-11-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(825, '牛銘', '筱', NULL, 'F', '2002-01-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(826, '商雯宜', '琪', NULL, 'M', '2003-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(827, '禹庭偉', '筱芳', NULL, 'M', '2001-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(828, '申屠承', '心冠', NULL, 'M', '2005-08-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(829, '黎萍', '瑋', NULL, 'M', '2008-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(830, '晏宏美', '芳美', NULL, 'M', '2004-10-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(831, '杭鈺', '芳佩', NULL, 'M', '2014-03-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(832, '山文思', '哲志', NULL, 'M', '2013-02-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(833, '童傑柏', '鈺', NULL, 'M', '2004-11-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(834, '帥琬怡', '心', NULL, 'F', '2011-01-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(835, '閭丘偉嘉', '君', NULL, 'M', '2009-06-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(836, '漆雕俊', '萱如', NULL, 'F', '2005-12-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(837, '支傑佳', '冠', NULL, 'F', '2011-08-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(838, '祖冠', '佳', NULL, 'M', '2013-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(839, '閆嘉', '玲', NULL, 'F', '2009-04-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(840, '郝靜靜', '柏', NULL, 'F', '2002-12-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(841, '荀霖', '家心', NULL, 'M', '2006-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(842, '洪安華', '樺信', NULL, 'F', '2005-05-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(843, '郗慧', '惠', NULL, 'F', '2014-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(844, '闕哲詩', '廷嘉', NULL, 'M', '2003-01-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(845, '昝玲依', '欣', NULL, 'F', '2015-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(846, '咸宜', '佳偉', NULL, 'M', '2002-02-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(847, '巢君筑', '娟冠', NULL, 'F', '2011-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(848, '舒美', '穎冠', NULL, 'M', '2011-01-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(849, '竺伶怡', '萱', NULL, 'M', '2007-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(850, '祖儀', '廷', NULL, 'M', '2009-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(851, '史家', '柏冠', NULL, 'F', '2004-12-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(852, '邊君佳', '庭', NULL, 'M', '2004-02-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(853, '柏琪', '翰偉', NULL, 'M', '2010-05-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(854, '車翰宜', '雅琪', NULL, 'F', '2013-09-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(855, '壤駟娟芳', '華', NULL, 'F', '2003-03-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(856, '芮郁蓉', '庭軒', NULL, 'F', '2009-03-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(857, '福宇家', '威嘉', NULL, 'M', '2015-08-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(858, '宮慧', '志', NULL, 'F', '2012-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(859, '歐琪', '芳', NULL, 'M', '2006-10-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(860, '戎豪', '柏翰', NULL, 'F', '2002-09-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(861, '郝偉', '志賢', NULL, 'M', '2013-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(862, '熊娟珊', '嘉雯', NULL, 'M', '2013-12-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(863, '盧廷', '如佳', NULL, 'M', '2002-05-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(864, '養宏美', '廷', NULL, 'F', '2010-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(865, '闞君', '慧君', NULL, 'F', '2003-10-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(866, '鬱華婷', '思', NULL, 'F', '2014-07-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(867, '滿伶雯', '霖', NULL, 'M', '2003-08-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(868, '賞惠', '廷', NULL, 'F', '2009-04-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(869, '琴俊偉', '安玲', NULL, 'M', '2009-09-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(870, '步靜欣', '涵', NULL, 'F', '2014-12-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(871, '於宜柏', '筱', NULL, 'M', '2013-12-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(872, '柴雯瑜', '樺', NULL, 'M', '2011-01-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(873, '梁丘穎雯', '豪華', NULL, 'M', '2012-10-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(874, '康佳信', '文冠', NULL, 'F', '2008-02-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(875, '夏傑', '宜庭', NULL, 'F', '2001-02-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(876, '向蓉琬', '華', NULL, 'F', '2009-09-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(877, '闕娟君', '穎嘉', NULL, 'F', '2012-09-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(878, '呼延傑', '文淑', NULL, 'F', '2005-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(879, '經嘉', '安', NULL, 'M', '2003-04-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(880, '谷樺', '豪傑', NULL, 'M', '2005-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(881, '壽筑', '冠心', NULL, 'F', '2009-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(882, '陽志', '彥', NULL, 'M', '2008-02-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(883, '羊詩', '依嘉', NULL, 'M', '2011-02-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(884, '衡萱', '華', NULL, 'F', '2015-07-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(885, '朱哲瑋', '芳鈺', NULL, 'F', '2004-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(886, '糜君萱', '欣馨', NULL, 'M', '2015-06-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(887, '姬筑嘉', '哲', NULL, 'M', '2006-10-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(888, '邴萱心', '欣萱', NULL, 'F', '2001-03-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(889, '岑宗', '宏', NULL, 'F', '2001-01-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(890, '婁彥文', '慧', NULL, 'F', '2004-05-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(891, '督宏宜', '建心', NULL, 'F', '2013-03-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(892, '史君柏', '賢', NULL, 'F', '2012-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(893, '馬傑', '詩宗', NULL, 'M', '2015-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(894, '況安', '翰', NULL, 'F', '2003-12-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(895, '田筱萍', '詩', NULL, 'F', '2015-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(896, '符芳雅', '銘宏', NULL, 'M', '2014-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(897, '宦彥承', '樺承', NULL, 'M', '2008-04-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(898, '應傑', '婷', NULL, 'M', '2009-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(899, '聞人芬', '惠', NULL, 'F', '2000-09-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(900, '仲孫宏', '俊', NULL, 'F', '2008-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(901, '養佳', '琬', NULL, 'M', '2003-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(902, '甄心', '建', NULL, 'F', '2002-10-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(903, '閔珊', '柏', NULL, 'M', '2004-06-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(904, '褚樺', '彥', NULL, 'F', '2008-01-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(905, '福豪', '華', NULL, 'F', '2002-04-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(906, '汪琬', '雅冠', NULL, 'F', '2001-07-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(907, '梁丘心', '冠', NULL, 'M', '2013-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(908, '晁宜', '宇', NULL, 'F', '2014-01-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(909, '甯琬', '瑋', NULL, 'M', '2014-05-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(910, '沙佳', '家翰', NULL, 'M', '2002-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(911, '督冠', '安', NULL, 'M', '2008-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(912, '鮑心', '芬嘉', NULL, 'M', '2009-02-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(913, '宇文建', '彥銘', NULL, 'F', '2002-12-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(914, '晁琬欣', '佳郁', NULL, 'M', '2014-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(915, '連家', '宏', NULL, 'M', '2007-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(916, '酈安', '偉傑', NULL, 'M', '2005-08-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(917, '富庭嘉', '琬雯', NULL, 'M', '2007-09-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(918, '于華靜', '蓉', NULL, 'M', '2013-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(919, '賁思宜', '傑霖', NULL, 'M', '2004-03-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(920, '賁文', '信', NULL, 'F', '2015-04-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(921, '熊宜', '玲', NULL, 'M', '2006-02-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(922, '程宜', '淑怡', NULL, 'F', '2004-11-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(923, '文家宗', '家嘉', NULL, 'F', '2010-06-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(924, '婁依', '郁佩', NULL, 'F', '2001-11-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(925, '仇穎', '賢哲', NULL, 'F', '2010-09-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(926, '袁霖', '庭', NULL, 'M', '2002-11-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(927, '貢心安', '婉', NULL, 'F', '2010-05-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(928, '黃家珊', '萱', NULL, 'F', '2007-06-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(929, '雙穎', '筑婷', NULL, 'F', '2008-12-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(930, '羅鈺思', '承', NULL, 'M', '2001-05-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(931, '印豪建', '詩', NULL, 'M', '2009-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(932, '公西軒軒', '庭', NULL, 'F', '2009-04-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(933, '韋銘翰', '欣芳', NULL, 'F', '2012-04-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(934, '東方承瑋', '詩彥', NULL, 'M', '2005-04-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(935, '年心依', '宇宜', NULL, 'M', '2005-07-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(936, '赫連俊偉', '惠涵', NULL, 'F', '2001-01-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(937, '長孫豪', '如', NULL, 'F', '2009-05-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(938, '江霖家', '萍怡', NULL, 'F', '2015-06-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(939, '井家', '琬蓉', NULL, 'M', '2009-03-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(940, '万俟萍', '嘉', NULL, 'M', '2013-01-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(941, '封志', '華', NULL, 'F', '2015-06-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(942, '勞哲瑋', '淑穎', NULL, 'F', '2007-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(943, '祿威', '偉', NULL, 'F', '2007-04-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(944, '戚雯如', '俊信', NULL, 'M', '2000-10-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(945, '咸馨', '庭', NULL, 'F', '2002-01-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(946, '關依', '珊家', NULL, 'M', '2011-08-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(947, '滕雯', '庭', NULL, 'M', '2010-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(948, '甄萍', '宜心', NULL, 'M', '2010-03-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(949, '齊依安', '貞萍', NULL, 'M', '2001-09-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(950, '查豪', '思', NULL, 'F', '2008-01-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(951, '祁俊銘', '如', NULL, 'M', '2005-08-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(952, '燕穎惠', '俊柏', NULL, 'F', '2011-11-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(953, '鈕思', '安嘉', NULL, 'F', '2010-11-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(954, '邴華家', '如', NULL, 'M', '2015-08-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(955, '喻淑筱', '婷', NULL, 'M', '2013-12-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(956, '康庭佳', '筱瑜', NULL, 'M', '2013-07-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(957, '巫婉', '偉', NULL, 'F', '2012-08-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(958, '商心', '柏', NULL, 'M', '2009-04-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(959, '胡華', '冠芬', NULL, 'F', '2003-04-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(960, '愛霖', '傑承', NULL, 'F', '2002-09-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(961, '全馨', '娟', NULL, 'M', '2010-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(962, '印柏', '君', NULL, 'M', '2001-03-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(963, '韶冠', '儀文', NULL, 'F', '2008-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(964, '干靜芳', '涵美', NULL, 'M', '2014-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(965, '糜哲建', '偉', NULL, 'M', '2009-12-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(966, '鄭心淑', '蓉', NULL, 'M', '2000-10-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(967, '巫豪', '郁', NULL, 'M', '2011-01-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(968, '褚雯華', '宗穎', NULL, 'M', '2007-09-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(969, '談依', '怡琬', NULL, 'F', '2011-05-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(970, '賞柏', '慧如', NULL, 'F', '2002-09-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(971, '傅偉', '詩', NULL, 'F', '2001-07-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(972, '西門佳', '惠郁', NULL, 'F', '2012-03-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(973, '季宏思', '婷慧', NULL, 'M', '2007-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(974, '曹美美', '惠如', NULL, 'F', '2007-03-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(975, '向冠', '庭心', NULL, 'M', '2008-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(976, '夔穎賢', '慧', NULL, 'F', '2003-03-23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(977, '程穎', '佳宇', NULL, 'M', '2015-01-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(978, '黃建', '思筱', NULL, 'F', '2015-08-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(979, '郗冠宜', '宜豪', NULL, 'F', '2003-10-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(980, '上官宇柏', '宜君', NULL, 'M', '2013-03-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(981, '郗樺', '雅', NULL, 'F', '2006-10-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(982, '吉樺', '婷', NULL, 'F', '2015-08-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(983, '戴威', '婷珊', NULL, 'M', '2012-12-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(984, '尹貞嘉', '宏', NULL, 'F', '2004-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(985, '亓官庭宜', '靜琬', NULL, 'M', '2006-10-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(986, '宣詩', '冠', NULL, 'F', '2010-07-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(987, '懷怡', '慧欣', NULL, 'M', '2014-11-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(988, '廣哲', '美', NULL, 'M', '2000-12-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(989, '蔚心', '賢威', NULL, 'F', '2013-06-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(990, '陳玲', '美', NULL, 'F', '2006-03-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(991, '俞宗', '安', NULL, 'M', '2010-12-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(992, '鬱婷宜', '宜宗', NULL, 'M', '2003-05-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(993, '濮銘', '華', NULL, 'F', '2014-07-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(994, '童雯佩', '庭', NULL, 'M', '2015-04-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(995, '牛霖美', '嘉', NULL, 'M', '2004-12-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(996, '閭丘美', '鈺', NULL, 'F', '2001-01-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(997, '佘貞', '庭', NULL, 'M', '2015-04-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(998, '奚宇', '怡', NULL, 'F', '2002-06-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(999, '項怡筱', '瑜冠', NULL, 'F', '2004-07-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27'),
(1000, '鍾離傑', '穎詩', NULL, 'F', '2007-08-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:27', '2023-02-03 01:27:27');

-- --------------------------------------------------------

--
-- Table structure for table `student_details`
--

CREATE TABLE `student_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `holy_name` varchar(255) DEFAULT NULL,
  `baptized` date DEFAULT NULL,
  `first_communion` date DEFAULT NULL,
  `past_entry_grade` varchar(255) DEFAULT NULL,
  `past_entry_date` date DEFAULT NULL,
  `past_grade` varchar(255) DEFAULT NULL,
  `valid_stay` date DEFAULT NULL,
  `sibling` int(11) DEFAULT NULL,
  `sibling_at_work` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_gardians`
--

CREATE TABLE `student_gardians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `gardian_id` bigint(20) NOT NULL,
  `relation` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studies`
--

CREATE TABLE `studies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` int(11) NOT NULL,
  `title_zh` varchar(255) NOT NULL,
  `title_en` varchar(255) NOT NULL,
  `stream` varchar(255) NOT NULL,
  `grade` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `studies`
--

INSERT INTO `studies` (`id`, `version`, `title_zh`, `title_en`, `stream`, `grade`, `active`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, '小學全科', '小學全科', 'ALL', 'P', 1, NULL, '2023-02-06 01:27:17', '2023-02-06 18:51:32'),
(2, 1, '初中文科', '初中文科', 'ART', 'S', 1, NULL, '2023-02-06 17:50:56', '2023-02-06 17:50:56'),
(3, 1, '高中理科', '高中理科', 'ALL', 'S', 1, NULL, '2023-02-06 17:51:20', '2023-02-06 17:51:20');

-- --------------------------------------------------------

--
-- Table structure for table `study_subject`
--

CREATE TABLE `study_subject` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `study_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_subject`
--

INSERT INTO `study_subject` (`id`, `study_id`, `subject_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 1, 2, NULL, NULL),
(3, 1, 3, NULL, NULL),
(4, 1, 4, NULL, NULL),
(5, 1, 5, NULL, NULL),
(6, 1, 6, NULL, NULL),
(7, 1, 7, NULL, NULL),
(8, 1, 8, NULL, NULL),
(9, 1, 9, NULL, NULL),
(10, 1, 10, NULL, NULL),
(11, 1, 11, NULL, NULL),
(12, 1, 12, NULL, NULL),
(13, 1, 13, NULL, NULL),
(14, 1, 14, NULL, NULL),
(15, 1, 15, NULL, NULL),
(16, 1, 16, NULL, NULL),
(17, 1, 17, NULL, NULL),
(18, 1, 18, NULL, NULL),
(19, 1, 19, NULL, NULL),
(20, 1, 20, NULL, NULL),
(21, 1, 21, NULL, NULL),
(22, 1, 22, NULL, NULL),
(23, 1, 23, NULL, NULL),
(24, 1, 24, NULL, NULL),
(25, 1, 25, NULL, NULL),
(26, 1, 26, NULL, NULL),
(27, 1, 27, NULL, NULL),
(28, 1, 28, NULL, NULL),
(29, 1, 29, NULL, NULL),
(30, 1, 30, NULL, NULL),
(31, 1, 31, NULL, NULL),
(32, 1, 32, NULL, NULL),
(33, 1, 33, NULL, NULL),
(34, 1, 34, NULL, NULL),
(35, 1, 35, NULL, NULL),
(36, 1, 36, NULL, NULL),
(37, 1, 37, NULL, NULL),
(38, 1, 38, NULL, NULL),
(39, 1, 39, NULL, NULL),
(40, 1, 40, NULL, NULL),
(41, 2, 1, NULL, NULL),
(42, 2, 2, NULL, NULL),
(43, 2, 3, NULL, NULL),
(44, 2, 4, NULL, NULL),
(45, 2, 5, NULL, NULL),
(46, 2, 6, NULL, NULL),
(47, 2, 7, NULL, NULL),
(48, 2, 8, NULL, NULL),
(49, 2, 9, NULL, NULL),
(50, 2, 10, NULL, NULL),
(51, 2, 11, NULL, NULL),
(52, 2, 12, NULL, NULL),
(53, 2, 13, NULL, NULL),
(54, 2, 14, NULL, NULL),
(55, 2, 15, NULL, NULL),
(56, 2, 16, NULL, NULL),
(57, 2, 17, NULL, NULL),
(58, 2, 18, NULL, NULL),
(59, 2, 19, NULL, NULL),
(60, 2, 20, NULL, NULL),
(61, 2, 21, NULL, NULL),
(62, 2, 22, NULL, NULL),
(63, 2, 23, NULL, NULL),
(64, 2, 24, NULL, NULL),
(65, 2, 25, NULL, NULL),
(66, 2, 26, NULL, NULL),
(67, 2, 27, NULL, NULL),
(68, 2, 28, NULL, NULL),
(69, 2, 29, NULL, NULL),
(70, 2, 30, NULL, NULL),
(71, 2, 31, NULL, NULL),
(72, 2, 32, NULL, NULL),
(73, 2, 33, NULL, NULL),
(74, 2, 34, NULL, NULL),
(75, 2, 35, NULL, NULL),
(76, 2, 36, NULL, NULL),
(77, 2, 37, NULL, NULL),
(78, 2, 38, NULL, NULL),
(79, 2, 39, NULL, NULL),
(80, 2, 40, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grade_id` bigint(20) NOT NULL,
  `category` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `stream` varchar(6) DEFAULT NULL,
  `elective` varchar(6) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `study_id` bigint(20) DEFAULT NULL,
  `score_column_template` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `grade_id`, `category`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `description`, `active`, `study_id`, `score_column_template`, `version`, `created_at`, `updated_at`) VALUES
(1, 1, 'SUBJECT', 'REL', '宗教', 'Relegion', 'SUB', 'LIB', '1', NULL, 1, 1, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(2, 1, 'SUBJECT', 'PHY', '體能', 'Physic', 'SUB', 'LIB', '1', NULL, 1, 2, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(3, 1, 'SUBJECT', 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', '1', NULL, 1, 3, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(4, 1, 'SUBJECT', 'STY', '故事', 'Stry', 'SUB', 'LIB', '1', NULL, 1, 4, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(5, 1, 'SUBJECT', 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', '1', NULL, 1, 5, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(6, 1, 'SUBJECT', 'ELT', '英文', 'English Literature', 'SUB', 'LIB', '1', NULL, 1, 6, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(7, 1, 'SUBJECT', 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', '1', NULL, 1, 7, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(8, 1, 'SUBJECT', 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', '1', NULL, 1, 8, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(9, 1, 'SUBJECT', 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', '1', NULL, 1, 9, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(10, 1, 'SUBJECT', 'COM', '電腦', 'Computer', 'SUB', 'LIB', '1', NULL, 1, 10, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(11, 1, 'SUBJECT', 'PLA', '唱遊', 'Playgroup', 'SUB', 'LIB', '1', NULL, 1, 11, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(12, 1, 'SUBJECT', 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', '1', NULL, 1, 12, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(13, 1, 'ATTITUDE', 'health_1', '衣服鞋襪整齊清潔', NULL, 'ATT', 'LIB', '1', NULL, 1, 13, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(14, 1, 'ATTITUDE', 'health_2', '常剪指甲', NULL, 'ATT', 'LIB', '1', NULL, 1, 14, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(15, 1, 'ATTITUDE', 'health_3', '懂得使用手帕或紙巾', NULL, 'ATT', 'LIB', '1', NULL, 1, 15, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(16, 1, 'ATTITUDE', 'health_4', '不把手指雜物放進口裡', NULL, 'ATT', 'LIB', '1', NULL, 1, 16, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(17, 1, 'ATTITUDE', 'health_5', '能把癈物投入廢紙箱內', NULL, 'ATT', 'LIB', '1', NULL, 1, 17, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(18, 1, 'ATTITUDE', 'behaviour_1', '守秩序不喧嚷', NULL, 'ATT', 'LIB', '1', NULL, 1, 18, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(19, 1, 'ATTITUDE', 'behaviour_2', '留心聽講', NULL, 'ATT', 'LIB', '1', NULL, 1, 19, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(20, 1, 'ATTITUDE', 'behaviour_3', '坐立行走姿勢正確', NULL, 'ATT', 'LIB', '1', NULL, 1, 20, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(21, 1, 'ATTITUDE', 'behaviour_4', '離開坐位把物件桌椅整理好', NULL, 'ATT', 'LIB', '1', NULL, 1, 21, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(22, 1, 'ATTITUDE', 'behaviour_5', '愛護公物用後放回原處', NULL, 'ATT', 'LIB', '1', NULL, 1, 22, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(23, 1, 'ATTITUDE', 'behaviour_6', '遵守校規', NULL, 'ATT', 'LIB', '1', NULL, 1, 23, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(24, 1, 'ATTITUDE', 'social_1', '守時', NULL, 'ATT', 'LIB', '1', NULL, 1, 24, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(25, 1, 'ATTITUDE', 'social_2', '尊敬師長,友愛和睦', NULL, 'ATT', 'LIB', '1', NULL, 1, 25, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(26, 1, 'ATTITUDE', 'social_3', '樂於助人', NULL, 'ATT', 'LIB', '1', NULL, 1, 26, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(27, 1, 'ATTITUDE', 'social_4', '會和別人分享及輪侯', NULL, 'ATT', 'LIB', '1', NULL, 1, 27, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(28, 1, 'ATTITUDE', 'social_5', '誠實坦白肯認錯', NULL, 'ATT', 'LIB', '1', NULL, 1, 28, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(29, 1, 'SUMMARY', 'total_score', '總分', NULL, 'SUM', 'LIB', '1', NULL, 1, 29, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(30, 1, 'SUMMARY', 'average_score', '平均分', NULL, 'SUM', 'LIB', '1', NULL, 1, 30, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(31, 1, 'SUMMARY', 'class_size', '全班人數', NULL, 'SUM', 'LIB', '1', NULL, 1, 31, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(32, 1, 'SUMMARY', 'ranking', '考列名次', NULL, 'SUM', 'LIB', '1', NULL, 1, 32, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(33, 1, 'SUMMARY', 'late', '遲到次數', NULL, 'SUM', 'LIB', '1', NULL, 1, 33, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(34, 1, 'SUMMARY', 'absent', '缺席節數', NULL, 'SUM', 'LIB', '1', NULL, 1, 34, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(35, 1, 'GENERAL', 'comment', '評語', NULL, 'GEN', 'LIB', '1', NULL, 1, 35, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(36, 1, 'GENERAL', 'reward_punishment', '奬懲記錄', NULL, 'GEN', 'LIB', '1', NULL, 1, 36, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(37, 1, 'GENERAL', 'leisure_name', '餘暇活動名稱', NULL, 'GEN', 'LIB', '1', NULL, 1, 37, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(38, 1, 'GENERAL', 'leisure_performance', '餘暇活動表現', NULL, 'GEN', 'LIB', '1', NULL, 1, 38, 'TERMS', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(39, 1, 'GENERAL', 'remark', '備註', NULL, 'GEN', 'LIB', '1', NULL, 1, 39, 'COMMENT', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18'),
(40, 1, 'GENERAL', 'appraisal', '學年評定', NULL, 'GEN', 'LIB', '1', NULL, 1, 40, 'COMMENT', 1, '2023-02-05 22:37:18', '2023-02-05 22:37:18');

-- --------------------------------------------------------

--
-- Table structure for table `subject_templates`
--

CREATE TABLE `subject_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `stream` varchar(6) DEFAULT NULL,
  `elective` varchar(6) DEFAULT NULL,
  `grades` varchar(255) NOT NULL DEFAULT '[]',
  `description` text DEFAULT NULL,
  `score_template_batch` varchar(255) DEFAULT NULL,
  `version` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subject_templates`
--

INSERT INTO `subject_templates` (`id`, `category`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `grades`, `description`, `score_template_batch`, `version`, `active`, `created_at`, `updated_at`) VALUES
(1, 'SUBJECT', 'REL', '宗教', 'Relegion', 'SUB', 'AAS', 'COP', '[]', '1', 'SUB', '1', 1, NULL, '2023-02-07 01:41:09'),
(2, 'SUBJECT', 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:51:50'),
(3, 'SUBJECT', 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:52:31'),
(4, 'SUBJECT', 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:52:40'),
(5, 'SUBJECT', 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 19:52:54'),
(6, 'SUBJECT', 'ELT', '英文', 'English Literature', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:00:40'),
(7, 'SUBJECT', 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:00:49'),
(8, 'SUBJECT', 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:02'),
(9, 'SUBJECT', 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:11'),
(10, 'SUBJECT', 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:19'),
(11, 'SUBJECT', 'PLA', '唱遊', 'Playgroup', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:38'),
(12, 'SUBJECT', 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', '[]', NULL, 'SUB', '1', 1, NULL, '2023-02-05 20:01:50'),
(13, 'ATTITUDE', 'health_1', '衣服鞋襪整齊清潔', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(14, 'ATTITUDE', 'health_2', '常剪指甲', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(15, 'ATTITUDE', 'health_3', '懂得使用手帕或紙巾', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(16, 'ATTITUDE', 'health_4', '不把手指雜物放進口裡', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(17, 'ATTITUDE', 'health_5', '能把癈物投入廢紙箱內', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(18, 'ATTITUDE', 'behaviour_1', '守秩序不喧嚷', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(19, 'ATTITUDE', 'behaviour_2', '留心聽講', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(20, 'ATTITUDE', 'behaviour_3', '坐立行走姿勢正確', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(21, 'ATTITUDE', 'behaviour_4', '離開坐位把物件桌椅整理好', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(22, 'ATTITUDE', 'behaviour_5', '愛護公物用後放回原處', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(23, 'ATTITUDE', 'behaviour_6', '遵守校規', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(24, 'ATTITUDE', 'social_1', '守時', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(25, 'ATTITUDE', 'social_2', '尊敬師長,友愛和睦', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(26, 'ATTITUDE', 'social_3', '樂於助人', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(27, 'ATTITUDE', 'social_4', '會和別人分享及輪侯', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(28, 'ATTITUDE', 'social_5', '誠實坦白肯認錯', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(29, 'SUMMARY', 'total_score', '總分', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(30, 'SUMMARY', 'average_score', '平均分', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(31, 'SUMMARY', 'class_size', '全班人數', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(32, 'SUMMARY', 'ranking', '考列名次', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(33, 'SUMMARY', 'late', '遲到次數', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(34, 'SUMMARY', 'absent', '缺席節數', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(35, 'GENERAL', 'comment', '評語', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(36, 'GENERAL', 'reward_punishment', '奬懲記錄', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(37, 'GENERAL', 'leisure_name', '餘暇活動名稱', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(38, 'GENERAL', 'leisure_performance', '餘暇活動表現', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(39, 'GENERAL', 'remark', '備註', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL),
(40, 'GENERAL', 'appraisal', '學年評定', NULL, NULL, NULL, NULL, '[]', NULL, NULL, '1', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `categories` varchar(255) NOT NULL,
  `registed_date` date NOT NULL,
  `disproved_date` date NOT NULL,
  `remark` text NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `staff_id` bigint(20) NOT NULL,
  `subject_area` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `code`, `staff_id`, `subject_area`, `created_at`, `updated_at`) VALUES
(1, NULL, 30, NULL, NULL, NULL),
(2, NULL, 31, NULL, NULL, NULL),
(3, NULL, 32, NULL, NULL, NULL),
(4, NULL, 33, NULL, NULL, NULL),
(5, NULL, 34, NULL, NULL, NULL),
(6, NULL, 35, NULL, NULL, NULL),
(7, NULL, 36, NULL, NULL, NULL),
(8, NULL, 37, NULL, NULL, NULL),
(9, NULL, 38, NULL, NULL, NULL),
(10, NULL, 39, NULL, NULL, NULL),
(11, NULL, 40, NULL, NULL, NULL),
(12, NULL, 41, NULL, NULL, NULL),
(13, NULL, 42, NULL, NULL, NULL),
(14, NULL, 43, NULL, NULL, NULL),
(15, NULL, 44, NULL, NULL, NULL),
(16, NULL, 45, NULL, NULL, NULL),
(17, NULL, 46, NULL, NULL, NULL),
(18, NULL, 47, NULL, NULL, NULL),
(19, NULL, 48, NULL, NULL, NULL),
(20, NULL, 49, NULL, NULL, NULL),
(21, NULL, 50, NULL, NULL, NULL),
(22, NULL, 51, NULL, NULL, NULL),
(23, NULL, 52, NULL, NULL, NULL),
(24, NULL, 53, NULL, NULL, NULL),
(25, NULL, 54, NULL, NULL, NULL),
(26, NULL, 55, NULL, NULL, NULL),
(27, NULL, 56, NULL, NULL, NULL),
(28, NULL, 57, NULL, NULL, NULL),
(29, NULL, 58, NULL, NULL, NULL),
(30, NULL, 59, NULL, NULL, NULL),
(31, NULL, 60, NULL, NULL, NULL),
(32, NULL, 61, NULL, NULL, NULL),
(33, NULL, 62, NULL, NULL, NULL),
(34, NULL, 63, NULL, NULL, NULL),
(35, NULL, 64, NULL, NULL, NULL),
(36, NULL, 65, NULL, NULL, NULL),
(37, NULL, 66, NULL, NULL, NULL),
(38, NULL, 67, NULL, NULL, NULL),
(39, NULL, 68, NULL, NULL, NULL),
(40, NULL, 69, NULL, NULL, NULL),
(41, NULL, 70, NULL, NULL, NULL),
(42, NULL, 71, NULL, NULL, NULL),
(43, NULL, 72, NULL, NULL, NULL),
(44, NULL, 73, NULL, NULL, NULL),
(45, NULL, 74, NULL, NULL, NULL),
(46, NULL, 75, NULL, NULL, NULL),
(47, NULL, 76, NULL, NULL, NULL),
(48, NULL, 77, NULL, NULL, NULL),
(49, NULL, 78, NULL, NULL, NULL),
(50, NULL, 79, NULL, NULL, NULL),
(51, NULL, 80, NULL, NULL, NULL),
(52, NULL, 81, NULL, NULL, NULL),
(53, NULL, 82, NULL, NULL, NULL),
(54, NULL, 83, NULL, NULL, NULL),
(55, NULL, 84, NULL, NULL, NULL),
(56, NULL, 85, NULL, NULL, NULL),
(57, NULL, 86, NULL, NULL, NULL),
(58, NULL, 87, NULL, NULL, NULL),
(59, NULL, 88, NULL, NULL, NULL),
(60, NULL, 89, NULL, NULL, NULL),
(61, NULL, 90, NULL, NULL, NULL),
(62, NULL, 91, NULL, NULL, NULL),
(63, NULL, 92, NULL, NULL, NULL),
(64, NULL, 93, NULL, NULL, NULL),
(65, NULL, 94, NULL, NULL, NULL),
(66, NULL, 95, NULL, NULL, NULL),
(67, NULL, 96, NULL, NULL, NULL),
(68, NULL, 97, NULL, NULL, NULL),
(69, NULL, 98, NULL, NULL, NULL),
(70, NULL, 99, NULL, NULL, NULL),
(71, NULL, 100, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `personal_team` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `user_id`, `name`, `personal_team`, `created_at`, `updated_at`) VALUES
(1, 1, 'Master\'s Team', 1, '2023-02-03 01:27:30', '2023-02-03 01:27:30'),
(2, 2, 'Admin\'s Team', 1, '2023-02-03 01:27:30', '2023-02-03 01:27:30');

-- --------------------------------------------------------

--
-- Table structure for table `team_invitations`
--

CREATE TABLE `team_invitations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `team_id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_user`
--

CREATE TABLE `team_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `team_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transcripts`
--

CREATE TABLE `transcripts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `column` enum('PSN','T1','T2','T3','T4','T1E','T1P','T1A','T2E','T2P','T2A','T3E','T3P','T3A','T4E','T4P','T4A','FIN') NOT NULL,
  `category` enum('PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL') NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transcripts`
--

INSERT INTO `transcripts` (`id`, `klass_student_id`, `column`, `category`, `field_name`, `field_value`, `version`, `created_at`, `updated_at`) VALUES
(1, 1, 'T1', 'PERSONAL', 'name_ch', 'TEST name_ch', 1, NULL, NULL),
(2, 1, 'T1', 'PERSONAL', 'name_fn', 'TEST name_fn', 1, NULL, NULL),
(3, 1, 'T1', 'PERSONAL', 'academic_year', 'TEST academic_year', 1, NULL, NULL),
(4, 1, 'T1', 'PERSONAL', 'grade_class', 'TEST grade_class', 1, NULL, NULL),
(5, 1, 'T1', 'PERSONAL', 'student_number', 'TEST student_number', 1, NULL, NULL),
(6, 1, 'T1', 'PERSONAL', 'id_number', 'TEST id_number', 1, NULL, NULL),
(7, 1, 'T1', 'PERSONAL', 'issue_date', 'TEST issue_date', 1, NULL, NULL),
(8, 1, 'T1E', 'SUBJECT', 'religion', '55', 1, NULL, NULL),
(9, 1, 'T1E', 'SUBJECT', 'chinese_literature', '80', 1, NULL, NULL),
(10, 1, 'T1E', 'SUBJECT', 'common_sense', '85', 1, NULL, NULL),
(11, 1, 'T1E', 'SUBJECT', 'story', '18', 1, NULL, NULL),
(12, 1, 'T1E', 'SUBJECT', 'chinese_writing', '22', 1, NULL, NULL),
(13, 1, 'T1E', 'SUBJECT', 'numeracy', '74', 1, NULL, NULL),
(14, 1, 'T1E', 'SUBJECT', 'english_reading', '14', 1, NULL, NULL),
(15, 1, 'T1E', 'SUBJECT', 'english_writing', '8', 1, NULL, NULL),
(16, 1, 'T1E', 'SUBJECT', 'computer', '27', 1, NULL, NULL),
(17, 1, 'T1E', 'SUBJECT', 'mandarin', '83', 1, NULL, NULL),
(18, 1, 'T1E', 'SUBJECT', 'art_craft', '7', 1, NULL, NULL),
(19, 1, 'T1E', 'SUBJECT', 'playgroup', '60', 1, NULL, NULL),
(20, 1, 'T1E', 'SUBJECT', 'physical_fitness', '85', 1, NULL, NULL),
(21, 1, 'T1P', 'SUBJECT', 'religion', '33', 1, NULL, NULL),
(22, 1, 'T1P', 'SUBJECT', 'chinese_literature', '26', 1, NULL, NULL),
(23, 1, 'T1P', 'SUBJECT', 'common_sense', '79', 1, NULL, NULL),
(24, 1, 'T1P', 'SUBJECT', 'story', '34', 1, NULL, NULL),
(25, 1, 'T1P', 'SUBJECT', 'chinese_writing', '59', 1, NULL, NULL),
(26, 1, 'T1P', 'SUBJECT', 'numeracy', '54', 1, NULL, NULL),
(27, 1, 'T1P', 'SUBJECT', 'english_reading', '12', 1, NULL, NULL),
(28, 1, 'T1P', 'SUBJECT', 'english_writing', '37', 1, NULL, NULL),
(29, 1, 'T1P', 'SUBJECT', 'computer', '70', 1, NULL, NULL),
(30, 1, 'T1P', 'SUBJECT', 'mandarin', '5', 1, NULL, NULL),
(31, 1, 'T1P', 'SUBJECT', 'art_craft', '92', 1, NULL, NULL),
(32, 1, 'T1P', 'SUBJECT', 'playgroup', '54', 1, NULL, NULL),
(33, 1, 'T1P', 'SUBJECT', 'physical_fitness', '55', 1, NULL, NULL),
(34, 1, 'T1A', 'SUBJECT', 'religion', '10', 1, NULL, NULL),
(35, 1, 'T1A', 'SUBJECT', 'chinese_literature', '22', 1, NULL, NULL),
(36, 1, 'T1A', 'SUBJECT', 'common_sense', '71', 1, NULL, NULL),
(37, 1, 'T1A', 'SUBJECT', 'story', '78', 1, NULL, NULL),
(38, 1, 'T1A', 'SUBJECT', 'chinese_writing', '55', 1, NULL, NULL),
(39, 1, 'T1A', 'SUBJECT', 'numeracy', '71', 1, NULL, NULL),
(40, 1, 'T1A', 'SUBJECT', 'english_reading', '22', 1, NULL, NULL),
(41, 1, 'T1A', 'SUBJECT', 'english_writing', '53', 1, NULL, NULL),
(42, 1, 'T1A', 'SUBJECT', 'computer', '50', 1, NULL, NULL),
(43, 1, 'T1A', 'SUBJECT', 'mandarin', '83', 1, NULL, NULL),
(44, 1, 'T1A', 'SUBJECT', 'art_craft', '26', 1, NULL, NULL),
(45, 1, 'T1A', 'SUBJECT', 'playgroup', '36', 1, NULL, NULL),
(46, 1, 'T1A', 'SUBJECT', 'physical_fitness', '48', 1, NULL, NULL),
(47, 1, 'T2E', 'SUBJECT', 'religion', '36', 1, NULL, NULL),
(48, 1, 'T2E', 'SUBJECT', 'chinese_literature', '92', 1, NULL, NULL),
(49, 1, 'T2E', 'SUBJECT', 'common_sense', '74', 1, NULL, NULL),
(50, 1, 'T2E', 'SUBJECT', 'story', '11', 1, NULL, NULL),
(51, 1, 'T2E', 'SUBJECT', 'chinese_writing', '98', 1, NULL, NULL),
(52, 1, 'T2E', 'SUBJECT', 'numeracy', '67', 1, NULL, NULL),
(53, 1, 'T2E', 'SUBJECT', 'english_reading', '22', 1, NULL, NULL),
(54, 1, 'T2E', 'SUBJECT', 'english_writing', '50', 1, NULL, NULL),
(55, 1, 'T2E', 'SUBJECT', 'computer', '23', 1, NULL, NULL),
(56, 1, 'T2E', 'SUBJECT', 'mandarin', '33', 1, NULL, NULL),
(57, 1, 'T2E', 'SUBJECT', 'art_craft', '17', 1, NULL, NULL),
(58, 1, 'T2E', 'SUBJECT', 'playgroup', '51', 1, NULL, NULL),
(59, 1, 'T2E', 'SUBJECT', 'physical_fitness', '52', 1, NULL, NULL),
(60, 1, 'T2P', 'SUBJECT', 'religion', '86', 1, NULL, NULL),
(61, 1, 'T2P', 'SUBJECT', 'chinese_literature', '80', 1, NULL, NULL),
(62, 1, 'T2P', 'SUBJECT', 'common_sense', '26', 1, NULL, NULL),
(63, 1, 'T2P', 'SUBJECT', 'story', '60', 1, NULL, NULL),
(64, 1, 'T2P', 'SUBJECT', 'chinese_writing', '52', 1, NULL, NULL),
(65, 1, 'T2P', 'SUBJECT', 'numeracy', '18', 1, NULL, NULL),
(66, 1, 'T2P', 'SUBJECT', 'english_reading', '80', 1, NULL, NULL),
(67, 1, 'T2P', 'SUBJECT', 'english_writing', '32', 1, NULL, NULL),
(68, 1, 'T2P', 'SUBJECT', 'computer', '67', 1, NULL, NULL),
(69, 1, 'T2P', 'SUBJECT', 'mandarin', '18', 1, NULL, NULL),
(70, 1, 'T2P', 'SUBJECT', 'art_craft', '85', 1, NULL, NULL),
(71, 1, 'T2P', 'SUBJECT', 'playgroup', '60', 1, NULL, NULL),
(72, 1, 'T2P', 'SUBJECT', 'physical_fitness', '23', 1, NULL, NULL),
(73, 1, 'T2A', 'SUBJECT', 'religion', '7', 1, NULL, NULL),
(74, 1, 'T2A', 'SUBJECT', 'chinese_literature', '34', 1, NULL, NULL),
(75, 1, 'T2A', 'SUBJECT', 'common_sense', '43', 1, NULL, NULL),
(76, 1, 'T2A', 'SUBJECT', 'story', '100', 1, NULL, NULL),
(77, 1, 'T2A', 'SUBJECT', 'chinese_writing', '3', 1, NULL, NULL),
(78, 1, 'T2A', 'SUBJECT', 'numeracy', '18', 1, NULL, NULL),
(79, 1, 'T2A', 'SUBJECT', 'english_reading', '6', 1, NULL, NULL),
(80, 1, 'T2A', 'SUBJECT', 'english_writing', '53', 1, NULL, NULL),
(81, 1, 'T2A', 'SUBJECT', 'computer', '27', 1, NULL, NULL),
(82, 1, 'T2A', 'SUBJECT', 'mandarin', '27', 1, NULL, NULL),
(83, 1, 'T2A', 'SUBJECT', 'art_craft', '54', 1, NULL, NULL),
(84, 1, 'T2A', 'SUBJECT', 'playgroup', '15', 1, NULL, NULL),
(85, 1, 'T2A', 'SUBJECT', 'physical_fitness', '55', 1, NULL, NULL),
(86, 1, 'FIN', 'SUBJECT', 'religion', '73', 1, NULL, NULL),
(87, 1, 'FIN', 'SUBJECT', 'chinese_literature', '67', 1, NULL, NULL),
(88, 1, 'FIN', 'SUBJECT', 'common_sense', '75', 1, NULL, NULL),
(89, 1, 'FIN', 'SUBJECT', 'story', '96', 1, NULL, NULL),
(90, 1, 'FIN', 'SUBJECT', 'chinese_writing', '94', 1, NULL, NULL),
(91, 1, 'FIN', 'SUBJECT', 'numeracy', '73', 1, NULL, NULL),
(92, 1, 'FIN', 'SUBJECT', 'english_reading', '56', 1, NULL, NULL),
(93, 1, 'FIN', 'SUBJECT', 'english_writing', '69', 1, NULL, NULL),
(94, 1, 'FIN', 'SUBJECT', 'computer', '72', 1, NULL, NULL),
(95, 1, 'FIN', 'SUBJECT', 'mandarin', '87', 1, NULL, NULL),
(96, 1, 'FIN', 'SUBJECT', 'art_craft', '81', 1, NULL, NULL),
(97, 1, 'FIN', 'SUBJECT', 'playgroup', '66', 1, NULL, NULL),
(98, 1, 'FIN', 'SUBJECT', 'physical_fitness', '95', 1, NULL, NULL),
(99, 1, 'T1', 'ATTITUDE', 'health_1', 'A', 1, NULL, NULL),
(100, 1, 'T1', 'ATTITUDE', 'health_2', 'A', 1, NULL, NULL),
(101, 1, 'T1', 'ATTITUDE', 'health_3', 'A', 1, NULL, NULL),
(102, 1, 'T1', 'ATTITUDE', 'health_4', 'A', 1, NULL, NULL),
(103, 1, 'T1', 'ATTITUDE', 'health_5', 'A', 1, NULL, NULL),
(104, 1, 'T1', 'ATTITUDE', 'behaviour_1', 'A', 1, NULL, NULL),
(105, 1, 'T1', 'ATTITUDE', 'behaviour_2', 'A', 1, NULL, NULL),
(106, 1, 'T1', 'ATTITUDE', 'behaviour_3', 'A', 1, NULL, NULL),
(107, 1, 'T1', 'ATTITUDE', 'behaviour_4', 'A', 1, NULL, NULL),
(108, 1, 'T1', 'ATTITUDE', 'behaviour_5', 'A', 1, NULL, NULL),
(109, 1, 'T1', 'ATTITUDE', 'behaviour_6', 'A', 1, NULL, NULL),
(110, 1, 'T1', 'ATTITUDE', 'social_1', 'A', 1, NULL, NULL),
(111, 1, 'T1', 'ATTITUDE', 'social_2', 'A', 1, NULL, NULL),
(112, 1, 'T1', 'ATTITUDE', 'social_3', 'A', 1, NULL, NULL),
(113, 1, 'T1', 'ATTITUDE', 'social_4', 'A', 1, NULL, NULL),
(114, 1, 'T1', 'ATTITUDE', 'social_5', 'A', 1, NULL, NULL),
(115, 1, 'T2', 'ATTITUDE', 'health_1', 'B', 1, NULL, NULL),
(116, 1, 'T2', 'ATTITUDE', 'health_2', 'B', 1, NULL, NULL),
(117, 1, 'T2', 'ATTITUDE', 'health_3', 'B', 1, NULL, NULL),
(118, 1, 'T2', 'ATTITUDE', 'health_4', 'B', 1, NULL, NULL),
(119, 1, 'T2', 'ATTITUDE', 'health_5', 'B', 1, NULL, NULL),
(120, 1, 'T2', 'ATTITUDE', 'behaviour_1', 'B', 1, NULL, NULL),
(121, 1, 'T2', 'ATTITUDE', 'behaviour_2', 'B', 1, NULL, NULL),
(122, 1, 'T2', 'ATTITUDE', 'behaviour_3', 'B', 1, NULL, NULL),
(123, 1, 'T2', 'ATTITUDE', 'behaviour_4', 'B', 1, NULL, NULL),
(124, 1, 'T2', 'ATTITUDE', 'behaviour_5', 'B', 1, NULL, NULL),
(125, 1, 'T2', 'ATTITUDE', 'behaviour_6', 'B', 1, NULL, NULL),
(126, 1, 'T2', 'ATTITUDE', 'social_1', 'B', 1, NULL, NULL),
(127, 1, 'T2', 'ATTITUDE', 'social_2', 'B', 1, NULL, NULL),
(128, 1, 'T2', 'ATTITUDE', 'social_3', 'B', 1, NULL, NULL),
(129, 1, 'T2', 'ATTITUDE', 'social_4', 'B', 1, NULL, NULL),
(130, 1, 'T2', 'ATTITUDE', 'social_5', 'B', 1, NULL, NULL),
(131, 1, 'T1', 'SUMMARY', 'total_score', '100', 1, NULL, NULL),
(132, 1, 'T1', 'SUMMARY', 'average_score', '72', 1, NULL, NULL),
(133, 1, 'T1', 'SUMMARY', 'class_size', '87', 1, NULL, NULL),
(134, 1, 'T1', 'SUMMARY', 'ranking', '97', 1, NULL, NULL),
(135, 1, 'T1', 'SUMMARY', 'late', '91', 1, NULL, NULL),
(136, 1, 'T1', 'SUMMARY', 'absent', '4', 1, NULL, NULL),
(137, 1, 'T2', 'SUMMARY', 'total_score', '41', 1, NULL, NULL),
(138, 1, 'T2', 'SUMMARY', 'average_score', '9', 1, NULL, NULL),
(139, 1, 'T2', 'SUMMARY', 'class_size', '14', 1, NULL, NULL),
(140, 1, 'T2', 'SUMMARY', 'ranking', '39', 1, NULL, NULL),
(141, 1, 'T2', 'SUMMARY', 'late', '9', 1, NULL, NULL),
(142, 1, 'T2', 'SUMMARY', 'absent', '71', 1, NULL, NULL),
(143, 1, 'FIN', 'SUMMARY', 'total_score', '24', 1, NULL, NULL),
(144, 1, 'FIN', 'SUMMARY', 'average_score', '95', 1, NULL, NULL),
(145, 1, 'FIN', 'SUMMARY', 'class_size', '48', 1, NULL, NULL),
(146, 1, 'FIN', 'SUMMARY', 'ranking', '100', 1, NULL, NULL),
(147, 1, 'FIN', 'SUMMARY', 'late', '50', 1, NULL, NULL),
(148, 1, 'FIN', 'SUMMARY', 'absent', '96', 1, NULL, NULL),
(149, 1, 'T1', 'GENERAL', 'comment', 'T1 Comment', 1, NULL, NULL),
(150, 1, 'T2', 'GENERAL', 'comment', 'T2 Coment', 1, NULL, NULL),
(151, 1, 'T1', 'GENERAL', 'reward_punishment', 'T1 reward punishment', 1, NULL, NULL),
(152, 1, 'T2', 'GENERAL', 'reward_punishment', 'T2 reward punishment', 1, NULL, NULL),
(153, 1, 'T1', 'GENERAL', 'leisure_name', 'T1 leisure name', 1, NULL, NULL),
(154, 1, 'T2', 'GENERAL', 'leisure_name', 'T2 leisure name', 1, NULL, NULL),
(155, 1, 'T1', 'GENERAL', 'leisure_performance', 'T1 leisure performance', 1, NULL, NULL),
(156, 1, 'T2', 'GENERAL', 'leisure_performance', 'T2 leisure performance', 1, NULL, NULL),
(157, 1, 'T1', 'GENERAL', 'remark', 'T1 remark', 1, NULL, NULL),
(158, 1, 'T2', 'GENERAL', 'remark', 'T2 remark', 1, NULL, NULL),
(159, 1, 'FIN', 'GENERAL', 'remark', 'FIN remark', 1, NULL, NULL),
(160, 1, 'FIN', 'GENERAL', 'appraisal', 'FIN Appraisal', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transcript_templates`
--

CREATE TABLE `transcript_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` enum('PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL') NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `subject_code` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transcript_templates`
--

INSERT INTO `transcript_templates` (`id`, `category`, `field_name`, `title_zh`, `title_en`, `remark`, `subject_code`, `version`, `created_at`, `updated_at`) VALUES
(1, 'PERSONAL', 'name_ch', '姓名中文', NULL, NULL, '', 1, NULL, NULL),
(2, 'PERSONAL', 'name_fn', '姓名外文', NULL, NULL, '', 1, NULL, NULL),
(3, 'PERSONAL', 'academic_year', '年度', NULL, NULL, '', 1, NULL, NULL),
(4, 'PERSONAL', 'grade_class', '級別', NULL, NULL, '', 1, NULL, NULL),
(5, 'PERSONAL', 'student_number', '學生證編號', NULL, NULL, '', 1, NULL, NULL),
(6, 'PERSONAL', 'id_number', '身份證編號', NULL, NULL, '', 1, NULL, NULL),
(7, 'PERSONAL', 'issue_date', '簽發日期', NULL, NULL, '', 1, NULL, NULL),
(8, 'SUBJECT', 'religion', '宗教', NULL, NULL, '', 1, NULL, NULL),
(9, 'SUBJECT', 'chinese_literature', '語文', NULL, NULL, '', 1, NULL, NULL),
(10, 'SUBJECT', 'common_sense', '常識', NULL, NULL, '', 1, NULL, NULL),
(11, 'SUBJECT', 'story', '故事', NULL, NULL, '', 1, NULL, NULL),
(12, 'SUBJECT', 'chinese_writing', '中寫', NULL, NULL, '', 1, NULL, NULL),
(13, 'SUBJECT', 'numeracy', '識數', NULL, NULL, '', 1, NULL, NULL),
(14, 'SUBJECT', 'english_reading', '英文', NULL, NULL, '', 1, NULL, '2023-02-05 20:00:10'),
(15, 'SUBJECT', 'english_writing', '英寫', NULL, NULL, '', 1, NULL, NULL),
(16, 'SUBJECT', 'computer', '電腦', NULL, NULL, '', 1, NULL, NULL),
(17, 'SUBJECT', 'mandarin', '普通話', NULL, NULL, '', 1, NULL, NULL),
(18, 'SUBJECT', 'art_craft', '美勞', NULL, NULL, '', 1, NULL, NULL),
(19, 'SUBJECT', 'playgroup', '唱遊', NULL, NULL, '', 1, NULL, NULL),
(20, 'SUBJECT', 'physical_fitness', '體能', NULL, NULL, '', 1, NULL, NULL),
(21, 'ATTITUDE', 'health_1', '衣服鞋襪整齊清潔', NULL, NULL, '', 1, NULL, NULL),
(22, 'ATTITUDE', 'health_2', '常剪指甲', NULL, NULL, '', 1, NULL, NULL),
(23, 'ATTITUDE', 'health_3', '懂得使用手帕或紙巾', NULL, NULL, '', 1, NULL, NULL),
(24, 'ATTITUDE', 'health_4', '不把手指雜物放進口裡', NULL, NULL, '', 1, NULL, NULL),
(25, 'ATTITUDE', 'health_5', '能把癈物投入廢紙箱內', NULL, NULL, '', 1, NULL, NULL),
(26, 'ATTITUDE', 'behaviour_1', '守秩序不喧嚷', NULL, NULL, '', 1, NULL, NULL),
(27, 'ATTITUDE', 'behaviour_2', '留心聽講', NULL, NULL, '', 1, NULL, NULL),
(28, 'ATTITUDE', 'behaviour_3', '坐立行走姿勢正確', NULL, NULL, '', 1, NULL, NULL),
(29, 'ATTITUDE', 'behaviour_4', '離開坐位把物件桌椅整理好', NULL, NULL, '', 1, NULL, NULL),
(30, 'ATTITUDE', 'behaviour_5', '愛護公物用後放回原處', NULL, NULL, '', 1, NULL, NULL),
(31, 'ATTITUDE', 'behaviour_6', '遵守校規', NULL, NULL, '', 1, NULL, NULL),
(32, 'ATTITUDE', 'social_1', '守時', NULL, NULL, '', 1, NULL, NULL),
(33, 'ATTITUDE', 'social_2', '尊敬師長,友愛和睦', NULL, NULL, '', 1, NULL, NULL),
(34, 'ATTITUDE', 'social_3', '樂於助人', NULL, NULL, '', 1, NULL, NULL),
(35, 'ATTITUDE', 'social_4', '會和別人分享及輪侯', NULL, NULL, '', 1, NULL, NULL),
(36, 'ATTITUDE', 'social_5', '誠實坦白肯認錯', NULL, NULL, '', 1, NULL, NULL),
(37, 'SUMMARY', 'total_score', '總分', NULL, NULL, '', 1, NULL, NULL),
(38, 'SUMMARY', 'average_score', '平均分', NULL, NULL, '', 1, NULL, NULL),
(39, 'SUMMARY', 'class_size', '全班人數', NULL, NULL, '', 1, NULL, NULL),
(40, 'SUMMARY', 'ranking', '考列名次', NULL, NULL, '', 1, NULL, NULL),
(41, 'SUMMARY', 'late', '遲到次數', NULL, NULL, '', 1, NULL, NULL),
(42, 'SUMMARY', 'absent', '缺席節數', NULL, NULL, '', 1, NULL, NULL),
(43, 'GENERAL', 'comment', '評語', NULL, NULL, '', 1, NULL, NULL),
(44, 'GENERAL', 'reward_punishment', '奬懲記錄', NULL, NULL, '', 1, NULL, NULL),
(45, 'GENERAL', 'leisure_name', '餘暇活動名稱', NULL, NULL, '', 1, NULL, NULL),
(46, 'GENERAL', 'leisure_performance', '餘暇活動表現', NULL, NULL, '', 1, NULL, NULL),
(47, 'GENERAL', 'remark', '備註', NULL, NULL, '', 1, NULL, NULL),
(48, 'GENERAL', 'appraisal', '學年評定', NULL, NULL, '', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'Master', 'master@example.com', NULL, '$2y$10$5kcHKzNKE1cwYyavtHbuaumDTUcMtE12SfE8ht7cxEGrftehwkx3q', NULL, NULL, NULL, NULL, NULL, NULL, '2023-02-03 01:27:30', '2023-02-03 01:27:30'),
(2, 'Admin', 'admin@example.com', NULL, '$2y$10$TanPI5vzhD5251Zzokh8w.oGAsVS6KQnJcvqrMhmle2bxzfBPnQbq', NULL, NULL, NULL, NULL, 2, NULL, '2023-02-03 01:27:30', '2023-02-03 01:28:14');

-- --------------------------------------------------------

--
-- Table structure for table `years`
--

CREATE TABLE `years` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `meta` text DEFAULT NULL,
  `transcript` text DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `years`
--

INSERT INTO `years` (`id`, `code`, `title`, `description`, `meta`, `transcript`, `start`, `end`, `active`, `created_at`, `updated_at`) VALUES
(1, '2021', '2021-2022', NULL, NULL, NULL, '2021-09-01', '2022-07-30', 1, NULL, '2023-02-03 01:27:25'),
(2, '2022', '2022-2023', NULL, NULL, NULL, '2022-09-01', '2023-07-30', 0, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `behaviours`
--
ALTER TABLE `behaviours`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `behaviours_klass_student_id_term_id_unique` (`klass_student_id`,`term_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `configs_key_unique` (`key`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_scores`
--
ALTER TABLE `course_scores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_teachers`
--
ALTER TABLE `course_teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `disciplines`
--
ALTER TABLE `disciplines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gardians`
--
ALTER TABLE `gardians`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guardians`
--
ALTER TABLE `guardians`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `habits`
--
ALTER TABLE `habits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `klass_student_id_term_id` (`klass_student_id`,`term_id`);

--
-- Indexes for table `healthcares`
--
ALTER TABLE `healthcares`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `identity_documents`
--
ALTER TABLE `identity_documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `klasses`
--
ALTER TABLE `klasses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `klass_student`
--
ALTER TABLE `klass_student`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `outcomes`
--
ALTER TABLE `outcomes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `klass_student_id_term_id` (`klass_student_id`,`terim_id`);

--
-- Indexes for table `parentals`
--
ALTER TABLE `parentals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_score` (`klass_student_id`,`course_score_id`) USING BTREE;

--
-- Indexes for table `score_columns2`
--
ALTER TABLE `score_columns2`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `score_templates`
--
ALTER TABLE `score_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_details`
--
ALTER TABLE `student_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_gardians`
--
ALTER TABLE `student_gardians`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `studies`
--
ALTER TABLE `studies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `study_subject`
--
ALTER TABLE `study_subject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subjects_grade_id_code_unique` (`grade_id`,`code`);

--
-- Indexes for table `subject_templates`
--
ALTER TABLE `subject_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teams_user_id_index` (`user_id`);

--
-- Indexes for table `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_invitations_team_id_email_unique` (`team_id`,`email`);

--
-- Indexes for table `team_user`
--
ALTER TABLE `team_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_user_team_id_user_id_unique` (`team_id`,`user_id`);

--
-- Indexes for table `transcripts`
--
ALTER TABLE `transcripts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transcript_templates`
--
ALTER TABLE `transcript_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `years`
--
ALTER TABLE `years`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `years_code_unique` (`code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `behaviours`
--
ALTER TABLE `behaviours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `configs`
--
ALTER TABLE `configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=381;

--
-- AUTO_INCREMENT for table `course_scores`
--
ALTER TABLE `course_scores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=333;

--
-- AUTO_INCREMENT for table `course_teachers`
--
ALTER TABLE `course_teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `disciplines`
--
ALTER TABLE `disciplines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gardians`
--
ALTER TABLE `gardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `guardians`
--
ALTER TABLE `guardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `habits`
--
ALTER TABLE `habits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `healthcares`
--
ALTER TABLE `healthcares`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `identity_documents`
--
ALTER TABLE `identity_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `klasses`
--
ALTER TABLE `klasses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `klass_student`
--
ALTER TABLE `klass_student`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1261;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `outcomes`
--
ALTER TABLE `outcomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parentals`
--
ALTER TABLE `parentals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=394;

--
-- AUTO_INCREMENT for table `score_columns2`
--
ALTER TABLE `score_columns2`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=333;

--
-- AUTO_INCREMENT for table `score_templates`
--
ALTER TABLE `score_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT for table `student_details`
--
ALTER TABLE `student_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_gardians`
--
ALTER TABLE `student_gardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studies`
--
ALTER TABLE `studies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `study_subject`
--
ALTER TABLE `study_subject`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `subject_templates`
--
ALTER TABLE `subject_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `team_invitations`
--
ALTER TABLE `team_invitations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_user`
--
ALTER TABLE `team_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transcripts`
--
ALTER TABLE `transcripts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `transcript_templates`
--
ALTER TABLE `transcript_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `years`
--
ALTER TABLE `years`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD CONSTRAINT `team_invitations_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
