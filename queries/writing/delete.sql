-- ============================================
-- DELETE - Removing Data from Tables
-- ============================================
-- DELETE removes rows from a table permanently

-- ============================================
-- BASIC DELETE SYNTAX
-- ============================================
-- DELETE FROM table_name WHERE condition;

-- Example 1: Delete a specific row by ID
DELETE FROM "collections"
WHERE "id" = 5;

-- Example 2: Delete by title
DELETE FROM "collections"
WHERE "title" = 'Spring outing';

-- Example 3: Delete rows with NULL values
DELETE FROM "collections"
WHERE "acquired" IS NULL;

-- ============================================
-- DELETE ALL ROWS (EXTREMELY DANGEROUS!)
-- ============================================

-- Example 4: Delete ALL rows from a table
DELETE FROM "collections";

-- ⚠️ WARNING: This removes EVERY row! Use with extreme caution!
-- ⚠️ This does NOT delete the table itself, just all data
-- ⚠️ Cannot be undone (unless in transaction)

-- ============================================
-- DELETE WITH COMPARISON OPERATORS
-- ============================================

-- Example 5: Delete old records
DELETE FROM "collections"
WHERE "acquired" < '1909-01-01';

-- Explanation: Removes artwork acquired before January 1, 1909

-- Example 6: Delete based on rating
DELETE FROM "books"
WHERE "rating" < 2.0;

-- Example 7: Delete based on date range
DELETE FROM "logs"
WHERE "created_at" BETWEEN '2020-01-01' AND '2020-12-31';

-- Example 8: Delete records older than X days
DELETE FROM "sessions"
WHERE "created_at" < DATE('now', '-30 days');

-- ============================================
-- DELETE WITH MULTIPLE CONDITIONS
-- ============================================

-- Example 9: Delete with AND conditions
DELETE FROM "users"
WHERE "status" = 'inactive'
  AND "last_login" < DATE('now', '-365 days');

-- Example 10: Delete with OR conditions
DELETE FROM "temp_data"
WHERE "processed" = 1
   OR "created_at" < DATE('now', '-7 days');

-- Example 11: Complex conditions
DELETE FROM "products"
WHERE "discontinued" = 1
  AND "stock_quantity" = 0
  AND "last_sold" < DATE('now', '-180 days');

-- ============================================
-- DELETE WITH SUBQUERIES
-- ============================================

-- Example 12: Delete using subquery
DELETE FROM "created"
WHERE "artist_id" = (
    SELECT "id"
    FROM "artists"
    WHERE "name" = 'Unidentified artist'
);

-- Example 13: Delete rows not referenced in another table
DELETE FROM "categories"
WHERE "id" NOT IN (
    SELECT DISTINCT "category_id"
    FROM "products"
);

-- Explanation: Removes unused categories

-- Example 14: Delete duplicate records (keep one)
DELETE FROM "contacts"
WHERE "rowid" NOT IN (
    SELECT MIN("rowid")
    FROM "contacts"
    GROUP BY "email"
);

-- Explanation: Keeps first occurrence of each email, deletes duplicates

-- Example 15: Delete based on aggregate condition
DELETE FROM "customers"
WHERE "id" IN (
    SELECT "customer_id"
    FROM "orders"
    GROUP BY "customer_id"
    HAVING COUNT(*) = 0
);

-- ============================================
-- DELETE WITH LIMIT (SQLite)
-- ============================================

-- Example 16: Delete only first N rows
DELETE FROM "queue"
WHERE "status" = 'processed'
ORDER BY "created_at"
LIMIT 100;

-- Explanation: Removes oldest 100 processed items from queue

-- Example 17: Delete top rated items (unusual use case)
DELETE FROM "items"
WHERE "id" IN (
    SELECT "id"
    FROM "items"
    ORDER BY "rating" DESC
    LIMIT 5
);

-- ============================================
-- FOREIGN KEY CONSTRAINTS
-- ============================================

-- Example 18: DELETE causing foreign key error
-- DELETE FROM "artists"
-- WHERE "name" = 'Unidentified artist';
-- Error: FOREIGN KEY constraint failed

-- Solution 1: Delete child records first
DELETE FROM "created"
WHERE "artist_id" = (
    SELECT "id" FROM "artists" WHERE "name" = 'Unidentified artist'
);

