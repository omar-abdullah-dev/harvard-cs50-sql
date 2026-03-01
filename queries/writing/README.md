# Writing - Lecture 3 Query Examples

This folder contains SQL query examples for **Writing data** (INSERT, UPDATE, DELETE, Triggers, and Transactions) based on Harvard CS50 SQL Lecture 3.

## 📚 Files Overview

### 1. **insert.sql**
- Basic INSERT syntax
- Inserting single and multiple rows
- INSERT with DEFAULT values
- INSERT from CSV files
- INSERT with subqueries
- INSERT OR REPLACE / INSERT OR IGNORE
- RETURNING clause

**Key Concepts:**
- Adding data to tables
- Auto-increment primary keys
- Constraint handling (UNIQUE, NOT NULL)
- Bulk insert performance
- CSV import techniques

---

### 2. **update.sql**
- Basic UPDATE syntax
- UPDATE with WHERE clause
- UPDATE with calculations
- UPDATE with subqueries
- UPDATE with CASE statements
- UPDATE with date/time functions
- UPDATE with RETURNING

**Key Concepts:**
- Modifying existing data
- Conditional updates
- Batch updates
- Calculated field updates
- Transaction safety

---

### 3. **delete.sql**
- Basic DELETE syntax
- DELETE with conditions
- DELETE with subqueries
- Foreign key constraints
- ON DELETE CASCADE, SET NULL
- DELETE with RETURNING
- Soft delete pattern

**Key Concepts:**
- Removing data safely
- Foreign key handling
- Cascading deletes
- Data recovery strategies
- Audit trail maintenance

---

### 4. **triggers.sql**
- BEFORE, AFTER, INSTEAD OF triggers
- INSERT, UPDATE, DELETE triggers
- OLD and NEW keywords
- WHEN clause for conditions
- Multiple statements in triggers
- RAISE function
- Practical trigger patterns

**Key Concepts:**
- Automatic SQL execution
- Data consistency automation
- Audit logging
- Referential integrity
- View updateability

---

### 5. **transactions.sql**
- BEGIN, COMMIT, ROLLBACK
- Savepoints for partial rollback
- Transaction isolation levels
- ACID properties
- Nested transaction patterns
- Error handling
- Performance optimization

**Key Concepts:**
- Atomic operations
- Data consistency
- Error recovery
- Batch processing
- Concurrency control

---

## 🎯 Quick Reference

### Insert Data
```sql
INSERT INTO "table" ("col1", "col2")
VALUES ('val1', 'val2');

-- Multiple rows
INSERT INTO "table" ("col1", "col2")
VALUES 
    ('val1', 'val2'),
    ('val3', 'val4');
```

### Update Data
```sql
UPDATE "table"
SET "col1" = 'new_value'
WHERE "id" = 1;
```

### Delete Data
```sql
DELETE FROM "table"
WHERE "condition";
```

### Create Trigger
```sql
CREATE TRIGGER "trigger_name"
AFTER INSERT ON "table"
FOR EACH ROW
BEGIN
    -- SQL statements
END;
```

### Use Transaction
```sql
BEGIN TRANSACTION;
    -- Multiple operations
    INSERT INTO ...;
    UPDATE ...;
COMMIT;
```

---

## 🔍 When to Use Each Operation

| Operation | Use Case | Example |
|-----------|----------|---------|
| **INSERT** | Add new records | New user registration |
| **UPDATE** | Modify existing data | Change user email |
| **DELETE** | Remove records | Delete old logs |
| **TRIGGER** | Automatic actions | Log all changes |
| **TRANSACTION** | Group operations | Money transfer |

---

## 💡 Best Practices

### INSERT
1. ✅ Always specify column names
2. ✅ Use bulk INSERT for multiple rows
3. ✅ Validate data before inserting
4. ✅ Handle constraint violations gracefully
5. ⚠️ Don't rely on column order

### UPDATE
1. ✅ Always use WHERE clause (unless updating all rows)
2. ✅ Test with SELECT first
3. ✅ Use transactions for important updates
4. ✅ Update timestamps for audit trails
5. ⚠️ Be careful with UPDATE without WHERE

### DELETE
1. ✅ Always use WHERE clause (unless deleting all rows)
2. ✅ Test with SELECT first
3. ✅ Consider soft delete over hard delete
4. ✅ Backup before bulk deletes
5. ⚠️ Be aware of foreign key constraints

### TRIGGERS
1. ✅ Keep triggers simple and focused
2. ✅ Document trigger purpose
3. ✅ Use WHEN clause to limit execution
4. ✅ Test thoroughly
5. ⚠️ Avoid trigger chains

### TRANSACTIONS
1. ✅ Keep transactions short
2. ✅ Handle errors with ROLLBACK
3. ✅ Use for related operations
4. ✅ Use savepoints for complex operations
5. ⚠️ Don't hold locks too long

---

## 🚨 Common Pitfalls

### INSERT Mistakes
```sql
-- ❌ WRONG: No column names
INSERT INTO "users" VALUES ('john', 'john@email.com');

-- ✅ CORRECT: Specify columns
INSERT INTO "users" ("username", "email")
VALUES ('john', 'john@email.com');
```

### UPDATE Mistakes
```sql
-- ❌ WRONG: No WHERE clause (updates ALL rows!)
UPDATE "users" SET "status" = 'active';

-- ✅ CORRECT: Use WHERE
UPDATE "users" SET "status" = 'active' WHERE "id" = 1;
```

