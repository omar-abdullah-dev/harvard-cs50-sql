# Harvard CS50 SQL Study Repository

A structured study workspace for Harvard CS50's Introduction to Databases with SQL.
It combines lecture notes, quick-review summaries, practice queries, problem-set work, and source materials — all oriented toward building production-grade SQL skills for a **Java Spring backend developer**.

---

## What this repo contains

- Full lecture coverage for Lecture 0 through Lecture 6
- Quick-review files for each lecture in `Lectures Quick view/`
- Detailed lecture notes in `notes/`
- Topic-based SQL query examples in `queries/`
- Problem-set solutions in `problems/`
- **Java + JDBC hands-on code** in `problems/Lecture 6 - Scaling/dont-panic-java/`
- Database/schema assets in `schemas/` and problem folders
- Official/companion course files in `Source Code/`
- Reference summaries in `summaries/`

---

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
|   |-- 2- Desiging.md          ← on-disk spelling preserved
|   |-- 3- Writing.md
|   |-- 4- Viewing.md
|   |-- 5- Optimizing.md
|   `-- 6- Scaling.md
|-- notes/
|   |-- Lecture 0/
|   |   |-- 00- Querying.md
|   |   |-- img.png
|   |   |-- img_1.png
|   |   `-- img_2.png
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
|   |-- joins/                  ← README included
|   |-- subqueries/
|   |-- sets/
|   |-- designing/
|   |-- writing/                ← README included
|   |-- views/                  ← README included
|   |-- optimizing/             ← README + SUMMARY included
|   `-- scaling/                ← README included
|-- problems/
|   |-- Lecture 0 - Querying/
|   |   |-- Cyberchase/
|   |   |-- Normals/
|   |   |-- players/
|   |   `-- Views/
|   |-- Lecture 1 - Relating/
|   |   |-- dese/
|   |   |-- moneyball/
|   |   `-- Packages/
|   |-- Lecture 2 - Designing/
|   |   |-- atl/
|   |   |-- connect/
|   |   `-- donuts/
|   |-- Lecture 3 - Writing/
|   |   |-- dont-panic/
|   |   `-- meteorites/
|   |-- Lecture 4 - Viewing/
|   |   |-- bnb/
|   |   |-- census/
|   |   `-- private/            ← The Private Eye
|   |-- Lecture 5 - Optimizing/
|   |   `-- snap/
|   `-- Lecture 6 - Scaling/
|       |-- deep/               ← sharding/partitioning conceptual answers
|       |-- dont-panic-java/    ← JDBC + PreparedStatement hands-on
|       |   |-- Hack.java
|       |   |-- Hack.class
|       |   |-- dont-panic.db
|       |   |-- reset.sql
|       |   `-- sqlite-jdbc-3.43.0.0.jar
|       `-- sentimental-connect/
|           `-- schema.sql      ← 6-table LinkedIn-style schema
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

---

## Lecture-by-lecture map

| # | Topic | Key Concepts | Query Folder | Problem Sets |
|---|-------|-------------|--------------|--------------|
| 0 | Querying | SELECT, WHERE, ORDER BY, LIKE, aggregates | `basic/`, `aggregations/`, `groups/` | Cyberchase, Normals, Players, Views |
| 1 | Relating | JOINs, set ops, subqueries, relationships | `joins/`, `sets/`, `subqueries/` | dese, moneyball, Packages |
| 2 | Designing | Schema design, keys, constraints, normalization | `designing/` | atl, connect, donuts |
| 3 | Writing | INSERT, UPDATE, DELETE, triggers, transactions | `writing/` | dont-panic, meteorites |
| 4 | Viewing | Views, CTEs, security, soft deletions | `views/` | bnb, census, private |
| 5 | Optimizing | Indexes, EXPLAIN QUERY PLAN, VACUUM, locking | `optimizing/` | snap |
| 6 | Scaling | MySQL/PostgreSQL, stored procs, replication, access control, JDBC, SQL injection | `scaling/` | deep, dont-panic-java, sentimental-connect |

Each lecture is covered across:
`Lecture Slides/` → `Lectures Quick view/` → `notes/` → `queries/` → `problems/`

---

## Query library (`queries/`)

| Folder | Contents |
|--------|----------|
| `basic/` | `SELECT`, `WHERE`, `ORDER BY`, `LIKE`, `DISTINCT`, `BETWEEN`, null checks, date filtering |
| `aggregations/` | `COUNT`, `AVG`, `SUM`, `MIN`, `MAX` |
| `groups/` | `GROUP BY`, grouped sorting, `HAVING` |
| `joins/` | INNER / LEFT / FULL / NATURAL / multi-table joins + README |
| `subqueries/` | Scalar, nested, correlated, `IN`-style patterns |
| `sets/` | `UNION`, `INTERSECT`, `EXCEPT` |
| `designing/` | `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, primary/foreign keys, constraints |
| `writing/` | INSERT / UPDATE / DELETE, triggers, transactions + README |
| `views/` | Basic & aggregate views, CTEs, security views, soft deletions, view management + README |
| `optimizing/` | Indexes, `EXPLAIN QUERY PLAN`, timing, transactions, locking, VACUUM + README + SUMMARY |
| `scaling/` | MySQL & PostgreSQL setup, data types, MBTA schema variants, stored procedures, replication, access control, SQL injection prevention + README |

