-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 18, 2026 at 08:59 PM
-- Server version: 5.7.44-48
-- PHP Version: 8.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `colibrip_abcsistema`
--

-- --------------------------------------------------------

--
-- Table structure for table `cp_activity_log`
--

CREATE TABLE `cp_activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_categories`
--

CREATE TABLE `cp_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'product',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_categories`
--

INSERT INTO `cp_categories` (`id`, `name`, `type`, `enabled`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'PLAYERAS', 'product', 1, 0, '2026-09-16 23:58:13', '2026-09-17 00:35:38'),
(3, 'TAZAS', 'product', 1, 0, '2026-09-17 00:34:06', '2026-09-17 00:34:06'),
(4, 'LLAVEROS', 'product', 1, 0, '2026-09-17 00:34:12', '2026-09-17 00:34:12'),
(5, 'YETIS', 'product', 1, 0, '2026-09-17 00:34:18', '2026-09-17 00:34:18'),
(6, 'GRABADO LÁSER', 'product', 1, 0, '2026-09-17 00:34:28', '2026-09-17 00:34:28'),
(7, 'IMPRESIÓN', 'product', 1, 0, '2026-09-17 13:53:07', '2026-09-17 13:53:07');

-- --------------------------------------------------------

--
-- Table structure for table `cp_customers`
--

