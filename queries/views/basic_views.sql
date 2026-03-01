-- ============================================
-- BASIC VIEWS - Simplifying Queries
-- ============================================
-- Views are virtual tables defined by a query.
-- They don't consume much disk space as data is still stored in underlying tables.

-- Example 1: Creating a Simple View
-- Joins multiple tables to simplify future queries
CREATE VIEW "longlist" AS
SELECT "name", "title"
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";

-- Querying the view
SELECT * FROM "longlist";

-- Example 2: Simplified Query Using View
-- Without view (nested query - complex):
SELECT "title" FROM "books"
WHERE "id" IN (
    SELECT "book_id" FROM "authored"
    WHERE "author_id" = (
        SELECT "id" FROM "authors"
        WHERE "name" = 'Fernanda Melchor'
    )
);

-- With view (much simpler):
SELECT "title" FROM "longlist"
WHERE "name" = 'Fernanda Melchor';

-- Example 3: Ordering Data in a View Query
SELECT "name", "title"
FROM "longlist"
ORDER BY "title";

-- Example 4: Creating an Ordered View
-- The view itself can be ordered by including ORDER BY in the CREATE VIEW statement
CREATE VIEW "longlist_sorted" AS
SELECT "name", "title"
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id"
ORDER BY "title";

-- ============================================
-- KEY POINTS:
-- ============================================
-- 1. Views simplify complex queries by joining multiple tables
-- 2. Views can be queried just like regular tables
-- 3. Views don't store data separately - they reference underlying tables
-- 4. Updating underlying tables automatically updates the view results

