# Harvard CS50 – Introduction to Databases with SQL

> A comprehensive study repository containing notes, SQL queries, problem solutions, and database schemas from Harvard's CS50 Introduction to Databases course.

## 📚 About This Repository

This repository serves as a complete learning resource for mastering SQL fundamentals through Harvard's CS50 SQL course. It includes organized lecture materials, practice problems with solutions, reusable SQL query templates, and working database schemas for hands-on learning.

---

## 📂 Repository Structure

```
harvard-cs50-sql/
│
├── 📖 Lecture Slides/          # PDF presentations for all lectures
│   ├── lecture 0 - Querying.pdf
│   ├── lecture 1 - Relating.pdf
│   ├── lecture 2 - Designing.pdf
│   ├── lecture 3 - Writing.pdf
│   ├── lecture 4 - Viewing.pdf
│   └── lecture 5 - Optimizing.pdf
│
├── 📝 Lectures Quick view/     # Quick reference summaries
│   ├── 0- Querying.md
│   ├── 1- Relating.md
│   ├── 2- Desiging.md
│   ├── 3- Writing.md
│   ├── 4- Viewing.md
│   └── 5- Optimizing.md
│
├── 📓 notes/                   # Detailed lecture notes
│   ├── Lecture 0/             # Querying fundamentals
│   ├── Lecture 1/             # Relationships and joins
│   ├── Lecture 2/             # Database design
│   ├── Lecture 3/             # Writing and modifying data
│   ├── Lecture 4/             # Views and optimization
│   └── Lecture 5/             # Performance optimization and concurrency
│
├── 🎯 problems/                # Problem sets with solutions
│   ├── Lecture 0 - Querying/
│   │   ├── Cyberchase/       # 13 problems
│   │   ├── Normals/          # 10 problems
│   │   ├── players/          # 10 problems
│   │   └── Views/            # 10 problems
│   │
│   ├── Lecture 1 - Relating/
│   │   ├── dese/             # 13 problems (education data)
│   │   ├── moneyball/        # 12 problems (baseball stats)
│   │   └── Packages/         # Package management queries
│   │
│   ├── Lecture 2 - Designing/
│   │   ├── atl/              # Airport database schema
│   │   ├── connect/          # Social network schema
│   │   └── donuts/           # Donut shop schema
│   │
│   ├── Lecture 3 - Writing/
│   │   ├── dont-panic/       # Database manipulation
│   │   └── meteorites/       # Data import and cleaning
│   │
│   ├── Lecture 4 - Viewing/
│   │   ├── bnb/              # Airbnb data views (5 problems)
│   │   ├── census/           # Census data views (4 problems)
│   │   └── private/          # The Private Eye mystery (1 problem)
│   │
│   └── Lecture 5 - Optimizing/
│       └── snap/             # Social network optimization (4 problems)
│
├── 🔍 queries/                 # Reusable SQL query templates
│   ├── aggregations/         # AVG, COUNT, MIN, MAX, SUM
│   ├── basic/                # SELECT, WHERE, ORDER BY, LIKE, DISTINCT
│   ├── designing/            # CREATE, ALTER, DROP
│   ├── groups/               # GROUP BY, HAVING
│   ├── joins/                # INNER, LEFT, FULL joins
│   ├── sets/                 # UNION, INTERSECT, EXCEPT
│   ├── subqueries/           # Nested queries
│   ├── views/                # Views, CTEs, soft deletions (Lecture 4)
│   ├── writing/              # INSERT, UPDATE, DELETE, Triggers (Lecture 3)
│   └── optimizing/           # Indexes, VACUUM, transactions, concurrency (Lecture 5)
│
├── 💾 schemas/                 # Database files (.db)
│   ├── Lecture 0/            # Practice databases (cyberchase.db, normals.db, players.db, views.db)
│   ├── Lecture 1/            # Relational databases (dese/, moneyball/, packages/)
│   ├── Lecture 2/            # Design examples (ATL/, connect/, donuts/)
│   ├── Lecture 3/            # Writing exercises (dont-panic/, meteorites/)
│   └── Lecture 4/            # Viewing databases (bnb/, census/, private/)
│
├── 📦 Source Code/            # Official course materials
│   ├── 0-Querying/
│   ├── 1-Relating/
│   ├── 2-Designing/
│   ├── 3-Writing/
│   └── 4-Viewing/
│
├── 📋 summaries/              # Additional SQL references
│   ├── SQL-APNA College.pdf
│   └── SQL-Summary.pdf
│
└── 📄 README.md               # This file
```

