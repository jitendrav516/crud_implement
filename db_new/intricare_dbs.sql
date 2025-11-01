-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 01, 2025 at 10:34 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `intricare_dbs`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `additional_file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_merged` tinyint(1) NOT NULL DEFAULT 0,
  `merged_into` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `phone`, `gender`, `profile_image`, `additional_file`, `created_at`, `updated_at`, `is_merged`, `merged_into`) VALUES
(1, 'jitendra vema', 'jitendrav516@gmail.com', '09319802669', 'male', 'contacts/profile/Bu2UeEMF6fV7r28xGwQtRxYrWzpQBKFQmhYVJ7ac.jpg', 'contacts/files/m0TXqmkbGWqVJ1yWYubESlIxkFJvnwrLv35noySt.pdf', '2025-11-01 00:40:45', '2025-11-01 01:41:25', 1, 3),
(2, 'sachin', 'sachinn2@mailnesia.com', '09319802660', 'male', 'contacts/profile/khB3ZzA6bOiU9oHsS6o7bmSfyBnSVzDdHdgBjFQy.jpg', 'contacts/files/iCVUtOvsibB7c2WV3SuvHdXPWGigGyw5caqz7Zxp.pdf', '2025-11-01 00:48:11', '2025-11-01 01:10:35', 1, 1),
(3, 'vishal sharma', 'vishalsharma11@gmail.com', '09319802667', 'male', 'contacts/profile/Qg1ZaF9Rb0FN3UdGsyOBm1tYRxLzhA2gpwn4U0wA.jpg', 'contacts/files/vZyIMneKg1wzpdZGKKZrd4MM6IK4Z8nNPVMGU4SB.pdf', '2025-11-01 01:13:22', '2025-11-01 01:13:22', 0, NULL),
(5, 'satendra pal', 'satendra.singh@mailnesia.com', '9876543211', 'male', 'contacts/profile/fWAMLhmxi96NWuBBmQNFqHZKBbTJzSL14NlAXhm7.jpg', 'contacts/files/51SA0iLXSFi4BjXeMD7ulRH2ZFxwalwnQrdNCm59.pdf', '2025-11-01 03:54:09', '2025-11-01 03:54:48', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `contact_emails`
--

CREATE TABLE `contact_emails` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contact_id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_emails`
--

INSERT INTO `contact_emails` (`id`, `contact_id`, `email`, `is_primary`, `created_at`, `updated_at`) VALUES
(1, 1, 'sachinn2@mailnesia.com', 0, '2025-11-01 01:10:35', '2025-11-01 01:10:35'),
(2, 3, 'sachinn2@mailnesia.com', 0, '2025-11-01 01:13:57', '2025-11-01 01:13:57'),
(3, 3, 'jitendrav516@gmail.com', 0, '2025-11-01 01:13:57', '2025-11-01 01:13:57'),
(4, 3, 'satendra.singh@mailnesia.com', 0, '2025-11-01 03:54:48', '2025-11-01 03:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `contact_merge_logs`
--

CREATE TABLE `contact_merge_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `master_contact_id` bigint(20) UNSIGNED NOT NULL,
  `secondary_contact_id` bigint(20) UNSIGNED NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`payload`)),
  `merged_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_merge_logs`
--

