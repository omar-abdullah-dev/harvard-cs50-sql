-- MySQL Data Types

);
    PRIMARY KEY(`id`)
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `category` ENUM('electronics', 'clothing', 'food', 'books'),
    `stock` SMALLINT UNSIGNED DEFAULT 0,
    `price` DECIMAL(10, 2) NOT NULL,
    `description` TEXT,
    `name` VARCHAR(100) NOT NULL,
    `id` INT AUTO_INCREMENT,
CREATE TABLE `products` (
-- Example: Complete table with various types

);
    PRIMARY KEY(`id`)
    `name` VARCHAR(100),
    `id` INT AUTO_INCREMENT,
CREATE TABLE `users` (

-- Automatically generates unique sequential numbers
-- --------------
-- AUTO_INCREMENT

);
    `percentage` DECIMAL(5, 2)  -- Like 100.00
    `price` DECIMAL(10, 2),  -- 10 total digits, 2 after decimal
    `double_col` DOUBLE PRECISION,
    `float_col` FLOAT,
CREATE TABLE `numeric_examples` (

-- DECIMAL(digits, precision): Fixed-point decimal
-- DOUBLE PRECISION: Double precision floating point
-- FLOAT: Single precision floating point
-- -------------
-- NUMERIC TYPES

);
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    `created_at` DATETIME,
    `start_time` TIME,
    `birth_year` YEAR,
    `birth_date` DATE,
CREATE TABLE `datetime_examples` (

-- TIMESTAMP: More precise timestamp
-- DATETIME: YYYY-MM-DD HH:MM:SS
-- TIME: HH:MM:SS
-- YEAR: YYYY
-- DATE: YYYY-MM-DD
-- -------------------
-- DATE AND TIME TYPES

);
    `genres` SET('action', 'comedy', 'drama', 'horror')
    `shirt_size` ENUM('S', 'M', 'L', 'XL', 'XXL'),
    `regular_text` TEXT,
    `short_text` TINYTEXT,
    `variable_text` VARCHAR(255),       -- Up to 255 characters
    `fixed_text` CHAR(10),              -- Always 10 characters
CREATE TABLE `text_examples` (

-- SET: Predefined set of options (multiple choices allowed)
-- ENUM: Predefined set of options (single choice)
-- LONGTEXT: Up to 4,294,967,295 characters
-- MEDIUMTEXT: Up to 16,777,215 characters
-- TEXT: Up to 65,535 characters
-- TINYTEXT: Up to 255 characters
-- VARCHAR(n): Variable-length string (up to n characters)
-- CHAR(n): Fixed-width string
-- ----------
-- TEXT TYPES

);
    `unsigned_col` INT UNSIGNED  -- Doubles the maximum positive value
    `big_col` BIGINT,
    `int_col` INT,
    `medium_col` MEDIUMINT,
    `small_col` SMALLINT,
    `tiny_col` TINYINT,
CREATE TABLE `integer_examples` (

-- BIGINT: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
-- INT: -2,147,483,648 to 2,147,483,647
-- MEDIUMINT: -8,388,608 to 8,388,607
-- SMALLINT: -32,768 to 32,767 (or 0 to 65,535 unsigned)
-- TINYINT: -128 to 127 (or 0 to 255 unsigned)
-- -------------
-- INTEGER TYPES

-- MySQL provides more granular data types than SQLite
-- ==================================================
