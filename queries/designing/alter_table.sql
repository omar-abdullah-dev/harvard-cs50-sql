-- alter_table.sql
-- This file shows how to modify a table.

ALTER TABLE users ADD COLUMN phone TEXT;

ALTER TABLE users RENAME COLUMN phone TO phone_number;

ALTER TABLE users DROP COLUMN phone_number;

-- Simple Explanation (English)

-- ALTER TABLE is used to change an existing table.
--
--     ADD COLUMN adds a new column.
--
--     RENAME COLUMN changes a column name.
--
--     DROP COLUMN removes a column.
--
--     This is useful when your database design changes.
-- ALTER TABLE is used to change an existing table.
-- ADD COLUMN adds a new column to the table.
-- RENAME COLUMN changes the name of an existing column.
-- DROP COLUMN removes a column from the table.
-- In this example:
-- 1. We add a new column called phone to the users table.
-- 2. We rename the phone column to phone_number.
-- 3. We drop the phone_number column from the users table.
