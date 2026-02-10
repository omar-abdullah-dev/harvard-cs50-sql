-- many_to_many.sql
-- Use case:
-- Use subqueries across a junction table.

-- Example:
-- Find authors who wrote the book "Flights"
SELECT name
FROM authors
WHERE id IN (
    SELECT author_id
    FROM authored
    WHERE book_id = (
        SELECT id
        FROM books
        WHERE title = 'Flights'
    )
);
