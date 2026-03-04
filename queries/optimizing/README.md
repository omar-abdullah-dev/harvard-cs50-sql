# Lecture 5: Optimizing Queries

This folder contains SQL examples and explanations for database optimization techniques covered in Harvard CS50's Lecture 5.

## 📚 Contents

### 1. **creating_indexes.sql**
Learn how to create indexes to speed up query performance.
- Basic index creation
- Multi-column indexes
- Covering indexes
- Partial indexes
- When to use indexes
- Trade-offs (space and time)

**Key Concepts:**
- Indexes are like book indexes - they help find data quickly
- Can make queries 8-10x faster or more
- Automatically created for PRIMARY KEY columns
- Cost: Extra disk space and slower INSERT/UPDATE operations

---

### 2. **dropping_indexes.sql**
Learn how to remove indexes from your database.
- Dropping single and multiple indexes
- When to drop indexes
- Impact on query performance
- Reclaiming space with VACUUM

**Key Concepts:**
- Drop unused indexes to free space
- Test query performance before/after
- Cannot drop automatic indexes (PRIMARY KEY)

---

### 3. **explain_query_plan.sql**
Understand how SQLite executes your queries.
- Using EXPLAIN QUERY PLAN
- Reading execution plans
- Identifying table scans vs index searches
- Detecting covering indexes
- Optimizing complex queries

**Key Concepts:**
- SCAN TABLE = slow (reads every row)
- SEARCH USING INDEX = fast (jumps to relevant rows)
- USING COVERING INDEX = fastest (data in index itself)

---

### 4. **vacuum.sql**
Reclaim unused space in your database.
- What VACUUM does
- When to use VACUUM
- Checking database size
- Auto-vacuum modes
- Trade-offs and best practices

**Key Concepts:**
- Deleted data isn't immediately removed - just marked as free
- VACUUM actually frees the space
- Can reduce database size significantly
- Takes time and requires temporary disk space

---

### 5. **transactions.sql**
Ensure data integrity with ACID transactions.
- BEGIN TRANSACTION, COMMIT, ROLLBACK
- Atomicity (all or nothing)
- Consistency (maintaining constraints)
- Isolation (preventing interference)
- Durability (permanent changes)
- Transaction types (DEFERRED, IMMEDIATE, EXCLUSIVE)

**Key Concepts:**
- Transactions group multiple operations into one unit
- Either all operations succeed or all fail (no partial updates)
- Essential for financial systems, e-commerce, multi-step operations

---

### 6. **concurrency_locking.sql**
Handle multiple simultaneous database users safely.
- Shared locks (reading)
- Exclusive locks (writing)
- Preventing race conditions
- Deadlock scenarios
- Lock states in SQLite
- Best practices for multi-user applications

**Key Concepts:**
- Multiple users can read simultaneously (SHARED locks)
- Only one user can write at a time (EXCLUSIVE lock)
- Transactions run in isolation to prevent conflicts
- SQLite locks entire database (not row-level)

---

### 7. **timing_queries.sql**
Measure and compare query performance.
- Enabling `.timer on` in SQLite
- Interpreting timing results
- Benchmarking before/after optimization
- Performance testing workflow
- Comparing different query approaches

**Key Concepts:**
- "real" time = what users experience (stopwatch time)
- Compare performance before and after adding indexes
- Fast queries: < 0.010s, Slow queries: > 0.100s

---

## 🎯 Key Database Optimization Concepts

### **Index Data Structure: B-Tree**
Indexes are stored as balanced trees (B-Trees):
- Root node at the top
- Branch nodes for navigation
- Leaf nodes contain actual data
- Sorted for efficient binary search
- Broken into pages for large datasets

### **Trade-offs in Optimization**

| Optimization | Benefit | Cost |
|--------------|---------|------|
| **Indexes** | Faster SELECT queries | Slower INSERT/UPDATE, more disk space |
| **Partial Indexes** | Less space than full index | Only helps specific queries |
| **VACUUM** | Reclaims disk space | Takes time, locks database |
| **Transactions** | Data integrity, consistency | Locks prevent concurrent writes |

