-- drop_table.sql
-- This file shows how to delete a table.

DROP TABLE IF EXISTS users;

-- Simple Explanation (English)
-- DROP TABLE deletes a table completely.
--
-- IF EXISTS prevents errors if the table does not exist.
--
-- Be careful: this permanently removes all data.
-- DROP TABLE is used to delete an entire table and all its data.
-- IF EXISTS prevents an error if the table does not exist.
-- In this example, we delete the users table if it exists.

