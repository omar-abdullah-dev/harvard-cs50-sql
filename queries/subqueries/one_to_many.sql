-- one_to_many.sql
-- Use case:
-- Use a subquery to filter rows using a foreign key.

-- Example:
-- Books published by Fitzcarraldo Editions
SELECT title
FROM books
WHERE publisher_id = (
    SELECT id
    FROM publishers
    WHERE publisher = 'Fitzcarraldo Editions'
);

-- Explanation
-- This query uses a subquery to find the publisher_id for 'Fitzcarraldo Editions' from the publishers table. The outer query then retrieves the titles of books that have this publisher_id.
-- Expected Output:
-- A list of book titles published by Fitzcarraldo Editions.
-- Sample Output:
-- title
-- ----------------------
-- Book Title 1
-- Book Title 2
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.