DELETE FROM "artists"
WHERE "name" = 'Unidentified artist';

-- Solution 2: Use ON DELETE CASCADE in schema
-- FOREIGN KEY("artist_id") REFERENCES "artists"("id") ON DELETE CASCADE

-- Then this works:
DELETE FROM "artists"
WHERE "name" = 'Unidentified artist';
-- Automatically deletes from "created" table too

-- ============================================
-- DELETE WITH ON DELETE OPTIONS
-- ============================================

-- ON DELETE RESTRICT: Prevents deletion if foreign keys exist (default)
-- ON DELETE NO ACTION: Same as RESTRICT
-- ON DELETE SET NULL: Sets foreign keys to NULL when parent deleted
-- ON DELETE SET DEFAULT: Sets foreign keys to default value
-- ON DELETE CASCADE: Deletes child records when parent deleted

-- Example 19: CASCADE deletion
-- Schema has: ON DELETE CASCADE
DELETE FROM "authors"
WHERE "id" = 5;
-- Also deletes from "authored" table automatically

-- Example 20: SET NULL deletion
-- Schema has: ON DELETE SET NULL
DELETE FROM "departments"
WHERE "id" = 10;
-- Sets "department_id" to NULL in "employees" table

-- ============================================
-- DELETE WITH RETURNING (SQLite 3.35+)
-- ============================================

-- Example 21: Return deleted rows
DELETE FROM "users"
WHERE "status" = 'banned'
RETURNING *;

-- Explanation: Shows the deleted rows before they're removed

-- Example 22: Return specific columns
DELETE FROM "products"
WHERE "discontinued" = 1
RETURNING "id", "name", "price";

-- Example 23: Log deletions
DELETE FROM "old_records"
WHERE "created_at" < DATE('now', '-5 years')
RETURNING "id", "created_at";

-- ============================================
-- SOFT DELETE PATTERN (Better than DELETE)
-- ============================================

-- Instead of DELETE, mark as deleted:

-- Step 1: Add deleted column
ALTER TABLE "collections"
ADD COLUMN "deleted" INTEGER DEFAULT 0;

-- Step 2: "Delete" by updating
UPDATE "collections"
SET "deleted" = 1
WHERE "title" = 'Farmers working at dawn';

-- Step 3: Query only non-deleted rows
SELECT * FROM "collections"
WHERE "deleted" = 0;

-- Advantages of soft delete:
-- ✅ Can recover deleted data
-- ✅ Maintains audit trail
-- ✅ Preserves referential integrity
-- ✅ Allows analysis of deleted vs active data

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: Delete expired sessions
DELETE FROM "sessions"
WHERE "expires_at" < DATETIME('now');

-- Use Case 2: Clean up temporary files
DELETE FROM "temp_files"
WHERE "created_at" < DATETIME('now', '-24 hours');

-- Use Case 3: Remove spam comments
DELETE FROM "comments"
WHERE "is_spam" = 1
  AND "created_at" < DATE('now', '-30 days');

-- Use Case 4: Delete unverified accounts
DELETE FROM "users"
WHERE "email_verified" = 0
  AND "created_at" < DATETIME('now', '-7 days');

-- Use Case 5: Clear old logs
DELETE FROM "error_logs"
WHERE "logged_at" < DATE('now', '-90 days');

-- Use Case 6: Remove cancelled orders
DELETE FROM "orders"
WHERE "status" = 'cancelled'
  AND "cancelled_at" < DATE('now', '-1 year');

-- Use Case 7: Clean up test data
DELETE FROM "users"
WHERE "email" LIKE '%@test.com';

-- ============================================
-- DELETE WITH TRANSACTIONS
-- ============================================

-- Example 24: Atomic deletion (all or nothing)
BEGIN TRANSACTION;

DELETE FROM "order_items"
WHERE "order_id" = 100;

DELETE FROM "orders"
WHERE "id" = 100;

COMMIT;

-- If any DELETE fails, all are rolled back

-- Example 25: Conditional transaction
BEGIN TRANSACTION;

DELETE FROM "products"
WHERE "id" = 50;

-- Check if deletion affected expected number of rows
-- If not, rollback:
ROLLBACK;
-- If good, commit:
COMMIT;

-- ============================================
-- DELETE VS TRUNCATE
-- ============================================

