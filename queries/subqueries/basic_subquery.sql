-- Subquery (single value)
-- Use case:
-- Filter using a value from another table.

SELECT title
FROM books
WHERE publisher_id = (
    SELECT id
    FROM publishers
    WHERE publisher = 'Fitzcarraldo Editions'
);

-- Explanation
-- Inner query runs first.
-- Outer query uses its result.
-- The inner query retrieves the publisher ID for 'Fitzcarraldo Editions' from the publishers table. The outer query then retrieves the titles of books that have that publisher_id. This is a subquery that returns a single value, which is used to filter the books in the outer query.
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