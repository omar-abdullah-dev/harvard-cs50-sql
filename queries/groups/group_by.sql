-- group_by.sql
-- Use case:
-- Aggregate values by group.

-- Example:
-- Average rating per book
SELECT book_id, AVG(rating) AS "Average Rating"
FROM ratings
GROUP BY book_id;

-- Explanation
-- GROUP BY groups rows that have the same values in specified columns into summary rows.
-- It is often used with aggregate functions (like AVG, COUNT, SUM) to perform calculations on each group.

-- Note: When using GROUP BY, all columns in the SELECT statement that are not aggregated must be included in the GROUP BY clause.
-- Expected Output:
-- book_id | Average Rating
-- ---------+----------------
-- 1       | 4.5
-- 2       | 3.8
-- ...
-- Sample Output:
-- book_id | Average Rating
-- ---------+----------------
-- 1       | 4.5
-- 2       | 3.8
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.