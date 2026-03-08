-- SQL Injection Attack Prevention
-- ==================================================
-- Protecting against malicious SQL code injection

-- VULNERABLE CODE (DON'T DO THIS!)
-- --------------------------------
-- Never concatenate user input directly into SQL queries
-- Example of vulnerable query:
-- SELECT `id` FROM `users`
-- WHERE `user` = 'input_username' AND `password` = 'input_password';

-- ATTACK EXAMPLE:
-- If user enters: password' OR '1' = '1
-- The query becomes:
-- SELECT `id` FROM `users`
-- WHERE `user` = 'Carter' AND `password` = 'password' OR '1' = '1';
-- This returns ALL users!

-- ATTACK EXAMPLE 2: UNION injection
SELECT * FROM `accounts`
WHERE `id` = 1 UNION SELECT * FROM `accounts`;
-- This could expose all account data

-- SOLUTION: Prepared Statements
-- ==============================

-- Create a prepared statement with placeholder
PREPARE `balance_check`
FROM 'SELECT * FROM `accounts` WHERE `id` = ?';

-- Set the variable with user input
SET @id = 1;

-- Execute with the variable
EXECUTE `balance_check` USING @id;

-- The ? placeholder safely escapes malicious input
-- Even if user tries: '1 UNION SELECT * FROM `accounts`'
SET @id = '1 UNION SELECT * FROM `accounts`';
EXECUTE `balance_check` USING @id;
-- Returns only account with that literal string as ID (none)

-- Multiple parameters example
PREPARE `login_check`
FROM 'SELECT `id` FROM `users` WHERE `username` = ? AND `password` = ?';

SET @username = 'carter';
SET @password = 'secure_password';
EXECUTE `login_check` USING @username, @password;

-- Prepared statement with INSERT
PREPARE `add_user`
FROM 'INSERT INTO `users` (`username`, `email`) VALUES (?, ?)';

SET @new_username = 'john_doe';
SET @new_email = 'john@example.com';
EXECUTE `add_user` USING @new_username, @new_email;

-- Prepared statement with UPDATE
PREPARE `update_email`
FROM 'UPDATE `users` SET `email` = ? WHERE `id` = ?';

SET @new_email = 'newemail@example.com';
SET @user_id = 5;
EXECUTE `update_email` USING @new_email, @user_id;

-- Clean up prepared statement when done
DEALLOCATE PREPARE `balance_check`;

-- How Prepared Statements Work
-- ----------------------------
-- 1. SQL statement is parsed and compiled separately from data
-- 2. Placeholders (?) are used for user input
-- 3. User input is "escaped" - special SQL characters are neutralized
-- 4. Input is treated as data, never as executable code

-- Additional Security Measures
-- ----------------------------

-- 1. Use views to limit data exposure
CREATE VIEW `public_users` AS
SELECT `id`, `username`, `created_at`
FROM `users`;
-- Don't expose password columns

-- 2. Validate input on application level
-- - Check data types
-- - Limit string lengths
-- - Whitelist allowed characters
-- - Reject suspicious patterns

-- 3. Use stored procedures with parameters
delimiter //
CREATE PROCEDURE `safe_login`(
    IN `input_username` VARCHAR(50),
    IN `input_password` VARCHAR(255)
)
BEGIN
    SELECT `id`, `username`
    FROM `users`
    WHERE `username` = `input_username`
    AND `password` = SHA2(`input_password`, 256);
END//
delimiter ;

-- 4. Implement rate limiting
-- - Prevent brute force attacks
-- - Limit failed login attempts

-- 5. Use parameterized queries in application code
--
-- Python (with mysql.connector):
-- cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))
--
-- PHP (with PDO):
-- $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
-- $stmt->execute([$user_id]);
--
-- Node.js (with mysql2):
-- connection.execute("SELECT * FROM users WHERE id = ?", [userId]);

-- Common SQL Injection Patterns to Watch For
-- ------------------------------------------
-- 1. ' OR '1'='1
-- 2. '; DROP TABLE users; --
-- 3. ' UNION SELECT * FROM other_table --
-- 4. admin'--
-- 5. ' OR 1=1--
-- 6. '; EXEC xp_cmdshell('dir'); --

-- Best Practices Summary
-- ---------------------
-- ✅ Always use prepared statements/parameterized queries
-- ✅ Never concatenate user input into SQL
-- ✅ Validate and sanitize all user input
-- ✅ Use stored procedures with parameters
-- ✅ Implement least privilege access control
-- ✅ Keep software and libraries updated
-- ✅ Log and monitor suspicious query patterns
-- ❌ Never trust user input
-- ❌ Never store passwords in plain text
-- ❌ Never expose detailed error messages to users

