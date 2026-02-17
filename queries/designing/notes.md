# Database Designing Notes

## What is Normalization?
Normalization means:
- Put each entity in its own table.
- Avoid repeating the same data many times.
- Use foreign keys to connect tables.

## Relationships

1. One-to-One
   One record in Table A matches one record in Table B.

2. One-to-Many
   One record in Table A matches many records in Table B.

3. Many-to-Many
   Many records in Table A match many records in Table B.
   This requires a junction table.

## SQLite Storage Classes
- NULL
- INTEGER
- REAL
- TEXT
- BLOB

## Why Constraints Are Important
Constraints:
- Prevent wrong data.
- Keep the database consistent.
- Enforce business rules.
