-- Altering Tables in MySQL
-- ==================================================
-- MySQL allows more fundamental alterations than SQLite

-- Add a new option to ENUM
-- Example: Add 'silver' line to stations
ALTER TABLE `stations`
MODIFY `line` ENUM('blue', 'green', 'orange', 'red', 'silver') NOT NULL;

-- Add a new column
ALTER TABLE `collections`
ADD COLUMN `deleted` TINYINT DEFAULT 0;

-- Modify column type
ALTER TABLE `users`
MODIFY `email` VARCHAR(255) NOT NULL;

-- Rename a column
ALTER TABLE `products`
CHANGE `old_name` `new_name` VARCHAR(100);

-- Drop a column
ALTER TABLE `users`
DROP COLUMN `middle_name`;

-- Add a constraint
ALTER TABLE `orders`
ADD CONSTRAINT `positive_amount` CHECK(`amount` > 0);

-- Add a foreign key
ALTER TABLE `orders`
ADD FOREIGN KEY(`customer_id`) REFERENCES `customers`(`id`);

-- Example: Complete table modification workflow
CREATE TABLE `employees` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(50),
    PRIMARY KEY(`id`)
);

-- Add more columns
ALTER TABLE `employees`
ADD COLUMN `email` VARCHAR(100),
ADD COLUMN `department` VARCHAR(50),
ADD COLUMN `salary` DECIMAL(10, 2);

-- Make email unique
ALTER TABLE `employees`
MODIFY `email` VARCHAR(100) UNIQUE;

-- Add department as ENUM
ALTER TABLE `employees`
MODIFY `department` ENUM('hr', 'it', 'sales', 'marketing');

-- Add constraint for salary
ALTER TABLE `employees`
ADD CONSTRAINT `salary_check` CHECK(`salary` > 0);

