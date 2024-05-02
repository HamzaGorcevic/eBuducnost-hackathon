-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2024 at 10:58 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school`
--

-- --------------------------------------------------------

--
-- Table structure for table `aktivnost`
--

CREATE TABLE `aktivnost` (
  `id` int(11) NOT NULL,
  `vrsta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth`
--

CREATE TABLE `auth` (
  `id` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth`
--

INSERT INTO `auth` (`id`, `email`, `password`) VALUES
(1, 'masovic.erhad@gmail.com', 'erhadeki123');

-- --------------------------------------------------------

--
-- Table structure for table `skola`
--

CREATE TABLE `skola` (
  `id` int(11) NOT NULL,
  `naziv` varchar(40) NOT NULL,
  `grad` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `skola`
--

INSERT INTO `skola` (`id`, `naziv`, `grad`) VALUES
(1, 'Tehnicka Skola \"Izudin Susevic\"', 'Novi Pazar');

-- --------------------------------------------------------

--
-- Table structure for table `ucenik`
--

CREATE TABLE `ucenik` (
  `id` int(11) NOT NULL,
  `ime` varchar(40) NOT NULL,
  `razred` int(11) NOT NULL,
  `skola_id` varchar(255) DEFAULT NULL,
  `poslovi` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`poslovi`)),
  `ocene` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{   "predmeti": [     {       "ime": "matematika",       "ocene": [0]     },     {       "ime": "likovno",       "ocene": [0]     },     {       "ime": "srpski",       "ocene": [0]     },     {       "ime": "engleski",       "ocene": [0]     },     {       "ime": "informatika",       "ocene": [0]     },     {       "ime": "fizičko",       "ocene": [0]     },     {       "ime": "racunarske mreze",       "ocene": [0]     },     {       "ime": "elektrotehnika",       "ocene": [0]     },     {       "ime": "elektrotehnicar",       "ocene": [0]     },     {       "ime": "racunarstvo u oblaku",       "ocene": [0]     },     {       "ime": "serveri",       "ocene": [0]     },     {       "ime": "programiranje",       "ocene": [0]     },     {       "ime": "preduzenistvo",       "ocene": [0]     },     {       "ime": "tehnicka dokumentacija",       "ocene": [0]     },     {       "ime": "ekologija",       "ocene": [0]     },     {       "ime": "muzicko",       "ocene": [0]     },     {       "ime": "sociologii",       "ocene": [0]     },     {       "ime": "pravo intelektuelne svojine",       "ocene": [0]     },     {       "ime": "fizicko",       "ocene": [0]     },     {       "ime": "pravi postupci",       "ocene": [0]     },     {       "ime": "korespodencija",       "ocene": [0]     },     {       "ime": "retorika i besednistvo",       "ocene": [0]     },     {       "ime": "poslovni engleski",       "ocene": [0]     },     {       "ime": "radno pravo",       "ocene": [0]     },     {       "ime": "poslovno pravni promet",       "ocene": [0]     }   ] }',
  `datum` varchar(30) DEFAULT NULL,
  `slika` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ucenik`
--

INSERT INTO `ucenik` (`id`, `ime`, `razred`, `skola_id`, `poslovi`, `ocene`, `datum`, `slika`) VALUES
(2, 'Haris Gorcevic', 3, 'Tehnicka Skola \"Izudin Susevic\"', '{}', '{   \"predmeti\": [     {       \"ime\": \"matematika\",       \"ocene\": [0]     },     {       \"ime\": \"likovno\",       \"ocene\": [0]     },     {       \"ime\": \"srpski\",       \"ocene\": [3, 4 , 2, 1]     },     {       \"ime\": \"engleski\",       \"ocene\": [3, 4 , 2, 1]     },     {       \"ime\": \"informatika\",       \"ocene\": [3, 4 , 2, 1]    },     {       \"ime\": \"fizičko\",       \"ocene\": [5, 4 , 4, 5]    }   ] }', '20/1/2005', 'https://t4.ftcdn.net/jpg/03/26/98/51/360_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg'),
(3, 'Hamza Gorcevic', 2, 'Tehnicka Skola \"Izudin Susevic\"', '{}', '{   \"predmeti\": [     {       \"ime\": \"matematika\",       \"ocene\": [0]     },     {       \"ime\": \"likovno\",       \"ocene\": [0]     },     {       \"ime\": \"srpski\",       \"ocene\": [0]     },     {       \"ime\": \"engleski\",       \"ocene\": [0]     },     {       \"ime\": \"informatika\",       \"ocene\": [0]     },     {       \"ime\": \"fizičko\",       \"ocene\": [0]     }   ] }', '20/1/2005', 'https://c1.klipartz.com/pngpicture/823/765/sticker-png-login-icon-system-administrator-user-user-profile-icon-design-avatar-face-head.png'),
(4, 'Dzenan Demirovic', 3, 'Tehnicka Skola \"Izudin Susevic\"', '{}', '{\r\n  \"predmeti\": [\r\n    {\r\n      \"ime\": \"matematika\",\r\n      \"ocene\": [3, 4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"likovno\",\r\n      \"ocene\": [4, 3]\r\n    },\r\n    {\r\n      \"ime\": \"srpski\",\r\n      \"ocene\": [5, 4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"engleski\",\r\n      \"ocene\": [4, 5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"informatika\",\r\n      \"ocene\": [5, 4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"fizičko\",\r\n      \"ocene\": [5, 5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"racunarske mreze\",\r\n      \"ocene\": [3, 4]\r\n    },\r\n    {\r\n      \"ime\": \"elektrotehnika\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"elektrotehnicar\",\r\n      \"ocene\": [5, 5]\r\n    },\r\n    {\r\n      \"ime\": \"racunarstvo u oblaku\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"serveri\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"programiranje\",\r\n      \"ocene\": [5, 5]\r\n    },\r\n    {\r\n      \"ime\": \"preduzenistvo\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"tehnicka dokumentacija\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"ekologija\",\r\n      \"ocene\": [3, 4]\r\n    },\r\n    {\r\n      \"ime\": \"muzicko\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"sociologii\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"pravo intelektuelne svojine\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"fizicko\",\r\n      \"ocene\": [5, 5]\r\n    },\r\n    {\r\n      \"ime\": \"pravi postupci\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"korespodencija\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"retorika i besednistvo\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"poslovni engleski\",\r\n      \"ocene\": [5, 5]\r\n    },\r\n    {\r\n      \"ime\": \"radno pravo\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"poslovno pravni promet\",\r\n      \"ocene\": [5, 4]\r\n    }\r\n  ]\r\n}', '20/1/2005', 'https://c1.klipartz.com/pngpicture/823/765/sticker-png-login-icon-system-administrator-user-user-profile-icon-design-avatar-face-head.png'),
(5, 'Umejr Zukorlic', 3, 'Tehnicka Skola \"Izudin Susevic\"', '{}', '{\r\n  \"predmeti\": [\r\n    {\r\n      \"ime\": \"matematika\",\r\n      \"ocene\": [4, 3, 5]\r\n    },\r\n    {\r\n      \"ime\": \"likovno\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"srpski\",\r\n      \"ocene\": [4, 5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"engleski\",\r\n      \"ocene\": [5, 4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"informatika\",\r\n      \"ocene\": [4, 5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"fizičko\",\r\n      \"ocene\": [5, 4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"racunarske mreze\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"elektrotehnika\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"elektrotehnicar\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"racunarstvo u oblaku\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"serveri\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"programiranje\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"preduzenistvo\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"tehnicka dokumentacija\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"ekologija\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"muzicko\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"sociologii\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"pravo intelektuelne svojine\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"fizicko\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"pravi postupci\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"korespodencija\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"retorika i besednistvo\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"poslovni engleski\",\r\n      \"ocene\": [4, 5]\r\n    },\r\n    {\r\n      \"ime\": \"radno pravo\",\r\n      \"ocene\": [5, 4]\r\n    },\r\n    {\r\n      \"ime\": \"poslovno pravni promet\",\r\n      \"ocene\": [4, 5]\r\n    }\r\n  ]\r\n}', '20/1/2005', 'https://media.licdn.com/dms/image/D4D03AQEPSWqTWm85dg/profile-displayphoto-shrink_200_200/0/1690725143222?e=2147483647&v=beta&t=IyFcuNPiCaItQi4FMsd1OgMOi0qzCq6RmxZCSZw2TIE'),
(69, 'Erhad Masovic', 3, 'Tehnicka Skola \"Izudin Susevic\"', '{}', '{\r\n  \"predmeti\": [\r\n    {\r\n      \"ime\": \"matematika\",\r\n      \"ocene\": [4]\r\n    },\r\n    {\r\n      \"ime\": \"likovno\",\r\n      \"ocene\": [2]\r\n    },\r\n    {\r\n      \"ime\": \"srpski\",\r\n      \"ocene\": [3]\r\n    },\r\n    {\r\n      \"ime\": \"engleski\",\r\n      \"ocene\": [5]\r\n    },\r\n    {\r\n      \"ime\": \"informatika\",\r\n      \"ocene\": [4]\r\n    },\r\n    {\r\n      \"ime\": \"fizičko\",\r\n      \"ocene\": [4]\r\n    },\r\n    {\r\n      \"ime\": \"racunarske mreze\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"elektrotehnika\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"elektrotehnicar\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"racunarstvo u oblaku\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"serveri\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"programiranje\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"preduzenistvo\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"tehnicka dokumentacija\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"ekologija\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"muzicko\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"sociologii\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"pravo intelektuelne svojine\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"fizicko\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"pravi postupci\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"korespodencija\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"retorika i besednistvo\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"poslovni engleski\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"radno pravo\",\r\n      \"ocene\": [0]\r\n    },\r\n    {\r\n      \"ime\": \"poslovno pravni promet\",\r\n      \"ocene\": [0]\r\n    }\r\n  ]\r\n}', '20/1/2005', 'https://scontent.fbeg4-1.fna.fbcdn.net/v/t39.30808-1/365962469_3586253938323887_4807022475963122990_n.jpg?stp=cp0_dst-jpg_p74x74&_nc_cat=102&ccb=1-7&_nc_sid=5f2048&_nc_ohc=kzhvgq2giuEAb7lKz3k&_nc_ht=scontent.fbeg4-1.fna&oh=00_AfDOBuJpXqsUI6GoXHaPd64SYt95J');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aktivnost`
--
ALTER TABLE `aktivnost`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skola`
--
ALTER TABLE `skola`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ucenik`
--
ALTER TABLE `ucenik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `skola_id` (`skola_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aktivnost`
--
ALTER TABLE `aktivnost`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth`
--
ALTER TABLE `auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `skola`
--
ALTER TABLE `skola`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ucenik`
--
ALTER TABLE `ucenik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
