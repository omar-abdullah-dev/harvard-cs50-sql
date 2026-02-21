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