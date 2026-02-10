-- group_order.sql
-- Use case:
-- Sort aggregated results.

SELECT book_id, COUNT(rating) AS "Ratings Count"
FROM ratings
GROUP BY book_id
ORDER BY "Ratings Count" DESC;

-- Explanation
-- The ORDER BY clause is used to sort the results of a query. When used with GROUP BY, it sorts the aggregated results based on the specified column or aggregate function. In this example, the results are sorted by the count of ratings in descending order, showing the books with the most ratings at the top.
-- Expected Output:
-- book_id | Ratings Count
-- ---------+---------------
-- 1       | 150
-- 2       | 120
-- ...
-- Sample Output:
-- book_id | Ratings Count
-- ---------+---------------
-- 1       | 150
-- 2       | 120
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.