# CS50 SQL – Lecture 0: Querying 🗃️

This section covers **Lecture 0 (Querying)** from Harvard CS50 SQL.

It focuses on building **strong SQL fundamentals** by practicing how to retrieve, filter, sort, and analyze data using SQL queries.

The queries in this lecture are organized by **concept**, not by dataset, to make revision and interview preparation easier.

---

## 📚 Topics Covered

- SELECT statements
- Filtering data using WHERE
- Sorting results with ORDER BY
- Handling NULL values
- Working with dates
- Aggregate functions (COUNT, AVG, MIN, MAX)
- Subqueries (nested SELECT statements)

---

## 🗂️ Folder Structure
```
queries/
├── basic/
│   ├── select_where.sql
│   ├── filtering.sql
│   ├── order_by.sql
│   ├── date_filtering.sql
│   └── null_checks.sql
│
├── aggregations/
│   ├── count.sql
│   ├── avg.sql
│   └── min_max.sql
│
├── subqueries/
│   ├── above_average.sql
│   └── max_comparison.sql
│
└── joins/
    └── README.md
```

---

## 📁 basic/

Contains simple SQL queries without aggregation or subqueries.

**Used for:**
- Selecting specific columns
- Filtering rows with WHERE
- Sorting results
- Date filtering
- NULL checks

**Example:**
```sql
SELECT first_name, last_name
FROM players
WHERE birth_country <> 'USA'
ORDER BY first_name, last_name;
```

---

## 📁 aggregations/

Contains queries that summarize data using aggregate functions.

**Used for:**
- Counting rows
- Calculating averages
- Finding minimum and maximum values
- Formatting numeric results

**Example:**
```sql
SELECT ROUND(AVG(height), 2) AS "Average Height"
FROM players
WHERE debut >= '2000-01-01';
```

---

## 📁 subqueries/

Contains more advanced queries using nested SELECT statements.

**Used for:**
- Comparing values against averages
- Filtering using MAX or AVG
- Writing interview-level SQL logic

**Example:**
```sql
SELECT first_name, last_name
FROM players
WHERE height > (
    SELECT AVG(height)
    FROM players
)
ORDER BY height DESC;
```

---

## 📁 joins/

This folder is intentionally empty for now.

JOINs will be covered in Lecture 1, including:
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- Table relationships and foreign keys

---

## 🎯 Goal of Lecture 0

- Understand SQL querying deeply (not memorization)
- Write clean and readable SQL queries
- Prepare for backend development topics such as JDBC
- Build a solid foundation for SQL interviews

---

## 🧠 Notes

- All queries are written manually for learning purposes
- Focus is on logic and understanding, not shortcuts
- This section is continuously updated as part of the learning journey

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning SQL fundamentals with Harvard CS50