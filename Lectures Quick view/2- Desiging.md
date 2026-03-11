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

---

## 📖 Complete SQL Syntax Reference

### CREATE TABLE
```sql
-- Basic table creation
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype
);

-- With constraints
CREATE TABLE table_name (
    id INTEGER,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    age INTEGER CHECK(age >= 18),
    created_at NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

-- With foreign keys
CREATE TABLE table_name (
    id INTEGER,
    foreign_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(foreign_id) REFERENCES other_table(id)
);

-- Composite primary key
CREATE TABLE junction_table (
    table1_id INTEGER,
    table2_id INTEGER,
    PRIMARY KEY(table1_id, table2_id),
    FOREIGN KEY(table1_id) REFERENCES table1(id),
    FOREIGN KEY(table2_id) REFERENCES table2(id)
);
```

### ALTER TABLE
```sql
-- Rename table
ALTER TABLE old_name RENAME TO new_name;

-- Add column
ALTER TABLE table_name ADD COLUMN column_name datatype;

-- Add column with constraints
ALTER TABLE table_name 
ADD COLUMN column_name TEXT NOT NULL DEFAULT 'value';

-- Rename column
ALTER TABLE table_name 
RENAME COLUMN old_name TO new_name;

-- Drop column
ALTER TABLE table_name DROP COLUMN column_name;
```

### DROP TABLE
```sql
-- Delete entire table
DROP TABLE table_name;

-- Delete if exists (no error if doesn't exist)
DROP TABLE IF EXISTS table_name;
```

### Table Constraints
```sql
-- PRIMARY KEY
PRIMARY KEY(column_name)
PRIMARY KEY(column1, column2)  -- Composite

-- FOREIGN KEY
FOREIGN KEY(column_name) REFERENCES other_table(column_name)

-- FOREIGN KEY with actions
FOREIGN KEY(column_name) REFERENCES other_table(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE

-- UNIQUE (table-level)
UNIQUE(column_name)
UNIQUE(column1, column2)  -- Composite unique

-- CHECK (table-level)
CHECK(condition)
```

### Column Constraints
```sql
-- NOT NULL
column_name datatype NOT NULL

-- UNIQUE
column_name datatype UNIQUE

-- CHECK
column_name datatype CHECK(condition)
column_name INTEGER CHECK(column_name > 0)
column_name TEXT CHECK(column_name IN ('value1', 'value2'))

-- DEFAULT
column_name datatype DEFAULT value
created_at NUMERIC DEFAULT CURRENT_TIMESTAMP
status TEXT DEFAULT 'active'

-- Multiple constraints
column_name TEXT NOT NULL UNIQUE
age INTEGER NOT NULL CHECK(age >= 18)
```

### SQLite Data Types
```sql
-- INTEGER types
id INTEGER
count SMALLINT
big_number BIGINT

-- TEXT types
name TEXT
description VARCHAR(255)
fixed_code CHAR(10)

-- REAL types
price REAL
rating DECIMAL(3,2)
percentage FLOAT

-- NUMERIC (flexible)
date_field NUMERIC
timestamp_field NUMERIC

-- BLOB
image_data BLOB
file_content BLOB
```

### Common Patterns
```sql
-- Auto-incrementing primary key (implicit in SQLite)
CREATE TABLE table_name (
    id INTEGER PRIMARY KEY,  -- Automatically auto-increments
    name TEXT
);

-- Timestamps
CREATE TABLE table_name (
    id INTEGER PRIMARY KEY,
    created_at NUMERIC DEFAULT CURRENT_TIMESTAMP,
    updated_at NUMERIC DEFAULT CURRENT_TIMESTAMP
);

-- Enum-like values
CREATE TABLE table_name (
    id INTEGER PRIMARY KEY,
    status TEXT CHECK(status IN ('pending', 'active', 'completed'))
);

-- Junction table (many-to-many)
CREATE TABLE students_courses (
    student_id INTEGER,
    course_id INTEGER,
    enrolled_at NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(student_id, course_id),
    FOREIGN KEY(student_id) REFERENCES students(id),
    FOREIGN KEY(course_id) REFERENCES courses(id)
);
```

### Entity Relationship Types
```sql
-- One-to-One
-- Person ← Profile (one person has one profile)
CREATE TABLE profiles (
    person_id INTEGER UNIQUE,  -- UNIQUE ensures one-to-one
    bio TEXT,
    FOREIGN KEY(person_id) REFERENCES persons(id)
);

-- One-to-Many
-- Author → Books (one author, many books)
CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    author_id INTEGER,  -- No UNIQUE, allows multiple books per author
    FOREIGN KEY(author_id) REFERENCES authors(id)
);

-- Many-to-Many
-- Students ↔ Courses (students take multiple courses, courses have multiple students)
CREATE TABLE enrollments (
    student_id INTEGER,
    course_id INTEGER,
    PRIMARY KEY(student_id, course_id),
    FOREIGN KEY(student_id) REFERENCES students(id),
    FOREIGN KEY(course_id) REFERENCES courses(id)
);
```

---

## 💡 Best Practices

1. **Always use primary keys** - Every table should have one
2. **Normalize your data** - Avoid duplication
3. **Use meaningful names** - `user_id` not `uid`
4. **Add constraints** - Protect data integrity early
5. **Document your schema** - Write comments or maintain ER diagrams
6. **Think about relationships** - One-to-one, one-to-many, or many-to-many?
7. **Use foreign keys** - Maintain referential integrity

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning database design with Harvard CS50 SQL
