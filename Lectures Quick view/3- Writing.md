# CS50 SQL – Lecture 3: Writing 📝

This lecture focuses on modifying data in databases.
Instead of just querying, we now learn how to:

- Insert data into tables
- Delete data from tables
- Update existing data
- Use triggers for automation
- Implement soft deletions

---

## 1️⃣ Introduction

**Context:** Boston MFA (Museum of Fine Arts) database
- Museums need to add new artwork to their collections
- Data must be inserted, updated, and deleted over time
- Schema constraints protect data integrity

---

## 2️⃣ INSERT INTO

### Basic Syntax

```sql
INSERT INTO "collections" ("id", "title", "accession_number", "acquired")
VALUES (1, 'Profusion of flowers', '56.257', '1956-04-12');
```

### Auto-incrementing IDs

**Omit the ID column** — SQLite fills it automatically:

```sql
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Farmers working at dawn', '11.6152', '1911-08-03');
```

> SQLite increments from the highest existing primary key.

---

## 3️⃣ Inserting Multiple Rows

### Comma-separated Values

```sql
INSERT INTO "collections" ("title", "accession_number", "acquired") 
VALUES 
('Imaginative landscape', '56.496', NULL),
('Peonies and butterfly', '06.1899', '1906-01-01');
```

**Benefits:**
- More convenient
- Faster and more efficient
- Must all succeed or all fail together

---

## 4️⃣ Importing from CSV

### Direct Import (with IDs)

```sql
.import --csv --skip 1 mfa.csv collections
```

- `--csv` tells SQLite it's a CSV file
- `--skip 1` skips the header row

### Import Without IDs (using temp table)

**Step 1:** Import to temporary table

```sql
.import --csv mfa.csv temp
```

**Step 2:** Move data to real table (auto-generates IDs)

```sql
INSERT INTO "collections" ("title", "accession_number", "acquired") 
SELECT "title", "accession_number", "acquired" FROM "temp";
```

**Step 3:** Clean up

```sql
DROP TABLE "temp";
```

---

## 5️⃣ Schema Constraints Protection

Constraints act as **guardrails** to protect data integrity:

| Constraint | What it prevents |
|------------|------------------|
| `NOT NULL` | Empty values |
| `UNIQUE` | Duplicate values |
| `PRIMARY KEY` | Duplicate or NULL IDs |
| `FOREIGN KEY` | Invalid references |

**Example errors:**
- `UNIQUE constraint failed`
- `NOT NULL constraint failed`
- `FOREIGN KEY constraint failed`

---

## 6️⃣ DELETE

### Delete All Rows

```sql
DELETE FROM "collections";
```

⚠️ **Dangerous!** Deletes everything.

### Conditional Delete

```sql
DELETE FROM "collections"
WHERE "title" = 'Spring outing';
```

```sql
DELETE FROM "collections"
WHERE "acquired" IS NULL;
```

```sql
DELETE FROM "collections"
WHERE "acquired" < '1909-01-01';
```

---

## 7️⃣ Foreign Key Deletion Behaviors

When deleting a row referenced by foreign keys:

| Behavior | Action |
|----------|--------|
| `ON DELETE RESTRICT` | Prevent deletion (default) |
| `ON DELETE NO ACTION` | Allow deletion, do nothing |
| `ON DELETE SET NULL` | Set foreign keys to NULL |
| `ON DELETE SET DEFAULT` | Set foreign keys to default value |
| `ON DELETE CASCADE` | **Delete related rows too** |

### CASCADE Example

```sql
FOREIGN KEY("artist_id") REFERENCES "artists"("id") ON DELETE CASCADE
```

**Effect:** Deleting an artist also deletes all their artwork affiliations.

---

## 8️⃣ UPDATE

### Basic Syntax

```sql
UPDATE "table_name"
SET "column" = 'new_value'
WHERE "condition";
```

### Complex Update Example

```sql
UPDATE "created"
SET "artist_id" = (
    SELECT "id"
    FROM "artists"
    WHERE "name" = 'Li Yin'
)
WHERE "collection_id" = (
    SELECT "id"
    FROM "collections"
    WHERE "title" = 'Farmers working at dawn'
);
```

Changes the artist attribution for a specific painting.

---

## 9️⃣ TRIGGERS ⚡

**Trigger** = SQL statement that runs automatically in response to another SQL statement.

### "Sell" Trigger (BEFORE DELETE)

```sql
CREATE TRIGGER "sell" 
BEFORE DELETE ON "collections"
BEGIN
    INSERT INTO "transactions" ("title", "action")
    VALUES (OLD."title", 'sold');
END;
```

- Runs **before** deletion
- `OLD` = the row being deleted
- Logs the sale automatically

### "Buy" Trigger (AFTER INSERT)

