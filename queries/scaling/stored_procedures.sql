-- Stored Procedures in MySQL
-- ==================================================
-- Automate SQL statements to run repeatedly

-- Basic stored procedure without parameters
-- Change delimiter to allow semicolons inside procedure
delimiter //

CREATE PROCEDURE `current_collection`()
BEGIN
    SELECT `title`, `accession_number`, `acquired`
    FROM `collections`
    WHERE `deleted` = 0;
END//

delimiter ;

-- Call the procedure
CALL `current_collection`();

-- Stored procedure WITH parameters
-- Example: Sell an artwork (soft delete and log transaction)
delimiter //

CREATE PROCEDURE `sell`(IN `sold_id` INT)
BEGIN
    -- Soft delete the item
    UPDATE `collections`
    SET `deleted` = 1
    WHERE `id` = `sold_id`;

    -- Log the transaction
    INSERT INTO `transactions` (`title`, `action`)
    VALUES (
        (SELECT `title` FROM `collections` WHERE `id` = `sold_id`),
        'sold'
    );
END//

delimiter ;

-- Call procedure with parameter
CALL `sell`(2);

-- Stored procedure with multiple parameters
delimiter //

CREATE PROCEDURE `add_employee`(
    IN `emp_name` VARCHAR(100),
    IN `emp_email` VARCHAR(100),
    IN `emp_dept` VARCHAR(50)
)
BEGIN
    INSERT INTO `employees` (`name`, `email`, `department`)
    VALUES (`emp_name`, `emp_email`, `emp_dept`);
END//

delimiter ;

CALL `add_employee`('John Doe', 'john@example.com', 'IT');

-- Stored procedure with OUT parameter
delimiter //

CREATE PROCEDURE `get_employee_count`(OUT `total` INT)
BEGIN
    SELECT COUNT(*) INTO `total` FROM `employees`;
END//

delimiter ;

-- Use OUT parameter
CALL `get_employee_count`(@count);
SELECT @count;

-- Stored procedure with IF statement
delimiter //

CREATE PROCEDURE `update_salary`(
    IN `emp_id` INT,
    IN `new_salary` DECIMAL(10, 2)
)
BEGIN
    IF `new_salary` > 0 THEN
        UPDATE `employees`
        SET `salary` = `new_salary`
        WHERE `id` = `emp_id`;
    END IF;
END//

delimiter ;

-- Stored procedure with WHILE loop
delimiter //

CREATE PROCEDURE `insert_test_data`(IN `count` INT)
BEGIN
    DECLARE `i` INT DEFAULT 1;

    WHILE `i` <= `count` DO
        INSERT INTO `test_table` (`value`) VALUES (`i`);
        SET `i` = `i` + 1;
    END WHILE;
END//

delimiter ;

-- View existing procedures
SHOW PROCEDURE STATUS WHERE `Db` = 'mbta';

-- Drop a procedure
DROP PROCEDURE IF EXISTS `procedure_name`;

-- Complete example: Bank transfer with transaction handling
delimiter //

CREATE PROCEDURE `transfer_money`(
    IN `from_account` INT,
    IN `to_account` INT,
    IN `amount` DECIMAL(10, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Deduct from sender
    UPDATE `accounts`
    SET `balance` = `balance` - `amount`
    WHERE `id` = `from_account`;

    -- Add to receiver
    UPDATE `accounts`
    SET `balance` = `balance` + `amount`
    WHERE `id` = `to_account`;

    COMMIT;
END//

delimiter ;

