-- FULL OUTER JOIN explanation
-- Implemented using UNION

-- full_join.sql
-- Use case:
-- Combine rows from two tables, keeping all rows from both tables, and filling in NULLs where there is no match.

-- Example:
-- List all books and their ratings, including books without ratings and ratings without books
SELECT books.title, ratings.rating
FROM books
         LEFT JOIN ratings
                   ON ratings.book_id = books.id
UNION
SELECT books.title, ratings.rating
FROM ratings
         LEFT JOIN books
                   ON ratings.book_id = books.id;

-- Explanation
-- A FULL OUTER JOIN returns all rows from both tables, with NULLs in places where there is no match. Since some databases do not support FULL OUTER JOIN directly, we can achieve the same result using a combination of LEFT JOIN and UNION. The first part retrieves all books and their ratings (including books without ratings), while the second part retrieves all ratings and their associated books (including ratings without books). The UNION operator combines these results, ensuring that all rows from both tables are included in the final output.
