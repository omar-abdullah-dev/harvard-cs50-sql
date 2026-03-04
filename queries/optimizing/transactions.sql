-- ============================================
-- TRANSACTIONS
-- ============================================
-- A transaction is a unit of work that must be completed entirely or not at all
-- Ensures database consistency and integrity
-- ACID properties: Atomicity, Consistency, Isolation, Durability


-- ============================================
-- BASIC TRANSACTION STRUCTURE
-- ============================================

-- Syntax:
-- BEGIN TRANSACTION;
-- ... SQL statements ...
-- COMMIT;

BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
COMMIT;


-- ============================================
-- ATOMICITY
-- ============================================
-- All operations in a transaction succeed together or fail together
-- Cannot see intermediate states

-- Example: Transfer money between accounts
BEGIN TRANSACTION;
-- Add money to Bob's account
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
-- Subtract money from Alice's account
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
COMMIT;

-- Both updates happen as one atomic operation
-- Outside observers never see Bob's balance increased without Alice's decreased


-- ============================================
-- CONSISTENCY
-- ============================================
-- Transactions maintain database constraints
-- If a constraint is violated, the transaction fails

-- Example: Attempting to create negative balance
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
-- If Alice's balance is 0, this violates CHECK constraint (balance >= 0)
COMMIT;  -- This will fail and revert all changes


-- ============================================
-- ROLLBACK
-- ============================================
-- If an error occurs, use ROLLBACK to undo all changes

-- Successful transaction:
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
COMMIT;  -- Changes are saved

-- Failed transaction:
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
-- Error detected! Constraint violation
ROLLBACK;  -- All changes are undone


-- ============================================
-- PRACTICAL EXAMPLE: BANK TRANSFER
-- ============================================

-- View current account balances
SELECT * FROM "accounts";
-- Alice (id=1): $100
-- Bob (id=2): $50

-- Transfer $10 from Alice to Bob
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
COMMIT;

-- View updated balances
SELECT * FROM "accounts";
-- Alice (id=1): $90
-- Bob (id=2): $60


-- ============================================
-- HANDLING ERRORS IN TRANSACTIONS
-- ============================================

-- Scenario: Alice tries to send $200 but only has $90
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 200 WHERE "id" = 2;
UPDATE "accounts" SET "balance" = "balance" - 200 WHERE "id" = 1;
-- Error: CHECK constraint failed: balance >= 0
ROLLBACK;

-- Check balances - unchanged!
SELECT * FROM "accounts";
-- Alice (id=1): $90 (no change)
-- Bob (id=2): $60 (no change)


-- ============================================
-- MULTIPLE OPERATIONS IN ONE TRANSACTION
-- ============================================

-- Complex transaction with multiple updates
BEGIN TRANSACTION;
-- Log the transaction
INSERT INTO "transaction_log" ("from_id", "to_id", "amount", "date")
VALUES (1, 2, 50, CURRENT_TIMESTAMP);
-- Update sender
UPDATE "accounts" SET "balance" = "balance" - 50 WHERE "id" = 1;
-- Update receiver
UPDATE "accounts" SET "balance" = "balance" + 50 WHERE "id" = 2;
COMMIT;


-- ============================================
-- TRANSACTION WITH INSERT
-- ============================================

-- Add multiple related records atomically
BEGIN TRANSACTION;
INSERT INTO "customers" ("name", "email") VALUES ('John Doe', 'john@example.com');
INSERT INTO "orders" ("customer_id", "product", "price")
VALUES (last_insert_rowid(), 'Laptop', 999.99);
COMMIT;


-- ============================================
-- TRANSACTION WITH DELETE
-- ============================================

-- Delete related records together
BEGIN TRANSACTION;
DELETE FROM "order_items" WHERE "order_id" = 5;
DELETE FROM "orders" WHERE "id" = 5;
COMMIT;


-- ============================================
-- EXCLUSIVE TRANSACTIONS
-- ============================================

-- Lock the entire database for this transaction
BEGIN EXCLUSIVE TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
COMMIT;

-- No other transactions can run simultaneously
-- Ensures complete isolation


-- ============================================
-- DEFERRED TRANSACTIONS
-- ============================================

-- Default mode - locks acquired when first read/write occurs
BEGIN DEFERRED TRANSACTION;
-- No lock yet
SELECT * FROM "accounts";
-- Shared lock acquired (allows other reads)
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 1;
-- Exclusive lock acquired (blocks other writes)
COMMIT;


-- ============================================
-- IMMEDIATE TRANSACTIONS
-- ============================================

-- Acquire lock immediately (before any SQL statements)
BEGIN IMMEDIATE TRANSACTION;
-- Reserved lock acquired immediately
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 1;
COMMIT;


-- ============================================
-- TRANSACTION ISOLATION
-- ============================================

-- Transactions run in isolation from each other
-- Prevents race conditions and inconsistent reads

-- User 1:
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" - 50 WHERE "id" = 1;
-- ... doing other work ...
COMMIT;

-- User 2 (running simultaneously):
BEGIN TRANSACTION;
-- This waits until User 1's transaction completes
SELECT "balance" FROM "accounts" WHERE "id" = 1;
COMMIT;


-- ============================================
-- DURABILITY
-- ============================================

-- Once committed, changes are permanent
-- Even if system crashes, data is not lost

BEGIN TRANSACTION;
INSERT INTO "important_data" ("value") VALUES ('Critical Information');
COMMIT;  -- Data is now safely stored on disk

-- Even if power fails after COMMIT, the data persists


-- ============================================
-- BEST PRACTICES
-- ============================================

-- 1. Keep transactions short
--    - Long transactions hold locks and block others

-- 2. Use transactions for related operations
--    - Ensure data consistency across multiple tables

-- 3. Always handle errors with ROLLBACK
--    - Prevent partial updates

-- 4. Commit or rollback promptly
--    - Don't leave transactions open

-- 5. Use appropriate transaction type
--    - DEFERRED for read-heavy operations
--    - IMMEDIATE/EXCLUSIVE for write-heavy operations

