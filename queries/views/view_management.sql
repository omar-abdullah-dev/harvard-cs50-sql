-- ============================================
-- VIEW MANAGEMENT OPERATIONS
-- ============================================
-- Common operations for managing views in SQLite

-- ============================================
-- CREATING VIEWS
-- ============================================

-- Basic view creation
CREATE VIEW "view_name" AS
SELECT "column1", "column2"
FROM "table_name";

-- Temporary view (exists only during current connection)
CREATE TEMPORARY VIEW "temp_view_name" AS
SELECT "column1", "column2"
FROM "table_name";

-- View with IF NOT EXISTS (prevents errors if view already exists)
CREATE VIEW IF NOT EXISTS "view_name" AS
SELECT "column1", "column2"
FROM "table_name";

-- ============================================
-- VIEWING EXISTING VIEWS
-- ============================================

-- List all views in the database
SELECT "name" FROM "sqlite_master"
WHERE "type" = 'view';

-- See the SQL that created a view
SELECT "sql" FROM "sqlite_master"
WHERE "type" = 'view'
AND "name" = 'view_name';

-- Show database schema (includes views)
.schema

-- Show specific view schema
.schema view_name

-- ============================================
-- DROPPING VIEWS
-- ============================================

-- Drop a view
DROP VIEW "view_name";

-- Drop view if it exists (prevents errors)
DROP VIEW IF EXISTS "view_name";

-- Drop a temporary view
DROP VIEW "temp_view_name";

-- ============================================
-- MODIFYING VIEWS
-- ============================================
-- Note: SQLite doesn't support ALTER VIEW
-- To modify a view, you must drop it and recreate it

-- Step 1: Drop the existing view
DROP VIEW IF EXISTS "view_name";

-- Step 2: Recreate with new definition
CREATE VIEW "view_name" AS
SELECT "column1", "column2", "column3"  -- Added column3
FROM "table_name";

-- ============================================
-- REPLACING VIEWS (workaround)
-- ============================================
-- Create a script that drops and recreates
DROP VIEW IF EXISTS "longlist";
CREATE VIEW "longlist" AS
SELECT "name", "title", "year"  -- Modified to include year
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";

-- ============================================
-- QUERYING VIEWS
-- ============================================

-- Query a view like a table
SELECT * FROM "view_name";

-- Filter results from a view
SELECT * FROM "view_name"
WHERE "column1" = 'value';

-- Join views with tables
SELECT * FROM "view_name"
JOIN "table_name" ON "view_name"."id" = "table_name"."id";

-- Join views with other views
SELECT * FROM "view1"
JOIN "view2" ON "view1"."id" = "view2"."id";

-- ============================================
-- VIEW METADATA
-- ============================================

-- Check if a view exists
SELECT COUNT(*) FROM "sqlite_master"
WHERE "type" = 'view'
AND "name" = 'view_name';

-- Get information about all views
SELECT
    "name" AS "view_name",
    "sql" AS "definition"
FROM "sqlite_master"
WHERE "type" = 'view'
ORDER BY "name";

-- ============================================
-- VIEW LIMITATIONS IN SQLite
-- ============================================

-- ❌ Cannot directly INSERT into a view (unless using INSTEAD OF trigger)
-- INSERT INTO "view_name" VALUES (...);  -- This will fail

-- ❌ Cannot directly UPDATE a view (unless using INSTEAD OF trigger)
-- UPDATE "view_name" SET "column1" = 'value';  -- This will fail

-- ❌ Cannot directly DELETE from a view (unless using INSTEAD OF trigger)
-- DELETE FROM "view_name" WHERE "id" = 1;  -- This will fail

-- ✅ Can use INSTEAD OF triggers to enable INSERT/UPDATE/DELETE
CREATE TRIGGER "insert_trigger"
INSTEAD OF INSERT ON "view_name"
FOR EACH ROW
BEGIN
    INSERT INTO "underlying_table" ("column1", "column2")
    VALUES (NEW."column1", NEW."column2");
END;

-- ============================================
-- BEST PRACTICES
-- ============================================

-- 1. Use descriptive names
CREATE VIEW "active_users_with_orders" AS
SELECT * FROM "users" WHERE "status" = 'active';

-- 2. Document complex views with comments
-- View: customer_summary
-- Purpose: Provides customer statistics for reporting
-- Updated: 2024-03-01
CREATE VIEW "customer_summary" AS
SELECT
    "customer_id",
    COUNT(*) AS "order_count",
    SUM("total") AS "total_spent"
FROM "orders"
GROUP BY "customer_id";

-- 3. Use views for frequently used complex queries
CREATE VIEW "best_selling_books" AS
SELECT
    "books"."title",
    COUNT("sales"."id") AS "sales_count"
FROM "books"
JOIN "sales" ON "books"."id" = "sales"."book_id"
GROUP BY "books"."id"
ORDER BY "sales_count" DESC
LIMIT 10;

-- 4. Test view performance
-- Use EXPLAIN QUERY PLAN to check performance
EXPLAIN QUERY PLAN
SELECT * FROM "view_name";

-- 5. Keep views simple when possible
-- Complex views can impact query performance

-- ============================================
-- COMMON PATTERNS
-- ============================================

-- Pattern 1: Simplification View
CREATE VIEW "author_books" AS
SELECT
    "authors"."name" AS "author",
    "books"."title" AS "book"
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";

-- Pattern 2: Aggregation View
CREATE VIEW "sales_by_month" AS
SELECT
    strftime('%Y-%m', "sale_date") AS "month",
    SUM("amount") AS "total_sales"
FROM "sales"
GROUP BY "month";

-- Pattern 3: Security View
CREATE VIEW "public_user_info" AS
SELECT
    "id",
    "username",
    "join_date"
    -- Omitting: password, email, phone, etc.
FROM "users";

-- Pattern 4: Partition View
CREATE VIEW "orders_2024" AS
SELECT * FROM "orders"
WHERE strftime('%Y', "order_date") = '2024';

-- ============================================
-- KEY POINTS:
-- ============================================
-- 1. Views are stored in sqlite_master table
-- 2. Use DROP VIEW to remove views
-- 3. No ALTER VIEW - must drop and recreate
-- 4. Views can be queried like tables
-- 5. Use INSTEAD OF triggers for INSERT/UPDATE/DELETE operations
-- 6. Check .schema to see all views
-- 7. Temporary views don't appear in schema

