-- ============================================
-- RANGES AND COMPARISONS
-- ============================================
-- Using comparison operators and BETWEEN for range queries

-- ============================================
-- COMPARISON OPERATORS
-- ============================================
-- Operators: <, >, <=, >=, =, !=, <>

-- Example 1: Find books published after 2020
SELECT "title", "year"
FROM "longlist"
WHERE "year" > 2020;

-- Example 2: Find books with rating of 4.0 or higher
SELECT "title", "rating"
FROM "longlist"
WHERE "rating" >= 4.0;

-- Example 3: Find books with less than 5000 votes
SELECT "title", "votes"
FROM "longlist"
WHERE "votes" < 5000;

-- Example 4: Find books with rating of exactly 4.5
SELECT "title", "rating"
FROM "longlist"
WHERE "rating" = 4.5;

-- Example 5: Find books NOT published in 2023 (using !=)
SELECT "title", "year"
FROM "longlist"
WHERE "year" != 2023;

-- Example 6: Find books NOT published in 2023 (using <>)
-- Note: <> and != are equivalent
SELECT "title", "year"
FROM "longlist"
WHERE "year" <> 2023;

-- ============================================
-- BETWEEN - INCLUSIVE RANGES
-- ============================================
-- BETWEEN is inclusive on both ends

-- Example 7: Find books longlisted between 2019 and 2022 (inclusive)
-- Method 1: Using comparison operators
SELECT "title", "author", "year"
FROM "longlist"
WHERE "year" >= 2019 AND "year" <= 2022;

-- Method 2: Using BETWEEN (cleaner syntax)
SELECT "title", "author", "year"
FROM "longlist"
WHERE "year" BETWEEN 2019 AND 2022;

-- Explanation: BETWEEN includes both endpoints (2019 and 2022)

-- Example 8: Find books with ratings between 3.5 and 4.5
SELECT "title", "rating"
FROM "longlist"
WHERE "rating" BETWEEN 3.5 AND 4.5;

-- Example 9: Find players born between 1990 and 2000
SELECT "first_name", "last_name", "birth_year"
FROM "players"
WHERE "birth_year" BETWEEN 1990 AND 2000;

-- ============================================
-- NOT BETWEEN - EXCLUSIVE RANGES
-- ============================================

-- Example 10: Find books NOT published between 2019 and 2022
SELECT "title", "year"
FROM "longlist"
WHERE "year" NOT BETWEEN 2019 AND 2022;

-- Equivalent to:
SELECT "title", "year"
FROM "longlist"
WHERE "year" < 2019 OR "year" > 2022;

-- ============================================
-- COMBINING MULTIPLE RANGE CONDITIONS
-- ============================================

-- Example 11: Find highly-rated books with many votes
SELECT "title", "rating", "votes"
FROM "longlist"
WHERE "rating" >= 4.0
  AND "votes" >= 10000;

-- Example 12: Find books from recent years with high ratings
SELECT "title", "year", "rating"
FROM "longlist"
WHERE "year" BETWEEN 2020 AND 2023
  AND "rating" > 4.0;

-- Example 13: Find books outside a specific range OR with high ratings
SELECT "title", "year", "rating"
FROM "longlist"
WHERE "year" NOT BETWEEN 2019 AND 2022
   OR "rating" >= 4.5;

-- ============================================
-- DATE RANGES
-- ============================================
-- Working with date ranges

-- Example 14: Find players who debuted between specific dates
SELECT "first_name", "last_name", "debut"
FROM "players"
WHERE "debut" BETWEEN '2000-01-01' AND '2005-12-31';

-- Example 15: Find players who debuted after year 2000
SELECT "first_name", "last_name", "debut"
FROM "players"
WHERE "debut" >= '2000-01-01';

-- Example 16: Find artwork acquired in the 1950s
SELECT "title", "acquired"
FROM "collections"
WHERE "acquired" BETWEEN '1950-01-01' AND '1959-12-31';

-- ============================================
-- TEXT RANGES (Alphabetical)
-- ============================================
-- BETWEEN also works with text (alphabetical ordering)

-- Example 17: Find authors whose names start with A through D
SELECT "author"
FROM "longlist"
WHERE "author" BETWEEN 'A' AND 'E'
ORDER BY "author";

-- Note: This includes names starting with A, B, C, D
-- "E" is not included unless a name is exactly "E"

