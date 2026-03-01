# Lecture 4 - Viewing: Complete Summary

## 📋 Overview

Lecture 4 focuses on **Views** - virtual tables that simplify queries, aggregate data, partition information, and enhance security.

---

## 🎯 Key Concepts

### 1. **What are Views?**
- Virtual tables defined by a query
- Don't store data separately (reference underlying tables)
- Update automatically when underlying data changes
- Stored in database schema (except temporary views and CTEs)

### 2. **Four Main Uses of Views**
1. **Simplifying** - Combine data from multiple tables
2. **Aggregating** - Store pre-calculated aggregate results
3. **Partitioning** - Divide data into logical pieces
4. **Securing** - Hide sensitive columns (PII protection)

---

## 📊 Types of Views

| Type | Keyword | Lifespan | Schema | Use Case |
|------|---------|----------|--------|----------|
| **Permanent View** | `CREATE VIEW` | Forever | ✅ Stored | Reusable queries |
| **Temporary View** | `CREATE TEMPORARY VIEW` | Connection | ❌ Not stored | Session-specific |
| **CTE** | `WITH ... AS` | Single query | ❌ Not stored | One-time calculation |

---

## 💡 Common Patterns

### Pattern 1: Simplifying Joins
```sql
-- Instead of complex nested queries
CREATE VIEW "longlist" AS
SELECT "name", "title" 
FROM "authors"
JOIN "authored" ON "authors"."id" = "authored"."author_id"
JOIN "books" ON "books"."id" = "authored"."book_id";

-- Simple query
SELECT "title" FROM "longlist" WHERE "name" = 'Author Name';
```

### Pattern 2: Aggregating Data
```sql
CREATE VIEW "average_book_ratings" AS
SELECT 
    "book_id",
    "title",
    ROUND(AVG("rating"), 2) AS "rating"
FROM "ratings"
JOIN "books" ON "ratings"."book_id" = "books"."id"
GROUP BY "book_id";
```

### Pattern 3: Using CTEs
```sql
WITH "book_ratings" AS (
    SELECT "book_id", AVG("rating") AS "avg_rating"
    FROM "ratings"
    GROUP BY "book_id"
)
SELECT * FROM "book_ratings" WHERE "avg_rating" >= 4.0;
```

### Pattern 4: Partitioning by Year
```sql
CREATE VIEW "2022" AS
SELECT "id", "title" FROM "books"
WHERE "year" = 2022;
```

### Pattern 5: Securing Data
```sql
-- Hide sensitive rider information
CREATE VIEW "analysis" AS
SELECT 
    "id", 
    "origin", 
    "destination",
    'Anonymous' AS "rider"
FROM "rides";
```

### Pattern 6: Soft Deletions
```sql
-- Add soft delete column
ALTER TABLE "collections" 
ADD COLUMN "deleted" INTEGER DEFAULT 0;

-- View shows only active records
CREATE VIEW "current_collections" AS
SELECT "id", "title", "accession_number"
FROM "collections"
WHERE "deleted" = 0;

-- INSTEAD OF trigger for deletions
CREATE TRIGGER "delete"
INSTEAD OF DELETE ON "current_collections"
FOR EACH ROW
BEGIN
    UPDATE "collections" SET "deleted" = 1 
    WHERE "id" = OLD."id";
END;
```

---

## 🔑 Important Keywords

### View Operations
- `CREATE VIEW` - Create permanent view
- `CREATE TEMPORARY VIEW` - Create session view
- `DROP VIEW` - Remove a view
- `WITH ... AS` - Create CTE

### Trigger Keywords (for views)
- `INSTEAD OF` - Intercept INSERT/UPDATE/DELETE on views
- `OLD` - Reference row being deleted/updated
- `NEW` - Reference row being inserted
- `FOR EACH ROW` - Trigger runs for each affected row
- `WHEN` - Add conditions to trigger

---

## 🎓 Best Practices

### ✅ DO:
- Use descriptive view names
- Document complex views with comments
- Use views to simplify frequently-used complex queries
- Create partitioned views for application-specific needs
- Use temporary views for testing
- Use CTEs for one-time calculations
- Implement soft deletions for data recovery

### ❌ DON'T:
- Over-complicate views (impacts performance)
- Rely solely on views for security (SQLite has no access control)
- Forget to drop unused views
- Create views on views on views (excessive nesting)
- Store massive result sets in views unnecessarily

---

## 🔒 Security Considerations