INSERT INTO `contact_merge_logs` (`id`, `master_contact_id`, `secondary_contact_id`, `payload`, `merged_at`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '{\"master_before\":{\"id\":1,\"name\":\"jitendra vema\",\"email\":\"jitendrav516@gmail.com\",\"phone\":\"09319802669\",\"gender\":\"male\",\"profile_image\":\"contacts\\/profile\\/qffuA78GhNaBnipjrRvx61X3der4lTrW8fkIA9rA.jpg\",\"additional_file\":\"contacts\\/files\\/odDujnUZofs71r1mYCE7B7TLYwJS0bB8UGLJ2Jhg.pdf\",\"created_at\":\"2025-11-01T06:10:45.000000Z\",\"updated_at\":\"2025-11-01T06:10:45.000000Z\",\"is_merged\":0,\"merged_into\":null,\"custom_values\":[],\"emails\":[],\"phones\":[]},\"secondary_before\":{\"id\":2,\"name\":\"sachin\",\"email\":\"sachinn2@mailnesia.com\",\"phone\":\"09319802660\",\"gender\":\"male\",\"profile_image\":\"contacts\\/profile\\/khB3ZzA6bOiU9oHsS6o7bmSfyBnSVzDdHdgBjFQy.jpg\",\"additional_file\":\"contacts\\/files\\/iCVUtOvsibB7c2WV3SuvHdXPWGigGyw5caqz7Zxp.pdf\",\"created_at\":\"2025-11-01T06:18:11.000000Z\",\"updated_at\":\"2025-11-01T06:18:11.000000Z\",\"is_merged\":0,\"merged_into\":null,\"custom_values\":[{\"id\":1,\"contact_id\":2,\"field_definition_id\":1,\"value\":\"2025-11-01\",\"created_at\":\"2025-11-01T06:18:11.000000Z\",\"updated_at\":\"2025-11-01T06:18:11.000000Z\",\"definition\":{\"id\":1,\"label\":\"Birthday\",\"field_key\":\"Birthday\",\"type\":\"date\",\"options\":null,\"created_at\":\"2025-11-01T06:11:17.000000Z\",\"updated_at\":\"2025-11-01T06:11:17.000000Z\"}}],\"emails\":[],\"phones\":[]},\"emails_added\":[{\"contact_id\":1,\"email\":\"sachinn2@mailnesia.com\",\"is_primary\":false,\"updated_at\":\"2025-11-01T06:40:35.000000Z\",\"created_at\":\"2025-11-01T06:40:35.000000Z\",\"id\":1}],\"phones_added\":[{\"contact_id\":1,\"phone\":\"09319802660\",\"is_primary\":false,\"updated_at\":\"2025-11-01T06:40:35.000000Z\",\"created_at\":\"2025-11-01T06:40:35.000000Z\",\"id\":1}],\"custom_fields_copied\":[{\"key\":\"Birthday\",\"value\":\"2025-11-01\"}],\"custom_fields_conflicts\":[]}', '2025-11-01 01:10:35', '2025-11-01 01:10:35', '2025-11-01 01:10:35'),
(2, 3, 1, '{\"master_before\":{\"id\":3,\"name\":\"vishal sharma\",\"email\":\"vishalsharma11@gmail.com\",\"phone\":\"09319802667\",\"gender\":\"male\",\"profile_image\":\"contacts\\/profile\\/Qg1ZaF9Rb0FN3UdGsyOBm1tYRxLzhA2gpwn4U0wA.jpg\",\"additional_file\":\"contacts\\/files\\/vZyIMneKg1wzpdZGKKZrd4MM6IK4Z8nNPVMGU4SB.pdf\",\"created_at\":\"2025-11-01T06:43:22.000000Z\",\"updated_at\":\"2025-11-01T06:43:22.000000Z\",\"is_merged\":0,\"merged_into\":null,\"custom_values\":[{\"id\":3,\"contact_id\":3,\"field_definition_id\":1,\"value\":\"2004-06-03\",\"created_at\":\"2025-11-01T06:43:22.000000Z\",\"updated_at\":\"2025-11-01T06:43:22.000000Z\",\"definition\":{\"id\":1,\"label\":\"Birthday\",\"field_key\":\"Birthday\",\"type\":\"date\",\"options\":null,\"created_at\":\"2025-11-01T06:11:17.000000Z\",\"updated_at\":\"2025-11-01T06:11:17.000000Z\"}}],\"emails\":[],\"phones\":[]},\"secondary_before\":{\"id\":1,\"name\":\"jitendra vema\",\"email\":\"jitendrav516@gmail.com\",\"phone\":\"09319802669\",\"gender\":\"male\",\"profile_image\":\"contacts\\/profile\\/qffuA78GhNaBnipjrRvx61X3der4lTrW8fkIA9rA.jpg\",\"additional_file\":\"contacts\\/files\\/odDujnUZofs71r1mYCE7B7TLYwJS0bB8UGLJ2Jhg.pdf\",\"created_at\":\"2025-11-01T06:10:45.000000Z\",\"updated_at\":\"2025-11-01T06:10:45.000000Z\",\"is_merged\":0,\"merged_into\":null,\"custom_values\":[{\"id\":2,\"contact_id\":1,\"field_definition_id\":1,\"value\":\"2025-11-01\",\"created_at\":\"2025-11-01T06:40:35.000000Z\",\"updated_at\":\"2025-11-01T06:40:35.000000Z\",\"definition\":{\"id\":1,\"label\":\"Birthday\",\"field_key\":\"Birthday\",\"type\":\"date\",\"options\":null,\"created_at\":\"2025-11-01T06:11:17.000000Z\",\"updated_at\":\"2025-11-01T06:11:17.000000Z\"}}],\"emails\":[{\"id\":1,\"contact_id\":1,\"email\":\"sachinn2@mailnesia.com\",\"is_primary\":0,\"created_at\":\"2025-11-01T06:40:35.000000Z\",\"updated_at\":\"2025-11-01T06:40:35.000000Z\"}],\"phones\":[{\"id\":1,\"contact_id\":1,\"phone\":\"09319802660\",\"is_primary\":0,\"created_at\":\"2025-11-01T06:40:35.000000Z\",\"updated_at\":\"2025-11-01T06:40:35.000000Z\"}]},\"emails_added\":[{\"contact_id\":3,\"email\":\"sachinn2@mailnesia.com\",\"is_primary\":false,\"updated_at\":\"2025-11-01T06:43:57.000000Z\",\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"id\":2},{\"contact_id\":3,\"email\":\"jitendrav516@gmail.com\",\"is_primary\":false,\"updated_at\":\"2025-11-01T06:43:57.000000Z\",\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"id\":3}],\"phones_added\":[{\"contact_id\":3,\"phone\":\"09319802660\",\"is_primary\":false,\"updated_at\":\"2025-11-01T06:43:57.000000Z\",\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"id\":2},{\"contact_id\":3,\"phone\":\"09319802669\",\"is_primary\":false,\"updated_at\":\"2025-11-01T06:43:57.000000Z\",\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"id\":3}],\"custom_fields_copied\":[],\"custom_fields_conflicts\":[{\"key\":\"Birthday\",\"master_value\":\"2004-06-03\",\"secondary_value\":\"2025-11-01\"}]}', '2025-11-01 01:13:57', '2025-11-01 01:13:57', '2025-11-01 01:13:57'),
(3, 3, 5, '{\"master_before\":{\"id\":3,\"name\":\"vishal sharma\",\"email\":\"vishalsharma11@gmail.com\",\"phone\":\"09319802667\",\"gender\":\"male\",\"profile_image\":\"contacts\\/profile\\/Qg1ZaF9Rb0FN3UdGsyOBm1tYRxLzhA2gpwn4U0wA.jpg\",\"additional_file\":\"contacts\\/files\\/vZyIMneKg1wzpdZGKKZrd4MM6IK4Z8nNPVMGU4SB.pdf\",\"created_at\":\"2025-11-01T06:43:22.000000Z\",\"updated_at\":\"2025-11-01T06:43:22.000000Z\",\"is_merged\":0,\"merged_into\":null,\"custom_values\":[{\"id\":3,\"contact_id\":3,\"field_definition_id\":1,\"value\":\"2004-06-03\",\"created_at\":\"2025-11-01T06:43:22.000000Z\",\"updated_at\":\"2025-11-01T06:43:22.000000Z\",\"definition\":{\"id\":1,\"label\":\"Birthday\",\"field_key\":\"Birthday\",\"type\":\"date\",\"options\":null,\"created_at\":\"2025-11-01T06:11:17.000000Z\",\"updated_at\":\"2025-11-01T06:11:17.000000Z\"}}],\"emails\":[{\"id\":3,\"contact_id\":3,\"email\":\"jitendrav516@gmail.com\",\"is_primary\":0,\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"updated_at\":\"2025-11-01T06:43:57.000000Z\"},{\"id\":2,\"contact_id\":3,\"email\":\"sachinn2@mailnesia.com\",\"is_primary\":0,\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"updated_at\":\"2025-11-01T06:43:57.000000Z\"}],\"phones\":[{\"id\":2,\"contact_id\":3,\"phone\":\"09319802660\",\"is_primary\":0,\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"updated_at\":\"2025-11-01T06:43:57.000000Z\"},{\"id\":3,\"contact_id\":3,\"phone\":\"09319802669\",\"is_primary\":0,\"created_at\":\"2025-11-01T06:43:57.000000Z\",\"updated_at\":\"2025-11-01T06:43:57.000000Z\"}]},\"secondary_before\":{\"id\":5,\"name\":\"satendra pal\",\"email\":\"satendra.singh@mailnesia.com\",\"phone\":\"9876543211\",\"gender\":\"male\",\"profile_image\":\"contacts\\/profile\\/fWAMLhmxi96NWuBBmQNFqHZKBbTJzSL14NlAXhm7.jpg\",\"additional_file\":\"contacts\\/files\\/51SA0iLXSFi4BjXeMD7ulRH2ZFxwalwnQrdNCm59.pdf\",\"created_at\":\"2025-11-01T09:24:09.000000Z\",\"updated_at\":\"2025-11-01T09:24:09.000000Z\",\"is_merged\":0,\"merged_into\":null,\"custom_values\":[{\"id\":5,\"contact_id\":5,\"field_definition_id\":1,\"value\":\"2006-06-07\",\"created_at\":\"2025-11-01T09:24:09.000000Z\",\"updated_at\":\"2025-11-01T09:24:09.000000Z\",\"definition\":{\"id\":1,\"label\":\"Birthday\",\"field_key\":\"Birthday\",\"type\":\"date\",\"options\":null,\"created_at\":\"2025-11-01T06:11:17.000000Z\",\"updated_at\":\"2025-11-01T06:11:17.000000Z\"}},{\"id\":6,\"contact_id\":5,\"field_definition_id\":2,\"value\":\"test\",\"created_at\":\"2025-11-01T09:24:09.000000Z\",\"updated_at\":\"2025-11-01T09:24:09.000000Z\",\"definition\":{\"id\":2,\"label\":\"Health\",\"field_key\":\"health\",\"type\":\"textarea\",\"options\":null,\"created_at\":\"2025-11-01T09:23:05.000000Z\",\"updated_at\":\"2025-11-01T09:23:05.000000Z\"}}],\"emails\":[],\"phones\":[]},\"emails_added\":[{\"contact_id\":3,\"email\":\"satendra.singh@mailnesia.com\",\"is_primary\":false,\"updated_at\":\"2025-11-01T09:24:48.000000Z\",\"created_at\":\"2025-11-01T09:24:48.000000Z\",\"id\":4}],\"phones_added\":[{\"contact_id\":3,\"phone\":\"9876543211\",\"is_primary\":false,\"updated_at\":\"2025-11-01T09:24:48.000000Z\",\"created_at\":\"2025-11-01T09:24:48.000000Z\",\"id\":4}],\"custom_fields_copied\":[{\"key\":\"health\",\"value\":\"test\"}],\"custom_fields_conflicts\":[{\"key\":\"Birthday\",\"master_value\":\"2004-06-03\",\"secondary_value\":\"2006-06-07\"}]}', '2025-11-01 03:54:48', '2025-11-01 03:54:48', '2025-11-01 03:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `contact_phones`
--

CREATE TABLE `contact_phones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contact_id` bigint(20) UNSIGNED NOT NULL,
  `phone` varchar(255) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_phones`
--

INSERT INTO `contact_phones` (`id`, `contact_id`, `phone`, `is_primary`, `created_at`, `updated_at`) VALUES
(1, 1, '09319802660', 0, '2025-11-01 01:10:35', '2025-11-01 01:10:35'),
(2, 3, '09319802660', 0, '2025-11-01 01:13:57', '2025-11-01 01:13:57'),
(3, 3, '09319802669', 0, '2025-11-01 01:13:57', '2025-11-01 01:13:57'),
(4, 3, '9876543211', 0, '2025-11-01 03:54:48', '2025-11-01 03:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `custom_field_definitions`
--

CREATE TABLE `custom_field_definitions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `label` varchar(255) NOT NULL,
  `field_key` varchar(255) NOT NULL,
  `type` enum('text','textarea','date','number','select') NOT NULL DEFAULT 'text',
  `options` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_field_definitions`
--

INSERT INTO `custom_field_definitions` (`id`, `label`, `field_key`, `type`, `options`, `created_at`, `updated_at`) VALUES
(1, 'Birthday', 'Birthday', 'date', NULL, '2025-11-01 00:41:17', '2025-11-01 00:41:17'),
(2, 'Health', 'health', 'textarea', NULL, '2025-11-01 03:53:05', '2025-11-01 03:53:05');

-- --------------------------------------------------------

--
-- Table structure for table `custom_field_values`
--

CREATE TABLE `custom_field_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contact_id` bigint(20) UNSIGNED NOT NULL,
  `field_definition_id` bigint(20) UNSIGNED NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_field_values`
--

INSERT INTO `custom_field_values` (`id`, `contact_id`, `field_definition_id`, `value`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2025-11-01', '2025-11-01 00:48:11', '2025-11-01 00:48:11'),
(2, 1, 1, '2025-11-01', '2025-11-01 01:10:35', '2025-11-01 01:10:35'),
(3, 3, 1, '2004-06-03', '2025-11-01 01:13:22', '2025-11-01 01:13:22'),
(5, 5, 1, '2006-06-07', '2025-11-01 03:54:09', '2025-11-01 03:54:09'),
(6, 5, 2, 'test', '2025-11-01 03:54:09', '2025-11-01 03:54:09'),
(7, 3, 2, 'test', '2025-11-01 03:54:48', '2025-11-01 03:54:48');

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
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_11_01_054835_create_contacts_table', 1),
(6, '2025_11_01_054844_create_custom_field_definitions_table', 1),
(7, '2025_11_01_054851_create_custom_field_values_table', 1),
(8, '2025_11_01_062436_create_contact_emails_table', 2),
(9, '2025_11_01_062445_create_contact_phones_table', 2),
(10, '2025_11_01_062453_add_merge_fields_and_log_table', 2);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_merged_into_index` (`merged_into`);

--
-- Indexes for table `contact_emails`
--
ALTER TABLE `contact_emails`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contact_emails_contact_id_email_unique` (`contact_id`,`email`),
  ADD KEY `contact_emails_contact_id_index` (`contact_id`),
  ADD KEY `contact_emails_email_index` (`email`);

--
-- Indexes for table `contact_merge_logs`
--
ALTER TABLE `contact_merge_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contact_merge_logs_master_contact_id_index` (`master_contact_id`),
  ADD KEY `contact_merge_logs_secondary_contact_id_index` (`secondary_contact_id`);

--
-- Indexes for table `contact_phones`
--
ALTER TABLE `contact_phones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contact_phones_contact_id_phone_unique` (`contact_id`,`phone`),
  ADD KEY `contact_phones_contact_id_index` (`contact_id`),
  ADD KEY `contact_phones_phone_index` (`phone`);

--
-- Indexes for table `custom_field_definitions`
--
ALTER TABLE `custom_field_definitions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `custom_field_definitions_field_key_unique` (`field_key`);

--
-- Indexes for table `custom_field_values`
--
ALTER TABLE `custom_field_values`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `custom_field_values_contact_id_field_definition_id_unique` (`contact_id`,`field_definition_id`),
  ADD KEY `custom_field_values_field_definition_id_foreign` (`field_definition_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `contact_emails`
--
ALTER TABLE `contact_emails`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `contact_merge_logs`
--
ALTER TABLE `contact_merge_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `contact_phones`
--
ALTER TABLE `contact_phones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `custom_field_definitions`
--
ALTER TABLE `custom_field_definitions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `custom_field_values`
--
ALTER TABLE `custom_field_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_merged_into_foreign` FOREIGN KEY (`merged_into`) REFERENCES `contacts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `contact_emails`
--
ALTER TABLE `contact_emails`
  ADD CONSTRAINT `contact_emails_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contact_merge_logs`
--
ALTER TABLE `contact_merge_logs`
  ADD CONSTRAINT `contact_merge_logs_master_contact_id_foreign` FOREIGN KEY (`master_contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contact_merge_logs_secondary_contact_id_foreign` FOREIGN KEY (`secondary_contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contact_phones`
--
ALTER TABLE `contact_phones`
  ADD CONSTRAINT `contact_phones_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `custom_field_values`
--
ALTER TABLE `custom_field_values`
  ADD CONSTRAINT `custom_field_values_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `custom_field_values_field_definition_id_foreign` FOREIGN KEY (`field_definition_id`) REFERENCES `custom_field_definitions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
