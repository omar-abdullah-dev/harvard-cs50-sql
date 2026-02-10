-- having.sql
-- Use case:
-- Filter grouped results.

-- Example:
-- Books with average rating above 4
SELECT book_id, ROUND(AVG(rating), 2) AS "Average Rating"
FROM ratings
GROUP BY book_id
HAVING "Average Rating" > 4.0;

-- Explanation
-- The HAVING clause is used to filter groups based on a condition. It is applied after the GROUP BY clause and can use aggregate functions to filter the results.

-- Note: When using HAVING, you can refer to the aggregated columns by their alias (like "Average Rating") or by the aggregate function directly (like AVG(rating)).
-- Expected Output:
-- book_id | Average Rating
-- ---------+----------------
-- 1       | 4.5
-- 3       | 4.2
-- ...
-- Sample Output:
-- book_id | Average Rating
-- ---------+----------------
-- 1       | 4.5
-- 3       | 4.2
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.