CREATE TABLE `cp_customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `source_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'MX',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_customers`
--

INSERT INTO `cp_customers` (`id`, `source_type`, `source_id`, `name`, `email`, `tax_number`, `phone`, `address`, `city`, `zip_code`, `state`, `country`, `notes`, `enabled`, `created_at`, `updated_at`) VALUES
(1, 'akaunting', 1, 'LUIS GARDEA', 'Yogardea@outlook.com', 'GARL301182BBM6', '6271074512', 'C Alemania\r\n87', 'Hidalgo del Parral José López Portillo', '33820', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(2, 'akaunting', 6, 'Beatriz Chávez', NULL, NULL, '6271354103', NULL, 'Hidalgo del Parral', '33820', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(3, 'akaunting', 7, 'Itzel Dariana', NULL, NULL, '649 197 3143', 'Col. 20 de Noviembre', 'Guachochi', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(4, 'akaunting', 8, 'Leticia Yazmin Salazar serrano', NULL, NULL, '6271171876', NULL, 'Hidalgo del Parral', '33820', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(5, 'akaunting', 9, 'Guadalupe Silva  Rueda', NULL, NULL, '627 111 4191', NULL, 'Hidalgo del Parral', '33820', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(6, 'akaunting', 10, 'CARSO INFRAESTRUCTURA Y CONSTRUCCION', 'mvadillo@condumex.com.mx', 'CIC991214L94', '6142327529', 'CALLE LAGO ZURICH\r\n245 EDIFICIO FRISCO\r\nAMPLIACION GRANADA', 'MIGUEL HIDALGO', '11529', 'CIUDAD DE MEXICO', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(7, 'akaunting', 13, 'Marely Ontiveros', NULL, NULL, '6271774403', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(8, 'akaunting', 14, 'LILIANA ORTIZ', 'ortiz-liliana@hotmail.com', NULL, '5545006497', 'C. SENDERO DE LA ALAMEDA No. 9\r\nCASA 4', 'MEXICO', '52934', 'ESTADO DE MEXICO', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(9, 'akaunting', 15, 'Marisela Mora Moreno', NULL, NULL, '6271509385', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(10, 'akaunting', 16, 'Rodrigo Chávez', NULL, NULL, '6275241520', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(11, 'akaunting', 17, 'Karmin Martìnez', NULL, NULL, '6275177922', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(12, 'akaunting', 18, 'Esc. Prim. María de la Cruz  Profr. Erick', NULL, NULL, '6567870958', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(13, 'akaunting', 19, 'Julia Varela', NULL, NULL, '627 279 6844', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(14, 'akaunting', 20, 'DIANA TORRES', NULL, NULL, '6271038001', NULL, 'HIDALGO DEL PARRAL', '33800', 'CHIHUAHUA', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(15, 'akaunting', 21, 'Clara Hernández', NULL, NULL, '627 150 7728', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(16, 'akaunting', 22, 'Ashley Martínez Rodríguez', NULL, NULL, '6271036390', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(17, 'akaunting', 23, 'Gonzalo Guerra', NULL, NULL, '6271745454', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(18, 'akaunting', 24, 'Benito Carrera', NULL, NULL, '627 114 4291', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(19, 'akaunting', 25, 'Flor', NULL, NULL, '639 147 1965', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(20, 'akaunting', 26, 'Miriam Villarreal', NULL, NULL, '627 133 1966', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(21, 'akaunting', 27, 'Carmen Lugo', NULL, NULL, '6271080194', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(22, 'akaunting', 28, 'Daniela Jiménez', NULL, NULL, '627 116 1150', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(23, 'akaunting', 29, 'Pamela RM MINERIA', NULL, NULL, '627 142 9155', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(24, 'akaunting', 30, 'Enrique Silva', NULL, NULL, '627 133 3310', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(25, 'akaunting', 31, 'Ana de la Cuz', NULL, NULL, '627 121 7220', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(26, 'akaunting', 32, 'Marìa Josè', NULL, NULL, '5545856421', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(27, 'akaunting', 33, 'María José', NULL, NULL, '55 4585 6421', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(28, 'akaunting', 34, 'ESCUELA SEC TEC 31', NULL, NULL, '6141252977', 'Anillo Periférico Luis Donaldo Colosio', 'Hidalgo del Parral', '33880', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(29, 'akaunting', 35, 'Edwin Iván Cervantes', 'edwin.cervantes@radarholding.com', NULL, '5527324354', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(30, 'akaunting', 36, 'Esc. Prim. Josef Solís de Lozoya 2156  Profr. José Luis', NULL, NULL, '6141639871', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(31, 'akaunting', 37, 'Marily Corral Irigoyen', NULL, NULL, '627 135 8100', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(32, 'akaunting', 38, 'Araceli Luna', NULL, NULL, '6271485877', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(33, 'akaunting', 39, 'Lluvia Villalobos', NULL, NULL, '614 494 8008', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(34, 'akaunting', 40, 'MAQUINADOS Y SOLDADURAS INDUSTRIALES MAYEROS S.A. DE C.V.', NULL, NULL, '922 212 4746', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(35, 'akaunting', 41, 'YAREMI VILLALOBOS', 'ventas@colibriprint.com.mx', NULL, '656 777 8597', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(36, 'akaunting', 42, 'MAQUINADOS Y SOLDADURAS INDUMAQUINADOS Y SOLDADURAS INDUSTRIALES MAYEROS S.A. DE C.V.STRIALES MAYEROS S.A. DE C.V.', NULL, NULL, '922 212 4746', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(37, 'akaunting', 43, 'María Guadalupe Bustillos Aguirre', 'mariedtorrs84@gmail.com', 'BUAG841115MCHIZ3', '6271489033', 'Real de Valladolid #7', 'Hidalgo del Parral', '33815', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(38, 'akaunting', 44, 'Esc. Prim. Est. Josefa Solís de Lozoya 2156', NULL, NULL, '6275221771', 'Calle Primera y  Juan Rangel #12\r\nCol. Altavista', 'Hidalgo del Parral, Chih.', '33860', 'Chih.', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(39, 'akaunting', 45, 'Miguel Ángel Rodríguez', NULL, NULL, '6275179105', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(40, 'akaunting', 46, 'Esteicy Barrón López', NULL, NULL, '656 167 3729', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(41, 'akaunting', 47, 'Araceli Barai', NULL, NULL, '6491960804', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(42, 'akaunting', 48, 'María de Jesús Sánchez Baca', NULL, NULL, '6271234990', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(43, 'akaunting', 49, 'Yolanda Monje', NULL, NULL, '627 150 4472', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(44, 'akaunting', 50, 'Alma Villalobos', NULL, NULL, '6566690976', 'Calle Alfareña #10\r\nCol. Centro', 'Parral', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(45, 'akaunting', 51, 'Vianney Portillo', NULL, NULL, '6141258583', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(46, 'akaunting', 52, 'Escuela Primaria Felipe Ángeles', NULL, NULL, '656 595 9999', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(47, 'akaunting', 53, 'ELIZABETH TENIENTE', NULL, NULL, '6271159409', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(48, 'akaunting', 54, 'Esc. María de la Cruz Reyes Profr. Erik', NULL, NULL, '6567870958', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(49, 'akaunting', 55, 'Sección 20', NULL, NULL, '6271779282', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(50, 'akaunting', 56, 'Alondra González', NULL, NULL, '6271025569', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(51, 'akaunting', 57, 'Alejandra Meza', NULL, NULL, '6271321620', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(52, 'akaunting', 58, 'Allitzel A. Primero Valenzuela', NULL, NULL, '627 140 0862', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(53, 'akaunting', 59, 'Yaritzel Molina', NULL, NULL, '649 114 6862', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(54, 'akaunting', 60, 'Karmin', NULL, NULL, '627 517 7922', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(55, 'akaunting', 61, 'Daniel Castillo', NULL, NULL, '6271747551', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(56, 'akaunting', 62, 'Jorge Luis Bustillos Aguirre', NULL, NULL, '627 110 2567', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(57, 'akaunting', 63, 'GEOTEST Geotecnia y Supervisión Tècnica S.A. de C.V. Haidee Estefanía Contreras Pérez', NULL, NULL, '2281371713', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(58, 'akaunting', 64, 'A.P.F. J.N. Gabriel García Márquez', NULL, NULL, NULL, 'Municipio de Parral s/n', 'Parral', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(59, 'akaunting', 65, 'María Salazar', NULL, NULL, '627 177 2826', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(60, 'akaunting', 66, 'Zulema Baeza', NULL, NULL, '627 144 9467', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(61, 'akaunting', 67, 'Yajaira Flores', NULL, NULL, '614 122 4022', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(62, 'akaunting', 68, 'Raquel Carrera', NULL, NULL, '6271237205', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(63, 'akaunting', 69, 'Eva Villegas', NULL, NULL, '627 122 2934', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(64, 'akaunting', 70, 'Karla Granados', NULL, NULL, '627 103 3929', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(65, 'akaunting', 71, 'Cinthia López', NULL, NULL, '627 142 9218', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(66, 'akaunting', 72, 'Lizbeth Canchola', NULL, NULL, '6271730702', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(67, 'akaunting', 73, 'Raúl Méndez', NULL, NULL, '6271130196', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(68, 'akaunting', 74, 'Yorlett', NULL, NULL, '627 143 2776', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(69, 'akaunting', 75, 'Claudia María Cervantes Villalobos', NULL, NULL, '627 139 5548', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(70, 'akaunting', 76, 'Nicol Valenzuela', 'fred.guillermo@gmail.com', NULL, '6563735317', 'Alemania 87\r\nLOMALINDA', 'Hidalgo del Parral', '33820', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(71, 'akaunting', 77, 'Yanet Chávez', NULL, NULL, '614 495 1415', NULL, 'Hidalgo del Parral', '33800', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(72, 'akaunting', 78, 'Glorisel Madrigal', 'gloriselmadrigal96@gmail.com', NULL, '6271037053', NULL, 'Hidalgo del Parral', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(73, 'akaunting', 79, 'Ahylin Gutiérrez', NULL, NULL, '6271736233', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(74, 'akaunting', 80, 'Pepe Pichardo', 'delfin810321@hotmail.com', NULL, '6271506406', NULL, 'Hidalgo del Parral', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(75, 'akaunting', 81, 'Flor Hernández', NULL, NULL, '627 131 9486', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(76, 'akaunting', 82, 'SERGIO SALVADOR MARTHA ARREDONDO', NULL, NULL, '6271782236', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(77, 'akaunting', 83, 'Cristina Monarrez', NULL, NULL, '6272790484', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(78, 'akaunting', 84, 'Janeth Monarrez', NULL, NULL, '627 517 6543', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(79, 'akaunting', 85, 'Berny Marquez', NULL, NULL, '627 521 5556', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(80, 'akaunting', 86, 'Cindy Domínguez Alonso', NULL, NULL, '614 444 9463', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(81, 'akaunting', 87, 'Ana Hernández', NULL, NULL, '627 139 3944', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(82, 'akaunting', 88, 'Verónica Madrigal', NULL, NULL, '627 115 1599', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(83, 'akaunting', 89, 'Karla Hernández', NULL, NULL, '627 148 7448', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(84, 'akaunting', 90, 'Sandra Cigarroa Olivas', NULL, NULL, '649 392 9561', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(85, 'akaunting', 91, 'José Amilano', NULL, NULL, '648 132 1566', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(86, 'akaunting', 92, 'Comercializadora de Refacciones y Mantenimiento', NULL, NULL, '627 121 4527', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(87, 'akaunting', 93, 'Yazmin Acosta', NULL, NULL, '6271043317', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(88, 'akaunting', 94, 'Marilu Carrón', NULL, NULL, '871 156 6321', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(89, 'akaunting', 95, 'YAREMI VILLALOBOS', NULL, NULL, '6567778597', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(90, 'akaunting', 96, 'Dora', NULL, NULL, '627 107 964', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(91, 'akaunting', 97, 'Claudia Mesta', NULL, NULL, '627 149 6907', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(92, 'akaunting', 98, 'Eneida Saenz', NULL, NULL, '6271476374', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(93, 'akaunting', 99, 'Gabriela Gardea', NULL, NULL, '627 106 9167', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(94, 'akaunting', 100, 'Angelli Rosas', NULL, NULL, '55 6063 0880', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(95, 'akaunting', 101, 'Mónica Martínez', NULL, NULL, '6271500984', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(96, 'akaunting', 102, 'Mónica Martínez', NULL, NULL, '627 150 0984', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(97, 'akaunting', 103, 'Julia Varela', NULL, NULL, '6272796844', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(98, 'akaunting', 104, 'Guillermo', NULL, NULL, '627 142 1834', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(99, 'akaunting', 105, 'Juan Fernando Ochoa', NULL, NULL, '656 626 5248', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(100, 'akaunting', 106, 'Angélica (Municipio Santa Bárbara)', NULL, NULL, '627 108 4172', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(101, 'akaunting', 107, 'Erika', NULL, NULL, '6271037867', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(102, 'akaunting', 108, 'Erika Samanta Guerrero Guerrero', NULL, NULL, '6271067179 y 6275233654', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(103, 'akaunting', 109, 'Mario Orquiz', NULL, NULL, '6271743497', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(104, 'akaunting', 110, 'Esc. Prim. Fed. Emiliano Zapata', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(105, 'akaunting', 111, 'Ana María Juárez Díaz', 'anamariajuarezdiaz@hotmail.com', NULL, '5518942250', 'Calle 6#106 ED.9 DEP.101 COL. AGRICOLA PANTITLAN DELG.', 'IZTACALCO', '08100', 'Ciudad de México', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(106, 'akaunting', 112, 'Judith Molina', NULL, NULL, '627 173 0714', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(107, 'akaunting', 113, 'Itzel', NULL, NULL, '6181565396', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(108, 'akaunting', 114, 'Berenice', NULL, NULL, '6271027767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(109, 'akaunting', 115, 'Lizbeth Ramos', NULL, NULL, '649 107 6610', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(110, 'akaunting', 116, 'Oscar', NULL, NULL, '6271128688', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(111, 'akaunting', 117, 'Sandra', NULL, NULL, '649 103 1800', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(112, 'akaunting', 118, 'Esc. Prim. Centenario del Ejército Mexicano', NULL, NULL, '6271213207', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(113, 'akaunting', 119, 'Yaneth Reyes', NULL, NULL, '6271211790', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(114, 'akaunting', 120, 'Sandra Cigarroa', NULL, NULL, '6491031800', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(115, 'akaunting', 121, 'Alma', NULL, NULL, '627 112 6118', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(116, 'akaunting', 122, 'Eden Méndez', NULL, NULL, '871 786 2350', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(117, 'akaunting', 123, 'Reyna Balbuena', NULL, NULL, '6271125152', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(118, 'akaunting', 124, 'Mónica Leticia Malanco Gutiérrez', 'lilith_monika@hotmail.com', NULL, '7226480311', 'Ejército de Oriente 123\r\nCol. Héroes del 5 de Mayo', 'Toluca', '5017', 'México', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(119, 'akaunting', 125, 'Mónica Leticia Malanco Gutiérrez', NULL, NULL, '7226480311', 'Ejército de Oriente 123\r\nCol. Héroes del 5 de Mayo', 'Toluca', '50170', 'México', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(120, 'akaunting', 126, 'Guadalupe Chavez', NULL, NULL, '6271105090', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(121, 'akaunting', 127, 'Instituto Bostón Gabriela Gardea', NULL, NULL, '871 568 4148', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(122, 'akaunting', 128, 'Martín Humberto Aguirre Arzola', NULL, NULL, '6271216504', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(123, 'akaunting', 129, 'José Méndez', NULL, NULL, '6144623590', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(124, 'akaunting', 130, 'José Guadalupe Méncez', NULL, NULL, '614 462 3590', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(125, 'akaunting', 131, 'Brenda Ontiveros', NULL, NULL, '6271034334', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(126, 'akaunting', 132, 'Elizabeth Morales', NULL, NULL, '6271064484', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(127, 'akaunting', 133, 'Pao (Bubble Bar)', NULL, NULL, '6271400840', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(128, 'akaunting', 134, 'Edeèn Varela', NULL, NULL, '6271313272', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(129, 'akaunting', 135, 'Angélica Holguín', NULL, NULL, '6291063459', NULL, 'Jiménez', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(130, 'akaunting', 136, 'Flor Guzmán', NULL, NULL, '6275171410', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(131, 'akaunting', 137, 'CARLOS GALVAN', 'carlosenriquegg30@gmail.com', NULL, '6271030748', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(132, 'akaunting', 138, 'Carolina Ramírez', NULL, NULL, '6271082626', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(133, 'akaunting', 139, 'Sarah', NULL, NULL, '6271047289', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(134, 'akaunting', 140, 'Movimiento Familiar Cristiano Diocesis Parral', NULL, NULL, '627 104 6620', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(135, 'akaunting', 141, 'Amilcar Nava Bailón', NULL, NULL, '6143343182', 'Calle 20 de noviembre #18\r\nreferencia a un lado de dulcería', 'Parral', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(136, 'akaunting', 142, 'Patricia Moreno', NULL, NULL, '6271086591', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(137, 'akaunting', 143, 'Rocio Rubio', 'Shiorubio2424@gmail.com', NULL, '627 113 9802', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(138, 'akaunting', 144, 'Carlos Garcia', NULL, NULL, '627 177 4253', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(139, 'akaunting', 145, 'Soledad Aguirre', NULL, NULL, '627 139 3171', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(140, 'akaunting', 146, 'Carmen Verónica Hernández', NULL, NULL, '6271475545', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(141, 'akaunting', 147, 'Merlisa', NULL, NULL, '8711091892', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(142, 'akaunting', 148, 'Diana Núñez', NULL, NULL, '627 123 1389', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(143, 'akaunting', 149, 'Elizabeth Chávez Del Toro', NULL, NULL, '6271488209', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(144, 'akaunting', 150, 'Marcela Vazque Gomez', NULL, NULL, '6271123525', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(145, 'akaunting', 151, 'Sandra Muñoz', NULL, NULL, '6143634347', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(146, 'akaunting', 152, 'Esc. Prim. Ignacio Allende', 'hugoivanurangaavalos@gmial.com', NULL, '6565858937', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(147, 'akaunting', 153, 'Dania García', NULL, NULL, '6143457138', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(148, 'akaunting', 154, 'Samanta Holguin', NULL, NULL, '627 133 7779', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(149, 'akaunting', 155, 'Claudia María Cervantes', NULL, NULL, '6271395548', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(150, 'akaunting', 156, 'Alejandra Duarte', NULL, NULL, '627 115 7512', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(151, 'akaunting', 157, 'Marily Corral', NULL, NULL, '627 135 8100', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(152, 'akaunting', 158, 'Marily Corral', NULL, NULL, '627 135 8100', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(153, 'akaunting', 159, 'MIREYA RODRIGUEZ', NULL, NULL, '6271040573', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(154, 'akaunting', 160, 'Homero Nava', NULL, NULL, '6491033922', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(155, 'akaunting', 161, 'Eva', NULL, NULL, '627 111 9600', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(156, 'akaunting', 162, 'Diana Rodríguez Salas', NULL, NULL, '6275172150', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(157, 'akaunting', 163, 'Ivon', NULL, NULL, '6271177192', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(158, 'akaunting', 164, 'Adriana Hernández', NULL, NULL, '627 139 2846', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(159, 'akaunting', 165, 'Nubia Alondra Chávez', NULL, NULL, '627 112 8408', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(160, 'akaunting', 166, 'Ivette', NULL, NULL, '627 113 4993', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(161, 'akaunting', 167, 'Yaretzi', NULL, NULL, '627 104 1826', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(162, 'akaunting', 168, 'Jessica Lizeth Vicente Garcia', NULL, NULL, '664 362 2156', 'Calle de las fuentes #12462 col. 20 de noviembre,', 'Tijuana B.C.', '22100', 'Baja California', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(163, 'akaunting', 169, 'Irvin Esparza', NULL, NULL, '6272799391', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(164, 'akaunting', 170, 'Omar Gómez', NULL, NULL, '627 150 7675', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(165, 'akaunting', 171, 'Esc. Prim. Ma. Brisia Rodríguez', NULL, NULL, '627 113 3333', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(166, 'akaunting', 172, 'Rocio', NULL, NULL, '614 373 4701', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(167, 'akaunting', 173, 'Laura Hernández', NULL, NULL, '6271117298', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(168, 'akaunting', 174, 'Esc. Prim. Centenario del Ejército Mexicano', NULL, NULL, '6271049835', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(169, 'akaunting', 175, 'Andrea Soto', NULL, NULL, '6271144483', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(170, 'akaunting', 176, 'Lore Coronado', NULL, NULL, '627 279 8826', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(171, 'akaunting', 177, 'Ana Rodríguez', NULL, NULL, '6271443005', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(172, 'akaunting', 178, 'J.N. Jesús Lozoya Solís #1127', NULL, NULL, '627 113 7667', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(173, 'akaunting', 179, 'Luis Payan', NULL, NULL, '656 704 2713', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(174, 'akaunting', 180, 'Carolina García Gutiérrez', NULL, NULL, '6271213331', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(175, 'akaunting', 181, 'Marilú', NULL, NULL, '627 139 9730', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(176, 'akaunting', 182, 'Esc. Sec. Tec. #70', NULL, NULL, '6271543973', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(177, 'akaunting', 183, 'Javier', NULL, NULL, '6271779051', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(178, 'akaunting', 184, 'Jonathan', NULL, NULL, '6271780925', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(179, 'akaunting', 185, 'Perla Nallely Saenz Bustillos', NULL, NULL, '6271437936', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(180, 'akaunting', 186, 'Esc. Prim. Jesús González Ortega', NULL, NULL, '6271507728', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(181, 'akaunting', 187, 'Ervey Rubio', NULL, NULL, '627 517 0287', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(182, 'akaunting', 188, 'Enedina Pérez', NULL, NULL, '627 143 5122', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(183, 'akaunting', 189, 'Esc. Profa Carmen Tarín Ibarra', NULL, NULL, '627 104 9311', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(184, 'akaunting', 190, 'Barbadoa IAN', NULL, NULL, '6272797834', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(185, 'akaunting', 191, 'Jesús Carbajal', NULL, NULL, '6271219050', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(186, 'akaunting', 192, 'Geisa Saenz', NULL, NULL, '6141155681', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(187, 'akaunting', 193, 'CENTRO DE INTERVENCION EN CRISIS ALMA CALMA AC', NULL, NULL, '614 523 0454', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(188, 'akaunting', 194, 'Fernando', NULL, NULL, '627 147 1916', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(189, 'akaunting', 195, 'Yuridia Gastelum', NULL, NULL, '627 132 9497', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(190, 'akaunting', 196, 'Liliana Cañez', NULL, NULL, '627 177 4144', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(191, 'akaunting', 197, 'EZEQUIEL ORQUIZ', NULL, NULL, '6271216554', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(192, 'akaunting', 198, 'Ana Flores', NULL, NULL, '6271125178', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(193, 'akaunting', 199, 'Primaria Emiliano Zapata', NULL, NULL, '6141020760', 'Venceremos y Che Guevara s/n Col. Tierra y Libertad', 'Jiménez', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(194, 'akaunting', 200, 'Noemi', NULL, NULL, '6278895844', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(195, 'akaunting', 201, 'Kevin valverde', NULL, NULL, '6271398651', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(196, 'akaunting', 202, 'Lourdes Chávez', NULL, NULL, '627 103 5309', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(197, 'akaunting', 203, 'Eden Varela', NULL, NULL, '6271313272', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(198, 'akaunting', 204, 'Amparo', NULL, NULL, '2283231767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(199, 'akaunting', 205, 'Luz del Carmen', NULL, NULL, '627 111 3652', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(200, 'akaunting', 206, 'Mercedes Solís', NULL, NULL, '627 517 8693', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(201, 'akaunting', 207, 'María Guzmán  Grupo Abreu', NULL, NULL, '55 3888 7332', NULL, 'México Delegación Coyoacán', NULL, 'México', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(202, 'akaunting', 208, 'Alexis Rodríguez', NULL, NULL, '627 119 5317', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(203, 'akaunting', 209, 'Elsa Tarin', NULL, NULL, '6271231891', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(204, 'akaunting', 210, 'Leslie Hernandez', NULL, NULL, '6291092461', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(205, 'akaunting', 211, 'Pedro Corral', NULL, NULL, '6291091302', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(206, 'akaunting', 212, 'Susana Gardea', NULL, NULL, '6271107702', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(207, 'akaunting', 213, 'Eloy', NULL, NULL, '4421390936', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(208, 'akaunting', 214, 'Brenda Molina', NULL, NULL, '6275215615', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(209, 'akaunting', 215, 'Anai Carbajal Morales', NULL, NULL, '656 222 3483', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(210, 'akaunting', 216, 'Hospital de ginecoobstetricia Parral', NULL, NULL, '614 607 6259', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(211, 'akaunting', 217, 'Andrea Granados', NULL, NULL, '6271033929', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(212, 'akaunting', 218, 'Alondra', NULL, NULL, '6271335817', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(213, 'akaunting', 219, 'Guadalupe Salgado', NULL, NULL, '627 521 2651', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(214, 'akaunting', 220, 'Misael Ramos', NULL, NULL, '6271354980', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(215, 'akaunting', 221, 'Elizabeth Arciniega', NULL, NULL, '627 521 2974', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(216, 'akaunting', 222, 'Jaquelin Montes', NULL, NULL, '6271025522', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(217, 'akaunting', 223, 'Paty chavira', NULL, NULL, '627 174 9665', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(218, 'akaunting', 224, 'Irais Domínguez', 'irais@onetoonegroup.mx', NULL, '+52 1 55 2363 1974', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(219, 'akaunting', 225, 'Ana Gabriela Toledo Hernández', NULL, NULL, '+52 1 777 218 7839', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(220, 'akaunting', 226, 'Francisco Javier', NULL, NULL, '6271323455', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(221, 'akaunting', 227, 'Ana Gabriela Toledo Hernández', NULL, NULL, '+52 1 777 218 7839', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(222, 'akaunting', 228, 'Cosme Baca', NULL, NULL, '6271138696', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(223, 'akaunting', 229, 'Thelma Ogaz', NULL, NULL, '6271057210', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(224, 'akaunting', 230, 'Tecnológico de Parral  Con atención al Ing. Juan José Mora  Jefe de recursos materiales', NULL, NULL, '627 123 6857', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(225, 'akaunting', 231, 'Oscar Solís', NULL, NULL, '+1 (720) 988-9476', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(226, 'akaunting', 232, 'Lizeth Barajas', NULL, NULL, '6271053943', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(227, 'akaunting', 233, 'Yazmin Carreon', NULL, NULL, '627 131 1654', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(228, 'akaunting', 234, 'Leticia Palomares', NULL, NULL, '6271089648', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(229, 'akaunting', 235, 'Arely Martínez', NULL, NULL, '656 329 8971', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(230, 'akaunting', 236, 'Fedra Teniente', NULL, NULL, '6271159409', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(231, 'akaunting', 237, 'Alondra Lazos', NULL, NULL, '6271136398', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(232, 'akaunting', 238, 'Guadalupe Alberto', NULL, NULL, '5564462208', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(233, 'akaunting', 239, 'Indian motorcycle Agencia cdmx', NULL, NULL, '+52 55 6565 7058', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(234, 'akaunting', 240, 'Esly', NULL, NULL, '6562142405', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(235, 'akaunting', 241, 'Mayra Vargas', NULL, NULL, '627 106 7938', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(236, 'akaunting', 242, 'Josue Arellanes', NULL, NULL, '627 889 6997', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(237, 'akaunting', 243, 'Nancy Méndez', NULL, NULL, '627 113 7667', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(238, 'akaunting', 244, 'Judith Gardea', NULL, NULL, '627 119 4507', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(239, 'akaunting', 245, 'Ana Gonzalez Loera', NULL, NULL, '6271087730', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(240, 'akaunting', 246, 'Daniela', NULL, NULL, '627 107 9334', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(241, 'akaunting', 247, 'Yaneth', NULL, NULL, '627 111 0073', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(242, 'akaunting', 248, 'Carolina', NULL, NULL, '5541920292', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(243, 'akaunting', 249, 'Jorge', NULL, NULL, '55 1333 5864', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(244, 'akaunting', 250, 'Esc. Prim. Vicente Guerrero', NULL, NULL, '627 102 0723', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(245, 'akaunting', 251, 'Esc. Prim. Jesùs González Ortega', NULL, NULL, '6271234990', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(246, 'akaunting', 252, 'Ma. Jesùs Sánchez', NULL, NULL, '6271234990', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(247, 'akaunting', 253, 'Ervey Rubio', NULL, NULL, '6275170287', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(248, 'akaunting', 254, 'Erika Bustillos', 'erikamitzy@gmail.com', 'BUAE8208274R5', '+526271470053', 'ALEMANIA 87', 'HIDALGO DEL PARRAL', '33820', 'CHIHUAHUA', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(249, 'akaunting', 255, 'luis gardea', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(250, 'akaunting', 256, 'Diana', NULL, NULL, '6271060146', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(251, 'akaunting', 257, 'Alfredo Tortillería Dan y Omar', NULL, NULL, '6271237907', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(252, 'akaunting', 258, 'Esc. Prim. Ma. Brisia Rodriguez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(253, 'akaunting', 259, 'María José Fonseca García', NULL, NULL, '5554312535', 'C. Tiburcio Sánchez de la Barquera ·116 interior 508\r\nBenito Juárez. Colonia Merced Juárez', 'Ciudad de México', '03930', 'Mèxico', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(254, 'akaunting', 260, 'Yuli Ramirez', NULL, NULL, '433 105 3847', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(255, 'akaunting', 261, 'JOAQUIN MEDINA', NULL, NULL, '+1 480 650 7926', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(256, 'akaunting', 262, 'Salma', NULL, NULL, '6275209949', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(257, 'akaunting', 263, 'CLAUDIA', NULL, NULL, '627 108 2209', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(258, 'akaunting', 264, 'VIOLETA RUIZ', NULL, NULL, '627 114 2818', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(259, 'akaunting', 265, 'Melida', NULL, NULL, '627 110 4468', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(260, 'akaunting', 266, 'Jorge Tamayo Bustillos', NULL, NULL, '6271192730', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(261, 'akaunting', 267, 'Susana Silva (Jardín de niños Miguel Hidalgo)', NULL, NULL, '627 139 9489', 'Guadalupe y Calvo', NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(262, 'akaunting', 268, 'Sergio', NULL, NULL, '627 104 6620', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(263, 'akaunting', 269, 'Angel Silva', NULL, NULL, '6275218294', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(264, 'akaunting', 270, 'Gabriel Urbina', NULL, NULL, '627 142 6793', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(265, 'akaunting', 271, 'Jhony', NULL, NULL, '6271234108', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(266, 'akaunting', 272, 'Cecilia Frías', NULL, NULL, '6271151801', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(267, 'akaunting', 273, 'Faviola Rodriguez', NULL, NULL, '+52 1 55 3462 6933', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(268, 'akaunting', 274, 'Julieta Carrillo', NULL, NULL, '6271396611', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(269, 'akaunting', 275, 'Jazmin Tarin Soto', NULL, NULL, '6272791739', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(270, 'akaunting', 276, 'Jazmín Tarin Soto (tesorera)', NULL, NULL, '627 279 1739', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(271, 'akaunting', 277, 'Lizbett Cereceres', NULL, NULL, '6271034971', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(272, 'akaunting', 278, 'Rocio Luna Gardea', NULL, NULL, '6143734701', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(273, 'akaunting', 279, 'Carniceria Carrillo', NULL, NULL, '6741013745', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(274, 'akaunting', 280, 'Tejidos locales Agroalimentarios en Red', NULL, NULL, '55 5963 7661', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(275, 'akaunting', 281, 'Jenni', NULL, NULL, '6271215465', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(276, 'akaunting', 282, 'Merced Gutiérrez', NULL, NULL, '6271238632', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(277, 'akaunting', 283, 'Yaritza', NULL, NULL, '6271446225', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(278, 'akaunting', 284, 'Edgar Rosas', NULL, NULL, '6563125423', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(279, 'akaunting', 285, 'Ocote Premium', NULL, NULL, '6271330947', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(280, 'akaunting', 286, 'Karla Mendez', NULL, NULL, '6271200642', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(281, 'akaunting', 287, 'Alexa Escarcega', NULL, NULL, '6271153453', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(282, 'akaunting', 288, 'Adriana Medina', NULL, NULL, '6272790093', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(283, 'akaunting', 289, 'Rocio Garcia', NULL, NULL, '6271030748', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(284, 'akaunting', 290, 'Mariana (TEXA)', NULL, NULL, '8715070367', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(285, 'akaunting', 291, 'Telesecundaria', NULL, NULL, '6271494978', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(286, 'akaunting', 292, 'Esmeralda Anahi Carrillo Ramos', NULL, NULL, '6741013745', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(287, 'akaunting', 293, 'Janeth Saenz', NULL, NULL, '6271110073', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(288, 'akaunting', 294, 'Laura Ríos', NULL, NULL, '627 144 1521', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(289, 'akaunting', 295, 'Daniela Sotelo', NULL, NULL, '627 111 8390', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(290, 'akaunting', 296, 'Daniela', NULL, NULL, '627 111 8390', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(291, 'akaunting', 297, 'Gloria Herrera', NULL, NULL, '6271176103', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(292, 'akaunting', 298, 'Veronica de la O', NULL, NULL, '627 114 6399', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(293, 'akaunting', 299, 'Lia Lee', NULL, NULL, '614 289 7217', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(294, 'akaunting', 300, 'Chantal Gutierréz', NULL, NULL, '627 143 7440', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(295, 'akaunting', 301, 'Johana Guzman', NULL, NULL, '627 139 7669', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(296, 'akaunting', 302, 'Dulce Armendariz', NULL, NULL, '6271029959', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(297, 'akaunting', 303, 'Carla Chávez', NULL, NULL, '627 108 8429', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(298, 'akaunting', 304, 'Julieta Morales', NULL, NULL, '629 103 6794', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(299, 'akaunting', 305, 'Celeste Ochoa', NULL, NULL, '6271065774', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(300, 'akaunting', 306, 'Brenda', NULL, NULL, '627 131 0473', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(301, 'akaunting', 307, 'Claudia Yesenia Arreola Rodriguez', NULL, NULL, '6271429987', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(302, 'akaunting', 308, 'Nayib', NULL, NULL, '627 105 2926', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(303, 'akaunting', 309, 'Ervey Rubio', NULL, NULL, '627 517 0287', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(304, 'akaunting', 310, 'Itzel', NULL, NULL, '627 102 0723', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(305, 'akaunting', 311, 'Mario', NULL, NULL, '627 115 9920', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(306, 'akaunting', 312, 'Fernando', NULL, NULL, '627 108 8346', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(307, 'akaunting', 313, 'Itzel Carrera', NULL, NULL, '6271484084', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(308, 'akaunting', 314, 'Alex', NULL, NULL, '627 143 9025', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(309, 'akaunting', 315, 'Sandra', NULL, NULL, '627 279 5634', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13');
INSERT INTO `cp_customers` (`id`, `source_type`, `source_id`, `name`, `email`, `tax_number`, `phone`, `address`, `city`, `zip_code`, `state`, `country`, `notes`, `enabled`, `created_at`, `updated_at`) VALUES
(310, 'akaunting', 316, 'Alejandra', NULL, NULL, '627 173 2636', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(311, 'akaunting', 317, 'Vanely', NULL, NULL, '627 143 8180', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(312, 'akaunting', 318, 'Sol', NULL, NULL, '627 113 2340', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(313, 'akaunting', 319, 'Elisa Chàvez', NULL, NULL, '6491037422', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(314, 'akaunting', 320, 'Elizabeth', NULL, NULL, '6271488209', NULL, 'Jiménez', NULL, 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(315, 'akaunting', 321, 'Perla Aracely Villezcas Ramos', NULL, NULL, '614 2775 353', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(316, 'akaunting', 322, 'Lorenzo Antonio', NULL, NULL, '6271130903', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(317, 'akaunting', 323, 'Alma Moya', NULL, NULL, '6271235656', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(318, 'akaunting', 324, 'Erika Valenzuela', NULL, NULL, '6271038712', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(319, 'akaunting', 325, 'Suhey Mata Publicidad', NULL, NULL, '871 523 7508', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(320, 'akaunting', 326, 'Alondra Tarin', NULL, NULL, '627 133 5817', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(321, 'akaunting', 327, 'Erika Elizabeth Bustillos Aguirre', NULL, NULL, '627 147 0053', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(322, 'akaunting', 328, 'Karla Jazmin Martinez Torres', NULL, NULL, '627 149 7077', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(323, 'akaunting', 329, 'Crece con Vales', NULL, NULL, '6271120983', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(324, 'akaunting', 330, 'Profesora Delil Aguirre', NULL, NULL, '6271154064', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(325, 'akaunting', 331, 'Profr. Gerardo Rodriguez', NULL, NULL, '627 117 0819', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(326, 'akaunting', 332, 'Luz', NULL, NULL, '614 123 2399', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(327, 'akaunting', 333, 'Rocio Escalante', NULL, NULL, '627 279 6767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(328, 'akaunting', 334, 'Sergio', NULL, NULL, '6271332582', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(329, 'akaunting', 335, 'Diosmar', NULL, NULL, '6341108391', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(330, 'akaunting', 336, 'Analy Valenzuela', NULL, NULL, '627 107 4848', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(331, 'akaunting', 337, 'Enrique Carrera', NULL, NULL, '6271125767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(332, 'akaunting', 338, 'ARIZONA el estado del gran cañon', NULL, NULL, '2222388764', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(333, 'akaunting', 339, 'Anahi Lozano', NULL, NULL, '6271021195', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(334, 'akaunting', 340, 'Laura Peinado', NULL, NULL, '6565734434', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(335, 'akaunting', 341, 'Reyna', NULL, NULL, '6271331122', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(336, 'akaunting', 342, 'Christian Galan', NULL, NULL, '52 1 55 9190 3512', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(337, 'akaunting', 343, 'Aaron Bustillos', NULL, NULL, '627 111 5366', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(338, 'akaunting', 344, 'Suhey Mata', NULL, NULL, '8715237508', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(339, 'akaunting', 345, 'Myrna Sáenz', NULL, NULL, '6272794894', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(340, 'akaunting', 346, 'MacLean Mèxico /  Eloy', NULL, NULL, '+52 1 442 139 0936', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(341, 'akaunting', 347, 'Fundación Dondé  / Dannyel Jamin Morales Bonilla', 'demorales.bec@frd.org.mx', NULL, '9999707550 ext 1437', 'Av. Independencia #310 \r\nCol. Centro', 'Hidalgo del Parral', '33800', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(342, 'akaunting', 348, 'Mayra Brito', NULL, NULL, '627 117 2239', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(343, 'akaunting', 349, 'Rosendo Carrilo', NULL, NULL, '627 150 9182', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(344, 'akaunting', 350, 'Ayled Castillo Lazos', NULL, NULL, '627 177 1568', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(345, 'akaunting', 351, 'Claudia Prieto', NULL, NULL, '614 216 3745', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(346, 'akaunting', 352, 'Edith Núñez', NULL, NULL, '6271046644', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(347, 'akaunting', 353, 'Iván Rodríguez', NULL, NULL, '614 209 8597', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(348, 'akaunting', 354, 'Diana Quintana', NULL, NULL, '6145467930', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(349, 'akaunting', 355, 'María de la Luz Sevares', NULL, NULL, '55 5401 0805', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(350, 'akaunting', 356, 'Claudia Karina Vargas campos', NULL, NULL, '627 133 2600', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(351, 'akaunting', 357, 'Gabriel López Chávez', NULL, NULL, '627 133 2600', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(352, 'akaunting', 358, 'Alondra Suarez', NULL, NULL, '627 131 4436', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(353, 'akaunting', 359, 'Vanesa Chaparro', NULL, NULL, '6271437270', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(354, 'akaunting', 360, 'Angel Ramos', NULL, NULL, '627 177 7421', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(355, 'akaunting', 361, 'Jorge', NULL, NULL, '627 151 9139', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(356, 'akaunting', 362, 'Georgina Chávez', NULL, NULL, '627 524 1176', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(357, 'akaunting', 363, 'Rebeca', NULL, NULL, '627 115 6284', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(358, 'akaunting', 364, 'Omilba Duarte', NULL, NULL, '627 148 8821', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(359, 'akaunting', 365, 'Christian Giovanny', NULL, NULL, '52 1 951 231 4196', 'Escuela Naval 407, esquina amapolas, Colina Reforma\r\nNegocio de comida D´Villatortas', 'Oaxaca', '68050', 'Oaxaca de Juárez', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(360, 'akaunting', 366, 'Selene Molina', NULL, NULL, '6672684614', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(361, 'akaunting', 367, 'Adriana Lozano Reyes', NULL, NULL, '656 551 1843', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(362, 'akaunting', 368, 'Olga Auday', NULL, NULL, '5626448317', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(363, 'akaunting', 369, 'José Manuel Bosquez Alarcón', NULL, NULL, '6271178615', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(364, 'akaunting', 370, 'Gobierno del Estado de Chihuahua', NULL, NULL, '656 777 8597', 'Venustiano Carranza 601', 'Chihuahua', '31350', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(365, 'akaunting', 371, 'Alondra Tarín', NULL, NULL, '627 133 5817', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(366, 'akaunting', 372, 'Elotes San Ángel', NULL, NULL, '627 120 5242', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(367, 'akaunting', 373, 'Zenet Pineda', NULL, NULL, '6271399643', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(368, 'akaunting', 374, 'Zulema Saldaña', NULL, NULL, '6271023023', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(369, 'akaunting', 375, 'Fabiola Gamboa', NULL, NULL, '999 194 8787', 'CALLE 46 #488 POR 57 Y 59 CENTRO , \r\n\r\nOFICINA MUEBLES ANTEA  , EDIFICIO AZUL CON GRIS HORARIO DE 10 A 4', 'MERIDA', '97000', 'YUCATÁN', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(370, 'akaunting', 376, 'Jesús Armando Pacheco', NULL, NULL, '614 192 9840', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(371, 'akaunting', 377, 'Perla Peña', NULL, NULL, '6275177886', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(372, 'akaunting', 378, 'Betty', NULL, NULL, '627 102 1023', 'Esc. Prim. Club de Leones', NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(373, 'akaunting', 379, 'Mari Soto', NULL, NULL, '627 521 6737', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(374, 'akaunting', 380, 'Patricia Salgado', NULL, NULL, '627 147 3670', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(375, 'akaunting', 381, 'Julián Ibarra López', NULL, NULL, '6561903168', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(376, 'akaunting', 382, 'Sec. 34', NULL, NULL, '6271066922', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(377, 'akaunting', 383, 'Esc. Ma Brisia Rodríguez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(378, 'akaunting', 384, 'Miryam Muñoz', NULL, NULL, '6271484402', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(379, 'akaunting', 385, 'Anahi', NULL, NULL, '6271120971', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(380, 'akaunting', 386, 'Lina Delgado', NULL, NULL, '6271471074', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(381, 'akaunting', 387, 'Brenda Bailon', NULL, NULL, '627 113 1802', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(382, 'akaunting', 388, 'ELYMSA', NULL, NULL, '+52 649 104 3888', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(383, 'akaunting', 389, 'Wilma Josselyn Ayala Lazos', NULL, NULL, '6271047955', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(384, 'akaunting', 390, 'Wilma J Ayala Lazos', NULL, NULL, '6271775490', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(385, 'akaunting', 391, 'Diego Díaz', NULL, NULL, '+52 1 442 833 6203', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(386, 'akaunting', 392, 'Vianey Dominguez Delgado', NULL, NULL, '6271122872', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(387, 'akaunting', 393, 'Guillermina Guzmán', NULL, NULL, '5512881014', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(388, 'akaunting', 394, 'Daiana Loya', NULL, NULL, '627 108 6944', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(389, 'akaunting', 395, 'Armando Cobos', NULL, NULL, '627 174 7548', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(390, 'akaunting', 396, 'Anabel Gutiérrez', NULL, NULL, '6271338171', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(391, 'akaunting', 397, 'Teresita', NULL, NULL, '6271317924', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(392, 'akaunting', 398, 'Blanca Estela Olivas Trujillo', NULL, NULL, '627 123 6511', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(393, 'akaunting', 399, 'CARO', NULL, NULL, '5582049341', 'HAMBURGO 213\r\nPISO 10\r\nCOL. JUAREZ', 'DELEGACION CUAHUTEMOC', '06600', 'CDMX', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(394, 'akaunting', 400, 'BLANCA RODRIGUEZ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(395, 'akaunting', 401, 'Alejandra Corona Hernández', NULL, NULL, '6491049222', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(396, 'akaunting', 402, 'Alely Jazmín', NULL, NULL, '6271126108', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(397, 'akaunting', 403, 'Irasema Barrón', NULL, NULL, '6271444471', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(398, 'akaunting', 404, 'BLANCA RODRIGUEZ', NULL, NULL, '6275245961', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(399, 'akaunting', 405, 'Myrna Nájera', NULL, NULL, '6271491096', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(400, 'akaunting', 406, 'Alicia', NULL, NULL, '6271035813', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(401, 'akaunting', 407, 'Yanira Ramos', NULL, NULL, '6271488821', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(402, 'akaunting', 408, 'Alonso', NULL, NULL, '627 212 8970', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(403, 'akaunting', 409, 'Isis Muñoz', NULL, NULL, '6271423136', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(404, 'akaunting', 410, 'Marcos Saenz', NULL, NULL, '+52 618 260 3414', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(405, 'akaunting', 411, 'Mtra Gaby', NULL, NULL, '+52 627 517 8208', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(406, 'akaunting', 412, 'Ana Carolina Valles Duarte', NULL, NULL, '+52 627 104 1005', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(407, 'akaunting', 413, 'COMERCIALIZADORA ROCAS SA DE CV', NULL, NULL, '+52 833 311 9089', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(408, 'akaunting', 414, 'Claudia Figueroa', NULL, NULL, '+52 55 3273 3995', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(409, 'akaunting', 415, 'Leonardo Olmeda', NULL, NULL, '6491132206', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(410, 'akaunting', 416, 'Gloria Herrera', NULL, NULL, '627 117 6103', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(411, 'akaunting', 417, 'Laura Zamarton', NULL, NULL, '6271041484', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(412, 'akaunting', 418, 'Yadhira Abigail Loya flores', NULL, NULL, '+52 627 131 4236', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(413, 'akaunting', 419, 'Angel', NULL, NULL, '+52 627 135 3550', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(414, 'akaunting', 420, 'Felix', NULL, NULL, '+52 614 403 4942', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(415, 'akaunting', 421, 'Abraham Soveranis', NULL, NULL, '99994079251', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(416, 'akaunting', 422, 'Kasey Chavira', NULL, NULL, '925 272 8082', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(417, 'akaunting', 423, 'Jessica Puerto Cardeña', 'Jpuerto.bec@frd.org.mx', NULL, '(999) 9407550 ext 1432', 'Calle 60 x 35 #346 Edificio Paseo 60 Col. Centro', 'Mérida', '97000', 'Yucatán', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(418, 'akaunting', 424, 'RUTILO ROMAN LÓPEZ', 'roman_uaaan@hotmail.com', NULL, '523329721523', 'CRUCERO JOJOTEPEC', 'JALISCO', NULL, 'GUADALAJARA', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(419, 'akaunting', 425, 'Adriana Pèrez', NULL, NULL, '6271152175', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(420, 'akaunting', 426, 'Diana Sifuentes', NULL, NULL, '6271494793', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(421, 'akaunting', 427, 'Ilse Luna', NULL, NULL, '6275210739', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(422, 'akaunting', 428, 'Anahí Frausto', NULL, NULL, '6291230068', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(423, 'akaunting', 429, 'Gladys Muniz', NULL, NULL, '6271137055', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(424, 'akaunting', 430, 'Laura Escobar', NULL, NULL, '+52 627 144 0120', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(425, 'akaunting', 431, 'ALEJANDRA ONTIVEROS CANO', NULL, NULL, '6271483799', 'OJITO DURANGO', 'DURANGO', NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(426, 'akaunting', 432, 'Esc, Prim. Ignaco Allende', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(427, 'akaunting', 433, 'Esc. Prim, Vicente Guerrero', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(428, 'akaunting', 434, 'Luisito Gardea', 'luisgardea2311@gmail.com', NULL, '6271074548', 'CIRCUITO MONTE GOLGOTA, FRACC. TERRANOVA SUR', 'JUÁREZ', '32576', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(429, 'akaunting', 435, 'Maribel Medina', NULL, NULL, '+52 998 705 6777', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(430, 'akaunting', 436, 'Escuela Primaria Ford 190 T.M', NULL, NULL, '627 150 0140', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(431, 'akaunting', 437, 'INNOVA PROMOCIONALES', NULL, 'IPR970219NE1', '+52 1 55 1256 8422', 'ALFONSO ESPARZA OTEO\r\nPRIMER PISO', 'ALVARO OBREGON', '01020', 'ALVARO OBREGON', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(432, 'akaunting', 438, 'Efrain', NULL, NULL, '6271024615', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(433, 'akaunting', 439, 'Margarita Arrieta', NULL, NULL, '+52 627 149 4152', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(434, 'akaunting', 440, 'Tania Ramírez', NULL, NULL, '6391149077', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(435, 'akaunting', 441, 'Ashley', NULL, NULL, '+52 627 103 6390', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(436, 'akaunting', 442, 'Brenda Rodriguez', NULL, NULL, '6271124607', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(437, 'akaunting', 443, 'Abdiel Sandoval', NULL, NULL, '52 1 33 1147 6361', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(438, 'akaunting', 444, 'Lusito', 'luisgardeabustillos1@gmail.com', NULL, '6271074512', 'ALEMANIA #87, PROLONGACIÓN PARÍS, PROLONGACIÓN PARÍS', 'HIDALGO DEL PARRAL', '33820', 'CHIHUAHUA', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(439, 'akaunting', 445, 'Jardín de Niños Bertha Aguilera Baca', NULL, NULL, '6271239559', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(440, 'akaunting', 446, 'Luis Baca', NULL, NULL, '627173003', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(441, 'akaunting', 447, 'Esc Centenario del Ejército Mexicano', NULL, NULL, '+52 627 113 7005', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(442, 'akaunting', 448, 'Esmeralda Loera', NULL, NULL, '6271235303', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(443, 'akaunting', 449, 'Victor Vázquez', NULL, NULL, '6271117298', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(444, 'akaunting', 450, 'Andrea Holguin', NULL, NULL, '6271324670', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(445, 'akaunting', 451, 'MINPRO', NULL, NULL, '+52 614 190 5176', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(446, 'akaunting', 452, 'Melissa Minerva Murillo Morín', NULL, NULL, '+52 1 844 122 6677', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(447, 'akaunting', 453, 'Isamar Cervantes', NULL, NULL, '6491137119', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(448, 'akaunting', 454, 'Alessia Frisoni', NULL, NULL, '4427327936', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(449, 'akaunting', 455, 'Nayeli Almanza', NULL, NULL, '627 174 9290', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(450, 'akaunting', 456, 'Jessica', NULL, NULL, '5565280381', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(451, 'akaunting', 457, 'Jazmin', NULL, NULL, '6271171876', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(452, 'akaunting', 458, 'Jorge', NULL, NULL, '6271519139', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(453, 'akaunting', 459, 'Multiservicios RR', NULL, NULL, '+52 627 147 3810', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(454, 'akaunting', 460, 'Saira Ayala', NULL, NULL, '+52 627 112 6301', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(455, 'akaunting', 461, 'Yancarlo', NULL, NULL, '+52 627 177 9565', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(456, 'akaunting', 462, 'Adriana Nuñez', NULL, NULL, '+52 627 119 2148', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(457, 'akaunting', 463, 'Abril García', NULL, NULL, '6271041466', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(458, 'akaunting', 464, 'Jassel Nuñez', NULL, NULL, '6271331507', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(459, 'akaunting', 465, 'Marisol', NULL, NULL, '+52 649 110 7188', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(460, 'akaunting', 466, 'Ivan Fabela', NULL, NULL, '+52 627 143 3164', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(461, 'akaunting', 467, 'Isamar Juárez Atonal', 'especialista.compras8@ciudadmaderas.com', NULL, '+52 442 320 5528', 'Desarrollo CMQRO:\r\nANILLO VIAL III OTE,  EL MARQUES, QUERÉTARO, C.P. 76246\r\n\r\nDesarrollo CDMSLP:\r\nW383+W9 Jesús María, 79530 S.L.P.', NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(462, 'akaunting', 468, 'Alejandra', NULL, NULL, '+52 649 104 9222', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(463, 'akaunting', 469, 'Abraham HOLGUIN', NULL, NULL, '614 313 0597', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(464, 'akaunting', 470, 'Alinka Zaragoza', NULL, NULL, '+52 627 133 1873', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(465, 'akaunting', 471, 'Arely', NULL, NULL, '+52 627 521 3324', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(466, 'akaunting', 472, 'Farmacias Similares', NULL, NULL, '+52 627 279 5070', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(467, 'akaunting', 473, 'Berenice Aguirre', NULL, NULL, '6271087040', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(468, 'akaunting', 474, 'Laura Fraire', NULL, NULL, '+52 627 112 9658', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(469, 'akaunting', 475, 'Escuela Josefa Solís de Lozoya', NULL, NULL, '627 112 6760', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(470, 'akaunting', 476, 'ADRIANA', 'auxventas1@mlmproductos.com', NULL, '6565795622', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(471, 'akaunting', 477, 'Georgina Unda', NULL, NULL, '6271488352', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(472, 'akaunting', 478, 'Ivanna Meza', NULL, NULL, '6271170295', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(473, 'akaunting', 479, 'Ángel Gutierrez Burciaga', NULL, NULL, '6271212420', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(474, 'akaunting', 480, 'Lizbeth Chaparro', NULL, NULL, '6272795942', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(475, 'akaunting', 481, 'Uriel Sánchez', NULL, NULL, '6181136054', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(476, 'akaunting', 482, 'Lizeth Monarrez', NULL, NULL, '6271335921', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(477, 'akaunting', 483, 'Laura Aguilera', NULL, NULL, '6271778352', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(478, 'akaunting', 484, 'Angela Gamez Aguirre', NULL, NULL, '5271236825', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(479, 'akaunting', 485, 'Nicole Martinez', NULL, NULL, '6271492038', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(480, 'akaunting', 486, 'Araceli Arzola', NULL, NULL, '+52 627 112 2758', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(481, 'akaunting', 487, 'Francia Lomeli', NULL, NULL, '6271319833', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(482, 'akaunting', 488, 'Juan Carlos Lomeli', NULL, NULL, '3414196479', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(483, 'akaunting', 489, 'Angelly', NULL, NULL, '6271023674', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(484, 'akaunting', 490, 'Judith Medina', NULL, NULL, '627 117 7074', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(485, 'akaunting', 491, 'Estefania', NULL, NULL, '+52 627 110 3947', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(486, 'akaunting', 492, 'Alejandra Martinez', NULL, NULL, '6271068169', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(487, 'akaunting', 493, 'Jazmin Armendariz', NULL, NULL, '6271421545', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(488, 'akaunting', 494, 'Erik Olvera', NULL, NULL, '6271020586', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(489, 'akaunting', 495, 'Autocristales y Refacciones', NULL, NULL, '6271192685', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(490, 'akaunting', 496, 'Nancy Mendez', NULL, NULL, '+52 627 113 7667', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(491, 'akaunting', 497, 'Jonathan Rodriguez', NULL, NULL, '+52 1 686 161 1134', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(492, 'akaunting', 498, 'Regina', NULL, NULL, '+1 531 3339355', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(493, 'akaunting', 499, 'Nancy etchechury', NULL, NULL, '+52 627 131 9148', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(494, 'akaunting', 500, 'Martin Soto', NULL, NULL, '+52 627 110 0918', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(495, 'akaunting', 501, 'Carmen Morales', NULL, NULL, '6275211926', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(496, 'akaunting', 502, 'Cristina MARTINEZ', NULL, NULL, '+52 649 105 2360', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(497, 'akaunting', 503, 'Rocío Nava', NULL, NULL, '+52 627 106 6922', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(498, 'akaunting', 504, 'Izamar Nuñez', NULL, NULL, '+52 627 148 6193', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(499, 'akaunting', 505, 'Soledad Aguirre', NULL, NULL, '+52 627 139 3171', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(500, 'akaunting', 506, 'Minpro ING. Vannesa Aleman', 'vannesa.aleman@minpro.com.mx', NULL, '+52 871 219 8091', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(501, 'akaunting', 507, 'Amanda Martínez TRENDSETERA', NULL, NULL, '+52 777 463 7283', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(502, 'akaunting', 508, 'Jonathan Ibarra', NULL, NULL, '+52 418 110 4109', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(503, 'akaunting', 509, 'Diana Rueda Jurado', NULL, NULL, '+52 627 131 6001', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(504, 'akaunting', 510, 'Abril', NULL, NULL, '+52 627 148 1305', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(505, 'akaunting', 511, 'Lupita Lozoya', NULL, NULL, '+52 627 121 0938', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(506, 'akaunting', 512, 'Cindy', NULL, NULL, '+52 627 104 5069', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(507, 'akaunting', 513, 'Sol Aguirre', 'wmaster1ro@gmail.com', NULL, '+52 627 139 3171', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(508, 'akaunting', 514, 'Asociación de padres de familia esc. prim. Jesús González O.', NULL, NULL, '627 117 0819', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(509, 'akaunting', 515, 'Carniceria Meza', NULL, NULL, '+52 627 174 8295', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(510, 'akaunting', 516, 'Esc. Prim Fed. Gustavo Diaz Ordaz', NULL, NULL, '+52 649 196 1075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(511, 'akaunting', 517, 'Carole Azaincot', NULL, NULL, '+52 55 5217 5493', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(512, 'akaunting', 518, 'Oscar Giovanni Rivera', NULL, NULL, '+52 229 250 0171', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(513, 'akaunting', 519, 'Esmeralda Herrera', NULL, NULL, '+52 627 148 4803', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(514, 'akaunting', 520, 'Escuela Carmen Tarín Ibarra', NULL, NULL, '+52 627 106 0840', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(515, 'akaunting', 521, 'AILYN LOPEZ', NULL, NULL, '6271212922', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(516, 'akaunting', 522, 'Flor García', NULL, NULL, '6275171435', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(517, 'akaunting', 523, 'ABTSA', NULL, NULL, '5516513909', 'Águilas int 1 ext 18A\r\nCol.Lago de Guadalupe', 'Cuautitlán Izcalli', '54760', 'México', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(518, 'akaunting', 524, 'Emy', NULL, NULL, '+52 649 196 1636', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(519, 'akaunting', 525, 'Jovana Rodríguez', NULL, NULL, '6271499611', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(520, 'akaunting', 526, 'Elizabeth Chaparro', NULL, NULL, '+52 627 151 4372', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(521, 'akaunting', 527, 'Rocío Rocha', NULL, NULL, '+52 614 253 2134', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(522, 'akaunting', 528, 'José Miranda', NULL, NULL, '+52 444 215 4167', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(523, 'akaunting', 529, 'LAURA ESTRADA', NULL, NULL, '6271432812', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(524, 'akaunting', 530, 'Patricio Rubio', NULL, NULL, '+52 656 167 3729', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(525, 'akaunting', 531, 'Laura Yesenia Salazar', NULL, NULL, '+52 627 520 4842', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(526, 'akaunting', 532, 'Alyson Pacheco', NULL, NULL, '+52 627 106 8726', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(527, 'akaunting', 533, 'Saúl Papás Leo', NULL, NULL, '+52 639 117 2204', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(528, 'akaunting', 534, 'Andrés', NULL, NULL, '+52 649 197 5603', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(529, 'akaunting', 535, 'Miguel', NULL, NULL, '+52 627 517 8466', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(530, 'akaunting', 536, 'Ferretería Regional', NULL, NULL, '6271585061', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(531, 'akaunting', 537, 'Gabriela Soto', NULL, NULL, '+52 627 116 4484', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(532, 'akaunting', 538, 'Yeimi ortega', NULL, NULL, '+52 627 111 1134', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(533, 'akaunting', 539, 'ITZEL ARCINIEGA', NULL, NULL, '+52 627 132 4235', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(534, 'akaunting', 540, 'Pedro Lerma', NULL, NULL, '6271424947', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(535, 'akaunting', 541, 'Villalobos Tile LLC', NULL, NULL, '6024734792', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(536, 'akaunting', 542, 'María Medrano', NULL, NULL, '+52 627 150 4059', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(537, 'akaunting', 543, 'Turismos Parral', NULL, NULL, '+52 627 117 6770', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(538, 'akaunting', 544, 'Fernanda Cazares', NULL, NULL, '6361239690', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(539, 'akaunting', 545, 'Yazmin Aguilar', NULL, NULL, '627 148 9782', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(540, 'akaunting', 546, 'Brenda Gonzales', NULL, NULL, '+52 627 117 0111', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(541, 'akaunting', 547, 'Esc. Primo. Lazara Quintana', NULL, NULL, '6271076981', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(542, 'akaunting', 548, 'Marisol Núñez', NULL, NULL, '+52 667 244 5784', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(543, 'akaunting', 549, 'Teresa Delgado', NULL, NULL, '+52 627 147 1074', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(544, 'akaunting', 550, 'Industrial Minera México', NULL, 'IMM8505281U0', '+52 656 311 6402', 'Campos Eliseos 400 ofic. 1102\r\nCol. Lomas de Chapultepec', 'CD. MÉXICO', '11000', 'Miguel Hidalgo', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(545, 'akaunting', 551, 'Félix Ruiz Gonzalez', NULL, NULL, '649 1010807. 6495326091', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(546, 'akaunting', 552, 'Araceli', NULL, NULL, '+52 627 133 0594', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(547, 'akaunting', 553, 'Cristian Sánchez  LA TREMENDA', NULL, NULL, '6271144189', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(548, 'akaunting', 554, 'Julia Gardea', NULL, NULL, '+52 627 104 7693', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(549, 'akaunting', 555, 'Rodolfo Guitierrez', NULL, NULL, '6681831600', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(550, 'akaunting', 556, 'Laura Prieto', NULL, NULL, '6271113706', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(551, 'akaunting', 557, 'Karen', NULL, NULL, '+52 627 114 8614', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(552, 'akaunting', 558, 'Esequiel Villalobos', NULL, NULL, '+52 614 154 3433', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(553, 'akaunting', 559, 'Villa Bonita', NULL, NULL, '+52 627 119 3915', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(554, 'akaunting', 560, 'Anabel Moreno', NULL, NULL, '+52 627 102 8194', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(555, 'akaunting', 561, 'Miriam Gallarzo', NULL, NULL, '+52 627 143 9199', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(556, 'akaunting', 562, 'Linda', NULL, NULL, '6271733449', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(557, 'akaunting', 563, 'Lucy Abril Meza Paniagua', NULL, NULL, '6271141522', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(558, 'akaunting', 564, 'Instituto Nacional Electoral', NULL, NULL, '+52 627 139 9643', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(559, 'akaunting', 565, 'Dania Luna', NULL, NULL, '+52 627 113 0652', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(560, 'akaunting', 566, 'Saúl Ochoa', NULL, NULL, '+52 639 117 2204', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(561, 'akaunting', 567, 'Luis Enrique Urbina', NULL, NULL, '6271315105', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(562, 'akaunting', 568, 'CREI año internacional del niño', NULL, NULL, '6271113706', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(563, 'akaunting', 569, 'Ingrid Chávez', NULL, NULL, '+52 56 1555 5291', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(564, 'akaunting', 570, 'Paty posada', NULL, NULL, '6271149619', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(565, 'akaunting', 571, 'Cindy Fernandez', NULL, NULL, '+52 627 111 0759', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(566, 'akaunting', 572, 'Jonathan Valdez', NULL, NULL, '6271234108', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(567, 'akaunting', 573, 'Yajaira Almazan', NULL, NULL, '+52 627 517 2761', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(568, 'akaunting', 574, 'Sandra Carbajal Álvarez', NULL, NULL, '+52 627 104 7056', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(569, 'akaunting', 575, 'Angélica Primero', NULL, 'Angélica Primero', '+52 627 140 0862', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(570, 'akaunting', 576, 'Esc Leona Vicario', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(571, 'akaunting', 577, 'Entidad de Limpieza y Mantenimiento', NULL, NULL, '+52 649 104 3888', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(572, 'akaunting', 578, 'Gisselle Rodriguez', NULL, NULL, '+52 627 112 6345', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(573, 'akaunting', 579, 'Karla', NULL, NULL, '+52 627 102 2258', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(574, 'akaunting', 580, 'Lina Macias', NULL, NULL, '+52 627 147 0892', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(575, 'akaunting', 581, 'Be Sweet Belem Bautista', NULL, NULL, '6275172040', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(576, 'akaunting', 582, 'Jorge', NULL, NULL, '6271519139', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(577, 'akaunting', 583, 'Alondra Rodriguez', NULL, NULL, '+52 627 103 3862', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(578, 'akaunting', 584, 'Lucybet', NULL, NULL, '+52 627 142 6620', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(579, 'akaunting', 585, 'Mtra Lorely Ávila', NULL, NULL, '+52 627 114 6670', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(580, 'akaunting', 586, 'Nancy Mendez', NULL, NULL, '+52 627 147 4075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(581, 'akaunting', 587, 'JN Lázaro Cárdenas del Río', NULL, NULL, '+52 627 142 1545', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(582, 'akaunting', 588, 'Jesús Manuel Carbajal Múñoz', NULL, NULL, '6271219050', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(583, 'akaunting', 589, 'Jesús Manuel Carbajal Múñoz', NULL, NULL, '6271219050', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(584, 'akaunting', 590, 'Rafael Ponce', NULL, NULL, '6276217403', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(585, 'akaunting', 591, 'Nallely', NULL, NULL, '6271216715', 'Agustín Melgar #3\r\ncol centro', 'Parral', '33800', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(586, 'akaunting', 592, 'Nancy Cano', NULL, NULL, '+52 627 112 8561', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(587, 'akaunting', 593, 'Esc prim 5 de Febrero 2127', NULL, NULL, '+52 627 279 3722', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(588, 'akaunting', 594, 'Perla Yaneth Jurado Luna', NULL, NULL, '+52 649 392 1875', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(589, 'akaunting', 595, 'Luci Chavira', NULL, NULL, '+1 (915) 272-8082', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(590, 'akaunting', 596, 'Rocío Holguín', NULL, NULL, '+52 627 110 1063', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(591, 'akaunting', 597, 'Denis', NULL, NULL, '+52 627 150 1009', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(592, 'akaunting', 598, 'Adriana Payan', NULL, NULL, '+52 627 117 4001', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(593, 'akaunting', 599, 'Ana Velia Flores', NULL, NULL, '+52 627 112 5178', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(594, 'akaunting', 600, 'Mary Soto', NULL, NULL, '6275216737', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(595, 'akaunting', 601, 'Esc. Prim. Club Rotario', NULL, NULL, '+52 627 279 8908', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(596, 'akaunting', 602, 'Jorge', NULL, NULL, '+52 627 151 9139', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(597, 'akaunting', 603, 'Brenda', NULL, NULL, '+52 627 131 0473', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(598, 'akaunting', 604, 'Verónica Estrada', NULL, NULL, '6275209283', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(599, 'akaunting', 605, 'Jorge Gutiérrrez', NULL, NULL, '6271113526', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(600, 'akaunting', 606, 'Adriana Montes', NULL, NULL, '6271041459', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(601, 'akaunting', 607, 'Jovany Alberto', NULL, NULL, '6491961075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(602, 'akaunting', 608, 'Lety', NULL, NULL, '+52 627 106 3458', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(603, 'akaunting', 609, 'Karla Chàvez', NULL, NULL, '6271088429', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(604, 'akaunting', 610, 'Esc. Prim. Centenario de Ejército Mexicano profr. Edgar', NULL, NULL, '6271104468', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(605, 'akaunting', 611, 'Ruth Gamboa', NULL, NULL, '6271236279', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(606, 'akaunting', 612, 'Esc. Prim. Leona Vicario', NULL, NULL, '6272798908', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(607, 'akaunting', 613, 'Rocio Holguin', NULL, NULL, '6271101063', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(608, 'akaunting', 614, 'Cinthia Teresa Lopez Galvan', NULL, NULL, '+52 627 142 9218', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(609, 'akaunting', 615, 'Mostrador', NULL, NULL, '+52 627 1034971', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(610, 'akaunting', 616, 'Blanca Prieto', NULL, NULL, '6271495993', 'Mártires 3 de mayo #68 Col. Emiliano Zapata', NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(611, 'akaunting', 617, 'Adriana Hernández', NULL, NULL, '6271420506', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(612, 'akaunting', 618, 'Jonathan Reyes', NULL, NULL, '6271780925', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(613, 'akaunting', 619, 'Gissel', NULL, NULL, '6271239902', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(614, 'akaunting', 620, 'Esc. Prim. Ma. Brisia Rodríguez/ Sociedad de padres', NULL, NULL, '6275213324', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(615, 'akaunting', 621, 'Laura Franco', NULL, NULL, '6271157673', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(616, 'akaunting', 622, 'Anaclaret Mata', NULL, NULL, '627 131 4757', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(617, 'akaunting', 623, 'Timoteo Montalvo', NULL, NULL, '6271050554', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(618, 'akaunting', 624, 'Raymundo Pineda', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(619, 'akaunting', 625, 'Anabel Vargas', NULL, NULL, '+52 627 117 1494', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13');
INSERT INTO `cp_customers` (`id`, `source_type`, `source_id`, `name`, `email`, `tax_number`, `phone`, `address`, `city`, `zip_code`, `state`, `country`, `notes`, `enabled`, `created_at`, `updated_at`) VALUES
(620, 'akaunting', 626, 'ISABEL LOYA', NULL, NULL, '+52 627 117 0207', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(621, 'akaunting', 627, 'Belém Holguín', NULL, NULL, '+52 627 148 1493', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(622, 'akaunting', 628, 'Dulce Mariana Castillo', NULL, NULL, '993 459 6475', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(623, 'akaunting', 629, 'Esc. Prim Ma Brisia Rodriguez', NULL, NULL, '6271730881', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(624, 'akaunting', 630, 'Don Ángel', NULL, NULL, '+52 627 150 0579', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(625, 'akaunting', 631, 'Guillermina Barraza', NULL, NULL, '+52 627 104 6589', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(626, 'akaunting', 632, 'Avril Ontiveros', NULL, NULL, '+52 614 368 1077', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(627, 'akaunting', 633, 'Sirelda Beltrán', NULL, NULL, '+52 627 517 0375', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(628, 'akaunting', 634, 'Karla', NULL, NULL, '6271126331', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(629, 'akaunting', 635, 'Hazel Pizarro', NULL, NULL, '+52 627 147 7106', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(630, 'akaunting', 636, 'Gamaliel García', NULL, NULL, '+52 55 7324 9207', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(631, 'akaunting', 637, 'Nallely', NULL, NULL, '+52 627 121 6715', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(632, 'akaunting', 638, 'Kevin Rodriguez', NULL, NULL, '6271733497', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(633, 'akaunting', 639, 'Janeth Villalobos', NULL, NULL, '+52 649 101 5465', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(634, 'akaunting', 640, 'Jannett', NULL, NULL, '+52 627 279 3509', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(635, 'akaunting', 641, 'Maria de Jesús Molina', NULL, NULL, '5551807927', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(636, 'akaunting', 642, 'Diana Torres', NULL, NULL, '8123514971', 'Mty NL', NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(637, 'akaunting', 643, 'Katia González', NULL, NULL, '627 517 2358', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(638, 'akaunting', 644, 'Secundaria Federal José Revueltas', NULL, NULL, '+52 627 106 6922', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(639, 'akaunting', 645, 'Mariana Meza Cano', NULL, NULL, '6271081182', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(640, 'akaunting', 646, 'Dra. Jaqueline Chávez León', NULL, NULL, '6271152554', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(641, 'akaunting', 647, 'Mariana', NULL, NULL, '6271081182', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(642, 'akaunting', 648, 'Lucy', NULL, NULL, '6271426620', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(643, 'akaunting', 649, 'Christian Cano', NULL, NULL, '+52 614 665 5523', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(644, 'akaunting', 650, 'Ricardo Nava Herrera', NULL, NULL, '+52 627 111 9362', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(645, 'akaunting', 651, 'Betty Vazquez', NULL, NULL, '+52 627 889 7313', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(646, 'akaunting', 652, 'Everardo', NULL, NULL, '6145041414', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(647, 'akaunting', 653, 'Edén Méndez', NULL, NULL, '8717862350', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(648, 'akaunting', 654, 'Yazmin García', NULL, NULL, '6271129013', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(649, 'akaunting', 655, 'Edith Holguín', NULL, NULL, '6271427679', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(650, 'akaunting', 656, 'Ricardo Chávez', NULL, NULL, '6271039257', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(651, 'akaunting', 657, 'Laura Franco', NULL, NULL, '+52 627 115 7673', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(652, 'akaunting', 658, 'Alicia', NULL, NULL, '627 150 7197', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(653, 'akaunting', 659, 'CLINICA HOSPITAL ISSSTE PARRAL Ing. Dulce  Ma. García Soto.', 'dulce.garcia@issste.gob.mx', NULL, '+52 627 889 7145', 'Francisco Miranda y, Rep. de Cuba NO. 8', 'Hidalgo del Parral', NULL, 'CHIHUAHUA', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(654, 'akaunting', 660, 'José Ceballos', NULL, NULL, '6271236513', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(655, 'akaunting', 661, 'Sol', NULL, NULL, '+52 667 244 5784', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(656, 'akaunting', 662, 'Fernanda Herrera', NULL, NULL, '+52 627 143 1641', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(657, 'akaunting', 663, 'Sandra Hernandez', NULL, NULL, '+52 627 133 7786', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(658, 'akaunting', 664, 'Mary Martínez', NULL, NULL, '+52 627 105 4853', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(659, 'akaunting', 665, 'Marlon Mendieta', NULL, NULL, '+52 951 548 3021', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(660, 'akaunting', 666, 'Luis Arzola', NULL, NULL, '+52 627 279 8068', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(661, 'akaunting', 667, 'Yaneth Calles', NULL, NULL, '627110947', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(662, 'akaunting', 668, 'Michelle García', NULL, NULL, '+52 627 142 2370', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(663, 'akaunting', 669, 'Yazmin Palacio', NULL, NULL, '+52 639 147 2778', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(664, 'akaunting', 670, 'Marlen Muñiz', NULL, NULL, '+52 627 132 4342', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(665, 'akaunting', 671, 'Mtra. Berenice García', NULL, NULL, '+52 627 102 7767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(666, 'akaunting', 672, 'Laura', NULL, NULL, '627 144 1521', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(667, 'akaunting', 673, 'Melida Margarita Chávez', NULL, NULL, '6271104468', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(668, 'akaunting', 674, 'Rocio', NULL, NULL, '6271032891', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(669, 'akaunting', 675, 'Brenda Martínez', NULL, NULL, '6271128936', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(670, 'akaunting', 676, 'Evelyn Rodríguez', NULL, NULL, '6271156464', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(671, 'akaunting', 677, 'Noemi Rodriguez', NULL, NULL, '+52 627 889 5844', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(672, 'akaunting', 678, 'Rocío', NULL, NULL, '+52 614 373 4701', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(673, 'akaunting', 679, 'Guadalupe Hernández', NULL, NULL, '+52 627 173 6258', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(674, 'akaunting', 680, 'Hotelera Queretana', NULL, NULL, '52 4428780208', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(675, 'akaunting', 681, 'Elizabeth Baca', NULL, NULL, '+52 627 121 3628', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(676, 'akaunting', 682, 'Angela', NULL, NULL, '+52 627 133 6714', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(677, 'akaunting', 683, 'Yara Sotelo', NULL, NULL, '+52 649 107 0392', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(678, 'akaunting', 684, 'Esc. Prim. Felipe Ángeles Álvarez #2426', NULL, NULL, '6271027767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(679, 'akaunting', 685, 'Firma Rosa Meza Guerrero', NULL, NULL, '6271039808', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(680, 'akaunting', 686, 'Ramona Terrazas Solis', NULL, NULL, '+52 667 326 9525', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(681, 'akaunting', 687, 'Esc. Melchor Gándara 2056', NULL, NULL, '627 117 1494', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(682, 'akaunting', 688, 'Esc. Telesecundaria Agua Amarilla', NULL, NULL, '6271121052', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(683, 'akaunting', 689, 'Lourdes Gardea', NULL, NULL, '+52 627 123 9569', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(684, 'akaunting', 690, 'Mary', NULL, NULL, '+52 627 105 4293', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(685, 'akaunting', 691, 'Edgar Martinez', NULL, NULL, '6261049059', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(686, 'akaunting', 692, 'Jonathan Villicaña Cobra Music', 'jonathan@cobramusicmanagement.com', NULL, '+52 55 3905 2954', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(687, 'akaunting', 693, 'Fernando Carbajal', NULL, NULL, '+52 669 101 3227', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(688, 'akaunting', 694, 'Martha Muro', NULL, NULL, '+52 627 123 3804', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(689, 'akaunting', 695, 'publico general', NULL, NULL, '6271501216', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(690, 'akaunting', 696, 'Blas Zapien Soto', NULL, NULL, '6491061824', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(691, 'akaunting', 697, 'Raúl Herrera', NULL, NULL, '6271195852', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(692, 'akaunting', 698, 'Janeth Luna. \"Nana Detalles hechos a mano\"', NULL, NULL, '6271436748', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(693, 'akaunting', 699, 'Keny Sandoval', NULL, NULL, '+52 627 112 7030', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(694, 'akaunting', 700, 'Yosi', NULL, NULL, '+52 686 353 2815', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(695, 'akaunting', 701, 'Mayra Galindo', NULL, NULL, '6271431064', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(696, 'akaunting', 702, 'Adriana Lozano', NULL, NULL, '6565511843', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(697, 'akaunting', 703, 'Profra Rocío', NULL, NULL, '+52 627 102 5075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(698, 'akaunting', 704, 'Manuel Carmona', NULL, NULL, '+52 627 517 2204', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(699, 'akaunting', 705, 'Esc. Prim. Melchor Gándara 2056', NULL, NULL, '+52 627 106 3237', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(700, 'akaunting', 706, 'Sujey Hinojos', NULL, NULL, '+52 1 627 174 4654', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(701, 'akaunting', 707, 'Martha Sandoval', NULL, NULL, '627 103 5717', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(702, 'akaunting', 708, 'Mercedes Moreno', NULL, NULL, '6491038565', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(703, 'akaunting', 709, 'Elizabeth', NULL, NULL, '+52 649 197 4152', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(704, 'akaunting', 710, 'Perla Yaritza', NULL, NULL, '+52 627 150 8576', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(705, 'akaunting', 711, 'Martín Villanueva', NULL, NULL, '6271236091', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(706, 'akaunting', 712, 'Gloria García', NULL, NULL, '+52 627 112 5928', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(707, 'akaunting', 713, 'Sarahi Torres', NULL, NULL, '+52 627 132 7910', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(708, 'akaunting', 714, 'Supervisión Escolar Zona 146', NULL, NULL, '6271119351', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(709, 'akaunting', 715, 'Nuvia García Holguín', NULL, NULL, '6295216667', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(710, 'akaunting', 716, 'Isabel Negrete', NULL, NULL, '+52 627 148 5678', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(711, 'akaunting', 717, 'Esc. Ángel Trias Álvarez', NULL, NULL, '6271231361', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(712, 'akaunting', 718, 'USAER 142', NULL, NULL, '+52 627 123 4990', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(713, 'akaunting', 719, 'Flor Salas', NULL, NULL, '+52 627 142 8638', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(714, 'akaunting', 720, 'Fredy', NULL, NULL, '+52 627 177 9377', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(715, 'akaunting', 721, 'Elizabeth Zamora', NULL, NULL, '6271238307', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(716, 'akaunting', 722, 'Flor', NULL, NULL, '+52 656 296 8357', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(717, 'akaunting', 723, 'Sergio Saenz', NULL, NULL, '+52 614 105 8212', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(718, 'akaunting', 724, 'Romina', NULL, NULL, '+52 627 142 0957', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(719, 'akaunting', 725, 'Oly', NULL, NULL, '+52 649 106 1524', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(720, 'akaunting', 726, 'Alexa', NULL, NULL, '+52 627 121 0906', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(721, 'akaunting', 727, 'Margarita chaparro', NULL, NULL, '6271070846', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(722, 'akaunting', 728, 'Aracely Gutierrez', NULL, NULL, '6271122192', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(723, 'akaunting', 729, 'Margarita Shaccid', NULL, NULL, '+52 627 121 0337', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(724, 'akaunting', 730, 'Vianey Gamez Rodriguez', NULL, NULL, '+52 449 151 4042', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(725, 'akaunting', 731, 'Yosamara Pantoja', NULL, NULL, '6863532815', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(726, 'akaunting', 732, 'Erika Delgado', NULL, NULL, '6271112755', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(727, 'akaunting', 733, 'Myriam Baca Rodríguez', NULL, NULL, '6271193707', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(728, 'akaunting', 734, 'Ferretería Yavireza S.A. de C,V,', NULL, NULL, '6491964868', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(729, 'akaunting', 735, 'María Guadalupe Zavala López', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(730, 'akaunting', 736, 'Lorena Martinez', NULL, '|', '6271033929', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(731, 'akaunting', 737, 'Reina Martínez', NULL, NULL, '6271434053', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(732, 'akaunting', 738, 'Yazmin Chávez', NULL, NULL, '6271773303', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(733, 'akaunting', 739, 'Paulina Navarro', NULL, NULL, '6271048292', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(734, 'akaunting', 740, 'María Elena Rodríguez', NULL, NULL, '6271352317', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(735, 'akaunting', 741, 'Raquel Carrera', NULL, NULL, '6271237205', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(736, 'akaunting', 742, 'Yanira Ramos', NULL, NULL, '6271130864', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(737, 'akaunting', 743, 'Mostrador', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(738, 'akaunting', 744, 'Diana', NULL, NULL, '+52 627 106 0146', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(739, 'akaunting', 745, 'Patricia Palacios', NULL, NULL, '+52 627 112 3200', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(740, 'akaunting', 746, 'Esmeralda Carrillo', NULL, NULL, '6271021110', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(741, 'akaunting', 747, 'Jennifer Paloma Lopez Galvan', NULL, NULL, '6271429218', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(742, 'akaunting', 748, 'SECRETARIA DE LA DEFENSA NACIONAL RFC SDN8501014D2', NULL, NULL, NULL, 'BLVD. MANUEL AVILA CAMACHO S/N LOMAS DE SOTELO', 'CD. DE MEXICO, MX', '33825', 'MX', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(743, 'akaunting', 749, 'Yolanda', NULL, NULL, '6275211901', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(744, 'akaunting', 750, 'Gabriela Cabrera', NULL, NULL, '6271131665', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(745, 'akaunting', 751, 'Ale', NULL, NULL, '6563601311', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(746, 'akaunting', 752, 'Jonathan', NULL, NULL, '6271158049', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(747, 'akaunting', 754, 'Alejandra Portilloi', NULL, NULL, '6563601311', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(748, 'akaunting', 755, 'Escuela Primaria Emiliano Zapata', 'erikabustillos@colibriprint.com.mx', 'XAXX010101000', '6141020760', 'Jimenez', 'Jiménez', NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(749, 'akaunting', 756, 'Luisa Caro', NULL, NULL, '6271199802', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(750, 'akaunting', 757, 'Adán Quezada', NULL, NULL, '6271060784', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(751, 'akaunting', 758, 'Uride Parral', NULL, NULL, '+52 669 101 3227', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(752, 'akaunting', 759, 'Naydelin Fragoso', NULL, NULL, '6271483596', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(753, 'akaunting', 760, 'Yazmin', NULL, NULL, '6271210428', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(754, 'akaunting', 761, 'Sara, Gonzalez', NULL, NULL, '+52 627 521 9388', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(755, 'akaunting', 762, 'Omar Valenzuela', NULL, NULL, '6143784370', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(756, 'akaunting', 763, 'JOSUE SANCHEZ', NULL, NULL, '6271121988', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(757, 'akaunting', 764, 'Elizabeth Armendariz', NULL, NULL, '+52 627 524 1886', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(758, 'akaunting', 765, 'Rosa Janeth Gutierrez', NULL, NULL, '+52 627 889 9594', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(759, 'akaunting', 766, 'Alejandra Ruiz', NULL, NULL, '+52 614 513 0673', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(760, 'akaunting', 767, 'Karla Dimas', NULL, NULL, '6271088471', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(761, 'akaunting', 768, 'Fumigaciones P&P', NULL, NULL, '+52 669 274 6143', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(762, 'akaunting', 769, 'Erika Cisneros', NULL, NULL, '6271037867', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(763, 'akaunting', 770, 'Karina salón de eventos Alexa', NULL, NULL, '+52 627 106 4807', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(764, 'akaunting', 771, 'Míriam Payan', NULL, NULL, '6251090665', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(765, 'akaunting', 772, 'Esc. Club Rotario', NULL, NULL, '6271177945', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(766, 'akaunting', 773, 'Esc. Prim. Niños Héroes', NULL, NULL, '6491061524', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(767, 'akaunting', 774, 'Josue Sanchez', NULL, NULL, '6271121988', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(768, 'akaunting', 775, 'Diana Rodriguez', NULL, NULL, '+52 627 517 2150', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(769, 'akaunting', 776, 'mostrador', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(770, 'akaunting', 777, 'TELESECUNDARIA 6100', NULL, NULL, '6271118788', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(771, 'akaunting', 778, 'Esc Josefa Solis y Esc Felipe Angeles', NULL, NULL, '+52 627 117 0535', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(772, 'akaunting', 779, 'Karla Reyes', NULL, NULL, '+52 627 111 3054', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(773, 'akaunting', 780, 'Escuela Lazara Quintana', NULL, NULL, '6271076981', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(774, 'akaunting', 781, 'Mtra Gris', NULL, NULL, '+52 627 147 8586', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(775, 'akaunting', 782, 'Brisa Gutierrez', NULL, NULL, '6271126593', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(776, 'akaunting', 783, 'Yolanda Estrada', NULL, NULL, '+52 627 149 5297', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(777, 'akaunting', 784, 'Profr. Carlos', NULL, NULL, '6271023701', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(778, 'akaunting', 785, 'Martin Pinedo', NULL, NULL, '6271173773', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(779, 'akaunting', 786, 'Sergio y Reina', NULL, NULL, '+52 627 111 9268', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(780, 'akaunting', 787, 'Prof. David Rubio', NULL, NULL, '6271086276', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(781, 'akaunting', 788, 'Quinta Zona Escolar', NULL, NULL, '6271045449', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(782, 'akaunting', 789, 'Belem Gutierrez', NULL, NULL, '6271233824', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(783, 'akaunting', 790, 'Yazmín Montes Contreras', NULL, NULL, '+52 649 114 4071', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(784, 'akaunting', 791, 'Irving Arrieta', NULL, NULL, '6271024288', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(785, 'akaunting', 792, 'Héctor Borjas', NULL, NULL, '6271771100', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(786, 'akaunting', 793, 'Zona 27', NULL, NULL, '6271045449', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(787, 'akaunting', 794, 'Lorena Zambrano', NULL, NULL, '6271144963', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(788, 'akaunting', 795, 'Blanca Alonso', NULL, NULL, '6275172602', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(789, 'akaunting', 796, 'Karla Rojas', NULL, '+52 627 521 8846', NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(790, 'akaunting', 797, 'Esc. 5 de Febrero 2127', NULL, NULL, NULL, 'Ejido San Rafael', 'Mpio. de Santa Bárbara', NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(791, 'akaunting', 798, 'Macky Jurado', NULL, NULL, '+52 614 198 6988', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(792, 'akaunting', 799, 'Karmina Bautista', NULL, '+52 627 173 7898', NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(793, 'akaunting', 800, 'Inspección Escolar Zona 67 Telesecundaria', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(794, 'akaunting', 801, 'July Gonzalez', NULL, NULL, '6272869282', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(795, 'akaunting', 802, 'Paola Jacobo', NULL, NULL, '6271234441', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(796, 'akaunting', 803, 'Yaneth Fernández', NULL, NULL, '+52 1 311 746 2653', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(797, 'akaunting', 804, 'esc. Nicolás Bravo', NULL, NULL, '6491100443', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(798, 'akaunting', 805, 'Judith', NULL, NULL, '627 117 7074', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(799, 'akaunting', 806, 'María de Jesús', NULL, NULL, '+52 627 123 4990', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(800, 'akaunting', 807, 'Enriqueta Villalobos', NULL, NULL, '6271327225', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(801, 'akaunting', 808, 'Yazmín Chavez', NULL, NULL, '+52 627 177 3303', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(802, 'akaunting', 809, 'Nayar Club Campestre', NULL, NULL, '3111070607', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(803, 'akaunting', 810, 'Maestra Eneida', NULL, NULL, '6271476374', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(804, 'akaunting', 811, 'Ultra Protección', NULL, NULL, '6271111297', 'Camino Viejo a San José', 'Chihuahua', '32459', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(805, 'akaunting', 812, 'Miguel A. Soto', NULL, NULL, '6491960398', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(806, 'akaunting', 813, 'MOSTRADOR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(807, 'akaunting', 814, 'Martha Sandoval', NULL, NULL, '6271035717', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(808, 'akaunting', 815, 'Cinthia Torres', NULL, NULL, '6141734112', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(809, 'akaunting', 816, 'Armando Pro', NULL, NULL, '6291525491', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(810, 'akaunting', 817, 'Prof. Julio Espinoza', NULL, NULL, '+52 627 150 0079', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(811, 'akaunting', 818, 'YADIRA CARRILLO', NULL, NULL, '6271234906', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(812, 'akaunting', 819, 'Maestra Maribel Guerra', NULL, NULL, '6493924391', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(813, 'akaunting', 820, 'Yaretzy Berenice', NULL, NULL, '+52 649 111 7637', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(814, 'akaunting', 821, 'Elizabeth', NULL, NULL, '+52 649 197 4152', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(815, 'akaunting', 822, 'Esc prim Miguel Alemán N° 2412', NULL, NULL, '+52 627 102 5075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(816, 'akaunting', 823, 'Miranda', NULL, NULL, '+52 627 106 5339', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(817, 'akaunting', 824, 'Preescolar Lázaro Cárdenas del Río 1267', NULL, NULL, '6391022834', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(818, 'akaunting', 825, 'Saboria', NULL, NULL, '6271437151', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(819, 'akaunting', 826, 'Alonso', NULL, NULL, '+525610759779', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(820, 'akaunting', 827, 'Bianey Vargas', NULL, NULL, '6491042467', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(821, 'akaunting', 828, 'Esc. Ángel Trías', NULL, NULL, '6271231361', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(822, 'akaunting', 829, 'Liliana Muñoz', NULL, NULL, '6271239551', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(823, 'akaunting', 830, 'Mtra Itzel', NULL, NULL, '6271733506', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(824, 'akaunting', 831, 'Esc Ma Brisia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(825, 'akaunting', 832, 'Damaris Chaparro', NULL, NULL, '214 477 4425', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(826, 'akaunting', 833, 'Dulce Mtz.', NULL, NULL, '6271122176', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(827, 'akaunting', 834, 'Omar Gómez', NULL, NULL, '6275245961', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(828, 'akaunting', 835, 'Jazmín Pedroza', NULL, NULL, '5959518357', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(829, 'akaunting', 836, 'Esc, Carmen Tarin Ibarra', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(830, 'akaunting', 837, 'Karla Torres', NULL, NULL, '6275213399', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(831, 'akaunting', 838, 'Ángel Gutiérrez', NULL, NULL, '6271212420', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(832, 'akaunting', 839, 'María del Carmen Payan', NULL, NULL, '6491964556', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(833, 'akaunting', 840, 'Esc. Prim. Lázaro Cárdenas', NULL, NULL, '+52 627 132 1361', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(834, 'akaunting', 841, 'Ángel Loya', NULL, NULL, '+52 627 524 6976', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(835, 'akaunting', 842, 'Maquinaria y equipo de Parral', NULL, NULL, '+52 614 138 2306', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(836, 'akaunting', 843, 'YAZMIN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(837, 'akaunting', 844, 'Brenda', NULL, NULL, '+52 627 112 8936', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(838, 'akaunting', 845, 'Andres', NULL, NULL, '+52 627 149 1080', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(839, 'akaunting', 846, 'Mariela Mariscal', NULL, NULL, '6674187117', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(840, 'akaunting', 847, 'Cuartel militar', NULL, NULL, '+52 342 101 4689', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(841, 'akaunting', 848, 'Edelmira Flores', NULL, NULL, '6271493751', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(842, 'akaunting', 849, 'Victor', NULL, NULL, '+52 627 117 3889', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(843, 'akaunting', 850, 'Sonia', NULL, NULL, '6272796473', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(844, 'akaunting', 851, 'Rocío Saldaña', NULL, NULL, '+52 627 111 8107', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(845, 'akaunting', 852, 'Erika Yudith Chávez', NULL, NULL, '+52 627 150 4484', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(846, 'akaunting', 853, 'Malú Sevares', NULL, NULL, '+52 55 5401 0805', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(847, 'akaunting', 854, 'Iván', NULL, NULL, '+52 614 209 8597', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(848, 'akaunting', 855, 'Dime empresa', 'servicio.mist@gmail.com', NULL, '+52 878 788 9550', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(849, 'akaunting', 856, 'Mtra Soco', NULL, NULL, '+52 627 106 8751', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(850, 'akaunting', 857, 'Ricardo Lerma', NULL, NULL, '+52 627 119 4167', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(851, 'akaunting', 858, 'Alejandra Horta', NULL, NULL, '+52 627 143 4776', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(852, 'akaunting', 859, 'Alberca Semiolìmpica INMUNODEPA', NULL, NULL, '6271230333', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(853, 'akaunting', 860, 'Miranda', NULL, NULL, '6491130587', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(854, 'akaunting', 861, 'Yoana Villar', NULL, NULL, '627 148 9435', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(855, 'akaunting', 862, 'Ximena', NULL, NULL, '6272875707', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(856, 'akaunting', 863, 'Ana Ríos', NULL, NULL, '+1 (575) 312-7619', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(857, 'akaunting', 864, 'Adriana', NULL, NULL, '+52 627 115 2175', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(858, 'akaunting', 865, 'Alejandra Soto', NULL, NULL, '627 131 3895', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(859, 'akaunting', 866, 'Departamento de bomberos', NULL, NULL, '6271162255', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(860, 'akaunting', 867, 'Mostrador', NULL, NULL, '+52 649 115 5302', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(861, 'akaunting', 868, 'Alberto Moreno', NULL, NULL, '6491155302', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(862, 'akaunting', 869, 'Jazmin Lugo', NULL, NULL, '6271067389', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(863, 'akaunting', 870, 'Rubí Campos Gallardo', NULL, NULL, '656 298 9351', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(864, 'akaunting', 871, 'Elizabeth Caldera', NULL, NULL, '+52 627 123 9176', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(865, 'akaunting', 872, 'Karely', NULL, NULL, '+52 627 113 2106', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(866, 'akaunting', 873, 'Anel', NULL, NULL, '+52 627 144 6222', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(867, 'akaunting', 874, 'Janeth', NULL, NULL, '+52 627 143 1168', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(868, 'akaunting', 875, 'Mtra Moni', NULL, NULL, '+52 627 147 4312', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(869, 'akaunting', 876, 'Karla', NULL, NULL, '6271126331', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(870, 'akaunting', 877, 'Dpto. Médico Cerca de Ti', NULL, NULL, '+52 627 889 6997', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(871, 'akaunting', 878, 'Selene Rocha', NULL, NULL, '+52 614 253 2134', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(872, 'akaunting', 879, 'Esc. Prim. Victor Hugo Rascón Banda', NULL, NULL, NULL, '08DPR2610D', NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(873, 'akaunting', 880, 'Karla Rico', NULL, NULL, '+52 649 103 1194', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(874, 'akaunting', 881, 'UACH', NULL, NULL, '6271052926', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(875, 'akaunting', 882, 'Sandra Holguín', NULL, NULL, '6271110978', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(876, 'akaunting', 883, 'Roberto Caballero', NULL, NULL, '627 123 8276', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(877, 'akaunting', 884, 'Nidia', NULL, NULL, '627113338464', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(878, 'akaunting', 885, 'Patricio Rubio Lopez', NULL, NULL, '+1 (983) 777-9011', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(879, 'akaunting', 886, 'Mostrador', NULL, NULL, '+52 1 649 104 2467', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(880, 'akaunting', 887, 'Socorrito', NULL, NULL, '627 106 8751', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(881, 'akaunting', 888, 'Paola Solís', NULL, NULL, '6271170591', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(882, 'akaunting', 889, 'Jonathan', NULL, NULL, '+52 627 123 4108', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(883, 'akaunting', 890, 'Energy Industrial & Mining', NULL, NULL, '+52 627 1137573', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(884, 'akaunting', 891, 'Exploraciones Mineras Rodríguez   Lizbeth Escobar', NULL, NULL, '6271022767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(885, 'akaunting', 892, 'Janeth', NULL, NULL, '6271211790', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(886, 'akaunting', 893, 'Adrian', NULL, NULL, '627 279 8083', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(887, 'akaunting', 894, 'Gabriela', NULL, NULL, '6271069167', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(888, 'akaunting', 895, 'Gabriela Gardea', NULL, NULL, '+52 627 106 9167', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(889, 'akaunting', 896, 'Alejandra Rodriguez', NULL, NULL, '+52 627 104 9835', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(890, 'akaunting', 897, 'Georgia Unda', NULL, NULL, '+52 627 148 8352', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(891, 'akaunting', 898, 'Leinad Cano', NULL, NULL, '+52 627 517 2607', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(892, 'akaunting', 899, 'Alejandra saldivar', NULL, NULL, '6271143867', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(893, 'akaunting', 900, 'VALE MAS Leticia Palomares', NULL, NULL, '+52 627 108 9648', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(894, 'akaunting', 901, 'VALE MAS Leticia Palomares', NULL, NULL, '6271089648', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(895, 'akaunting', 902, 'Lizeth Avilene Terrazas Chávez', NULL, NULL, '6271849321', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(896, 'akaunting', 903, 'Oscar Luis de León González', NULL, NULL, '6143553662', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(897, 'akaunting', 904, 'Escuela 2101', NULL, NULL, '+52 627 142 0506', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(898, 'akaunting', 905, 'Paola', NULL, NULL, '6141266165', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(899, 'akaunting', 906, 'Ana Almeida', NULL, NULL, '+52 627 132 7449', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(900, 'akaunting', 907, 'Departamento de Bomberos', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(901, 'akaunting', 908, 'Cristina', NULL, NULL, '+52 627 108 1222', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(902, 'akaunting', 909, 'Liza Herrera', NULL, NULL, '+52 627 149 7157', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(903, 'akaunting', 910, 'Arcadio Peregrinos de Fe', NULL, NULL, '+1 (708) 770-0607', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(904, 'akaunting', 911, 'Esc. Prim. Jesús González Ortega', NULL, NULL, '627 117 0819', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(905, 'akaunting', 912, 'Energy Industrial & Mining', 'nogalerosdejimenez01@outlook.com', NULL, '+52 627 173 5178', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(906, 'akaunting', 913, 'Wiwynn Auttecs /Margarita Shaccid', NULL, NULL, '+52 627 121 0337', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(907, 'akaunting', 914, 'Sugey Acosta', NULL, NULL, '+52 627 103 4883', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(908, 'akaunting', 915, 'Samuel', NULL, NULL, '+52 627 149 9450', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(909, 'akaunting', 916, 'Delma', NULL, NULL, '+52 627 135 7934', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(910, 'akaunting', 917, 'Hazael Javier Serrano Peinado', NULL, NULL, '6271143161', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(911, 'akaunting', 918, 'Leti', NULL, NULL, '6271171876', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(912, 'akaunting', 919, 'Raúl', NULL, NULL, '+52 627 119 5852', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(913, 'akaunting', 920, 'Jardín de Niños \"Miguel Hidalgo\" 1046', NULL, NULL, '6271067389', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(914, 'akaunting', 922, 'Crece con Vales', NULL, NULL, '+52 871 709 9256', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(915, 'akaunting', 923, 'Delma Duarte', NULL, NULL, '6271357934', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(916, 'akaunting', 924, 'TALLER MAYEPSA', NULL, NULL, '6141382306', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(917, 'akaunting', 925, 'Marcial, Escobedo', NULL, NULL, '+52 649 116 5267', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(918, 'akaunting', 926, 'Esc. Constituyentes', NULL, NULL, '6143945046', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(919, 'akaunting', 927, 'Carlos Iván Martínez Chávez', NULL, NULL, '+52 627 889 8687', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(920, 'akaunting', 928, 'Guadalupe Flores', NULL, NULL, '+52 627 106 4113', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(921, 'akaunting', 929, 'Adriana Hernández', NULL, NULL, '+52 627 139 2846', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(922, 'akaunting', 930, 'Sandra', NULL, NULL, '+52 649 103 1800', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(923, 'akaunting', 931, 'MARTIN VILLANUEVA', NULL, NULL, '6271236091', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(924, 'akaunting', 932, 'Marìa Eugenia Cervantes Flores', NULL, NULL, NULL, 'calle Playa Guayabitos 123\r\ncol Desarrollo San Pablo', 'Querétaro.', '76125', NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(925, 'akaunting', 933, 'Patricia Núñez', NULL, NULL, '+52 55 2112 0915', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(926, 'akaunting', 934, 'Eva Villalobos', NULL, NULL, '+52 627 111 9600', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(927, 'akaunting', 935, 'Diana Villanueva', NULL, NULL, '+52 627 112 3704', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(928, 'akaunting', 936, 'Jonathan Portillo', NULL, NULL, '+52 627 114 7105', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(929, 'akaunting', 937, 'Martha Elena Méndez', NULL, NULL, '+52 627 524 5620', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(930, 'akaunting', 938, 'Ariana Denisse Ramirez Sánchez', NULL, NULL, '+52 627 521 7596', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(931, 'akaunting', 939, 'Lázaro Cárdenas', NULL, NULL, '+52 656 551 1843', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(932, 'akaunting', 940, 'Griselda, Hinojos', NULL, NULL, '6271060311', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(933, 'akaunting', 941, 'Kenia Astorga', NULL, NULL, '+52 627 139 4938', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(934, 'akaunting', 942, 'Nancy Vazquez', NULL, NULL, '6271313345', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(935, 'akaunting', 943, 'Joaquin Olivas Ramírez', NULL, NULL, '6271310124', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13');
INSERT INTO `cp_customers` (`id`, `source_type`, `source_id`, `name`, `email`, `tax_number`, `phone`, `address`, `city`, `zip_code`, `state`, `country`, `notes`, `enabled`, `created_at`, `updated_at`) VALUES
(936, 'akaunting', 944, 'American  Style Boutique', NULL, NULL, '4491843569', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(937, 'akaunting', 945, 'Rosa Rodríguez', NULL, NULL, '6271553000', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(938, 'akaunting', 946, 'Paola Armendariz', NULL, NULL, '6278899257', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(939, 'akaunting', 947, 'Flor Lerma', NULL, NULL, '6271194167', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(940, 'akaunting', 948, 'Mtra Eneida', NULL, NULL, '+52 627 279 8449', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(941, 'akaunting', 949, 'Dianq', NULL, NULL, '6271515200', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(942, 'akaunting', 950, 'Yazmin Meza', NULL, NULL, '6271230249', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(943, 'akaunting', 951, 'Sociedad de Padres de familia Esc. Ma. Brisia Rodriguez', NULL, NULL, '+52 627 108 4473', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(944, 'akaunting', 952, 'Soledad Morales', NULL, NULL, '+52 627 103 9685', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(945, 'akaunting', 953, 'Rebeca Olivas', NULL, NULL, '6275173138', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(946, 'akaunting', 954, 'Etna Maciel', NULL, NULL, '5533437810', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(947, 'akaunting', 955, 'Jardín de niños Miguel Hidalgo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(948, 'akaunting', 956, 'Alexia Márquez', NULL, NULL, '6291111099', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(949, 'akaunting', 957, 'X-POOLS PISCINAS DE FIBRA DE VIDRIO', NULL, NULL, '6491964935', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(950, 'akaunting', 958, 'Diana', NULL, NULL, '+52 627 106 9781', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(951, 'akaunting', 959, 'Erika Aldana', NULL, NULL, '627528402', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(952, 'akaunting', 960, 'MACLEAN ENGINEERING MEXICANA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(953, 'akaunting', 961, 'HG Carpintería', NULL, NULL, '627 119 4344', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(954, 'akaunting', 962, 'Daniel Rivera', NULL, NULL, '+52 627 174 1088', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(955, 'akaunting', 963, 'Verónica de la O', NULL, NULL, '+52 627 114 6399', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(956, 'akaunting', 964, 'Daysi', NULL, NULL, '6271324953', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(957, 'akaunting', 965, 'DIF Municipal Parral', NULL, NULL, '+52 627 114 0510', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(958, 'akaunting', 966, 'Sonia Hernández,', NULL, NULL, '+52 627 108 9993', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(959, 'akaunting', 967, 'Ana', NULL, NULL, '+52 614 284 8733', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(960, 'akaunting', 968, 'Lizeth Betancourt', NULL, NULL, '6181686565', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(961, 'akaunting', 969, 'Jardín de niños Miguel Hidalgo', NULL, NULL, '+52 627 106 7389', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(962, 'akaunting', 970, 'Ana Ochoa / Lupita Rico', NULL, NULL, '+52 627 114 1023', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(963, 'akaunting', 971, 'Brenda Holguín', NULL, NULL, '+52 627 524 7539', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(964, 'akaunting', 972, 'Ricardo Jacobo', NULL, NULL, '+52 627 108 6296', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(965, 'akaunting', 973, 'Aracely Montes porfas', NULL, NULL, '+52 627 119 0312', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(966, 'akaunting', 974, 'Karla Sotelo', NULL, NULL, '6271022258', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(967, 'akaunting', 975, 'Karla Jurado', NULL, NULL, '+52 627 119 3658', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(968, 'akaunting', 976, 'Lucero Rodriguez', NULL, NULL, '+52 627 150 6708', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(969, 'akaunting', 977, 'Cristian Carbajal', NULL, NULL, '+52 627 131 7553', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(970, 'akaunting', 978, 'América Núñez', NULL, NULL, '+52 627 102 1095', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(971, 'akaunting', 979, 'Gustavo Zapien', NULL, NULL, '6272031650', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(972, 'akaunting', 980, 'Esc. Prim. Emiliano Zapata', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(973, 'akaunting', 981, 'Esc. Prim. Ford 80', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(974, 'akaunting', 982, 'Ing Marco DG PUBLICIDAD', NULL, NULL, '6271031075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(975, 'akaunting', 983, 'Tere Uribe', NULL, NULL, '+52 627 114 5212', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(976, 'akaunting', 984, 'Mayra', NULL, NULL, '6271746889', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(977, 'akaunting', 985, 'Adriana Piña', NULL, NULL, '6143541623', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(978, 'akaunting', 986, 'Elizabeth', NULL, NULL, '6271064484', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(979, 'akaunting', 987, 'Mtra Lore', NULL, NULL, '6272798826', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(980, 'akaunting', 988, 'Hg carpinteria', NULL, NULL, '6271194344', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(981, 'akaunting', 989, 'Rosy', NULL, NULL, '6271331129', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(982, 'akaunting', 990, 'Alejandra Pérez', NULL, NULL, '+52 625 589 8787', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(983, 'akaunting', 991, 'Jorge Bilbao', NULL, NULL, '6278895424', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(984, 'akaunting', 992, 'Carniceria Arredondo', NULL, NULL, '+52 649 101 4135', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(985, 'akaunting', 993, 'Marisol Armendariz', NULL, NULL, '+52 627 117 9955', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(986, 'akaunting', 994, 'Elena', NULL, NULL, '+52 627 133 0368', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(987, 'akaunting', 995, 'Samantha González', NULL, NULL, '+52 627 521 0215', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(988, 'akaunting', 996, 'Leticia García Imagen Arquitectónica Luferab', NULL, NULL, '+52 55 5453 6079', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(989, 'akaunting', 997, 'Fernando Chávez', NULL, NULL, '+52 627 139 6316', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(990, 'akaunting', 998, 'Agustina Chavez', NULL, NULL, '+52 627 103 8861', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(991, 'akaunting', 999, 'Norberto Hernández Alvarado', NULL, NULL, '+52 627 111 9414', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(992, 'akaunting', 1000, 'Omar Sáenz', NULL, NULL, '6271321705', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(993, 'akaunting', 1001, 'Carlos Villezcas', NULL, NULL, '+52 627 120 5139', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(994, 'akaunting', 1002, 'Yenni Escárcega', NULL, NULL, '6271132974', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(995, 'akaunting', 1003, 'Carolina Moreno', NULL, NULL, '+52 627 121 3207', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(996, 'akaunting', 1004, 'Naomi', NULL, NULL, '+52 627 178 2092', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(997, 'akaunting', 1005, 'Karla Lugo', NULL, NULL, '+52 627 173 9313', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(998, 'akaunting', 1006, 'Juana Maria Hernández Hernández', NULL, NULL, '+52 627 103 9587', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(999, 'akaunting', 1007, 'Perla', NULL, NULL, '+52 627 112 4562', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1000, 'akaunting', 1008, 'Antonio Rodriguez Rodriguez', NULL, NULL, '6271039530', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1001, 'akaunting', 1009, 'Escuela Telesecundaria Agua amarilla', NULL, NULL, '6271121052', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1002, 'akaunting', 1010, 'Mario', NULL, NULL, '+52 614 196 8919', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1003, 'akaunting', 1011, 'Mario Aguirre', NULL, NULL, '+52 614 196 8919', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1004, 'akaunting', 1012, 'MARIO AGUIRRE', NULL, NULL, '6141968919', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1005, 'akaunting', 1013, 'Marely Sotelo', NULL, NULL, '+52 627 150 7107', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1006, 'akaunting', 1014, 'Santiago Loya', NULL, NULL, '+52 614 124 9738', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1007, 'akaunting', 1015, 'Yajaira Bailon', NULL, NULL, '+52 627 521 6258', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1008, 'akaunting', 1016, 'Yazmin Jacobo', NULL, NULL, '6272797834', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1009, 'akaunting', 1017, 'Nayeli Galarza', NULL, NULL, '+52 871 572 7865', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1010, 'akaunting', 1018, 'Alberto Silva', NULL, NULL, '+52 627 112 0927', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1011, 'akaunting', 1019, 'Vianey', NULL, NULL, '+52 627 102 0301', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1012, 'akaunting', 1020, 'Martín Villanueva', NULL, NULL, '+52 627 103 6964', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1013, 'akaunting', 1021, 'Escuela: Carlos Pacheco  DPR: 08DPR00S5', NULL, NULL, '+52 614 604 1414', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1014, 'akaunting', 1022, 'Carniceria Baez', NULL, NULL, '+52 627 117 5152', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1015, 'akaunting', 1023, 'Bertha', NULL, NULL, '6271041649', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1016, 'akaunting', 1024, 'Tania Portillo Núñez', NULL, NULL, '+52 627 143 0545', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1017, 'akaunting', 1025, 'Lorena Gallardo', NULL, NULL, '6271500702', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1018, 'akaunting', 1026, 'José Ramírez', NULL, NULL, '+52 627 102 0530', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1019, 'akaunting', 1027, 'Marcel a Martínez OPTIMA IMPRESION', 'admin@optimaimpresion.net', NULL, '5555889562', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1020, 'akaunting', 1028, 'Adriana', NULL, NULL, '+52 627 115 2543', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1021, 'akaunting', 1029, 'Dra Maria Reyna Hernández', NULL, NULL, '+52 627 102 6829', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1022, 'akaunting', 1030, 'Nallely Escápita', NULL, NULL, '6141198804', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1023, 'akaunting', 1031, 'Cinthya Gonzalez', NULL, NULL, '6271475050', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1024, 'akaunting', 1032, 'Genesis', NULL, NULL, '+52 627 112 1418', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1025, 'akaunting', 1033, 'Taco Tacos', NULL, NULL, '+52 627 133 0955', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1026, 'akaunting', 1034, 'Colegio de Bachilleres del Estado de Chihuahua', NULL, NULL, '6271170535', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1027, 'akaunting', 1035, 'Marissa Torres', NULL, NULL, '6271114140', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1028, 'akaunting', 1036, 'Salma jamileth Hernández Banderas', NULL, NULL, '+52 627 173 5363', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1029, 'akaunting', 1037, 'Vitoria Molina', NULL, NULL, '+52 627 142 4690', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1030, 'akaunting', 1038, 'Esc Prim. Josefa Salís De Lozoya', NULL, NULL, '+52 627 889 7324', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1031, 'akaunting', 1039, 'Estrella Pérez', NULL, NULL, '+52 627 133 1315', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1032, 'akaunting', 1040, 'Edwin Sotelo', NULL, NULL, '+52 627 139 7424', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1033, 'akaunting', 1041, 'Adriana Troncoso', NULL, NULL, '+52 618 804 9903', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1034, 'akaunting', 1042, 'Melissa Cañas', NULL, NULL, '+52 627 120 8440', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1035, 'akaunting', 1043, 'Tele bachillerato 8650', NULL, NULL, '+52 627 111 7298', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1036, 'akaunting', 1044, 'Esc Prim Jesús González Ortega', NULL, NULL, '+52 627 117 0819', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1037, 'akaunting', 1045, 'Juan Hernández', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1038, 'akaunting', 1046, 'Ana', NULL, NULL, '+52 614 284 8733', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1039, 'akaunting', 1047, 'GRUPO COMERCIAL BUJAIDAR', NULL, NULL, '+52 614 173 4112', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1040, 'akaunting', 1048, 'Jardín de Niños Malintzin', NULL, NULL, '+52 627 113 6616', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1041, 'akaunting', 1049, 'Rita', NULL, NULL, '+52 627 113 2380', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1042, 'akaunting', 1050, 'Esc Prim Ford 190 TM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1043, 'akaunting', 1051, 'Karla Mireles', NULL, NULL, '6271231883', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1044, 'akaunting', 1052, 'Guadalupe Ramos', NULL, NULL, '6272795371', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1045, 'akaunting', 1053, 'Gerardo Nájera', NULL, NULL, '6271776570', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1046, 'akaunting', 1054, 'Norma Aracely', NULL, NULL, '6271337267', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1047, 'akaunting', 1055, 'Ivan Palacios', NULL, NULL, '+52 55 6476 6784', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1048, 'akaunting', 1056, 'Arlet', NULL, NULL, '6271501216', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1049, 'akaunting', 1057, 'Lina Vargas', NULL, NULL, '+52 627 133 0947', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1050, 'akaunting', 1058, 'Vivero El pequeño Paraíso', NULL, NULL, '+52 627 102 0659', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1051, 'akaunting', 1059, 'Daniel Sandoval', NULL, NULL, '+52 627 133 6340', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1052, 'akaunting', 1060, 'Cindy Roacho', NULL, NULL, '+52 627 133 4837', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1053, 'akaunting', 1061, 'Asael Chávez', NULL, NULL, '+52 627 113 4489', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1054, 'akaunting', 1062, 'Pastoral Penitenciaria Católica', NULL, NULL, '+52 627 112 8871', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1055, 'akaunting', 1063, 'Pauliana Lerma', NULL, NULL, '+52 627 117 7658', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1056, 'akaunting', 1064, 'Esc Prim 20 de Noviembre', NULL, NULL, '+52 649 196 1075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1057, 'akaunting', 1065, 'Damaris Baca', NULL, NULL, '+52 627 524 5708', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1058, 'akaunting', 1066, 'Verónica Arras', NULL, NULL, '+52 627 123 9341', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1059, 'akaunting', 1067, 'Esc. Prim. Álvaro Obregón', NULL, NULL, '6271499450', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1060, 'akaunting', 1068, 'Esc Prim Josefa Solis de Lozoya', NULL, NULL, '+52 627 889 7324', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1061, 'akaunting', 1069, 'Esc Prim Club Rotario', NULL, '+52 627 117 7945', NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1062, 'akaunting', 1070, 'Lizbeth Escobar', NULL, NULL, '+52 627 102 2767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1063, 'akaunting', 1071, 'Rolando Carrasco', NULL, NULL, '6271737348', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1064, 'akaunting', 1072, 'Dennysse Favela', NULL, NULL, '+52 627 106 9320', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1065, 'akaunting', 1073, 'Pollo Reinaga', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1066, 'akaunting', 1074, 'Idalia', NULL, NULL, '6141608826', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1067, 'akaunting', 1075, 'Juan Rocha', NULL, NULL, '+52 627 119 6525', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1068, 'akaunting', 1076, 'Fernanda Holguín', NULL, NULL, '+52 627 114 0825', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1069, 'akaunting', 1077, 'Supervisión Zona #67', NULL, NULL, '+52 627 106 6414', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1070, 'akaunting', 1078, 'Cynthia Barragán', NULL, NULL, '+52 656 360 7135', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1071, 'akaunting', 1079, 'Alejandra Hernández', NULL, NULL, '+52 627 150 6920', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1072, 'akaunting', 1080, 'Esc Prim Guillermo Baca', NULL, NULL, '+52 627 119 3778', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1073, 'akaunting', 1081, 'Mtra Rocio', NULL, NULL, '+52 627 102 5075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1074, 'akaunting', 1082, 'Sol Rivas', NULL, NULL, '+52 627 115 7453', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1075, 'akaunting', 1083, 'Erik Orpineda', NULL, NULL, '6271426574', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1076, 'akaunting', 1084, 'Kevin González', NULL, NULL, '+52 627 150 3372', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1077, 'akaunting', 1085, 'Jazmin Rodríguez', NULL, NULL, '+52 627 131 2966', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1078, 'akaunting', 1086, 'Jonathan Molina', NULL, NULL, '+52 649 196 5631', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1079, 'akaunting', 1087, 'SERVICIOS Y DESTILERIA SR', NULL, NULL, '+52 627 102 2767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1080, 'akaunting', 1088, 'Georgina Escapita', NULL, NULL, '+52 627 148 2590', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1081, 'akaunting', 1089, 'Colegio de Bachilleres del Estado de Chihuaha Plantel 12', NULL, NULL, '6271049290', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1082, 'akaunting', 1090, 'Riquelme Pizarro', NULL, NULL, '+52 649 110 4507', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1083, 'akaunting', 1091, 'Naomi Guevara', 'mktdpso@gmail.com', 'DPS190123PX6', '+524424744504', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1084, 'akaunting', 1092, 'Elder Esduardo Bojorquez Loya', NULL, NULL, '6491147133', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1085, 'akaunting', 1093, 'Sarahí Blanco', NULL, NULL, '+52 627 104 7289', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1086, 'akaunting', 1094, 'Silvia Nañez', NULL, NULL, '6271080335', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1087, 'akaunting', 1095, 'Yazmin', NULL, NULL, '+52 627 117 1876', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1088, 'akaunting', 1096, 'Brenda Rocio Ponce', NULL, NULL, '6271733497', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1089, 'akaunting', 1097, 'Mayra Villalobos', NULL, NULL, '+52 627 108 4627', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1090, 'akaunting', 1098, 'Bety', NULL, NULL, '6275241886', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1091, 'akaunting', 1099, 'María Campuzano', NULL, NULL, '627 110 5062', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1092, 'akaunting', 1100, 'Felix Pedroza', NULL, NULL, '+52 614 279 7909', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1093, 'akaunting', 1101, 'Blanca Soto', NULL, NULL, '6271063116', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1094, 'akaunting', 1102, 'Comedores Industriales de México', NULL, NULL, '+52 662 307 9112', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1095, 'akaunting', 1103, 'Uriel Pérez', NULL, NULL, '+52 627 279 8712', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1096, 'akaunting', 1104, 'Transportes El Oro Durango / Bere', NULL, NULL, '+52 627 521 3324', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1097, 'akaunting', 1105, 'Karina Bravo', NULL, NULL, '6275172866', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1098, 'akaunting', 1106, 'Perla Corral', NULL, NULL, '+52 627 103 6204', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1099, 'akaunting', 1107, 'Nallely Ontiveros', NULL, NULL, '+52 627 107 8719', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1100, 'akaunting', 1108, 'Comisariado Ejidal \"Ejido El Toro\"', NULL, NULL, '+52 627 113 9323', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1101, 'akaunting', 1109, 'Quinta Zona Escolar', NULL, NULL, '+52 627 119 3778', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1102, 'akaunting', 1110, 'Gamaliel Morúa Chávez', NULL, NULL, '+52 649 111 2139', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1103, 'akaunting', 1111, 'Itzel Rivas', NULL, NULL, '+52 627 139 1091', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1104, 'akaunting', 1112, 'Aron', NULL, NULL, '627 121 9783', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1105, 'akaunting', 1113, 'Celeste Villa', NULL, NULL, '6271741116', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1106, 'akaunting', 1114, 'Héctor Ivan Aguilera', NULL, NULL, '+52 627 117 2756', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1107, 'akaunting', 1115, 'Saira Ayala', NULL, NULL, '+52 627 112 6301', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1108, 'akaunting', 1116, 'Lucia Sandoval', NULL, NULL, '6271140441', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1109, 'akaunting', 1117, 'Josué Arellanes', NULL, NULL, '+52 614 684 3614', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1110, 'akaunting', 1118, 'Ruth Ramirez', NULL, NULL, '627 889 8316', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1111, 'akaunting', 1119, 'Kimberly Molina', NULL, NULL, '+52 627 111 3099', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1112, 'akaunting', 1120, 'María del Carmen Gamez Torres', NULL, NULL, '+52 614 184 4269', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1113, 'akaunting', 1121, 'Nallely  Sáenz', NULL, NULL, '6371039661', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1114, 'akaunting', 1122, 'Primaria Felipe Ángeles Álvarez #2426', NULL, NULL, '+52 627 102 7767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1115, 'akaunting', 1123, 'Jorge   Venegas', NULL, NULL, '6144632485', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1116, 'akaunting', 1124, 'Sarahy Castillo', NULL, NULL, '+52 627 149 7877', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1117, 'akaunting', 1125, 'Silvana', NULL, NULL, '+52 627 123 3454', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1118, 'akaunting', 1126, 'Silvana', NULL, NULL, '+52 627 123 3454', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1119, 'akaunting', 1127, 'URN PARRAL', NULL, NULL, '6271027893', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1120, 'akaunting', 1128, 'Yolanda Guadalupe', NULL, NULL, '+52 627 113 0465', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1121, 'akaunting', 1129, 'Esc prim Jesús Gonzalez Ortega', NULL, NULL, '+52 627 117 0819', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1122, 'akaunting', 1130, 'Supervisión Escolar Zona 146', NULL, NULL, '+52 627 111 9351', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1123, 'akaunting', 1131, 'Paty', NULL, NULL, '+52 627 524 5228', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1124, 'akaunting', 1132, 'Jesus Holguín Coordinador Diocesano PF', NULL, NULL, '+52 627 132 7232', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1125, 'akaunting', 1133, 'Susana Martinez', NULL, NULL, '+52 627 106 7142', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1126, 'akaunting', 1134, 'Idalia Olivas', NULL, NULL, '6271507476', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1127, 'akaunting', 1135, 'Eimee Padrón', NULL, NULL, '+52 627 123 3976', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1128, 'akaunting', 1136, 'Neyry Gutiérrez', NULL, NULL, '6271496448', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1129, 'akaunting', 1137, 'Profe Carlos', NULL, NULL, '6271023701', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1130, 'akaunting', 1138, 'Vianey Gamez Rodríguez', NULL, NULL, '+52 618 110 6540', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1131, 'akaunting', 1139, 'Dany Chávez', NULL, NULL, '627 148 2650', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1132, 'akaunting', 1140, 'Jazmin Bustillos', NULL, NULL, '627 173 8644', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1133, 'akaunting', 1141, 'Axel Gutièrrez', NULL, NULL, '6271515200', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1134, 'akaunting', 1142, 'Multiservicios el Granillo', NULL, NULL, '6272799567', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1135, 'akaunting', 1143, 'Alberto de la Garza', NULL, NULL, '+52 614 231 1298', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1136, 'akaunting', 1144, 'Esc Prim Ford 190', NULL, NULL, '+52 627 150 0140', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1137, 'akaunting', 1145, 'Esc Prim Ford 190 TV', NULL, NULL, '+52 656 148 9842', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1138, 'akaunting', 1146, 'Rocío Sáenz', NULL, NULL, '+52 627 119 3778', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1139, 'akaunting', 1147, 'Gloria Verónica Garcia Herrera', NULL, NULL, '614 151 1101', NULL, 'Hidalgo del Parral', '33800', 'Chihuahua', 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1140, 'akaunting', 1148, 'Esc. Prim. Vicente Guerrero', NULL, NULL, '+52 627 173 3506', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1141, 'akaunting', 1149, 'Escuela primaria Insurgentes', NULL, NULL, '+52 627 279 7834', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1142, 'akaunting', 1150, 'Supervisión General del Sector 29', NULL, NULL, '6275212311', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1143, 'akaunting', 1151, 'Esc Prim Carlos Pacheco', NULL, NULL, '6561138279', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1144, 'akaunting', 1152, 'Marisol Holguín', NULL, NULL, '+52 627 121 1632', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1145, 'akaunting', 1153, 'Karely Muñoz', NULL, NULL, '+52 627 143 1846', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1146, 'akaunting', 1154, 'Meny', NULL, NULL, '+52 627 521 5958', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1147, 'akaunting', 1155, 'Luis David Gardea', NULL, NULL, '+52 627 104 8788', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1148, 'akaunting', 1156, 'Silvia', NULL, NULL, '627 108 0335', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1149, 'akaunting', 1157, 'Sra Licha', NULL, NULL, '+52 627 177 9766', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1150, 'akaunting', 1158, 'Sociedad de padres de familia esc Ma Brisia', NULL, NULL, '6271112877', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1151, 'akaunting', 1159, 'Fernanda', NULL, NULL, '6271134989', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1152, 'akaunting', 1160, 'Arq. Vivian', NULL, NULL, '+52 627 123 6928', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1153, 'akaunting', 1161, 'Qualitas Compañía de Seguros', NULL, NULL, '+52 627 889 1998', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1154, 'akaunting', 1162, 'Comité de Graduación  XX', NULL, NULL, '6271052926', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1155, 'akaunting', 1163, 'Ana', NULL, NULL, '+52 614 284 8733', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1156, 'akaunting', 1164, 'Kevin Frausto', NULL, NULL, '+52 629 521 2000', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1157, 'akaunting', 1165, 'Verónica Acosta', NULL, NULL, '+52 629 101 0396', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1158, 'akaunting', 1166, 'Martha', NULL, NULL, '6563182829', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1159, 'akaunting', 1167, 'Alejandra Hernández', NULL, NULL, '627 150 6920', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1160, 'akaunting', 1168, 'Olga Aurora Rubio Rubio', NULL, NULL, '614 593 8517', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1161, 'akaunting', 1169, 'La villita', NULL, NULL, '627 123 6091', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1162, 'akaunting', 1170, 'Esc prim Lázaro cárdenas', NULL, NULL, '6271035080', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1163, 'akaunting', 1171, 'JN MIGUEL HIDALGO 1046', NULL, NULL, '+52 627 106 7389', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1164, 'akaunting', 1172, 'Juan Rodríguez', NULL, NULL, '+52 627 114 7398', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1165, 'akaunting', 1173, 'Lupita', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1166, 'akaunting', 1174, 'MITZY ANAHI', NULL, NULL, '627147085', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1167, 'akaunting', 1175, 'mitzy', NULL, NULL, '62774', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1168, 'akaunting', 1176, 'Autopartes San Vicente', NULL, NULL, '+52 627 119 5317', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1169, 'akaunting', 1177, 'Selina', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1170, 'akaunting', 1178, 'Shantal Dominguez', NULL, NULL, '+1 (970) 980-8355', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1171, 'akaunting', 1179, 'María Fernanda Holguín', NULL, NULL, '+52 627 114 0825', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1172, 'akaunting', 1180, 'ZONA ESCOLAR 142', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1173, 'akaunting', 1181, 'Luis Ituare', NULL, NULL, '+52 649 104 3735', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1174, 'akaunting', 1182, 'Esc 5 de febrero 2127', NULL, NULL, '+52 627 279 3722', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1175, 'akaunting', 1183, 'Lupita Loya', NULL, NULL, '+52 649 196 5488', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1176, 'akaunting', 1184, 'Myriam Fernández', NULL, NULL, '+52 627 150 0275', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1177, 'akaunting', 1185, 'Ana Cristina Martinez Arrieta', NULL, NULL, '+52 844 808 8223', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1178, 'akaunting', 1186, 'Giselle', NULL, NULL, '+52 627 158 4746', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1179, 'akaunting', 1187, 'Transformacion y Servicios Metalúrgicos', NULL, NULL, '+52 627 174 0590', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1180, 'akaunting', 1188, 'aneth nuñez', NULL, NULL, '627 177 5757', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1181, 'akaunting', 1189, 'Erazu Heredia', NULL, NULL, '6271049951', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1182, 'akaunting', 1190, 'Esc Prim 20 de Noviembre', NULL, NULL, '+52 649 196 1075', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1183, 'akaunting', 1191, 'Rosa María García', NULL, NULL, '6275203040', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1184, 'akaunting', 1192, 'Sec Tec No. 36', NULL, NULL, '+52 627 106 3595', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1185, 'akaunting', 1193, 'Fátima Reynaga', NULL, NULL, '+52 81 4583 5712', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1186, 'akaunting', 1194, 'Nancy Corral', NULL, NULL, '6271117779', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1187, 'akaunting', 1195, 'Jesus Grado', NULL, NULL, '+52 649 116 7684', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1188, 'akaunting', 1196, 'Colegio Vida con Futuro', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1189, 'akaunting', 1197, 'Michel', NULL, NULL, '+52 627 279 1508', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1190, 'akaunting', 1198, 'Esc Prim Álvaro Obregón', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1191, 'akaunting', 1199, 'Diana Cortez', NULL, NULL, '6271230324', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1192, 'akaunting', 1200, 'Ignacio Soto', NULL, NULL, '+52 55 3493 3988', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1193, 'akaunting', 1201, 'Profr. Isamar', NULL, NULL, '+52 649 113 7119', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1194, 'akaunting', 1202, 'Emili Gutiérrez', NULL, NULL, '6271443406', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1195, 'akaunting', 1203, 'Santiago', NULL, NULL, '6271328321', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1196, 'akaunting', 1204, 'Municipio Valle de Zaragoza /Nayeli', NULL, NULL, '+52 627 150 1804', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1197, 'akaunting', 1205, 'Jenifer Karina Arzola Corral', NULL, NULL, '+52 674 112 3901', 'Guanacevi Durango', NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1198, 'akaunting', 1206, 'Andrea Rodríguez', NULL, NULL, '+52 648 102 4662', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1199, 'akaunting', 1207, 'Jessica Rodríguez', NULL, NULL, '+52 627 123 4286', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1200, 'akaunting', 1208, 'Celia Corral', NULL, NULL, '+52 627 139 3388', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1201, 'akaunting', 1209, 'Raquel', NULL, NULL, '+52 627 147 8317', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1202, 'akaunting', 1210, 'UNIMEX', NULL, NULL, '+52 870 148 1685', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1203, 'akaunting', 1211, 'David Remedios Ramirez López', NULL, NULL, '+52 614 314 3809', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1204, 'akaunting', 1212, 'Mtra Alejandra', NULL, NULL, '+52 649 104 9222', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1205, 'akaunting', 1213, 'Danna Paola Ortega Hernández', 'dannapaola.oh@justbetter.mx', NULL, '81 4592 8410 / 222 818 58 99', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1206, 'akaunting', 1214, 'César García', NULL, NULL, '+52 627 119 1794', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1207, 'akaunting', 1215, 'Jazmin Ortega', NULL, NULL, '+52 627 112 0213', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1208, 'akaunting', 1216, 'Rmz Shop / Ramses Márquez', NULL, NULL, '+52 627 158 2828', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1209, 'akaunting', 1217, 'Instituto Municipal de la Juventud', NULL, NULL, '+52 627 139 7831', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1210, 'akaunting', 1218, 'Javier Huereque Parral', NULL, NULL, '6271153181', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1211, 'akaunting', 1219, 'Francisco Calleros', NULL, NULL, '6271120647', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1212, 'akaunting', 1220, 'Kiara Casteñeda', NULL, NULL, '+52 627 144 4315', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1213, 'akaunting', 1221, 'Mauro Vega', NULL, NULL, '+52 627 123 4976', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1214, 'akaunting', 1222, 'Karina García', NULL, NULL, '+52 627 112 9013', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1215, 'akaunting', 1223, 'Eva Villalobos', NULL, NULL, '+52 627 111 9600', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1216, 'akaunting', 1224, 'Gisselle Rodríguez', NULL, NULL, '+52 276 136 1625', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1217, 'akaunting', 1225, 'José Ángel Luna', NULL, NULL, '6271139323', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1218, 'akaunting', 1226, 'Teresa González', NULL, NULL, '627 132 1631', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1219, 'akaunting', 1227, 'Soledad Aguirre', NULL, NULL, '+52 627 139 3171', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1220, 'akaunting', 1228, 'Julio César Arroyo', NULL, NULL, '+52 627 123 5682', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1221, 'akaunting', 1229, 'Brenda Sáenz', NULL, NULL, '+52 627 131 0473', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1222, 'akaunting', 1230, 'Leonel Alvidrez', NULL, NULL, '+52 627 173 3702', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1223, 'akaunting', 1231, 'Elena Rodríguez', NULL, NULL, '+52 627 301 0550', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1224, 'akaunting', 1232, 'Constructora Coesmi', NULL, NULL, '+52 627 121 0832', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1225, 'akaunting', 1233, 'Edgar', NULL, NULL, '6601267809', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1226, 'akaunting', 1234, 'Esc Prim 5 de Febrero', NULL, NULL, '+52 627 103 4971', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1227, 'akaunting', 1235, 'Blanca Díaz', NULL, NULL, '+52 614 523 4371', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1228, 'akaunting', 1236, 'Juanito Cobos', NULL, NULL, '+52 627 147 5954', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1229, 'akaunting', 1237, 'Marianela Lopez', NULL, NULL, '+52 649 197 5105', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1230, 'akaunting', 1238, 'Emiliano', NULL, NULL, '+52 627 103 4971', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1231, 'akaunting', 1239, 'Cecilia Valverde', NULL, NULL, '+52 627 149 3838', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1232, 'akaunting', 1240, 'Jorge Silvas', NULL, NULL, '+52 627 103 1293', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1233, 'akaunting', 1241, 'Edith Holguin', NULL, NULL, '6291011058', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1234, 'akaunting', 1242, 'Elizabeth', NULL, NULL, '+52 649 197 4152', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1235, 'akaunting', 1243, 'Laura Núñez', NULL, NULL, '+52 627 115 8697', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1236, 'akaunting', 1244, 'Nancy Campuzano', NULL, NULL, '+52 656 113 8279', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1237, 'akaunting', 1245, 'Alondra Espinoza', NULL, NULL, '+52 627 119 4960', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1238, 'akaunting', 1246, 'Grupo Minero Lozoya', NULL, NULL, '+52 627 123 3864', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1239, 'akaunting', 1247, 'Aracely Olivas', NULL, NULL, '+52 627 112 4607', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1240, 'akaunting', 1248, 'Ivette Villanueva', NULL, NULL, '+52 627 114 8646', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1241, 'akaunting', 1249, 'Jardín de niños Rosaura Zapata 1006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1242, 'akaunting', 1250, 'Abril Alejandra Espinoza Ch.', NULL, NULL, '+52 614 495 7331', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1243, 'akaunting', 1251, 'Raúl', NULL, NULL, '+52 627 119 5852', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1244, 'akaunting', 1252, 'Dariel Alexa', NULL, NULL, '+52 627 144 9467', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1245, 'akaunting', 1253, 'Mtra Berenice', NULL, NULL, '+52 627 102 7767', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13');
INSERT INTO `cp_customers` (`id`, `source_type`, `source_id`, `name`, `email`, `tax_number`, `phone`, `address`, `city`, `zip_code`, `state`, `country`, `notes`, `enabled`, `created_at`, `updated_at`) VALUES
(1246, 'akaunting', 1254, 'Alan Loera', NULL, NULL, '+52 627 147 2390', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1247, 'akaunting', 1255, 'Marta Chávez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1248, 'akaunting', 1256, 'Janeth González', NULL, NULL, '+52 627 113 7458', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1249, 'akaunting', 1257, 'Laura', NULL, NULL, '+52 627 150 2142', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1250, 'akaunting', 1258, 'Edwin Huerta', NULL, NULL, '+52 639 154 9750', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1251, 'akaunting', 1259, 'Nubia Mendias', NULL, NULL, '+52 627 115 5810', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1252, 'akaunting', 1260, 'ILAP Ana Ruth', NULL, NULL, '+52 627 120 5614', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1253, 'akaunting', 1261, 'Nidia Chávez', NULL, NULL, '+52 627 123 5444', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1254, 'akaunting', 1262, 'Rafael', NULL, NULL, '+52 871 395 0211', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1255, 'akaunting', 1263, 'Elia Elizabeth Baca Corral', NULL, NULL, '+52 627 112 1482', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1256, 'akaunting', 1264, 'María José', NULL, NULL, '+52 613 111 9137', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1257, 'akaunting', 1265, 'Brenda', NULL, NULL, '+52 614 528 0365', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1258, 'akaunting', 1266, 'Nery Molina', NULL, NULL, '+52 627 150 6881', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1259, 'akaunting', 1267, 'Julieta Medrano', NULL, NULL, '+52 627 112 1482', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1260, 'akaunting', 1268, 'Karmina Bautista', NULL, NULL, '+52 627 173 7898', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1261, 'akaunting', 1269, 'Alejandro Salcido', NULL, NULL, '+52 656 358 3966', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1262, 'akaunting', 1270, 'HG CARPINTERIA', NULL, NULL, '+52 1 627 114 8973', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1263, 'akaunting', 1271, 'El Favorichis', NULL, NULL, '+52 627 173 4528', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1264, 'akaunting', 1272, 'Perla Herrera', NULL, NULL, '+52 627 143 5330', NULL, NULL, NULL, NULL, 'MX', NULL, 1, '2026-09-16 22:56:13', '2026-09-16 22:56:13'),
(1265, 'local', NULL, 'UACH', 'COMPRAS@UACH.COM', 'UACH8251452UD', '6271074512', 'C. ABELARDO RODRIGUEZ 22', 'PARRAL', '33815', 'CHIHUAHUA', 'MX', NULL, 1, '2026-09-17 11:42:10', '2026-09-17 11:42:10');

-- --------------------------------------------------------

--
-- Table structure for table `cp_invoices`
--

CREATE TABLE `cp_invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `invoice_number` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_date` date NOT NULL,
  `subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `cfdi_uuid` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_orders`
--

CREATE TABLE `cp_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_number` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quote_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `order_date` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `responsible_user_id` int(10) UNSIGNED DEFAULT NULL,
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `internal_notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_order_history`
--

CREATE TABLE `cp_order_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `old_status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `changed_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_order_items`
--

CREATE TABLE `cp_order_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `quote_item_id` int(10) UNSIGNED DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(12,3) NOT NULL DEFAULT '1.000',
  `unit_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_order_status`
