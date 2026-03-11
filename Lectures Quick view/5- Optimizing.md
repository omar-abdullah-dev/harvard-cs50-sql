# Lecture 5: Optimizing

## 📋 Quick Summary

**Focus:** Optimize database performance through indexes, transactions, and concurrency control

**Key Database:** IMDb (movies.db) - Large-scale movie database

---

## 🔑 Core Concepts

### 1. **Indexes**
- Speed up data retrieval (like book indexes)
- Created on columns frequently queried
- B-Tree data structure
- Trade-off: Faster SELECT, slower INSERT/UPDATE

```sql
CREATE INDEX "title_index" ON "movies" ("title");
```

### 2. **Query Plan Analysis**
- `EXPLAIN QUERY PLAN` shows execution strategy
- Identify scans (slow) vs index searches (fast)

```sql
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';
```

### 3. **VACUUM**
- Reclaims space from deleted data
- Optimizes database file

```sql
VACUUM;
```

### 4. **Transactions**
- Group operations into atomic units
- ACID properties ensure data integrity

```sql
BEGIN TRANSACTION;
-- operations here
COMMIT;
```

### 5. **Concurrency**
- Multiple users accessing database simultaneously
- Locking mechanisms prevent conflicts
- SHARED locks (reading) vs EXCLUSIVE locks (writing)

---

## 🎯 Key Commands

| Command | Purpose |
|---------|---------|
| `CREATE INDEX` | Create index for faster queries |
| `DROP INDEX` | Remove index |
| `EXPLAIN QUERY PLAN` | Show query execution strategy |
| `VACUUM` | Reclaim deleted space |
| `BEGIN TRANSACTION` | Start atomic operation |
| `COMMIT` | Save transaction changes |
| `ROLLBACK` | Undo transaction changes |
| `.timer on` | Measure query performance |

---

## 📊 Performance Optimization Workflow

1. **Identify** slow queries (`.timer on`)
2. **Analyze** execution plan (`EXPLAIN QUERY PLAN`)
3. **Optimize** with indexes
4. **Verify** improvement (re-time query)
5. **Maintain** database (`VACUUM`)

---

## ⚡ Quick Examples

### Before Index (Slow)
```sql
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Time: 0.100s (table scan)
```

### After Index (Fast)
```sql
CREATE INDEX "title_index" ON "movies" ("title");
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Time: 0.012s (8x faster!)
```

### Safe Money Transfer
```sql
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" - 50 WHERE "id" = 1;
UPDATE "accounts" SET "balance" = "balance" + 50 WHERE "id" = 2;
COMMIT;
```

---

## 💡 Important Trade-offs

| Optimization | Benefit | Cost |
|--------------|---------|------|
| **Indexes** | Faster queries | More disk space, slower writes |
| **Partial Indexes** | Less space | Only helps specific queries |
| **Transactions** | Data integrity | Locks block concurrent access |
| **VACUUM** | Reclaims space | Takes time, locks database |

---

## 🔒 ACID Properties

- **A**tomicity: All or nothing
- **C**onsistency: Maintains constraints  
- **I**solation: Transactions don't interfere
- **D**urability: Changes are permanent

---

## 🚀 Best Practices

✅ Index foreign keys and WHERE clause columns  
✅ Use covering indexes when possible  
✅ Keep transactions short  
✅ VACUUM after major deletions  
✅ Test with realistic data volumes  

❌ Don't over-index (slows writes)  
❌ Don't leave transactions open  
❌ Don't ignore "database locked" errors  

---

## 📁 Related Files

- **Notes:** `notes/Lecture 5/05- Optimizing.md`
- **Queries:** `queries/optimizing/`
- **Source Code:** `Source Code/5-Optimizing/`

---

## 🎓 Learning Path

**Master these in order:**
1. Basic queries (SELECT, WHERE, ORDER BY)
2. Joins and relationships
3. Indexes for common queries
4. Transactions for data integrity
5. Query plan analysis for bottlenecks
6. Advanced optimization techniques

---

## 📖 Complete SQL Syntax Reference

### CREATE INDEX
```sql
-- Basic index on single column
CREATE INDEX index_name ON table_name(column_name);

-- Index on multiple columns
CREATE INDEX index_name ON table_name(column1, column2);

-- Unique index
CREATE UNIQUE INDEX index_name ON table_name(column_name);

-- Partial index (condition-based)
CREATE INDEX index_name ON table_name(column_name)
WHERE condition;

-- Examples
CREATE INDEX title_index ON movies(title);
CREATE INDEX name_year_index ON movies(title, year);
CREATE INDEX recent_index ON movies(year) WHERE year >= 2020;
```

### DROP INDEX
```sql
-- Remove an index
DROP INDEX index_name;

-- Remove if exists
DROP INDEX IF EXISTS index_name;
```

### EXPLAIN QUERY PLAN
```sql
-- Analyze how a query will execute
EXPLAIN QUERY PLAN
SELECT * FROM movies WHERE title = 'Cars';

-- Check for table scans vs index usage
-- SCAN TABLE = slow (no index)
-- SEARCH USING INDEX = fast (using index)
-- USING COVERING INDEX = fastest (all data in index)
```

### VACUUM
```sql
-- Reclaim unused space
VACUUM;

-- Rebuild database file, reclaim deleted space
-- Run after major deletions
-- Temporarily requires disk space = 2x database size
```

