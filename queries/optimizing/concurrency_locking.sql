-- ============================================
-- CONCURRENCY AND LOCKING
-- ============================================
-- Concurrency allows multiple users/queries to access the database simultaneously
-- Locking mechanisms prevent conflicts and ensure data consistency
-- Understanding locks is crucial for multi-user database applications


-- ============================================
-- LOCK STATES IN SQLITE
-- ============================================

-- SQLite has several lock states:
-- 1. UNLOCKED: No users accessing the database
-- 2. SHARED: Multiple users can read simultaneously
-- 3. RESERVED: One user preparing to write (others can still read)
-- 4. PENDING: Waiting for readers to finish before writing
-- 5. EXCLUSIVE: One user writing (no other access allowed)


-- ============================================
-- SHARED LOCKS (Reading)
-- ============================================

-- Multiple transactions can read simultaneously
-- Each gets a SHARED lock

-- User 1 (reading):
BEGIN TRANSACTION;
SELECT * FROM "accounts";  -- Gets SHARED lock
-- Other users can also read
COMMIT;

-- User 2 (reading simultaneously):
BEGIN TRANSACTION;
SELECT * FROM "accounts";  -- Gets another SHARED lock (allowed)
COMMIT;

-- Both can read at the same time - no conflict


-- ============================================
-- EXCLUSIVE LOCKS (Writing)
-- ============================================

-- Only ONE transaction can write at a time
-- Writing requires an EXCLUSIVE lock

-- User 1 (writing):
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 1;
-- Gets EXCLUSIVE lock - blocks ALL other access
COMMIT;

-- User 2 (trying to read or write):
BEGIN TRANSACTION;
SELECT * FROM "accounts";  -- BLOCKED until User 1 commits
COMMIT;


-- ============================================
-- RACE CONDITIONS
-- ============================================

-- A race condition occurs when multiple transactions access the same data
-- Can lead to inconsistent results without proper locking

-- EXAMPLE: Two users trying to book the same seat

-- User 1:
BEGIN TRANSACTION;
-- Check if seat is available
SELECT "available" FROM "seats" WHERE "id" = 10;  -- Returns TRUE
-- Book the seat
UPDATE "seats" SET "available" = FALSE WHERE "id" = 10;
COMMIT;

-- User 2 (running at the same time):
BEGIN TRANSACTION;
-- Check if seat is available
SELECT "available" FROM "seats" WHERE "id" = 10;  -- Also returns TRUE!
-- Book the same seat
UPDATE "seats" SET "available" = FALSE WHERE "id" = 10;
COMMIT;

-- PROBLEM: Both users think they booked the seat!


-- ============================================
-- PREVENTING RACE CONDITIONS WITH ISOLATION
-- ============================================

-- Transactions run sequentially, not simultaneously
-- SQLite ensures isolation through locking

-- User 1:
BEGIN TRANSACTION;
SELECT "available" FROM "seats" WHERE "id" = 10;
UPDATE "seats" SET "available" = FALSE WHERE "id" = 10;
COMMIT;

-- User 2:
BEGIN TRANSACTION;
-- This waits until User 1 completes
SELECT "available" FROM "seats" WHERE "id" = 10;  -- Returns FALSE
-- Seat already taken, cannot book
COMMIT;


-- ============================================
-- EXCLUSIVE TRANSACTION EXAMPLE
-- ============================================

-- Force exclusive lock from the start
BEGIN EXCLUSIVE TRANSACTION;
SELECT * FROM "accounts";
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 1;
COMMIT;

-- No other users can access the database during this transaction
-- Guarantees no interference


-- ============================================
-- DETECTING LOCKED DATABASE
-- ============================================

-- When database is locked, you get an error:
-- "Error: database is locked"

-- Example scenario:
-- Terminal 1:
BEGIN EXCLUSIVE TRANSACTION;
-- Database is now locked
-- ... doing work ...

-- Terminal 2 (trying to access):
SELECT * FROM "accounts";
-- Error: database is locked

-- Terminal 1:
COMMIT;  -- Releases lock

-- Terminal 2:
SELECT * FROM "accounts";
-- Now works!


-- ============================================
-- WAIT FOR LOCK WITH TIMEOUT
-- ============================================

