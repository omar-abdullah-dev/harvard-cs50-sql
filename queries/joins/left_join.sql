-- left_join.sql
-- Use case:
-- Keep all rows from the left table, even if no match exists in the right table.

-- Example:
-- List all books and their ratings (if available)
SELECT books.title, ratings.rating
FROM books
         LEFT JOIN ratings
                   ON ratings.book_id = books.id;

-- Explanation
--
-- A LEFT JOIN keeps all rows from the left table.
-- If no related data exists, the result will contain NULL values.