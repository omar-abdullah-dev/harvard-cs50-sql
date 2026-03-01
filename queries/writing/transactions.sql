-- ============================================
-- TRANSACTIONS - Atomic Database Operations
-- ============================================
-- Transactions ensure a group of operations either ALL succeed or ALL fail
-- ACID Properties: Atomicity, Consistency, Isolation, Durability

-- ============================================
-- BASIC TRANSACTION SYNTAX
-- ============================================

-- Transaction structure:
BEGIN TRANSACTION;
    -- SQL statements here
COMMIT;  -- Save changes

-- Or rollback:
BEGIN TRANSACTION;
    -- SQL statements here
ROLLBACK;  -- Undo changes

-- ============================================
-- SIMPLE TRANSACTION EXAMPLE
-- ============================================

-- Example 1: Transfer money between accounts
BEGIN TRANSACTION;

    -- Debit from account A
    UPDATE "accounts"
    SET "balance" = "balance" - 100
    WHERE "account_number" = 'A001';

    -- Credit to account B
    UPDATE "accounts"
    SET "balance" = "balance" + 100
    WHERE "account_number" = 'A002';

COMMIT;

-- If either UPDATE fails, both are rolled back
-- Ensures money isn't lost or created from nothing

-- ============================================
-- ROLLBACK ON ERROR
-- ============================================

-- Example 2: Conditional rollback
BEGIN TRANSACTION;

    INSERT INTO "orders" ("customer_id", "total")
    VALUES (123, 99.99);

    -- Check if customer has credit
    -- If not, rollback:
    ROLLBACK;

    -- If yes, commit:
    COMMIT;

-- ============================================
-- SAVEPOINTS
-- ============================================
-- Savepoints allow partial rollback within a transaction

-- Example 3: Using savepoints
BEGIN TRANSACTION;

    INSERT INTO "users" ("username", "email")
    VALUES ('user1', 'user1@example.com');

    SAVEPOINT after_user;

    INSERT INTO "profiles" ("user_id", "bio")
    VALUES (1, 'User bio');

    -- If profile insert fails, rollback to savepoint
    ROLLBACK TO after_user;

    -- User insert is preserved, profile insert is undone

COMMIT;

-- Example 4: Multiple savepoints
BEGIN TRANSACTION;

    UPDATE "inventory" SET "quantity" = "quantity" - 10 WHERE "product_id" = 1;
    SAVEPOINT sp1;

    UPDATE "inventory" SET "quantity" = "quantity" - 5 WHERE "product_id" = 2;
    SAVEPOINT sp2;

    UPDATE "inventory" SET "quantity" = "quantity" - 3 WHERE "product_id" = 3;

    -- Rollback to sp2 (undoes product 3, keeps 1 and 2)
    ROLLBACK TO sp2;

    -- Or rollback to sp1 (undoes 2 and 3, keeps 1)
    -- ROLLBACK TO sp1;

COMMIT;

-- ============================================
-- TRANSACTION ISOLATION LEVELS
-- ============================================
-- SQLite supports different isolation levels

-- Default: SERIALIZABLE (highest isolation)
PRAGMA read_uncommitted = 0;  -- Default

-- Read uncommitted (lowest isolation, allows dirty reads)
PRAGMA read_uncommitted = 1;

-- Example 5: Explicit isolation
BEGIN DEFERRED TRANSACTION;  -- Lock acquired on first read/write
-- operations
COMMIT;

BEGIN IMMEDIATE TRANSACTION;  -- Lock acquired immediately
-- operations
COMMIT;

BEGIN EXCLUSIVE TRANSACTION;  -- Exclusive lock immediately
-- operations
COMMIT;

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: Order Processing
BEGIN TRANSACTION;

    -- Create order
    INSERT INTO "orders" ("customer_id", "total", "status")
    VALUES (100, 150.00, 'pending');

    -- Get order ID
    -- last_insert_rowid() in application

    -- Add order items
    INSERT INTO "order_items" ("order_id", "product_id", "quantity", "price")
    VALUES
        (last_insert_rowid(), 1, 2, 25.00),
        (last_insert_rowid(), 3, 1, 100.00);

    -- Update inventory
    UPDATE "inventory"
    SET "quantity" = "quantity" - 2
    WHERE "product_id" = 1;

    UPDATE "inventory"
    SET "quantity" = "quantity" - 1
    WHERE "product_id" = 3;

COMMIT;

-- Use Case 2: User Registration with Profile
BEGIN TRANSACTION;

    -- Create user account
    INSERT INTO "users" ("username", "email", "password_hash")
    VALUES ('john_doe', 'john@example.com', 'hashed_pass');

    -- Create user profile
    INSERT INTO "profiles" ("user_id", "first_name", "last_name")
    VALUES (last_insert_rowid(), 'John', 'Doe');

    -- Create default preferences
    INSERT INTO "preferences" ("user_id", "theme", "notifications")
    VALUES (last_insert_rowid(), 'light', 1);

