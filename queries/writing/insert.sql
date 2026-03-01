-- ============================================
-- INSERT - Adding Data to Tables
-- ============================================
-- INSERT INTO is used to add new rows to a table

-- ============================================
-- BASIC INSERT SYNTAX
-- ============================================

-- Example 1: Insert a single row with all columns specified
INSERT INTO "collections" ("id", "title", "accession_number", "acquired")
VALUES (1, 'Profusion of flowers', '56.257', '1956-04-12');

-- Example 2: Insert without specifying ID (SQLite auto-generates it)
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Farmers working at dawn', '11.6152', '1911-08-03');

-- Explanation: Omitting the ID column allows SQLite to auto-increment
-- SQLite takes the highest existing ID and increments by 1

-- Example 3: Insert with NULL value
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Imaginative landscape', '56.496', NULL);

-- Explanation: NULL can be used when data is unknown or not applicable

-- ============================================
-- INSERTING MULTIPLE ROWS
-- ============================================

-- Example 4: Insert multiple rows at once (more efficient)
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES
    ('Imaginative landscape', '56.496', NULL),
    ('Peonies and butterfly', '06.1899', '1906-01-01'),
    ('Spring outing', '14.76', '1914-01-08');

-- Explanation: Separate rows with commas
-- This is faster than running multiple INSERT statements

-- Example 5: Insert multiple players
INSERT INTO "players" ("first_name", "last_name", "birth_year", "debut")
VALUES
    ('Jackie', 'Robinson', 1919, '1947-04-15'),
    ('Willie', 'Mays', 1931, '1951-05-25'),
    ('Hank', 'Aaron', 1934, '1954-04-13');

-- ============================================
-- INSERT WITH COLUMN ORDER
-- ============================================

-- Example 6: Columns don't have to be in schema order
INSERT INTO "collections" ("acquired", "title", "accession_number")
VALUES ('1920-05-01', 'Modern Art', '20.123');

-- Explanation: Column order in INSERT can differ from table schema
-- Just ensure VALUES match the specified column order

-- ============================================
-- INSERT ALL COLUMNS (Shorthand)
-- ============================================

-- Example 7: If inserting into ALL columns in schema order, can omit column names
INSERT INTO "collections"
VALUES (10, 'Abstract Painting', '45.789', '1945-06-15');

-- ⚠️ Warning: This approach is risky - if table schema changes, query breaks
-- ✅ Better practice: Always specify column names

-- ============================================
-- INSERT WITH DEFAULT VALUES
-- ============================================

-- Example 8: Using DEFAULT keyword
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('New Artwork', '24.001', DEFAULT);

-- Explanation: DEFAULT uses the default value specified in schema
-- If no default, uses NULL

-- Example 9: Insert with only required columns
INSERT INTO "users" ("username", "email")
VALUES ('john_doe', 'john@example.com');
-- Other columns with DEFAULT or NULL are auto-filled

-- ============================================
-- CONSTRAINTS AND ERRORS
-- ============================================

-- Example 10: Violating UNIQUE constraint (will cause error)
-- INSERT INTO "collections" ("title", "accession_number", "acquired")
-- VALUES ('Duplicate', '56.257', '2020-01-01');
-- Error: UNIQUE constraint failed: collections.accession_number

-- Example 11: Violating NOT NULL constraint (will cause error)
-- INSERT INTO "collections" ("title", "accession_number", "acquired")
-- VALUES (NULL, '99.999', '2020-01-01');
-- Error: NOT NULL constraint failed: collections.title

-- Example 12: Valid insert respecting all constraints
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Valid Artwork', '24.002', '2024-01-01');

-- ============================================
-- INSERT FROM CSV FILE
-- ============================================

-- Method 1: Direct CSV import (SQLite command, not SQL)
-- .import --csv --skip 1 mfa.csv collections
-- Explanation:
--   --csv: indicates CSV format
--   --skip 1: skip header row
--   mfa.csv: source file
--   collections: target table

-- Method 2: Import to temporary table, then transfer
-- Step 1: Import CSV to temp table
-- .import --csv mfa.csv temp

-- Step 2: Transfer data to actual table
INSERT INTO "collections" ("title", "accession_number", "acquired")
SELECT "title", "accession_number", "acquired" FROM "temp";

-- Step 3: Clean up temporary table
DROP TABLE "temp";

-- ============================================
-- INSERT WITH SUBQUERIES
-- ============================================

-- Example 13: Insert based on data from another table
INSERT INTO "archived_books" ("title", "author", "year")
SELECT "title", "author", "year"
FROM "books"
WHERE "year" < 2000;

-- Explanation: Copies old books to archive table

-- Example 14: Insert with calculated values
INSERT INTO "statistics" ("year", "avg_rating", "total_books")
SELECT
    "year",
    ROUND(AVG("rating"), 2),
    COUNT(*)
FROM "books"
GROUP BY "year";

-- ============================================
-- INSERT OR REPLACE / INSERT OR IGNORE
-- ============================================

