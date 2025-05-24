-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 24, 2025 at 06:30 PM
-- Server version: 8.3.0
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinema`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `showtime_id` bigint UNSIGNED NOT NULL,
  `seat_id` bigint UNSIGNED NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_price` decimal(10,2) NOT NULL DEFAULT '50.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_user_id_foreign` (`user_id`),
  KEY `bookings_showtime_id_foreign` (`showtime_id`),
  KEY `bookings_seat_id_foreign` (`seat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `showtime_id`, `seat_id`, `booking_date`, `total_price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2025-05-12 12:12:51', 50.00, NULL, NULL),
(2, 1, 3, 12, '2025-05-23 17:27:37', 50.00, '2025-05-23 16:27:37', '2025-05-23 16:27:37'),
(3, 1, 1, 6, '2025-05-23 17:29:05', 50.00, '2025-05-23 16:29:05', '2025-05-23 16:29:05'),
(4, 1, 4, 15, '2025-05-23 17:29:46', 50.00, '2025-05-23 16:29:46', '2025-05-23 16:29:46'),
(5, 1, 4, 11, '2025-05-23 17:31:51', 50.00, '2025-05-23 16:31:51', '2025-05-23 16:31:51'),
(6, 1, 4, 11, '2025-05-23 17:35:32', 50.00, '2025-05-23 16:35:32', '2025-05-23 16:35:32'),
(7, 3, 4, 17, '2025-05-23 17:38:38', 50.00, '2025-05-23 16:38:38', '2025-05-23 16:38:38'),
(8, 3, 4, 22, '2025-05-23 17:39:22', 50.00, '2025-05-23 16:39:22', '2025-05-23 16:39:22'),
(9, 1, 5, 25, '2025-05-24 11:51:16', 50.00, '2025-05-24 10:51:16', '2025-05-24 10:51:16'),
(10, 1, 5, 24, '2025-05-24 11:51:57', 50.00, '2025-05-24 10:51:57', '2025-05-24 10:51:57');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '2025_04_27_201818_create_bookings_table', 1),
(3, '2025_04_27_201836_create_movies_table', 1),
(4, '2025_04_27_201847_create_seats_table', 1),
(5, '2025_04_27_201909_create_showtimes_table', 1),
(6, '2025_04_27_232810_create_personal_access_tokens_table', 1),
(7, '2025_04_29_001825_create_theaters_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
CREATE TABLE IF NOT EXISTS `movies` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `duration_minutes` int DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `poster_url` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trailer_url` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `movies_poster_url_unique` (`poster_url`),
  UNIQUE KEY `movies_trailer_url_unique` (`trailer_url`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `title`, `description`, `duration_minutes`, `release_date`, `poster_url`, `trailer_url`, `created_at`, `updated_at`) VALUES
(1, 'Inception', 'Inception is a 2010 science fiction action film about a thief, Dom Cobb, who enters people\'s dreams to steal information. He is offered a chance to have his criminal record erased if he implants an idea into the mind of a target. The film explores dream-sharing technology and the complexities of the subconscious, with Cobb and his team navigating multiple dream levels in a high-stakes, mind-bending adventure.', 149, '2025-04-10', 'https://image.tmdb.org/t/p/original/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg', 'https://www.youtube.com/watch?v=YoHD9XEInc0', '2025-04-28 22:32:48', '2025-05-24 10:30:02'),
(2, 'spiderman', 'filmm dyal batal', 150, '2025-04-16', 'https://m.media-amazon.com/images/I/71niXI3lxlL._AC_SL1178_.jpg', NULL, '2025-04-29 10:05:45', '2025-04-29 10:05:45'),
(3, 'The Dark Knight', 'Some desc', 120, '2024-05-01', 'https://image.tmdb.org/t/p/original/qJ2tW6WMUDux911r6m7haRef0WH.jpg', 'https://www.youtube.com/watch?v=EXeTwQWrcwY', '2025-04-29 10:27:25', '2025-04-29 10:27:25'),
(9, 'Oppenheimer', 'Drama,  History', 181, '2023-07-21', 'https://image.tmdb.org/t/p/original/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', NULL, '2025-05-02 12:19:21', '2025-05-02 12:19:21'),
(10, 'severance', 'mistery', 45, '2025-05-15', 'https://image.tmdb.org/t/p/original/lFf6LLrQjYldcZItzOkGmMMigP7.jpg', NULL, '2025-05-02 12:44:33', '2025-05-02 12:45:16'),
(8, 'Blue Lock', 'Animation,  Action,  Drama', 90, '2024-04-19', 'https://image.tmdb.org/t/p/original/ae434jM5NG2kKX1rRkG5giMhpPI.jpg', NULL, '2025-04-29 15:58:56', '2025-05-02 09:52:11'),
(11, 'The Godfather', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 175, '1972-03-24', 'https://image.tmdb.org/t/p/original/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', NULL, '2025-05-02 12:56:43', '2025-05-02 12:56:43'),
(12, 'Parasite', 'A poor family schemes to become employed by a wealthy family by infiltrating their household.', 132, '2019-05-30', 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', 'https://www.youtube.com/watch?v=5xH0HfJHsaY', NULL, NULL),
(13, 'Whiplash', 'A young drummer enrolls at a music conservatory where he is mentored by an abusive instructor.', 106, '2014-10-10', 'https://image.tmdb.org/t/p/w500/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg', 'https://www.youtube.com/watch?v=7d_jQycdQGo', NULL, NULL),
(14, 'Her', 'In a near future, a lonely writer develops an unlikely relationship with an operating system.', 126, '2013-12-18', 'https://image.tmdb.org/t/p/w500/yk4J4aewWYNiBhD49WD7UaBBn37.jpg', 'https://www.youtube.com/watch?v=WzV6mXIOVl4', NULL, NULL),
(15, 'The Grand Budapest Hotel', 'A concierge teams up with one of his employees to prove his innocence after being framed for murder.', 99, '2014-03-28', 'https://image.tmdb.org/t/p/w500/nX5XotM9yprCKarRH4fzOq1VM1J.jpg', 'https://www.youtube.com/watch?v=1Fg5iWmQjwk', NULL, NULL),
(16, 'La La Land', 'A jazz pianist and an aspiring actress fall in love while pursuing their dreams in Los Angeles.', 128, '2016-12-09', 'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg', 'https://www.youtube.com/watch?v=0pdqf4P9MB8', NULL, NULL),
(17, 'The Revenant', 'A frontiersman fights for survival after being mauled by a bear and left for dead by his hunting team.', 156, '2015-12-25', 'https://image.tmdb.org/t/p/w500/oXUWEc5i3wYyFnL1Ycu8ppxxPvs.jpg', 'https://www.youtube.com/watch?v=LoebZZ8K5N0', NULL, NULL),
(18, 'Mad Max: Fury Road', 'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search for her homeland.', 120, '2015-05-15', 'https://image.tmdb.org/t/p/w500/8tZYtuWezp8JbcsvHYO0O46tFbo.jpg', 'https://www.youtube.com/watch?v=hEJnMQG9ev8', NULL, NULL),
(19, 'The Social Network', 'The story of the founding of Facebook and the lawsuits that followed its success.', 120, '2010-10-01', 'https://image.tmdb.org/t/p/w500/n0ybibhJtQ5icDqTp8eRytcIHJx.jpg', 'https://www.youtube.com/watch?v=lB95KLmpLR4', NULL, NULL),
(20, 'Django Unchained', 'A freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.', 165, '2012-12-25', 'https://image.tmdb.org/t/p/w500/7oWY8VDWW7thTzWh3OKYRkWUlD5.jpg', 'https://www.youtube.com/watch?v=eUdM9vrCbow', NULL, NULL),
(21, 'The Imitation Game', 'Alan Turing and his team of code-breakers help defeat the Nazis during WWII.', 113, '2014-11-28', 'https://image.tmdb.org/t/p/w500/zSqJ1qFq8NXFfi7JeIYMlzyR0dx.jpg', 'https://www.youtube.com/watch?v=S5CjKEFb-sM', NULL, NULL),
(22, 'Joker', 'Arthur Fleck, a failed stand-up comedian, transforms into the infamous criminal mastermind.', 122, '2019-10-04', 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg', 'https://www.youtube.com/watch?v=zAGVQLHvwOY', NULL, NULL),
(23, 'Soul', 'A jazz musician, stuck between life and death, learns what it truly means to have soul.', 100, '2020-12-25', 'https://image.tmdb.org/t/p/w500/hm58Jw4Lw8OIeECIq5qyPYhAeRJ.jpg', 'https://www.youtube.com/watch?v=xOsLIiBStEs', NULL, NULL),
(24, 'Knives Out', 'A detective investigates the death of a patriarch of an eccentric, combative family.', 130, '2019-11-27', 'https://image.tmdb.org/t/p/w500/pThyQovXQrw2m0s9x82twj48Jq4.jpg', 'https://www.youtube.com/watch?v=qGqiHJTsRkQ', NULL, NULL),
(25, 'Everything Everywhere All at Once', 'A woman is swept into an insane multiverse adventure.', 139, '2022-03-11', 'https://image.tmdb.org/t/p/w500/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg', 'https://www.youtube.com/watch?v=wxN1T1uxQ2g', NULL, NULL),
(26, 'Coco', 'A boy who dreams of becoming a musician enters the Land of the Dead to seek his great-great-grandfather.', 105, '2017-10-27', 'https://image.tmdb.org/t/p/w500/gGEsBPAijhVUFoiNpgZXqRVWJt2.jpg', 'https://www.youtube.com/watch?v=Ga6RYejo6Hk', NULL, NULL),
(28, 'Now you see me : Now you don\'t', 'The Four Horsemen return along with a new generation of illusionists performing mind-melding twists, turns, surprises, and magic unlike anything ever captured on film.', 120, '2025-11-14', 'https://image.tmdb.org/t/p/original/oD3Eey4e4Z259XLm3eD3WGcoJAh.jpg', 'https://www.youtube.com/watch?v=-E3lMRx7HRQ', '2025-05-24 10:34:43', '2025-05-24 10:34:43');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'auth_token', '52f181a814f3798fefaed319739a2bc93d1cc365d6bc1cc948dae854cfc5e2dd', '[\"*\"]', NULL, NULL, '2025-05-12 11:07:46', '2025-05-12 11:07:46'),
(2, 'App\\Models\\User', 2, 'auth_token', '7ccce3c14b29d8647ecaec8d2ed90db26096d1332de02d955511909ba6efd694', '[\"*\"]', NULL, NULL, '2025-05-12 11:28:56', '2025-05-12 11:28:56'),
(3, 'App\\Models\\User', 2, 'auth_token', '16e0d902929ac9327730bdb923c56c2f6703bc4e0f322abd30706124bdc53c02', '[\"*\"]', NULL, NULL, '2025-05-12 15:12:23', '2025-05-12 15:12:23'),
(4, 'App\\Models\\User', 2, 'auth_token', 'fcc9fbafe323b5cae8b05fdf5ed2e590cf5a71aa6cb3ef778b3b899316923df6', '[\"*\"]', NULL, NULL, '2025-05-12 15:16:04', '2025-05-12 15:16:04'),
(5, 'App\\Models\\User', 1, 'auth_token', 'c549dde37de0d44a89be38af1679a4121f1fac03aa35a81690bfa2c4544ae4e9', '[\"*\"]', NULL, NULL, '2025-05-12 15:16:21', '2025-05-12 15:16:21'),
(6, 'App\\Models\\User', 2, 'auth_token', 'df08eda7b66156ca7f4180d12b9f269a5afe285cbbbb56e4340872cfb3337b9c', '[\"*\"]', NULL, NULL, '2025-05-12 18:29:55', '2025-05-12 18:29:55'),
(7, 'App\\Models\\User', 2, 'auth_token', '8885b07173c5bc37b1768d6511b986b3625cbe42e25fe8eb950118efe5ae93dc', '[\"*\"]', NULL, NULL, '2025-05-12 19:04:17', '2025-05-12 19:04:17'),
(8, 'App\\Models\\User', 1, 'auth_token', '932eb887e89a13696ee75da098e7f51141f0bdb5230e1cb765836c8d1bb3f328', '[\"*\"]', NULL, NULL, '2025-05-12 19:13:32', '2025-05-12 19:13:32'),
(9, 'App\\Models\\User', 2, 'auth_token', 'bb5f159f0c5bc36aab045819827a06c7a99e5b7a064e956521bfa496012088df', '[\"*\"]', NULL, NULL, '2025-05-12 19:48:56', '2025-05-12 19:48:56'),
(10, 'App\\Models\\User', 2, 'auth_token', 'fa19a5796f87c5db3e2d1cf1daded9b419945e442291eeeefe8fecda9a7c53b3', '[\"*\"]', NULL, NULL, '2025-05-12 19:50:51', '2025-05-12 19:50:51'),
(11, 'App\\Models\\User', 1, 'auth_token', '59bb194bf0a9bafa513a4537ae85a2a7857e97c1e12f5eb0ffaec2f09c5db82d', '[\"*\"]', NULL, NULL, '2025-05-12 19:51:01', '2025-05-12 19:51:01'),
(12, 'App\\Models\\User', 1, 'auth_token', '8e84601e1d248677e61aba072b3215fca4e9e2ab5925662364807e6747b7ba96', '[\"*\"]', NULL, NULL, '2025-05-12 19:51:01', '2025-05-12 19:51:01'),
(13, 'App\\Models\\User', 1, 'auth_token', '3ec1a215270ab0edf610d3d5f1a34e1026a2400cf227a2faac2154aba342f127', '[\"*\"]', NULL, NULL, '2025-05-12 19:51:21', '2025-05-12 19:51:21'),
(14, 'App\\Models\\User', 1, 'auth_token', '8fb13ffc3f831175d42a21a7fdf3fda60145e587cde3474bf3d4e08b9c6c21a3', '[\"*\"]', NULL, NULL, '2025-05-23 12:13:39', '2025-05-23 12:13:39'),
(15, 'App\\Models\\User', 1, 'auth_token', '62290493ea9eddb25f4b5d2b3a5d6ddf0891bc7bea2a3aa1ee687f5fd4ef94fb', '[\"*\"]', NULL, NULL, '2025-05-23 12:19:36', '2025-05-23 12:19:36'),
(16, 'App\\Models\\User', 1, 'auth_token', 'afd9c71494519b629d9a338cf6eb94a194b8e969759423ec4dbc15adec2eca00', '[\"*\"]', NULL, NULL, '2025-05-23 12:23:48', '2025-05-23 12:23:48'),
(17, 'App\\Models\\User', 1, 'auth_token', '87aef8b58fa5df6c94a4aa7f3468a8f59e0e85af35c4e1e8a1a5ebdd80d1879f', '[\"*\"]', NULL, NULL, '2025-05-23 12:59:42', '2025-05-23 12:59:42'),
(18, 'App\\Models\\User', 1, 'auth_token', '23781a5d430c83d0a0a94ffb9d1519d4cb7eb94ee94512b7b55fe28e16c9f6fa', '[\"*\"]', NULL, NULL, '2025-05-23 13:10:35', '2025-05-23 13:10:35'),
(19, 'App\\Models\\User', 1, 'auth_token', 'eee54515af7d443b0c1d4a1e36cada930d1f6bafb33f8d2139937ad391cc3b46', '[\"*\"]', NULL, NULL, '2025-05-23 13:11:24', '2025-05-23 13:11:24'),
(20, 'App\\Models\\User', 1, 'auth_token', 'f058b10127188f585323a5cb9cf8e6f49aecba612edf4112dc4fff863e1c543b', '[\"*\"]', NULL, NULL, '2025-05-23 13:11:24', '2025-05-23 13:11:24'),
(21, 'App\\Models\\User', 1, 'auth_token', '33a0756d674770fe92a1476392a6d45396e7ea10e9cd46f4fbb083e259f861aa', '[\"*\"]', NULL, NULL, '2025-05-23 15:52:52', '2025-05-23 15:52:52'),
(22, 'App\\Models\\User', 1, 'auth_token', '2f1210aa9a212df586606e1eafc9a86fb8eda1f15f2839794b43b7ccca0de3df', '[\"*\"]', NULL, NULL, '2025-05-23 15:59:07', '2025-05-23 15:59:07'),
(23, 'App\\Models\\User', 1, 'auth_token', 'ab82f362ffc833a4f175b8c9276f7e5ed969c4695d23f6c7947a5f286acb83a4', '[\"*\"]', NULL, NULL, '2025-05-23 16:01:30', '2025-05-23 16:01:30'),
(24, 'App\\Models\\User', 1, 'auth_token', '957baa1bc17ffcdc8b01c7e28781b06b2464a3a41454016d21150f78e05ad9c3', '[\"*\"]', NULL, NULL, '2025-05-23 16:15:58', '2025-05-23 16:15:58'),
(25, 'App\\Models\\User', 1, 'auth_token', '2c17f4fd1f2eb67167201a81ca4cf548e8775423d23c65e28a281cf794c0235c', '[\"*\"]', NULL, NULL, '2025-05-23 16:16:30', '2025-05-23 16:16:30'),
(26, 'App\\Models\\User', 1, 'auth_token', 'd1a338f6a2fb2f100874b892409831f8267b63be4ebfca11d295d1f58fe53668', '[\"*\"]', NULL, NULL, '2025-05-23 16:17:40', '2025-05-23 16:17:40'),
(27, 'App\\Models\\User', 1, 'auth_token', 'e3921f8301b59c097c2e7662a74249a23b4207fdd1633f3d70df2bfe731efcc2', '[\"*\"]', NULL, NULL, '2025-05-23 16:18:10', '2025-05-23 16:18:10'),
(28, 'App\\Models\\User', 1, 'auth_token', '107c986d042758307fe174f733c21dec93640093e87b7cfa70bf9d2d335e57ac', '[\"*\"]', NULL, NULL, '2025-05-23 16:20:27', '2025-05-23 16:20:27'),
(29, 'App\\Models\\User', 1, 'auth_token', '1278c0041bc2c76793ba190d602cfb8930f21cb0c8f9692225ea35e825ffc956', '[\"*\"]', NULL, NULL, '2025-05-23 16:22:25', '2025-05-23 16:22:25'),
(30, 'App\\Models\\User', 1, 'auth_token', '4f61360c50dc27804eed20f3861c4151c1790b9ebbd516c1d0bc467f8d2f29d5', '[\"*\"]', NULL, NULL, '2025-05-23 16:29:40', '2025-05-23 16:29:40'),
(31, 'App\\Models\\User', 1, 'auth_token', '38f98f0db8e6691d71c14961b3997fcb535b88ab20150418d96b9090a90ad437', '[\"*\"]', NULL, NULL, '2025-05-23 16:36:45', '2025-05-23 16:36:45'),
(32, 'App\\Models\\User', 3, 'auth_token', '3320df2195db496247e89e17171ad60dceee73e42e2277125ececdb1580131f0', '[\"*\"]', NULL, NULL, '2025-05-23 16:37:53', '2025-05-23 16:37:53'),
(33, 'App\\Models\\User', 3, 'auth_token', '34a9e8ec1c5d3e301d1a1fac53b83c3d59eed0c0071e6fedb7977035f956bac3', '[\"*\"]', NULL, NULL, '2025-05-23 16:39:17', '2025-05-23 16:39:17'),
(34, 'App\\Models\\User', 2, 'auth_token', '1aa56218d1bcaf89c41ebf19d6b1535cc5b696b1baacef1ec6a13fb2e8f74b2e', '[\"*\"]', NULL, NULL, '2025-05-24 10:02:15', '2025-05-24 10:02:15'),
(35, 'App\\Models\\User', 2, 'auth_token', '14683783b400489bea027468576629f8c7b469fc67f960bbdc56c40d0bd8da9a', '[\"*\"]', NULL, NULL, '2025-05-24 10:12:59', '2025-05-24 10:12:59'),
(36, 'App\\Models\\User', 2, 'auth_token', '31c2fcf1e50d2f60df6ba637225b9b68a111ca7c7996fd4b2f82e911e77e92db', '[\"*\"]', NULL, NULL, '2025-05-24 10:21:28', '2025-05-24 10:21:28'),
(37, 'App\\Models\\User', 2, 'auth_token', '68c04a8121009a06d2384e362b56c82ca679644031ecf75d3dfd27bfdf012145', '[\"*\"]', NULL, NULL, '2025-05-24 10:29:02', '2025-05-24 10:29:02'),
(38, 'App\\Models\\User', 2, 'auth_token', '12d8b88e904040800415bb5d2c20fb8a881c3fa4fa578f4e3bd4e0977572df89', '[\"*\"]', NULL, NULL, '2025-05-24 10:46:13', '2025-05-24 10:46:13'),
(39, 'App\\Models\\User', 4, 'auth_token', '2af8073b20bc0e3acd6567db43fb08f5061a86f365da2565bb98d62784fac61d', '[\"*\"]', NULL, NULL, '2025-05-24 10:48:54', '2025-05-24 10:48:54'),
(40, 'App\\Models\\User', 5, 'auth_token', '9b33534a1c0c444f4949e6808b09dbc9dc57a3acb9bae95fd4322d2efc4ee41b', '[\"*\"]', NULL, NULL, '2025-05-24 10:49:36', '2025-05-24 10:49:36'),
(41, 'App\\Models\\User', 2, 'auth_token', '5b4350aedb9708573e4a8e5bf79c3352616408fcc3806782e2f280ba84aec130', '[\"*\"]', NULL, NULL, '2025-05-24 10:49:45', '2025-05-24 10:49:45'),
(42, 'App\\Models\\User', 3, 'auth_token', '87237e97d0e61f9a23bbe961c7ef4e5980ecce428029d7d9c09fac18b59dc1f4', '[\"*\"]', NULL, NULL, '2025-05-24 10:50:10', '2025-05-24 10:50:10'),
(43, 'App\\Models\\User', 1, 'auth_token', 'c74d0b91c8adc894999deea14a7ce6fdfc686b14fa89e54cbf6a748d381bff47', '[\"*\"]', NULL, NULL, '2025-05-24 10:50:32', '2025-05-24 10:50:32');

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
CREATE TABLE IF NOT EXISTS `seats` (
  `seat_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `theater_id` bigint UNSIGNED NOT NULL,
  `seat_number` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `seats_theater_id_foreign` (`theater_id`)
) ENGINE=MyISAM AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seats`
--

INSERT INTO `seats` (`seat_id`, `theater_id`, `seat_number`, `created_at`, `updated_at`) VALUES
(1, 1, 'A1', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(2, 1, 'A2', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(3, 1, 'A3', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(4, 1, 'A4', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(5, 1, 'A5', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(6, 1, 'A6', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(7, 1, 'A7', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(8, 1, 'A8', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(9, 1, 'A9', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(10, 1, 'A10', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(11, 1, 'A11', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(12, 1, 'A12', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(13, 1, 'A13', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(14, 1, 'A14', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(15, 1, 'A15', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(16, 1, 'B1', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(17, 1, 'B2', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(18, 1, 'B3', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(19, 1, 'B4', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(20, 1, 'B5', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(21, 1, 'B6', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(22, 1, 'B7', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(23, 1, 'B8', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(24, 1, 'B9', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(25, 1, 'B10', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(26, 1, 'B11', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(27, 1, 'B12', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(28, 1, 'B13', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(29, 1, 'B14', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(30, 1, 'B15', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(31, 1, 'C1', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(32, 1, 'C2', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(33, 1, 'C3', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(34, 1, 'C4', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(35, 1, 'C5', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(36, 1, 'C6', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(37, 1, 'C7', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(38, 1, 'C8', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(39, 1, 'C9', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(40, 1, 'C10', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(41, 1, 'C11', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(42, 1, 'C12', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(43, 1, 'C13', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(44, 1, 'C14', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(45, 1, 'C15', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(46, 1, 'D1', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(47, 1, 'D2', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(48, 1, 'D3', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(49, 1, 'D4', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(50, 1, 'D5', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(51, 1, 'D6', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(52, 1, 'D7', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(53, 1, 'D8', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(54, 1, 'D9', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(55, 1, 'D10', '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(56, 5, 'A1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(57, 5, 'A2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(58, 5, 'A3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(59, 5, 'A4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(60, 5, 'A5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(61, 5, 'A6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(62, 5, 'A7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(63, 5, 'A8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(64, 5, 'A9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(65, 5, 'A10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(66, 5, 'A11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(67, 5, 'A12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(68, 5, 'A13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(69, 5, 'A14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(70, 5, 'A15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(71, 5, 'B1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(72, 5, 'B2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(73, 5, 'B3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(74, 5, 'B4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(75, 5, 'B5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(76, 5, 'B6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(77, 5, 'B7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(78, 5, 'B8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(79, 5, 'B9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(80, 5, 'B10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(81, 5, 'B11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(82, 5, 'B12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(83, 5, 'B13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(84, 5, 'B14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(85, 5, 'B15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(86, 5, 'C1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(87, 5, 'C2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(88, 5, 'C3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(89, 5, 'C4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(90, 5, 'C5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(91, 5, 'C6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(92, 5, 'C7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(93, 5, 'C8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(94, 5, 'C9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(95, 5, 'C10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(96, 5, 'C11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(97, 5, 'C12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(98, 5, 'C13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(99, 5, 'C14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(100, 5, 'C15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(101, 5, 'D1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(102, 5, 'D2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(103, 5, 'D3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(104, 5, 'D4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(105, 5, 'D5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(106, 5, 'D6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(107, 5, 'D7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(108, 5, 'D8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(109, 5, 'D9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(110, 5, 'D10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(111, 5, 'D11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(112, 5, 'D12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(113, 5, 'D13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(114, 5, 'D14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(115, 5, 'D15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(116, 5, 'E1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(117, 5, 'E2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(118, 5, 'E3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(119, 5, 'E4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(120, 5, 'E5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(121, 5, 'E6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(122, 5, 'E7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(123, 5, 'E8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(124, 5, 'E9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(125, 5, 'E10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(126, 5, 'E11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(127, 5, 'E12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(128, 5, 'E13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(129, 5, 'E14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(130, 5, 'E15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(131, 5, 'F1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(132, 5, 'F2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(133, 5, 'F3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(134, 5, 'F4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(135, 5, 'F5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(136, 5, 'F6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(137, 5, 'F7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(138, 5, 'F8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(139, 5, 'F9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(140, 5, 'F10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(141, 5, 'F11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(142, 5, 'F12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(143, 5, 'F13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(144, 5, 'F14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(145, 5, 'F15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(146, 5, 'G1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(147, 5, 'G2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(148, 5, 'G3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(149, 5, 'G4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(150, 5, 'G5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(151, 5, 'G6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(152, 5, 'G7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(153, 5, 'G8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(154, 5, 'G9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(155, 5, 'G10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(156, 5, 'G11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(157, 5, 'G12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(158, 5, 'G13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(159, 5, 'G14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(160, 5, 'G15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(161, 5, 'H1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(162, 5, 'H2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(163, 5, 'H3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(164, 5, 'H4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(165, 5, 'H5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(166, 5, 'H6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(167, 5, 'H7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(168, 5, 'H8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(169, 5, 'H9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(170, 5, 'H10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(171, 5, 'H11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(172, 5, 'H12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(173, 5, 'H13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(174, 5, 'H14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(175, 5, 'H15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(176, 5, 'I1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(177, 5, 'I2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(178, 5, 'I3', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(179, 5, 'I4', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(180, 5, 'I5', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(181, 5, 'I6', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(182, 5, 'I7', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(183, 5, 'I8', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(184, 5, 'I9', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(185, 5, 'I10', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(186, 5, 'I11', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(187, 5, 'I12', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(188, 5, 'I13', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(189, 5, 'I14', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(190, 5, 'I15', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(191, 5, 'J1', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(192, 5, 'J2', '2025-05-24 10:46:43', '2025-05-24 10:46:43'),
(193, 5, 'J3', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(194, 5, 'J4', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(195, 5, 'J5', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(196, 5, 'J6', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(197, 5, 'J7', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(198, 5, 'J8', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(199, 5, 'J9', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(200, 5, 'J10', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(201, 5, 'J11', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(202, 5, 'J12', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(203, 5, 'J13', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(204, 5, 'J14', '2025-05-24 10:46:44', '2025-05-24 10:46:44'),
(205, 5, 'J15', '2025-05-24 10:46:44', '2025-05-24 10:46:44');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('x8Q6fKzPiAA7mrN7iTKgYylCN3y3saVQ4mq6wrNW', NULL, '127.0.0.1', 'PostmanRuntime/7.43.4', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZVdGdmtxRTgzS1lmWnJoZGh1R0lsQ2szcU56d01LMFBCVW9xMHRGRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1747078102);

-- --------------------------------------------------------

--
-- Table structure for table `showtimes`
--

DROP TABLE IF EXISTS `showtimes`;
CREATE TABLE IF NOT EXISTS `showtimes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `movie_id` bigint UNSIGNED NOT NULL,
  `theater_id` bigint UNSIGNED NOT NULL,
  `show_date` date NOT NULL,
  `show_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `showtimes_movie_id_foreign` (`movie_id`),
  KEY `showtimes_theater_id_foreign` (`theater_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `showtimes`
