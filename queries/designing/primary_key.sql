-- primary_key.sql
-- This file shows how to define a primary key.

CREATE TABLE students (
                          id INTEGER,
                          name TEXT,
                          age INTEGER,
                          PRIMARY KEY (id)
);

-- Simple Explanation (English)
-- A PRIMARY KEY uniquely identifies each row.
--
-- No two rows can have the same id.
--
-- A primary key cannot be NULL.
--
-- It ensures every record is unique.
-- CREATE TABLE is used to create a new table.
--     students is the name of the table.
--     Inside parentheses, we define columns.
--     INTEGER stores whole numbers.
--     TEXT stores strings.
--     PRIMARY KEY (id) means that the id column is the primary key of this table.
--     Each row in this table represents one student.

