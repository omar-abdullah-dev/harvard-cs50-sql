-- union.sql
-- Use case:
-- Combine two result sets without duplicates.

SELECT 'author' AS profession, name FROM authors
UNION
SELECT 'translator' AS profession, name FROM translators;

-- Explanation
-- The UNION operator combines the results of two SELECT statements and removes duplicates. In this example, it creates a combined list of names from both the authors and translators tables, along with their profession. If a name appears in both tables, it will only be listed once in the final result.

-- Expected Output:
-- profession | name
-- -----------+----------------------
-- author     | John Doe
-- translator | Jane Smith
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.