--

CREATE TABLE `cp_order_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `stage` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `note` text COLLATE utf8mb4_unicode_ci,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_payments`
--

CREATE TABLE `cp_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `payment_date` date NOT NULL,
  `method` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `reference` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'confirmed',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_print_jobs`
--

CREATE TABLE `cp_print_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `quote_id` int(10) UNSIGNED DEFAULT NULL,
  `printer_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Lona',
  `printexp_job` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `printed_at` datetime NOT NULL,
  `dpi_x` smallint(5) UNSIGNED DEFAULT NULL,
  `dpi_y` smallint(5) UNSIGNED DEFAULT NULL,
  `print_program_pct` decimal(6,2) DEFAULT NULL,
  `print_speed_m2_h` decimal(10,3) DEFAULT NULL,
  `print_speed_m_h` decimal(10,3) DEFAULT NULL,
  `print_mode` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `print_time_seconds` int(10) UNSIGNED DEFAULT NULL,
  `copy_number` smallint(5) UNSIGNED DEFAULT NULL,
  `copy_total` smallint(5) UNSIGNED DEFAULT NULL,
  `job_width_mm` decimal(10,2) NOT NULL DEFAULT '0.00',
  `job_length_mm` decimal(10,2) NOT NULL DEFAULT '0.00',
  `print_length_m` decimal(12,3) NOT NULL DEFAULT '0.000',
  `gross_m2` decimal(12,3) NOT NULL DEFAULT '0.000',
  `result_status` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `waste_reason` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `waste_m2` decimal(12,3) NOT NULL DEFAULT '0.000',
  `good_m2` decimal(12,3) NOT NULL DEFAULT '0.000',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_print_meter_logs`
--

CREATE TABLE `cp_print_meter_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `roll_id` bigint(20) UNSIGNED NOT NULL,
  `printed_at` datetime NOT NULL,
  `job_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_length_mm` decimal(12,2) NOT NULL DEFAULT '0.00',
  `linear_m` decimal(12,3) NOT NULL DEFAULT '0.000',
  `result_status` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `waste_m` decimal(12,3) NOT NULL DEFAULT '0.000',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_print_meter_logs`
--

INSERT INTO `cp_print_meter_logs` (`id`, `roll_id`, `printed_at`, `job_name`, `job_length_mm`, `linear_m`, `result_status`, `waste_m`, `created_by`, `created_at`) VALUES
(1, 1, '2026-09-17 22:11:00', 'Dibujos fiesta y lona maestra cobach', 3810.00, 3.810, 'good', 0.000, 1, '2026-09-17 22:12:12'),
(2, 2, '2026-09-17 22:12:00', 'Figuras calavera', 794.17, 0.794, 'good', 0.000, 1, '2026-09-17 22:13:20'),
(3, 1, '2026-09-18 14:29:00', 'Impresion cuadros', 1542.03, 1.542, 'good', 0.000, 1, '2026-09-18 14:29:53');

-- --------------------------------------------------------

--
-- Table structure for table `cp_print_rolls`
--

CREATE TABLE `cp_print_rolls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `roll_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_m` decimal(12,3) NOT NULL DEFAULT '0.000',
  `remaining_m` decimal(12,3) NOT NULL DEFAULT '0.000',
  `opened_at` datetime NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_print_rolls`
--

INSERT INTO `cp_print_rolls` (`id`, `roll_name`, `initial_m`, `remaining_m`, `opened_at`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Rollo Lona promodigital pro max 50', 50.000, 44.648, '2026-09-17 22:11:35', 'active', 1, '2026-09-17 22:11:35', '2026-09-18 14:29:53'),
(2, 'Rollo de vinil ahdesivo', 50.000, 49.206, '2026-09-17 22:12:35', 'active', 1, '2026-09-17 22:12:35', '2026-09-17 22:13:20');

-- --------------------------------------------------------

--
-- Table structure for table `cp_products`
--

CREATE TABLE `cp_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
  `source_id` int(10) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `sale_price` decimal(15,2) DEFAULT NULL,
  `purchase_price` decimal(15,2) DEFAULT NULL,
  `pricing_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `visible_web` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_products`
