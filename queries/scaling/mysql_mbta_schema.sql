-- MySQL MBTA Database Schema
-- ==================================================
-- Boston MBTA (subway system) database

-- Create database
CREATE DATABASE `mbta`;
USE `mbta`;

-- Create cards table
-- CharlieCards used by riders
CREATE TABLE `cards` (
    `id` INT AUTO_INCREMENT,
    PRIMARY KEY(`id`)
);

-- Create stations table
-- Subway stations with their lines
CREATE TABLE `stations` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL UNIQUE,
    `line` ENUM('blue', 'green', 'orange', 'red') NOT NULL,
    PRIMARY KEY(`id`)
);

-- Create swipes table
-- Records when a card is swiped at a station
CREATE TABLE `swipes` (
    `id` INT AUTO_INCREMENT,
    `card_id` INT,
    `station_id` INT,
    `type` ENUM('enter', 'exit', 'deposit') NOT NULL,
    `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `amount` DECIMAL(5,2) NOT NULL CHECK(`amount` != 0),
    PRIMARY KEY(`id`),
    FOREIGN KEY(`station_id`) REFERENCES `stations`(`id`),
    FOREIGN KEY(`card_id`) REFERENCES `cards`(`id`)
);

-- Insert sample data
INSERT INTO `stations` (`name`, `line`) VALUES
('Park Street', 'red'),
('South Station', 'red'),
('Harvard', 'red'),
('Government Center', 'blue'),
('Aquarium', 'blue'),
('North Station', 'orange'),
('Back Bay', 'orange'),
('Copley', 'green'),
('Kenmore', 'green');

INSERT INTO `cards` VALUES (), (), ();

INSERT INTO `swipes` (`card_id`, `station_id`, `type`, `amount`) VALUES
(1, 1, 'enter', -2.40),
(1, 2, 'exit', 0.00),
(2, 4, 'enter', -2.40),
(3, 1, 'deposit', 20.00);

-- Query examples
SELECT * FROM `stations` WHERE `line` = 'red';
SELECT * FROM `swipes` WHERE `type` = 'deposit';

SELECT s.`name`, sw.`type`, sw.`datetime`
FROM `swipes` sw
JOIN `stations` s ON sw.`station_id` = s.`id`
WHERE sw.`card_id` = 1;

