-- ============================================
-- EXPLAIN QUERY PLAN
-- ============================================
-- EXPLAIN QUERY PLAN shows how SQLite will execute a query
-- Helps identify performance bottlenecks and verify index usage


-- ============================================
-- BASIC USAGE
-- ============================================

-- Syntax: EXPLAIN QUERY PLAN followed by any SELECT query

EXPLAIN QUERY PLAN
SELECT * FROM "movies"
WHERE "title" = 'Cars';

-- Output shows the execution plan:
-- - "SCAN TABLE movies" = scanning entire table (slow)
-- - "SEARCH TABLE movies USING INDEX" = using an index (fast)


-- ============================================
-- CHECKING INDEX USAGE
-- ============================================

-- WITHOUT INDEX - shows table scan
EXPLAIN QUERY PLAN
SELECT * FROM "movies"
WHERE "title" = 'Cars';
-- Output: SCAN TABLE movies

-- WITH INDEX - shows index usage
CREATE INDEX "title_index" ON "movies" ("title");

EXPLAIN QUERY PLAN
SELECT * FROM "movies"
WHERE "title" = 'Cars';
-- Output: SEARCH TABLE movies USING INDEX title_index (title=?)


-- ============================================
-- COVERING INDEX DETECTION
-- ============================================

-- A covering index contains all columns needed for the query
-- EXPLAIN QUERY PLAN will show "USING COVERING INDEX"

CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");

EXPLAIN QUERY PLAN
SELECT "movie_id" FROM "stars"
WHERE "person_id" = 1;
-- Output: SEARCH TABLE stars USING COVERING INDEX person_index


-- ============================================
-- COMPLEX QUERY ANALYSIS
-- ============================================

-- Analyze nested queries (subqueries)
EXPLAIN QUERY PLAN
SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars"
    WHERE "person_id" = (
        SELECT "id" FROM "people"
        WHERE "name" = 'Tom Hanks'
    )
);

-- Output shows execution plan for each level:
-- 1. Innermost query on "people" table
-- 2. Middle query on "stars" table
-- 3. Outer query on "movies" table


-- ============================================
-- JOIN QUERY ANALYSIS
-- ============================================

-- See how joins are executed
EXPLAIN QUERY PLAN
SELECT "movies"."title", "people"."name"
FROM "movies"
JOIN "stars" ON "movies"."id" = "stars"."movie_id"
JOIN "people" ON "stars"."person_id" = "people"."id"
WHERE "people"."name" = 'Tom Hanks';


-- ============================================
-- PARTIAL INDEX VERIFICATION
-- ============================================

-- Check if a partial index is being used
CREATE INDEX "recents" ON "movies" ("title")
WHERE "year" = 2023;

EXPLAIN QUERY PLAN
SELECT "title" FROM "movies"
WHERE "year" = 2023;
-- Should show: USING INDEX recents


-- ============================================
-- COMPARING QUERY PLANS
-- ============================================

-- Compare performance before and after optimization

-- BEFORE optimization:
EXPLAIN QUERY PLAN
SELECT "title" FROM "movies"
WHERE "title" = 'Cars';
-- Output: SCAN TABLE movies (slow)

-- Create index
CREATE INDEX "title_index" ON "movies" ("title");

-- AFTER optimization:
EXPLAIN QUERY PLAN
SELECT "title" FROM "movies"
WHERE "title" = 'Cars';
-- Output: SEARCH TABLE movies USING INDEX title_index (fast)


-- ============================================
-- READING THE OUTPUT
-- ============================================

-- Common output patterns:

-- 1. SCAN TABLE table_name
--    - Reads every row in the table (slow for large tables)

-- 2. SEARCH TABLE table_name USING INDEX index_name
--    - Uses an index to find rows (fast)

-- 3. USING COVERING INDEX index_name
--    - All needed data is in the index (fastest)

-- 4. USING PRIMARY KEY
--    - Searching by primary key (very fast)

-- 5. USING INTEGER PRIMARY KEY
--    - Optimized search for INTEGER PRIMARY KEY (fastest)


-- ============================================
-- PRACTICAL EXAMPLE
-- ============================================

-- Find all movies by a specific actor

-- Step 1: Check current plan (without indexes)
EXPLAIN QUERY PLAN
SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars"
    WHERE "person_id" = (
        SELECT "id" FROM "people"
        WHERE "name" = 'Tom Hanks'
    )
);

-- Step 2: Create indexes
CREATE INDEX "name_index" ON "people" ("name");
CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");

-- Step 3: Check optimized plan (with indexes)
EXPLAIN QUERY PLAN
SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars"
    WHERE "person_id" = (
        SELECT "id" FROM "people"
        WHERE "name" = 'Tom Hanks'
    )
);

-- Now the output should show index usage instead of table scans!

