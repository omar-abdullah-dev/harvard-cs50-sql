-- date_filtering.sql
-- Use case:
-- Filter rows based on date ranges.

-- Example:
-- Find players who played their final game in 2022
SELECT first_name, last_name
FROM players
WHERE final_game BETWEEN '2022-01-01' AND '2022-12-31';

-- Explanation
--
-- Dates in SQL are compared as strings in the format YYYY-MM-DD.
-- BETWEEN is useful for filtering a full date range.
--
-- This query filters players based on the date of their final game.
-- The BETWEEN operator is used to specify a range of dates.
-- Only players whose final_game date falls within the year 2022 are included in the results.
-- Expected Output:
-- A list of first and last names of players who played their final game in 2022.
-- Sample Output:
-- first_name | last_name
-- ------------+-----------
-- John       | Doe
-- Jane       | Smith
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.
