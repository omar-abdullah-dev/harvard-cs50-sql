-- ============================================
-- CREATING INDEXES
-- ============================================
-- Indexes are structures used to speed up the retrieval of rows from a table
-- They work like book indexes - allowing quick lookups instead of scanning entire tables
-- Trade-off: Indexes improve query speed but take up additional space

-- Example database: movies.db (IMDb database)


-- ============================================
-- BASIC INDEX CREATION
-- ============================================

-- Create an index on a single column
-- Syntax: CREATE INDEX "index_name" ON "table_name" ("column_name");

CREATE INDEX "title_index" ON "movies" ("title");

-- This creates an index for the "title" column in the "movies" table
-- Now searching for movies by title will be much faster (e.g., 8x faster)


-- ============================================
-- MULTI-COLUMN INDEX
-- ============================================

-- Create an index on multiple columns
-- Useful when queries filter or sort by multiple columns

CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");

-- This creates a COVERING INDEX
-- A covering index contains all data needed for a query
-- The database doesn't need to look up the actual table rows


-- ============================================
-- INDEX ON FOREIGN KEYS
-- ============================================

-- Indexes are automatically created for PRIMARY KEY columns
-- But foreign keys benefit from manual indexes

CREATE INDEX "name_index" ON "people" ("name");
CREATE INDEX "movie_id_index" ON "stars" ("movie_id");


-- ============================================
-- PARTIAL INDEX
-- ============================================

-- A partial index includes only a subset of rows
-- Saves space while optimizing common queries

CREATE INDEX "recents" ON "movies" ("title")
WHERE "year" = 2023;

-- This index only stores titles of movies from 2023
-- Queries filtering by year = 2023 will use this smaller, faster index


-- ============================================
-- EXAMPLE: Before and After Indexing
-- ============================================

-- WITHOUT INDEX (slow - scans entire table):
SELECT * FROM "movies"
WHERE "title" = 'Cars';

-- AFTER CREATING INDEX (fast - uses index to jump directly to result):
CREATE INDEX "title_index" ON "movies" ("title");

SELECT * FROM "movies"
WHERE "title" = 'Cars';


-- ============================================
-- COMPLEX QUERY OPTIMIZATION
-- ============================================

-- Query to find all movies Tom Hanks starred in
-- This query joins multiple tables

SELECT "title" FROM "movies"
WHERE "id" IN (
    SELECT "movie_id" FROM "stars"
    WHERE "person_id" = (
        SELECT "id" FROM "people"
        WHERE "name" = 'Tom Hanks'
    )
);

-- To optimize this query, create indexes on columns used in WHERE clauses:
CREATE INDEX "name_index" ON "people" ("name");
CREATE INDEX "person_index" ON "stars" ("person_id", "movie_id");

-- After creating these indexes, the query runs much faster
-- Both indexes become COVERING INDEXES for this query


-- ============================================
-- CHECKING IF INDEX EXISTS
-- ============================================

-- View all indexes in the database
.schema

-- The output will show all CREATE INDEX statements


-- ============================================
-- NOTES ON INDEX USAGE
-- ============================================

-- Automatic Indexes:
-- - SQLite automatically creates indexes for PRIMARY KEY columns
-- - No need to manually index primary keys

-- When to Create Indexes:
-- - Columns frequently used in WHERE clauses
-- - Columns used in JOIN operations
-- - Columns used in ORDER BY
-- - Foreign key columns

-- When NOT to Create Indexes:
-- - Small tables (scanning is already fast)
-- - Columns rarely queried
-- - Tables with frequent INSERT/UPDATE operations
--   (indexes slow down data modification)

