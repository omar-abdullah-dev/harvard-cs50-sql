-- ============================================
-- UPDATE - Modifying Existing Data
-- ============================================
-- UPDATE is used to modify existing rows in a table

-- ============================================
-- BASIC UPDATE SYNTAX
-- ============================================
-- UPDATE table_name SET column = value WHERE condition;

-- Example 1: Update a single column for one row
UPDATE "collections"
SET "title" = 'Profusion of Flowers'
WHERE "accession_number" = '56.257';

-- Explanation: Changes the title for artwork with specific accession number

-- Example 2: Update multiple columns at once
UPDATE "collections"
SET
    "title" = 'New Title',
    "acquired" = '2024-01-01'
WHERE "id" = 5;

-- Explanation: Updates both title and acquisition date in one statement

-- ============================================
-- UPDATE WITH WHERE CLAUSE
-- ============================================
-- ⚠️ CRITICAL: Always use WHERE unless you want to update ALL rows!

-- Example 3: Update specific row by ID
UPDATE "users"
SET "email" = 'newemail@example.com'
WHERE "id" = 42;

-- Example 4: Update all books from a specific year
UPDATE "books"
SET "publisher" = 'Updated Publisher'
WHERE "year" = 2020;

-- Example 5: Update based on multiple conditions
UPDATE "players"
SET "status" = 'retired'
WHERE "birth_year" < 1980
  AND "last_game" < '2010-01-01';

-- ============================================
-- UPDATE ALL ROWS (USE WITH CAUTION)
-- ============================================

-- Example 6: Update ALL rows in a table (no WHERE clause)
UPDATE "products"
SET "on_sale" = 0;

-- ⚠️ Warning: This updates EVERY row in the table!
-- Always double-check before running updates without WHERE

-- ============================================
-- UPDATE WITH CALCULATIONS
-- ============================================

-- Example 7: Increase all prices by 10%
UPDATE "products"
SET "price" = "price" * 1.10;

-- Example 8: Increment a counter
UPDATE "users"
SET "login_count" = "login_count" + 1
WHERE "username" = 'john_doe';

-- Example 9: Apply discount to expensive items
UPDATE "products"
SET "price" = "price" * 0.9
WHERE "price" > 100;

-- Example 10: Calculate and store derived value
UPDATE "orders"
SET "total" = "subtotal" + "tax" + "shipping"
WHERE "total" IS NULL;

-- ============================================
-- UPDATE WITH SUBQUERIES
-- ============================================

-- Example 11: Update using data from another table
UPDATE "created"
SET "artist_id" = (
    SELECT "id"
    FROM "artists"
    WHERE "name" = 'Li Yin'
)
WHERE "collection_id" = (
    SELECT "id"
    FROM "collections"
    WHERE "title" = 'Farmers working at dawn'
);

-- Explanation: Changes the artist association for a specific artwork

-- Example 12: Update based on aggregate from another table
UPDATE "customers"
SET "total_orders" = (
    SELECT COUNT(*)
    FROM "orders"
    WHERE "orders"."customer_id" = "customers"."id"
);

-- Example 13: Update using JOIN logic
UPDATE "books"
SET "category" = 'Bestseller'
WHERE "id" IN (
    SELECT "book_id"
    FROM "sales"
    GROUP BY "book_id"
    HAVING SUM("quantity") > 10000
);

-- ============================================
-- UPDATE WITH CASE STATEMENTS
-- ============================================

-- Example 14: Conditional updates with CASE
UPDATE "students"
SET "grade_letter" = CASE
    WHEN "grade_numeric" >= 90 THEN 'A'
    WHEN "grade_numeric" >= 80 THEN 'B'
    WHEN "grade_numeric" >= 70 THEN 'C'
    WHEN "grade_numeric" >= 60 THEN 'D'
    ELSE 'F'
END;

-- Example 15: Update with multiple conditions
UPDATE "products"
SET "discount" = CASE
    WHEN "category" = 'Electronics' AND "price" > 500 THEN 0.15
    WHEN "category" = 'Clothing' THEN 0.20
    WHEN "price" > 1000 THEN 0.10
    ELSE 0.05
END;

-- ============================================
-- UPDATE WITH LIMITS (SQLite specific)
-- ============================================

-- Example 16: Update only first N rows
UPDATE "logs"
SET "processed" = 1
WHERE "processed" = 0
ORDER BY "created_at"
LIMIT 100;

-- Explanation: Processes oldest 100 unprocessed log entries

-- ============================================
-- UPDATE WITH DATE/TIME FUNCTIONS
-- ============================================

-- Example 17: Update timestamp to current time
UPDATE "users"
SET "last_login" = DATETIME('now')
WHERE "username" = 'john_doe';

-- Example 18: Update date fields
UPDATE "events"
SET "end_date" = DATE("start_date", '+7 days')
WHERE "duration_days" = 7;

-- Example 19: Set expiration date
UPDATE "subscriptions"
SET "expires_at" = DATETIME('now', '+1 year')
WHERE "status" = 'active';

-- ============================================
-- UPDATE WITH STRING FUNCTIONS
-- ============================================

-- Example 20: Convert text to uppercase
UPDATE "products"
SET "name" = UPPER("name")
WHERE "category" = 'ELECTRONICS';

-- Example 21: Trim whitespace
UPDATE "users"
SET "email" = TRIM("email");

-- Example 22: Concatenate strings
UPDATE "customers"
SET "full_name" = "first_name" || ' ' || "last_name"
WHERE "full_name" IS NULL;

-- Example 23: Replace text
UPDATE "posts"
SET "content" = REPLACE("content", 'old_url', 'new_url');

-- ============================================
-- UPDATE WITH NULL HANDLING
-- ============================================

