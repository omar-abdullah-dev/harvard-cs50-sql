-- ============================================
-- AGGREGATE VIEWS - Storing Aggregate Results
-- ============================================
-- Views can store the results of aggregate functions like AVG, SUM, COUNT, etc.
-- This allows quick access to pre-calculated aggregations.

-- Example 1: Average Ratings Per Book
-- Calculate and store average ratings for each book
CREATE VIEW "average_book_ratings" AS
SELECT
    "book_id" AS "id",
    "title",
    "year",
    ROUND(AVG("rating"), 2) AS "rating"
FROM "ratings"
JOIN "books" ON "ratings"."book_id" = "books"."id"
GROUP BY "book_id";

-- Query the aggregated view
SELECT * FROM "average_book_ratings";

-- Example 2: Nested Aggregation Using Views
-- Use the average ratings per book to calculate average ratings per year
SELECT
    "year",
    ROUND(AVG("rating"), 2) AS "rating"
FROM "average_book_ratings"
GROUP BY "year";

-- Example 3: Temporary View
-- Create a temporary view that exists only for the duration of the database connection
CREATE TEMPORARY VIEW "average_ratings_by_year" AS
SELECT
    "year",
    ROUND(AVG("rating"), 2) AS "rating"
FROM "average_book_ratings"
GROUP BY "year";

-- Query the temporary view
SELECT * FROM "average_ratings_by_year";

-- Example 4: Complex Aggregation View
-- Combining multiple aggregate functions
CREATE VIEW "book_statistics" AS
SELECT
    "book_id",
    "title",
    COUNT("rating") AS "total_ratings",
    ROUND(AVG("rating"), 2) AS "avg_rating",
    MIN("rating") AS "min_rating",
    MAX("rating") AS "max_rating"
FROM "ratings"
JOIN "books" ON "ratings"."book_id" = "books"."id"
GROUP BY "book_id";

-- ============================================
-- KEY POINTS:
-- ============================================
-- 1. Aggregating views store pre-calculated results (AVG, COUNT, SUM, etc.)
-- 2. Views update automatically when underlying data changes
-- 3. Temporary views exist only during the current database connection
-- 4. Use TEMPORARY when you don't want the view permanently stored in schema
-- 5. Views can be built on top of other views for nested aggregations

