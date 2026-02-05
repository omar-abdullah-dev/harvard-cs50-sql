-- select_where.sql
-- Use case:
-- Retrieve specific columns from a table with basic filtering conditions.

-- Example:
-- Get first and last names of players born outside the USA
SELECT first_name, last_name
FROM players
WHERE birth_country <> 'USA';
-- Explanation:
-- This query selects specific columns from a table and filters rows using a WHERE condition.
-- It is used when you want only certain rows, not the whole table.

-- This query selects the first_name and last_name columns from the players table
-- where the birth_country is not equal to 'USA', effectively filtering out players
-- who were born in the USA.
-- Expected Output:
-- A list of first and last names of players born outside the USA.
-- Sample Output:
-- first_name | last_name
-- ------------+-----------
-- John       | Doe
-- Jane       | Smith
-- ...