COMMIT;

-- Use Case 3: Batch Updates
BEGIN TRANSACTION;

    -- Update prices
    UPDATE "products"
    SET "price" = "price" * 1.10
    WHERE "category" = 'Electronics';

    -- Log the change
    INSERT INTO "price_changes" ("category", "change_percent", "changed_at")
    VALUES ('Electronics', 10, DATETIME('now'));

    -- Update statistics
    UPDATE "statistics"
    SET "last_price_update" = DATETIME('now');

COMMIT;

-- Use Case 4: Deleting with Dependencies
BEGIN TRANSACTION;

    -- Delete user's data in correct order
    DELETE FROM "sessions" WHERE "user_id" = 42;
    DELETE FROM "posts" WHERE "user_id" = 42;
    DELETE FROM "comments" WHERE "user_id" = 42;
    DELETE FROM "likes" WHERE "user_id" = 42;
    DELETE FROM "follows" WHERE "follower_id" = 42 OR "following_id" = 42;
    DELETE FROM "users" WHERE "id" = 42;

COMMIT;

-- ============================================
-- ERROR HANDLING PATTERNS
-- ============================================

-- Example 6: Try-catch pattern (in application code)
BEGIN TRANSACTION;
    -- Operations that might fail
    INSERT INTO "table1" VALUES (...);
    UPDATE "table2" SET ... WHERE ...;
    DELETE FROM "table3" WHERE ...;
COMMIT;

-- In application:
-- try {
--     executeTransaction();
-- } catch (error) {
--     ROLLBACK;
--     log(error);
-- }

-- ============================================
-- NESTED TRANSACTIONS (Using Savepoints)
-- ============================================

-- Example 7: Simulating nested transactions
BEGIN TRANSACTION;

    INSERT INTO "logs" ("message") VALUES ('Starting process');

    SAVEPOINT nested_1;

        INSERT INTO "temp_data" VALUES (...);

        SAVEPOINT nested_2;

            UPDATE "table" SET ...;

        -- Can rollback to nested_2
        ROLLBACK TO nested_2;

    -- Can rollback to nested_1
    -- ROLLBACK TO nested_1;

COMMIT;

-- ============================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================

-- Example 8: Bulk operations in transaction (faster)
-- Without transaction (slow - commits each insert):
INSERT INTO "products" VALUES (1, 'Product 1', 10.00);
INSERT INTO "products" VALUES (2, 'Product 2', 20.00);
-- ... 1000 more inserts ...

-- With transaction (fast - commits once):
BEGIN TRANSACTION;
    INSERT INTO "products" VALUES (1, 'Product 1', 10.00);
    INSERT INTO "products" VALUES (2, 'Product 2', 20.00);
    -- ... 1000 more inserts ...
COMMIT;

-- Example 9: Batch updates in transaction
BEGIN TRANSACTION;
    UPDATE "users" SET "verified" = 1 WHERE "email_confirmed" = 1;
    UPDATE "users" SET "last_updated" = DATETIME('now');
    -- Many more updates...
COMMIT;

-- ============================================
-- TRANSACTION STATES
-- ============================================

-- No transaction: Auto-commit mode (each statement commits immediately)
INSERT INTO "table" VALUES (...);  -- Auto-commits

-- Active transaction: Changes are pending
BEGIN TRANSACTION;
INSERT INTO "table" VALUES (...);  -- Not committed yet

-- Committed: Changes are permanent
COMMIT;

-- Rolled back: Changes are discarded
ROLLBACK;

-- ============================================
-- CHECKING TRANSACTION STATE
-- ============================================

-- SQLite command to check if in transaction:
-- PRAGMA transaction;
-- Returns: read, write, or empty (no transaction)

-- ============================================
-- EXPLICIT VS IMPLICIT TRANSACTIONS
-- ============================================

-- Implicit (auto-commit):
UPDATE "users" SET "email" = 'new@email.com' WHERE "id" = 1;
-- Automatically wrapped in transaction and committed

-- Explicit:
BEGIN TRANSACTION;
    UPDATE "users" SET "email" = 'new@email.com' WHERE "id" = 1;
    UPDATE "users" SET "updated_at" = DATETIME('now') WHERE "id" = 1;
COMMIT;

-- ============================================
-- LOCKING AND CONCURRENCY
-- ============================================

-- Example 10: Deferred transaction (default)
BEGIN TRANSACTION;
-- No lock yet
SELECT * FROM "table";  -- Lock acquired here
UPDATE "table" SET ...;
COMMIT;

