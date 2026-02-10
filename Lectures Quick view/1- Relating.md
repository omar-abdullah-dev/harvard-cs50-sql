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

## 🧠 Notes

- All queries are written manually for learning purposes
- Focus is on understanding relationships, not memorizing syntax
- Concepts here are heavily used in backend development and interviews

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning relational databases with Harvard CS50 SQL