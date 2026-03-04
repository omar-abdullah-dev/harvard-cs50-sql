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

1. Read detailed notes
2. Practice with query examples
3. Time queries before/after optimization
4. Experiment with IMDb database
5. Review source code examples

