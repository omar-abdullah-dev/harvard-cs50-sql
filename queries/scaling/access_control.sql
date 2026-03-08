-- Access Control in MySQL
-- ==================================================
-- Managing users and privileges

-- Create a new user
CREATE USER 'carter' IDENTIFIED BY 'password';
CREATE USER 'analyst' IDENTIFIED BY 'secure_password';
CREATE USER 'developer'@'localhost' IDENTIFIED BY 'dev_pass';

-- Grant SELECT privilege on specific table
GRANT SELECT ON `rideshare`.`analysis` TO 'carter';

-- Grant SELECT on all tables in a database
GRANT SELECT ON `database_name`.* TO 'analyst';

-- Grant multiple privileges
GRANT SELECT, INSERT, UPDATE ON `database_name`.`table_name` TO 'developer';

-- Grant all privileges on a database
GRANT ALL PRIVILEGES ON `mydb`.* TO 'admin_user';

-- Grant specific privileges on all databases
GRANT CREATE, DROP ON *.* TO 'superuser';

-- View user privileges
SHOW GRANTS FOR 'carter';
SHOW GRANTS FOR CURRENT_USER;

-- Revoke privileges
REVOKE SELECT ON `database_name`.`table_name` FROM 'username';
REVOKE ALL PRIVILEGES ON `database_name`.* FROM 'username';

-- Remove a user
DROP USER 'username';

-- Example: Rideshare database with PII protection
-- ------------------------------------------------

USE `rideshare`;

-- Create view that anonymizes PII
CREATE VIEW `analysis` AS
SELECT
    `id`,
    '***' AS `rider`,  -- Hide rider name
    `pickup`,
    `dropoff`,
    `distance`,
    `fare`
FROM `rides`;

-- Grant analyst access only to the anonymized view
GRANT SELECT ON `rideshare`.`analysis` TO 'analyst';

-- Analyst can now access anonymized data
-- (Run as analyst user)
USE `rideshare`;
SELECT * FROM `analysis`;  -- Works!
SELECT * FROM `rides`;     -- Access denied!

-- Example: Banking system with role-based access
-- -----------------------------------------------

-- Create users with different roles
CREATE USER 'teller' IDENTIFIED BY 'teller_pass';
CREATE USER 'manager' IDENTIFIED BY 'manager_pass';
CREATE USER 'auditor' IDENTIFIED BY 'auditor_pass';

-- Teller: Can view and update accounts
GRANT SELECT, UPDATE ON `bank`.`accounts` TO 'teller';
GRANT INSERT ON `bank`.`transactions` TO 'teller';

-- Manager: Full access to accounts and transactions
GRANT SELECT, INSERT, UPDATE, DELETE ON `bank`.`accounts` TO 'manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON `bank`.`transactions` TO 'manager';

-- Auditor: Read-only access to everything
GRANT SELECT ON `bank`.* TO 'auditor';

-- Example: Column-level privileges (where supported)
-- ---------------------------------------------------

-- Grant access to specific columns only
GRANT SELECT (`id`, `email`, `created_at`) ON `users` TO 'support_team';

-- Refresh privileges (run after making changes)
FLUSH PRIVILEGES;

-- Best Practices
-- --------------
-- 1. Principle of least privilege: Give users only what they need
-- 2. Use views to hide sensitive data
-- 3. Create role-based users (teller, manager, analyst, etc.)
-- 4. Regularly audit user privileges
-- 5. Use strong passwords and rotate them regularly
-- 6. Remove unused user accounts
-- 7. Log and monitor access to sensitive tables

