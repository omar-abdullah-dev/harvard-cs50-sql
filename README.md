# Harvard CS50 SQL Study Repository

A structured study workspace for Harvard CS50's Introduction to Databases with SQL.
It combines lecture notes, quick-review summaries, practice queries, problem-set work, and source materials in one place.

## What this repo contains

- Full lecture coverage for Lecture 0 through Lecture 6
- Quick-review files for each lecture in `Lectures Quick view/`
- Detailed lecture notes in `notes/`
- Topic-based SQL query examples in `queries/`
- Problem-set work in `problems/`
- Lecture 6 problem sets (`deep`, `dont-panic-java`, `sentimental-connect`)
- Database/schema assets in `schemas/` and problem folders
- Official/companion course files in `Source Code/`

## Repository structure

```text
harvard-cs50-sql/
|-- README.md
|-- Lecture Slides/
|   |-- lecture 0 - Querying.pdf
|   |-- lecture 1 - Relating.pdf
|   |-- lecture 2 - Designing.pdf
|   |-- lecture 3 - Writing.pdf
|   |-- lecture 4 - Viewing.pdf
|   |-- lecture 5 - Optimizing.pdf
|   `-- lecture 6 - Scaling.pdf
|-- Lectures Quick view/
|   |-- 0- Querying.md
|   |-- 1- Relating.md
|   |-- 2- Desiging.md
|   |-- 3- Writing.md
|   |-- 4- Viewing.md
|   |-- 5- Optimizing.md
|   `-- 6- Scaling.md
|-- notes/
|   |-- Lecture 0/00- Querying.md (+ images)
|   |-- Lecture 1/01- Relating.md
|   |-- Lecture 2/02- Designing.md
|   |-- Lecture 3/03- Writing.md
|   |-- Lecture 4/04- Viewing.md
|   |-- Lecture 5/05- Optimizing.md
|   `-- Lecture 6/06- Scaling.md
|-- queries/
|   |-- basic/
|   |-- aggregations/
|   |-- groups/
|   |-- joins/
|   |-- subqueries/
|   |-- sets/
|   |-- designing/
|   |-- writing/
|   |-- views/
|   |-- optimizing/
|   `-- scaling/
|-- problems/
|   |-- Lecture 0 - Querying/
|   |-- Lecture 1 - Relating/
|   |-- Lecture 2 - Designing/
|   |-- Lecture 3 - Writing/
|   |-- Lecture 4 - Viewing/
|   |-- Lecture 5 - Optimizing/
|   `-- Lecture 6 - Scaling/
|       |-- deep/
|       |-- dont-panic-java/
|       `-- sentimental-connect/
|-- schemas/
|   |-- Lecture 0/
|   |-- Lecture 1/
|   |-- Lecture 2/
|   |-- Lecture 3/
|   |-- Lecture 4/
|   |-- Lecture 5/
|   `-- Lecture 6/
|-- Source Code/
|   |-- 0-Querying/
|   |-- 1-Relating/
|   |-- 2-Designing/
|   |-- 3-Writing/
|   |-- 4-Viewing/
|   |-- 5-Optimizing/
|   `-- 6-Scaling/
`-- summaries/
    |-- SQL-APNA College.pdf
    |-- SQL-Summary.pdf
    `-- SYNTAX_UPDATE_SUMMARY.md
```

## Lecture-by-lecture map

- `Lecture 0 - Querying`: SQL basics, filtering, sorting, aggregates
- `Lecture 1 - Relating`: joins, relationships, set operations, grouped analysis
- `Lecture 2 - Designing`: schema design, keys, constraints, normalization
- `Lecture 3 - Writing`: insert/update/delete, triggers, transactions
- `Lecture 4 - Viewing`: views, CTEs, view security, view lifecycle
- `Lecture 5 - Optimizing`: indexes, query plans, VACUUM, locking/concurrency
- `Lecture 6 - Scaling`: MySQL/PostgreSQL syntax, access control, replication concepts

Each lecture is represented across:
- `Lecture Slides/`
- `Lectures Quick view/`
- `notes/`
- `queries/` (where applicable)
- `problems/` (for assigned problem sets)

## Query library (queries/)

- `queries/basic/`: `SELECT`, `WHERE`, `ORDER BY`, `LIKE`, `DISTINCT`, `BETWEEN`, null checks
- `queries/aggregations/`: `COUNT`, `AVG`, `SUM`, `MIN`, `MAX`
- `queries/groups/`: `GROUP BY`, grouped sorting, `HAVING`
- `queries/joins/`: inner/left/full/natural/multi-table join patterns + README
- `queries/subqueries/`: scalar and nested queries, `IN`, relationship patterns
- `queries/sets/`: `UNION`, `INTERSECT`, `EXCEPT`
- `queries/designing/`: `CREATE`, `ALTER`, `DROP`, primary/foreign keys, constraints
- `queries/writing/`: insert/update/delete/triggers/transactions + README
- `queries/views/`: basic and aggregate views, CTEs, security, soft deletions, management + summary
- `queries/optimizing/`: indexes, `EXPLAIN QUERY PLAN`, timing, transactions, locking, vacuum + summary
- `queries/scaling/`: MySQL/PostgreSQL setup, schema variants, stored procedures, replication, access control, SQL injection prevention + README

## Problem sets

- `problems/Lecture 0 - Querying/`: Cyberchase, Normals, Players, Views
- `problems/Lecture 1 - Relating/`: dese, moneyball, Packages
- `problems/Lecture 2 - Designing/`: atl, connect, donuts
- `problems/Lecture 3 - Writing/`: dont-panic, meteorites
- `problems/Lecture 4 - Viewing/`: bnb, census, private (The Private Eye)
- `problems/Lecture 5 - Optimizing/`: snap
- `problems/Lecture 6 - Scaling/`: deep, dont-panic-java, sentimental-connect

## How to study with this repo

1. Read the lecture quick view in `Lectures Quick view/`
2. Review details from `notes/`
3. Run matching examples from `queries/`
4. Solve the related problem set in `problems/`
5. Revisit syntax references in `summaries/`

## Running SQL files with SQLite

Use SQLite directly from terminal.

```powershell
sqlite3
.open "schemas/Lecture 0/normals.db"
.read "queries/basic/select_where.sql"
.tables
.quit
```

You can switch the `.open` and `.read` paths for any database/query file in this repository.

## Notes

- File names are documented as they currently exist in the repository.
- `Lectures Quick view/2- Desiging.md` keeps the existing on-disk spelling.
- `problems/Lecture 6 - Scaling/sentimental-connect/schema.sql` currently defines 6 tables: `users`, `schools`, `companies`, `connections`, `education`, `employment`.

## Author

Omar Abdullah Moharam

## Last updated

March 15, 2026