### **ACID Properties**
- **A**tomicity: All or nothing
- **C**onsistency: Maintains constraints
- **I**solation: Transactions don't interfere
- **D**urability: Changes are permanent

---

## 💡 Practical Usage Examples

### Finding Slow Queries
```sql
-- Enable timing
.timer on

-- Run your query
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Real time: 0.100s (slow!)

-- Check execution plan
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Output: SCAN TABLE movies (scanning entire table)
```

### Optimizing with Index
```sql
-- Create index
CREATE INDEX "title_index" ON "movies" ("title");

-- Run query again
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Real time: 0.012s (8x faster!)

-- Verify index usage
EXPLAIN QUERY PLAN
SELECT * FROM "movies" WHERE "title" = 'Cars';
-- Output: SEARCH TABLE movies USING INDEX title_index
```

### Safe Money Transfer
```sql
-- Transfer $50 from Alice to Bob
BEGIN TRANSACTION;
UPDATE "accounts" SET "balance" = "balance" - 50 WHERE "id" = 1;
UPDATE "accounts" SET "balance" = "balance" + 50 WHERE "id" = 2;
COMMIT;

-- Both updates happen together or not at all
-- No one sees intermediate state
```

---

## 🔍 Database Used: IMDb (movies.db)

The examples in Lecture 5 use the Internet Movie Database with:
- **movies** table: Movie titles, years, ratings
- **people** table: Actors, directors, etc.
- **stars** table: Many-to-many relationship (who starred in what)
- **ratings** table: User ratings and votes

Much larger than previous course databases - perfect for demonstrating optimization!

---

## 📊 Performance Optimization Workflow

1. **Identify slow queries** (use `.timer on`)
2. **Analyze execution plan** (use `EXPLAIN QUERY PLAN`)
3. **Create appropriate indexes** (on columns in WHERE, JOIN, ORDER BY)
4. **Verify improvement** (re-run with timer)
5. **Monitor trade-offs** (check INSERT/UPDATE speed, disk space)
6. **Maintain database** (VACUUM periodically)

---

## ⚠️ Common Pitfalls

1. **Over-indexing**: Too many indexes slow down INSERT/UPDATE
2. **Wrong column indexed**: Index must match your WHERE clauses
3. **Forgetting to VACUUM**: Dropped indexes don't free space automatically
4. **Long transactions**: Hold locks too long, block other users
5. **Not testing concurrency**: Race conditions only appear under load

---

## 🚀 Best Practices

✅ Index foreign key columns  
✅ Index columns used in WHERE clauses  
✅ Use covering indexes when possible  
✅ Keep transactions short  
✅ VACUUM after major deletions  
✅ Test with realistic data volumes  
✅ Monitor query performance over time  
✅ Use transactions for multi-step operations  

❌ Don't index every column  
❌ Don't leave transactions open  
❌ Don't ignore "database is locked" errors  
❌ Don't VACUUM during peak hours  

---

## 🔗 Related Topics

- **Lecture 4 (Viewing)**: Views can benefit from underlying indexes
- **Lecture 3 (Writing)**: Indexes slow down INSERT/UPDATE operations
- **Lecture 1 (Relating)**: Index foreign keys for faster joins
- **Lecture 0 (Querying)**: Index columns frequently used in WHERE

---

## 📖 Additional Resources

- [SQLite Index Documentation](https://www.sqlite.org/lang_createindex.html)
- [Transaction Documentation](https://www.sqlite.org/lang_transaction.html)
- [EXPLAIN QUERY PLAN](https://www.sqlite.org/eqp.html)
- [SQLite Locking](https://www.sqlite.org/lockingv3.html)

---

**Happy Optimizing! 🚀**

> "Premature optimization is the root of all evil, but so is premature pessimization." - Always measure before and after!

