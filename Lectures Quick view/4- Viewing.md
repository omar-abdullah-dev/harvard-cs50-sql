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

## 7️⃣ Securing with Views

Hide **Personally Identifiable Information (PII)** while sharing data.

### Original Table (contains PII)

| id | origin | destination | rider |
|----|--------|-------------|-------|
| 1 | Boston | New York | Alice |
| 2 | Seattle | Portland | Bob |

### Secured View (anonymized)

```sql
CREATE VIEW "analysis" AS
SELECT "id", "origin", "destination", 'Anonymous' AS "rider" 
FROM "rides";
```

Result:

| id | origin | destination | rider |
|----|--------|-------------|-------|
| 1 | Boston | New York | Anonymous |
| 2 | Seattle | Portland | Anonymous |

⚠️ **Note:** SQLite doesn't enforce access control — users can still query the original table. Use database permissions for true security.

---

## 8️⃣ Soft Deletions with Views

**Soft deletion** = Mark rows as deleted instead of removing them.

### Implementation

**Step 1:** Add `deleted` column

```sql
ALTER TABLE "collections" 
ADD COLUMN "deleted" INTEGER DEFAULT 0;
```

**Step 2:** Soft delete a row

```sql
UPDATE "collections" 
SET "deleted" = 1 
WHERE "title" = 'Farmers working at dawn';
```

**Step 3:** Create view of non-deleted rows

```sql
CREATE VIEW "current_collections" AS
SELECT "id", "title", "accession_number", "acquired" 
FROM "collections" 
WHERE "deleted" = 0;
```

---

## 9️⃣ INSTEAD OF Triggers

Views are read-only by default, but **INSTEAD OF triggers** let you modify underlying tables through views.

### Trigger for Deleting (Soft Delete)

```sql
CREATE TRIGGER "delete"
INSTEAD OF DELETE ON "current_collections"
FOR EACH ROW
BEGIN
    UPDATE "collections" SET "deleted" = 1 
    WHERE "id" = OLD."id";
END;
```

Now you can "delete" from the view:

```sql
DELETE FROM "current_collections" 
WHERE "title" = 'Imaginative landscape';
```

### Trigger for Inserting (Existing Row)

If row already exists but was soft-deleted, restore it:

```sql
CREATE TRIGGER "insert_when_exists"
INSTEAD OF INSERT ON "current_collections"
FOR EACH ROW 
WHEN NEW."accession_number" IN (
    SELECT "accession_number" FROM "collections"
)
BEGIN
    UPDATE "collections" 
    SET "deleted" = 0 
    WHERE "accession_number" = NEW."accession_number";
END;
```

### Trigger for Inserting (New Row)

If row doesn't exist, insert it:

```sql
CREATE TRIGGER "insert_when_new"
INSTEAD OF INSERT ON "current_collections"
FOR EACH ROW
WHEN NEW."accession_number" NOT IN (
    SELECT "accession_number" FROM "collections"
)
BEGIN
    INSERT INTO "collections" ("title", "accession_number", "acquired")
    VALUES (NEW."title", NEW."accession_number", NEW."acquired");
END;
```

---

## 🎯 Key Concepts from Lecture 4

- **Views** are virtual tables that simplify complex queries
- Views **don't store data** — they query underlying tables each time
- Use views to **simplify**, **aggregate**, **partition**, and **secure** data
- **Temporary views** exist only during your connection
- **CTEs** exist for a single query only
- Views automatically show **updated data** from underlying tables
- **INSTEAD OF triggers** let you insert/delete through views
- Combine views with soft deletions for flexible data management

---

## 📋 Quick Reference

### Create View
```sql
CREATE VIEW "view_name" AS
SELECT columns FROM table WHERE condition;
```

### Create Temporary View
```sql
CREATE TEMPORARY VIEW "view_name" AS
SELECT columns FROM table WHERE condition;
```

### Common Table Expression (CTE)
```sql
WITH "cte_name" AS (
    SELECT columns FROM table
)
SELECT * FROM "cte_name";
```

### Drop View
```sql
DROP VIEW "view_name";
```

### INSTEAD OF Trigger
```sql
CREATE TRIGGER "trigger_name"
INSTEAD OF DELETE ON "view_name"
FOR EACH ROW
BEGIN
    -- SQL statements
END;
```

### Join Tables (for Views)
```sql
SELECT columns FROM table1
JOIN table2 ON table1.id = table2.foreign_id;
```