```sql
CREATE TRIGGER "buy" 
AFTER INSERT ON "collections"
BEGIN
    INSERT INTO "transactions" ("title", "action")
    VALUES (NEW."title", 'bought');
END;
```

- Runs **after** insertion
- `NEW` = the row being inserted
- Logs the purchase automatically

### Trigger Keywords

| Keyword | Meaning |
|---------|---------|
| `BEFORE` | Run before the action |
| `AFTER` | Run after the action |
| `OLD` | Reference to deleted/updated row |
| `NEW` | Reference to inserted/updated row |

---

## 🔟 Soft Deletions

**Soft delete** = Mark data as deleted instead of actually removing it.

### Implementation

**Step 1:** Add a `deleted` column

```sql
ALTER TABLE "collections"
ADD COLUMN "deleted" INTEGER DEFAULT 0;
```

**Step 2:** "Delete" by updating

```sql
UPDATE "collections"
SET "deleted" = 1
WHERE "title" = 'Farmers working at dawn';
```

**Step 3:** Query only active records

```sql
SELECT * FROM "collections"
WHERE "deleted" != 1;
```

### Benefits

- Data can be recovered if needed
- Maintains complete historical record
- Useful for auditing

⚠️ **Note:** Still must comply with data privacy regulations requiring true deletion.

---

## 🎯 Key Concepts from Lecture 3

- Use `INSERT INTO` to add data (omit ID for auto-increment)
- Import CSV files efficiently using temporary tables
- Constraints protect your database from bad data
- Use `ON DELETE CASCADE` to handle related deletions
- `UPDATE` changes existing data with conditions
- **Triggers** automate actions in response to changes
- **Soft deletes** preserve data while marking it inactive
- Always test deletions and updates carefully!

---

## 📋 Quick Reference

### Insert
```sql
INSERT INTO "table" ("col1", "col2") VALUES ('val1', 'val2');
```

### Delete
```sql
DELETE FROM "table" WHERE "condition";
```

### Update
```sql
UPDATE "table" SET "col" = 'value' WHERE "condition";
```

### Trigger
```sql
CREATE TRIGGER "name" 
AFTER INSERT ON "table"
BEGIN
    -- SQL statements
END;
```

---

## 📖 Complete SQL Syntax Reference

### INSERT INTO
```sql
-- Insert single row
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);

-- Insert with auto-increment ID (omit ID column)
INSERT INTO table_name (column1, column2)
VALUES (value1, value2);

-- Insert multiple rows
INSERT INTO table_name (column1, column2)
VALUES 
(value1a, value2a),
(value1b, value2b),
(value1c, value2c);

-- Insert from SELECT
INSERT INTO table_name (column1, column2)
SELECT column1, column2
FROM another_table
WHERE condition;

-- Insert with NULL values
INSERT INTO table_name (column1, column2)
VALUES ('value1', NULL);
```

### DELETE
```sql
-- Delete all rows (DANGEROUS!)
DELETE FROM table_name;

-- Delete with condition
DELETE FROM table_name WHERE column_name = value;

-- Delete with multiple conditions
DELETE FROM table_name 
WHERE condition1 AND condition2;

-- Delete with subquery
DELETE FROM table_name
WHERE column_name = (
    SELECT column_name
    FROM another_table
    WHERE condition
);

-- Delete with IN
DELETE FROM table_name
WHERE column_name IN (value1, value2, value3);

-- Delete NULL values
DELETE FROM table_name WHERE column_name IS NULL;

-- Delete with comparison
DELETE FROM table_name WHERE date_column < '2020-01-01';
```

### UPDATE
```sql
-- Update all rows (DANGEROUS!)
UPDATE table_name SET column_name = value;

-- Update with condition
UPDATE table_name 
SET column_name = value
WHERE condition;

-- Update multiple columns
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    column3 = value3
WHERE condition;

-- Update with subquery
UPDATE table_name
SET column_name = (
    SELECT column_name
    FROM another_table
    WHERE condition
)
WHERE condition;

-- Update with calculation
UPDATE table_name
SET price = price * 1.1
WHERE category = 'premium';

-- Update with CASE
UPDATE table_name
SET status = CASE
    WHEN score >= 90 THEN 'Excellent'
    WHEN score >= 70 THEN 'Good'
    ELSE 'Needs Improvement'
END;
```

