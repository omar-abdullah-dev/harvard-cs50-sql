-- ============================================
-- QUERY TIMING AND PERFORMANCE MEASUREMENT
-- ============================================
-- Measure query execution time to identify slow queries
-- Compare performance before and after optimization


-- ============================================
-- ENABLING QUERY TIMER IN SQLITE
-- ============================================

-- Turn on timing for all subsequent queries
.timer on

-- Now all queries will display execution time
SELECT * FROM "movies" WHERE "title" = 'Cars';

-- Output shows:
-- Run Time: real 0.123 user 0.045 system 0.012
--
-- "real" time = stopwatch time (what users experience)
-- "user" time = CPU time in user mode
-- "system" time = CPU time in system mode

-- Turn off timing
.timer off


-- ============================================
-- MEASURING QUERY PERFORMANCE
-- ============================================

-- Test 1: Query without index
.timer on
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Real time: ~0.100 seconds (example)
.timer off

-- Create index
CREATE INDEX "title_index" ON "movies" ("title");

-- Test 2: Same query with index
.timer on
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Real time: ~0.012 seconds (example - 8x faster!)
.timer off


-- ============================================
-- COMPARING SCAN VS INDEX SEARCH
-- ============================================

-- Drop all indexes first
DROP INDEX IF EXISTS "title_index";

-- Time a full table scan
.timer on
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Real time: 0.100s
.timer off

-- Create index
CREATE INDEX "title_index" ON "movies" ("title");

-- Time with index
.timer on
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Real time: 0.012s (8x improvement)
.timer off


-- ============================================
-- TIMING COMPLEX QUERIES
-- ============================================

-- Without optimization
.timer on
SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars"
    WHERE "person_id" = (
        SELECT "id" FROM "people"
        WHERE "name" = 'Tom Hanks'
    )
);
-- Real time: ~0.500s
.timer off

-- Create indexes
CREATE INDEX "name_index" ON "people" ("name");
CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");

-- With optimization
.timer on
SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars"
    WHERE "person_id" = (
        SELECT "id" FROM "people"
        WHERE "name" = 'Tom Hanks'
    )
);
-- Real time: ~0.050s (10x improvement!)
.timer off


-- ============================================
-- TIMING JOIN QUERIES
-- ============================================

.timer on
SELECT "movies"."title", "people"."name"
FROM "movies"
JOIN "stars" ON "movies"."id" = "stars"."movie_id"
JOIN "people" ON "stars"."person_id" = "people"."id"
WHERE "people"."name" = 'Tom Hanks';
.timer off


-- ============================================
-- TIMING AGGREGATE QUERIES
-- ============================================

.timer on
SELECT "year", COUNT(*) AS "movie_count"
FROM "movies"
GROUP BY "year"
ORDER BY "year" DESC;
.timer off


-- ============================================
-- TIMING WITH LIMITS
-- ============================================

-- Small result set
.timer on
SELECT * FROM "movies" LIMIT 10;
-- Real time: ~0.001s
.timer off

-- Large result set
.timer on
SELECT * FROM "movies" LIMIT 100000;
-- Real time: ~0.050s
.timer off


-- ============================================
-- PERFORMANCE TESTING WORKFLOW
-- ============================================

-- Step 1: Enable timer
.timer on

-- Step 2: Run baseline query (no optimization)
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Record time: 0.100s

-- Step 3: Analyze query plan
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Shows: SCAN TABLE movies (slow)

-- Step 4: Add optimization (index)
CREATE INDEX "title_index" ON "movies" ("title");

-- Step 5: Run optimized query
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- New time: 0.012s

-- Step 6: Verify query plan
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Shows: SEARCH TABLE movies USING INDEX

-- Step 7: Calculate improvement
-- Improvement = 0.100s / 0.012s = 8.3x faster


-- ============================================
-- TIMING MULTIPLE QUERY VARIANTS
-- ============================================

-- Variant 1: Subquery
.timer on
SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars" WHERE "person_id" = 1
);
.timer off

-- Variant 2: JOIN
.timer on
SELECT "movies"."title"
FROM "movies"
JOIN "stars" ON "movies"."id" = "stars"."movie_id"
WHERE "stars"."person_id" = 1;
.timer off

-- Compare times to choose fastest approach


-- ============================================
-- TIMING INSERTIONS
-- ============================================

-- Without index
.timer on
INSERT INTO "movies" ("title", "year") VALUES ('New Movie', 2024);
-- Time: ~0.001s
.timer off

-- With multiple indexes
CREATE INDEX "title_index" ON "movies" ("title");
CREATE INDEX "year_index" ON "movies" ("year");

.timer on
INSERT INTO "movies" ("title", "year") VALUES ('Another Movie', 2024);
-- Time: ~0.003s (slower due to index updates)
.timer off


-- ============================================
-- TIMING UPDATES
-- ============================================

-- Single row update
.timer on
UPDATE "movies" SET "year" = 2023 WHERE "id" = 1;
.timer off

-- Bulk update
.timer on
UPDATE "movies" SET "year" = "year" + 1 WHERE "year" < 2000;
.timer off


-- ============================================
-- TIMING DELETIONS
-- ============================================

.timer on
DELETE FROM "movies" WHERE "year" < 1900;
.timer off


-- ============================================
-- PERFORMANCE BENCHMARKING TIPS
-- ============================================

-- 1. Run queries multiple times
--    - First run may be slower (cold cache)
--    - Average multiple runs for accuracy

-- 2. Test with realistic data volumes
--    - Small datasets don't show real performance

-- 3. Test both read and write operations
--    - Indexes speed up reads, slow down writes

-- 4. Clear cache between tests
--    - Close and reopen database
--    - Or restart SQLite

-- 5. Focus on "real" time
--    - This is what users experience
--    - User and system time are less relevant


-- ============================================
-- INTERPRETING TIMING RESULTS
-- ============================================

-- Fast queries: < 0.010s
-- Acceptable: 0.010s - 0.100s
-- Slow: 0.100s - 1.000s
-- Very slow: > 1.000s

-- Note: These are guidelines for small to medium databases
-- Large databases (GB/TB) have different thresholds


-- ============================================
-- SAMPLE PERFORMANCE TEST SCRIPT
-- ============================================

-- Enable timing
.timer on

-- Test 1: Full table scan
SELECT COUNT(*) FROM "movies";

-- Test 2: Indexed search
SELECT * FROM "movies" WHERE "id" = 12345;

-- Test 3: Non-indexed search
SELECT * FROM "movies" WHERE "title" = 'Inception';

-- Test 4: Join query
SELECT "movies"."title", COUNT("stars"."person_id") AS "cast_size"
FROM "movies"
JOIN "stars" ON "movies"."id" = "stars"."movie_id"
GROUP BY "movies"."id";

-- Test 5: Subquery
SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars"
    GROUP BY "movie_id"
    HAVING COUNT(*) > 10
);

-- Disable timing
.timer off