---

## Problem sets

| Lecture | Problems |
|---------|---------|
| Lecture 0 - Querying | Cyberchase, Normals, Players, Views |
| Lecture 1 - Relating | dese, moneyball, Packages |
| Lecture 2 - Designing | atl, connect, donuts |
| Lecture 3 - Writing | dont-panic, meteorites |
| Lecture 4 - Viewing | bnb, census, **private** (The Private Eye) |
| Lecture 5 - Optimizing | snap |
| Lecture 6 - Scaling | **deep** (partitioning/sharding answers), **dont-panic-java** (JDBC), **sentimental-connect** (LinkedIn-style schema) |

---

## JDBC Connection — Hands-on with Java

The `dont-panic-java` problem bridges SQL theory and Java backend development.  
It uses the **SQLite JDBC driver** (`sqlite-jdbc-3.43.0.0.jar`) to connect to a `.db` file from pure Java.

### Core JDBC pattern used (`Hack.java`)

```java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

// 1. Open connection
Connection conn = DriverManager.getConnection("jdbc:sqlite:dont-panic.db");

// 2. Build a parameterised query  →  prevents SQL injection
String sql = """
    UPDATE "users"
    SET password = ?
    WHERE username = 'admin';
""";

// 3. Prepare → bind → execute
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, newPassword);   // safely binds user input
ps.executeUpdate();
ps.close();
```

### Why this matters for Spring backend development

| CS50 SQL concept | Spring equivalent |
|------------------|-------------------|
| `DriverManager.getConnection()` | `DataSource` / `HikariCP` connection pool |
| `PreparedStatement` | `JdbcTemplate.update()` / `NamedParameterJdbcTemplate` |
| `ResultSet` | `RowMapper<T>` / `BeanPropertyRowMapper` |
| SQL injection prevention via `?` params | Spring's parameterised queries do this by default |
| Views & CTEs | Spring Data projections / `@Query` with native SQL |
| Indexes & EXPLAIN | Query tuning in production — same commands work in MySQL/PostgreSQL |
| Stored procedures | `@Procedure` annotation in Spring Data JPA |
| Access control (`GRANT`) | Database-level security alongside Spring Security |
| Transactions | `@Transactional` in Spring maps directly to `BEGIN / COMMIT / ROLLBACK` |
| Replication (leader/follower) | Spring `@Primary` + read-replica `DataSource` routing |

### How to compile and run the JDBC example

```powershell
cd "problems/Lecture 6 - Scaling/dont-panic-java"

# Compile
javac -cp "sqlite-jdbc-3.43.0.0.jar" Hack.java

# Run
java -cp ".;sqlite-jdbc-3.43.0.0.jar" Hack
```