### Views for Privacy
- **Omit sensitive columns** - Don't include PII in analyst views
- **Anonymize data** - Replace names with 'Anonymous'
- **Mask information** - Show partial data (e.g., partial emails)
- **Aggregate only** - Share statistics, not individual records

### ⚠️ SQLite Limitations
- No built-in user permissions
- No access control on tables/views
- Anyone with database access can query original tables
- **Solution**: Use PostgreSQL, MySQL, or other DBMS for production

---

## 📈 Performance Tips

1. **Index underlying tables** - Views query the base tables
2. **Keep views simple** - Complex views = slower queries
3. **Use EXPLAIN QUERY PLAN** - Check query performance
4. **Partition large datasets** - Smaller views = faster queries
5. **Materialized views** - Not in SQLite, but concept exists in other DBMS

---

## 🛠️ Common Operations

```sql
-- List all views
SELECT "name" FROM "sqlite_master" WHERE "type" = 'view';

-- See view definition
SELECT "sql" FROM "sqlite_master" 
WHERE "type" = 'view' AND "name" = 'view_name';

-- Drop a view
DROP VIEW IF EXISTS "view_name";

-- Query a view (like a table)
SELECT * FROM "view_name";

-- Modify a view (drop and recreate)
DROP VIEW IF EXISTS "view_name";
CREATE VIEW "view_name" AS
SELECT "new_columns" FROM "table_name";
```

---

## 📚 Files in queries/views/

1. **basic_views.sql** - View fundamentals and simplification
2. **aggregate_views.sql** - Aggregation patterns and temporary views
3. **cte.sql** - Common Table Expressions with examples
4. **partitioning_views.sql** - Data partitioning strategies
5. **securing_views.sql** - Privacy and security patterns
6. **soft_deletions.sql** - Soft delete with triggers
7. **view_management.sql** - Administrative operations
8. **README.md** - Complete guide and reference

---

## 🎯 Practice Problems

### Lecture 4 - Viewing Problem Sets:
1. **BNB** (5 problems) - Airbnb data analysis with views
2. **Census** (4 problems) - Population data views
3. **Private** (1 problem) - Mystery solving with views

---

## 🔄 Comparison: Views vs Tables

| Feature | Tables | Views |
|---------|--------|-------|
| Stores Data | ✅ Yes | ❌ No (virtual) |
| Disk Space | High | Minimal |
| UPDATE/INSERT/DELETE | ✅ Direct | ⚠️ Needs triggers |
| Query Performance | Fast | Depends on complexity |
| Auto-updates | N/A | ✅ Yes |
| Schema Storage | ✅ Yes | ✅ Yes (except temp) |

---

## 💭 When to Use What?

### Use **Permanent Views** when:
- Query is used frequently across application
- Need to simplify complex joins for team
- Want to create different access levels
- Building APIs or applications

### Use **Temporary Views** when:
- Need view only during current session
- Testing query logic before making permanent
- Session-specific calculations
- Don't want to clutter schema

### Use **CTEs** when:
- One-time complex calculation
- Breaking down complex query for readability
- Multiple steps in single query
- Don't need reusability

### Use **Soft Deletions** when:
- Need data recovery capability
- Compliance requires audit trail
- Referential integrity is critical
- Analytics on deleted vs active data

---

## 🚀 Quick Start Commands

```bash
# Open database
sqlite3 database.db

# Load view examples
.read queries/views/basic_views.sql

# List all views
SELECT name FROM sqlite_master WHERE type = 'view';

# Check a view's definition
.schema view_name

# Query a view
SELECT * FROM view_name LIMIT 10;
```

---

## 📖 Additional Resources

- **Lecture Notes**: `notes/Lecture 4/04- Viewing.md`
- **Lecture Slides**: `Lecture Slides/lecture 4 - Viewing.pdf`
- **Quick View**: `Lectures Quick view/4- Viewing.md`
- **Source Code**: `Source Code/4-Viewing/`
- **Schemas**: `schemas/Lecture 4/`

---

## ✨ Key Takeaways

1. ✅ Views simplify complex queries by joining tables
2. ✅ Views don't store data - they're virtual tables
3. ✅ Views update automatically with underlying data
4. ✅ CTEs are perfect for one-time calculations
5. ✅ Temporary views exist only during connection
6. ✅ INSTEAD OF triggers enable INSERT/UPDATE/DELETE on views
7. ✅ Soft deletions preserve data while marking as deleted
8. ✅ Views enhance security but aren't complete solution in SQLite

---

**Master views to write cleaner, more maintainable SQL code! 🎉**

