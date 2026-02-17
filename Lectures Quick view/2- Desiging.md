# CS50 SQL – Lecture 2: Designing 🏗️

This lecture focuses on designing database schemas from scratch.
Instead of querying existing databases, we now learn how to:

- Create tables
- Choose data types
- Normalize data
- Add constraints
- Modify schemas

---

## 1️⃣ Understanding Existing Schemas

### Useful SQLite Commands

```sql
.schema
```

Shows how tables were created.

```sql
.schema table_name
```

Shows schema for a specific table.

---

## 2️⃣ Designing a Database

When designing a database, ask:

- What tables do we need?
- What columns should each table have?
- What data types should we use?
- How are tables related?

---

## 3️⃣ Normalizing (Very Important ⚡)

**Normalization** = Avoid duplication.

**Bad design:**
- Same rider name repeated many times
- Same station repeated many times

**Better design:**
- Put riders in one table
- Put stations in one table
- Use IDs to relate them

> Each entity gets its own table.

---

## 4️⃣ Relationships

**Example:**
- A rider visits many stations
- A station has many riders

This is a **many-to-many** relationship.

**Solution:** Create a junction table:

```sql
CREATE TABLE visits (
    rider_id INTEGER,
    station_id INTEGER
);
```

---

## 5️⃣ CREATE TABLE

**Basic syntax:**

```sql
CREATE TABLE table_name (
    column_name data_type,
    column_name data_type
);
```

**Example:**

```sql
CREATE TABLE riders (
    id INTEGER,
    name TEXT
);
```

---

## 6️⃣ SQLite Storage Classes

SQLite has 5 storage classes:

| Type    | Meaning        |
|---------|----------------|
| NULL    | Empty value    |
| INTEGER | Whole numbers  |
| REAL    | Decimal numbers|
| TEXT    | Strings        |
| BLOB    | Binary data    |

---

## 7️⃣ Type Affinity

SQLite columns don't strictly enforce types — they have **type affinity**:

- TEXT
- NUMERIC
- INTEGER
- REAL
- BLOB

SQLite tries to convert values automatically.

---

## 8️⃣ Table Constraints

### Primary Key

```sql
PRIMARY KEY(id)
```

- Unique
- Not null

### Foreign Key

```sql
FOREIGN KEY(rider_id) REFERENCES riders(id)
```

Ensures relationship integrity.

### Composite Primary Key

```sql
PRIMARY KEY(rider_id, station_id)
```

Used when uniqueness depends on multiple columns.

---

## 9️⃣ Column Constraints

| Constraint | Meaning                   |
|------------|---------------------------|
| NOT NULL   | Cannot be empty           |
| UNIQUE     | Must be unique            |
| CHECK      | Must satisfy condition    |
| DEFAULT    | Uses default value        |

**Example:**

```sql
age INTEGER NOT NULL CHECK(age > 0)
```

---

## 🔟 ALTER TABLE

SQLite allows the following alterations:

**Rename table**

```sql
ALTER TABLE visits RENAME TO swipes;
```

**Add column**

```sql
ALTER TABLE swipes ADD COLUMN type TEXT;
```

**Rename column**

```sql
ALTER TABLE swipes RENAME COLUMN swipetype TO type;
```

**Drop column**

```sql
ALTER TABLE swipes DROP COLUMN type;
```

---

## 1️⃣1️⃣ Updated Schema Example

Example of a well-designed schema:

```sql
CREATE TABLE cards (
    id INTEGER,
    PRIMARY KEY(id)
);

CREATE TABLE stations (
    id INTEGER,
    name TEXT NOT NULL UNIQUE,
    line TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE swipes (
    id INTEGER,
    card_id INTEGER,
    station_id INTEGER,
    type TEXT NOT NULL CHECK(type IN ('enter', 'exit', 'deposit')),
    datetime NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount NUMERIC NOT NULL CHECK(amount != 0),
    PRIMARY KEY(id),
    FOREIGN KEY(card_id) REFERENCES cards(id),
    FOREIGN KEY(station_id) REFERENCES stations(id)
);
```

---

## 🎯 Key Concepts from Lecture 2

- Always normalize data.
- Use IDs instead of repeating text.
- Use foreign keys to relate tables.
- Add constraints to protect your data.
- Think before designing — structure matters.