---

## 🎓 Course Content Overview

### Lecture 0: Querying
**Learn the fundamentals of SQL queries**
- `SELECT` statements and basic queries
- Filtering with `WHERE` clauses
- Pattern matching with `LIKE`
- Sorting with `ORDER BY`
- Aggregation functions (COUNT, AVG, SUM, MIN, MAX)
- Working with NULL values
- Date and time filtering

**Practice Problems:**
- **Cyberchase** (13 problems): Query a TV show database
- **Normals** (10 problems): Analyze meteorological data
- **Players** (10 problems): Baseball player statistics
- **Views** (10 problems): Museum exhibition data

---

### Lecture 1: Relating
**Master relationships between tables**
- `JOIN` operations (INNER, LEFT, RIGHT, FULL)
- One-to-many and many-to-many relationships
- Set operations (UNION, INTERSECT, EXCEPT)
- `GROUP BY` and `HAVING` clauses
- Subqueries and nested SELECT statements

**Practice Problems:**
- **DESE** (13 problems): Massachusetts education data analysis
- **Moneyball** (12 problems): Baseball statistics and analytics
- **Packages** (1 problem): Package dependency analysis

---

### Lecture 2: Designing
**Design efficient database schemas**
- Database normalization
- Primary and foreign keys
- Table constraints (NOT NULL, UNIQUE, CHECK)
- One-to-one, one-to-many, many-to-many relationships
- Indexes for performance
- Entity-Relationship (ER) diagrams

**Practice Problems:**
- **ATL** (schema design): Airport database design
- **Connect** (schema design): Social network database
- **Donuts** (schema design): Donut shop order system

---

### Lecture 3: Writing
**Modify and maintain databases**
- `INSERT` statements to add data
- `UPDATE` statements to modify records
- `DELETE` statements to remove data
- Importing data from CSV files
- Triggers for automated actions
- Soft deletes vs. hard deletes
- Transactions and data integrity

**Practice Problems:**
- **Don't Panic** (SQL injection): Database security
- **Meteorites** (data import): Clean and import meteorite data

---

### Lecture 4: Viewing
**Create and optimize database views**
- Creating views with `CREATE VIEW`
- Temporary vs. permanent views
- Materialized views
- Common Table Expressions (CTEs)
- Query optimization techniques
- Partitioning and indexing strategies

**Practice Problems:**
- **BNB** (5 problems): Analyze Airbnb listings and create views for property searches
- **Census** (4 problems): Population data analysis with views
- **Private** (1 problem): Use views and queries to solve "The Private Eye" mystery

---

### Lecture 5: Optimizing
**Advanced performance optimization and concurrency**
- Creating and dropping indexes
- B-Tree data structures
- Query execution plans with `EXPLAIN QUERY PLAN`
- Space and time trade-offs
- Partial indexes for specific queries
- `VACUUM` command to reclaim space
- ACID transactions (Atomicity, Consistency, Isolation, Durability)
- Concurrency and database locking
- Race conditions and prevention
- Timing queries with `.timer on`

**Database:** IMDb (movies.db) - Large-scale movie database with millions of records

**Practice Problems:**
- **Snap** (4 problems): Optimize a social media database with indexing strategies

---

## 🚀 Getting Started

