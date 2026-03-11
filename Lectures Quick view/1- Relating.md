# CS50 SQL – Lecture 1: Relating 🔗

This section covers **Lecture 1 (Relating)** from Harvard CS50 SQL. It focuses on understanding how **multiple tables** are connected in a relational database and how to query related data correctly using **keys, JOINs, subqueries, sets, and grouping**.

The queries in this lecture are organized by **concept**, not by dataset, to make revision and interview preparation easier.

---

## 📚 Topics Covered

- Relational databases and table relationships
- One-to-one, one-to-many, and many-to-many relationships
- Primary keys and foreign keys
- Junction (join) tables
- Subqueries
- The `IN` keyword
- JOINs (INNER JOIN, LEFT JOIN)
- Set operations (UNION, INTERSECT, EXCEPT)
- GROUP BY and HAVING

---

## 🗂️ Folder Structure

```
queries/
├── joins/
│   ├── inner_join.sql
│   ├── left_join.sql
│   ├── natural_join.sql
│   ├── right_join.sql
│   └── full_join.sql
│
├── subqueries/
│   ├── basic_subquery.sql
│   └── in_keyword.sql
│
├── sets/
│   ├── union.sql
│   ├── intersect.sql
│   └── except.sql
│
└── groups/
    ├── group_by.sql
    ├── having.sql
    └── group_order.sql
```

---

## 📁 Query Categories

### joins/

Contains SQL queries that combine data from multiple tables.

**Used for:**
- Retrieving related data across tables
- Understanding INNER vs LEFT joins
- Handling missing related data (NULL values)

**Example:**
```sql
SELECT books.title, publishers.publisher
FROM books
JOIN publishers
ON books.publisher_id = publishers.id;
```

---

### subqueries/

Contains queries that use nested SELECT statements.

**Used for:**
- Filtering data based on results from another query
- Handling one-to-many and many-to-many relationships
- Writing advanced SQL logic

**Example:**
```sql
SELECT title
FROM books
WHERE id IN (
    SELECT book_id
    FROM authored
    WHERE author_id = (
        SELECT id
        FROM authors
        WHERE name = 'Fernanda Melchor'
    )
);
```

---

### sets/

Contains queries that work with SQL result sets.

**Used for:**
- Combining results from multiple queries
- Finding common or exclusive values

**Example:**
```sql
SELECT name FROM authors
INTERSECT
SELECT name FROM translators;
```

---

### groups/

Contains queries that group data and apply aggregate functions.

**Used for:**
- Calculating values per group
- Filtering aggregated results
- Sorting grouped data

**Example:**
```sql
SELECT book_id, ROUND(AVG(rating), 2) AS avg_rating
FROM ratings
GROUP BY book_id
HAVING avg_rating > 4;
```

---

## 🎯 Goal of Lecture 1

- Understand how relational databases are designed
- Learn how tables are linked using keys
- Write correct JOIN queries across multiple tables
- Use subqueries and IN for complex filtering
- Analyze grouped data using GROUP BY and HAVING
- Prepare for real-world backend database queries

---

## 📖 SQL Syntax Reference

### Subqueries
```sql
-- Basic subquery
SELECT column1 FROM table1
WHERE column2 = (
    SELECT column_name FROM table2
    WHERE condition
);

-- Multi-level nesting
SELECT title FROM books
WHERE id IN (
    SELECT book_id FROM authored
    WHERE author_id = (
        SELECT id FROM authors
        WHERE name = 'Author Name'
    )
);
```

### IN Keyword
```sql
-- With literal values
SELECT * FROM table_name
WHERE column_name IN (value1, value2, value3);

-- With subquery
SELECT * FROM table_name
WHERE column_name IN (
    SELECT column_name FROM another_table
);

-- NOT IN
SELECT * FROM table_name
WHERE column_name NOT IN (value1, value2);
```

### JOIN Operations
```sql
-- INNER JOIN (default)
SELECT * FROM table1
JOIN table2 ON table1.id = table2.foreign_id;

-- LEFT JOIN (keep all from left table)
SELECT * FROM table1
LEFT JOIN table2 ON table1.id = table2.foreign_id;

-- RIGHT JOIN (keep all from right table)
SELECT * FROM table1
RIGHT JOIN table2 ON table1.id = table2.foreign_id;

-- Multiple JOINs
SELECT * FROM table1
JOIN table2 ON table1.id = table2.table1_id
JOIN table3 ON table2.id = table3.table2_id;

-- NATURAL JOIN (automatic matching columns)
SELECT * FROM table1
NATURAL JOIN table2;
```

### Set Operations
```sql
-- INTERSECT (common elements)
SELECT column FROM table1
INTERSECT
SELECT column FROM table2;

-- UNION (all unique elements)
SELECT column FROM table1
UNION
SELECT column FROM table2;

-- EXCEPT (elements in first but not second)
SELECT column FROM table1
EXCEPT
SELECT column FROM table2;
```

### GROUP BY and HAVING
```sql
-- Basic grouping
SELECT column1, COUNT(*) 
FROM table_name
GROUP BY column1;

-- With aggregate functions
SELECT column1, AVG(column2) AS avg_value
FROM table_name
GROUP BY column1;

-- Filter groups with HAVING
SELECT column1, COUNT(*) AS count
FROM table_name
GROUP BY column1
HAVING count > 5;

-- GROUP BY with ORDER BY
SELECT column1, AVG(column2) AS avg_val
FROM table_name
GROUP BY column1
HAVING avg_val > 100
ORDER BY avg_val DESC;
```

### Primary and Foreign Keys
```sql
-- Create table with primary key
CREATE TABLE table_name (
    id INTEGER,
    column_name TEXT,
    PRIMARY KEY(id)
);

-- Create table with foreign key
CREATE TABLE related_table (
    id INTEGER,
    table_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(table_id) REFERENCES table_name(id)
);
```

---

## 🧠 Notes

- All queries are written manually for learning purposes
- Focus is on understanding relationships, not memorizing syntax
- Concepts here are heavily used in backend development and interviews

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning relational databases with Harvard CS50 SQL