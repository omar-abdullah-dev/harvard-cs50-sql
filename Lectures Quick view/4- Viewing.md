# CS50 SQL – Lecture 4: Viewing 👁️

This lecture focuses on creating and using views to access data.
Instead of complex queries, we now learn how to:

- Create virtual tables (views)
- Simplify complex joins
- Aggregate data efficiently
- Partition data into logical pieces
- Secure sensitive information

---

## 1️⃣ What are Views?

**View** = A virtual table defined by a query.

Views don't store data themselves — they pull from underlying tables each time they're queried.

### Why Use Views?

| Purpose | Description |
|---------|-------------|
| **Simplifying** | Combine data from multiple tables |
| **Aggregating** | Store results of calculations |
| **Partitioning** | Divide data into logical pieces |
| **Securing** | Hide sensitive columns |

> Views consume minimal disk space since they only store the query definition, not the data.

---

## 2️⃣ Simplifying with Views

### The Problem

Finding books by an author requires complex nested queries:

```sql
SELECT "title" FROM "books"
WHERE "id" IN (
    SELECT "book_id" FROM "authored"
    WHERE "author_id" = (
        SELECT "id" FROM "authors"
        WHERE "name" = 'Fernanda Melchor'
    )
);
```

### The Solution: Create a View

**Step 1:** Join tables together

```sql
SELECT "name", "title" FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";
```

**Step 2:** Save as a view

```sql
CREATE VIEW "longlist" AS
SELECT "name", "title" FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";
```

**Step 3:** Query the view simply

```sql
SELECT "title" FROM "longlist" 
WHERE "name" = 'Fernanda Melchor';
```

✨ **Much simpler!**

### Ordering Views

You can order data **when querying** a view:

```sql
SELECT "name", "title"
FROM "longlist"
ORDER BY "title";
```

Or include `ORDER BY` **in the view definition** itself.

---

## 3️⃣ Aggregating with Views

### Calculate Average Ratings

Store aggregated data for easy reuse:

```sql
CREATE VIEW "average_book_ratings" AS
SELECT "book_id" AS "id", "title", "year", 
       ROUND(AVG("rating"), 2) AS "rating" 
FROM "ratings"
JOIN "books" ON "ratings"."book_id" = "books"."id"
GROUP BY "book_id";
```

### Query the Aggregated View

```sql
SELECT * FROM "average_book_ratings";
```

### Calculate Averages Per Year

Use the view to create **another aggregation**:

```sql
SELECT "year", ROUND(AVG("rating"), 2) AS "rating" 
FROM "average_book_ratings" 
GROUP BY "year";
```

> Each time you query a view, it pulls fresh data from underlying tables — always up-to-date!

---

## 4️⃣ Temporary Views

**Temporary views** exist only for your current database connection.

### Create Temporary View

```sql
CREATE TEMPORARY VIEW "average_ratings_by_year" AS
SELECT "year", ROUND(AVG("rating"), 2) AS "rating" 
FROM "average_book_ratings" 
GROUP BY "year";
```

**Use case:** Testing queries without cluttering the schema.

### Drop a View

```sql
DROP VIEW "average_book_ratings";
```

---

## 5️⃣ Common Table Expressions (CTE)

**CTE** = A view that exists for a **single query only**.

### Syntax

```sql
WITH "average_book_ratings" AS (
    SELECT "book_id", "title", "year", 
           ROUND(AVG("rating"), 2) AS "rating" 
    FROM "ratings"
    JOIN "books" ON "ratings"."book_id" = "books"."id"
    GROUP BY "book_id"
)
SELECT "year", ROUND(AVG("rating"), 2) AS "rating" 
FROM "average_book_ratings"
GROUP BY "year";
```

### View Lifespan Comparison

| Type | Lifespan |
|------|----------|
| **Regular View** | Forever (stored in schema) |
| **Temporary View** | Current connection |
| **CTE** | Single query only |

---

## 6️⃣ Partitioning with Views

Break data into **logical pieces** for specific purposes.

### Example: Books by Year

```sql
CREATE VIEW "2022" AS
SELECT "id", "title" FROM "books"
WHERE "year" = 2022;
```

Query the partitioned view:

```sql
SELECT * FROM "2022";
```

**Use case:** Website pages showing longlisted books per year.

---

## 📖 Complete SQL Syntax Reference

### CREATE VIEW
```sql
-- Basic view
CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;

-- View with JOIN
CREATE VIEW view_name AS
SELECT t1.column1, t2.column2
FROM table1 t1
JOIN table2 t2 ON t1.id = t2.foreign_id;

-- View with aggregation
CREATE VIEW view_name AS
SELECT column1, COUNT(*) AS count, AVG(column2) AS average
FROM table_name
GROUP BY column1;

-- View with ORDER BY
CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
ORDER BY column1 DESC;

-- Complex view with multiple joins and aggregation
CREATE VIEW sales_summary AS
SELECT 
    p.name AS product_name,
    c.name AS category_name,
    COUNT(s.id) AS total_sales,
    SUM(s.amount) AS total_revenue
FROM products p
JOIN categories c ON p.category_id = c.id
LEFT JOIN sales s ON p.id = s.product_id
GROUP BY p.id, c.id;
```

