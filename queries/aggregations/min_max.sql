-- min_max.sql
-- Use case:
-- Find minimum or maximum values.

-- Example:
-- Find tallest and shortest players
SELECT
    MIN(height) AS "Shortest Player",
    MAX(height) AS "Tallest Player"
FROM players;

-- Explanation
--
-- MIN() returns the smallest value in a column.
-- MAX() returns the largest value in a column.
-- Very common in analytics queries.
--
-- MIN() finds the minimum value in a specified column.
-- MAX() finds the maximum value in a specified column.
-- This query retrieves the shortest and tallest player heights from the players table.
-- The results are labeled with appropriate aliases for clarity.
-- Expected Output:
-- A single row with the shortest and tallest player heights.
-- Sample Output:
-- Shortest Player | Tallest Player
-- ----------------+----------------
-- 59              | 84
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.