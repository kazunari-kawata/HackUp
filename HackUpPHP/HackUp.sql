-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- ホスト: localhost
-- 生成日時: 2025 年 7 月 03 日 15:18
-- サーバのバージョン： 10.4.28-MariaDB
-- PHP のバージョン: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `HackUp`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `hacks`
--

CREATE TABLE `hacks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` datetime NOT NULL,
  `upvotes` int(11) NOT NULL,
  `downvotes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- テーブルのデータのダンプ `hacks`
--

INSERT INTO `hacks` (`id`, `user_id`, `title`, `description`, `created_at`, `upvotes`, `downvotes`) VALUES
(11, 1, 'テスト投稿', 'これはテストです', '2025-07-03 21:57:35', 0, 0),
(12, 1, 'jkfdjlas', 'mfldksaml', '2025-07-03 21:58:22', 0, 0),
(13, 1, 'test-title', 'test-content', '2025-07-03 21:59:11', 0, 0);

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL COMMENT 'ユーザーID',
  `firebase_uid` varchar(255) NOT NULL COMMENT 'Firebase Auth使用を前提としたUID',
  `display_name` varchar(100) NOT NULL COMMENT '表示名',
  `created_at` datetime NOT NULL COMMENT '作成日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- テーブルのデータのダンプ `users`
--

INSERT INTO `users` (`id`, `firebase_uid`, `display_name`, `created_at`) VALUES
(1, 'test_uid_1', 'テストユーザー', '2025-07-03 21:57:19');

-- --------------------------------------------------------

--
-- テーブルの構造 `votes`
--

CREATE TABLE `votes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `hack_id` int(11) NOT NULL,
  `vote_type` enum('up','down') NOT NULL,
  `voted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `unique_vote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `hacks`
--
ALTER TABLE `hacks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- テーブルのインデックス `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_vote` (`unique_vote`),
  ADD KEY `hack_id` (`hack_id`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `hacks`
--
ALTER TABLE `hacks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- テーブルの AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ユーザーID', AUTO_INCREMENT=2;

--
-- テーブルの AUTO_INCREMENT `votes`
--
ALTER TABLE `votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `hacks`
--
ALTER TABLE `hacks`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- テーブルの制約 `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `hack_id` FOREIGN KEY (`hack_id`) REFERENCES `hacks` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
