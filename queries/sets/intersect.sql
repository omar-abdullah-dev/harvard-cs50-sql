-- intersect.sql
-- Use case:
-- Find common values between two result sets.

-- Example:
-- People who are both authors and translators
SELECT name FROM authors
INTERSECT
SELECT name FROM translators;

-- Explanation
-- The INTERSECT operator returns only the rows that are present in both result sets.
-- In this example, it finds names that appear in both the authors and translators tables, effectively giving us a list of people who are both authors and translators.

-- Expected Output:
-- A list of names that are present in both the authors and translators tables.
-- Sample Output:
-- name
-- ----------------------
-- John Doe
-- Jane Smith
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.