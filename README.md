# Harvard CS50 – Intro to SQL 

This repository contains notes, SQL queries, schemas, and problem set solutions gathered while working through Harvard's CS50 Introduction to Databases (SQL). It is organized to be a practical learning reference before moving on to JDBC and Java backend development.

Root files and important items
- `identifier.sqlite` — a SQLite database file included at the repository root (sample data / working DB).
- `README.md` — this file.

## Full Repository Structure

```
harvard-cs50-sql/
├── identifier.sqlite
├── README.md
├── Lecture Slides/
│   ├── lecture 0 - Querying.pdf
│   ├── lecture 1 - Relating.pdf
│   ├── lecture 2 - Designing.pdf
│   └── lecture 3 - Writing.pdf
├── Lectures Quick view/
│   ├── 0- Querying.md
│   ├── 1- Relating.md
│   ├── 2- Desiging.md
│   └── 3- Writing.md
├── notes/
│   ├── Lecture 0/
│   │   ├── 01- Querying.md
│   │   ├── img.png
│   │   ├── img_1.png
│   │   └── img_2.png
│   ├── Lecture 1/
│   │   └── 02- Relating.md
│   ├── Lecture 2/
│   │   └── 02- Designing.md
│   └── Lecture 3/
│       └── 03- Writing.md
├── problems/
│   ├── Lecture 0 - Querying/
│   │   ├── Cyberchase/
│   │   │   ├── 1.sql
│   │   │   ├── 2.sql
│   │   │   ├── 3.sql
│   │   │   ├── 4.sql
│   │   │   ├── 5.sql
│   │   │   ├── 6.sql
│   │   │   ├── 7.sql
│   │   │   ├── 8.sql
│   │   │   ├── 9.sql
│   │   │   ├── 10.sql
│   │   │   ├── 11.sql
│   │   │   ├── 12.sql
│   │   │   └── 13.sql
│   │   ├── Normals/
│   │   │   ├── 1.sql
│   │   │   ├── 2.sql
│   │   │   ├── 3.sql
│   │   │   ├── 4.sql
│   │   │   ├── 5.sql
│   │   │   ├── 6.sql
│   │   │   ├── 7.sql
│   │   │   ├── 8.sql
│   │   │   ├── 9.sql
│   │   │   └── 10.sql
│   │   ├── players/
│   │   │   ├── 1.sql
│   │   │   ├── 2.sql
│   │   │   ├── 3.sql
│   │   │   ├── 4.sql
│   │   │   ├── 5.sql
│   │   │   ├── 6.sql
│   │   │   ├── 7.sql
│   │   │   ├── 8.sql
│   │   │   ├── 9.sql
│   │   │   └── 10.sql
│   │   └── Views/
│   │       ├── 1.sql
│   │       ├── 2.sql
│   │       ├── 3.sql
│   │       ├── 4.sql
│   │       ├── 5.sql
│   │       ├── 6.sql
│   │       ├── 7.sql
│   │       ├── 8.sql
│   │       ├── 9.sql
│   │       └── 10.sql
│   ├── Lecture 1 - Relating/
│   │   ├── dese/
│   │   │   ├── 1.sql
│   │   │   ├── 2.sql
│   │   │   ├── 3.sql
│   │   │   ├── 4.sql
│   │   │   ├── 5.sql
│   │   │   ├── 6.sql
│   │   │   ├── 7.sql
│   │   │   ├── 8.sql
│   │   │   ├── 9.sql
│   │   │   ├── 10.sql
│   │   │   ├── 11.sql
│   │   │   ├── 12.sql
│   │   │   └── 13.sql
│   │   ├── moneyball/
│   │   │   ├── 1.sql
│   │   │   ├── 2.sql
│   │   │   ├── 3.sql
│   │   │   ├── 4.sql
│   │   │   ├── 5.sql
│   │   │   ├── 6.sql
│   │   │   ├── 7.sql
│   │   │   ├── 8.sql
│   │   │   ├── 9.sql
│   │   │   ├── 10.sql
│   │   │   ├── 11.sql
│   │   │   └── 12.sql
│   │   └── Packages/
│   │       ├── answers.txt
│   │       └── log.sql
│   ├── Lecture 2 - Designing/
│   │   ├── atl/
│   │   │   ├── atl.db
│   │   │   └── schema.sql
│   │   ├── connect/
│   │   │   └── schema.sql
│   │   └── donuts/
│   │       └── schema.sql
│   └── Lecture 3 - Writing/
│       ├── dont-panic/
│       │   ├── dont-panic.db
│       │   ├── hack.sql
│       │   └── reset.sql
│       └── meteorites/
│           ├── import.sql
│           ├── meteorites.csv
│           └── meteorites.db
├── queries/
│   ├── aggregations/
│   │   ├── avg.sql
│   │   ├── count.sql
│   │   └── min_max.sql
│   ├── basic/
│   │   ├── date_filtering.sql
│   │   ├── filtering.sql
│   │   ├── null_checks.sql
│   │   ├── order_by.sql
│   │   └── select_where.sql
│   ├── designing/
│   │   ├── constraints.sql
│   │   ├── alter_table.sql
│   │   ├── create_table.sql
│   │   ├── drop_table.sql
│   │   ├── foreign_key.sql
│   │   ├── notes.md
│   │   └── primary_key.sql
│   ├── groups/
│   │   ├── group_by.sql
│   │   ├── group_order.sql
│   │   └── having.sql
│   ├── joins/
│   │   ├── full_join.sql
│   │   ├── inner_join.sql
│   │   ├── left_join.sql
│   │   ├── multi_table_join.sql
│   │   ├── natural_join.sql
│   │   └── README.md
│   ├── sets/
│   │   ├── except.sql
│   │   ├── intersect.sql
│   │   └── union.sql
│   └── subqueries/
│       ├── above_average.sql
│       ├── basic_subquery.sql
│       ├── in_keyword.sql
│       ├── many_to_many.sql
│       └── one_to_many.sql
├── schemas/
│   ├── Lecture 0/
│   │   ├── cyberchase.db
│   │   ├── normals.db
│   │   ├── players.db
│   │   └── views.db
│   ├── Lecture 1/
│   │   ├── dese/
│   │   │   └── dese.db
│   │   ├── moneyball/
│   │   │   └── moneyball.db
│   │   └── packages/
│   │       └── packages.db
│   ├── Lecture 2/
│   │   ├── ATL/
│   │   │   └── atl.db
│   │   ├── connect/
│   │   │   └── connect.db
│   │   └── donuts/
│   │       └── donuts.db
│   └── Lecture 3/
│       ├── dont-panic/
│       │   └── dont-panic.db
│       └── meteorites/
│           └── meteorites.csv
├── Source Code/
│   ├── 0-Querying/
│   │   ├── pdf/
│   │   │   └── 0-Querying.pdf
│   │   └── sourcefiles/
│   │       ├── .DS_Store
│   │       ├── 0-SELECT.sql
│   │       ├── 1-LIMIT.sql
│   │       ├── 2-WHERE.sql
│   │       ├── 3-NULL.sql
│   │       ├── 4-LIKE.sql
│   │       ├── 5-compound.sql
│   │       ├── 6-range.sql
│   │       ├── 7-dates.sql
│   │       ├── 8-ORDER BY.sql
│   │       ├── 9-aggregate.sql
│   │       ├── aggregate.sql
│   │       ├── compound.sql
│   │       ├── csv/
│   │       │   └── longlist.csv
│   │       ├── LIKE.sql
│   │       ├── LIMIT.sql
│   │       ├── longlist.csv
│   │       ├── longlist.db
│   │       ├── NULL.sql
│   │       ├── ORDER BY.sql
│   │       ├── range.sql
│   │       ├── SELECT.sql
│   │       └── WHERE.sql
│   ├── 1-Relating/
│   │   ├── pdf/
│   │   │   └── 1-Relating.pdf
│   │   └── sourcefiles/
│   │       ├── authored.csv
│   │       ├── authors.csv
│   │       ├── books.csv
│   │       ├── csv/
│   │       │   ├── authored.csv
│   │       │   ├── authors.csv
│   │       │   ├── books.csv
│   │       │   ├── longlist.csv
│   │       │   ├── migrations.csv
│   │       │   ├── publishers.csv
│   │       │   ├── ratings.csv
│   │       │   ├── sea_lions.csv
│   │       │   ├── translated.csv
│   │       │   └── translators.csv
│   │       ├── groups.sql
│   │       ├── joins.sql
│   │       ├── longlist.csv
│   │       ├── longlist.db
│   │       ├── migrations.csv
│   │       ├── nested.sql
│   │       ├── publishers.csv
│   │       ├── ratings.csv
│   │       ├── sea_lions.csv
│   │       ├── sea_lions.db
│   │       ├── sets.sql
│   │       ├── src1.pdf
│   │       ├── translated.csv
│   │       └── translators.csv
│   ├── 2-Designing/
│   │   ├── pdf/
│   │   │   └── 2-Designing.pdf
│   │   └── sourcefiles/
│   │       ├── alter/
│   │       │   ├── alter0.sql
│   │       │   ├── alter1.sql
│   │       │   ├── alter2.sql
│   │       │   └── alter3.sql
│   │       └── schema/
│   │           ├── schema0.sql
│   │           ├── schema1.sql
│   │           ├── schema2.sql
│   │           ├── schema3.sql
│   │           ├── schema4.sql
│   │           ├── schema5.sql
│   │           ├── schema6.sql
│   │           └── schema7.sql
│   └── 3-Writing/
│       ├── pdf/
│       │   └── 3-Writing.pdf
│       └── sourcefiles/
│           ├── delete/
│           │   ├── delete0.sql
│           │   ├── delete1.sql
│           │   ├── delete2.sql
│           │   ├── schema0.sql
│           │   ├── schema1.sql
│           │   ├── schema2.sql
│           │   └── soft/
│           │       ├── delete.sql
│           │       └── soft_delete.sql
│           ├── import/
│           │   ├── import0/
│           │   │   ├── import0.sql
│           │   │   └── mfa.csv
│           │   └── import1/
│           │       ├── import1.sql
│           │       └── mfa.csv
│           ├── insert/
│           │   ├── import/
│           │   │   ├── import0/
│           │   │   │   ├── import0.sql
│           │   │   │   └── mfa.csv
│           │   │   └── import1/
│           │       │       ├── import1.sql
│           │       │       └── mfa.csv
│           │   ├── insert0.sql
│           │   ├── insert1.sql
│           │   └── schema.sql
│           ├── README.md
│           ├── schemas/
│           │   ├── delete/
│           │   │   ├── schema0.sql
│           │   │   ├── schema1.sql
│           │   │   └── schema2.sql
│           │   ├── insert/
│           │   │   └── schema.sql
│           │   ├── triggers/
│           │   │   └── schema.sql
│           │   └── update/
│           │       └── schema.sql
│           ├── triggers/
│           │   ├── schema.sql
│           │   └── triggers.sql
│           └── update/
│               ├── schema.sql
│               ├── update0.sql
│               ├── update1.sql
│               └── votes.csv
└── summaries/
    ├── SQL-APNA College.pdf
    └── SQL-Summary.pdf
```

