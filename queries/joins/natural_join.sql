-- natural_join.sql
-- Use case:
-- Join tables automatically using columns with the same name.

-- Example:
SELECT *
FROM sea_lions
         NATURAL JOIN migrations;

-- Explanation
--
-- NATURAL JOIN automatically joins tables using columns with the same name.
-- It behaves like an INNER JOIN but removes duplicate join columns.