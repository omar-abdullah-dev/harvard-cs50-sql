-- constraints.sql
-- This file shows different column constraints.

CREATE TABLE users (
                       id INTEGER PRIMARY KEY,
                       email TEXT UNIQUE NOT NULL,
                       age INTEGER CHECK(age > 0),
                       created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- Simple Explanation (English)
-- This file shows common constraints:
--
-- PRIMARY KEY → Unique identifier.
--
-- UNIQUE → No duplicate values allowed.
--
--     NOT NULL → Cannot leave empty.
--
-- CHECK(age > 0) → Age must be positive.
--
-- DEFAULT CURRENT_TIMESTAMP → If no value is given, SQLite inserts the current time automatically.
--
-- Constraints help keep data correct and clean.
-- This table has several constraints:
-- 1. PRIMARY KEY (id): The id column is the primary key, which means it uniquely identifies each row and cannot be NULL.
-- 2. UNIQUE (email): The email column must have unique values, so no two users can have the same email address.
-- 3. NOT NULL (email): The email column cannot be NULL, so every user must have an email address.
-- 4. CHECK (age > 0): The age column must be greater than 0, ensuring that only valid ages are stored.
-- 5. DEFAULT CURRENT_TIMESTAMP (created_at): If no value is provided for the created_at column when a new user is inserted, it will automatically be set to the current date and time.
-- CREATE TABLE is used to create a new table.
--     users is the name of the table.
--     Inside parentheses, we define columns and their constraints.
--     INTEGER stores whole numbers.
--     TEXT stores strings.
--     Each row in this table represents one user.