--

INSERT INTO `showtimes` (`id`, `movie_id`, `theater_id`, `show_date`, `show_time`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-09', '13:10:00', '2025-05-12 11:08:03', '2025-05-12 11:08:03'),
(2, 1, 1, '2025-05-01', '21:01:00', '2025-05-12 18:28:48', '2025-05-12 18:28:48'),
(3, 1, 1, '2025-05-02', '21:01:00', '2025-05-12 18:31:02', '2025-05-12 18:31:02'),
(4, 2, 1, '2025-05-16', '21:52:00', '2025-05-12 19:49:37', '2025-05-12 19:49:37'),
(5, 28, 1, '2025-12-25', '17:35:00', '2025-05-24 10:35:55', '2025-05-24 10:35:55'),
(6, 28, 5, '2025-12-27', '16:47:00', '2025-05-24 10:47:11', '2025-05-24 10:47:11');

-- --------------------------------------------------------

--
-- Table structure for table `theaters`
--

DROP TABLE IF EXISTS `theaters`;
CREATE TABLE IF NOT EXISTS `theaters` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `theaters_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `theaters`
--

INSERT INTO `theaters` (`id`, `name`, `capacity`, `created_at`, `updated_at`) VALUES
(1, 'salle 1', 55, '2025-05-12 11:07:54', '2025-05-12 11:07:54'),
(5, 'Salle D4', 150, '2025-05-24 10:46:43', '2025-05-24 10:46:43');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'souhail', 'souhail@gmail.com', '$2y$12$rXNz35xv12QFrHc0./DuU.ykdrWumzyO68t2pslU6aLOeeC2BV2Cy', 'user', NULL, '2025-05-11 22:26:14', '2025-05-11 22:26:14'),
(2, 'admin', 'admin@gmail.com', '$2y$12$zOl22/8Xqt5RZwv7zbYTOevWNhYiuY9qvFRXNB7hkcuVSqM5znaTG', 'admin', NULL, '2025-05-11 22:26:45', '2025-05-11 22:26:45'),
(3, 'yamal howa lbaba', 'wabarca@gmail.com', '$2y$12$Y.1LYA2b1.PRo/S6JE90Mue34yZGGS8RiA7V/a7/M.XN9Fu228UHa', 'admin', NULL, '2025-05-11 22:38:26', '2025-05-11 22:38:26'),
(4, 'Souhail', 'adSouhail@test.com', '$2y$12$WO1MIN4dIgg0pka7lKnAsePVAI2WWmxN6gdDNbmRSR36Qe0YJU4XG', 'admin', NULL, '2025-05-24 10:48:54', '2025-05-24 10:48:54'),
(5, 'Yamal', 'yamal@gmail.com', '$2y$12$y3PAEICV4jbMSzrLJ5tOdeiPHVolssto0/BkgJfHGuiKVPrQmMv/G', 'user', NULL, '2025-05-24 10:49:36', '2025-05-24 10:49:36');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
