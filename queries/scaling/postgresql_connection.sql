-- PostgreSQL Connection and Basic Commands
-- ==================================================
-- Connect to PostgreSQL server from terminal:
-- psql postgresql://postgres@127.0.0.1:5432/postgres
--
-- Format: psql postgresql://username@host:port/database

-- List all databases
\l

-- Create a new database
CREATE DATABASE "mbta";

-- Connect to a specific database
\c "mbta"

-- List all tables in current database
\dt

-- Describe table structure
\d "cards"

-- Quit PostgreSQL
\q

-- Show current database
SELECT current_database();

-- Show current user
SELECT current_user;

-- Example: Creating a simple database workflow
CREATE DATABASE "example_db";
\c "example_db"

CREATE TABLE "users" (
    "id" SERIAL,
    "username" VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY("id")
);

\dt
\d "users"

-- Additional useful commands
-- ---------------------------

-- List all schemas
\dn

-- List all functions
\df

-- List all views
\dv

-- Show table size
\dt+

-- Execute SQL from a file
\i /path/to/file.sql

-- Display query execution time
\timing on

-- Set output format
\x on  -- Expanded display (vertical)
\x off -- Normal display (horizontal)