-- Example 24: Set NULL values to default
UPDATE "products"
SET "description" = 'No description available'
WHERE "description" IS NULL;

-- Example 25: Clear values (set to NULL)
UPDATE "orders"
SET "notes" = NULL
WHERE "notes" = '';

-- Example 26: Update only NULL values
UPDATE "users"
SET "country" = 'Unknown'
WHERE "country" IS NULL;

-- ============================================
-- UPDATE WITH RETURNING (SQLite 3.35+)
-- ============================================

-- Example 27: Return updated values
UPDATE "users"
SET "email" = 'updated@example.com'
WHERE "id" = 10
RETURNING "id", "username", "email";

-- Explanation: Returns the updated row data

-- Example 28: Track what was changed
UPDATE "products"
SET "price" = "price" * 1.05
WHERE "category" = 'Electronics'
RETURNING "id", "name", "price";

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: User Profile Update
UPDATE "users"
SET
    "first_name" = 'John',
    "last_name" = 'Smith',
    "updated_at" = DATETIME('now')
WHERE "id" = 123;

-- Use Case 2: Order Status Change
UPDATE "orders"
SET
    "status" = 'shipped',
    "shipped_date" = DATE('now'),
    "tracking_number" = 'TRACK123456'
WHERE "order_id" = 5001;

-- Use Case 3: Inventory Adjustment
UPDATE "inventory"
SET "quantity" = "quantity" - 5
WHERE "product_id" = 42
  AND "quantity" >= 5;

-- Use Case 4: Password Reset
UPDATE "users"
SET
    "password_hash" = 'new_hashed_password',
    "password_changed_at" = DATETIME('now'),
    "reset_token" = NULL
WHERE "reset_token" = 'abc123xyz';

-- Use Case 5: Bulk Status Update
UPDATE "accounts"
SET "status" = 'inactive'
WHERE "last_login" < DATE('now', '-365 days');

-- Use Case 6: Price Adjustment
UPDATE "products"
SET
    "old_price" = "price",
    "price" = "price" * 0.85,
    "sale_start" = DATE('now')
WHERE "category" = 'Seasonal';

-- ============================================
-- UPDATE WITH TRANSACTIONS
-- ============================================

-- Example 29: Atomic updates
BEGIN TRANSACTION;

UPDATE "accounts"
SET "balance" = "balance" - 100
WHERE "account_id" = 'A001';

UPDATE "accounts"
SET "balance" = "balance" + 100
WHERE "account_id" = 'A002';

COMMIT;

-- If any UPDATE fails, both are rolled back

-- ============================================
-- COMMON PATTERNS
-- ============================================

-- Pattern 1: Toggle boolean values
UPDATE "settings"
SET "enabled" = NOT "enabled"
WHERE "key" = 'notifications';

-- Pattern 2: Increment version number
UPDATE "documents"
SET "version" = "version" + 1
WHERE "id" = 100;

-- Pattern 3: Update with current user (application context)
UPDATE "posts"
SET
    "content" = 'New content',
    "updated_by" = 'current_user_id',
    "updated_at" = DATETIME('now')
WHERE "id" = 50;

-- Pattern 4: Batch update with IN clause
UPDATE "products"
SET "featured" = 1
WHERE "id" IN (10, 20, 30, 40, 50);

-- Pattern 5: Conditional update based on existing value
UPDATE "users"
SET "subscription_tier" = 'premium'
WHERE "subscription_tier" = 'basic'
  AND "total_spent" > 1000;

-- ============================================
-- SAFETY AND BEST PRACTICES
-- ============================================

-- ✅ DO: Always use WHERE clause (unless you really want to update all rows)
UPDATE "table" SET "column" = 'value' WHERE "id" = 1;

-- ❌ DON'T: Update without WHERE by accident
-- UPDATE "table" SET "column" = 'value';  -- Updates ALL rows!

-- ✅ DO: Test with SELECT first
SELECT * FROM "users" WHERE "status" = 'pending';
-- Then update:
UPDATE "users" SET "status" = 'active' WHERE "status" = 'pending';

-- ✅ DO: Use transactions for critical updates
BEGIN TRANSACTION;
UPDATE "table1" SET "col" = 'val' WHERE "id" = 1;
UPDATE "table2" SET "col" = 'val' WHERE "id" = 1;
COMMIT;

-- ✅ DO: Backup data before bulk updates
CREATE TABLE "users_backup" AS SELECT * FROM "users";
-- Then perform updates

-- ✅ DO: Update timestamps for audit trails
UPDATE "records"
SET
    "data" = 'new_value',
    "updated_at" = DATETIME('now'),
    "updated_by" = 'user_id'
WHERE "id" = 100;

-- ============================================
-- DEBUGGING AND VERIFICATION
-- ============================================

-- Step 1: Preview what will be updated
SELECT * FROM "products"
WHERE "category" = 'Electronics' AND "price" < 50;

-- Step 2: Perform the update
UPDATE "products"
SET "discount" = 0.20
WHERE "category" = 'Electronics' AND "price" < 50;

-- Step 3: Verify the update
SELECT * FROM "products"
WHERE "category" = 'Electronics' AND "price" < 50;

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. UPDATE modifies existing rows in a table
-- 2. Always use WHERE clause to target specific rows
-- 3. Can update multiple columns in one statement
-- 4. Can use calculations and functions in SET clause
-- 5. Subqueries allow updates based on other table data
-- 6. CASE statements enable conditional updates
-- 7. Use transactions for related updates
-- 8. Test with SELECT before running UPDATE
-- 9. Keep audit trails with timestamps and user tracking
-- 10. RETURNING clause shows updated data (SQLite 3.35+)

