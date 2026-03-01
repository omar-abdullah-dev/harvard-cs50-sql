# Views - Lecture 4 Query Examples

This folder contains SQL query examples and patterns for working with **Views** in SQLite, based on Harvard CS50 SQL Lecture 4.

## 📚 Files Overview

### 1. **basic_views.sql**
- Creating simple views
- Joining multiple tables
- Simplifying complex nested queries
- Ordering data in views
- Basic view operations

**Key Concepts:**
- Views as virtual tables
- Simplifying queries with views
- Views don't store data separately

---

### 2. **aggregate_views.sql**
- Creating views with aggregate functions (AVG, COUNT, SUM, etc.)
- Temporary views vs permanent views
- Nested aggregations using views
- Multiple aggregate functions in one view

**Key Concepts:**
- Pre-calculating aggregations
- Temporary views (connection-based)
- Building views on top of other views
- Automatic updates when data changes

---

### 3. **cte.sql**
- Common Table Expressions (WITH clause)
- Single-query temporary views
- Chaining multiple CTEs
- Complex filtering with CTEs
- Recursive CTEs

**Key Concepts:**
- CTEs exist for single query only
- Multiple CTEs in one query
- Improved readability
- No schema storage

**Comparison:**
| Type | Lifespan | Stored in Schema | Use Case |
|------|----------|------------------|----------|
| View | Permanent | ✅ Yes | Reusable queries |
| Temporary View | Connection | ❌ No | Session-specific |
| CTE | Single Query | ❌ No | One-time calculation |

---

### 4. **partitioning_views.sql**
- Partitioning data by year, category, or other criteria
- Creating focused subsets of data
- Multiple views for different audiences
- Application-specific views

**Key Concepts:**
- Breaking large datasets into logical pieces
- Views for different website pages/sections
- Performance optimization with smaller datasets

**Use Cases:**
- Website page-specific data
- Department-specific access
- Time-period based partitions
- Category-based filtering

---

### 5. **securing_views.sql**
- Protecting PII (Personally Identifiable Information)
- Anonymizing sensitive data
- Masking data with string functions
- Role-based views
- Aggregated data for privacy

**Key Concepts:**
- Omitting sensitive columns
- Data anonymization techniques
- Different access levels through views
- Application-level security

**⚠️ Important Security Notes:**
- SQLite doesn't support user permissions
- Views alone don't prevent direct table access
- Use proper DBMS (PostgreSQL, MySQL) for production security
- Views are one layer, not complete security solution

---

### 6. **soft_deletions.sql**
- Soft deletion pattern (marking as deleted)
- Views to show only active records
- INSTEAD OF triggers for views
- INSERT/UPDATE/DELETE operations on views
- Restoring soft-deleted records

**Key Concepts:**
- Soft delete vs hard delete
- INSTEAD OF triggers
- OLD and NEW keywords in triggers
- WHEN clause for conditional triggers

**Benefits:**
- ✅ Data recovery capability
- ✅ Audit trail preservation
- ✅ Referential integrity maintained
- ✅ Compliance with retention policies

**Drawbacks:**
- ⚠️ Increased storage usage
- ⚠️ Query complexity
- ⚠️ Performance considerations

---

### 7. **view_management.sql**
- Creating and dropping views
- Listing existing views
- Modifying views (drop and recreate)
- View metadata queries
- Best practices and common patterns

**Key Concepts:**
- No ALTER VIEW in SQLite
- Views in sqlite_master table
- EXPLAIN QUERY PLAN for performance
- View documentation practices

---

## 🎯 Quick Reference

### Create a View
```sql
CREATE VIEW "view_name" AS
SELECT "column1", "column2"
FROM "table_name";
```

### Create Temporary View
```sql
CREATE TEMPORARY VIEW "temp_view" AS
SELECT * FROM "table_name";
```

### Create CTE
```sql
WITH "cte_name" AS (
    SELECT * FROM "table_name"
)
SELECT * FROM "cte_name";
```

### Drop a View
```sql
DROP VIEW IF EXISTS "view_name";
```

### Query a View
```sql
SELECT * FROM "view_name";
```

### List All Views
```sql
SELECT "name" FROM "sqlite_master" WHERE "type" = 'view';
```

---

## 🔍 When to Use Each Type

| Scenario | Recommended Type |
|----------|------------------|
| Frequently used complex query | **Permanent View** |
| One-time calculation in a query | **CTE** |
| Session-specific aggregation | **Temporary View** |
| Securing sensitive data | **Permanent View** |
| Testing query logic | **Temporary View or CTE** |
| Website page-specific data | **Permanent View** |

---

## 💡 Best Practices

1. **Naming Convention**
   - Use descriptive names: `active_users_with_orders`
   - Prefix temporary views: `temp_sales_summary`
   - Year-based partitions: `orders_2024`

2. **Performance**
   - Keep views simple when possible
   - Use EXPLAIN QUERY PLAN to check performance
   - Consider indexes on underlying tables

3. **Documentation**
   - Comment complex views
   - Document purpose and update date
   - Maintain a view catalog

4. **Security**
   - Explicitly SELECT needed columns only
   - Don't rely solely on views for security
   - Regular audit of exposed data

5. **Maintenance**
   - Drop unused views
   - Update views when schema changes
   - Test views after table modifications

---

## 📖 Related Topics

- **Joins** (queries/joins/) - Views often use joins
- **Aggregations** (queries/aggregations/) - Common in aggregate views
- **Subqueries** (queries/subqueries/) - Views can replace complex subqueries
- **Triggers** (designing/) - INSTEAD OF triggers for view operations

---

## 🎓 Learning Path

1. Start with **basic_views.sql** - Understand view fundamentals
2. Move to **aggregate_views.sql** - Learn aggregation patterns
3. Study **cte.sql** - Master temporary query-level views
4. Explore **partitioning_views.sql** - Data organization strategies
5. Review **securing_views.sql** - Security and privacy patterns
6. Practice **soft_deletions.sql** - Advanced trigger patterns
7. Reference **view_management.sql** - Administrative operations

---

## 🚀 Quick Start

```bash
# Open SQLite database
sqlite3 database_name.db

# Enable headers and column mode
.headers on
.mode column

# Load and execute examples
.read queries/views/basic_views.sql

# List all views
SELECT name FROM sqlite_master WHERE type = 'view';

# Check view definition
.schema view_name
```

---

## 📚 Additional Resources

- [SQLite View Documentation](https://www.sqlite.org/lang_createview.html)
- [SQLite Trigger Documentation](https://www.sqlite.org/lang_createtrigger.html)
- [CS50 SQL Lecture 4 Notes](https://cs50.harvard.edu/sql/notes/4/)

---

**Happy Learning! 🎉**