What you'll find in practice folders
- `queries/` contains many ready-to-run SQL files such as `select_where.sql`, `group_by.sql`, `inner_join.sql`, and more.
- `problems/` contains worked solutions and practice SQL for the course problems (organized by lecture and by subtopics like `Cyberchase`, `Normals`, `players`, `Views`, etc.).
- `schemas/` contains SQLite database files you can open directly with a SQLite client.

Quick usage (open and run queries)
- Recommended GUI: DB Browser for SQLite (https://sqlitebrowser.org/) — open any `.db` or the `identifier.sqlite` file, browse tables, and run SQL from the `queries/` or `problems/` folders.

- Using sqlite3 CLI on Windows PowerShell (if you have sqlite3 installed):

  # Open the database
  sqlite3 "identifier.sqlite"

  # Within the sqlite3 prompt, list tables and run queries
  .tables
  SELECT * FROM table_name LIMIT 10;

- If you're using a different DBMS for experiments, note that most queries are written to be SQLite-compatible; some syntax (e.g., date functions or certain DDL differences) may need minor adjustments for other systems.

Study guidance and recommended order
1. Start with `Lectures Quick view/` and `notes/` for a fast conceptual pass.
2. Work through `queries/basic` to practice SELECT/WHERE/ORDER BY.
3. Move to `queries/aggregations` and `groups` for GROUP BY and HAVING exercises.
4. Practice `queries/joins` and `queries/subqueries` with the `schemas/` sample DBs.
5. Attempt problems in `problems/` before checking solutions.

Pro tips
- Keep a separate copy of any DB you intend to modify. The repository contains sample DB files and example queries; run queries that change data only on copies.
- Use `EXPLAIN QUERY PLAN` in SQLite to get basic insights into how a query will be executed.
- Many problems are organized so you can compare your solution with the instructor's by opening the relevant schema and running the SQL files in the `problems/` directory.

Contributing
- Add missing solutions, improve notes, or add new example queries.
- Follow the existing organization: put lecture-specific material under the corresponding lecture folder.
- If adding large database files, prefer placing them under `schemas/` or `schemas/Lecture X/` so they stay organized.

Contact / Author
- Author: Omar Abdullah — working through SQL fundamentals with the goal of solid preparation for JDBC and Java backend development.

License
- No license specified. If you'd like this repository to be open-source, consider adding an appropriate LICENSE file (MIT, Apache-2.0, etc.).

---

This README was updated to reflect the repository's actual structure (schemas, queries, problems, notes, slides, and sample DB files). If you'd like, I can also:
- Add a short CONTRIBUTING.md template,
- Create a small script to run a selected `.sql` file against `identifier.sqlite`, or
- Generate a quick index (table) of all SQL files in `queries/` and `problems/`.

Tell me which of those (if any) you'd like next.