-- Set timeout to wait for locks to be released
PRAGMA busy_timeout = 5000;  -- Wait up to 5 seconds

-- Now if database is locked, query waits instead of failing immediately
BEGIN TRANSACTION;
SELECT * FROM "accounts";  -- Waits up to 5 seconds for lock
COMMIT;


-- ============================================
-- BANK ROBBERY ATTACK EXAMPLE
-- ============================================

-- Without proper isolation, attackers can exploit race conditions

-- Attacker with two accounts trying to withdraw same money twice:

-- Account 1 (checking balance):
BEGIN TRANSACTION;
SELECT "balance" FROM "accounts" WHERE "id" = 1;  -- Returns $100
-- Withdraw $100
UPDATE "accounts" SET "balance" = "balance" - 100 WHERE "id" = 1;
COMMIT;

-- Account 2 (simultaneously checking same balance):
BEGIN TRANSACTION;
SELECT "balance" FROM "accounts" WHERE "id" = 1;  -- Also sees $100
-- Withdraw $100 again
UPDATE "accounts" SET "balance" = "balance" - 100 WHERE "id" = 1;
COMMIT;

-- PROBLEM: Withdrew $200 from account with only $100!

-- SOLUTION: Transactions run in isolation (sequentially)
-- Second transaction sees updated balance of $0


-- ============================================
-- PREVENTING CONFLICTS IN MULTI-USER APPS
-- ============================================

-- Scenario: E-commerce inventory management

-- User 1 buying last item:
BEGIN TRANSACTION;
SELECT "quantity" FROM "products" WHERE "id" = 5;  -- Returns 1
UPDATE "products" SET "quantity" = "quantity" - 1 WHERE "id" = 5;
COMMIT;

-- User 2 trying to buy same item:
BEGIN TRANSACTION;
-- Waits for User 1 to complete
SELECT "quantity" FROM "products" WHERE "id" = 5;  -- Returns 0
-- Cannot buy - out of stock
ROLLBACK;


-- ============================================
-- IMMEDIATE TRANSACTION FOR HIGH PRIORITY
-- ============================================

-- Use IMMEDIATE to acquire lock quickly
BEGIN IMMEDIATE TRANSACTION;
-- Reserved lock acquired immediately
-- Prevents other IMMEDIATE/EXCLUSIVE transactions
UPDATE "critical_data" SET "value" = 100 WHERE "id" = 1;
COMMIT;


-- ============================================
-- DEADLOCK SCENARIO
-- ============================================

-- Deadlock: Two transactions waiting for each other

-- Transaction 1:
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" - 10 WHERE "id" = 1;
-- Waiting for lock on row 2...
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 2;
COMMIT;

-- Transaction 2:
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" - 5 WHERE "id" = 2;
-- Waiting for lock on row 1...
UPDATE "accounts" SET "balance" = "balance" + 5 WHERE "id" = 1;
COMMIT;

-- Both transactions wait forever!
-- Solution: SQLite detects and resolves deadlocks automatically


-- ============================================
-- LOCK GRANULARITY
-- ============================================

-- SQLite locks at the DATABASE level (not row or table level)
-- This means:
-- - SHARED lock: entire database can be read by multiple users
-- - EXCLUSIVE lock: entire database is locked for writing

-- Other databases (PostgreSQL, MySQL) support finer-grained locking:
-- - Row-level locks
-- - Table-level locks
-- - Page-level locks


-- ============================================
-- BEST PRACTICES FOR CONCURRENCY
-- ============================================

-- 1. Keep transactions SHORT
--    - Long transactions hold locks longer
--    - Blocks other users

-- 2. Use appropriate transaction type
--    - DEFERRED: Read-heavy workloads
--    - IMMEDIATE: Write operations that can wait
--    - EXCLUSIVE: Critical operations requiring full isolation

-- 3. Handle "database is locked" errors gracefully
--    - Retry after a short delay
--    - Use busy_timeout

-- 4. Avoid long-running operations in transactions
--    - Don't do complex calculations inside transactions
--    - Prepare data first, then transact

-- 5. Read then write pattern
--    - Read outside transaction
--    - Write inside transaction
--    - Minimizes lock duration

-- 6. Test concurrent scenarios
--    - Simulate multiple users
--    - Verify race conditions are prevented