> On Linux/macOS replace `;` with `:` in the classpath.

---

## Java Spring Backend Developer — Study Roadmap

This course directly supports the SQL foundation needed at every layer of Spring development.

```
CS50 SQL Lecture          →  Spring / Production Relevance
──────────────────────────────────────────────────────────────────────
L0  Querying              →  Writing JPQL / native @Query in repositories
L1  Relating              →  Designing @OneToMany, @ManyToMany entities & joins
L2  Designing             →  Schema migrations with Flyway / Liquibase
L3  Writing               →  Transactional writes, batch inserts, cascade ops
L4  Viewing               →  DB views as Spring Data projections / read models
L5  Optimizing            →  Index strategy, slow-query analysis in prod
L6  Scaling               →  Connection pooling, read replicas, stored procs,
                              JDBC direct usage, SQL injection prevention
```

### Skill progression

1. **Raw SQL first** (this repo) → understand what the framework generates
2. **Spring JDBC** (`JdbcTemplate`) → thin abstraction, full SQL control
3. **Spring Data JPA** (`@Repository`, `@Entity`) → ORM layer on top of SQL
4. **Production concerns** → Flyway migrations + HikariCP pool + query plans

---

## How to study with this repo

1. **Quick scan** — open the matching file in `Lectures Quick view/`
2. **Deep dive** — read `notes/` for full explanation with examples
3. **Practice syntax** — run queries from `queries/` against a local SQLite file
4. **Solve problems** — work through `problems/` for each lecture
5. **Review** — reference `summaries/` for syntax sheets

---

## Running SQL files with SQLite

```powershell
sqlite3
.open "schemas/Lecture 0/normals.db"
.read "queries/basic/select_where.sql"
.tables
.quit
```

Replace `.open` and `.read` paths for any database/query combination in this repo.

---

## Notes

- `Lectures Quick view/2- Desiging.md` — on-disk spelling preserved intentionally.
- `problems/Lecture 6 - Scaling/sentimental-connect/schema.sql` defines 6 tables: `users`, `schools`, `companies`, `connections`, `education`, `employment` (LinkedIn-style schema).
- `problems/Lecture 6 - Scaling/dont-panic-java/sqlite-jdbc-3.43.0.0.jar` is the JDBC driver required to compile and run `Hack.java`.

---

## 🎓 End of Course — CS50 SQL Complete

All 7 lectures of **Harvard CS50's Introduction to Databases with SQL** have been completed.

### What was covered

| Lecture | Topic | Status |
|---------|-------|--------|
| Lecture 0 | Querying | ✅ Complete |
| Lecture 1 | Relating | ✅ Complete |
| Lecture 2 | Designing | ✅ Complete |
| Lecture 3 | Writing | ✅ Complete |
| Lecture 4 | Viewing | ✅ Complete |
| Lecture 5 | Optimizing | ✅ Complete |
| Lecture 6 | Scaling | ✅ Complete |

### Skills acquired

- Writing complex SQL queries across SQLite, MySQL, and PostgreSQL
- Designing normalised relational schemas with proper keys and constraints
- Reading and writing data safely using transactions and triggers
- Building views, CTEs, and security layers over raw tables
- Optimising queries with indexes and execution plans (`EXPLAIN QUERY PLAN`)
- Scaling databases: replication models, sharding, access control
- Connecting to a database from Java using **JDBC + PreparedStatement**
- Preventing SQL injection at the driver level

### What comes next — Spring backend path

```
CS50 SQL (done ✅)
        ↓
Spring JDBC  →  JdbcTemplate, NamedParameterJdbcTemplate
        ↓
Spring Data JPA  →  @Entity, @Repository, JPQL, @Query
        ↓
Schema Migrations  →  Flyway / Liquibase
        ↓
Production  →  HikariCP pool, read-replica routing, slow-query logs
```

---

## Author

Omar Abdullah Moharam

## Last updated

March 15, 2026
