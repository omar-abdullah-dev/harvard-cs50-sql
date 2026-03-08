# Scaling Queries

This folder contains SQL queries and examples for **Lecture 6: Scaling** from Harvard CS50's Introduction to Databases with SQL.

## 📚 Contents

### MySQL Basics
- **`mysql_connection.sql`** - Connecting to MySQL server and basic commands
- **`mysql_data_types.sql`** - MySQL-specific data types (INT, VARCHAR, ENUM, DECIMAL, etc.)
- **`mysql_mbta_schema.sql`** - Complete MBTA (Boston subway) database schema in MySQL
- **`alter_table_mysql.sql`** - Altering tables in MySQL (more powerful than SQLite)

### PostgreSQL Basics
- **`postgresql_connection.sql`** - Connecting to PostgreSQL and basic commands
- **`postgresql_data_types.sql`** - PostgreSQL data types (SERIAL, custom ENUM types, etc.)
- **`postgresql_mbta_schema.sql`** - Complete MBTA database schema in PostgreSQL

### Advanced Features
- **`stored_procedures.sql`** - Creating and using stored procedures with parameters
- **`access_control.sql`** - User management and privilege granting
- **`sql_injection_prevention.sql`** - Prepared statements to prevent SQL injection attacks
- **`replication_concepts.sql`** - Database replication and scaling strategies (conceptual)

## 🎯 Key Concepts

### MySQL vs PostgreSQL vs SQLite

| Feature | SQLite | MySQL | PostgreSQL |
|---------|--------|-------|------------|
| **Type** | Embedded | Server | Server |
| **Auto-increment** | `INTEGER PRIMARY KEY` | `AUTO_INCREMENT` | `SERIAL` |
| **Quote Style** | `"double"` | `` `backticks` `` | `"double"` |
| **Scaling** | Limited | Excellent | Excellent |

### Data Types Comparison

**MySQL:**
- Integers: `TINYINT`, `SMALLINT`, `MEDIUMINT`, `INT`, `BIGINT`
- Auto-increment: `AUTO_INCREMENT`
- Text: `VARCHAR(n)`, `CHAR(n)`, `TEXT`, `ENUM()`, `SET()`
- Decimal: `DECIMAL(digits, precision)`

**PostgreSQL:**
- Integers: `SMALLINT`, `INTEGER`, `BIGINT`
- Auto-increment: `SERIAL`, `BIGSERIAL`
- Text: `VARCHAR(n)`, `TEXT`
- Custom types: `CREATE TYPE "name" AS ENUM(...)`
- Decimal: `NUMERIC(digits, precision)`

### Stored Procedures

Automate sequences of SQL statements:

```sql
delimiter //
CREATE PROCEDURE `procedure_name`(IN `param` INT)
BEGIN
    -- SQL statements here
END//
delimiter ;

CALL `procedure_name`(value);
```

### Scaling Strategies

1. **Vertical Scaling**: Add more power to a single server
2. **Horizontal Scaling**: Distribute load across multiple servers
3. **Replication**: Keep copies of database on multiple servers
   - **Single-leader**: One server handles writes, others replicate
   - **Multi-leader**: Multiple servers handle writes
   - **Leaderless**: No designated leader
4. **Synchronous vs Asynchronous**:
   - **Synchronous**: Wait for replication (slower, consistent)
   - **Asynchronous**: Don't wait (faster, eventual consistency)
5. **Sharding**: Split database across servers
   - Avoid hotspots (overloaded servers)
   - Avoid single points of failure

### Security

**Access Control:**
```sql
CREATE USER 'username' IDENTIFIED BY 'password';
GRANT SELECT ON `database`.`table` TO 'username';
```

**SQL Injection Prevention:**
```sql
PREPARE `statement` FROM 'SELECT * FROM `table` WHERE `id` = ?';
SET @id = 1;
EXECUTE `statement` USING @id;
```

## 🚀 Getting Started

### Install MySQL
```bash
# Windows: Download from mysql.com
# Mac: brew install mysql
# Linux: sudo apt-get install mysql-server

# Connect
mysql -u root -h 127.0.0.1 -P 3306 -p
```

### Install PostgreSQL
```bash
# Windows: Download from postgresql.org
# Mac: brew install postgresql
# Linux: sudo apt-get install postgresql

# Connect
psql postgresql://postgres@127.0.0.1:5432/postgres
```

## 📖 Usage Examples

### Creating a Database in MySQL
```sql
CREATE DATABASE `mydb`;
USE `mydb`;
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(100),
    PRIMARY KEY(`id`)
);
```

### Creating a Database in PostgreSQL
```sql
CREATE DATABASE "mydb";
\c "mydb"
CREATE TABLE "users" (
    "id" SERIAL,
    "name" VARCHAR(100),
    PRIMARY KEY("id")
);
```

## 🔗 Related Resources

- **Notes**: `notes/Lecture 6/06- Scaling.md`
- **Quick View**: `Lectures Quick view/6- Scaling.md`
- **Source Code**: `Source Code/6-Scaling/` (if available)

## 💡 Best Practices

✅ Use appropriate data types to save space  
✅ Index foreign keys and frequently queried columns  
✅ Use prepared statements to prevent SQL injection  
✅ Grant minimal necessary privileges  
✅ Use replication for high availability  
✅ Monitor replication lag  

❌ Don't use overly large data types  
❌ Don't store passwords in plain text  
❌ Don't concatenate user input into SQL  
❌ Don't create single points of failure  

## 📝 Notes

- MySQL uses `` `backticks` `` for identifiers
- PostgreSQL uses `"double quotes"` for identifiers
- SQLite has limited ALTER TABLE capabilities
- MySQL and PostgreSQL support more complex alterations
- Always use prepared statements in production
- Test replication thoroughly before deploying

