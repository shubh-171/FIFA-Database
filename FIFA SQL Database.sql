-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 04, 2025 at 06:14 PM
-- Server version: 8.0.40
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `upad4283`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`upad4283`@`%` PROCEDURE `AddTeam` (`teamName` VARCHAR(50), `groupId` CHAR(1))   BEGIN
    INSERT INTO Teams (team_name, group_id) VALUES (teamName, groupId);
END$$

--
-- Functions
--
CREATE DEFINER=`upad4283`@`%` FUNCTION `TotalMatchesPlayed` (`teamId` INT) RETURNS INT  BEGIN
    RETURN (SELECT COUNT(*) FROM Matches WHERE home_team_id = teamId OR away_team_id = teamId);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Groups`
--

CREATE TABLE `Groups` (
  `group_id` char(1) NOT NULL,
  `group_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Groups`
--

INSERT INTO `Groups` (`group_id`, `group_name`) VALUES
('A', 'Group A'),
('B', 'Group B'),
('C', 'Group C'),
('D', 'Group D');

-- --------------------------------------------------------

--
-- Table structure for table `MatchDetails`
--

CREATE TABLE `MatchDetails` (
  `match_id` int NOT NULL,
  `player_id` varchar(10) NOT NULL,
  `team_id` int NOT NULL,
  `goals_scored` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `MatchDetails`
--

INSERT INTO `MatchDetails` (`match_id`, `player_id`, `team_id`, `goals_scored`) VALUES
(1, 'ARG10', 1, 2),
(1, 'BRA9', 2, 1),
(2, 'FRA7', 3, 1),
(2, 'GER9', 4, 1),
(3, 'ESP8', 5, 2),
(3, 'POR7', 6, 1),
(4, 'ENG10', 7, 1),
(5, 'ITA9', 9, 1);

--
-- Triggers `MatchDetails`
--
DELIMITER $$
CREATE TRIGGER `trg_check_goals` BEFORE INSERT ON `MatchDetails` FOR EACH ROW BEGIN
    IF NEW.goals_scored < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Goals scored cannot be negative';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Matches`
--