-- SQLite doesn't have TRUNCATE, but concept is:
-- DELETE: Removes rows one by one, slower, can use WHERE
DELETE FROM "table" WHERE "condition";

-- TRUNCATE equivalent (faster, but removes ALL rows):
DELETE FROM "table";  -- In SQLite, this is optimized when no WHERE

-- Or use:
DROP TABLE "table";
CREATE TABLE "table" (...);

-- ============================================
-- SAFETY AND BEST PRACTICES
-- ============================================

-- ✅ DO: Always use WHERE clause (unless deleting all rows intentionally)
DELETE FROM "users" WHERE "id" = 123;

-- ❌ DON'T: Forget WHERE clause by accident
-- DELETE FROM "users";  -- Deletes EVERYTHING!

-- ✅ DO: Test with SELECT first
SELECT * FROM "orders" WHERE "status" = 'cancelled';
-- Then delete:
DELETE FROM "orders" WHERE "status" = 'cancelled';

-- ✅ DO: Use transactions for important deletions
BEGIN TRANSACTION;
DELETE FROM "critical_data" WHERE "id" = 1;
-- Verify before committing
ROLLBACK;  -- Or COMMIT if correct

-- ✅ DO: Backup before bulk deletions
CREATE TABLE "users_backup" AS SELECT * FROM "users";
-- Then perform deletion

-- ✅ DO: Consider soft deletes instead of hard deletes
UPDATE "records" SET "deleted" = 1 WHERE "id" = 5;

-- ✅ DO: Log important deletions
INSERT INTO "deletion_log" ("table_name", "record_id", "deleted_at")
VALUES ('users', 123, DATETIME('now'));

DELETE FROM "users" WHERE "id" = 123;

-- ============================================
-- DEBUGGING AND VERIFICATION
-- ============================================

-- Step 1: Count rows to be deleted
SELECT COUNT(*) FROM "products"
WHERE "discontinued" = 1;

-- Step 2: Preview records to be deleted
SELECT * FROM "products"
WHERE "discontinued" = 1
LIMIT 10;

-- Step 3: Perform deletion in transaction
BEGIN TRANSACTION;
DELETE FROM "products" WHERE "discontinued" = 1;
-- Verify count or spot check
ROLLBACK;  -- Or COMMIT if satisfied

-- Step 4: Verify deletion
SELECT COUNT(*) FROM "products"
WHERE "discontinued" = 1;
-- Should return 0

-- ============================================
-- CASCADING DELETES EXAMPLE
-- ============================================

-- Schema with cascading:
-- CREATE TABLE "orders" (
--     "id" INTEGER PRIMARY KEY,
--     "customer_id" INTEGER,
--     FOREIGN KEY("customer_id") REFERENCES "customers"("id")
--         ON DELETE CASCADE
-- );

-- Delete customer
DELETE FROM "customers" WHERE "id" = 10;
-- All orders for customer 10 are automatically deleted too!

-- ============================================
-- COMMON PATTERNS
-- ============================================

-- Pattern 1: Delete and return count
-- (Use RETURNING COUNT in application)
DELETE FROM "sessions"
WHERE "expired" = 1
RETURNING *;
-- Count rows in result

-- Pattern 2: Delete in batches (for large datasets)
DELETE FROM "logs"
WHERE "id" IN (
    SELECT "id" FROM "logs"
    WHERE "old" = 1
    LIMIT 1000
);
-- Run multiple times until no rows left

-- Pattern 3: Delete with JOIN logic
DELETE FROM "user_preferences"
WHERE "user_id" IN (
    SELECT "id" FROM "users"
    WHERE "deleted" = 1
);

-- Pattern 4: Clean up orphaned records
DELETE FROM "profile_images"
WHERE "user_id" NOT IN (SELECT "id" FROM "users");

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. DELETE removes rows permanently (unless in transaction)
-- 2. Always use WHERE clause (unless deleting all rows intentionally)
-- 3. Test with SELECT before running DELETE
-- 4. Use transactions for safety
-- 5. Consider soft deletes over hard deletes
-- 6. Be aware of foreign key constraints
-- 7. ON DELETE CASCADE auto-deletes child records
-- 8. RETURNING shows deleted rows (SQLite 3.35+)
-- 9. Backup important data before bulk deletions
-- 10. Cannot undo DELETE (except with ROLLBACK in transaction)

