# Lecture 5 Query Files Summary

This folder contains 7 comprehensive SQL files covering all optimization concepts from Harvard CS50 Lecture 5.

## 📚 File Overview

### 1. **creating_indexes.sql** (119 lines)
**Purpose:** Learn how to create indexes to speed up queries

**Topics Covered:**
- Basic index creation syntax
- Single-column vs multi-column indexes
- Covering indexes (fastest type)
- Partial indexes (space-efficient)
- Index on foreign keys
- Real-world examples with IMDb database
- When to create indexes vs when not to

**Example:**
```sql
CREATE INDEX "title_index" ON "movies" ("title");
```

---

### 2. **dropping_indexes.sql** (73 lines)
**Purpose:** Remove indexes and understand the impact

**Topics Covered:**
- DROP INDEX syntax
- Checking impact before dropping
- Reclaiming space after dropping
- When to drop indexes
- Cannot drop automatic indexes

**Example:**
```sql
DROP INDEX "title_index";
```

---

### 3. **explain_query_plan.sql** (169 lines)
**Purpose:** Understand how SQLite executes queries

**Topics Covered:**
- EXPLAIN QUERY PLAN syntax
- Reading execution plans
- Identifying table scans (slow)
- Detecting index usage (fast)
- Covering index detection
- Analyzing complex nested queries
- Comparing query plans before/after optimization

**Example:**
```sql
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';
```

---

### 4. **vacuum.sql** (158 lines)
**Purpose:** Reclaim unused disk space

**Topics Covered:**
- What VACUUM does
- When to use VACUUM
- Checking database size before/after
- VACUUM after dropping indexes
- VACUUM after deleting data
- Auto-vacuum modes
- Trade-offs and best practices
- Forensics implications

**Example:**
```sql
DROP INDEX "person_index";
VACUUM;  -- Now space is actually freed
```

---

### 5. **transactions.sql** (212 lines)
**Purpose:** Ensure data integrity with ACID transactions

**Topics Covered:**
- BEGIN TRANSACTION, COMMIT, ROLLBACK
- Atomicity (all or nothing)
- Consistency (maintaining constraints)
- Isolation (preventing interference)
- Durability (permanent changes)
- EXCLUSIVE transactions
- DEFERRED transactions
- IMMEDIATE transactions
- Multiple operations in one transaction
- Error handling with ROLLBACK

**Example:**
```sql
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" - 50 WHERE "id" = 1;
UPDATE "accounts" SET "balance" = "balance" + 50 WHERE "id" = 2;
COMMIT;
```

---

### 6. **concurrency_locking.sql** (243 lines)
**Purpose:** Handle multiple simultaneous users safely

**Topics Covered:**
- Lock states (UNLOCKED, SHARED, RESERVED, PENDING, EXCLUSIVE)
- Shared locks for reading
- Exclusive locks for writing
- Race conditions and how to prevent them
- Bank robbery attack example
- Deadlock scenarios
- busy_timeout pragma
- Lock granularity in SQLite
- Best practices for multi-user apps

**Example:**
```sql
BEGIN EXCLUSIVE TRANSACTION;
-- Locks entire database
UPDATE "accounts" SET "balance" = "balance" + 10 WHERE "id" = 1;
COMMIT;
```

---

### 7. **timing_queries.sql** (160 lines)
**Purpose:** Measure and compare query performance

**Topics Covered:**
- .timer on/off command
- Interpreting timing results (real, user, system)
- Measuring query performance
- Comparing scan vs index search
- Timing complex queries
- Performance testing workflow
- Benchmarking tips
- Sample performance test scripts

**Example:**
```sql
.timer on
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Real time: 0.012s
.timer off
```

---

## 🎯 Learning Path

### Beginner
1. Start with **creating_indexes.sql** - understand what indexes are
2. Use **timing_queries.sql** - see the performance impact
3. Try **explain_query_plan.sql** - visualize how queries execute

### Intermediate
4. Learn **transactions.sql** - ensure data integrity
5. Practice **vacuum.sql** - maintain your database
6. Study **dropping_indexes.sql** - know when to remove indexes

### Advanced
7. Master **concurrency_locking.sql** - handle multiple users

---

## 💡 Key Concepts Summary

### Performance Optimization
- **Indexes**: Speed up SELECT, slow down INSERT/UPDATE
- **Timing**: Measure before and after optimization
- **VACUUM**: Reclaim space from deleted data

### Data Integrity
- **Transactions**: All operations succeed or fail together
- **ACID**: Atomicity, Consistency, Isolation, Durability
- **ROLLBACK**: Undo changes if errors occur

### Multi-User Access
- **Locks**: Prevent conflicts between users
- **Isolation**: Transactions don't interfere
- **Race Conditions**: Prevented by sequential execution

---

## 📊 Quick Reference Table

| File | Lines | Key Command | Primary Use Case |
|------|-------|-------------|------------------|
| creating_indexes.sql | 119 | `CREATE INDEX` | Speed up queries |
| dropping_indexes.sql | 73 | `DROP INDEX` | Remove unused indexes |
| explain_query_plan.sql | 169 | `EXPLAIN QUERY PLAN` | Analyze query execution |
| vacuum.sql | 158 | `VACUUM` | Reclaim disk space |
| transactions.sql | 212 | `BEGIN TRANSACTION` | Data integrity |
| concurrency_locking.sql | 243 | `BEGIN EXCLUSIVE` | Multi-user safety |
| timing_queries.sql | 160 | `.timer on` | Measure performance |

**Total:** 7 files, 1,134 lines of SQL examples and explanations

---

## 🚀 Practice Exercises

1. **Index Performance Test**
   - Time a query without an index
   - Create an index
   - Time the same query
   - Calculate speedup

2. **Transaction Safety**
   - Create a bank transfer transaction
   - Introduce a constraint violation
   - Verify ROLLBACK works

3. **Space Optimization**
   - Check database size
   - Drop several indexes
   - VACUUM the database
   - Calculate space savings

4. **Concurrency Simulation**
   - Open two terminal windows
   - Start exclusive transaction in one
   - Try to query in the other
   - Observe locking behavior

---

## 📖 Additional Resources

- Main README: `../README.md`
- Lecture Notes: `../../notes/Lecture 5/05- Optimizing.md`
- Quick View: `../../Lectures Quick view/5- Optimizing.md`
- Source Code: `../../Source Code/5-Optimizing/`

---

**Total Learning Time:** ~4-6 hours to work through all files

**Recommended Database:** movies.db (IMDb) from CS50 course materials