### CREATE TRIGGER
```sql
-- Basic trigger structure
CREATE TRIGGER trigger_name
[BEFORE | AFTER | INSTEAD OF] [INSERT | UPDATE | DELETE]
ON table_name
BEGIN
    -- SQL statements
END;

-- Trigger with condition
CREATE TRIGGER trigger_name
AFTER INSERT ON table_name
WHEN NEW.column_name > 100
BEGIN
    -- SQL statements
END;

-- BEFORE DELETE trigger
CREATE TRIGGER log_deletion
BEFORE DELETE ON products
BEGIN
    INSERT INTO audit_log (action, product_name, timestamp)
    VALUES ('DELETE', OLD.name, CURRENT_TIMESTAMP);
END;

-- AFTER INSERT trigger
CREATE TRIGGER welcome_user
AFTER INSERT ON users
BEGIN
    INSERT INTO notifications (user_id, message)
    VALUES (NEW.id, 'Welcome to our platform!');
END;

-- AFTER UPDATE trigger
CREATE TRIGGER track_changes
AFTER UPDATE ON inventory
WHEN OLD.quantity != NEW.quantity
BEGIN
    INSERT INTO inventory_history (product_id, old_qty, new_qty, changed_at)
    VALUES (NEW.id, OLD.quantity, NEW.quantity, CURRENT_TIMESTAMP);
END;

-- Multiple statements in trigger
CREATE TRIGGER complex_trigger
AFTER INSERT ON orders
BEGIN
    UPDATE products SET stock = stock - NEW.quantity WHERE id = NEW.product_id;
    INSERT INTO order_log (order_id, created_at) VALUES (NEW.id, CURRENT_TIMESTAMP);
    UPDATE customers SET last_order_date = CURRENT_TIMESTAMP WHERE id = NEW.customer_id;
END;
```

### DROP TRIGGER
```sql
-- Remove a trigger
DROP TRIGGER trigger_name;

-- Remove if exists
DROP TRIGGER IF EXISTS trigger_name;
```

### Foreign Key Actions
```sql
-- ON DELETE CASCADE (delete related rows)
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- ON DELETE SET NULL (set to NULL)
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE SET NULL
);

-- ON DELETE RESTRICT (prevent deletion - default)
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE RESTRICT
);

-- ON DELETE SET DEFAULT
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    status TEXT DEFAULT 'pending',
    FOREIGN KEY(status) REFERENCES statuses(name) ON DELETE SET DEFAULT
);

-- ON UPDATE CASCADE (update related rows)
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    FOREIGN KEY(customer_id) REFERENCES customers(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
```

### Soft Delete Pattern
```sql
-- Add deleted column
ALTER TABLE table_name ADD COLUMN deleted INTEGER DEFAULT 0;

-- Or with timestamp
ALTER TABLE table_name ADD COLUMN deleted_at NUMERIC DEFAULT NULL;

-- Soft delete (mark as deleted)
UPDATE table_name SET deleted = 1 WHERE id = 5;
UPDATE table_name SET deleted_at = CURRENT_TIMESTAMP WHERE id = 5;

-- Query active records only
SELECT * FROM table_name WHERE deleted = 0;
SELECT * FROM table_name WHERE deleted_at IS NULL;

-- Restore soft-deleted record
UPDATE table_name SET deleted = 0 WHERE id = 5;
UPDATE table_name SET deleted_at = NULL WHERE id = 5;

-- Permanently delete soft-deleted records
DELETE FROM table_name WHERE deleted = 1;
DELETE FROM table_name WHERE deleted_at IS NOT NULL;
```

### CSV Import Commands (SQLite)
```sql
-- Import CSV with header (skip first row)
.import --csv --skip 1 filename.csv table_name

-- Import CSV without header
.import --csv filename.csv table_name

-- Import into temporary table
.import --csv data.csv temp

-- Then move to permanent table with auto-generated IDs
INSERT INTO permanent_table (col1, col2)
SELECT col1, col2 FROM temp;

-- Clean up
DROP TABLE temp;
```

### Transaction Patterns
```sql
-- Begin transaction
BEGIN TRANSACTION;

-- Multiple operations
INSERT INTO table1 (col) VALUES ('value');
UPDATE table2 SET col = 'value' WHERE id = 1;
DELETE FROM table3 WHERE id = 5;

-- Commit (save changes)
COMMIT;

-- Or rollback (undo changes)
ROLLBACK;
```

---

## 💡 Best Practices for Writing Data

1. **Always use transactions** for multiple related operations
2. **Test DELETE and UPDATE** on copies first
3. **Use WHERE clauses** - never forget them!
4. **Validate constraints** before inserting
5. **Use triggers sparingly** - they can make debugging hard
6. **Consider soft deletes** for important data
7. **Log important changes** with triggers or application code
8. **Backup before mass updates** or deletions

---

## ⚠️ Common Pitfalls

- Forgetting WHERE clause in UPDATE/DELETE (affects all rows!)
- Not handling foreign key constraints before deletion
- Triggering infinite loops with triggers
- Not testing constraint violations
- Ignoring transaction boundaries

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning data manipulation with Harvard CS50 SQL
