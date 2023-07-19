-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 04, 2023 at 02:30 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpus`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `rak_id` int(11) NOT NULL,
  `book_name` varchar(191) NOT NULL,
  `pengarang` varchar(191) NOT NULL,
  `penerbit` varchar(191) NOT NULL,
  `tahun_terbit` year(4) NOT NULL,
  `isbn` varchar(10) NOT NULL,
  `deskripsi` text NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `category_id`, `rak_id`, `book_name`, `pengarang`, `penerbit`, `tahun_terbit`, `isbn`, `deskripsi`, `status`) VALUES
(8, 5, 1, 'Buku Sejarah Indonesia', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1),
(9, 5, 1, 'Buku Bahasa Indonesia', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1),
(10, 5, 1, 'Buku Matematika', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1),
(11, 5, 1, 'Buku Bahasa Inggris', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1),
(12, 5, 1, 'Buku Pendidikan Agama Islam', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1),
(13, 5, 1, 'Buku Pendidikan Agama Kristen', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1),
(14, 5, 1, 'Buku Pendidikan Kewarganegaraan & Pancasila', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1),
(15, 5, 1, 'Buku Informatika', 'Kemendikbudristek', 'Kemendikbudristek', 2019, '1234', '-', 1);

--
-- Triggers `books`
--
DELIMITER $$
CREATE TRIGGER `after_books_insert` AFTER INSERT ON `books` FOR EACH ROW BEGIN
        INSERT INTO stocks(book_id, stock)
        VALUES(new.id, 0);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_delete_books` AFTER DELETE ON `books` FOR EACH ROW BEGIN
        DELETE FROM stocks WHERE book_id = old.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categorys`
--

CREATE TABLE `categorys` (
  `id` int(11) NOT NULL,
  `category_name` varchar(191) NOT NULL,
  `deskripsi` text NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categorys`
--

INSERT INTO `categorys` (`id`, `category_name`, `deskripsi`, `status`) VALUES
(5, 'Kelas X', 'Kategori Khusus Buku Mata Pelajaran Kelas X', 1),
(6, 'Kelas XI', 'Kategori Khusus Buku Mata Pelajaran Kelas XI', 1),
(7, 'Kelas XII', 'Kategori Khusus Buku Mata Pelajaran Kelas XII', 1);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT 0,
  `type` varchar(32) NOT NULL,
  `menu_key` varchar(32) NOT NULL,
  `label` varchar(199) NOT NULL,
  `route` varchar(199) DEFAULT NULL,
  `icon` varchar(199) DEFAULT NULL,
  `short_order` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `parent_id`, `type`, `menu_key`, `label`, `route`, `icon`, `short_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 'MAIN_MENU', 'DASHBOARDS', 'Dashboards', 'dashboard', 'fa fa-th', 1, 1, '2022-12-06 05:42:08', '2022-12-27 19:35:45'),
(3, 6, 'SUB_MENU', 'DATA_BUKU', 'Data Buku', 'data-buku', 'fa fa-angle-double-right', 3, 1, '2022-12-06 07:06:52', '2023-01-01 00:53:00'),
(5, 6, 'SUB_MENU', 'KATEGORI', 'Kategori', 'data-kategori', 'fa fa-angle-double-right', 3, 1, '2022-12-06 07:08:43', '2023-01-01 00:49:04'),
(6, 0, 'MAIN_MENU', 'MASTER_DATA', 'Master Data', 'sistem', 'fa fa-folder', 15, 1, '2022-12-06 13:34:12', '2023-01-01 04:15:15'),
(11, 6, 'SUB_MENU', 'MENU', 'Menu', 'data-menu', 'fa fa-angle-double-right', 1, 1, '2022-12-09 07:06:37', '2023-01-01 03:55:11'),
(93, 6, 'SUB_MENU', 'USER', 'User', 'data-user', 'fa fa-angle-double-right', 7, 1, '2022-12-27 19:53:20', '2023-01-11 06:50:29'),
(94, 0, 'MAIN_MENU', 'PINJAMAN', 'Pinjaman', 'pinjaman', 'fa fa-exchange', 9, 1, '2022-12-27 19:53:45', '2023-01-01 04:15:55'),
(102, 6, 'SUB_MENU', 'RAK', 'Rak', 'data-rak', 'fa fa-angle-double-right', 4, 1, '2022-12-29 01:31:35', '2023-01-01 03:48:22'),
(111, 6, 'SUB_MENU', 'STOCK_BUKU', 'Stock Buku', 'data-stock', 'fa fa-angle-double-right', 6, 1, '2023-01-01 01:11:12', '2023-01-01 21:09:27'),
(112, 6, 'SUB_MENU', 'DATA_SISWA', 'Data Siswa', 'data-siswa', 'fa fa-angle-double-right', 2, 1, '2023-01-01 01:13:18', '2023-01-01 01:13:19'),
(113, 94, 'SUB_MENU', 'PINJAM_BUKU', 'Pinjam Buku', 'pinjam-buku', 'fa fa-angle-double-right', 1, 1, '2023-01-01 02:00:35', '2023-01-01 02:00:35'),
(114, 94, 'SUB_MENU', 'DAFTAR_PENGEMBALIAN_BUKU', 'Daftar Pengembalian Buku', 'pengembalian-buku', 'fa fa-angle-double-right', 2, 1, '2023-01-01 02:01:19', '2023-01-10 22:51:36'),
(115, 11, 'ACTIONS', 'DATA_MENU', 'Data Menu', 'data-menu', 'fa fa-angle-double-right', 1, 1, '2023-01-02 01:47:15', '2023-01-19 17:20:12'),
(116, 11, 'ACTIONS', 'ROLE_MENU', 'Role Menu', 'role-menu', 'fa fa-angle-double-right', 2, 1, '2023-01-02 01:47:52', '2023-01-19 17:20:22'),
(117, 6, 'SUB_MENU', 'ROLE', 'Role', 'data-role', 'fa fa-angle-double-right', 8, 1, '2023-01-02 01:56:54', '2023-01-02 01:58:19'),
(119, 0, 'MAIN_MENU', 'GANTI_PASSWORD', 'Ganti Password', 'change-password', 'fa fa-cog', 30, 1, '2023-01-18 05:19:19', '2023-01-18 05:19:47');

-- --------------------------------------------------------

--
-- Table structure for table `menu_role`
--

CREATE TABLE `menu_role` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_role`
--