-- Example 18: Find players with last names in middle of alphabet
SELECT "last_name"
FROM "players"
WHERE "last_name" BETWEEN 'M' AND 'R'
ORDER BY "last_name";

-- ============================================
-- COMBINING WITH ORDER BY
-- ============================================

-- Example 19: Find top-rated books from recent years
SELECT "title", "year", "rating"
FROM "longlist"
WHERE "year" >= 2020
  AND "rating" >= 4.0
ORDER BY "rating" DESC, "year" DESC;

-- Example 20: Find books with moderate ratings, ordered by votes
SELECT "title", "rating", "votes"
FROM "longlist"
WHERE "rating" BETWEEN 3.0 AND 4.0
ORDER BY "votes" DESC;

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: Age range filtering
SELECT "name", "age"
FROM "users"
WHERE "age" BETWEEN 18 AND 65;

-- Use Case 2: Price range for e-commerce
SELECT "product_name", "price"
FROM "products"
WHERE "price" BETWEEN 20.00 AND 50.00
ORDER BY "price";

-- Use Case 3: Height requirements
SELECT "first_name", "last_name", "height"
FROM "players"
WHERE "height" >= 72  -- At least 6 feet (72 inches)
ORDER BY "height" DESC;

-- Use Case 4: Date range for reports (this month)
SELECT "order_id", "order_date", "total"
FROM "orders"
WHERE "order_date" BETWEEN '2024-03-01' AND '2024-03-31';

-- Use Case 5: Temperature range
SELECT "date", "temperature"
FROM "weather"
WHERE "temperature" BETWEEN 60 AND 80;  -- Comfortable range

-- Use Case 6: Grade ranges
SELECT "student_name", "score"
FROM "grades"
WHERE "score" BETWEEN 90 AND 100;  -- A grades

-- ============================================
-- MULTIPLE RANGE CONDITIONS (OR)
-- ============================================

-- Example 21: Find books from early 2000s OR late 2010s
SELECT "title", "year"
FROM "longlist"
WHERE "year" BETWEEN 2000 AND 2005
   OR "year" BETWEEN 2017 AND 2022;

-- Example 22: Find books with very high OR very low ratings
SELECT "title", "rating"
FROM "longlist"
WHERE "rating" < 2.0 OR "rating" > 4.5;

-- ============================================
-- RANGE WITH NULL HANDLING
-- ============================================

-- Example 23: Find books with ratings in range (excluding NULL)
SELECT "title", "rating"
FROM "longlist"
WHERE "rating" BETWEEN 3.0 AND 5.0
  AND "rating" IS NOT NULL;

-- Example 24: Include NULLs in results
SELECT "title", "rating"
FROM "longlist"
WHERE ("rating" BETWEEN 4.0 AND 5.0)
   OR "rating" IS NULL;

-- ============================================
-- PERFORMANCE TIPS
-- ============================================

-- ✅ BETWEEN is often clearer than using >= and <=
-- ✅ Indexes on columns improve range query performance
-- ✅ Use appropriate data types (INTEGER for numbers, DATE for dates)
-- ⚠️ BETWEEN includes both boundaries (use < and > for exclusive ranges)

-- Example 25: Exclusive range (NOT including endpoints)
SELECT "title", "rating"
FROM "longlist"
WHERE "rating" > 3.0 AND "rating" < 5.0;  -- Excludes 3.0 and 5.0

-- ============================================
-- COMMON PITFALLS
-- ============================================

-- ❌ WRONG: Reversed BETWEEN values
-- SELECT * FROM "longlist"
-- WHERE "year" BETWEEN 2022 AND 2019;  -- Returns nothing!

-- ✅ CORRECT: Lower value first, higher value second
SELECT * FROM "longlist"
WHERE "year" BETWEEN 2019 AND 2022;

-- ❌ WRONG: Forgetting BETWEEN is inclusive
-- If you want exclusive range, don't use BETWEEN

-- ✅ CORRECT: For exclusive range, use < and >
SELECT * FROM "longlist"
WHERE "rating" > 3.0 AND "rating" < 5.0;

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. Comparison operators: <, >, <=, >=, =, !=, <>
-- 2. BETWEEN is inclusive on both ends
-- 3. NOT BETWEEN excludes the range
-- 4. Works with numbers, dates, and text
-- 5. Can combine multiple range conditions with AND/OR
-- 6. BETWEEN is equivalent to: column >= value1 AND column <= value2
-- 7. Use appropriate data types for best performance
-- 8. Indexes significantly improve range query performance

