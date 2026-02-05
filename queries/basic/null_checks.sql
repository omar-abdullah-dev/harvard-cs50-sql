-- null_checks.sql
-- Use case:
-- Find rows where data is missing.

-- Example:
-- Find players with no debut date
SELECT id
FROM players
WHERE debut IS NULL;

-- Explanation
--
-- NULL represents missing or unknown values.
-- You must use IS NULL or IS NOT NULL (never =).
-- NULL represents missing or unknown data in SQL.
-- The IS NULL condition is used to filter rows where a specific column has no value.
-- This query retrieves the IDs of players from the players table where the debut date is missing (NULL).
-- Expected Output:
-- A list of player IDs with no debut date.
-- Sample Output:
-- id
-- -----------
-- 12345
-- 67890
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.