--

INSERT INTO `cp_products` (`id`, `source_type`, `source_id`, `category_id`, `name`, `sku`, `description`, `sale_price`, `purchase_price`, `pricing_type`, `visible_web`, `enabled`, `created_at`, `updated_at`) VALUES
(1, 'local', NULL, 1, 'Playera tipo polo, negra', NULL, NULL, 290.00, NULL, 'variable', 1, 1, '2026-09-17 00:00:10', '2026-09-17 00:35:51'),
(2, 'local', NULL, 3, 'Taza 11oz personalizada', NULL, 'Taza blanca 11oz persoonalizable', 100.00, 20.00, 'variable', 1, 1, '2026-09-17 13:51:28', '2026-09-17 13:52:18');

-- --------------------------------------------------------

--
-- Table structure for table `cp_product_images`
--

CREATE TABLE `cp_product_images` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_product_images`
--

INSERT INTO `cp_product_images` (`id`, `product_id`, `path`, `alt_text`, `sort_order`, `enabled`, `created_at`) VALUES
(1, 1, '/uploads/products/8accefa041193dee33cbe8a0e20bef55.webp', 'Playera tipo polo, negra', 0, 1, '2026-09-17 00:00:10'),
(2, 2, '/uploads/products/14243a403a6c6046796330059f21a53e.jpg', 'Taza 11oz personalizada', 0, 1, '2026-09-17 13:51:28');

-- --------------------------------------------------------

--
-- Table structure for table `cp_promotions`
--

CREATE TABLE `cp_promotions` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OFERTA',
  `description` text COLLATE utf8mb4_unicode_ci,
  `promo_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `normal_price` decimal(15,2) DEFAULT NULL,
  `promo_price` decimal(15,2) DEFAULT NULL,
  `discount_percent` decimal(6,2) DEFAULT NULL,
  `quantity_available` int(10) UNSIGNED DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_text` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `show_web` tinyint(1) NOT NULL DEFAULT '1',
  `show_catalog` tinyint(1) NOT NULL DEFAULT '1',
  `show_whatsapp` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_promotions`