### DELETE Mistakes
```sql
-- ❌ WRONG: No WHERE clause (deletes ALL rows!)
DELETE FROM "users";

-- ✅ CORRECT: Use WHERE
DELETE FROM "users" WHERE "id" = 1;
```

### Transaction Mistakes
```sql
-- ❌ WRONG: No error handling
BEGIN TRANSACTION;
    UPDATE "accounts" SET "balance" = "balance" - 100 WHERE "id" = 1;
    UPDATE "accounts" SET "balance" = "balance" + 100 WHERE "id" = 2;
COMMIT;  -- What if second update fails?

-- ✅ CORRECT: With error handling (in application)
BEGIN TRANSACTION;
try {
    UPDATE "accounts" SET "balance" = "balance" - 100 WHERE "id" = 1;
    UPDATE "accounts" SET "balance" = "balance" + 100 WHERE "id" = 2;
    COMMIT;
} catch (error) {
    ROLLBACK;
}
```

---

## 📖 Related Topics

- **Designing** (queries/designing/) - Table schemas and constraints
- **Views** (queries/views/) - INSTEAD OF triggers work with views
- **Basic** (queries/basic/) - SELECT for verifying changes
- **Joins** (queries/joins/) - Using joins in subqueries

---

## 🎓 Learning Path

1. Start with **insert.sql** - Learn to add data
2. Move to **update.sql** - Modify existing data
3. Study **delete.sql** - Remove data safely
4. Master **triggers.sql** - Automate actions
5. Complete with **transactions.sql** - Ensure data consistency

---

## 🔒 Data Safety Checklist

Before running data modification queries:

- [ ] Test with SELECT first
- [ ] Use WHERE clause (if not affecting all rows)
- [ ] Backup important data
- [ ] Use transaction for safety
- [ ] Verify changes after execution
- [ ] Have rollback plan ready
- [ ] Consider soft delete over hard delete
- [ ] Check foreign key dependencies
- [ ] Log important changes
- [ ] Test in development first

---

## 💻 Practical Examples

### User Registration Flow
```sql
BEGIN TRANSACTION;
    -- Insert user
    INSERT INTO "users" ("username", "email", "password_hash")
    VALUES ('john_doe', 'john@example.com', 'hashed_password');
    
    -- Create profile
    INSERT INTO "profiles" ("user_id", "first_name", "last_name")
    VALUES (last_insert_rowid(), 'John', 'Doe');
    
    -- Set default preferences
    INSERT INTO "preferences" ("user_id", "theme")
    VALUES (last_insert_rowid(), 'light');
COMMIT;
```

### Order Processing
```sql
BEGIN TRANSACTION;
    -- Create order
    INSERT INTO "orders" ("customer_id", "total")
    VALUES (100, 99.99);
    
    -- Add items
    INSERT INTO "order_items" ("order_id", "product_id", "quantity")
    VALUES (last_insert_rowid(), 1, 2);
    
    -- Update inventory
    UPDATE "inventory"
    SET "quantity" = "quantity" - 2
    WHERE "product_id" = 1;
COMMIT;
```

### Audit Logging with Trigger
```sql
CREATE TRIGGER "log_user_changes"
AFTER UPDATE ON "users"
FOR EACH ROW
BEGIN
    INSERT INTO "audit_log" ("table_name", "record_id", "action", "timestamp")
    VALUES ('users', NEW."id", 'UPDATE', DATETIME('now'));
END;
```

---

## 📊 Performance Tips

1. **Bulk Inserts**: Use multiple VALUES instead of separate INSERTs
2. **Transactions**: Wrap bulk operations in transactions
3. **Indexes**: Ensure proper indexes on WHERE/JOIN columns
4. **Batch Processing**: Process large datasets in chunks
5. **Prepared Statements**: Use in application code for repeated operations

```sql
-- Slow: Multiple inserts
INSERT INTO "products" VALUES (1, 'Product 1');
INSERT INTO "products" VALUES (2, 'Product 2');
-- ... 1000 more

-- Fast: Bulk insert in transaction
BEGIN TRANSACTION;
    INSERT INTO "products" VALUES 
        (1, 'Product 1'),
        (2, 'Product 2'),
        -- ... 1000 more
        (1000, 'Product 1000');
COMMIT;
```

---

## 🚀 Quick Start

```bash
# Open SQLite database
sqlite3 mfa.db

# Enable headers and column mode
.headers on
.mode column

# Load and execute examples
.read queries/writing/insert.sql

# Test INSERT
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Test Artwork', '99.999', '2024-03-01');

# Verify
SELECT * FROM "collections" WHERE "accession_number" = '99.999';
```

---

## 📚 Additional Resources

- [SQLite INSERT Documentation](https://www.sqlite.org/lang_insert.html)
- [SQLite UPDATE Documentation](https://www.sqlite.org/lang_update.html)
- [SQLite DELETE Documentation](https://www.sqlite.org/lang_delete.html)
- [SQLite TRIGGER Documentation](https://www.sqlite.org/lang_createtrigger.html)
- [SQLite TRANSACTION Documentation](https://www.sqlite.org/lang_transaction.html)
- [CS50 SQL Lecture 3 Notes](https://cs50.harvard.edu/sql/notes/3/)

---

## ⚠️ Critical Safety Reminders

### Always Remember:
- **UPDATE without WHERE = Update ALL rows**
- **DELETE without WHERE = Delete ALL rows**
- **Test with SELECT before UPDATE/DELETE**
- **Use transactions for safety**
- **Backup before bulk operations**
- **Foreign keys matter for DELETE**
- **Triggers can have side effects**
- **Transactions prevent partial changes**

---

**Write data responsibly! 🛡️📝**

