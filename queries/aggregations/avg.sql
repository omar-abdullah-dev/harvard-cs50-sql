-- avg.sql
-- Use case:
-- Calculate averages and round numeric results.

-- Example:
-- Average height and weight of players debuted after 2000
SELECT
    ROUND(AVG(height), 2) AS "Average Height",
    ROUND(AVG(weight), 2) AS "Average Weight"
FROM players
WHERE debut >= '2000-01-01';

-- Explanation
--
-- AVG() calculates the average value of a column.
-- ROUND(value, decimals) is used to format numeric results.
--
-- AVG() calculates the average of a numeric column.
-- ROUND() is used to limit decimal places for better readability.
-- This query calculates the average height and weight of players who debuted after January 1, 2000.
-- The results are rounded to two decimal places for clarity and presented with appropriate aliases.
-- Expected Output:
-- A single row with average height and weight of players debuted after 2000.
-- Sample Output:
-- Average Height | Average Weight
-- ----------------+----------------
-- 72.45          | 180.32
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.