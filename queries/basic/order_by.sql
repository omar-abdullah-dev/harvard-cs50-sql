-- order_by.sql
-- Use case:
-- Sort query results in ascending or descending order.

-- Example:
-- List players sorted alphabetically by first name, then last name
SELECT first_name, last_name
FROM players
ORDER BY first_name ASC, last_name ASC;

-- Explanation
--
-- ORDER BY is used to sort query results.
--
    -- ASC → ascending order
    -- DESC → descending order
-- This query retrieves the first and last names of players from the players table
-- and sorts the results first by first_name in ascending order, and then by last_name
-- in ascending order as well. The ORDER BY clause is used to specify the sorting criteria.
-- ASC indicates ascending order. If DESC were used instead, the sorting would be in descending order.
-- Expected Output:
-- A list of players sorted alphabetically by first name, then last name.
-- Sample Output:
-- first_name | last_name
-- ------------+-----------
-- Alice      | Johnson
-- Bob        | Williams
-- Charlie    | Brown
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.