CREATE TABLE `Matches` (
  `match_id` int NOT NULL,
  `match_date` datetime NOT NULL,
  `home_team_id` int NOT NULL,
  `away_team_id` int NOT NULL,
  `stadium_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Matches`
--

INSERT INTO `Matches` (`match_id`, `match_date`, `home_team_id`, `away_team_id`, `stadium_id`) VALUES
(1, '2024-11-27 16:00:00', 1, 2, 1),
(2, '2024-11-28 18:00:00', 3, 4, 2),
(3, '2024-11-29 20:00:00', 5, 6, 3),
(4, '2024-11-30 22:00:00', 7, 8, 4),
(5, '2024-12-01 18:00:00', 9, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Players`
--

CREATE TABLE `Players` (
  `player_id` varchar(10) NOT NULL,
  `team_id` int NOT NULL,
  `player_name` varchar(100) NOT NULL,
  `position` char(2) DEFAULT NULL,
  `birth_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Players`
--

INSERT INTO `Players` (`player_id`, `team_id`, `player_name`, `position`, `birth_date`) VALUES
('ARG1', 1, 'Emiliano Martinez', 'GK', '1992-09-02'),
('ARG10', 1, 'Lionel Messi', 'FW', '1987-06-24'),
('BRA1', 2, 'Alisson Becker', 'GK', '1992-10-02'),
('BRA9', 2, 'Neymar Jr.', 'FW', '1992-02-05'),
('ENG10', 7, 'Harry Kane', 'FW', '1993-07-28'),
('ESP8', 5, 'Pedri Gonzalez', 'MF', '2002-11-25'),
('FRA1', 3, 'Hugo Lloris', 'GK', '1986-12-26'),
('FRA7', 3, 'Kylian Mbappe', 'FW', '1998-12-20'),
('GER9', 4, 'Thomas Muller', 'FW', '1989-09-13'),
('ITA9', 9, 'Ciro Immobile', 'FW', '1990-02-20'),
('NED10', 8, 'Memphis Depay', 'FW', '1994-02-13'),
('POR7', 6, 'Cristiano Ronaldo', 'FW', '1985-02-05');

-- --------------------------------------------------------

--
-- Table structure for table `Stadiums`
--

CREATE TABLE `Stadiums` (
  `stadium_id` int NOT NULL,
  `stadium_name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `capacity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Stadiums`
--

INSERT INTO `Stadiums` (`stadium_id`, `stadium_name`, `location`, `capacity`) VALUES
(1, 'Lusail Stadium', 'Lusail, Qatar', 80000),
(2, 'Al Bayt Stadium', 'Al Khor, Qatar', 60000),
(3, 'Education City Stadium', 'Al Rayyan, Qatar', 45000),
(4, 'Ahmad Bin Ali Stadium', 'Al Rayyan, Qatar', 40000);

-- --------------------------------------------------------

--
-- Table structure for table `Teams`
--

CREATE TABLE `Teams` (
  `team_id` int NOT NULL,
  `team_name` varchar(50) NOT NULL,
  `coach_name` varchar(50) DEFAULT NULL,
  `group_id` char(1) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Teams`
--

INSERT INTO `Teams` (`team_id`, `team_name`, `coach_name`, `group_id`, `created_at`) VALUES
(1, 'Argentina', 'Lionel Scaloni', 'A', '2024-11-28 23:46:36'),
(2, 'Brazil', 'Tite', 'B', '2024-11-28 23:46:36'),
(3, 'France', 'Didier Deschamps', 'C', '2024-11-28 23:46:36'),
(4, 'Germany', 'Hansi Flick', 'D', '2024-11-28 23:46:36'),
(5, 'Spain', 'Luis Enrique', 'C', '2024-11-28 23:51:28'),
(6, 'Portugal', 'Roberto Martinez', 'C', '2024-11-28 23:51:28'),
(7, 'England', 'Gareth Southgate', 'D', '2024-11-28 23:51:28'),
(8, 'Netherlands', 'Ronald Koeman', 'D', '2024-11-28 23:51:28'),
(9, 'Italy', 'Roberto Mancini', 'A', '2024-11-28 23:51:28'),
(10, 'Japan', 'Hajime Moriyasu', 'B', '2024-11-28 23:51:28');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vMatchDetails`
-- (See below for the actual view)
--
CREATE TABLE `vMatchDetails` (
`match_id` int
,`player_name` varchar(100)
,`team_name` varchar(50)
,`goals_scored` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vMatchesTeams`
-- (See below for the actual view)
--
CREATE TABLE `vMatchesTeams` (
`match_id` int
,`home_team` varchar(50)
,`away_team` varchar(50)
,`match_date` datetime
);

-- --------------------------------------------------------

--
-- Structure for view `vMatchDetails`
--
DROP TABLE IF EXISTS `vMatchDetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`upad4283`@`%` SQL SECURITY DEFINER VIEW `vMatchDetails`  AS SELECT `md`.`match_id` AS `match_id`, `p`.`player_name` AS `player_name`, `t`.`team_name` AS `team_name`, `md`.`goals_scored` AS `goals_scored` FROM ((`MatchDetails` `md` join `Players` `p` on((`md`.`player_id` = `p`.`player_id`))) join `Teams` `t` on((`md`.`team_id` = `t`.`team_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vMatchesTeams`
--
DROP TABLE IF EXISTS `vMatchesTeams`;

CREATE ALGORITHM=UNDEFINED DEFINER=`upad4283`@`%` SQL SECURITY DEFINER VIEW `vMatchesTeams`  AS SELECT `m`.`match_id` AS `match_id`, `t1`.`team_name` AS `home_team`, `t2`.`team_name` AS `away_team`, `m`.`match_date` AS `match_date` FROM ((`Matches` `m` join `Teams` `t1` on((`m`.`home_team_id` = `t1`.`team_id`))) join `Teams` `t2` on((`m`.`away_team_id` = `t2`.`team_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Groups`
--
ALTER TABLE `Groups`
  ADD PRIMARY KEY (`group_id`),
  ADD UNIQUE KEY `group_name` (`group_name`);

--
-- Indexes for table `MatchDetails`
--
ALTER TABLE `MatchDetails`
  ADD PRIMARY KEY (`match_id`,`player_id`),
  ADD KEY `player_id` (`player_id`,`team_id`);

--
-- Indexes for table `Matches`
--
ALTER TABLE `Matches`
  ADD PRIMARY KEY (`match_id`),
  ADD KEY `home_team_id` (`home_team_id`),
  ADD KEY `away_team_id` (`away_team_id`),
  ADD KEY `stadium_id` (`stadium_id`);

--
-- Indexes for table `Players`
--
ALTER TABLE `Players`
  ADD PRIMARY KEY (`player_id`,`team_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `Stadiums`
--
ALTER TABLE `Stadiums`
  ADD PRIMARY KEY (`stadium_id`);

--
-- Indexes for table `Teams`
--
ALTER TABLE `Teams`
  ADD PRIMARY KEY (`team_id`),
  ADD UNIQUE KEY `team_name` (`team_name`),
  ADD KEY `group_id` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Matches`
--
ALTER TABLE `Matches`
  MODIFY `match_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `Stadiums`
--
ALTER TABLE `Stadiums`
  MODIFY `stadium_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Teams`
--
ALTER TABLE `Teams`
  MODIFY `team_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `MatchDetails`
--
ALTER TABLE `MatchDetails`
  ADD CONSTRAINT `MatchDetails_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `Matches` (`match_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `MatchDetails_ibfk_2` FOREIGN KEY (`player_id`,`team_id`) REFERENCES `Players` (`player_id`, `team_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Matches`
--
ALTER TABLE `Matches`
  ADD CONSTRAINT `Matches_ibfk_1` FOREIGN KEY (`home_team_id`) REFERENCES `Teams` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Matches_ibfk_2` FOREIGN KEY (`away_team_id`) REFERENCES `Teams` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Matches_ibfk_3` FOREIGN KEY (`stadium_id`) REFERENCES `Stadiums` (`stadium_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `Players`
--
ALTER TABLE `Players`
  ADD CONSTRAINT `Players_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `Teams`
--
ALTER TABLE `Teams`
  ADD CONSTRAINT `Teams_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `Groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`upad4283`@`%` EVENT `CleanupOldMatches` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-27 15:43:18' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM Matches WHERE match_date < DATE_SUB(NOW(), INTERVAL 1 YEAR)$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
