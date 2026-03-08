# Lecture 6: Scaling

## 📋 Quick Summary

**Focus:** Scale databases using MySQL and PostgreSQL, replication, sharding, and security

**Key Databases:** MBTA (subway system), MFA (museum), Bank (security examples)

---

## 🔑 Core Concepts

### 1. **Database Servers**
- SQLite: Embedded database
- MySQL & PostgreSQL: Database servers (run on dedicated hardware)
- Advantage: Store data in RAM for faster queries
- Connect over internet/network

### 2. **MySQL Data Types**

**Integers:**
- `TINYINT`, `SMALLINT`, `MEDIUMINT`, `INT`, `BIGINT`
- `AUTO_INCREMENT` for automatic ID generation

**Text:**
- `CHAR(n)` - Fixed width
- `VARCHAR(n)` - Variable length
- `TEXT` types: `TINYTEXT`, `TEXT`, `MEDIUMTEXT`, `LONGTEXT`
- `ENUM('option1', 'option2')` - Predefined options
- `SET` - Multiple options allowed

**Date/Time:**
- `DATE`, `YEAR`, `TIME`, `DATETIME`, `TIMESTAMP`

**Numeric:**
- `FLOAT`, `DOUBLE PRECISION`
- `DECIMAL(digits, precision)` - Fixed precision

### 3. **PostgreSQL Data Types**

**Integers:**
- `SMALLINT`, `INTEGER`, `BIGINT`
- `SERIAL` - Auto-incrementing integers

**Others:**
- `VARCHAR`, `TEXT`
- Custom types: `CREATE TYPE "type_name" AS ENUM(...)`
- `TIMESTAMP`, `DATE`, `TIME`, `INTERVAL`
- `NUMERIC(digits, precision)` - Like MySQL's DECIMAL

### 4. **Stored Procedures**
- Automate SQL statements
- Run repeatedly
- Can accept parameters

```sql
delimiter //
CREATE PROCEDURE `procedure_name`(IN `param` INT)
BEGIN
    -- SQL statements
END//
delimiter ;
```

### 5. **Scaling Strategies**

**Vertical Scaling:**
- Increase computing power of single server

**Horizontal Scaling:**
- Distribute load across multiple servers

**Replication Models:**
- **Single-leader:** One server handles writes, others replicate
- **Multi-leader:** Multiple servers handle writes
- **Leaderless:** No designated leader

**Synchronous vs Asynchronous:**
- **Synchronous:** Wait for followers to replicate (slower, consistent)
- **Asynchronous:** Don't wait (faster, eventual consistency)

**Sharding:**
- Split database across multiple servers
- Avoid hotspots (overloaded servers)
- Beware of single points of failure

---

## 🎯 Key Commands

### MySQL Connection
```bash
mysql -u root -h 127.0.0.1 -P 3306 -p
```

### PostgreSQL Connection
```bash
psql postgresql://postgres@127.0.0.1:5432/postgres
```

### Common MySQL Commands
| Command | Purpose |
|---------|---------|
| `SHOW DATABASES;` | List all databases |
| `USE database_name;` | Switch to database |
| `SHOW TABLES;` | List tables |
| `DESCRIBE table_name;` | Show table structure |
| `CREATE DATABASE` | Create new database |

### Common PostgreSQL Commands
| Command | Purpose |
|---------|---------|
| `\l` | List databases |
| `\c "database"` | Connect to database |
| `\dt` | List tables |
| `\d "table"` | Describe table |
| `\q` | Quit |

---

## 📊 MySQL vs PostgreSQL vs SQLite

| Feature | SQLite | MySQL | PostgreSQL |
|---------|--------|-------|------------|
| **Type** | Embedded | Server | Server |
| **Auto-increment** | `INTEGER PRIMARY KEY` | `AUTO_INCREMENT` | `SERIAL` |
| **Text Types** | Generic `TEXT` | `VARCHAR`, `ENUM`, `SET` | `VARCHAR`, Custom types |
| **Scaling** | Limited | Excellent | Excellent |
| **Use Case** | Small apps | Web apps, reads | Complex apps, writes |

---

## ⚡ Quick Examples

### Create Table (MySQL)
```sql
CREATE TABLE `stations` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL UNIQUE,
    `line` ENUM('blue', 'green', 'orange', 'red') NOT NULL,
    PRIMARY KEY(`id`)
);
```

### Create Table (PostgreSQL)
```sql
CREATE TYPE "swipe_type" AS ENUM('enter', 'exit', 'deposit');

CREATE TABLE "swipes" (
    "id" SERIAL,
    "type" "swipe_type" NOT NULL,
    "datetime" TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY("id")
);
```

### Stored Procedure
```sql
delimiter //
CREATE PROCEDURE `sell`(IN `sold_id` INT)
BEGIN
    UPDATE `collections` SET `deleted` = 1 WHERE `id` = `sold_id`;
    INSERT INTO `transactions` (`title`, `action`)
    VALUES ((SELECT `title` FROM `collections` WHERE `id` = `sold_id`), 'sold');
END//
delimiter ;

-- Call procedure
CALL `sell`(2);
```

### Alter Table
```sql
ALTER TABLE `stations` 
MODIFY `line` ENUM('blue', 'green', 'orange', 'red', 'silver') NOT NULL;
```

---

## 🔒 Security & Access Control

### Create User
```sql
CREATE USER 'username' IDENTIFIED BY 'password';
```

### Grant Privileges
```sql
GRANT SELECT ON `database`.`table` TO 'username';
```

### Prepared Statements (Prevent SQL Injection)
```sql
PREPARE `balance_check`
FROM 'SELECT * FROM `accounts` WHERE `id` = ?';

SET @id = 1;
EXECUTE `balance_check` USING @id;
```

---

## 💡 Important Concepts

### Read Replica
- Copy of database for read-only queries
- Leader handles writes
- Followers handle reads

### SQL Injection Attack
- Malicious SQL code injected through user input
- **Prevention:** Use prepared statements
- Example attack: `password' OR '1' = '1`

### Single Point of Failure
- If one component fails, entire system goes down
- Use replication to avoid this

---

## 🚀 Best Practices

✅ Use appropriate data types (save space)  
✅ Index foreign keys and frequently queried columns  
✅ Use prepared statements to prevent SQL injection  
✅ Grant minimal necessary privileges to users  
✅ Use replication for high availability  
✅ Shard carefully to avoid hotspots  

❌ Don't use overly large data types  
❌ Don't store PII without access controls  
❌ Don't concatenate user input into SQL queries  
❌ Don't create single points of failure  

---

## 📁 Related Files

- **Notes:** `notes/Lecture 6/06- Scaling.md`
- **Source Code:** `Source Code/6-Scaling/` (if available)

---

## 🎓 Learning Path

1. Install MySQL and PostgreSQL
2. Practice creating databases in both systems
3. Experiment with stored procedures
4. Understand replication models
5. Learn about prepared statements
6. Study access control mechanisms

---

## 🔧 Programming Constructs in MySQL

MySQL supports common programming constructs in stored procedures:

- `IF/THEN/ELSE` - Conditional logic
- `CASE` - Switch statements
- `LOOP`, `WHILE`, `REPEAT` - Iteration
- Variables and parameters
- Error handling

---

## 🌐 When to Use What

**SQLite:**
- Small applications
- Mobile apps
- Prototyping
- Single-user scenarios

**MySQL:**
- Web applications
- Read-heavy workloads
- E-commerce sites
- Content management systems

**PostgreSQL:**
- Complex applications
- Write-heavy workloads
- Data analytics
- Applications requiring advanced features

