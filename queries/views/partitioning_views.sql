-- ============================================
-- PARTITIONING VIEWS
-- ============================================
-- Views can partition data into logical pieces for specific purposes.
-- Useful for breaking large datasets into manageable, focused subsets.

-- Example 1: Partition by Year
-- Create a view for books longlisted in 2022
CREATE VIEW "2022" AS
SELECT "id", "title"
FROM "books"
WHERE "year" = 2022;

-- Query the partitioned view
SELECT * FROM "2022";

-- Example 2: Partition by Year (2023)
CREATE VIEW "2023" AS
SELECT "id", "title"
FROM "books"
WHERE "year" = 2023;

-- Example 3: Partition by Rating Category
-- High-rated books (4.0 and above)
CREATE VIEW "highly_rated_books" AS
SELECT
    "books"."id",
    "books"."title",
    ROUND(AVG("ratings"."rating"), 2) AS "avg_rating"
FROM "books"
JOIN "ratings" ON "books"."id" = "ratings"."book_id"
GROUP BY "books"."id"
HAVING AVG("ratings"."rating") >= 4.0;

-- Low-rated books (below 3.0)
CREATE VIEW "low_rated_books" AS
SELECT
    "books"."id",
    "books"."title",
    ROUND(AVG("ratings"."rating"), 2) AS "avg_rating"
FROM "books"
JOIN "ratings" ON "books"."id" = "ratings"."book_id"
GROUP BY "books"."id"
HAVING AVG("ratings"."rating") < 3.0;

-- Example 4: Partition by Author Region (if applicable)
-- Books by European authors
CREATE VIEW "european_authors_books" AS
SELECT
    "authors"."name",
    "books"."title"
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "authored"."book_id" = "books"."id"
WHERE "authors"."region" = 'Europe';

-- Example 5: Partition by Data Range
-- Recent books (last 2 years)
CREATE VIEW "recent_books" AS
SELECT * FROM "books"
WHERE "year" >= (SELECT MAX("year") - 1 FROM "books");

-- Example 6: Partition for Application-Specific Needs
-- Books available for a specific website page
CREATE VIEW "featured_books" AS
SELECT
    "id",
    "title",
    "year",
    "publisher"
FROM "books"
WHERE "featured" = 1;

-- ============================================
-- KEY POINTS:
-- ============================================
-- 1. Partitioning breaks large datasets into smaller, logical pieces
-- 2. Useful for website pages, reports, or application-specific needs
-- 3. Each partition can be a separate view
-- 4. Partitions can be based on: time periods, categories, ratings, etc.
-- 5. Views automatically update when underlying data changes
-- 6. Multiple applications can use different partitioned views from same data

-- ============================================
-- USE CASES:
-- ============================================
-- - Website pages (one view per year/category)
-- - Department-specific data access
-- - Performance optimization (smaller result sets)
-- - Simplified application logic

