-- inner_join.sql
-- Use case:
-- Combine rows from two tables where matching values exist in both.

-- Example:
-- List book titles with their publishers
SELECT books.title, publishers.publisher
FROM books
         JOIN publishers
              ON books.publisher_id = publishers.id;
-- Explanation (Simple English)
--
-- An INNER JOIN returns only rows that have matching values in both tables.
-- If there is no match, the row is excluded.