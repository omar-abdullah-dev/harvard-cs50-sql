-- max_comparison.sql
-- Use case:
-- Retrieve rows that match the maximum value in a column.

-- Example:
-- Find the tallest player(s)
SELECT first_name, last_name, height
FROM players
WHERE height = (
    SELECT MAX(height)
    FROM players
);

-- Explanation
--
-- Subqueries are useful when the condition depends on aggregated data like MAX or AVG.
--
-- This query uses a subquery to find the maximum height from the players table.
-- The outer query then retrieves the first name, last name, and height of players whose height
-- matches this maximum value.
-- This is useful for identifying records that correspond to extreme values in a dataset.
-- Expected Output:
-- A list of first and last names of the tallest player(s) along with their height.
-- Sample Output:
-- first_name | last_name | height
-- ------------+-----------+--------
-- John       | Doe       | 84
-- Jane       | Smith     | 84
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.