-- multi_table_join.sql
-- Use case:
-- Join more than two tables together.

-- Example:
-- List book titles with author names
SELECT books.title, authors.name
FROM books
         JOIN authored ON authored.book_id = books.id
         JOIN authors ON authors.id = authored.author_id;

-- Explanation
--
-- Multiple JOINs are used when data spans more than two tables.
-- This is very common in real-world databases.
-- This query demonstrates how to join three tables: books, authored, and authors.
-- The first JOIN connects the books table to the authored table using the book_id.
-- The second JOIN connects the authored table to the authors table using the author_id.
-- This allows us to retrieve the title of each book along with the name of its author(s).
-- Expected Output:
-- A list of book titles along with their corresponding author names.
-- Sample Output:
-- title                 | name
-- ----------------------+----------------------
-- The Great Gatsby      | F. Scott Fitzgerald
-- To Kill a Mockingbird | Harper Lee
-- ...
-- Note:
-- Adjust the table and column names based on your actual database schema.