INSERT INTO `menu_role` (`id`, `role_id`, `menu_id`) VALUES
(111, 1, 94),
(112, 1, 113),
(113, 1, 114),
(116, 1, 1),
(117, 1, 6),
(118, 1, 11),
(119, 1, 115),
(120, 1, 116),
(121, 1, 119),
(122, 1, 112),
(123, 1, 3),
(124, 1, 5),
(125, 1, 102),
(126, 1, 111),
(127, 1, 93),
(128, 1, 117),
(129, 3, 1),
(130, 3, 94),
(131, 3, 113),
(132, 3, 114),
(133, 3, 6),
(135, 3, 112),
(136, 3, 3),
(137, 3, 5),
(138, 3, 102),
(140, 3, 119),
(141, 4, 1),
(142, 4, 119),
(143, 3, 93);

-- --------------------------------------------------------

--
-- Table structure for table `pinjaman`
--

CREATE TABLE `pinjaman` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal_dipinjam` date NOT NULL,
  `batas_dipinjam` date NOT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pinjaman`
--

INSERT INTO `pinjaman` (`id`, `book_id`, `student_id`, `jumlah`, `tanggal_dipinjam`, `batas_dipinjam`, `tanggal_kembali`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(31, 9, 4, 1, '2023-06-22', '2023-06-30', '2023-06-22', 0, 1, '2023-06-22', NULL),
(32, 8, 5, 1, '2023-06-22', '2023-06-30', NULL, 1, 1, '2023-06-22', NULL),
(33, 9, 5, 1, '2023-06-22', '2023-06-30', NULL, 1, 1, '2023-06-22', NULL),
(34, 10, 5, 1, '2023-06-22', '2023-06-30', NULL, 1, 1, '2023-06-22', NULL),
(35, 10, 9, 1, '2023-06-22', '2023-06-30', NULL, 1, 1, '2023-06-22', NULL);

--
-- Triggers `pinjaman`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pinjam` AFTER DELETE ON `pinjaman` FOR EACH ROW BEGIN
        UPDATE stocks SET stock = stock + old.jumlah
   		WHERE book_id = old.book_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_dikembalikan` AFTER UPDATE ON `pinjaman` FOR EACH ROW BEGIN
	 IF NEW.status = 0 THEN
        UPDATE stocks SET stock = stock + old.jumlah
   		WHERE book_id = old.book_id;
     END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_pinjam_insert` AFTER INSERT ON `pinjaman` FOR EACH ROW BEGIN
        UPDATE stocks SET stock = stock - NEW.jumlah
   		WHERE book_id = NEW.book_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `raks`
--

CREATE TABLE `raks` (
  `id` int(11) NOT NULL,
  `rak_name` varchar(191) NOT NULL,
  `deskripsi` text NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `raks`
--

INSERT INTO `raks` (`id`, `rak_name`, `deskripsi`, `status`) VALUES
(1, 'Rak X-A', 'Berisikan Buku Buku Mata Pelajaran Kelas X', 1),
(3, 'RAK XII-A', 'Berisikan Buku Buku Mata Pelajaran Kelas XII', 1),
(4, 'Rak XI-A', 'Berisikan Buku Buku Mata Pelajaran Kelas XI', 1);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `slack` varchar(191) NOT NULL,
  `role` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `slack`, `role`) VALUES
(1, 'HpWeYcIxjz9hlbg', 'Super Admin'),
(3, 'PupeQHRX8d2eTWP', 'Admin'),
(4, 'DyGVU6xa95S372F', 'Siswa');

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `book_id`, `stock`) VALUES
(7, 8, 199),
(8, 9, 199),
(9, 10, 198),
(10, 11, 200),
(11, 12, 200),
(12, 13, 200),
(13, 14, 200),
(14, 15, 200);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nama_siswa` varchar(191) NOT NULL,
  `nis` varchar(10) NOT NULL,
  `alamat` text NOT NULL,
  `tempat_lahir` varchar(191) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `tahun_angkatan` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `nama_siswa`, `nis`, `alamat`, `tempat_lahir`, `tanggal_lahir`, `tahun_angkatan`, `status`, `created_at`) VALUES
