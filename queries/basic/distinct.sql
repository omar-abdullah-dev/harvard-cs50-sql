-- ============================================
-- DISTINCT - Removing Duplicates
-- ============================================
-- DISTINCT returns only unique values from a column

-- ============================================
-- BASIC DISTINCT USAGE
-- ============================================

-- Example 1: Get all unique years from the longlist
SELECT DISTINCT "year"
FROM "longlist"
ORDER BY "year";

-- Explanation: Without DISTINCT, you'd get duplicate years (one per book)
-- With DISTINCT, each year appears only once

-- Example 2: Compare with and without DISTINCT
-- Without DISTINCT (shows all 65 books' years)
SELECT "year"
FROM "longlist";

-- With DISTINCT (shows only unique years, e.g., 2019, 2020, 2021, 2022, 2023)
SELECT DISTINCT "year"
FROM "longlist";

-- ============================================
-- DISTINCT WITH MULTIPLE COLUMNS
-- ============================================

-- Example 3: Get unique combinations of year and publisher
SELECT DISTINCT "year", "publisher"
FROM "longlist"
ORDER BY "year", "publisher";

-- Explanation: Returns unique pairs of (year, publisher)
-- Each combination appears only once

-- Example 4: Get unique author-translator combinations
SELECT DISTINCT "author", "translator"
FROM "longlist"
WHERE "translator" IS NOT NULL
ORDER BY "author";

-- ============================================
-- DISTINCT WITH COUNT
-- ============================================

-- Example 5: Count how many unique years are in the database
SELECT COUNT(DISTINCT "year") AS "unique_years"
FROM "longlist";

-- Example 6: Count unique authors
SELECT COUNT(DISTINCT "author") AS "total_authors"
FROM "longlist";

-- Example 7: Count unique publishers
SELECT COUNT(DISTINCT "publisher") AS "total_publishers"
FROM "longlist";

-- Example 8: Compare total rows vs unique authors
SELECT
    COUNT(*) AS "total_books",
    COUNT(DISTINCT "author") AS "unique_authors"
FROM "longlist";

-- Explanation: Shows if any author has multiple books

-- ============================================
-- DISTINCT IN PRACTICAL SCENARIOS
-- ============================================

-- Example 9: Get list of all countries players are from
SELECT DISTINCT "birth_country"
FROM "players"
ORDER BY "birth_country";

-- Example 10: Get all unique batting styles
SELECT DISTINCT "bats"
FROM "players";

-- Example 11: Find all unique combinations of batting and throwing
SELECT DISTINCT "bats", "throws"
FROM "players"
ORDER BY "bats", "throws";

-- ============================================
-- DISTINCT WITH WHERE CLAUSE
-- ============================================

-- Example 12: Get unique years for books rated above 4.0
SELECT DISTINCT "year"
FROM "longlist"
WHERE "rating" > 4.0
ORDER BY "year";

-- Example 13: Find unique publishers for books from 2023
SELECT DISTINCT "publisher"
FROM "longlist"
WHERE "year" = 2023
ORDER BY "publisher";

-- Example 14: Get unique birth countries for players who debuted after 2000
SELECT DISTINCT "birth_country"
FROM "players"
WHERE "debut" >= '2000-01-01'
ORDER BY "birth_country";

-- ============================================
-- DISTINCT vs GROUP BY
-- ============================================
-- Both can achieve similar results, but GROUP BY is more powerful

-- Example 15: Using DISTINCT to get unique years
SELECT DISTINCT "year"
FROM "longlist"
ORDER BY "year";

-- Example 16: Using GROUP BY to get unique years (same result)
SELECT "year"
FROM "longlist"
GROUP BY "year"
ORDER BY "year";

-- Example 17: GROUP BY advantage - can aggregate
SELECT "year", COUNT(*) AS "books_per_year"
FROM "longlist"
GROUP BY "year"
ORDER BY "year";

-- Note: DISTINCT can't show counts per group, GROUP BY can

-- ============================================
-- DISTINCT WITH NULL VALUES
-- ============================================

-- Example 18: DISTINCT includes NULL as a unique value
SELECT DISTINCT "translator"
FROM "longlist"
ORDER BY "translator";

-- Explanation: If multiple books have NULL translator, NULL appears once

-- Example 19: Count unique translators (NULL counts as one unique value)
SELECT COUNT(DISTINCT "translator") AS "unique_translators"
FROM "longlist";

-- Example 20: Exclude NULLs when counting distinct
SELECT COUNT(DISTINCT "translator") AS "unique_translators"
FROM "longlist"
WHERE "translator" IS NOT NULL;

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: E-commerce - Get all unique categories
SELECT DISTINCT "category"
FROM "products"
ORDER BY "category";

-- Use Case 2: Find all unique email domains
SELECT DISTINCT
    SUBSTR("email", INSTR("email", '@') + 1) AS "email_domain"
FROM "users"
ORDER BY "email_domain";

-- Use Case 3: Get all cities customers are from
SELECT DISTINCT "city"
FROM "customers"
WHERE "country" = 'USA'
ORDER BY "city";

-- Use Case 4: Find all tags used in blog posts
SELECT DISTINCT "tag"
FROM "post_tags"
ORDER BY "tag";

-- Use Case 5: Get unique status values
SELECT DISTINCT "status"
FROM "orders";

-- Use Case 6: Find all subjects taught
SELECT DISTINCT "subject"
FROM "courses"
ORDER BY "subject";

-- ============================================
-- DISTINCT WITH AGGREGATIONS
-- ============================================

-- Example 21: Average rating by unique years
SELECT DISTINCT "year"
FROM "longlist"
ORDER BY "year";
-- Then in application or separate query, calculate averages

-- Better approach: Use GROUP BY for aggregations
SELECT "year", ROUND(AVG("rating"), 2) AS "avg_rating"
FROM "longlist"
GROUP BY "year"
ORDER BY "year";

-- ============================================
-- DISTINCT WITH JOINS
-- ============================================

-- Example 22: Get unique author names from books table (with join)
SELECT DISTINCT "authors"."name"
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
ORDER BY "authors"."name";

-- Example 23: Get unique publishers that published books in 2023
SELECT DISTINCT "publishers"."name"
FROM "publishers"
JOIN "books" ON "publishers"."id" = "books"."publisher_id"
WHERE "books"."year" = 2023
ORDER BY "publishers"."name";

-- ============================================
-- COMBINING DISTINCT WITH LIMIT
-- ============================================

-- Example 24: Get first 5 unique years
SELECT DISTINCT "year"
FROM "longlist"
ORDER BY "year"
LIMIT 5;

-- Example 25: Get 10 unique author names
SELECT DISTINCT "author"
FROM "longlist"
ORDER BY "author"
LIMIT 10;

-- ============================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================

-- ⚠️ DISTINCT requires sorting/hashing - can be slow on large datasets
-- ✅ Index columns used with DISTINCT for better performance
-- ⚠️ DISTINCT on multiple columns is more expensive than single column
-- ✅ Use WHERE clause to filter before DISTINCT reduces work

-- Slower (DISTINCT on all rows):
SELECT DISTINCT "author"
FROM "longlist";

-- Faster (filter first, then DISTINCT):
SELECT DISTINCT "author"
FROM "longlist"
WHERE "year" = 2023;

-- ============================================
-- DISTINCT ALL (Opposite of DISTINCT)
-- ============================================

-- Example 26: ALL is the default (shows duplicates)
SELECT ALL "year"
FROM "longlist";

-- Equivalent to:
SELECT "year"
FROM "longlist";

-- Note: ALL is rarely used since it's the default behavior

-- ============================================
-- COMMON PATTERNS
-- ============================================

-- Pattern 1: Get unique values for dropdown/select list
SELECT DISTINCT "category"
FROM "products"
ORDER BY "category";

-- Pattern 2: Check data quality (find variations)
SELECT DISTINCT "country"
FROM "customers"
ORDER BY "country";
-- Results might show "USA", "United States", "US" - indicating data cleanup needed

-- Pattern 3: Unique combinations for validation
SELECT DISTINCT "username", "email"
FROM "users"
ORDER BY "username";

-- Pattern 4: Count distinct for metrics
SELECT
    COUNT(*) AS "total_orders",
    COUNT(DISTINCT "customer_id") AS "unique_customers",
    COUNT(DISTINCT "product_id") AS "unique_products"
FROM "orders";

-- ============================================
-- DISTINCT vs SELECT DISTINCT *
-- ============================================

-- Example 27: DISTINCT * removes duplicate ROWS
SELECT DISTINCT *
FROM "longlist"
WHERE "year" = 2023;

-- Explanation: Removes rows that are completely identical across ALL columns

-- Example 28: DISTINCT on specific column
SELECT DISTINCT "year"
FROM "longlist";

-- Explanation: Removes duplicates only for the "year" column

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. DISTINCT removes duplicate values from result set
-- 2. Can use DISTINCT with one or multiple columns
-- 3. COUNT(DISTINCT column) counts unique values
-- 4. NULL is treated as a distinct value
-- 5. DISTINCT happens after WHERE but before ORDER BY
-- 6. GROUP BY is better when you need aggregations
-- 7. DISTINCT can impact performance on large datasets
-- 8. Use indexes to improve DISTINCT performance
-- 9. DISTINCT * removes duplicate rows
-- 10. Combine with ORDER BY for sorted unique values

