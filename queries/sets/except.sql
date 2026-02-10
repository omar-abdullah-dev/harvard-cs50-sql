-- except.sql
-- Use case:
-- Find values present in one set but not the other.

SELECT name FROM authors
EXCEPT
SELECT name FROM translators;

-- Explanation
-- The EXCEPT operator returns rows from the first SELECT statement that are not present in the second SELECT statement. In this example, it retrieves names that are listed in the authors table but not in the translators table, effectively giving us a list of people who are authors but not translators.

-- Expected Output:
-- A list of names that are present in the authors table but not in the translators table.
-- Sample Output:
-- name
-- ----------------------
-- John Doe
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.