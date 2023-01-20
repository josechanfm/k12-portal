-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 19-Jan-2023 às 17:21
-- Versão do servidor: 10.3.37-MariaDB-0ubuntu0.20.04.1
-- versão do PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `k12_aims`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `addressable_id` bigint(20) NOT NULL,
  `addressable_type` varchar(255) NOT NULL,
  `zone` varchar(255) NOT NULL,
  `road_name` varchar(255) NOT NULL,
  `building` varchar(255) NOT NULL,
  `overnight` varchar(255) NOT NULL,
  `overnight_address` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `banks`
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
-- Estrutura da tabela `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `configs`
--

CREATE TABLE `configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `configs`
--

INSERT INTO `configs` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'grades', '[{\"value\":\"P1\",\"label\":\"P1\"},{\"value\":\"P2\",\"label\":\"P2\"},{\"value\":\"P3\",\"label\":\"P3\"}]', NULL, NULL),
(2, 'student_state', '{\"ACT\": \"Active\",\"RES\": \"Resigned\"}', NULL, NULL),
(3, 'stream', '{\"ART\":\"Art Stream\",\"SCI\":\"Science Stream}', NULL, NULL),
(4, 'year_creation', '{ \"kgrade\":3, \"kklass\":3, \"kgradeDefault\":0, \"kklassDefault\":0, \"pgrade\":6, \"pklass\":5, \"pgradeDefault\":6, \"pklassDefault\":4, \"sgrade\":6, \"sklass\":5, \"sgradeDefault\":6, \"sklassDefault\":4 }', NULL, NULL),
(5, 'score_columns', '[{\"REG\":\"平時分\"},{\"TST\":\"測驗分\"},{\"CLS\":\"課堂表現\"},{\"EXM\":\"考試分\"}]', NULL, NULL),
(6, 'klass_letters', '[\r\n   {\"value\":\"A\",\"label\":\"A\"},\r\n   {\"value\":\"B\",\"label\":\"B\"},\r\n   {\"value\":\"C\",\"label\":\"C\"},\r\n   {\"value\":\"D\",\"label\":\"D\"},\r\n   {\"value\":\"E\",\"label\":\"E\"},\r\n   {\"value\":\"F\",\"label\":\"F\"}\r\n]', NULL, NULL),
(7, 'subject_types', '\r\n[{\"value\":\"SUB\",\"label\":\"學科\"},\r\n{\"value\":\"ATT\",\"label\":\"生活習慣和態度\"},\r\n{\"value\":\"RPAL\",\"label\":\"獎懲遲缺\"},\r\n{\"value\":\"LES\",\"label\":\"餘暇活動\"},\r\n{\"value\":\"OVA\",\"label\":\"總體評分\"}]', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) NOT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `stream` varchar(3) DEFAULT NULL,
  `elective` varchar(3) NOT NULL,
  `score_column` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `subject_id` bigint(20) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `socre_scheme` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `courses`
--

