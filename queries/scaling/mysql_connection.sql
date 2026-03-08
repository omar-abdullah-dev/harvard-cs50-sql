-- MySQL Connection and Basic Commands
-- ==================================================
-- Connect to MySQL server from terminal:
-- mysql -u root -h 127.0.0.1 -P 3306 -p
--
-- Parameters:
-- -u : username (root = admin)
-- -h : host address (127.0.0.1 = localhost)
-- -P : port number (3306 = default MySQL port)
-- -p : prompt for password

-- Show all databases on the server
SHOW DATABASES;

-- Create a new database
CREATE DATABASE `mbta`;

-- Switch to a specific database
USE `mbta`;

-- Show all tables in current database
SHOW TABLES;

-- Describe table structure
DESCRIBE `cards`;

-- Example: Creating a simple database workflow
CREATE DATABASE `example_db`;
USE `example_db`;

CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY(`id`)
);

SHOW TABLES;
DESCRIBE `users`;