--

INSERT INTO `cp_promotions` (`id`, `title`, `slug`, `label`, `description`, `promo_type`, `normal_price`, `promo_price`, `discount_percent`, `quantity_available`, `start_date`, `end_date`, `image_path`, `whatsapp_text`, `status`, `show_web`, `show_catalog`, `show_whatsapp`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Playera tipo polo bordada | OFERTA DEL MES', 'playera-tipo-polo-bordada-oferta-del-mes', 'OFERTA', NULL, 'fixed', 290.00, 200.00, 31.03, 11, '2026-09-17', '2026-09-19', '/uploads/promotions/669089c7657ab6d0f9ec1193b5a64d2d.png', NULL, 'draft', 1, 1, 1, 1, 1, '2026-09-17 15:38:08', '2026-09-18 00:42:49');

-- --------------------------------------------------------

--
-- Table structure for table `cp_promotion_products`
--

CREATE TABLE `cp_promotion_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `promotion_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_promotion_products`
--

INSERT INTO `cp_promotion_products` (`id`, `promotion_id`, `product_id`, `sort_order`, `created_at`) VALUES
(3, 1, 1, 0, '2026-09-18 00:42:49');

-- --------------------------------------------------------

--
-- Table structure for table `cp_quotes`
--

CREATE TABLE `cp_quotes` (
  `id` int(10) UNSIGNED NOT NULL,
  `quote_number` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `issue_date` date NOT NULL,
  `valid_until` date DEFAULT NULL,
  `client_reference` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_terms` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_time` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_place` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `terms` text COLLATE utf8mb4_unicode_ci,
  `internal_notes` text COLLATE utf8mb4_unicode_ci,
  `source_calculator` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_data` longtext COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_quote_costs`
--

CREATE TABLE `cp_quote_costs` (
  `id` int(10) UNSIGNED NOT NULL,
  `quote_id` int(10) UNSIGNED NOT NULL,
  `concept` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_quote_items`
--

CREATE TABLE `cp_quote_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `quote_id` int(10) UNSIGNED NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(12,3) NOT NULL DEFAULT '1.000',
  `unit_price` decimal(15,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `calculator_source` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_quote_public_tokens`
--

CREATE TABLE `cp_quote_public_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `quote_id` int(10) UNSIGNED NOT NULL,
  `token` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `last_access_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_quote_totals`
--

CREATE TABLE `cp_quote_totals` (
  `id` int(10) UNSIGNED NOT NULL,
  `quote_id` int(10) UNSIGNED NOT NULL,
  `subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total` decimal(15,2) NOT NULL DEFAULT '0.00',
  `internal_cost` decimal(15,2) NOT NULL DEFAULT '0.00',
  `profit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `margin_pct` decimal(7,3) NOT NULL DEFAULT '0.000',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_roles`
--

CREATE TABLE `cp_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_roles`
--

INSERT INTO `cp_roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 'Acceso completo a la plataforma.', '2026-09-16 22:35:58', '2026-09-16 22:35:58');

-- --------------------------------------------------------

--
-- Table structure for table `cp_settings`
--

CREATE TABLE `cp_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_key` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_settings`
--

INSERT INTO `cp_settings` (`id`, `setting_key`, `setting_value`, `created_at`, `updated_at`) VALUES
(1, 'app.name', 'Colibrí Print México', '2026-09-16 22:35:58', '2026-09-16 22:35:58'),
(2, 'company.name', 'Colibrí Print México', '2026-09-16 22:35:58', '2026-09-16 22:35:58'),
(3, 'company.country', 'MX', '2026-09-16 22:35:58', '2026-09-17 11:40:28'),
(4, 'company.currency', 'MXN', '2026-09-16 22:35:58', '2026-09-16 22:35:58'),
(5, 'akaunting.database', 'colibrip_akau488', '2026-09-16 22:35:58', '2026-09-16 22:35:58'),
(6, 'setup.version', '1.0.0', '2026-09-16 22:35:58', '2026-09-16 22:35:58'),
(7, 'calculator.bastidor.ptr_m', '70.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(8, 'calculator.bastidor.canvas_m2', '50.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(9, 'calculator.bastidor.print_m2', '140.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(10, 'calculator.bastidor.labor_hour', '0.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(11, 'calculator.bastidor.waste_pct', '10.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(12, 'calculator.bastidor.margin_pct', '35.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(13, 'calculator.cnc.material_m2', '450.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(14, 'calculator.cnc.machine_hour', '250.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(15, 'calculator.cnc.labor_hour', '120.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(16, 'calculator.cnc.consumption_pct', '10.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(17, 'calculator.cnc.margin_pct', '35.0000', '2026-09-17 00:11:27', '2026-09-17 00:30:36'),
(40, 'company.legal_name', 'Colibrí Print México', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(41, 'company.trade_name', 'Colibrí Print', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(42, 'company.rfc', '', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(43, 'company.tax_regime', 'Régimen Simplificado de Confianza', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(44, 'company.address', 'Calle Alemania 87', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(45, 'company.neighborhood', 'LOMA LINDA', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(46, 'company.city', 'HIDALGO DEL PARRAL', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(47, 'company.state', 'CHIHUAHUA', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(48, 'company.postal_code', '33820', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(50, 'company.phone', '6271470053', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(51, 'company.email', 'ventas@colibriprint.com.mx', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(52, 'company.website', 'https://colibriprint.com.mx', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(53, 'company.logo_path', '/assets/img/company/logo-20260917114028-a6753015.png', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(54, 'company.quote_footer', 'Este documento es una cotización comercial y no sustituye un comprobante fiscal digital (CFDI).', '2026-09-17 11:40:28', '2026-09-17 11:40:28'),
(55, 'company.payment_info', '012162004867143744\r\n BANCOMER\r\n\r\nErika Elizabeth Bustillos Aguirre \r\nColibrí Print México \r\nC. Alemania #87\r\n Col. Loma Linda\r\n\r\nEn el concepto  poner su nombre', '2026-09-17 11:40:28', '2026-09-17 11:40:28');

-- --------------------------------------------------------

--
-- Table structure for table `cp_tracking_tokens`
--

CREATE TABLE `cp_tracking_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `token` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `last_access_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cp_users`
--

CREATE TABLE `cp_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_users`
--

INSERT INTO `cp_users` (`id`, `role_id`, `name`, `email`, `password_hash`, `enabled`, `last_login_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Administrador', 'ventas@colibriprint.com.mx', '$2y$10$exXwwyuOSJwdgJYWHR3tDO.C.BtOprMV5iLIhonCJsWI4AZGgLqk2', 1, '2026-09-18 20:03:03', '2026-09-16 22:35:58', '2026-09-16 22:35:58');

-- --------------------------------------------------------

--
-- Table structure for table `cp_whatsapp_log`
--

CREATE TABLE `cp_whatsapp_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `template_key` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `quote_id` int(10) UNSIGNED DEFAULT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `phone` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'prepared',
  `prepared_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_whatsapp_log`
--

INSERT INTO `cp_whatsapp_log` (`id`, `template_key`, `order_id`, `quote_id`, `customer_id`, `phone`, `message`, `status`, `prepared_by`, `created_at`) VALUES
(30, 'promotion_offer', NULL, NULL, NULL, '', '✨ OFERTA: Playera tipo polo bordada | OFERTA DEL MES\n\n💥 Precio promocional: $200.00\n🏷️ Precio normal: $290.00\n🎯 Descuento: 31.03 %\n📅 Vigencia: 17/09/2026 al 19/09/2026\n📦 Disponibilidad: 11\n\n🌐 https://colibriprint.com.mx\n\nColibrí Print', 'prepared', 1, '2026-09-18 20:20:06');

-- --------------------------------------------------------

--
-- Table structure for table `cp_whatsapp_templates`
--

CREATE TABLE `cp_whatsapp_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `template_key` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'service',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cp_whatsapp_templates`
--

INSERT INTO `cp_whatsapp_templates` (`id`, `template_key`, `name`, `category`, `body`, `active`, `created_at`, `updated_at`) VALUES
(1, 'quote_sent', 'Cotización enviada', 'service', 'Hola {cliente} 👋\n\nGracias por confiar en {empresa}. Te compartimos la cotización {folio}.\n\n💰 Total cotizado: {total}\n📅 Vigencia: {vigencia}\n\n📄 Ver y descargar tu cotización en PDF:\n{pdf_url}\n\nQuedamos atentos a cualquier duda o ajuste que necesites.\n\nSaludos,\n{empresa}', 1, '2026-09-17 15:11:10', '2026-09-17 21:16:52'),
(3, 'order_confirmed', 'Pedido confirmado', 'service', 'Hola {cliente} 👋\n\nTu pedido {orden} ya fue registrado y comenzamos a trabajar en él.\n\n💰 Total de la orden: {total}\n📅 Fecha compromiso: {fecha_entrega}\n\n🔎 Consulta el avance de tu pedido:\n{seguimiento}\n\nGracias por confiar en {empresa}.', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(4, 'design_ready', 'Diseño listo', 'service', 'Hola {cliente} 👋\n\n🎨 El diseño de tu pedido {orden} ya está listo para revisión.\n\nPuedes consultar el avance de tu pedido aquí:\n{seguimiento}\n\nSi necesitas algún ajuste, respóndenos por este mismo medio.\n\n{empresa}', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(5, 'design_approval', 'Aprobación de diseño', 'service', 'Hola {cliente} 👋\n\n🎨 El diseño de tu pedido {orden} está listo para aprobación.\n\nPara autorizar la producción, responde a este mensaje con *APROBADO*. Si necesitas cambios, indícanos cuáles para revisarlos contigo.\n\n🔎 Seguimiento del pedido:\n{seguimiento}\n\n{empresa}', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(6, 'printing', 'En impresión', 'service', 'Hola {cliente} 👋\n\n🖨️ Tu pedido {orden} ya se encuentra en impresión. Estamos avanzando con tu trabajo.\n\n🔎 Consulta el avance aquí:\n{seguimiento}\n\n{empresa}', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(7, 'in_production', 'En producción', 'service', 'Hola {cliente} 👋\n\n🔧 Tu pedido {orden} ya se encuentra en producción. Nuestro equipo está trabajando en los detalles de tu trabajo.\n\n🔎 Consulta el avance aquí:\n{seguimiento}\n\n{empresa}', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(8, 'quality_review', 'Control de calidad', 'service', 'Hola {cliente} 👋\n\n✅ Tu pedido {orden} está en revisión final de calidad antes de pasar a entrega.\n\n🔎 Consulta el avance aquí:\n{seguimiento}\n\nTe avisaremos en cuanto esté listo.\n\n{empresa}', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(9, 'finished', 'Trabajo terminado', 'service', 'Hola {cliente} 👋\n\n✅ Tu pedido {orden} terminó su proceso de producción.\n\nEstamos preparando la entrega y te avisaremos cuando esté listo para recoger o entregar.\n\n🔎 Seguimiento:\n{seguimiento}\n\n{empresa}', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(10, 'ready_delivery', 'Listo para entrega', 'service', 'Hola {cliente} 👋\n\n🚚 ¡Tu pedido {orden} ya está listo para entrega!\n\n📅 Fecha compromiso: {fecha_entrega}\n\n🔎 Consulta los detalles aquí:\n{seguimiento}\n\nGracias por confiar en {empresa}.', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(11, 'delivered', 'Entregado', 'service', 'Hola {cliente} 👋\n\n🎉 Tu pedido {orden} ha sido entregado correctamente.\n\nGracias por confiar en {empresa}. Esperamos seguir trabajando contigo.', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52'),
(12, 'promotion_offer', 'Promoción comercial', 'commercial', '✨ {label}: {promotion_title}\n\n{promotion_description}\n\n💥 Precio promocional: {promo_price}\n🏷️ Precio normal: {normal_price}\n🎯 Descuento: {discount}\n📅 Vigencia: {vigencia_promocion}\n📦 Disponibilidad: {availability}\n\n🌐 {website}\n\n{empresa}', 1, '2026-09-17 21:16:52', '2026-09-17 21:16:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cp_activity_log`
--
ALTER TABLE `cp_activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_activity_user` (`user_id`),
  ADD KEY `idx_cp_activity_created` (`created_at`);

--
-- Indexes for table `cp_categories`
--
ALTER TABLE `cp_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_categories_type` (`type`),
  ADD KEY `idx_cp_categories_enabled` (`enabled`);

--
-- Indexes for table `cp_customers`
--
ALTER TABLE `cp_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_customers_source` (`source_type`,`source_id`),
  ADD KEY `idx_cp_customers_name` (`name`),
  ADD KEY `idx_cp_customers_phone` (`phone`);

--
-- Indexes for table `cp_invoices`
--
ALTER TABLE `cp_invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_invoices_number` (`invoice_number`),
  ADD KEY `idx_cp_invoices_order` (`order_id`),
  ADD KEY `idx_cp_invoices_customer` (`customer_id`),
  ADD KEY `idx_cp_invoices_date` (`invoice_date`),
  ADD KEY `idx_cp_invoices_status` (`status`),
  ADD KEY `fk_cp_invoices_created_by` (`created_by`),
  ADD KEY `fk_cp_invoices_updated_by` (`updated_by`);

--
-- Indexes for table `cp_orders`
--
ALTER TABLE `cp_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_orders_number` (`order_number`),
  ADD UNIQUE KEY `uq_cp_orders_quote` (`quote_id`),
  ADD KEY `idx_cp_orders_customer` (`customer_id`),
  ADD KEY `idx_cp_orders_status` (`status`),
  ADD KEY `idx_cp_orders_due_date` (`due_date`),
  ADD KEY `fk_cp_orders_responsible` (`responsible_user_id`),
  ADD KEY `fk_cp_orders_created_by` (`created_by`),
  ADD KEY `fk_cp_orders_updated_by` (`updated_by`);

--
-- Indexes for table `cp_order_history`
--
ALTER TABLE `cp_order_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_order_history_order` (`order_id`),
  ADD KEY `fk_cp_order_history_user` (`changed_by`),
  ADD KEY `idx_cp_order_history_new_status` (`new_status`);

--
-- Indexes for table `cp_order_items`
--
ALTER TABLE `cp_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_order_items_order` (`order_id`),
  ADD KEY `fk_cp_order_items_quote_item` (`quote_item_id`);

--
-- Indexes for table `cp_order_status`
--
ALTER TABLE `cp_order_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_order_status_order` (`order_id`),
  ADD KEY `idx_cp_order_status_stage` (`stage`),
  ADD KEY `fk_cp_order_status_user` (`updated_by`),
  ADD KEY `idx_cp_order_status_updated_at` (`updated_at`);

--
-- Indexes for table `cp_payments`
--
ALTER TABLE `cp_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_payments_order` (`order_id`),
  ADD KEY `idx_cp_payments_customer` (`customer_id`),
  ADD KEY `idx_cp_payments_date` (`payment_date`),
  ADD KEY `idx_cp_payments_status` (`status`),
  ADD KEY `fk_cp_payments_created_by` (`created_by`),
  ADD KEY `fk_cp_payments_updated_by` (`updated_by`);

--
-- Indexes for table `cp_print_jobs`
--
ALTER TABLE `cp_print_jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_print_jobs_printed_at` (`printed_at`),
  ADD KEY `idx_cp_print_jobs_result_status` (`result_status`),
  ADD KEY `idx_cp_print_jobs_order_id` (`order_id`),
  ADD KEY `idx_cp_print_jobs_quote_id` (`quote_id`),
  ADD KEY `idx_cp_print_jobs_printer` (`printer_name`),
  ADD KEY `idx_cp_print_jobs_material` (`material_name`);

--
-- Indexes for table `cp_print_meter_logs`
--
ALTER TABLE `cp_print_meter_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_print_meter_roll` (`roll_id`),
  ADD KEY `idx_cp_print_meter_date` (`printed_at`),
  ADD KEY `idx_cp_print_meter_result` (`result_status`);

--
-- Indexes for table `cp_print_rolls`
--
ALTER TABLE `cp_print_rolls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_print_rolls_status` (`status`),
  ADD KEY `idx_cp_print_rolls_opened_at` (`opened_at`);

--
-- Indexes for table `cp_products`
--
ALTER TABLE `cp_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_products_source` (`source_type`,`source_id`),
  ADD KEY `idx_cp_products_category` (`category_id`),
  ADD KEY `idx_cp_products_name` (`name`),
  ADD KEY `idx_cp_products_web` (`visible_web`,`enabled`);

--
-- Indexes for table `cp_product_images`
--
ALTER TABLE `cp_product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_product_images_product` (`product_id`);

--
-- Indexes for table `cp_promotions`
--
ALTER TABLE `cp_promotions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_promotions_slug` (`slug`),
  ADD KEY `idx_cp_promotions_status_dates` (`status`,`start_date`,`end_date`),
  ADD KEY `idx_cp_promotions_web` (`show_web`,`status`),
  ADD KEY `idx_cp_promotions_catalog` (`show_catalog`,`status`),
  ADD KEY `idx_cp_promotions_whatsapp` (`show_whatsapp`,`status`),
  ADD KEY `fk_cp_promotions_created_by` (`created_by`),
  ADD KEY `fk_cp_promotions_updated_by` (`updated_by`);

--
-- Indexes for table `cp_promotion_products`
--
ALTER TABLE `cp_promotion_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_promotion_product` (`promotion_id`,`product_id`),
  ADD KEY `idx_cp_promotion_products_product` (`product_id`);

--
-- Indexes for table `cp_quotes`
--
ALTER TABLE `cp_quotes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_quotes_number` (`quote_number`),
  ADD KEY `idx_cp_quotes_customer` (`customer_id`),
  ADD KEY `idx_cp_quotes_status` (`status`),
  ADD KEY `idx_cp_quotes_issue_date` (`issue_date`),
  ADD KEY `fk_cp_quotes_created_by` (`created_by`),
  ADD KEY `fk_cp_quotes_updated_by` (`updated_by`);

--
-- Indexes for table `cp_quote_costs`
--
ALTER TABLE `cp_quote_costs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_quote_costs_quote` (`quote_id`);

--
-- Indexes for table `cp_quote_items`
--
ALTER TABLE `cp_quote_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_quote_items_quote` (`quote_id`);

--
-- Indexes for table `cp_quote_public_tokens`
--
ALTER TABLE `cp_quote_public_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_quote_public_quote` (`quote_id`),
  ADD UNIQUE KEY `uq_cp_quote_public_token` (`token`),
  ADD KEY `idx_cp_quote_public_active` (`active`);

--
-- Indexes for table `cp_quote_totals`
--
ALTER TABLE `cp_quote_totals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_quote_totals_quote` (`quote_id`);

--
-- Indexes for table `cp_roles`
--
ALTER TABLE `cp_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_roles_name` (`name`);

--
-- Indexes for table `cp_settings`
--
ALTER TABLE `cp_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_settings_key` (`setting_key`);

--
-- Indexes for table `cp_tracking_tokens`
--
ALTER TABLE `cp_tracking_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_tracking_order` (`order_id`),
  ADD UNIQUE KEY `uq_cp_tracking_token` (`token`),
  ADD KEY `idx_cp_tracking_active` (`active`);

--
-- Indexes for table `cp_users`
--
ALTER TABLE `cp_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_users_email` (`email`),
  ADD KEY `idx_cp_users_role_id` (`role_id`);

--
-- Indexes for table `cp_whatsapp_log`
--
ALTER TABLE `cp_whatsapp_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cp_whatsapp_log_order` (`order_id`),
  ADD KEY `idx_cp_whatsapp_log_quote` (`quote_id`),
  ADD KEY `idx_cp_whatsapp_log_customer` (`customer_id`),
  ADD KEY `idx_cp_whatsapp_log_created` (`created_at`),
  ADD KEY `fk_cp_whatsapp_log_user` (`prepared_by`);

--
-- Indexes for table `cp_whatsapp_templates`
--
ALTER TABLE `cp_whatsapp_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cp_whatsapp_template_key` (`template_key`),
  ADD KEY `idx_cp_whatsapp_template_category` (`category`),
  ADD KEY `idx_cp_whatsapp_template_active` (`active`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cp_activity_log`
--
ALTER TABLE `cp_activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=195;

--
-- AUTO_INCREMENT for table `cp_categories`
--
ALTER TABLE `cp_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cp_customers`
--
ALTER TABLE `cp_customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1266;

--
-- AUTO_INCREMENT for table `cp_invoices`
--
ALTER TABLE `cp_invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cp_orders`
--
ALTER TABLE `cp_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cp_order_history`
--
ALTER TABLE `cp_order_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `cp_order_items`
--
ALTER TABLE `cp_order_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cp_order_status`
--
ALTER TABLE `cp_order_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cp_payments`
--
ALTER TABLE `cp_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cp_print_jobs`
--
ALTER TABLE `cp_print_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cp_print_meter_logs`
--
ALTER TABLE `cp_print_meter_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cp_print_rolls`
--
ALTER TABLE `cp_print_rolls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cp_products`
--
ALTER TABLE `cp_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cp_product_images`
--
ALTER TABLE `cp_product_images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `cp_promotions`
--
ALTER TABLE `cp_promotions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cp_promotion_products`
--
ALTER TABLE `cp_promotion_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cp_quotes`
--
ALTER TABLE `cp_quotes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `cp_quote_costs`
--
ALTER TABLE `cp_quote_costs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cp_quote_items`
--
ALTER TABLE `cp_quote_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `cp_quote_public_tokens`
--
ALTER TABLE `cp_quote_public_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `cp_quote_totals`
--
ALTER TABLE `cp_quote_totals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `cp_roles`
--
ALTER TABLE `cp_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cp_settings`
--
ALTER TABLE `cp_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `cp_tracking_tokens`
--
ALTER TABLE `cp_tracking_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `cp_users`
--
ALTER TABLE `cp_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cp_whatsapp_log`
--
ALTER TABLE `cp_whatsapp_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `cp_whatsapp_templates`
--
ALTER TABLE `cp_whatsapp_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cp_invoices`
--
ALTER TABLE `cp_invoices`
  ADD CONSTRAINT `fk_cp_invoices_created_by` FOREIGN KEY (`created_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_invoices_customer` FOREIGN KEY (`customer_id`) REFERENCES `cp_customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_invoices_order` FOREIGN KEY (`order_id`) REFERENCES `cp_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_invoices_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_orders`
--
ALTER TABLE `cp_orders`
  ADD CONSTRAINT `fk_cp_orders_created_by` FOREIGN KEY (`created_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `cp_customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_orders_quote` FOREIGN KEY (`quote_id`) REFERENCES `cp_quotes` (`id`),
  ADD CONSTRAINT `fk_cp_orders_responsible` FOREIGN KEY (`responsible_user_id`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_orders_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_order_history`
--
ALTER TABLE `cp_order_history`
  ADD CONSTRAINT `fk_cp_order_history_order` FOREIGN KEY (`order_id`) REFERENCES `cp_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_order_history_user` FOREIGN KEY (`changed_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_order_items`
--
ALTER TABLE `cp_order_items`
  ADD CONSTRAINT `fk_cp_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `cp_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_order_items_quote_item` FOREIGN KEY (`quote_item_id`) REFERENCES `cp_quote_items` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_order_status`
--
ALTER TABLE `cp_order_status`
  ADD CONSTRAINT `fk_cp_order_status_order` FOREIGN KEY (`order_id`) REFERENCES `cp_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_order_status_user` FOREIGN KEY (`updated_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_payments`
--
ALTER TABLE `cp_payments`
  ADD CONSTRAINT `fk_cp_payments_created_by` FOREIGN KEY (`created_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_payments_customer` FOREIGN KEY (`customer_id`) REFERENCES `cp_customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_payments_order` FOREIGN KEY (`order_id`) REFERENCES `cp_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_payments_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_print_meter_logs`
--
ALTER TABLE `cp_print_meter_logs`
  ADD CONSTRAINT `fk_cp_print_meter_roll` FOREIGN KEY (`roll_id`) REFERENCES `cp_print_rolls` (`id`);

--
-- Constraints for table `cp_product_images`
--
ALTER TABLE `cp_product_images`
  ADD CONSTRAINT `fk_cp_product_images_product` FOREIGN KEY (`product_id`) REFERENCES `cp_products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cp_promotions`
--
ALTER TABLE `cp_promotions`
  ADD CONSTRAINT `fk_cp_promotions_created_by` FOREIGN KEY (`created_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_promotions_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_promotion_products`
--
ALTER TABLE `cp_promotion_products`
  ADD CONSTRAINT `fk_cp_promotion_products_product` FOREIGN KEY (`product_id`) REFERENCES `cp_products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cp_promotion_products_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `cp_promotions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cp_quotes`
--
ALTER TABLE `cp_quotes`
  ADD CONSTRAINT `fk_cp_quotes_created_by` FOREIGN KEY (`created_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_quotes_customer` FOREIGN KEY (`customer_id`) REFERENCES `cp_customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_quotes_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cp_quote_costs`
--
ALTER TABLE `cp_quote_costs`
  ADD CONSTRAINT `fk_cp_quote_costs_quote` FOREIGN KEY (`quote_id`) REFERENCES `cp_quotes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cp_quote_items`
--
ALTER TABLE `cp_quote_items`
  ADD CONSTRAINT `fk_cp_quote_items_quote` FOREIGN KEY (`quote_id`) REFERENCES `cp_quotes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cp_quote_public_tokens`
--
ALTER TABLE `cp_quote_public_tokens`
  ADD CONSTRAINT `fk_cp_quote_public_quote` FOREIGN KEY (`quote_id`) REFERENCES `cp_quotes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cp_quote_totals`
--
ALTER TABLE `cp_quote_totals`
  ADD CONSTRAINT `fk_cp_quote_totals_quote` FOREIGN KEY (`quote_id`) REFERENCES `cp_quotes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cp_tracking_tokens`
--
ALTER TABLE `cp_tracking_tokens`
  ADD CONSTRAINT `fk_cp_tracking_order` FOREIGN KEY (`order_id`) REFERENCES `cp_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cp_users`
--
ALTER TABLE `cp_users`
  ADD CONSTRAINT `fk_cp_users_role` FOREIGN KEY (`role_id`) REFERENCES `cp_roles` (`id`);

--
-- Constraints for table `cp_whatsapp_log`
--
ALTER TABLE `cp_whatsapp_log`
  ADD CONSTRAINT `fk_cp_whatsapp_log_customer` FOREIGN KEY (`customer_id`) REFERENCES `cp_customers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_whatsapp_log_order` FOREIGN KEY (`order_id`) REFERENCES `cp_orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_whatsapp_log_quote` FOREIGN KEY (`quote_id`) REFERENCES `cp_quotes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cp_whatsapp_log_user` FOREIGN KEY (`prepared_by`) REFERENCES `cp_users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