-- Example 15: INSERT OR REPLACE (upsert)
INSERT OR REPLACE INTO "settings" ("key", "value")
VALUES ('theme', 'dark');

-- Explanation: If key exists, UPDATE it; otherwise INSERT
-- Useful for key-value stores

-- Example 16: INSERT OR IGNORE (skip if conflict)
INSERT OR IGNORE INTO "users" ("username", "email")
VALUES ('existing_user', 'new@example.com');

-- Explanation: If username exists (UNIQUE constraint), ignore the insert
-- No error thrown

-- ============================================
-- INSERT WITH RETURNING (SQLite 3.35+)
-- ============================================

-- Example 17: Get the inserted row ID
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('New Painting', '24.003', '2024-03-01')
RETURNING "id";

-- Explanation: Returns the auto-generated ID of inserted row

-- Example 18: Return multiple columns
INSERT INTO "users" ("username", "email")
VALUES ('jane_doe', 'jane@example.com')
RETURNING "id", "username", "created_at";

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: User Registration
INSERT INTO "users" ("username", "email", "password_hash", "created_at")
VALUES ('newuser123', 'user@example.com', 'hashed_password', DATETIME('now'));

-- Use Case 2: Creating an Order
INSERT INTO "orders" ("customer_id", "order_date", "total", "status")
VALUES (42, DATE('now'), 99.99, 'pending');

-- Use Case 3: Logging Events
INSERT INTO "logs" ("event_type", "user_id", "timestamp", "details")
VALUES ('login', 15, DATETIME('now'), 'User logged in from mobile app');

-- Use Case 4: Adding Product to Inventory
INSERT INTO "inventory" ("product_id", "quantity", "warehouse_id", "last_updated")
VALUES (1001, 50, 3, DATE('now'));

-- Use Case 5: Enrolling Student in Course
INSERT INTO "enrollments" ("student_id", "course_id", "enrollment_date", "status")
VALUES (2023001, 'CS50-SQL', DATE('now'), 'active');

-- ============================================
-- BULK INSERT PATTERNS
-- ============================================

-- Pattern 1: Insert multiple related records
INSERT INTO "order_items" ("order_id", "product_id", "quantity", "price")
VALUES
    (100, 1, 2, 19.99),
    (100, 5, 1, 49.99),
    (100, 12, 3, 9.99);

-- Pattern 2: Insert with transaction (all or nothing)
BEGIN TRANSACTION;
INSERT INTO "accounts" ("account_number", "balance") VALUES ('A001', 1000);
INSERT INTO "accounts" ("account_number", "balance") VALUES ('A002', 2000);
COMMIT;

-- If any INSERT fails, all are rolled back

-- ============================================
-- BEST PRACTICES
-- ============================================

-- ✅ DO: Always specify column names
INSERT INTO "users" ("username", "email") VALUES ('user1', 'email@example.com');

-- ❌ DON'T: Rely on column order
-- INSERT INTO "users" VALUES ('user1', 'email@example.com');

-- ✅ DO: Use multiple VALUES for bulk inserts
INSERT INTO "table" ("col") VALUES ('val1'), ('val2'), ('val3');

-- ❌ DON'T: Run separate INSERTs unnecessarily
-- INSERT INTO "table" ("col") VALUES ('val1');
-- INSERT INTO "table" ("col") VALUES ('val2');
-- INSERT INTO "table" ("col") VALUES ('val3');

-- ✅ DO: Validate data before inserting
-- Check constraints, data types, required fields

-- ✅ DO: Use transactions for related inserts
-- Ensures data consistency

-- ============================================
-- COMMON PATTERNS
-- ============================================

-- Pattern 1: Insert with current timestamp
INSERT INTO "posts" ("title", "content", "created_at")
VALUES ('New Post', 'Content here', DATETIME('now'));

-- Pattern 2: Insert with auto-increment
INSERT INTO "categories" ("name", "description")
VALUES ('Electronics', 'Electronic devices and accessories');
-- ID is auto-generated

-- Pattern 3: Conditional insert (only if not exists)
INSERT INTO "tags" ("name")
SELECT 'Programming'
WHERE NOT EXISTS (SELECT 1 FROM "tags" WHERE "name" = 'Programming');

-- Pattern 4: Copy data between tables
INSERT INTO "backup_users" SELECT * FROM "users";

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. INSERT INTO adds new rows to tables
-- 2. Omit ID column to let SQLite auto-increment
-- 3. Insert multiple rows with comma-separated VALUES
-- 4. NULL represents unknown/missing data
-- 5. Constraints (UNIQUE, NOT NULL) protect data integrity
-- 6. Use INSERT OR REPLACE for upsert operations
-- 7. Use INSERT OR IGNORE to skip conflicts
-- 8. Specify column names for maintainability
-- 9. Use transactions for multiple related inserts
-- 10. RETURNING clause returns inserted data (SQLite 3.35+)

