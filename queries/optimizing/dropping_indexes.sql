-- ============================================
-- DROPPING INDEXES
-- ============================================
-- Indexes can be removed to free up space or when they're no longer needed
-- Dropping an index doesn't remove data, only the index structure


-- ============================================
-- BASIC DROP INDEX
-- ============================================

-- Drop a single index
-- Syntax: DROP INDEX "index_name";

DROP INDEX "title_index";

-- This removes the index from the database
-- Queries that used this index will now perform table scans instead


-- ============================================
-- DROP MULTIPLE INDEXES
-- ============================================

-- Drop several indexes (one statement per index)
DROP INDEX "person_index";
DROP INDEX "name_index";
DROP INDEX "movie_id_index";


-- ============================================
-- DROP PARTIAL INDEX
-- ============================================

DROP INDEX "recents";


-- ============================================
-- CHECKING IMPACT BEFORE DROPPING
-- ============================================

-- Before dropping an index, check which queries use it
-- Use EXPLAIN QUERY PLAN to see if an index is used

EXPLAIN QUERY PLAN
SELECT "title" FROM "movies"
WHERE "title" = 'Cars';

-- If it shows "USING INDEX", the query benefits from the index
-- If it shows "SCAN TABLE", no index is being used


-- ============================================
-- RECLAIMING SPACE AFTER DROPPING INDEXES
-- ============================================

-- Dropping an index marks space as available but doesn't free it immediately
-- Use VACUUM to actually reclaim the space

DROP INDEX "person_index";

-- The database file size hasn't decreased yet!
-- Check size: du -b movies.db (Unix command)

-- Now vacuum to reclaim space:
VACUUM;

-- Check size again - it should be smaller now


-- ============================================
-- EXAMPLE: Drop All Custom Indexes
-- ============================================

-- Drop all indexes we created
DROP INDEX "title_index";
DROP INDEX "person_index";
DROP INDEX "name_index";
DROP INDEX "movie_id_index";
DROP INDEX "recents";

-- Reclaim all the space
VACUUM;


-- ============================================
-- WHEN TO DROP INDEXES
-- ============================================

-- Drop indexes when:
-- 1. The column is no longer frequently queried
-- 2. The table has too many indexes (slowing down INSERT/UPDATE)
-- 3. You need to free up disk space
-- 4. You're testing query performance with and without indexes
-- 5. Before bulk data imports (recreate after)

-- NOTE: You cannot drop indexes that SQLite creates automatically
-- (like those on PRIMARY KEY columns)

