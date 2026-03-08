-- PostgreSQL Data Types
-- ==================================================

-- INTEGER TYPES
-- -------------
-- SMALLINT: -32,768 to 32,767
-- INTEGER (or INT): -2,147,483,648 to 2,147,483,647
-- BIGINT: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
-- SERIAL: Auto-incrementing INTEGER
-- BIGSERIAL: Auto-incrementing BIGINT

CREATE TABLE "integer_examples" (
    "small_col" SMALLINT,
    "int_col" INTEGER,
    "big_col" BIGINT,
    "auto_id" SERIAL,
    "big_auto_id" BIGSERIAL
);

-- TEXT TYPES
-- ----------
-- VARCHAR(n): Variable-length string (up to n characters)
-- TEXT: Unlimited length text
-- CHAR(n): Fixed-length string

CREATE TABLE "text_examples" (
    "variable_text" VARCHAR(255),
    "unlimited_text" TEXT,
    "fixed_text" CHAR(10)
);

-- CUSTOM ENUM TYPES
-- -----------------
-- Create custom types for predefined options

CREATE TYPE "swipe_type" AS ENUM('enter', 'exit', 'deposit');
CREATE TYPE "status_type" AS ENUM('active', 'inactive', 'pending');
CREATE TYPE "priority_level" AS ENUM('low', 'medium', 'high', 'urgent');

CREATE TABLE "custom_type_examples" (
    "swipe" "swipe_type",
    "status" "status_type",
    "priority" "priority_level"
);

-- DATE AND TIME TYPES
-- -------------------
-- DATE: YYYY-MM-DD
-- TIME: HH:MM:SS
-- TIMESTAMP: Date and time
-- INTERVAL: Time duration

CREATE TABLE "datetime_examples" (
    "event_date" DATE,
    "event_time" TIME,
    "created_at" TIMESTAMP DEFAULT now(),
    "duration" INTERVAL
);

-- NUMERIC TYPES
-- -------------
-- REAL: Single precision floating point
-- DOUBLE PRECISION: Double precision floating point
-- NUMERIC(digits, precision): Fixed-point decimal (like MySQL DECIMAL)

CREATE TABLE "numeric_examples" (
    "real_col" REAL,
    "double_col" DOUBLE PRECISION,
    "price" NUMERIC(10, 2),
    "percentage" NUMERIC(5, 2)
);

-- BOOLEAN TYPE
-- ------------
CREATE TABLE "boolean_examples" (
    "is_active" BOOLEAN DEFAULT TRUE,
    "is_verified" BOOLEAN
);

-- ARRAY TYPES
-- -----------
-- PostgreSQL supports arrays!

CREATE TABLE "array_examples" (
    "tags" TEXT[],
    "scores" INTEGER[]
);

INSERT INTO "array_examples" VALUES
    (ARRAY['tag1', 'tag2', 'tag3'], ARRAY[85, 90, 95]);

-- JSON TYPES
-- ----------
-- JSON and JSONB (binary JSON, more efficient)

CREATE TABLE "json_examples" (
    "data" JSON,
    "metadata" JSONB
);

-- UUID TYPE
-- ---------
CREATE TABLE "uuid_examples" (
    "id" UUID DEFAULT gen_random_uuid(),
    "name" VARCHAR(100)
);

-- Example: Complete table with various types
CREATE TABLE "products" (
    "id" SERIAL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "price" NUMERIC(10, 2) NOT NULL,
    "stock" SMALLINT DEFAULT 0,
    "tags" TEXT[],
    "is_active" BOOLEAN DEFAULT TRUE,
    "created_at" TIMESTAMP DEFAULT now(),
    PRIMARY KEY("id")
);

