-- ============================================
-- COMMON TABLE EXPRESSIONS (CTE)
-- ============================================
-- A CTE is a view that exists for a single query only.
-- Use WITH keyword to define a CTE.

-- Example 1: Basic CTE
-- Calculate average book ratings per year using a CTE
WITH "average_book_ratings" AS (
    SELECT
        "book_id",
        "title",
        "year",
        ROUND(AVG("rating"), 2) AS "rating"
    FROM "ratings"
    JOIN "books" ON "ratings"."book_id" = "books"."id"
    GROUP BY "book_id"
)
SELECT
    "year",
    ROUND(AVG("rating"), 2) AS "rating"
FROM "average_book_ratings"
GROUP BY "year";

-- Example 2: Multiple CTEs
-- Chain multiple CTEs together
WITH
"book_ratings" AS (
    SELECT
        "book_id",
        AVG("rating") AS "avg_rating"
    FROM "ratings"
    GROUP BY "book_id"
),
"highly_rated" AS (
    SELECT * FROM "book_ratings"
    WHERE "avg_rating" >= 4.0
)
SELECT
    "books"."title",
    "highly_rated"."avg_rating"
FROM "highly_rated"
JOIN "books" ON "highly_rated"."book_id" = "books"."id";

-- Example 3: CTE for Complex Filtering
-- Find authors with books that have above-average ratings
WITH "avg_all_books" AS (
    SELECT AVG("rating") AS "overall_avg"
    FROM "ratings"
),
"book_avgs" AS (
    SELECT
        "book_id",
        AVG("rating") AS "book_avg"
    FROM "ratings"
    GROUP BY "book_id"
)
SELECT DISTINCT "authors"."name"
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "book_avgs" ON "authored"."book_id" = "book_avgs"."book_id"
CROSS JOIN "avg_all_books"
WHERE "book_avgs"."book_avg" > "avg_all_books"."overall_avg";

-- Example 4: CTE for Recursive Queries (if supported)
-- Note: SQLite supports recursive CTEs for hierarchical data
WITH RECURSIVE "counter" AS (
    SELECT 1 AS "n"
    UNION ALL
    SELECT "n" + 1 FROM "counter"
    WHERE "n" < 10
)
SELECT * FROM "counter";

-- ============================================
-- KEY POINTS:
-- ============================================
-- 1. CTEs exist only for the duration of a single query
-- 2. Use WITH keyword to define a CTE
-- 3. Multiple CTEs can be chained together with commas
-- 4. CTEs improve query readability and organization
-- 5. Unlike views, CTEs don't get stored in the database schema
-- 6. CTEs are perfect for one-time complex calculations

-- ============================================
-- COMPARISON: Views vs Temporary Views vs CTEs
-- ============================================
-- Views:            Permanent, stored in schema, reusable across queries
-- Temporary Views:  Exist during connection, not in schema
-- CTEs:             Exist for single query only, not stored