### CREATE TEMPORARY VIEW
```sql
-- Temporary view (exists only for current session)
CREATE TEMPORARY VIEW temp_view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;

-- Short form
CREATE TEMP VIEW temp_view_name AS
SELECT column1, column2
FROM table_name;
```

### DROP VIEW
```sql
-- Remove a view
DROP VIEW view_name;

-- Remove if exists (no error if doesn't exist)
DROP VIEW IF EXISTS view_name;

-- Drop temporary view
DROP VIEW IF EXISTS temp_view_name;
```

### Common Table Expressions (CTE)
```sql
-- Basic CTE
WITH cte_name AS (
    SELECT column1, column2
    FROM table_name
    WHERE condition
)
SELECT * FROM cte_name;

-- Multiple CTEs
WITH 
cte1 AS (
    SELECT column1, column2 FROM table1
),
cte2 AS (
    SELECT column1, column3 FROM table2
)
SELECT cte1.column1, cte1.column2, cte2.column3
FROM cte1
JOIN cte2 ON cte1.column1 = cte2.column1;

-- CTE with aggregation
WITH average_ratings AS (
    SELECT book_id, AVG(rating) AS avg_rating
    FROM ratings
    GROUP BY book_id
)
SELECT books.title, average_ratings.avg_rating
FROM books
JOIN average_ratings ON books.id = average_ratings.book_id
WHERE average_ratings.avg_rating > 4.0;

-- Recursive CTE (advanced)
WITH RECURSIVE counter(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM counter WHERE n < 10
)
SELECT * FROM counter;
```

### Querying Views
```sql
-- Query like a regular table
SELECT * FROM view_name;

-- With WHERE clause
SELECT * FROM view_name WHERE column1 > 100;

-- With JOIN
SELECT v.column1, t.column2
FROM view_name v
JOIN table_name t ON v.id = t.view_id;

-- With aggregation
SELECT column1, COUNT(*) 
FROM view_name
GROUP BY column1;
```

### View Patterns for Different Purposes

#### 1. Simplifying Complex Queries
```sql
-- Instead of this complex query every time:
SELECT users.name, orders.total, products.name
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id;

-- Create a view once:
CREATE VIEW user_orders AS
SELECT users.name AS user_name, orders.total, products.name AS product_name
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id;

-- Query simply:
SELECT * FROM user_orders WHERE user_name = 'John';
```

#### 2. Aggregating Data
```sql
-- Pre-aggregated data view
CREATE VIEW daily_sales AS
SELECT 
    DATE(order_date) AS sale_date,
    COUNT(*) AS total_orders,
    SUM(total) AS total_revenue,
    AVG(total) AS average_order_value
FROM orders
GROUP BY DATE(order_date);

-- Easy to query
SELECT * FROM daily_sales WHERE sale_date = '2024-01-15';
```

#### 3. Securing Data
```sql
-- Hide sensitive columns
CREATE VIEW public_users AS
SELECT id, username, email, created_at
FROM users;
-- Password, social_security, etc. are hidden

-- Grant access to view, not base table
-- (In production databases with access control)
```

#### 4. Partitioning Data
```sql
-- Active users only
CREATE VIEW active_users AS
SELECT * FROM users WHERE status = 'active';

-- Recent orders
CREATE VIEW recent_orders AS
SELECT * FROM orders WHERE order_date >= DATE('now', '-30 days');

-- High-value customers
CREATE VIEW vip_customers AS
SELECT user_id, SUM(total) AS lifetime_value
FROM orders
GROUP BY user_id
HAVING lifetime_value > 10000;
```

### Checking if View Exists
```sql
-- SQLite: Check schema
.schema view_name

-- Or query sqlite_master
SELECT name FROM sqlite_master 
WHERE type = 'view' AND name = 'view_name';

-- List all views
SELECT name FROM sqlite_master WHERE type = 'view';
```

### Replacing a View
```sql
-- Drop and recreate
DROP VIEW IF EXISTS view_name;
CREATE VIEW view_name AS
SELECT column1, column2 FROM table_name;

-- Note: SQLite doesn't have CREATE OR REPLACE VIEW
-- Must drop first, then create
```

---

## 💡 Best Practices for Views

1. **Use descriptive names** - `monthly_sales_summary` not `view1`
2. **Document complex views** - Add comments explaining the logic
3. **Consider performance** - Views are re-executed each time
4. **Use CTEs for one-off queries** - Don't clutter schema
5. **Secure sensitive data** - Views can hide columns
6. **Test before deployment** - Ensure views return correct data
7. **Regular views for common queries** - Temporary for testing
8. **Don't nest too deeply** - View of a view of a view gets slow

---

## ⚠️ View Limitations

- Views don't store data (always query underlying tables)
- Complex views can be slow
- Can't always UPDATE/DELETE through views
- Schema changes to base tables may break views
- No indexes on views (indexes are on base tables)

---

## 🎯 When to Use Each Type

| Type | When to Use |
|------|-------------|
| **Regular View** | Frequently used query, permanent simplification |
| **Temporary View** | Testing, session-specific data, prototyping |
| **CTE** | One-time complex query, intermediate results |

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning views and CTEs with Harvard CS50 SQL