### Transactions
```sql
-- Basic transaction
BEGIN TRANSACTION;
-- SQL statements here
COMMIT;

-- Transaction with rollback
BEGIN TRANSACTION;
INSERT INTO accounts (id, balance) VALUES (1, 1000);
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
-- If error occurs:
ROLLBACK;
-- Otherwise:
COMMIT;

-- Transaction types
BEGIN DEFERRED TRANSACTION;   -- Default, lock on first read/write
BEGIN IMMEDIATE TRANSACTION;  -- Lock immediately
BEGIN EXCLUSIVE TRANSACTION;  -- Exclusive lock immediately

-- Savepoints (partial rollback)
BEGIN TRANSACTION;
INSERT INTO table1 VALUES (1, 'data');
SAVEPOINT sp1;
INSERT INTO table2 VALUES (2, 'data');
ROLLBACK TO sp1;  -- Undo second insert only
COMMIT;
```

### Timing Queries
```sql
-- SQLite command to enable timing
.timer on

-- Run your query
SELECT * FROM movies WHERE year = 2020;

-- Output shows execution time
-- real: wall-clock time (what users experience)
-- user: CPU time in user mode
-- sys: CPU time in kernel mode
```

### Concurrency & Locking
```sql
-- SQLite locking states (automatic):
-- UNLOCKED → SHARED → RESERVED → PENDING → EXCLUSIVE

-- SHARED lock: Multiple readers allowed
SELECT * FROM table_name;

-- EXCLUSIVE lock: One writer, no readers
BEGIN IMMEDIATE TRANSACTION;
INSERT INTO table_name VALUES (...);
COMMIT;

-- Check locks (not standard SQL, database-specific)
PRAGMA locking_mode;
PRAGMA journal_mode;
```

### Index Strategies
```sql
-- Index foreign keys
CREATE INDEX fk_user_id ON orders(user_id);

-- Index WHERE clause columns
CREATE INDEX status_idx ON orders(status);

-- Index JOIN columns
CREATE INDEX user_id_idx ON orders(user_id);

-- Covering index (include all needed columns)
CREATE INDEX order_summary_idx ON orders(user_id, total, created_at);

-- Partial index for common queries
CREATE INDEX active_users_idx ON users(last_login)
WHERE status = 'active';
```

### Query Optimization Patterns
```sql
-- Use EXISTS instead of IN for large datasets
-- Slow:
SELECT * FROM users
WHERE id IN (SELECT user_id FROM orders);

-- Faster:
SELECT * FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);

-- Limit results early
SELECT * FROM large_table LIMIT 100;

-- Use specific columns instead of SELECT *
SELECT id, name FROM users;  -- Not SELECT *

-- Index columns in WHERE, JOIN, ORDER BY
CREATE INDEX idx_name ON users(last_name, first_name);
SELECT * FROM users WHERE last_name = 'Smith' ORDER BY first_name;
```

### Database Maintenance
```sql
-- Check database integrity
PRAGMA integrity_check;

-- Check for quick check
PRAGMA quick_check;

-- Analyze database statistics
ANALYZE;

-- Update statistics for query optimizer
ANALYZE table_name;

-- Check database size
.dbinfo

-- or
SELECT page_count * page_size as size FROM pragma_page_count(), pragma_page_size();
```

---

## 💡 Optimization Best Practices

### When to Create Indexes
✅ **DO index:**
- Primary keys (automatic in most databases)
- Foreign keys
- Columns in WHERE clauses
- Columns in JOIN conditions
- Columns in ORDER BY clauses
- Columns frequently searched

❌ **DON'T over-index:**
- Small tables (< 1000 rows)
- Columns rarely queried
- Columns with low cardinality (few unique values)
- Write-heavy tables (slows INSERT/UPDATE)

### Index Trade-offs
| Benefit | Cost |
|---------|------|
| Faster SELECT | Slower INSERT |
| Faster JOIN | Slower UPDATE |
| Faster WHERE | More disk space |
| Faster ORDER BY | Slower DELETE |

### Transaction Best Practices
1. **Keep transactions short** - Don't hold locks long
2. **Batch operations** - Insert 1000 rows in one transaction, not 1000 transactions
3. **Use appropriate isolation** - DEFERRED for most cases
4. **Handle errors** - Always ROLLBACK on error
5. **Commit frequently** - In long operations, commit periodically

### VACUUM Best Practices
- Run after major deletions
- Run during low-traffic periods
- Ensure enough disk space (2x database size)
- Consider AUTO_VACUUM mode for automatic cleanup

---

## 🚀 Performance Tuning Workflow

1. **Identify slow queries** - Use `.timer on`
2. **Analyze execution plan** - Use `EXPLAIN QUERY PLAN`
3. **Check for table scans** - Look for "SCAN TABLE" in plan
4. **Create appropriate indexes** - On filtered/joined columns
5. **Re-test query** - Verify performance improvement
6. **Monitor index usage** - Remove unused indexes
7. **VACUUM periodically** - Reclaim space after deletions
8. **Analyze statistics** - Run `ANALYZE` after major changes

---

## 📊 Reading EXPLAIN QUERY PLAN

```
QUERY PLAN
├── SCAN TABLE movies          ← BAD: Reading entire table
├── SEARCH TABLE movies USING INDEX idx_title    ← GOOD: Using index
└── SEARCH TABLE movies USING COVERING INDEX idx_title_year  ← BEST: All data in index
```

**Key terms:**
- **SCAN** = Full table scan (slow)
- **SEARCH** = Index search (fast)
- **COVERING INDEX** = All columns in index (fastest)
- **TEMP B-TREE** = Temporary sorting (uses memory/disk)

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning query optimization with Harvard CS50 SQL
