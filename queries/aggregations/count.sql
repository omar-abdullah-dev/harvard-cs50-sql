-- count.sql
-- Use case:
-- Count how many rows match a condition.

-- Example:
-- Count right-handed batters
SELECT COUNT(*) AS "Right Handed Batters"
FROM players
WHERE bats = 'R';

-- Explanation
--
-- COUNT(*) returns the number of rows that match a condition.
-- It is commonly used for statistics and summaries.
--
-- COUNT(*) counts all rows that match the WHERE condition.
-- This query counts the number of players in the players table who bat right-handed (bats = 'R').
-- The result is returned with the alias "Right Handed Batters" for clarity.
-- Expected Output:
-- A single number representing the count of right-handed batters.
-- Sample Output:
-- Right Handed Batters
-- ----------------------
-- 1500
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.