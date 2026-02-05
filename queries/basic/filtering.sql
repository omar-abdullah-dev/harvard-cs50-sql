-- filtering.sql
-- Use case:
-- Filter data using multiple conditions with AND / OR.

-- Example:
-- Find players who bat right-handed and throw left-handed
SELECT first_name, last_name
FROM players
WHERE bats = 'R'
  AND throws = 'L';

-- Explanation
--
-- This query demonstrates how to combine multiple conditions using AND.
-- Only rows that satisfy all conditions are returned.

-- This query retrieves the first and last names of players who bat right-handed (bats = 'R')
-- and throw left-handed (throws = 'L'). The AND operator ensures that both conditions must be met for a player to be included in the results.
-- Expected Output:
-- A list of first and last names of players who bat right-handed and throw left-handed.
-- Sample Output:
-- first_name | last_name
-- ------------+-----------
-- Alice      | Johnson
-- Bob        | Williams
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.
