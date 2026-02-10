-- in_keyword.sql
-- Use case:
-- Filter rows where a column value exists in a list or subquery result.

-- Example 1:
-- Find books written by a specific author (many-to-many relationship)
SELECT title
FROM books
WHERE id IN (
    SELECT book_id
    FROM authored
    WHERE author_id = (
        SELECT id
        FROM authors
        WHERE name = 'Fernanda Melchor'
    )
);

-- Explanation (Simple English)
--
-- The inner query finds the author ID
--
-- The next query finds all book IDs written by that author
--
-- The outer query retrieves the titles of those books
--
-- IN is used because:
--
-- An author can write multiple books
--
-- The subquery returns more than one row
-- This query uses a subquery to find the author_id for 'Fernanda Melchor' from the authors table. The inner subquery retrieves the book_id(s) from the authored table for that author. The outer query then retrieves the titles of books that have those book_id(s).
-- Expected Output:
-- A list of book titles written by Fernanda Melchor.
-- Sample Output:
-- title
-- ----------------------
-- Book Title 1
-- Book Title 2
-- ...

-- Find players born in specific countries
    SELECT first_name, last_name
    FROM players
    WHERE birth_country IN ('USA', 'Canada', 'Japan');
-- Explanation
-- Returns players whose country is any one of the listed values.
--

-- Note:
-- Adjust the table and column names based on your actual database schema.