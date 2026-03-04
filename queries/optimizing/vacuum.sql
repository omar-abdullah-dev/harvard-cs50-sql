-- ============================================
-- VACUUM COMMAND
-- ============================================
-- VACUUM reclaims unused space from deleted data and dropped indexes
-- In SQLite, deleted data isn't immediately removed - it's just marked as available
-- VACUUM actually frees up that space and optimizes the database file


-- ============================================
-- BASIC VACUUM
-- ============================================

-- Syntax: Simply run VACUUM
VACUUM;

-- This command:
-- 1. Finds all deleted/unused space in the database
-- 2. Reorganizes the database to remove that space
-- 3. Optimizes the database file structure
-- 4. May take several seconds for large databases


-- ============================================
-- WHEN TO USE VACUUM
-- ============================================

-- Use VACUUM after:

-- 1. Dropping indexes
DROP INDEX "title_index";
DROP INDEX "person_index";
VACUUM;  -- Reclaim space from dropped indexes

-- 2. Deleting large amounts of data
DELETE FROM "movies" WHERE "year" < 1950;
VACUUM;  -- Reclaim space from deleted rows

-- 3. Updating many rows
UPDATE "movies" SET "title" = UPPER("title");
VACUUM;  -- Optimize after bulk updates

-- 4. Regular maintenance (periodic cleanup)
VACUUM;  -- Run weekly/monthly depending on database activity


-- ============================================
-- CHECKING DATABASE SIZE
-- ============================================

-- Before VACUUM:
-- Use terminal command: du -b database.db (Unix)
-- Or: (Get-Item database.db).length (PowerShell)

-- Example workflow:
-- 1. Check size: du -b movies.db
--    Output: 158,000,000 bytes (158 MB)

-- 2. Drop an index
DROP INDEX "person_index";

-- 3. Check size again: du -b movies.db
--    Output: 158,000,000 bytes (still 158 MB - no change!)

-- 4. Run VACUUM
VACUUM;

-- 5. Check size again: du -b movies.db
--    Output: 157,500,000 bytes (157.5 MB - space reclaimed!)


-- ============================================
-- VACUUM AFTER DELETING DATA
-- ============================================

-- Delete old movies
DELETE FROM "movies" WHERE "year" < 1900;

-- Space is marked as free but not yet reclaimed
-- Database file size hasn't changed

-- Reclaim the space
VACUUM;

-- Now the database file is smaller


-- ============================================
-- VACUUM AFTER DROPPING MULTIPLE INDEXES
-- ============================================

-- Drop all custom indexes
DROP INDEX "title_index";
DROP INDEX "name_index";
DROP INDEX "person_index";
DROP INDEX "movie_id_index";

-- All indexes marked as deleted but space not freed

-- Free all the space at once
VACUUM;

-- Database size significantly reduced


-- ============================================
-- VACUUM PRACTICAL EXAMPLE
-- ============================================

-- Scenario: Clean up the movies database

-- Step 1: Check current size
-- Terminal: du -b movies.db
-- Result: 158 MB

-- Step 2: Remove unnecessary indexes
DROP INDEX "person_index";

-- Step 3: Check size (no change yet)
-- Terminal: du -b movies.db
-- Result: 158 MB

-- Step 4: Vacuum to reclaim space
VACUUM;

-- Step 5: Check size again (now smaller)
-- Terminal: du -b movies.db
-- Result: 155 MB (3 MB reclaimed)

-- Step 6: Drop all indexes and vacuum
DROP INDEX "title_index";
DROP INDEX "name_index";
VACUUM;

-- Step 7: Final size check
-- Terminal: du -b movies.db
-- Result: 100 MB (58 MB total space reclaimed!)


-- ============================================
-- VACUUM TRADE-OFFS
-- ============================================

-- Advantages:
-- - Reclaims disk space
-- - Improves database performance
-- - Optimizes database structure
-- - Defragments the database file

-- Disadvantages:
-- - Takes time (can be slow for large databases)
-- - Requires temporary disk space (up to 2x database size)
-- - Locks the entire database during operation
-- - Cannot be run inside a transaction


-- ============================================
-- VACUUM ALTERNATIVES
-- ============================================

-- Auto-vacuum mode (set at database creation):
PRAGMA auto_vacuum = FULL;
-- Database automatically reclaims space after deletions
-- Trade-off: Slower DELETE operations

-- Incremental vacuum:
PRAGMA auto_vacuum = INCREMENTAL;
PRAGMA incremental_vacuum(N);
-- Reclaims N pages of space incrementally
-- Less disruptive than full VACUUM


-- ============================================
-- FORENSICS NOTE
-- ============================================

-- Before VACUUM: Deleted data can be recovered by forensics
-- After VACUUM: Deleted data is permanently removed
-- Use VACUUM for secure deletion of sensitive data


-- ============================================
-- BEST PRACTICES
-- ============================================

-- 1. Schedule regular VACUUM during low-traffic periods
-- 2. Monitor database size before and after
-- 3. Ensure enough disk space (2x database size)
-- 4. Consider auto_vacuum for write-heavy databases
-- 5. Don't VACUUM too frequently (overhead isn't worth it)