### Prerequisites
- **SQLite3** installed on your system
- A SQL client (recommended: [DB Browser for SQLite](https://sqlitebrowser.org/))
- Text editor or IDE (VS Code, IntelliJ IDEA, etc.)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/harvard-cs50-sql.git
   cd harvard-cs50-sql
   ```

2. **Open a database:**
   ```bash
   sqlite3 schemas/Lecture\ 0/normals.db
   ```

3. **Run SQL queries:**
   ```sql
   -- List all tables
   .tables
   
   -- Run a query
   SELECT * FROM table_name LIMIT 10;
   
   -- Execute a SQL file
   .read queries/basic/select_where.sql
   ```

---

## 💡 How to Use This Repository

### For Learning:
1. **Start with Quick View** → Read the lecture summary in `Lectures Quick view/`
2. **Review Slides** → Study the PDF in `Lecture Slides/`
3. **Read Detailed Notes** → Dive deep in `notes/`
4. **Practice Queries** → Experiment with examples in `queries/`
5. **Solve Problems** → Work through `problems/` directories
6. **Check Schemas** → Explore database structures in `schemas/`

### For Quick Reference:
- **Need a specific query?** → Check `queries/` by topic
- **Forgot syntax?** → Review `summaries/` PDFs
- **Need example data?** → Use databases in `schemas/`

### Study Order (Recommended):
```
Week 1: Lecture 0 (Querying)
  ├── Watch lecture + review slides
  ├── Read notes/Lecture 0/
  ├── Practice with queries/basic/
  └── Solve problems/Lecture 0 - Querying/

Week 2: Lecture 1 (Relating)
  ├── Watch lecture + review slides
  ├── Read notes/Lecture 1/
  ├── Practice with queries/joins/ and queries/subqueries/
  └── Solve problems/Lecture 1 - Relating/

Week 3: Lecture 2 (Designing)
  ├── Watch lecture + review slides
  ├── Read notes/Lecture 2/
  ├── Practice with queries/designing/
  └── Design schemas in problems/Lecture 2 - Designing/

Week 4: Lecture 3 (Writing)
  ├── Watch lecture + review slides
  ├── Read notes/Lecture 3/
  ├── Practice with queries/writing/
  ├── Review Source Code/3-Writing/
  └── Complete problems/Lecture 3 - Writing/

Week 5: Lecture 4 (Viewing)
  ├── Watch lecture + review slides
  ├── Read notes/Lecture 4/
  ├── Practice with queries/views/
  ├── Review Source Code/4-Viewing/
  └── Complete problems/Lecture 4 - Viewing/

Week 6: Lecture 5 (Optimizing)
  ├── Watch lecture + review slides
  ├── Read notes/Lecture 5/
  ├── Practice with queries/optimizing/
  ├── Review Source Code/5-Optimizing/
  └── Complete practice problems (when available)
```

---

## 📂 Query Templates Library

The `queries/` folder contains organized SQL query examples and patterns for quick reference:

### **views/** (Lecture 4 - NEW! ✨)
Comprehensive examples for working with views, CTEs, and advanced patterns:
- **basic_views.sql** - Creating and using simple views, joining tables
- **aggregate_views.sql** - Views with AVG, COUNT, SUM and temporary views
- **cte.sql** - Common Table Expressions with WITH clause
- **partitioning_views.sql** - Dividing data into logical pieces
- **securing_views.sql** - Protecting PII and sensitive data
- **soft_deletions.sql** - Soft delete patterns with INSTEAD OF triggers
- **view_management.sql** - Creating, dropping, and managing views
- **README.md** - Complete guide with best practices and comparisons

### **writing/** (Lecture 3 - NEW! ✨)
Comprehensive examples for data modification and automation:
- **insert.sql** - INSERT statements, bulk inserts, CSV imports
- **update.sql** - UPDATE with calculations, subqueries, CASE statements
- **delete.sql** - DELETE operations, foreign keys, cascading deletes
- **triggers.sql** - BEFORE/AFTER triggers, OLD/NEW keywords, automation
- **transactions.sql** - BEGIN/COMMIT/ROLLBACK, savepoints, ACID properties
- **README.md** - Complete guide with safety practices and examples

### Other Query Folders:
- **basic/** - SELECT, WHERE, ORDER BY, LIKE, DISTINCT, BETWEEN, filtering
- **joins/** - INNER, LEFT, RIGHT, FULL joins with examples
- **aggregations/** - AVG, COUNT, MIN, MAX, SUM functions
- **groups/** - GROUP BY, HAVING clause patterns
- **subqueries/** - Nested queries and IN keyword
- **sets/** - UNION, INTERSECT, EXCEPT operations
- **designing/** - CREATE, ALTER, DROP table operations

---

## 🔧 Useful SQL Commands

### Basic Commands
```sql
.open database.db          -- Open a database
.tables                    -- List all tables
.schema table_name         -- Show table structure
.mode column               -- Format output as columns
.headers on                -- Show column headers
.read file.sql             -- Execute SQL from file
.output results.txt        -- Save output to file
.quit                      -- Exit SQLite
```

---

## 📊 Problem Set Quick Reference

| Problem Set | Topic | Count | Difficulty |
|------------|-------|-------|------------|
| Cyberchase | Querying | 13 | ⭐ Easy |
| Normals | Querying | 10 | ⭐⭐ Medium |
| Players | Querying | 10 | ⭐⭐ Medium |
| Views | Querying | 10 | ⭐⭐ Medium |
| DESE | Relating | 13 | ⭐⭐⭐ Hard |
| Moneyball | Relating | 12 | ⭐⭐⭐ Hard |
| Packages | Relating | 1 | ⭐⭐ Medium |
| ATL | Designing | Schema | ⭐⭐ Medium |
| Connect | Designing | Schema | ⭐⭐⭐ Hard |
| Donuts | Designing | Schema | ⭐⭐ Medium |
| Don't Panic | Writing | Security | ⭐⭐ Medium |
| Meteorites | Writing | Import | ⭐⭐⭐ Hard |
| BNB | Viewing | Views | ⭐⭐ Medium |
| Census | Viewing | Views | ⭐⭐ Medium |
| Private | Viewing | Mystery | ⭐⭐⭐ Hard |
| Snap | Optimizing | Indexes | ⭐⭐⭐ Hard |

---

## 🎯 Key SQL Concepts Covered

### Data Querying
- ✅ SELECT, WHERE, ORDER BY, LIMIT
- ✅ Filtering and pattern matching (LIKE, BETWEEN, IN)
- ✅ Aggregate functions (COUNT, AVG, SUM, MIN, MAX)
- ✅ NULL handling (IS NULL, IS NOT NULL)

### Relationships
- ✅ INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN
- ✅ Many-to-many relationships with junction tables
- ✅ Subqueries and nested queries
- ✅ Set operations (UNION, INTERSECT, EXCEPT)

### Database Design
- ✅ Primary keys and foreign keys
- ✅ Normalization (1NF, 2NF, 3NF)
- ✅ Constraints (NOT NULL, UNIQUE, CHECK, DEFAULT)
- ✅ Indexes for performance optimization

### Data Manipulation
- ✅ INSERT, UPDATE, DELETE statements
- ✅ Data import from CSV files
- ✅ Triggers for automation
- ✅ Transactions and ACID properties

### Views & Optimization
- ✅ CREATE VIEW for virtual tables
- ✅ Common Table Expressions (CTEs)
- ✅ Query performance optimization
- ✅ Indexes and query planning

---

## 🛠️ Tools & Resources

### Recommended Tools
- **[DB Browser for SQLite](https://sqlitebrowser.org/)** - Visual database management
- **[SQLite Online](https://sqliteonline.com/)** - Browser-based SQL practice
- **[SQL Fiddle](http://sqlfiddle.com/)** - Test queries online
- **[SQLite Documentation](https://www.sqlite.org/docs.html)** - Official reference

### Additional Learning Resources
- [CS50 SQL Course](https://cs50.harvard.edu/sql/) - Official course page
- [SQL Cheat Sheet](https://www.sqltutorial.org/sql-cheat-sheet/) - Quick reference
- [SQLZoo](https://sqlzoo.net/) - Interactive SQL tutorials
- [LeetCode SQL Problems](https://leetcode.com/problemset/database/) - Practice problems

---

## 📝 Notes Structure

Each lecture's notes folder contains:
- **Markdown notes** with code examples
- **Images/diagrams** for visual learning
- **Key concepts** and best practices
- **Common pitfalls** and how to avoid them

---

## 🤝 Contributing

This is a personal study repository, but suggestions are welcome!

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

---

## 📄 License

This repository is for educational purposes. Course materials are property of Harvard University and CS50.

---

## 👤 Author

**Omar Abdullah Moharam**
- Studying SQL fundamentals through Harvard's CS50
- Goal: Master database concepts for backend development
- Next steps: JDBC and Java backend integration

---

## 🙏 Acknowledgments

- **Harvard University** and **CS50 Team** for the excellent course
- **David J. Malan** and **Carter Zenke** as instructors for clear explanations
- The SQL community for continuous learning resources

---

## 📅 Last Updated

March 4, 2026

---

**Happy Learning! 🚀📊**

> "Data is the new oil, and SQL is the refinery." - Learn it well!