-- Example 11: Immediate transaction
BEGIN IMMEDIATE TRANSACTION;
-- Reserved lock acquired immediately
-- Other connections can read but not write
UPDATE "table" SET ...;
COMMIT;

-- Example 12: Exclusive transaction
BEGIN EXCLUSIVE TRANSACTION;
-- Exclusive lock acquired immediately
-- No other connections can read or write
UPDATE "table" SET ...;
COMMIT;

-- ============================================
-- TRANSACTION BEST PRACTICES
-- ============================================

-- ✅ DO: Keep transactions short
BEGIN TRANSACTION;
    -- Quick operations only
    UPDATE "table" SET "field" = 'value' WHERE "id" = 1;
COMMIT;

-- ❌ DON'T: Keep transactions open too long
-- BEGIN TRANSACTION;
--     -- Long-running operations
--     -- Complex calculations
--     -- External API calls (NO!)
-- COMMIT;

-- ✅ DO: Use transactions for related operations
BEGIN TRANSACTION;
    INSERT INTO "orders" ...;
    INSERT INTO "order_items" ...;
    UPDATE "inventory" ...;
COMMIT;

-- ✅ DO: Handle errors properly
-- In application:
-- begin()
-- try {
--     operation1()
--     operation2()
--     commit()
-- } catch {
--     rollback()
-- }

-- ✅ DO: Use savepoints for partial rollback
BEGIN TRANSACTION;
    INSERT INTO "main_table" ...;
    SAVEPOINT sp1;
    INSERT INTO "optional_table" ...;  -- Might fail
    -- If fails: ROLLBACK TO sp1
COMMIT;

-- ❌ DON'T: Nest BEGIN/COMMIT (SQLite doesn't support it)
-- BEGIN TRANSACTION;
--     BEGIN TRANSACTION;  -- Error!

-- ✅ DO: Use bulk operations
BEGIN TRANSACTION;
    INSERT INTO "table" VALUES (1, 'a'), (2, 'b'), (3, 'c');
COMMIT;

-- ============================================
-- TRANSACTION LIFECYCLE EXAMPLE
-- ============================================

-- Complete example with error handling
BEGIN TRANSACTION;

    -- Step 1: Validate
    SELECT COUNT(*) FROM "users" WHERE "id" = 100;
    -- If count = 0, ROLLBACK;

    SAVEPOINT after_validation;

    -- Step 2: Update primary data
    UPDATE "users"
    SET "status" = 'active'
    WHERE "id" = 100;

    SAVEPOINT after_main_update;

    -- Step 3: Update related data (might fail)
    UPDATE "user_stats"
    SET "last_active" = DATETIME('now')
    WHERE "user_id" = 100;
    -- If fails, ROLLBACK TO after_main_update;

    -- Step 4: Log the operation
    INSERT INTO "audit_log" ("action", "user_id", "timestamp")
    VALUES ('user_activated', 100, DATETIME('now'));

COMMIT;

-- ============================================
-- COMMON PATTERNS
-- ============================================

-- Pattern 1: All or nothing
BEGIN TRANSACTION;
    DELETE FROM "cache" WHERE "expired" = 1;
    INSERT INTO "archive" SELECT * FROM "cache" WHERE "expired" = 1;
COMMIT;

-- Pattern 2: Atomic counter
BEGIN TRANSACTION;
    UPDATE "counters" SET "value" = "value" + 1 WHERE "name" = 'page_views';
COMMIT;

-- Pattern 3: Safe migration
BEGIN TRANSACTION;
    -- Create new table
    CREATE TABLE "users_new" (...);
    -- Copy data
    INSERT INTO "users_new" SELECT * FROM "users";
    -- Drop old table
    DROP TABLE "users";
    -- Rename new table
    ALTER TABLE "users_new" RENAME TO "users";
COMMIT;

-- Pattern 4: Batch processing with checkpoints
BEGIN TRANSACTION;
    -- Process batch
    UPDATE "queue" SET "processed" = 1 WHERE "id" IN (1, 2, 3);
COMMIT;

BEGIN TRANSACTION;
    -- Process next batch
    UPDATE "queue" SET "processed" = 1 WHERE "id" IN (4, 5, 6);
COMMIT;

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. Transactions ensure all-or-nothing execution
-- 2. BEGIN starts a transaction, COMMIT saves changes
-- 3. ROLLBACK undoes changes in current transaction
-- 4. Savepoints allow partial rollback
-- 5. Keep transactions short for better performance
-- 6. Use transactions for related operations
-- 7. Handle errors with proper rollback
-- 8. Transactions improve bulk operation performance
-- 9. SQLite has DEFERRED, IMMEDIATE, and EXCLUSIVE modes
-- 10. ACID properties: Atomicity, Consistency, Isolation, Durability