INSERT INTO `courses` (`id`, `klass_id`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `score_column`, `description`, `subject_id`, `active`, `socre_scheme`, `created_at`, `updated_at`) VALUES
(1, 1, 'CHN', '中文', 'Chinese', 'SUB', 'ART', '0', NULL, NULL, 1, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(2, 1, 'ENG', '英文', 'English', 'SUB', 'ART', '0', NULL, NULL, 2, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(3, 1, 'MAT', '數學', 'Mathematic', 'SUB', 'SCI', '0', NULL, NULL, 3, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(5, 1, 'GEN', '常識', 'General', 'SUB', 'ART', '1', NULL, NULL, 5, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(6, 1, 'ATT', '生活習慣和態度', 'Habit and Attitude', 'ATT', 'GEN', '0', NULL, NULL, 1, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(7, 2, 'ENG', '英文', 'English', NULL, 'ART', '0', NULL, NULL, 2, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(8, 2, 'MAT', '數學', 'Mathematic', NULL, 'SCI', '0', NULL, NULL, 3, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(9, 2, 'PHY', '物理', 'Physics', NULL, 'SCI', '1', NULL, NULL, 4, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(10, 2, 'GEN', '常識', 'General', NULL, 'ART', '1', NULL, NULL, 5, 1, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(23, 67, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, NULL, 1, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(24, 67, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, NULL, 2, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(25, 67, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, NULL, 7, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(26, 67, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, NULL, 8, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(27, 67, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, NULL, 9, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(28, 67, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, NULL, 10, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(29, 67, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, NULL, 11, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(30, 67, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, NULL, 12, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(31, 67, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, NULL, 13, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(32, 67, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, NULL, 14, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(33, 67, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, NULL, 15, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(34, 67, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, NULL, 16, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(35, 67, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, NULL, 17, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(36, 67, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, NULL, 18, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(37, 67, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, NULL, 19, 1, NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(38, 68, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, NULL, 32, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(39, 68, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, NULL, 33, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(40, 68, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, NULL, 24, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(41, 68, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, NULL, 30, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(42, 68, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, NULL, 26, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(43, 68, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, NULL, 27, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(44, 68, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, NULL, 35, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(45, 68, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, NULL, 29, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(46, 68, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, NULL, 28, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(47, 68, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, NULL, 36, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(48, 68, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, NULL, 23, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(49, 68, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, NULL, 31, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(50, 68, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, NULL, 22, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(51, 68, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, NULL, 34, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18'),
(52, 68, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, NULL, 25, 1, NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18');

-- --------------------------------------------------------

--
-- Estrutura da tabela `course_scores`
--

CREATE TABLE `course_scores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `semester` tinyint(4) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `mark` int(11) NOT NULL DEFAULT 0,
  `scope` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `course_teachers`
--

CREATE TABLE `course_teachers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) NOT NULL,
  `is_head` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `course_teachers`
--

INSERT INTO `course_teachers` (`id`, `course_id`, `teacher_id`, `is_head`, `created_at`, `updated_at`) VALUES
(1, 1, 11, 0, NULL, NULL),
(2, 2, 12, 0, NULL, NULL),
(3, 1, 13, 1, NULL, NULL),
(4, 4, 14, 0, NULL, NULL),
(5, 5, 15, 0, NULL, NULL),
(6, 6, 13, 0, NULL, NULL),
(7, 7, 17, 0, NULL, NULL),
(8, 8, 18, 0, NULL, NULL),
(9, 9, 19, 0, NULL, NULL),
(10, 10, 11, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `disciplines`
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
-- Estrutura da tabela `failed_jobs`
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
-- Estrutura da tabela `gardians`
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
-- Estrutura da tabela `grades`
--

CREATE TABLE `grades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `year_id` bigint(20) NOT NULL,
  `rank` int(11) NOT NULL,
  `initial` char(1) NOT NULL,
  `level` int(11) NOT NULL,
  `tag` varchar(5) DEFAULT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `version` varchar(255) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `grades`
--

INSERT INTO `grades` (`id`, `year_id`, `rank`, `initial`, `level`, `tag`, `title_zh`, `title_en`, `description`, `version`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'P', 1, 'P1', 'title_zh', NULL, '111', '1', 1, NULL, '2023-01-18 18:45:07'),
(2, 1, 2, 'P', 2, 'P2', NULL, NULL, NULL, '1', 1, NULL, NULL),
(3, 1, 3, 'P', 3, 'P3', NULL, NULL, NULL, '1', 1, NULL, NULL),
(4, 1, 4, 'P', 4, 'P4', NULL, NULL, '1', '1', 1, NULL, '2023-01-18 20:44:33'),
(7, 1, 7, 'S', 1, 'S1', NULL, NULL, NULL, '1', 1, NULL, NULL),
(8, 1, 8, 'S', 2, 'S2', NULL, NULL, NULL, '1', 1, NULL, NULL),
(9, 1, 9, 'S', 3, 'S3', NULL, NULL, NULL, '1', 1, NULL, NULL),
(10, 1, 10, 'S', 4, 'S4', NULL, NULL, NULL, '1', 1, NULL, NULL),
(11, 1, 11, 'S', 5, 'S5', NULL, NULL, NULL, '1', 1, NULL, NULL),
(12, 1, 12, 'S', 6, 'S6', NULL, NULL, NULL, '1', 1, NULL, NULL),
(13, 2, 1, 'P', 1, 'P1', NULL, NULL, NULL, '1', 1, NULL, NULL),
(14, 2, 2, 'P', 2, 'P2', NULL, NULL, NULL, '1', 1, NULL, NULL),
(15, 2, 3, 'P', 3, 'P3', NULL, NULL, NULL, '1', 1, NULL, NULL),
(16, 2, 4, 'P', 4, 'P4', NULL, NULL, NULL, '1', 1, NULL, NULL),
(17, 2, 5, 'P', 5, 'P5', NULL, NULL, NULL, '1', 1, NULL, NULL),
(18, 2, 6, 'P', 6, 'P6', NULL, NULL, NULL, '1', 1, NULL, NULL),
(19, 2, 7, 'S', 1, 'S1', NULL, NULL, NULL, '1', 1, NULL, NULL),
(20, 2, 8, 'S', 2, 'S2', NULL, NULL, NULL, '1', 1, NULL, NULL),
(21, 2, 9, 'S', 3, 'S3', NULL, NULL, NULL, '1', 1, NULL, NULL),
(22, 2, 10, 'S', 4, 'S4', NULL, NULL, NULL, '1', 1, NULL, NULL),
(23, 2, 11, 'S', 5, 'S5', NULL, NULL, NULL, '1', 1, NULL, NULL),
(24, 2, 12, 'S', 6, 'S6', NULL, NULL, NULL, '1', 1, NULL, NULL),
(25, 1, 5, 'P', 5, 'P5', '小五', '4', '4', '4', 1, '2023-01-18 22:57:53', '2023-01-18 22:57:53');

-- --------------------------------------------------------

--
-- Estrutura da tabela `guardians`
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
  `road_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `post_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `healthcares`
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
-- Estrutura da tabela `identity_documents`
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
-- Estrutura da tabela `klasses`
--

CREATE TABLE `klasses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grade_id` bigint(20) NOT NULL,
  `letter` char(5) DEFAULT NULL,
  `tag` char(5) DEFAULT NULL,
  `room` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `klasses`
--

INSERT INTO `klasses` (`id`, `grade_id`, `letter`, `tag`, `room`, `created_at`, `updated_at`) VALUES
(1, 1, 'A', 'P1A', '2', NULL, '2023-01-18 01:48:22'),
(2, 1, 'B', 'P1B', NULL, NULL, NULL),
(3, 1, 'C', 'P1C', NULL, NULL, NULL),
(4, 1, 'D', 'P1D', NULL, NULL, NULL),
(5, 1, 'E', 'P1E', NULL, NULL, NULL),
(6, 2, 'A', 'P2A', NULL, NULL, NULL),
(7, 2, 'B', 'P2B', NULL, NULL, NULL),
(8, 2, 'C', 'P2C', NULL, NULL, NULL),
(9, 2, 'D', 'P2D', NULL, NULL, NULL),
(10, 2, 'E', 'P2E', NULL, NULL, NULL),
(11, 3, 'A', 'P3A', NULL, NULL, NULL),
(12, 3, 'B', 'P3B', NULL, NULL, NULL),
(13, 3, 'C', 'P3C', NULL, NULL, NULL),
(14, 3, 'D', 'P3D', NULL, NULL, NULL),
(15, 3, 'E', 'P3E', NULL, NULL, NULL),
(16, 4, 'A', 'P4A', NULL, NULL, NULL),
(17, 4, 'B', 'P4B', NULL, NULL, NULL),
(18, 4, 'C', 'P4C', NULL, NULL, NULL),
(19, 4, 'D', 'P4D', NULL, NULL, NULL),
(20, 4, 'E', 'P4E', NULL, NULL, NULL),
(21, 5, 'A', 'P5A', NULL, NULL, NULL),
(22, 5, 'B', 'P5B', NULL, NULL, NULL),
(23, 5, 'C', 'P5C', NULL, NULL, NULL),
(24, 5, 'D', 'P5D', NULL, NULL, NULL),
(25, 5, 'E', 'P5E', NULL, NULL, NULL),
(26, 6, 'A', 'P6A', NULL, NULL, NULL),
(27, 6, 'B', 'P6B', NULL, NULL, NULL),
(28, 6, 'C', 'P6C', NULL, NULL, NULL),
(29, 6, 'D', 'P6D', NULL, NULL, NULL),
(30, 6, 'E', 'P6E', NULL, NULL, NULL),
(31, 7, 'A', 'S1A', NULL, NULL, NULL),
(32, 7, 'B', 'S1B', NULL, NULL, NULL),
(33, 7, 'C', 'S1C', NULL, NULL, NULL),
(34, 7, 'D', 'S1D', NULL, NULL, NULL),
(35, 7, 'E', 'S1E', NULL, NULL, NULL),
(36, 8, 'A', 'S2A', NULL, NULL, NULL),
(37, 8, 'B', 'S2B', NULL, NULL, NULL),
(38, 8, 'C', 'S2C', NULL, NULL, NULL),
(39, 8, 'D', 'S2D', NULL, NULL, NULL),
(40, 8, 'E', 'S2E', NULL, NULL, NULL),
(41, 9, 'A', 'S3A', NULL, NULL, NULL),
(42, 9, 'B', 'S3B', NULL, NULL, NULL),
(43, 9, 'C', 'S3C', NULL, NULL, NULL),
(44, 9, 'D', 'S3D', NULL, NULL, NULL),
(45, 9, 'E', 'S3E', NULL, NULL, NULL),
(46, 10, 'A', 'S4A', NULL, NULL, NULL),
(47, 10, 'B', 'S4B', NULL, NULL, NULL),
(48, 10, 'C', 'S4C', NULL, NULL, NULL),
(49, 10, 'D', 'S4D', NULL, NULL, NULL),
(50, 10, 'E', 'S4E', NULL, NULL, NULL),
(51, 11, 'A', 'S5A', NULL, NULL, NULL),
(52, 11, 'B', 'S5B', NULL, NULL, NULL),
(53, 11, 'C', 'S5C', NULL, NULL, NULL),
(54, 11, 'D', 'S5D', NULL, NULL, NULL),
(55, 11, 'E', 'S5E', NULL, NULL, NULL),
(56, 12, 'A', 'S6A', NULL, NULL, NULL),
(57, 12, 'B', 'S6B', NULL, NULL, NULL),
(58, 12, 'C', 'S6C', NULL, NULL, NULL),
(59, 12, 'D', 'S6D', NULL, NULL, NULL),
(60, 12, 'E', 'S6E', NULL, NULL, NULL),
(67, 1, 'F', 'P1F', NULL, '2023-01-19 00:38:21', '2023-01-19 00:38:21'),
(68, 2, 'F', 'P2F', NULL, '2023-01-19 01:19:18', '2023-01-19 01:19:18');

-- --------------------------------------------------------

--
-- Estrutura da tabela `klass_students`
--

CREATE TABLE `klass_students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_id` bigint(20) NOT NULL DEFAULT 0,
  `student_id` bigint(20) NOT NULL DEFAULT 0,
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
-- Extraindo dados da tabela `klass_students`
--

INSERT INTO `klass_students` (`id`, `klass_id`, `student_id`, `student_number`, `state`, `stream`, `promote`, `promote_to`, `score_scheme`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(2, 1, 2, 2, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(3, 1, 3, 3, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(4, 1, 4, 4, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
(5, 1, 5, 5, 'ACT', 'ART', 0, 0, NULL, NULL, NULL),
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
INSERT INTO `klass_students` (`id`, `klass_id`, `student_id`, `student_number`, `state`, `stream`, `promote`, `promote_to`, `score_scheme`, `created_at`, `updated_at`) VALUES
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
-- Estrutura da tabela `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
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
(25, '2022_12_02_011550_create_klass_students_table', 1),
(27, '2022_12_12_141100_create_course_scores_table', 1),
(28, '2023_01_07_152244_create_transcripts_table', 1),
(29, '2023_01_07_162945_create_transcript_templates_table', 1),
(30, '2023_01_09_033255_create_score_columns_table', 1),
(32, '2023_01_11_064535_create_permission_tables', 3),
(33, '2023_01_11_023007_create_course_teacher_table', 4),
(34, '2023_01_14_024917_create_addresses_table', 4),
(35, '2023_01_14_133306_create_identity_documents_table', 5),
(36, '2023_01_14_141228_create_banks_table', 5),
(37, '2023_01_14_142338_create_student_details_table', 5),
(38, '2023_01_14_150126_create_parentals_table', 5),
(39, '2023_01_14_151709_create_guardians_table', 5),
(40, '2023_01_14_161817_create_healthcares_table', 5),
(41, '2022_12_09_071744_create_teachers_table', 6),
(42, '2023_01_16_081153_create_klass_teachers_table', 7),
(43, '2023_01_11_023007_create_course_teachers_table', 8),
(44, '2023_01_18_082948_create_garde_subjects_table', 9),
(45, '2023_01_18_083107_create_grade_subjects_table', 10),
(46, '2023_01_18_083745_create_subject_templates_table', 1),
(47, '2023_01_19_025347_create_grade_subjects_table', 11),
(49, '2022_11_25_025230_create_subjects_table', 12);

-- --------------------------------------------------------

--
-- Estrutura da tabela `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `parentals`
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
-- Estrutura da tabela `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Account Management', 'web', '2023-01-10 22:55:08', '2023-01-10 22:55:08');

-- --------------------------------------------------------

--
-- Estrutura da tabela `personal_access_tokens`
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
-- Estrutura da tabela `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'master', 'web', '2023-01-10 22:50:01', '2023-01-10 22:50:01');

-- --------------------------------------------------------

--
-- Estrutura da tabela `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `scores`
--

CREATE TABLE `scores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `score_column_id` bigint(20) NOT NULL,
  `point` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `scores`
--

INSERT INTO `scores` (`id`, `klass_student_id`, `score_column_id`, `point`, `remark`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '100', NULL, NULL, NULL),
(2, 5, 1, '80', NULL, NULL, NULL),
(3, 3, 2, '90', NULL, NULL, NULL),
(4, 1, 14, '1', NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(5, 1, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(6, 2, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(7, 2, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(8, 3, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(9, 3, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(10, 3, 1, '100', NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(11, 3, 2, '90', NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(12, 4, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(13, 4, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(14, 5, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(15, 5, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(16, 5, 1, '80', NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(17, 6, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(18, 6, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(19, 7, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(20, 7, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(21, 8, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(22, 8, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(23, 9, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(24, 9, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(25, 10, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(26, 10, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(27, 11, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(28, 11, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(29, 12, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(30, 12, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(31, 13, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(32, 13, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(33, 14, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(34, 14, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(35, 15, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(36, 15, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(37, 16, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(38, 16, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(39, 17, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(40, 17, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(41, 18, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(42, 18, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(43, 19, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(44, 19, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(45, 20, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(46, 20, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(47, 21, 14, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(48, 21, 15, NULL, NULL, '2023-01-16 17:30:07', '2023-01-16 17:30:07'),
(49, 1, 14, '1', NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(50, 1, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(51, 2, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(52, 2, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(53, 3, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(54, 3, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(55, 3, 1, '100', NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(56, 3, 2, '90', NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(57, 4, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(58, 4, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(59, 5, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(60, 5, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(61, 5, 1, '80', NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(62, 6, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(63, 6, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(64, 7, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(65, 7, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(66, 8, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(67, 8, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(68, 9, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(69, 9, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(70, 10, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(71, 10, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(72, 11, 14, '1', NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(73, 11, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(74, 12, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(75, 12, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(76, 13, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(77, 13, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(78, 14, 14, '1', NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(79, 14, 15, '1', NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(80, 15, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(81, 15, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(82, 16, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(83, 16, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(84, 17, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(85, 17, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(86, 18, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(87, 18, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(88, 19, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(89, 19, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(90, 20, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(91, 20, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(92, 21, 14, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(93, 21, 15, NULL, NULL, '2023-01-16 17:30:18', '2023-01-16 17:30:18'),
(94, 1, 11, 'A', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(95, 1, 12, 'A', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(96, 1, 14, '1', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(97, 1, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(98, 2, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(99, 2, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(100, 2, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(101, 2, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(102, 3, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(103, 3, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(104, 3, 1, '100', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(105, 3, 2, '90', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(106, 3, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(107, 3, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(108, 4, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(109, 4, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(110, 4, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(111, 4, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(112, 5, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(113, 5, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(114, 5, 1, '80', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(115, 5, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(116, 5, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(117, 6, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(118, 6, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(119, 6, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(120, 6, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(121, 7, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(122, 7, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(123, 7, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(124, 7, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(125, 8, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(126, 8, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(127, 8, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(128, 8, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(129, 9, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(130, 9, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(131, 9, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(132, 9, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(133, 10, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(134, 10, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(135, 10, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(136, 10, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(137, 11, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(138, 11, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(139, 11, 14, '1', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(140, 11, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(141, 12, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(142, 12, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(143, 12, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(144, 12, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(145, 13, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(146, 13, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(147, 13, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(148, 13, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(149, 14, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(150, 14, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(151, 14, 14, '1', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(152, 14, 15, '1', NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(153, 15, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(154, 15, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(155, 15, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(156, 15, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(157, 16, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(158, 16, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(159, 16, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(160, 16, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(161, 17, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(162, 17, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(163, 17, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(164, 17, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(165, 18, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(166, 18, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(167, 18, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(168, 18, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(169, 19, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(170, 19, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(171, 19, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(172, 19, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(173, 20, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(174, 20, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(175, 20, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(176, 20, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(177, 21, 11, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(178, 21, 12, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(179, 21, 14, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20'),
(180, 21, 15, NULL, NULL, '2023-01-16 18:00:20', '2023-01-16 18:00:20');

-- --------------------------------------------------------

--
-- Estrutura da tabela `score_columns`
--

CREATE TABLE `score_columns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(4) DEFAULT NULL,
  `scheme` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `score_columns`
--

INSERT INTO `score_columns` (`id`, `course_id`, `term_id`, `sequence`, `name`, `type`, `scheme`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '上學期', 'SUB', NULL, NULL, NULL, '2023-01-16 02:21:30'),
(2, 1, 2, 2, '下學期', 'SUB', NULL, NULL, NULL, '2023-01-16 02:21:39'),
(3, 1, 1, 3, '整潔', 'ATT', NULL, NULL, NULL, '2023-01-16 01:39:36'),
(4, 1, 2, 4, '整潔', 'ATT', NULL, NULL, NULL, '2023-01-16 01:39:51'),
(5, 3, 1, NULL, '上學期1', NULL, NULL, NULL, '2023-01-15 20:01:54', '2023-01-15 20:11:24'),
(6, 3, 2, NULL, '下學期2', NULL, NULL, NULL, '2023-01-15 20:11:35', '2023-01-15 20:11:35'),
(7, 4, 1, NULL, '上學期3', NULL, NULL, NULL, '2023-01-15 20:12:33', '2023-01-15 20:12:33'),
(8, 4, 2, NULL, '下學期4', NULL, NULL, NULL, '2023-01-15 20:12:45', '2023-01-15 20:12:45'),
(9, 5, 1, NULL, '上學期5', NULL, NULL, NULL, '2023-01-15 20:12:59', '2023-01-15 20:12:59'),
(10, 5, 2, NULL, '下學期6', NULL, NULL, NULL, '2023-01-15 20:13:09', '2023-01-15 20:13:09'),
(11, 6, 1, NULL, '整潔1', 'ATT', NULL, NULL, '2023-01-15 20:13:18', '2023-01-15 20:13:18'),
(12, 6, 2, NULL, '整潔2', 'ATT', NULL, NULL, '2023-01-15 20:13:27', '2023-01-15 20:13:27'),
(13, 7, 1, NULL, '上學期9', NULL, NULL, NULL, '2023-01-15 20:13:37', '2023-01-15 20:13:37'),
(14, 2, 1, NULL, '上學期10', 'SUB', NULL, NULL, '2023-01-16 17:24:48', '2023-01-16 17:24:48'),
(15, 2, 2, NULL, '下學期11', 'SUB', NULL, NULL, '2023-01-16 17:27:53', '2023-01-16 17:27:53');

-- --------------------------------------------------------

--
-- Estrutura da tabela `sessions`
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
-- Extraindo dados da tabela `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('07Tn5YfjeedAeIt1CStblAISWpDd6kiyWGHVWk86', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidU9aUjNZcjI4eENXOWpwQ3lsalpIVE1FdXgycVdHSDRhdHBoNW1VSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9lc3NlbnRpYWwvZ3JhZGVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCRtRld1LlUxc2UxR3ljSnhiazhEbGRPR2JPY1RGcDJWT1Zpb20zLzNzNDBuT2NyYlVOSFo1MiI7fQ==', 1674120009);

-- --------------------------------------------------------

--
-- Estrutura da tabela `staff`
--

CREATE TABLE `staff` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
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
-- Extraindo dados da tabela `staff`
--

INSERT INTO `staff` (`id`, `code`, `name_zh`, `name_fn`, `gender`, `dob`, `mobile`, `sector`, `created_at`, `updated_at`) VALUES
(1, '001', '游承', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(2, '002', '燕嘉樺', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(3, '003', '景靜詩', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(4, '004', '關雅淑', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(5, '005', '鄭家佩', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(6, '006', '佘欣', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(7, '007', '別詩慧', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(8, '008', '陰美', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(9, '009', '嚴穎', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(10, '010', '佘淑馨', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(11, '011', '張慧', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(12, '012', '顏伶', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(13, '013', '元庭萍', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(14, '014', '邰雅儀', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(15, '015', '郗君', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(16, '016', '通冠君', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(17, '017', '嚴文依', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(18, '018', '尹文佩', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(19, '019', '公華', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(20, '020', '緱娟萱', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(21, '021', '張冠', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(22, '022', '南宮安琪', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(23, '023', '昝婷', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(24, '024', '韋宗瑋', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(25, '025', '黎如', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(26, '026', '衛婉', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(27, '027', '房柏', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(28, '028', '燕建', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(29, '029', '牟思', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(30, '030', '郝軒', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(31, '031', '滑瑋志', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(32, '032', '融宏傑', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(33, '033', '柏庭', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(34, '034', '督貞穎', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(35, '035', '郜瑜蓉', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(36, '036', '鬱靜嘉', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(37, '037', '宗政婷慧', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(38, '038', '從霖宜', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(39, '039', '路宗', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(40, '040', '舒君', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(41, '041', '莘淑冠', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(42, '042', '鄧美嘉', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(43, '043', '容瑜珊', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(44, '044', '饒慧', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(45, '045', '龍華萍', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(46, '046', '滿涵', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(47, '047', '翟翰', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(48, '048', '晉涵', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(49, '049', '壽思銘', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(50, '050', '藺安', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(51, '051', '閻涵', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(52, '052', '糜家', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(53, '053', '毛瑜', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(54, '054', '牟樺庭', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(55, '055', '牟家廷', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(56, '056', '咸美思', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(57, '057', '蓋欣', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(58, '058', '秋霖賢', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(59, '059', '左雯', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(60, '060', '宰惠貞', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(61, '061', '湯家華', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(62, '062', '殳嘉', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(63, '063', '岳蓉', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(64, '064', '陽華心', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(65, '065', '臧彥建', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(66, '066', '鬱建美', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(67, '067', '包淑怡', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(68, '068', '孔廷華', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(69, '069', '微生安', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(70, '070', '法宏君', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(71, '071', '甯思', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(72, '072', '伍霖', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(73, '073', '鄢美芬', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(74, '074', '劉婉琬', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(75, '075', '王君', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(76, '076', '浦君', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(77, '077', '拓跋哲', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(78, '078', '居珊', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(79, '079', '衛穎安', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(80, '080', '莘思庭', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(81, '081', '姚依', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(82, '082', '有文偉', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(83, '083', '軒轅惠萍', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(84, '084', '孟霖佳', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(85, '085', '連宗', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(86, '086', '單于心心', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(87, '087', '季安', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(88, '088', '莘穎', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(89, '089', '邵婉雅', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(90, '090', '壤駟俊宗', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(91, '091', '閭丘美建', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(92, '092', '吳華宏', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(93, '093', '步宜宗', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(94, '094', '廖冠', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(95, '095', '古文佳', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(96, '096', '詹萱華', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(97, '097', '趙威', NULL, 'F', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(98, '098', '子車承', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(99, '099', '竇穎', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00'),
(100, '100', '阮美文', NULL, 'M', NULL, NULL, NULL, '2023-01-10 18:15:00', '2023-01-10 18:15:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `students`
--

CREATE TABLE `students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name_zh` varchar(255) NOT NULL,
  `name_fn` varchar(255) NOT NULL,
  `gender` char(1) NOT NULL,
  `dob` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `students`
--

INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `gender`, `dob`, `created_at`, `updated_at`) VALUES
(1, '第五庭家', '銘樺', 'F', '2003-05-30', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(2, '軒轅信軒', '詩家', 'M', '2011-06-29', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(3, '酆瑋銘', '心家', 'F', '2011-10-17', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(4, '路瑋宜', '珊', 'M', '2015-02-09', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(5, '車柏', '佳承', 'F', '2005-06-14', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(6, '汝安賢', '萍靜', 'F', '2010-10-04', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(7, '盛建', '志', 'F', '2004-09-24', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(8, '于銘志', '美佳', 'F', '2013-08-31', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(9, '龐玲蓉', '佳筱', 'F', '2009-08-04', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(10, '商志', '豪志', 'M', '2002-04-16', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(11, '燕銘', '庭', 'F', '2011-09-01', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(12, '墨建', '君華', 'F', '2014-11-24', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(13, '伍承', '承宇', 'M', '2004-03-31', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(14, '裘思娟', '翰', 'F', '2006-02-09', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(15, '宋宏廷', '安思', 'F', '2014-11-01', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(16, '樂正芬蓉', '冠', 'M', '2005-10-08', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(17, '于傑冠', '廷豪', 'F', '2004-10-21', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(18, '史偉廷', '欣珊', 'M', '2011-03-06', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(19, '谷雅瑜', '偉傑', 'M', '2010-06-18', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(20, '別玲安', '承', 'F', '2013-06-22', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(21, '祿哲', '瑋信', 'M', '2003-06-20', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(22, '甄心欣', '雅', 'F', '2000-11-16', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(23, '岳雅淑', '穎伶', 'F', '2008-10-18', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(24, '周宜雅', '冠翰', 'M', '2013-01-09', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(25, '蔚偉柏', '哲思', 'F', '2011-07-31', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(26, '孔雅冠', '欣', 'F', '2005-05-09', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(27, '裴美', '雅', 'M', '2001-10-17', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(28, '黃宇哲', '如儀', 'M', '2004-06-11', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(29, '甘穎', '銘文', 'M', '2002-04-02', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(30, '簡惠', '哲', 'M', '2001-02-21', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(31, '黎柏', '依佳', 'F', '2003-01-26', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(32, '晏思信', '儀怡', 'F', '2008-11-10', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(33, '尹婷', '雅', 'F', '2000-09-16', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(34, '井建安', '華宇', 'F', '2000-09-08', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(35, '危霖', '瑜蓉', 'F', '2003-06-13', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(36, '齊芬', '玲琪', 'F', '2004-10-11', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(37, '查威', '文', 'M', '2011-03-28', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(38, '謝宜', '安', 'F', '2003-04-19', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(39, '彭宏', '承', 'F', '2009-12-02', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(40, '郗威翰', '依涵', 'M', '2008-07-21', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(41, '江珊芳', '蓉', 'F', '2013-04-01', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(42, '屠安', '貞依', 'M', '2005-10-11', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(43, '邰志宗', '詩', 'F', '2008-07-21', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(44, '牟琬', '娟文', 'M', '2012-10-13', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(45, '干依伶', '俊傑', 'M', '2004-07-01', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(46, '隗樺宇', '柏', 'F', '2014-02-23', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(47, '幸佳', '冠', 'M', '2011-05-09', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(48, '卓心', '芬貞', 'F', '2009-02-04', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(49, '家威豪', '琪玲', 'M', '2011-12-04', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(50, '蔡依', '娟', 'F', '2004-11-06', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(51, '沃心樺', '文鈺', 'M', '2004-01-17', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(52, '胥威', '冠宜', 'M', '2005-04-21', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(53, '東方婷佳', '彥', 'M', '2007-04-08', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(54, '干萍郁', '心婷', 'F', '2007-05-12', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(55, '西門偉', '慧', 'F', '2010-09-16', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(56, '韓志文', '庭', 'M', '2002-10-10', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(57, '扶思安', '婷馨', 'M', '2009-11-30', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(58, '裴萍芬', '志華', 'F', '2004-09-20', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(59, '全家', '傑', 'F', '2011-05-05', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(60, '毛依', '雅', 'F', '2008-05-19', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(61, '弘筑嘉', '美瑋', 'F', '2005-08-10', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(62, '甄依', '庭', 'M', '2009-02-10', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(63, '年威彥', '心華', 'M', '2010-11-02', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(64, '奚信傑', '琪', 'F', '2013-08-13', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(65, '宮瑋', '惠伶', 'F', '2013-12-03', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(66, '費心', '怡', 'M', '2003-11-29', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(67, '廣如萱', '詩', 'M', '2006-01-26', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(68, '阮宏翰', '涵文', 'F', '2012-10-16', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(69, '牛哲俊', '貞', 'M', '2007-07-01', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(70, '桓萍如', '華佳', 'M', '2012-08-06', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(71, '俞淑', '琪萱', 'M', '2015-02-02', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(72, '別穎瑋', '志', 'M', '2012-08-07', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(73, '万俟萍', '安建', 'M', '2012-11-14', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(74, '司徒思', '柏', 'F', '2003-04-13', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(75, '馬廷威', '瑋', 'F', '2006-07-11', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(76, '空思', '華', 'M', '2006-08-09', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(77, '宇文如', '冠樺', 'M', '2007-12-28', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(78, '王軒宏', '淑', 'M', '2003-10-05', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(79, '荀依', '伶', 'F', '2008-01-25', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(80, '步詩', '心', 'M', '2007-12-18', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(81, '空筱', '君', 'M', '2001-04-27', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(82, '黨娟家', '雅', 'M', '2008-01-02', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(83, '湯玲欣', '芬思', 'F', '2012-02-12', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(84, '欒宜', '婉佩', 'M', '2013-10-31', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(85, '石怡涵', '宜', 'M', '2008-11-05', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(86, '梅淑', '萍', 'F', '2006-09-17', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(87, '羿軒君', '嘉', 'F', '2012-10-07', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(88, '鈕欣', '樺', 'F', '2011-05-26', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(89, '籍哲', '佳', 'M', '2011-08-15', '2023-01-10 18:14:57', '2023-01-10 18:14:57'),
(90, '戴宜芳', '慧', 'M', '2004-01-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(91, '弘美心', '豪建', 'M', '2003-02-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(92, '詹庭柏', '賢', 'M', '2005-07-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(93, '祝心宏', '樺宏', 'F', '2008-01-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(94, '令狐心', '庭穎', 'F', '2001-11-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(95, '太叔銘', '安雅', 'F', '2009-12-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(96, '史如', '美偉', 'F', '2011-03-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(97, '鄭玲美', '君', 'M', '2009-11-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(98, '岳慧雅', '安瑋', 'F', '2004-03-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(99, '伯芳', '豪', 'F', '2010-09-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(100, '夾谷華', '詩', 'M', '2006-07-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(101, '申哲', '佳彥', 'F', '2011-04-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(102, '項穎君', '柏', 'F', '2006-11-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(103, '仉娟詩', '承', 'F', '2013-12-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(104, '相思', '嘉琬', 'F', '2011-03-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(105, '壤駟心', '安', 'F', '2004-04-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(106, '酈雯琪', '志俊', 'M', '2008-09-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(107, '蒙廷家', '庭', 'M', '2001-11-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(108, '鳳華', '哲', 'M', '2002-08-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(109, '榮翰', '柏', 'F', '2005-04-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(110, '全萍娟', '彥傑', 'M', '2009-09-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(111, '麴郁婉', '俊', 'M', '2013-12-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(112, '相宇', '思', 'F', '2004-01-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(113, '龍冠宇', '郁芳', 'F', '2009-05-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(114, '梁丘安婉', '琬', 'F', '2003-01-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(115, '弘穎穎', '樺豪', 'M', '2014-09-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(116, '宇文芳', '翰詩', 'F', '2008-02-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(117, '虞宇', '芳', 'M', '2007-09-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(118, '羿文婉', '華', 'F', '2011-07-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(119, '夔樺', '玲', 'M', '2010-12-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(120, '冷佩', '馨', 'M', '2012-12-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(121, '濮銘宏', '雯', 'M', '2008-02-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(122, '司徒豪', '安', 'F', '2003-01-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(123, '別嘉', '佩', 'M', '2014-08-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(124, '辛柏', '雯萱', 'F', '2006-06-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(125, '濮美', '君家', 'M', '2012-08-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(126, '晏詩', '銘君', 'F', '2011-11-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(127, '芮婷', '宇宏', 'M', '2001-04-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(128, '閔美', '建文', 'F', '2011-12-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(129, '陰哲思', '君萱', 'F', '2008-02-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(130, '明美安', '威', 'M', '2009-11-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(131, '盧君廷', '淑', 'F', '2008-06-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(132, '海娟', '俊', 'F', '2010-11-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(133, '班怡', '美', 'F', '2012-11-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(134, '歐陽銘家', '文怡', 'M', '2012-10-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(135, '公冶靜穎', '家承', 'M', '2010-02-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(136, '鄧安', '翰冠', 'F', '2001-01-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(137, '史雅冠', '琬', 'F', '2006-01-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(138, '危嘉君', '淑瑜', 'M', '2007-06-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(139, '耿冠', '華', 'F', '2012-05-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(140, '鄭慧', '慧', 'M', '2014-01-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(141, '姬華霖', '美欣', 'F', '2002-03-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(142, '欒娟儀', '軒宗', 'M', '2007-11-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(143, '段干華', '詩廷', 'F', '2004-04-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(144, '索文', '家', 'M', '2014-06-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(145, '欒信', '郁心', 'M', '2015-08-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(146, '益承', '安庭', 'M', '2007-01-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(147, '晏穎蓉', '依', 'M', '2010-05-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(148, '胥華怡', '豪承', 'F', '2003-08-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(149, '祁伶', '瑋', 'M', '2004-09-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(150, '吳華豪', '心萍', 'M', '2004-09-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(151, '鮮于宜傑', '文', 'M', '2002-10-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(152, '聶冠', '嘉', 'F', '2007-10-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(153, '柯志', '冠蓉', 'M', '2003-12-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(154, '蒼宏承', '依', 'M', '2014-06-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(155, '臧霖', '家家', 'F', '2008-08-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(156, '單于思瑋', '雯詩', 'F', '2015-03-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(157, '韓安偉', '思', 'F', '2011-12-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(158, '祿心', '瑋', 'F', '2013-07-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(159, '封宇詩', '傑庭', 'F', '2002-10-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(160, '祁婉美', '惠', 'M', '2014-04-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(161, '井依', '宜', 'F', '2005-03-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(162, '蔡馨', '雅', 'M', '2010-01-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(163, '東方軒安', '銘傑', 'F', '2006-05-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(164, '支俊君', '軒', 'F', '2009-01-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(165, '巫傑', '彥', 'M', '2011-06-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(166, '應佳', '文', 'M', '2009-08-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(167, '幸郁思', '承志', 'F', '2004-07-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(168, '壤駟靜', '哲', 'F', '2010-03-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(169, '壽霖', '軒', 'F', '2006-05-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(170, '桓家珊', '鈺', 'M', '2005-02-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(171, '甘冠穎', '彥', 'F', '2007-01-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(172, '婁宗', '哲', 'M', '2013-03-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(173, '季安', '俊', 'M', '2002-09-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(174, '于佳', '伶心', 'F', '2001-05-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(175, '張佳', '筑', 'F', '2001-07-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(176, '匡穎俊', '宜', 'F', '2013-11-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(177, '支庭思', '銘宏', 'M', '2005-09-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(178, '袁美', '庭', 'F', '2012-01-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(179, '湯威', '安', 'M', '2002-11-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(180, '富賢', '思家', 'M', '2005-10-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(181, '萬樺君', '翰', 'M', '2009-02-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(182, '巢涵琬', '冠', 'M', '2004-11-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(183, '經琬如', '庭廷', 'M', '2001-11-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(184, '榮霖', '俊', 'M', '2001-07-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(185, '穆怡', '宜', 'F', '2011-12-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(186, '雲心宗', '慧', 'M', '2006-12-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(187, '倪樺安', '廷翰', 'F', '2003-08-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(188, '蔣承華', '美', 'F', '2006-03-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(189, '咸宇宗', '俊信', 'F', '2002-01-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(190, '農宜柏', '慧', 'M', '2010-01-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(191, '顏嘉穎', '安樺', 'F', '2007-01-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(192, '簡豪安', '穎婷', 'F', '2015-06-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(193, '湛宇美', '賢冠', 'M', '2014-01-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(194, '祁宗文', '志威', 'M', '2001-03-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(195, '井萍穎', '文詩', 'M', '2014-07-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(196, '黎琪穎', '宜', 'F', '2002-08-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(197, '白雯', '萍', 'F', '2005-03-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(198, '崔靜思', '霖心', 'F', '2000-10-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(199, '束怡', '思', 'M', '2003-12-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(200, '裴柏霖', '冠', 'M', '2015-02-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(201, '喻佳', '文家', 'M', '2012-08-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(202, '弓庭', '心賢', 'F', '2009-10-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(203, '全穎信', '琬思', 'M', '2002-10-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(204, '安華宗', '琪', 'F', '2009-03-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(205, '單于儀', '家安', 'F', '2005-05-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(206, '酆彥建', '鈺', 'F', '2001-05-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(207, '陸萱', '文', 'F', '2015-03-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(208, '方蓉', '宗偉', 'M', '2005-05-27', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(209, '駱宗', '廷', 'F', '2008-02-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(210, '甘淑', '筑', 'F', '2004-03-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(211, '東美廷', '宇', 'M', '2002-06-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(212, '樊萍', '美', 'F', '2009-04-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(213, '黃信軒', '嘉', 'F', '2007-07-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(214, '桂文', '庭樺', 'M', '2002-02-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(215, '聞人俊', '彥宗', 'F', '2013-02-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(216, '赫連芳', '如欣', 'F', '2011-04-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(217, '溫蓉慧', '宇嘉', 'M', '2010-01-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(218, '石銘軒', '廷', 'F', '2001-07-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(219, '郝如', '軒', 'F', '2002-02-27', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(220, '晏琬華', '穎', 'F', '2011-09-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(221, '公良伶', '冠', 'M', '2001-10-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(222, '甄詩安', '宜', 'M', '2007-11-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(223, '懷瑜如', '珊', 'F', '2000-09-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(224, '仲穎涵', '涵婉', 'F', '2003-12-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(225, '楚筑', '俊君', 'M', '2011-10-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(226, '呼延穎', '安', 'M', '2007-02-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(227, '晉信傑', '承', 'M', '2011-10-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(228, '楊穎銘', '霖', 'M', '2003-09-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(229, '欒樺', '威', 'F', '2008-05-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(230, '璩威', '賢', 'F', '2012-06-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(231, '闞宏翰', '馨', 'F', '2012-01-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(232, '殷俊銘', '家安', 'M', '2007-04-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(233, '饒翰', '佳佳', 'M', '2007-11-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(234, '卜詩', '芬', 'M', '2011-01-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(235, '宋芳', '家賢', 'M', '2001-03-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(236, '成家', '芳萍', 'F', '2012-12-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(237, '何淑儀', '婉', 'F', '2008-08-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(238, '卞佩芳', '馨', 'M', '2003-07-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(239, '鍾佳', '傑穎', 'M', '2004-02-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(240, '梁穎', '樺佳', 'M', '2012-01-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(241, '夏侯宏', '婉', 'F', '2006-04-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(242, '翁詩家', '萱婉', 'F', '2008-03-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(243, '靳萍涵', '庭', 'M', '2008-06-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(244, '甘銘思', '思', 'M', '2006-04-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(245, '全志', '雅雯', 'M', '2013-12-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(246, '祁文', '娟', 'F', '2007-02-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(247, '安郁', '豪', 'F', '2002-04-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(248, '司馬如', '涵玲', 'M', '2013-04-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(249, '干佳宇', '宜', 'M', '2005-08-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(250, '靳嘉嘉', '威', 'F', '2008-07-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(251, '簡宏', '華志', 'M', '2010-07-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(252, '融馨文', '伶萍', 'M', '2004-10-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(253, '虞冠', '穎', 'F', '2007-06-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(254, '仲美', '雯', 'M', '2015-01-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(255, '汲佳', '心佳', 'F', '2013-06-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(256, '祁樺', '心玲', 'F', '2002-06-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(257, '長孫佳', '婷', 'F', '2008-09-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(258, '宇文賢', '彥', 'M', '2009-12-27', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(259, '郭華', '建信', 'F', '2011-02-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(260, '上官嘉', '哲', 'F', '2014-05-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(261, '顧婷', '偉', 'F', '2001-08-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(262, '梁穎', '涵', 'M', '2011-02-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(263, '薊宜華', '萱華', 'M', '2014-05-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(264, '鍾美', '樺', 'F', '2008-09-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(265, '巢翰', '嘉威', 'M', '2015-07-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(266, '瞿婷萍', '娟', 'F', '2012-09-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(267, '仲淑芬', '賢', 'M', '2011-02-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(268, '郜蓉', '美豪', 'F', '2012-01-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(269, '江筑家', '琬怡', 'F', '2011-03-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(270, '王惠', '信', 'M', '2006-04-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(271, '衡娟', '君', 'F', '2008-01-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(272, '相伶嘉', '瑋宏', 'F', '2014-11-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(273, '車廷哲', '娟', 'F', '2007-02-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(274, '微生君', '佩', 'F', '2012-08-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(275, '后靜穎', '涵', 'M', '2009-11-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(276, '董芳嘉', '志', 'M', '2002-02-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(277, '左彥嘉', '貞', 'M', '2008-11-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(278, '南宮雅', '美', 'M', '2004-09-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(279, '巫如心', '萍', 'F', '2001-06-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(280, '薛庭', '佩穎', 'F', '2010-10-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(281, '竇安芬', '珊芳', 'F', '2012-01-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(282, '尤佳伶', '美威', 'M', '2009-02-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(283, '訾文思', '華', 'M', '2008-01-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(284, '柯佳婷', '儀婷', 'M', '2003-07-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(285, '荀思心', '翰', 'M', '2012-09-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(286, '東柏廷', '傑', 'M', '2004-01-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(287, '闞安心', '思惠', 'M', '2007-07-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(288, '冀霖宇', '承', 'F', '2002-03-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(289, '曾思樺', '賢', 'F', '2006-11-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(290, '烏嘉', '郁惠', 'M', '2003-02-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(291, '繆哲', '靜美', 'M', '2012-09-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(292, '姚君蓉', '傑', 'F', '2004-12-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(293, '魚廷', '淑', 'M', '2014-11-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(294, '相筑儀', '瑜家', 'M', '2015-02-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(295, '幸依', '淑', 'M', '2012-12-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(296, '竺宇宇', '承銘', 'F', '2010-11-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(297, '戎家文', '文', 'F', '2014-04-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(298, '言家', '威華', 'F', '2012-05-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(299, '郝豪宇', '華宜', 'M', '2004-03-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(300, '夏侯庭哲', '宗', 'M', '2014-10-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(301, '相佳', '筱', 'M', '2014-03-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(302, '令狐依萱', '家', 'M', '2013-12-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(303, '司徒筱華', '嘉', 'F', '2012-01-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(304, '樊建', '偉', 'M', '2004-11-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(305, '羅心', '雅伶', 'F', '2014-10-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(306, '郜伶芳', '志', 'M', '2005-05-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(307, '郎文安', '芳玲', 'M', '2007-03-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(308, '鄔冠', '怡', 'M', '2010-10-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(309, '羅霖', '惠', 'F', '2004-07-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(310, '羊舌婉', '瑋彥', 'M', '2013-06-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(311, '龐賢', '俊詩', 'M', '2014-05-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(312, '壤駟婉如', '宇俊', 'F', '2014-04-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(313, '邢娟', '傑', 'M', '2013-10-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(314, '慕容筱依', '婷', 'M', '2007-12-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(315, '倪依', '穎', 'F', '2005-09-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(316, '姚穎佳', '華樺', 'M', '2009-12-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(317, '太叔婉穎', '廷', 'F', '2010-05-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(318, '左丘怡', '軒', 'F', '2004-03-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(319, '全芳', '柏建', 'F', '2014-04-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(320, '厙霖承', '君樺', 'M', '2011-08-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(321, '鮑穎', '文心', 'F', '2008-04-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(322, '夏侯承宗', '郁', 'M', '2012-09-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(323, '閆嘉', '文芬', 'F', '2008-09-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(324, '聞人靜華', '佳', 'F', '2012-10-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(325, '嚴依', '賢賢', 'F', '2012-06-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(326, '融琬', '宗宏', 'M', '2012-11-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(327, '褚佳華', '依佳', 'M', '2012-06-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(328, '空宜', '家安', 'F', '2010-02-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(329, '褚彥樺', '儀', 'F', '2005-07-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(330, '隗貞蓉', '欣惠', 'F', '2010-09-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(331, '韓柏庭', '偉', 'M', '2008-05-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(332, '任婉郁', '芬', 'F', '2011-04-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(333, '麻婷', '怡', 'F', '2013-03-27', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(334, '祿翰安', '冠', 'F', '2013-10-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(335, '諸葛貞雯', '鈺儀', 'F', '2012-06-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(336, '晉哲', '美信', 'F', '2008-08-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(337, '伍娟婉', '心', 'M', '2009-02-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(338, '閆霖俊', '華詩', 'M', '2015-01-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(339, '狄琪華', '淑儀', 'M', '2011-09-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(340, '拓跋軒建', '宇安', 'M', '2005-01-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(341, '龔霖佳', '信詩', 'F', '2001-11-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(342, '弘宜', '俊心', 'M', '2003-04-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(343, '弘萍玲', '嘉宇', 'F', '2013-01-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(344, '乜雅', '承瑋', 'F', '2010-05-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(345, '莫美雯', '宏思', 'F', '2008-07-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(346, '莘豪', '思家', 'F', '2012-11-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(347, '呂鈺美', '嘉芬', 'F', '2010-07-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(348, '桑貞鈺', '宜華', 'M', '2006-12-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(349, '井庭', '婷淑', 'F', '2007-12-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(350, '計佳', '華', 'M', '2014-11-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(351, '舒俊', '心', 'F', '2007-11-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(352, '牧豪', '靜琪', 'M', '2013-05-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(353, '牛庭安', '芬琪', 'F', '2014-12-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(354, '夏侯思', '文華', 'F', '2006-02-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(355, '田鈺', '家', 'M', '2002-07-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(356, '冀芬', '傑彥', 'F', '2008-02-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(357, '孟志', '宜靜', 'F', '2015-08-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(358, '龐安', '心', 'F', '2010-08-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(359, '荀筱筑', '文豪', 'M', '2011-09-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(360, '慎依', '華', 'F', '2014-06-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(361, '水豪', '涵', 'M', '2010-08-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(362, '紅華萱', '貞鈺', 'F', '2003-11-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(363, '蘇心偉', '嘉君', 'M', '2007-12-27', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(364, '越翰', '彥豪', 'F', '2010-05-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(365, '童豪宏', '嘉穎', 'F', '2014-07-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(366, '郭詩靜', '宜郁', 'M', '2013-01-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(367, '龐佳冠', '賢', 'M', '2001-10-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(368, '鄒傑', '傑家', 'M', '2007-08-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(369, '宋雯琬', '安靜', 'F', '2012-12-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(370, '公羊怡欣', '芳嘉', 'F', '2007-07-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(371, '冀淑萱', '佳欣', 'F', '2012-10-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(372, '微生彥', '思心', 'F', '2014-01-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(373, '閆穎', '瑜', 'M', '2012-10-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(374, '梁郁靜', '婉', 'F', '2002-11-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(375, '雷佳', '玲佩', 'F', '2015-07-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(376, '公西宇佳', '佳', 'F', '2008-03-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(377, '湯華', '芳怡', 'M', '2005-10-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(378, '壤駟雯', '華志', 'F', '2009-09-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(379, '竺志銘', '宜', 'M', '2003-10-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(380, '單瑜伶', '貞芳', 'M', '2012-07-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(381, '薄郁', '傑', 'F', '2012-05-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(382, '段詩穎', '琪琬', 'M', '2002-09-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(383, '秋柏嘉', '慧', 'M', '2005-10-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(384, '宗政嘉', '如', 'M', '2007-01-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(385, '辛家思', '詩', 'F', '2012-06-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(386, '充宇', '蓉', 'F', '2012-02-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(387, '笪婉瑜', '彥', 'M', '2015-08-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(388, '乜傑偉', '美', 'F', '2015-08-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(389, '益俊', '威', 'M', '2009-12-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(390, '洪怡', '宜', 'M', '2009-09-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(391, '利豪偉', '涵', 'F', '2000-12-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(392, '宗宜彥', '萱家', 'M', '2005-02-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(393, '包樺', '宏翰', 'F', '2008-01-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(394, '姜翰宜', '依雯', 'F', '2013-12-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(395, '宣威霖', '玲依', 'F', '2002-08-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(396, '卜心', '宗威', 'M', '2008-01-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(397, '戎穎', '佩佩', 'M', '2001-08-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(398, '涂建安', '穎如', 'M', '2011-01-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(399, '褚信', '慧雯', 'F', '2002-11-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(400, '西門銘', '宜', 'F', '2004-04-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(401, '吉傑', '庭君', 'M', '2002-02-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(402, '于瑋', '依思', 'M', '2004-09-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(403, '宰父筱冠', '嘉', 'M', '2007-05-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(404, '東郭心', '威銘', 'M', '2001-05-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(405, '秋傑', '冠', 'M', '2005-07-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(406, '戈郁淑', '君美', 'M', '2002-11-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(407, '凌穎', '美美', 'F', '2010-07-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(408, '苗傑佳', '庭', 'M', '2013-05-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(409, '郝嘉瑋', '怡詩', 'M', '2010-07-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(410, '佴思', '霖安', 'M', '2006-11-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(411, '暴詩華', '傑', 'M', '2009-08-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(412, '山芳', '彥豪', 'M', '2012-03-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(413, '黨賢宇', '芬', 'F', '2004-11-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(414, '尤美', '依雅', 'M', '2002-10-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(415, '唐心翰', '君宜', 'M', '2002-10-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(416, '劉廷', '彥心', 'M', '2005-12-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(417, '孫佩', '冠', 'M', '2007-11-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(418, '魚冠心', '彥', 'M', '2012-03-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(419, '甘賢華', '思承', 'M', '2013-01-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(420, '卓瑋冠', '威軒', 'F', '2008-11-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(421, '鈕心', '信華', 'M', '2006-11-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(422, '江宗建', '瑋', 'M', '2008-06-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(423, '時志', '芳', 'F', '2004-11-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(424, '東珊庭', '宜', 'F', '2006-07-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(425, '逯鈺筱', '詩偉', 'F', '2007-02-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(426, '權馨宜', '涵', 'M', '2007-02-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(427, '雲佳', '穎霖', 'M', '2012-05-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(428, '慕容宜', '思', 'F', '2013-01-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(429, '欽宗', '美心', 'F', '2011-09-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(430, '許娟', '美', 'M', '2006-11-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(431, '璩華', '涵', 'F', '2001-11-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(432, '柴庭瑋', '佳', 'F', '2013-04-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(433, '印郁', '雯', 'F', '2005-03-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(434, '陰宇', '瑜宜', 'F', '2006-03-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(435, '周宇軒', '家思', 'F', '2003-11-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(436, '水華', '珊', 'F', '2001-12-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(437, '連筱', '慧', 'F', '2007-01-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(438, '慕建翰', '詩宜', 'F', '2013-11-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(439, '呼延鈺', '賢', 'F', '2008-04-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(440, '豐芳', '廷', 'M', '2008-07-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(441, '東方豪', '淑', 'F', '2005-03-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(442, '佘貞', '佳俊', 'M', '2005-03-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(443, '宣家傑', '琬婉', 'F', '2002-07-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(444, '時詩宗', '志志', 'F', '2009-12-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(445, '程君', '樺翰', 'F', '2004-02-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(446, '尤廷美', '雅', 'F', '2009-07-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(447, '浦淑', '瑜', 'M', '2012-08-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(448, '萬如', '嘉', 'F', '2013-07-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(449, '年家鈺', '哲建', 'F', '2013-07-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(450, '殳儀瑜', '廷', 'M', '2003-01-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(451, '蕭信', '思', 'M', '2004-05-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(452, '顧安婷', '哲霖', 'M', '2014-04-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(453, '沙穎', '琪玲', 'M', '2003-12-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(454, '牛心', '俊承', 'F', '2008-07-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(455, '宮嘉', '文', 'M', '2010-01-31', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(456, '閻霖', '家怡', 'F', '2014-01-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(457, '富惠', '豪家', 'M', '2000-12-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(458, '南宮嘉', '哲賢', 'M', '2003-03-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(459, '鍾離嘉', '芬雅', 'M', '2008-02-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(460, '相心', '傑', 'F', '2004-03-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(461, '羊舌穎', '志', 'F', '2014-12-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(462, '鈕貞', '家', 'M', '2002-03-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(463, '伍文', '華賢', 'M', '2009-11-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(464, '墨儀', '賢', 'F', '2001-10-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(465, '范廷', '彥廷', 'M', '2013-05-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(466, '賴霖', '美君', 'M', '2002-04-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(467, '慕冠偉', '郁', 'M', '2011-07-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(468, '笪郁', '廷俊', 'M', '2002-07-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(469, '柳嘉霖', '芬', 'F', '2006-11-27', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(470, '申屠惠', '雯貞', 'F', '2001-04-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(471, '邊翰', '思彥', 'F', '2013-04-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(472, '芮穎銘', '庭承', 'M', '2001-03-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(473, '阮蓉穎', '文', 'M', '2000-12-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(474, '蓬萍鈺', '慧', 'M', '2014-01-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(475, '祝志', '承廷', 'F', '2006-11-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(476, '聞人賢', '娟玲', 'M', '2009-06-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(477, '危佳', '筑', 'M', '2009-12-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(478, '魚依', '穎偉', 'M', '2014-05-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(479, '牧思', '安', 'M', '2010-09-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(480, '儲瑜思', '詩', 'F', '2009-02-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(481, '毋庭宜', '家', 'M', '2008-09-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(482, '督宏佳', '雯', 'F', '2002-05-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(483, '沙穎華', '蓉', 'F', '2012-04-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(484, '弓慧娟', '家萍', 'F', '2004-03-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(485, '殳玲筑', '儀淑', 'M', '2011-10-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(486, '管君蓉', '志華', 'F', '2004-06-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(487, '班美筑', '偉', 'F', '2013-10-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(488, '終玲', '思', 'M', '2007-05-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(489, '郗美', '安安', 'F', '2011-06-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(490, '水宜', '軒柏', 'M', '2011-06-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(491, '商庭', '宇', 'M', '2012-06-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(492, '公羊賢', '偉承', 'F', '2011-07-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(493, '司珊思', '傑', 'F', '2004-06-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(494, '葛心', '佩', 'F', '2012-05-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(495, '左丘威', '美', 'M', '2006-05-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(496, '章華佳', '佳', 'M', '2004-10-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(497, '韶欣鈺', '娟欣', 'F', '2012-11-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(498, '韶賢', '婉', 'M', '2010-04-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(499, '芮志庭', '建冠', 'F', '2000-12-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(500, '空俊文', '華依', 'M', '2011-10-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(501, '祿穎', '宗', 'M', '2000-12-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(502, '宦豪君', '宗', 'F', '2003-12-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(503, '干華玲', '承', 'M', '2001-03-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(504, '沃靜淑', '賢安', 'F', '2006-04-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(505, '方翰宏', '佩', 'M', '2005-09-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(506, '花華', '萱琪', 'M', '2005-08-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(507, '顏郁佳', '嘉信', 'F', '2003-03-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(508, '蒯樺', '思', 'F', '2005-11-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(509, '須家', '柏', 'M', '2009-06-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(510, '牧玲雅', '庭靜', 'M', '2004-04-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(511, '陰信', '偉安', 'F', '2004-12-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(512, '凌思嘉', '志', 'F', '2007-11-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(513, '符俊', '娟筱', 'M', '2001-10-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(514, '東方庭', '翰', 'F', '2002-05-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(515, '閻芳思', '怡欣', 'M', '2004-07-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(516, '法庭', '筑', 'M', '2012-03-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(517, '昝琬', '穎', 'M', '2004-03-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(518, '宮佳宗', '霖', 'M', '2006-11-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(519, '藍穎信', '庭彥', 'M', '2012-03-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(520, '晁珊', '瑋安', 'M', '2006-03-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(521, '祖涵', '文', 'M', '2011-05-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(522, '牟筱玲', '庭宇', 'M', '2008-11-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(523, '東儀惠', '如儀', 'M', '2005-10-27', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(524, '芮威宏', '文君', 'M', '2011-05-12', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(525, '連柏偉', '華霖', 'M', '2002-05-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(526, '冉庭娟', '慧', 'F', '2007-10-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(527, '鞏威', '俊', 'F', '2008-03-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(528, '楊雯冠', '琪依', 'M', '2008-06-06', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(529, '費傑', '佩', 'F', '2015-08-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(530, '支宜哲', '華安', 'F', '2012-05-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(531, '范欣', '偉', 'F', '2012-07-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(532, '邴銘', '嘉', 'M', '2008-08-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(533, '柳嘉', '郁郁', 'M', '2012-08-21', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(534, '翁穎雯', '哲賢', 'F', '2012-07-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(535, '童娟', '萱淑', 'M', '2012-03-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(536, '公冶霖', '瑜馨', 'F', '2002-05-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(537, '百里琬', '淑', 'F', '2014-08-23', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(538, '禹慧涵', '冠賢', 'F', '2009-02-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(539, '秋涵琬', '美萱', 'M', '2011-12-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(540, '陰思建', '華宏', 'M', '2013-01-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(541, '宮婉雅', '廷思', 'M', '2011-03-25', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(542, '扈心', '心', 'M', '2011-03-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(543, '焦娟', '馨', 'F', '2003-08-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(544, '巴瑋傑', '心廷', 'F', '2005-04-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(545, '鄧淑', '馨萱', 'F', '2008-01-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(546, '舒君華', '琬', 'F', '2012-11-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(547, '聶霖廷', '郁', 'M', '2001-02-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(548, '史佩', '軒', 'F', '2008-03-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(549, '司詩', '瑋', 'F', '2001-05-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(550, '闕宏', '志', 'F', '2002-09-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(551, '林宏', '宇', 'F', '2001-08-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(552, '彭詩怡', '庭', 'M', '2001-02-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(553, '喬信', '瑋', 'M', '2007-09-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(554, '宦如', '如', 'M', '2013-03-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(555, '丁嘉家', '庭詩', 'M', '2013-03-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(556, '黎安華', '馨', 'F', '2011-04-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(557, '皮美彥', '冠', 'M', '2014-04-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(558, '茅賢文', '心雯', 'F', '2002-06-13', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(559, '韓偉', '靜家', 'M', '2003-07-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(560, '甘佳伶', '彥華', 'M', '2006-08-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(561, '沙賢君', '銘柏', 'F', '2001-05-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(562, '徐樺瑋', '佳美', 'F', '2001-03-05', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(563, '蓋惠文', '鈺', 'M', '2006-06-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(564, '謝偉彥', '芳', 'M', '2015-03-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(565, '季玲家', '筑安', 'F', '2001-12-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(566, '杭建', '惠鈺', 'F', '2009-06-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(567, '安廷君', '彥翰', 'F', '2009-09-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(568, '石佳宇', '偉', 'F', '2000-12-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(569, '第五君', '志信', 'M', '2011-11-18', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(570, '晁宏佳', '芬鈺', 'F', '2010-08-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(571, '酆柏柏', '安君', 'F', '2013-03-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(572, '養賢詩', '承銘', 'M', '2003-06-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(573, '澹臺信', '家宜', 'M', '2004-07-15', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(574, '計芬穎', '冠家', 'F', '2003-10-11', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(575, '晏如蓉', '庭蓉', 'F', '2006-01-26', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(576, '樂銘', '美琬', 'F', '2006-07-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(577, '鞏鈺', '威承', 'M', '2002-04-14', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(578, '于馨', '偉建', 'F', '2015-04-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(579, '魏庭筱', '冠', 'F', '2013-03-29', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(580, '丘穎思', '心柏', 'M', '2014-12-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(581, '賞芬', '慧惠', 'M', '2005-03-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(582, '雷銘', '俊', 'M', '2013-10-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(583, '居霖佳', '華靜', 'M', '2004-01-08', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(584, '譚思', '承信', 'F', '2015-04-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(585, '康志志', '華', 'F', '2015-08-30', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(586, '匡琬', '彥', 'F', '2004-05-16', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(587, '孟軒承', '俊', 'M', '2012-02-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(588, '淳于志', '蓉琬', 'F', '2002-06-20', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(589, '程承', '君慧', 'M', '2002-08-19', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(590, '亓官涵雅', '琪', 'F', '2014-07-24', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(591, '雙琬', '郁', 'M', '2014-03-03', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(592, '唐庭', '如', 'M', '2010-10-07', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(593, '令狐安', '家', 'F', '2013-07-10', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(594, '卓廷', '樺', 'M', '2014-06-09', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(595, '沙萍靜', '宗詩', 'F', '2006-08-04', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(596, '石銘佳', '家佳', 'F', '2002-04-22', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(597, '庾彥', '鈺靜', 'F', '2014-02-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(598, '溫華', '雯貞', 'F', '2005-12-17', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(599, '沈穎賢', '穎華', 'F', '2010-09-02', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(600, '朱美', '賢', 'M', '2014-06-28', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(601, '荊佳', '涵馨', 'M', '2003-05-01', '2023-01-10 18:14:58', '2023-01-10 18:14:58'),
(602, '賁馨婷', '芬', 'M', '2004-12-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(603, '魏心柏', '華', 'M', '2009-06-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(604, '游珊欣', '宇庭', 'M', '2009-10-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(605, '阮馨', '安娟', 'F', '2009-01-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(606, '西門思貞', '樺', 'F', '2015-07-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(607, '黨宜蓉', '文', 'M', '2008-02-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(608, '養宇文', '瑋豪', 'F', '2015-06-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59');
INSERT INTO `students` (`id`, `name_zh`, `name_fn`, `gender`, `dob`, `created_at`, `updated_at`) VALUES
(609, '封承', '淑玲', 'F', '2003-11-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(610, '耿瑋', '詩美', 'M', '2002-02-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(611, '封庭', '文', 'F', '2009-06-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(612, '夾谷文', '建心', 'M', '2013-05-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(613, '程美宗', '雯', 'F', '2015-04-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(614, '藍馨', '鈺', 'M', '2002-02-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(615, '申蓉', '俊', 'F', '2012-06-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(616, '籍伶儀', '怡怡', 'F', '2002-06-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(617, '富怡', '萱庭', 'F', '2006-09-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(618, '管美華', '婷', 'M', '2002-10-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(619, '宰冠穎', '霖', 'M', '2008-11-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(620, '趙靜', '哲安', 'M', '2009-06-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(621, '單依慧', '思宇', 'M', '2005-01-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(622, '鮑玲', '淑', 'M', '2007-01-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(623, '干婉', '淑馨', 'F', '2012-01-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(624, '華家承', '芬萱', 'F', '2012-12-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(625, '儲芳筑', '霖', 'M', '2006-01-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(626, '相靜', '柏豪', 'M', '2009-10-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(627, '巢宇銘', '宇', 'F', '2011-08-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(628, '慎安怡', '宜豪', 'M', '2011-03-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(629, '羊華傑', '如', 'F', '2004-03-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(630, '司寇信志', '文宜', 'M', '2012-01-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(631, '公冶嘉雅', '涵', 'M', '2010-08-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(632, '殳詩', '宗', 'M', '2001-06-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(633, '朱庭', '蓉蓉', 'F', '2015-05-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(634, '班玲靜', '哲文', 'F', '2010-03-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(635, '吳冠', '惠', 'F', '2006-03-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(636, '隗廷', '思', 'F', '2011-04-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(637, '昝哲', '怡雯', 'M', '2014-04-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(638, '晉筱雯', '柏承', 'F', '2014-04-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(639, '勞君', '軒', 'F', '2002-04-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(640, '鈕銘瑋', '嘉宜', 'F', '2009-11-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(641, '譚穎怡', '家華', 'F', '2011-08-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(642, '那如', '美', 'F', '2009-01-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(643, '厲穎儀', '華', 'F', '2014-06-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(644, '亓官琬', '安', 'F', '2011-08-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(645, '駱惠', '安', 'F', '2007-12-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(646, '酈心淑', '萍', 'M', '2004-11-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(647, '夏侯琪安', '美', 'M', '2011-01-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(648, '公承', '貞惠', 'M', '2015-03-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(649, '郭鈺詩', '鈺貞', 'M', '2007-01-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(650, '沙鈺', '依', 'M', '2002-11-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(651, '廉琬', '芳', 'M', '2015-03-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(652, '司徒翰佳', '萍安', 'M', '2010-01-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(653, '雲鈺萍', '心', 'M', '2013-06-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(654, '文宏庭', '宜豪', 'M', '2009-05-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(655, '東家穎', '文', 'M', '2002-12-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(656, '干廷傑', '霖', 'M', '2008-12-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(657, '聶如', '俊', 'F', '2015-05-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(658, '袁琬', '文宗', 'M', '2011-03-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(659, '湯威', '庭文', 'M', '2003-02-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(660, '祖詩', '華', 'F', '2015-05-21', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(661, '公思靜', '靜', 'M', '2009-10-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(662, '公冶建', '建嘉', 'F', '2002-02-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(663, '詹賢', '惠', 'M', '2003-06-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(664, '常哲賢', '軒', 'F', '2013-08-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(665, '呼延琬', '哲', 'M', '2008-10-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(666, '宓冠詩', '軒', 'M', '2002-08-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(667, '澹臺信', '傑彥', 'F', '2010-06-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(668, '賞賢', '俊嘉', 'F', '2004-11-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(669, '岑傑宜', '心', 'M', '2002-09-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(670, '邴宜伶', '冠', 'M', '2002-07-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(671, '鄒豪', '華美', 'F', '2013-08-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(672, '巴樺', '傑宜', 'F', '2002-10-17', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(673, '宰安', '庭', 'M', '2002-02-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(674, '蔡嘉', '涵', 'F', '2012-03-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(675, '牛彥宗', '傑霖', 'F', '2014-12-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(676, '張承嘉', '安建', 'M', '2012-09-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(677, '席銘君', '涵儀', 'F', '2014-05-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(678, '萬文', '珊欣', 'F', '2003-05-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(679, '梁筑佩', '心', 'M', '2014-09-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(680, '陶宜佩', '思', 'F', '2006-12-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(681, '越家', '君思', 'F', '2001-04-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(682, '巢銘豪', '偉俊', 'F', '2008-04-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(683, '賴穎柏', '庭宇', 'F', '2005-02-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(684, '夏華威', '華文', 'F', '2002-12-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(685, '冀銘', '筱雯', 'M', '2013-12-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(686, '琴志', '偉', 'F', '2006-03-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(687, '危柏柏', '萍', 'M', '2014-12-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(688, '諸俊柏', '萱', 'M', '2002-11-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(689, '儲珊伶', '萍', 'F', '2004-06-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(690, '閆馨', '心婉', 'M', '2001-01-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(691, '孟嘉信', '淑嘉', 'M', '2002-10-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(692, '杜賢廷', '君', 'F', '2012-09-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(693, '計心樺', '心', 'F', '2002-08-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(694, '廖宜詩', '玲', 'M', '2006-12-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(695, '墨樺柏', '宜', 'F', '2014-03-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(696, '單于惠', '豪', 'M', '2003-04-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(697, '麻淑華', '君', 'M', '2004-11-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(698, '豐慧', '穎文', 'F', '2005-12-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(699, '和廷', '華', 'M', '2004-01-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(700, '宗軒樺', '君', 'M', '2014-06-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(701, '洪宗承', '賢穎', 'F', '2004-03-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(702, '皇甫筑', '宜怡', 'M', '2003-05-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(703, '岳萍', '珊雯', 'M', '2005-12-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(704, '澹臺信宗', '華冠', 'M', '2009-03-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(705, '晏君銘', '家婷', 'M', '2009-09-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(706, '焦哲建', '安君', 'F', '2011-04-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(707, '田美', '芬蓉', 'M', '2002-01-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(708, '仉琬佳', '翰志', 'M', '2004-06-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(709, '帥庭', '雅', 'F', '2003-03-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(710, '禹志', '庭', 'M', '2006-10-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(711, '劉承', '廷', 'F', '2015-05-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(712, '茹貞婉', '婉', 'M', '2003-07-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(713, '晉蓉筱', '傑', 'M', '2012-10-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(714, '金宇', '佳穎', 'F', '2008-04-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(715, '危穎婉', '瑜', 'M', '2005-01-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(716, '盛蓉安', '宜', 'M', '2015-07-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(717, '蓋儀儀', '君彥', 'M', '2007-07-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(718, '屠冠伶', '惠', 'M', '2005-10-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(719, '殳銘君', '佩華', 'M', '2014-11-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(720, '東惠', '婉珊', 'F', '2015-04-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(721, '鞠軒', '涵', 'F', '2011-02-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(722, '相芬儀', '軒', 'F', '2007-10-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(723, '湛軒家', '淑婷', 'M', '2009-08-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(724, '益文美', '承嘉', 'F', '2015-08-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(725, '譚信', '詩宏', 'F', '2009-02-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(726, '郜筱', '心', 'F', '2008-02-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(727, '融鈺萱', '翰偉', 'F', '2012-11-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(728, '咸涵', '庭', 'M', '2007-08-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(729, '薊華威', '文筱', 'M', '2004-11-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(730, '舒美傑', '樺心', 'M', '2006-08-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(731, '黃思哲', '雅', 'F', '2003-01-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(732, '段嘉', '蓉', 'F', '2015-03-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(733, '巫詩', '依', 'M', '2013-07-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(734, '米信', '佳', 'M', '2013-12-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(735, '楊瑜珊', '宏', 'F', '2011-11-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(736, '寇安', '華', 'M', '2015-02-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(737, '慕容穎', '芳', 'M', '2014-01-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(738, '巫文思', '思', 'M', '2005-06-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(739, '季詩賢', '君', 'M', '2005-12-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(740, '汪豪', '嘉', 'F', '2008-11-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(741, '越琪宜', '娟美', 'M', '2010-02-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(742, '上官萱怡', '建宇', 'F', '2003-09-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(743, '宗雅', '儀', 'M', '2011-02-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(744, '婁穎冠', '銘宇', 'F', '2003-07-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(745, '虞筱筑', '宗俊', 'M', '2014-12-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(746, '焦美', '豪宗', 'F', '2012-06-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(747, '汝君美', '安軒', 'F', '2011-07-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(748, '韶嘉', '庭', 'M', '2006-05-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(749, '淳于傑豪', '玲芬', 'M', '2004-07-21', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(750, '常君', '婉安', 'M', '2013-06-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(751, '莘傑安', '萍', 'M', '2006-10-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(752, '易鈺芳', '銘', 'M', '2002-06-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(753, '范娟', '安珊', 'M', '2015-06-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(754, '段干怡', '翰家', 'F', '2015-03-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(755, '俞建', '靜', 'F', '2012-02-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(756, '湛穎', '淑', 'M', '2014-10-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(757, '婁鈺如', '婷心', 'F', '2002-05-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(758, '龐傑銘', '如穎', 'F', '2010-11-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(759, '龍馨美', '嘉', 'M', '2006-03-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(760, '申宇', '思柏', 'F', '2015-04-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(761, '呂思芳', '豪霖', 'F', '2014-05-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(762, '茅豪', '雅', 'F', '2006-06-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(763, '宓宗樺', '慧靜', 'F', '2013-02-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(764, '苗瑜佩', '思', 'F', '2008-04-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(765, '海心婉', '瑜宜', 'M', '2011-03-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(766, '譙佩', '柏', 'M', '2007-08-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(767, '胡惠', '傑安', 'F', '2004-05-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(768, '商廷軒', '如華', 'M', '2001-02-17', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(769, '戈華', '偉威', 'F', '2010-04-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(770, '佴穎', '俊', 'F', '2006-01-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(771, '平哲', '瑋', 'M', '2003-10-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(772, '歐陽惠詩', '惠淑', 'F', '2005-09-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(773, '申屠樺心', '豪俊', 'M', '2012-05-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(774, '勞思', '心', 'M', '2015-01-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(775, '璩軒豪', '萍萱', 'F', '2010-07-17', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(776, '蓋思', '承佳', 'M', '2014-10-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(777, '鄭文佳', '詩思', 'F', '2012-09-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(778, '韋冠', '慧', 'M', '2004-08-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(779, '從建', '信', 'M', '2011-01-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(780, '宗淑', '怡', 'F', '2006-09-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(781, '應宜', '彥', 'M', '2010-06-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(782, '長孫筱佩', '威', 'M', '2001-12-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(783, '譙建傑', '冠', 'M', '2014-11-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(784, '融思安', '軒', 'F', '2002-04-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(785, '水柏安', '家', 'M', '2007-02-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(786, '司馬宜庭', '豪', 'F', '2005-05-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(787, '東門詩', '宜君', 'M', '2011-08-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(788, '緱君君', '琪', 'F', '2011-10-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(789, '隆詩賢', '君偉', 'M', '2015-03-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(790, '宮安', '鈺', 'M', '2006-11-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(791, '況筑雯', '美', 'F', '2009-11-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(792, '干安', '宏', 'M', '2004-07-17', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(793, '杭建美', '依欣', 'M', '2013-03-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(794, '路娟', '威文', 'M', '2009-04-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(795, '鮮于彥', '彥', 'F', '2011-05-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(796, '潘郁郁', '蓉', 'M', '2009-05-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(797, '司寇俊', '涵', 'M', '2002-10-21', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(798, '桑婷', '庭雅', 'M', '2005-02-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(799, '滑豪', '偉俊', 'F', '2001-09-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(800, '沃思筑', '芳美', 'F', '2005-08-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(801, '步郁穎', '家', 'F', '2004-09-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(802, '祿傑銘', '美翰', 'F', '2006-03-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(803, '席詩', '惠', 'F', '2011-04-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(804, '袁宇', '宜', 'F', '2001-09-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(805, '尹儀芳', '琪文', 'M', '2003-06-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(806, '緱靜', '嘉', 'F', '2002-07-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(807, '蒼安怡', '馨', 'F', '2013-01-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(808, '琴筱', '華冠', 'M', '2014-11-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(809, '靳芬婷', '靜', 'M', '2001-09-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(810, '簡哲', '俊', 'M', '2015-07-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(811, '蔡宏', '玲嘉', 'F', '2002-10-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(812, '郟淑', '哲', 'M', '2010-09-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(813, '俞庭惠', '娟', 'F', '2006-01-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(814, '夔惠', '詩霖', 'M', '2007-08-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(815, '陳穎瑜', '詩', 'M', '2011-08-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(816, '邊琪', '佳宏', 'M', '2013-11-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(817, '竇伶', '筑', 'F', '2003-01-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(818, '裘詩瑋', '冠', 'M', '2004-06-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(819, '黃慧依', '文伶', 'F', '2013-01-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(820, '弓宜', '建', 'M', '2001-11-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(821, '施柏', '雅家', 'F', '2004-02-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(822, '韶宏彥', '慧', 'F', '2004-04-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(823, '林詩霖', '承宏', 'M', '2003-09-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(824, '桑思', '宜賢', 'F', '2002-11-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(825, '諸葛安家', '心', 'M', '2002-09-17', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(826, '督嘉', '豪志', 'F', '2010-08-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(827, '亢欣怡', '傑安', 'F', '2001-08-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(828, '盛文思', '銘', 'M', '2004-04-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(829, '郁賢軒', '萍馨', 'M', '2002-08-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(830, '帥佳賢', '文', 'F', '2002-02-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(831, '緱瑋軒', '霖銘', 'F', '2011-02-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(832, '富貞怡', '佳欣', 'F', '2011-02-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(833, '姚承', '佩', 'F', '2013-06-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(834, '金冠', '詩承', 'F', '2011-09-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(835, '單思', '家', 'F', '2013-03-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(836, '薊家銘', '貞婷', 'M', '2008-04-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(837, '福萍', '詩', 'F', '2008-08-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(838, '支翰', '銘', 'M', '2012-01-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(839, '苗美', '翰承', 'M', '2011-01-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(840, '鍾彥豪', '彥彥', 'M', '2010-12-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(841, '逄冠如', '心穎', 'M', '2010-10-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(842, '欽威', '瑋豪', 'M', '2008-08-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(843, '辛宜', '雅', 'M', '2001-10-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(844, '許筑怡', '銘', 'M', '2011-08-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(845, '莫嘉玲', '安安', 'F', '2003-12-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(846, '舒涵', '彥', 'F', '2004-07-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(847, '狄娟筑', '宜', 'M', '2007-12-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(848, '濮陽傑穎', '美怡', 'F', '2009-01-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(849, '言筱', '宗', 'M', '2002-06-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(850, '崔如', '依', 'M', '2004-01-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(851, '申屠心', '哲嘉', 'F', '2005-11-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(852, '魚文', '霖', 'M', '2002-05-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(853, '宗哲', '依', 'F', '2013-04-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(854, '單于怡心', '瑜惠', 'M', '2005-08-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(855, '熊廷', '宜', 'F', '2014-09-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(856, '厲佳', '廷哲', 'M', '2012-01-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(857, '麴家', '美傑', 'F', '2006-09-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(858, '羊舌樺哲', '蓉安', 'F', '2007-06-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(859, '元文', '柏志', 'M', '2000-10-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(860, '裴安', '哲翰', 'M', '2013-05-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(861, '尤穎', '傑', 'F', '2006-09-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(862, '習筱', '娟', 'F', '2010-10-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(863, '刁霖', '偉冠', 'M', '2013-07-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(864, '全俊', '瑜慧', 'F', '2008-01-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(865, '衛宜靜', '佳美', 'F', '2005-09-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(866, '符美美', '依', 'M', '2014-08-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(867, '司徒淑珊', '文', 'F', '2003-08-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(868, '賀軒信', '珊宜', 'M', '2010-10-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(869, '周豪', '彥佳', 'M', '2008-09-21', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(870, '鳳芬', '欣', 'M', '2003-07-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(871, '洪華志', '嘉君', 'M', '2010-07-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(872, '牛雅靜', '君', 'M', '2014-08-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(873, '荀萍', '冠', 'M', '2006-04-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(874, '竺賢', '佳翰', 'F', '2014-08-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(875, '益華柏', '家', 'M', '2013-11-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(876, '紅豪', '志', 'M', '2003-11-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(877, '冉宗信', '哲瑋', 'F', '2010-05-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(878, '雲安嘉', '宇軒', 'F', '2009-01-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(879, '鄒思', '賢', 'M', '2011-04-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(880, '晉宜萱', '霖', 'F', '2009-11-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(881, '伏嘉文', '銘', 'F', '2011-05-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(882, '沃馨萱', '軒', 'F', '2004-05-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(883, '段干文廷', '宜', 'F', '2002-04-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(884, '刁欣', '馨', 'F', '2010-09-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(885, '謝宏', '宏俊', 'F', '2007-12-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(886, '弘婷佳', '嘉', 'F', '2003-01-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(887, '韋賢', '心', 'F', '2006-01-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(888, '伏怡瑜', '彥', 'F', '2014-11-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(889, '朱文心', '欣', 'M', '2003-01-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(890, '申屠穎', '安心', 'F', '2001-08-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(891, '燕彥', '美雅', 'M', '2006-10-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(892, '燕欣思', '穎', 'M', '2003-01-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(893, '楊思伶', '冠涵', 'F', '2009-04-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(894, '慎華', '伶', 'F', '2002-10-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(895, '宇文筑怡', '彥', 'M', '2003-11-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(896, '東郭惠靜', '嘉', 'F', '2003-08-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(897, '雍心穎', '廷思', 'M', '2010-04-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(898, '阮文', '美', 'M', '2007-09-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(899, '賞雅', '傑銘', 'F', '2007-05-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(900, '暨美淑', '廷', 'M', '2013-05-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(901, '常家庭', '雅', 'F', '2000-12-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(902, '莫君', '穎', 'M', '2008-02-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(903, '微生珊', '伶', 'F', '2005-04-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(904, '許思', '淑', 'F', '2015-06-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(905, '莊惠淑', '婷萍', 'F', '2014-12-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(906, '蓬涵', '家', 'M', '2007-10-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(907, '茅思', '嘉', 'F', '2002-04-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(908, '夔冠詩', '琪', 'M', '2013-02-06', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(909, '貝家建', '芳', 'M', '2003-07-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(910, '辛美慧', '君嘉', 'F', '2010-03-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(911, '秦馨淑', '宜', 'M', '2012-12-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(912, '花琪宜', '馨冠', 'F', '2009-05-20', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(913, '扈瑜', '冠偉', 'M', '2014-05-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(914, '都俊安', '宗', 'F', '2006-11-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(915, '衡芬芳', '伶', 'F', '2011-11-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(916, '欽君傑', '庭玲', 'F', '2004-03-05', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(917, '葛宜', '珊佩', 'M', '2009-04-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(918, '戎銘', '柏', 'M', '2007-12-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(919, '鄭穎琬', '華庭', 'M', '2003-10-12', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(920, '祝文君', '建承', 'M', '2010-10-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(921, '梁慧芬', '怡', 'F', '2007-07-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(922, '史冠', '筑', 'M', '2013-12-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(923, '束冠', '君', 'F', '2013-07-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(924, '赫連瑜依', '芳', 'F', '2004-09-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(925, '湯靜', '佩鈺', 'F', '2013-08-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(926, '韋宜', '豪宇', 'F', '2010-08-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(927, '孟儀', '淑', 'F', '2008-08-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(928, '廉賢君', '儀琪', 'F', '2006-02-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(929, '歸文威', '婷欣', 'F', '2013-11-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(930, '包庭家', '瑋', 'M', '2015-04-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(931, '庾筱', '銘', 'M', '2011-08-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(932, '湯軒哲', '宜', 'F', '2002-02-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(933, '農伶', '貞欣', 'F', '2006-06-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(934, '樂儀', '華', 'M', '2007-08-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(935, '明宇', '宜志', 'F', '2014-12-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(936, '墨詩琬', '瑜', 'F', '2007-11-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(937, '甯佳信', '君', 'F', '2005-08-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(938, '後儀', '嘉', 'M', '2011-08-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(939, '幸嘉佳', '霖', 'M', '2007-01-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(940, '佴萍', '庭賢', 'M', '2013-12-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(941, '方佩華', '文', 'F', '2013-09-26', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(942, '蘇鈺', '君瑋', 'F', '2014-05-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(943, '咸欣文', '珊', 'M', '2013-09-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(944, '陰萱雅', '蓉珊', 'F', '2012-07-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(945, '聶穎冠', '哲', 'F', '2004-11-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(946, '勞廷', '婷', 'M', '2012-02-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(947, '逯庭', '翰賢', 'M', '2013-09-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(948, '申傑', '宜', 'M', '2011-04-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(949, '狄佳柏', '心筑', 'F', '2006-07-10', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(950, '卜銘華', '靜', 'M', '2010-05-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(951, '連嘉', '靜安', 'M', '2009-05-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(952, '愛建', '儀', 'M', '2006-01-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(953, '能軒霖', '宇', 'M', '2007-11-07', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(954, '鈄雅家', '琬雅', 'F', '2008-07-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(955, '鬱詩華', '庭', 'F', '2002-11-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(956, '沈宇信', '心涵', 'F', '2006-03-22', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(957, '倪志', '庭', 'M', '2005-08-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(958, '鄢彥華', '華瑜', 'M', '2002-07-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(959, '丁娟', '華珊', 'F', '2003-09-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(960, '梁丘淑', '偉豪', 'F', '2001-06-30', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(961, '權詩偉', '琪庭', 'M', '2000-09-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(962, '酈俊瑋', '芬美', 'F', '2014-01-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(963, '黨冠', '宜玲', 'F', '2004-01-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(964, '顧美儀', '伶筑', 'F', '2012-12-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(965, '駱志威', '軒', 'F', '2009-01-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(966, '祝安芳', '嘉', 'M', '2010-11-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(967, '宗政偉信', '柏彥', 'M', '2011-03-27', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(968, '微生庭佳', '家佩', 'F', '2010-09-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(969, '蓋廷柏', '建安', 'M', '2014-12-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(970, '緱心', '涵', 'M', '2001-10-15', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(971, '宗嘉', '信賢', 'M', '2010-11-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(972, '江詩賢', '君思', 'M', '2009-03-25', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(973, '公蓉', '婷', 'M', '2006-04-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(974, '壽佳', '宏', 'F', '2001-05-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(975, '閔翰', '珊琪', 'F', '2003-11-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(976, '馬文', '郁', 'M', '2004-05-19', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(977, '曾馨', '穎思', 'M', '2004-03-29', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(978, '朱琬冠', '軒威', 'M', '2009-04-21', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(979, '程華佳', '芳玲', 'F', '2013-11-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(980, '別詩', '賢思', 'M', '2011-02-14', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(981, '安琪如', '萍', 'F', '2011-08-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(982, '喻冠樺', '穎豪', 'M', '2001-07-02', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(983, '管威', '嘉靜', 'F', '2010-01-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(984, '宦芬心', '靜', 'M', '2006-08-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(985, '欽家', '心', 'F', '2011-07-03', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(986, '陳娟', '廷心', 'M', '2013-11-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(987, '元冠', '哲威', 'F', '2010-05-23', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(988, '霍翰', '欣婷', 'M', '2010-07-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(989, '鄧珊華', '庭', 'M', '2001-12-28', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(990, '車惠', '哲', 'F', '2011-12-31', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(991, '裘思華', '欣芳', 'M', '2007-12-04', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(992, '聞人銘信', '宇', 'F', '2014-02-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(993, '魯詩樺', '宗思', 'F', '2004-06-16', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(994, '鄒樺宏', '君宜', 'F', '2011-02-18', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(995, '董家宜', '心軒', 'F', '2004-02-09', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(996, '燕貞', '樺', 'M', '2010-08-01', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(997, '冀宗美', '哲', 'F', '2003-10-11', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(998, '蘇庭思', '信', 'F', '2003-07-13', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(999, '郭欣珊', '雯婷', 'M', '2007-08-24', '2023-01-10 18:14:59', '2023-01-10 18:14:59'),
(1000, '諸葛庭安', '慧瑜', 'F', '2001-07-08', '2023-01-10 18:14:59', '2023-01-10 18:14:59');

-- --------------------------------------------------------

--
-- Estrutura da tabela `student_details`
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
-- Estrutura da tabela `student_gardians`
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
-- Estrutura da tabela `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grade_id` bigint(20) NOT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `stream` varchar(6) DEFAULT NULL,
  `elective` varchar(6) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `subject_template_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `subjects`
--

INSERT INTO `subjects` (`id`, `grade_id`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `description`, `active`, `subject_template_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:36:09', '2023-01-19 00:36:59'),
(2, 1, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:36:09', '2023-01-19 00:36:59'),
(7, 1, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(8, 1, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(9, 1, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(10, 1, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(11, 1, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(12, 1, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(13, 1, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(14, 1, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(15, 1, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(16, 1, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(17, 1, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(18, 1, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(19, 1, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:36:59', '2023-01-19 00:36:59'),
(22, 2, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(23, 2, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(24, 2, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(25, 2, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(26, 2, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(27, 2, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(28, 2, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(29, 2, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(30, 2, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(31, 2, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(32, 2, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(33, 2, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(34, 2, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(35, 2, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(36, 2, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:55:09', '2023-01-19 00:55:09'),
(37, 3, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(38, 3, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(39, 3, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(40, 3, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(41, 3, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(42, 3, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(43, 3, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(44, 3, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(45, 3, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(46, 3, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(47, 3, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(48, 3, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(49, 3, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(50, 3, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(51, 3, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:55:40', '2023-01-19 00:55:40'),
(52, 25, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(53, 25, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(54, 25, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(55, 25, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(56, 25, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(57, 25, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(58, 25, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(59, 25, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(60, 25, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(61, 25, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(62, 25, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(63, 25, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(64, 25, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(65, 25, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(66, 25, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:55:50', '2023-01-19 00:55:50'),
(67, 7, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(68, 7, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(69, 7, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(70, 7, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(71, 7, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(72, 7, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(73, 7, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(74, 7, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(75, 7, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(76, 7, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(77, 7, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(78, 7, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(79, 7, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(80, 7, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(81, 7, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:55:58', '2023-01-19 00:55:58'),
(82, 8, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(83, 8, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(84, 8, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(85, 8, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(86, 8, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(87, 8, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(88, 8, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(89, 8, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(90, 8, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(91, 8, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(92, 8, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(93, 8, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(94, 8, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(95, 8, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(96, 8, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:56:08', '2023-01-19 00:56:08'),
(97, 4, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(98, 4, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(99, 4, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(100, 4, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(101, 4, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(102, 4, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(103, 4, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(104, 4, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(105, 4, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(106, 4, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(107, 4, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(108, 4, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(109, 4, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(110, 4, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(111, 4, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:56:25', '2023-01-19 00:56:25'),
(112, 9, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(113, 9, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(114, 9, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(115, 9, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(116, 9, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(117, 9, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(118, 9, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(119, 9, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(120, 9, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(121, 9, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(122, 9, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(123, 9, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(124, 9, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(125, 9, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(126, 9, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:56:37', '2023-01-19 00:56:37'),
(127, 10, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(128, 10, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(129, 10, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(130, 10, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(131, 10, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(132, 10, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(133, 10, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(134, 10, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(135, 10, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(136, 10, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(137, 10, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(138, 10, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(139, 10, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(140, 10, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(141, 10, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:56:46', '2023-01-19 00:56:46'),
(142, 11, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(143, 11, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(144, 11, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(145, 11, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(146, 11, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(147, 11, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(148, 11, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(149, 11, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(150, 11, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(151, 11, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(152, 11, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(153, 11, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(154, 11, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(155, 11, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(156, 11, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 00:56:55', '2023-01-19 00:56:55'),
(157, 12, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, 1, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(158, 12, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, 2, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(159, 12, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, 3, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(160, 12, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, 4, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(161, 12, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, 5, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(162, 12, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, 7, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(163, 12, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, 8, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(164, 12, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, 9, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(165, 12, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, 10, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(166, 12, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, 11, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(167, 12, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, 12, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(168, 12, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, 13, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(169, 12, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, 14, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(170, 12, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, 15, '2023-01-19 01:18:32', '2023-01-19 01:18:32'),
(171, 12, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, 16, '2023-01-19 01:18:32', '2023-01-19 01:18:32');

-- --------------------------------------------------------

--
-- Estrutura da tabela `subject_templates`
--

CREATE TABLE `subject_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `type` varchar(3) DEFAULT NULL,
  `stream` varchar(3) DEFAULT NULL,
  `elective` varchar(3) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `subject_templates`
--

INSERT INTO `subject_templates` (`id`, `code`, `title_zh`, `title_en`, `type`, `stream`, `elective`, `description`, `active`, `version`, `created_at`, `updated_at`) VALUES
(1, 'REL', '宗教', 'Relegion', 'SUB', 'LIB', 'COP', NULL, 1, '1', NULL, '2023-01-18 20:27:12'),
(2, 'PHY', '體能', 'Physic', 'SUB', 'LIB', 'COP', NULL, 1, '', NULL, '2023-01-17 23:21:47'),
(3, 'CLT', '語文', 'Chinese Literature', 'SUB', 'LIB', 'COP', NULL, 1, '', NULL, '2023-01-17 23:29:03'),
(4, 'STY', '故事', 'Stry', 'SUB', 'LIB', 'COP', NULL, 1, '', NULL, '2023-01-17 23:23:22'),
(5, 'CWR', '中寫', 'Chinse_writting', 'SUB', 'LIB', 'COP', NULL, 1, '', NULL, '2023-01-17 23:28:02'),
(6, 'ELT', '英文', 'English Literature', 'SUB', 'LIB', 'COP', NULL, NULL, '', '2023-01-17 23:40:21', '2023-01-17 23:40:21'),
(7, 'EWR', '英寫', 'English Writing', 'SUB', 'LIB', 'COP', NULL, 1, '', '2023-01-17 23:41:34', '2023-01-17 23:41:34'),
(8, 'OCS', '常識', 'Ordinary Common Sense', 'SUB', 'LIB', 'COP', NULL, 1, '', '2023-01-17 23:44:50', '2023-01-17 23:44:50'),
(9, 'NUM', '識數', 'Numeracy', 'SUB', 'LIB', 'COP', NULL, 1, '', '2023-01-17 23:45:21', '2023-01-17 23:45:21'),
(10, 'COM', '電腦', 'Computer', 'SUB', 'LIB', 'COP', NULL, 1, '', '2023-01-17 23:46:45', '2023-01-17 23:46:45'),
(11, 'PLA', 'Playgroup', '唱遊', 'SUB', 'LIB', 'COP', NULL, 1, '', '2023-01-17 23:47:01', '2023-01-17 23:47:01'),
(12, 'ART', '美勞', 'Art Craft', 'SUB', 'LIB', 'COP', NULL, 1, '', '2023-01-17 23:47:23', '2023-01-17 23:47:23'),
(13, 'ATT', '生活習慣和態度', 'Habits and Attitudes', 'SUB', 'LIB', 'COP', NULL, 1, NULL, '2023-01-18 20:36:28', '2023-01-18 20:36:28'),
(14, 'RPLA', '獎懲遲缺', 'Reword Punishment  Late and Absent', 'SUB', 'LIB', 'COP', NULL, 1, NULL, '2023-01-18 20:39:21', '2023-01-18 20:40:15'),
(15, 'LES', '餘暇活動', 'Leisure Activies', 'SUB', 'LIB', 'COP', NULL, 1, NULL, '2023-01-18 20:39:41', '2023-01-18 20:39:41'),
(16, 'OVA', '總體評分', 'Overall Score', 'SUB', 'LIB', 'COP', NULL, 1, NULL, '2023-01-18 20:41:57', '2023-01-18 20:41:57');

-- --------------------------------------------------------

--
-- Estrutura da tabela `suppliers`
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
-- Estrutura da tabela `teachers`
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
-- Extraindo dados da tabela `teachers`
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
-- Estrutura da tabela `teams`
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
-- Extraindo dados da tabela `teams`
--

INSERT INTO `teams` (`id`, `user_id`, `name`, `personal_team`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin\'s Team', 1, '2023-01-10 18:15:01', '2023-01-10 18:15:01');

-- --------------------------------------------------------

--
-- Estrutura da tabela `team_invitations`
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
-- Estrutura da tabela `team_user`
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
-- Estrutura da tabela `transcripts`
--

CREATE TABLE `transcripts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_student_id` bigint(20) NOT NULL,
  `column` enum('PSN','T1','T2','T3','T4','T1E','T1P','T1A','T2E','T2P','T2A','T3E','T3P','T3A','T4E','T4P','T4A','FIN') NOT NULL,
  `category` enum('PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL') NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `transcripts`
--

INSERT INTO `transcripts` (`id`, `klass_student_id`, `column`, `category`, `field_name`, `field_value`, `created_at`, `updated_at`) VALUES
(1, 1, 'T1', 'PERSONAL', 'name_ch', 'TEST name_ch', NULL, NULL),
(2, 1, 'T1', 'PERSONAL', 'name_fn', 'TEST name_fn', NULL, NULL),
(3, 1, 'T1', 'PERSONAL', 'academic_year', 'TEST academic_year', NULL, NULL),
(4, 1, 'T1', 'PERSONAL', 'grade_class', 'TEST grade_class', NULL, NULL),
(5, 1, 'T1', 'PERSONAL', 'student_number', 'TEST student_number', NULL, NULL),
(6, 1, 'T1', 'PERSONAL', 'id_number', 'TEST id_number', NULL, NULL),
(7, 1, 'T1', 'PERSONAL', 'issue_date', 'TEST issue_date', NULL, NULL),
(8, 1, 'T1E', 'SUBJECT', 'religion', '55', NULL, NULL),
(9, 1, 'T1E', 'SUBJECT', 'chinese_literature', '96', NULL, NULL),
(10, 1, 'T1E', 'SUBJECT', 'common_sense', '51', NULL, NULL),
(11, 1, 'T1E', 'SUBJECT', 'story', '36', NULL, NULL),
(12, 1, 'T1E', 'SUBJECT', 'chinese_writing', '53', NULL, NULL),
(13, 1, 'T1E', 'SUBJECT', 'numeracy', '93', NULL, NULL),
(14, 1, 'T1E', 'SUBJECT', 'english_reading', '25', NULL, NULL),
(15, 1, 'T1E', 'SUBJECT', 'english_writing', '10', NULL, NULL),
(16, 1, 'T1E', 'SUBJECT', 'computer', '61', NULL, NULL),
(17, 1, 'T1E', 'SUBJECT', 'mandarin', '77', NULL, NULL),
(18, 1, 'T1E', 'SUBJECT', 'art_craft', '14', NULL, NULL),
(19, 1, 'T1E', 'SUBJECT', 'playgroup', '55', NULL, NULL),
(20, 1, 'T1E', 'SUBJECT', 'physical_fitness', '50', NULL, NULL),
(21, 1, 'T1P', 'SUBJECT', 'religion', '61', NULL, NULL),
(22, 1, 'T1P', 'SUBJECT', 'chinese_literature', '85', NULL, NULL),
(23, 1, 'T1P', 'SUBJECT', 'common_sense', '55', NULL, NULL),
(24, 1, 'T1P', 'SUBJECT', 'story', '58', NULL, NULL),
(25, 1, 'T1P', 'SUBJECT', 'chinese_writing', '1', NULL, NULL),
(26, 1, 'T1P', 'SUBJECT', 'numeracy', '76', NULL, NULL),
(27, 1, 'T1P', 'SUBJECT', 'english_reading', '22', NULL, NULL),
(28, 1, 'T1P', 'SUBJECT', 'english_writing', '98', NULL, NULL),
(29, 1, 'T1P', 'SUBJECT', 'computer', '14', NULL, NULL),
(30, 1, 'T1P', 'SUBJECT', 'mandarin', '28', NULL, NULL),
(31, 1, 'T1P', 'SUBJECT', 'art_craft', '62', NULL, NULL),
(32, 1, 'T1P', 'SUBJECT', 'playgroup', '66', NULL, NULL),
(33, 1, 'T1P', 'SUBJECT', 'physical_fitness', '91', NULL, NULL),
(34, 1, 'T1A', 'SUBJECT', 'religion', '40', NULL, NULL),
(35, 1, 'T1A', 'SUBJECT', 'chinese_literature', '32', NULL, NULL),
(36, 1, 'T1A', 'SUBJECT', 'common_sense', '27', NULL, NULL),
(37, 1, 'T1A', 'SUBJECT', 'story', '54', NULL, NULL),
(38, 1, 'T1A', 'SUBJECT', 'chinese_writing', '31', NULL, NULL),
(39, 1, 'T1A', 'SUBJECT', 'numeracy', '8', NULL, NULL),
(40, 1, 'T1A', 'SUBJECT', 'english_reading', '80', NULL, NULL),
(41, 1, 'T1A', 'SUBJECT', 'english_writing', '2', NULL, NULL),
(42, 1, 'T1A', 'SUBJECT', 'computer', '33', NULL, NULL),
(43, 1, 'T1A', 'SUBJECT', 'mandarin', '77', NULL, NULL),
(44, 1, 'T1A', 'SUBJECT', 'art_craft', '81', NULL, NULL),
(45, 1, 'T1A', 'SUBJECT', 'playgroup', '56', NULL, NULL),
(46, 1, 'T1A', 'SUBJECT', 'physical_fitness', '13', NULL, NULL),
(47, 1, 'T2E', 'SUBJECT', 'religion', '32', NULL, NULL),
(48, 1, 'T2E', 'SUBJECT', 'chinese_literature', '45', NULL, NULL),
(49, 1, 'T2E', 'SUBJECT', 'common_sense', '17', NULL, NULL),
(50, 1, 'T2E', 'SUBJECT', 'story', '81', NULL, NULL),
(51, 1, 'T2E', 'SUBJECT', 'chinese_writing', '41', NULL, NULL),
(52, 1, 'T2E', 'SUBJECT', 'numeracy', '87', NULL, NULL),
(53, 1, 'T2E', 'SUBJECT', 'english_reading', '28', NULL, NULL),
(54, 1, 'T2E', 'SUBJECT', 'english_writing', '62', NULL, NULL),
(55, 1, 'T2E', 'SUBJECT', 'computer', '75', NULL, NULL),
(56, 1, 'T2E', 'SUBJECT', 'mandarin', '3', NULL, NULL),
(57, 1, 'T2E', 'SUBJECT', 'art_craft', '26', NULL, NULL),
(58, 1, 'T2E', 'SUBJECT', 'playgroup', '69', NULL, NULL),
(59, 1, 'T2E', 'SUBJECT', 'physical_fitness', '6', NULL, NULL),
(60, 1, 'T2P', 'SUBJECT', 'religion', '71', NULL, NULL),
(61, 1, 'T2P', 'SUBJECT', 'chinese_literature', '91', NULL, NULL),
(62, 1, 'T2P', 'SUBJECT', 'common_sense', '66', NULL, NULL),
(63, 1, 'T2P', 'SUBJECT', 'story', '57', NULL, NULL),
(64, 1, 'T2P', 'SUBJECT', 'chinese_writing', '72', NULL, NULL),
(65, 1, 'T2P', 'SUBJECT', 'numeracy', '42', NULL, NULL),
(66, 1, 'T2P', 'SUBJECT', 'english_reading', '20', NULL, NULL),
(67, 1, 'T2P', 'SUBJECT', 'english_writing', '93', NULL, NULL),
(68, 1, 'T2P', 'SUBJECT', 'computer', '67', NULL, NULL),
(69, 1, 'T2P', 'SUBJECT', 'mandarin', '78', NULL, NULL),
(70, 1, 'T2P', 'SUBJECT', 'art_craft', '42', NULL, NULL),
(71, 1, 'T2P', 'SUBJECT', 'playgroup', '8', NULL, NULL),
(72, 1, 'T2P', 'SUBJECT', 'physical_fitness', '23', NULL, NULL),
(73, 1, 'T2A', 'SUBJECT', 'religion', '37', NULL, NULL),
(74, 1, 'T2A', 'SUBJECT', 'chinese_literature', '62', NULL, NULL),
(75, 1, 'T2A', 'SUBJECT', 'common_sense', '98', NULL, NULL),
(76, 1, 'T2A', 'SUBJECT', 'story', '38', NULL, NULL),
(77, 1, 'T2A', 'SUBJECT', 'chinese_writing', '93', NULL, NULL),
(78, 1, 'T2A', 'SUBJECT', 'numeracy', '60', NULL, NULL),
(79, 1, 'T2A', 'SUBJECT', 'english_reading', '97', NULL, NULL),
(80, 1, 'T2A', 'SUBJECT', 'english_writing', '45', NULL, NULL),
(81, 1, 'T2A', 'SUBJECT', 'computer', '100', NULL, NULL),
(82, 1, 'T2A', 'SUBJECT', 'mandarin', '55', NULL, NULL),
(83, 1, 'T2A', 'SUBJECT', 'art_craft', '15', NULL, NULL),
(84, 1, 'T2A', 'SUBJECT', 'playgroup', '75', NULL, NULL),
(85, 1, 'T2A', 'SUBJECT', 'physical_fitness', '48', NULL, NULL),
(86, 1, 'FIN', 'SUBJECT', 'religion', '66', NULL, NULL),
(87, 1, 'FIN', 'SUBJECT', 'chinese_literature', '51', NULL, NULL),
(88, 1, 'FIN', 'SUBJECT', 'common_sense', '55', NULL, NULL),
(89, 1, 'FIN', 'SUBJECT', 'story', '99', NULL, NULL),
(90, 1, 'FIN', 'SUBJECT', 'chinese_writing', '95', NULL, NULL),
(91, 1, 'FIN', 'SUBJECT', 'numeracy', '85', NULL, NULL),
(92, 1, 'FIN', 'SUBJECT', 'english_reading', '82', NULL, NULL),
(93, 1, 'FIN', 'SUBJECT', 'english_writing', '96', NULL, NULL),
(94, 1, 'FIN', 'SUBJECT', 'computer', '90', NULL, NULL),
(95, 1, 'FIN', 'SUBJECT', 'mandarin', '82', NULL, NULL),
(96, 1, 'FIN', 'SUBJECT', 'art_craft', '67', NULL, NULL),
(97, 1, 'FIN', 'SUBJECT', 'playgroup', '56', NULL, NULL),
(98, 1, 'FIN', 'SUBJECT', 'physical_fitness', '83', NULL, NULL),
(99, 1, 'T1', 'ATTITUDE', 'health_1', 'A', NULL, NULL),
(100, 1, 'T1', 'ATTITUDE', 'health_2', 'A', NULL, NULL),
(101, 1, 'T1', 'ATTITUDE', 'health_3', 'A', NULL, NULL),
(102, 1, 'T1', 'ATTITUDE', 'health_4', 'A', NULL, NULL),
(103, 1, 'T1', 'ATTITUDE', 'health_5', 'A', NULL, NULL),
(104, 1, 'T1', 'ATTITUDE', 'behaviour_1', 'A', NULL, NULL),
(105, 1, 'T1', 'ATTITUDE', 'behaviour_2', 'A', NULL, NULL),
(106, 1, 'T1', 'ATTITUDE', 'behaviour_3', 'A', NULL, NULL),
(107, 1, 'T1', 'ATTITUDE', 'behaviour_4', 'A', NULL, NULL),
(108, 1, 'T1', 'ATTITUDE', 'behaviour_5', 'A', NULL, NULL),
(109, 1, 'T1', 'ATTITUDE', 'behaviour_6', 'A', NULL, NULL),
(110, 1, 'T1', 'ATTITUDE', 'social_1', 'A', NULL, NULL),
(111, 1, 'T1', 'ATTITUDE', 'social_2', 'A', NULL, NULL),
(112, 1, 'T1', 'ATTITUDE', 'social_3', 'A', NULL, NULL),
(113, 1, 'T1', 'ATTITUDE', 'social_4', 'A', NULL, NULL),
(114, 1, 'T1', 'ATTITUDE', 'social_5', 'A', NULL, NULL),
(115, 1, 'T2', 'ATTITUDE', 'health_1', 'B', NULL, NULL),
(116, 1, 'T2', 'ATTITUDE', 'health_2', 'B', NULL, NULL),
(117, 1, 'T2', 'ATTITUDE', 'health_3', 'B', NULL, NULL),
(118, 1, 'T2', 'ATTITUDE', 'health_4', 'B', NULL, NULL),
(119, 1, 'T2', 'ATTITUDE', 'health_5', 'B', NULL, NULL),
(120, 1, 'T2', 'ATTITUDE', 'behaviour_1', 'B', NULL, NULL),
(121, 1, 'T2', 'ATTITUDE', 'behaviour_2', 'B', NULL, NULL),
(122, 1, 'T2', 'ATTITUDE', 'behaviour_3', 'B', NULL, NULL),
(123, 1, 'T2', 'ATTITUDE', 'behaviour_4', 'B', NULL, NULL),
(124, 1, 'T2', 'ATTITUDE', 'behaviour_5', 'B', NULL, NULL),
(125, 1, 'T2', 'ATTITUDE', 'behaviour_6', 'B', NULL, NULL),
(126, 1, 'T2', 'ATTITUDE', 'social_1', 'B', NULL, NULL),
(127, 1, 'T2', 'ATTITUDE', 'social_2', 'B', NULL, NULL),
(128, 1, 'T2', 'ATTITUDE', 'social_3', 'B', NULL, NULL),
(129, 1, 'T2', 'ATTITUDE', 'social_4', 'B', NULL, NULL),
(130, 1, 'T2', 'ATTITUDE', 'social_5', 'B', NULL, NULL),
(131, 1, 'T1', 'SUMMARY', 'total_score', '31', NULL, NULL),
(132, 1, 'T1', 'SUMMARY', 'average_score', '13', NULL, NULL),
(133, 1, 'T1', 'SUMMARY', 'class_size', '56', NULL, NULL),
(134, 1, 'T1', 'SUMMARY', 'ranking', '47', NULL, NULL),
(135, 1, 'T1', 'SUMMARY', 'late', '61', NULL, NULL),
(136, 1, 'T1', 'SUMMARY', 'absent', '59', NULL, NULL),
(137, 1, 'T2', 'SUMMARY', 'total_score', '39', NULL, NULL),
(138, 1, 'T2', 'SUMMARY', 'average_score', '69', NULL, NULL),
(139, 1, 'T2', 'SUMMARY', 'class_size', '56', NULL, NULL),
(140, 1, 'T2', 'SUMMARY', 'ranking', '49', NULL, NULL),
(141, 1, 'T2', 'SUMMARY', 'late', '61', NULL, NULL),
(142, 1, 'T2', 'SUMMARY', 'absent', '26', NULL, NULL),
(143, 1, 'FIN', 'SUMMARY', 'total_score', '81', NULL, NULL),
(144, 1, 'FIN', 'SUMMARY', 'average_score', '45', NULL, NULL),
(145, 1, 'FIN', 'SUMMARY', 'class_size', '38', NULL, NULL),
(146, 1, 'FIN', 'SUMMARY', 'ranking', '3', NULL, NULL),
(147, 1, 'FIN', 'SUMMARY', 'late', '67', NULL, NULL),
(148, 1, 'FIN', 'SUMMARY', 'absent', '93', NULL, NULL),
(149, 1, 'T1', 'GENERAL', 'comment', 'T1 Comment', NULL, NULL),
(150, 1, 'T2', 'GENERAL', 'comment', 'T2 Coment', NULL, NULL),
(151, 1, 'T1', 'GENERAL', 'reward_punishment', 'T1 reward punishment', NULL, NULL),
(152, 1, 'T2', 'GENERAL', 'reward_punishment', 'T2 reward punishment', NULL, NULL),
(153, 1, 'T1', 'GENERAL', 'leisure_name', 'T1 leisure name', NULL, NULL),
(154, 1, 'T2', 'GENERAL', 'leisure_name', 'T2 leisure name', NULL, NULL),
(155, 1, 'T1', 'GENERAL', 'leisure_performance', 'T1 leisure performance', NULL, NULL),
(156, 1, 'T2', 'GENERAL', 'leisure_performance', 'T2 leisure performance', NULL, NULL),
(157, 1, 'T1', 'GENERAL', 'remark', 'T1 remark', NULL, NULL),
(158, 1, 'T2', 'GENERAL', 'remark', 'T2 remark', NULL, NULL),
(159, 1, 'FIN', 'GENERAL', 'remark', 'FIN remark', NULL, NULL),
(160, 1, 'FIN', 'GENERAL', 'appraisal', 'FIN Appraisal', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `transcript_templates`
--

CREATE TABLE `transcript_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `klass_id` bigint(20) NOT NULL,
  `category` enum('PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL') NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `title_zh` varchar(255) DEFAULT NULL,
  `title_en` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `transcript_templates`
--

INSERT INTO `transcript_templates` (`id`, `klass_id`, `category`, `field_name`, `title_zh`, `title_en`, `created_at`, `updated_at`) VALUES
(1, 1, 'PERSONAL', 'name_ch', '姓名中文', NULL, NULL, NULL),
(2, 1, 'PERSONAL', 'name_fn', '姓名外文', NULL, NULL, NULL),
(3, 1, 'PERSONAL', 'academic_year', '年度', NULL, NULL, NULL),
(4, 1, 'PERSONAL', 'grade_class', '級別', NULL, NULL, NULL),
(5, 1, 'PERSONAL', 'student_number', '學生證編號', NULL, NULL, NULL),
(6, 1, 'PERSONAL', 'id_number', '身份證編號', NULL, NULL, NULL),
(7, 1, 'PERSONAL', 'issue_date', '簽發日期', NULL, NULL, NULL),
(8, 1, 'SUBJECT', 'religion', '宗教', NULL, NULL, NULL),
(9, 1, 'SUBJECT', 'chinese_literature', '語文', NULL, NULL, NULL),
(10, 1, 'SUBJECT', 'common_sense', '常識', NULL, NULL, NULL),
(11, 1, 'SUBJECT', 'story', '故事', NULL, NULL, NULL),
(12, 1, 'SUBJECT', 'chinese_writing', '中寫', NULL, NULL, NULL),
(13, 1, 'SUBJECT', 'numeracy', '識數', NULL, NULL, NULL),
(14, 1, 'SUBJECT', 'english_reading', '讀本', NULL, NULL, NULL),
(15, 1, 'SUBJECT', 'english_writing', '英寫', NULL, NULL, NULL),
(16, 1, 'SUBJECT', 'computer', '電腦', NULL, NULL, NULL),
(17, 1, 'SUBJECT', 'mandarin', '普通話', NULL, NULL, NULL),
(18, 1, 'SUBJECT', 'art_craft', '美勞', NULL, NULL, NULL),
(19, 1, 'SUBJECT', 'playgroup', '唱遊', NULL, NULL, NULL),
(20, 1, 'SUBJECT', 'physical_fitness', '體能', NULL, NULL, NULL),
(21, 1, 'ATTITUDE', 'health_1', '衣服鞋襪整齊清潔', NULL, NULL, NULL),
(22, 1, 'ATTITUDE', 'health_2', '常剪指甲', NULL, NULL, NULL),
(23, 1, 'ATTITUDE', 'health_3', '懂得使用手帕或紙巾', NULL, NULL, NULL),
(24, 1, 'ATTITUDE', 'health_4', '不把手指雜物放進口裡', NULL, NULL, NULL),
(25, 1, 'ATTITUDE', 'health_5', '能把癈物投入廢紙箱內', NULL, NULL, NULL),
(26, 1, 'ATTITUDE', 'behaviour_1', '守秩序不喧嚷', NULL, NULL, NULL),
(27, 1, 'ATTITUDE', 'behaviour_2', '留心聽講', NULL, NULL, NULL),
(28, 1, 'ATTITUDE', 'behaviour_3', '坐立行走姿勢正確', NULL, NULL, NULL),
(29, 1, 'ATTITUDE', 'behaviour_4', '離開坐位把物件桌椅整理好', NULL, NULL, NULL),
(30, 1, 'ATTITUDE', 'behaviour_5', '愛護公物用後放回原處', NULL, NULL, NULL),
(31, 1, 'ATTITUDE', 'behaviour_6', '遵守校規', NULL, NULL, NULL),
(32, 1, 'ATTITUDE', 'social_1', '守時', NULL, NULL, NULL),
(33, 1, 'ATTITUDE', 'social_2', '尊敬師長,友愛和睦', NULL, NULL, NULL),
(34, 1, 'ATTITUDE', 'social_3', '樂於助人', NULL, NULL, NULL),
(35, 1, 'ATTITUDE', 'social_4', '會和別人分享及輪侯', NULL, NULL, NULL),
(36, 1, 'ATTITUDE', 'social_5', '誠實坦白肯認錯', NULL, NULL, NULL),
(37, 1, 'SUMMARY', 'total_score', '總分', NULL, NULL, NULL),
(38, 1, 'SUMMARY', 'average_score', '平均分', NULL, NULL, NULL),
(39, 1, 'SUMMARY', 'class_size', '全班人數', NULL, NULL, NULL),
(40, 1, 'SUMMARY', 'ranking', '考列名次', NULL, NULL, NULL),
(41, 1, 'SUMMARY', 'late', '遲到次數', NULL, NULL, NULL),
(42, 1, 'SUMMARY', 'absent', '缺席節數', NULL, NULL, NULL),
(43, 1, 'GENERAL', 'comment', '評語', NULL, NULL, NULL),
(44, 1, 'GENERAL', 'reward_punishment', '奬懲記錄', NULL, NULL, NULL),
(45, 1, 'GENERAL', 'leisure_name', '餘暇活動名稱', NULL, NULL, NULL),
(46, 1, 'GENERAL', 'leisure_performance', '餘暇活動表現', NULL, NULL, NULL),
(47, 1, 'GENERAL', 'remark', '備註', NULL, NULL, NULL),
(48, 1, 'GENERAL', 'appraisal', '學年評定', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
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
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@admin.com', NULL, '$2y$10$mFWu.U1se1GycJxbk8DldOGbOcTFp2VOViom3/3s40nOcrbUNHZ52', NULL, NULL, NULL, NULL, 1, NULL, '2023-01-10 18:15:01', '2023-01-10 20:28:30');

-- --------------------------------------------------------

--
-- Estrutura da tabela `years`
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
-- Extraindo dados da tabela `years`
--

INSERT INTO `years` (`id`, `code`, `title`, `description`, `meta`, `transcript`, `start`, `end`, `active`, `created_at`, `updated_at`) VALUES
(1, '2021', '2021-2022', NULL, NULL, NULL, '2021-09-01', '2022-07-30', 1, NULL, '2023-01-10 18:14:57'),
(2, '2022', '2022-2023', NULL, NULL, NULL, '2022-09-01', '2023-07-30', 0, NULL, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `klass_subject` (`klass_id`,`code`);

--
-- Índices para tabela `course_scores`
--
ALTER TABLE `course_scores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `course_teachers`
--
ALTER TABLE `course_teachers`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `disciplines`
--
ALTER TABLE `disciplines`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Índices para tabela `gardians`
--
ALTER TABLE `gardians`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `guardians`
--
ALTER TABLE `guardians`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `healthcares`
--
ALTER TABLE `healthcares`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `identity_documents`
--
ALTER TABLE `identity_documents`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `klasses`
--
ALTER TABLE `klasses`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `klass_students`
--
ALTER TABLE `klass_students`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Índices para tabela `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Índices para tabela `parentals`
--
ALTER TABLE `parentals`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Índices para tabela `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Índices para tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Índices para tabela `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Índices para tabela `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Índices para tabela `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `score_columns`
--
ALTER TABLE `score_columns`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Índices para tabela `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `student_details`
--
ALTER TABLE `student_details`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `student_gardians`
--
ALTER TABLE `student_gardians`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subjects_grade_id_code_unique` (`grade_id`,`code`);

--
-- Índices para tabela `subject_templates`
--
ALTER TABLE `subject_templates`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teams_user_id_index` (`user_id`);

--
-- Índices para tabela `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_invitations_team_id_email_unique` (`team_id`,`email`);

--
-- Índices para tabela `team_user`
--
ALTER TABLE `team_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `team_user_team_id_user_id_unique` (`team_id`,`user_id`);

--
-- Índices para tabela `transcripts`
--
ALTER TABLE `transcripts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `transcript_templates`
--
ALTER TABLE `transcript_templates`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Índices para tabela `years`
--
ALTER TABLE `years`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `configs`
--
ALTER TABLE `configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de tabela `course_scores`
--
ALTER TABLE `course_scores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `course_teachers`
--
ALTER TABLE `course_teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `disciplines`
--
ALTER TABLE `disciplines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `gardians`
--
ALTER TABLE `gardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `grades`
--
ALTER TABLE `grades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `guardians`
--
ALTER TABLE `guardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `healthcares`
--
ALTER TABLE `healthcares`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `identity_documents`
--
ALTER TABLE `identity_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `klasses`
--
ALTER TABLE `klasses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT de tabela `klass_students`
--
ALTER TABLE `klass_students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1261;

--
-- AUTO_INCREMENT de tabela `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de tabela `parentals`
--
ALTER TABLE `parentals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `scores`
--
ALTER TABLE `scores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT de tabela `score_columns`
--
ALTER TABLE `score_columns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `staff`
--
ALTER TABLE `staff`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de tabela `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT de tabela `student_details`
--
ALTER TABLE `student_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `student_gardians`
--
ALTER TABLE `student_gardians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT de tabela `subject_templates`
--
ALTER TABLE `subject_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de tabela `teams`
--
ALTER TABLE `teams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `team_invitations`
--
ALTER TABLE `team_invitations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `team_user`
--
ALTER TABLE `team_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `transcripts`
--
ALTER TABLE `transcripts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT de tabela `transcript_templates`
--
ALTER TABLE `transcript_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `years`
--
ALTER TABLE `years`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `team_invitations`
--
ALTER TABLE `team_invitations`
  ADD CONSTRAINT `team_invitations_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