(4, 1, 'Ayu Rospika Panjaitan', '21001', 'Dusun Lumban Nababan Desa Pandiangian Kec. Lae Parira', 'Bah Balua', '2006-02-07', 2021, 1, '2023-06-22'),
(5, 1, 'Rido Chandra Prayoga', '21002', 'Bah Perak', 'Bah Perak', '2006-03-12', 2021, 1, '2023-06-22'),
(6, 1, 'Ovti Amelia', '21003', 'Bah Balua', 'Bah Balua', '2006-02-14', 2021, 1, '2023-06-22'),
(7, 1, 'Andi Antoni Lumban Gaol', '21004', 'Bandar Gunung', 'Bandar Gunung', '2006-04-19', 2021, 1, '2023-06-22'),
(8, 1, 'Cahyo Ramadhan', '21005', 'Bandar Kuala', 'Bandar Kuala', '2006-01-18', 2021, 1, '2023-06-22'),
(9, 1, 'Selly Rizki Anggraini', '21006', 'Bandar Gunung', 'Bandar Gunung', '2006-01-16', 2021, 1, '2023-06-22');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `slack` varchar(191) NOT NULL,
  `nama_lengkap` varchar(191) NOT NULL,
  `username` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `slack`, `nama_lengkap`, `username`, `email`, `password`, `status`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 'HFsWVMg8oNX24Ru', 'Super Admins', 'superadmin', 'superadmin@bangunpurba.com', '$2y$10$P/1iCyk8slfNkzmq1vp6me1Q15u18sfiN1rMn2R4cE6XSZCj1QPUy', 1, 1, 1, '2023-01-14 03:05:00', '2023-01-19 05:06:58'),
(3, 'UpwxgDsygyoUqx9', 'Admin Bangun Purba', 'Admin', 'admin@bangunpurba.com', '$2y$10$tI6JJBLjlXDPTn71Daem6OxaBxOdUd5XP3zZ9UEy.SkvKoKv9HY8K', 1, 1, 3, '2023-01-19 07:04:37', '2023-01-19 07:04:37'),
(4, 'T8YZYoBfnIEbZHO', 'Siswa Bangun Purba', 'Siswa', 'siswa@bangunpurba.com', '$2y$10$FasvVkhaMSdmltatcQ8HQe3Cu6vuTdqjzWaTJlq9Omj2goHVsibwG', 1, 1, 4, '2023-01-19 07:05:04', '2023-01-19 07:05:04'),
(5, 'iY3UUWVY5XA4ICI', 'Kepala Sekolah', 'kepsek', 'kepsek@bangunpurba.com', '$2y$10$xCAHiE0p9mbtwU0xFn8B3OFzSICg9MHHPnWZdiZWeRzr/yeV3y4Jq', 1, 1, 3, '2023-02-27 08:43:21', '2023-02-27 08:43:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categorys`
--
ALTER TABLE `categorys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_role`
--
ALTER TABLE `menu_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pinjaman`
--
ALTER TABLE `pinjaman`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `raks`
--
ALTER TABLE `raks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `categorys`
--
ALTER TABLE `categorys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `menu_role`
--
ALTER TABLE `menu_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `pinjaman`
--
ALTER TABLE `pinjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `raks`
--
ALTER TABLE `raks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
