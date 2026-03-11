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

## 📖 Complete SQL Syntax Reference

### MySQL Connection
```bash
# Connect to MySQL
mysql -u username -h hostname -P port -p

# Example
mysql -u root -h 127.0.0.1 -P 3306 -p
```

### MySQL Data Types
```sql
-- Integer types
TINYINT      -- 1 byte (-128 to 127)
SMALLINT     -- 2 bytes (-32,768 to 32,767)
MEDIUMINT    -- 3 bytes
INT          -- 4 bytes (-2 billion to 2 billion)
BIGINT       -- 8 bytes

-- Unsigned integers (0 to positive max)
INT UNSIGNED
BIGINT UNSIGNED

-- Auto-increment
id INT AUTO_INCREMENT

-- Text types
CHAR(n)      -- Fixed length
VARCHAR(n)   -- Variable length
TEXT         -- Up to 65,535 characters
MEDIUMTEXT   -- Up to 16 MB
LONGTEXT     -- Up to 4 GB
ENUM('val1', 'val2')  -- Predefined options
SET('val1', 'val2')   -- Multiple options allowed

-- Date/Time types
DATE         -- YYYY-MM-DD
TIME         -- HH:MM:SS
DATETIME     -- YYYY-MM-DD HH:MM:SS
TIMESTAMP    -- Unix timestamp
YEAR         -- YYYY

-- Numeric types
FLOAT        -- 4 bytes
DOUBLE       -- 8 bytes
DECIMAL(M,D) -- Fixed precision (M digits, D after decimal)

-- Binary
BLOB         -- Binary data
```

### MySQL CREATE TABLE
```sql
CREATE TABLE `table_name` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) UNIQUE,
    `status` ENUM('active', 'inactive') DEFAULT 'active',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `amount` DECIMAL(10,2),
    PRIMARY KEY(`id`),
    INDEX `idx_email` (`email`)
);
```

### MySQL ALTER TABLE
```sql
-- Add column
ALTER TABLE `table_name` ADD COLUMN `column_name` datatype;

-- Modify column (change type/constraints)
ALTER TABLE `table_name` MODIFY `column_name` new_datatype;

-- Change column name and type
ALTER TABLE `table_name` CHANGE `old_name` `new_name` datatype;

-- Drop column
ALTER TABLE `table_name` DROP COLUMN `column_name`;

-- Add index
ALTER TABLE `table_name` ADD INDEX `index_name` (`column_name`);

-- Add foreign key
ALTER TABLE `table_name` 
ADD CONSTRAINT `fk_name` 
FOREIGN KEY (`column`) REFERENCES `other_table`(`id`);
```

### MySQL Stored Procedures
```sql
-- Change delimiter (needed for procedures)
DELIMITER //

-- Create procedure
CREATE PROCEDURE procedure_name(IN param1 INT, OUT param2 VARCHAR(255))
BEGIN
    -- SQL statements
    SELECT column INTO param2 FROM table WHERE id = param1;
END//

-- Reset delimiter
DELIMITER ;

-- Call procedure
CALL procedure_name(5, @result);
SELECT @result;

-- Drop procedure
DROP PROCEDURE IF EXISTS procedure_name;
```

### PostgreSQL Connection
```bash
# Connect to PostgreSQL
psql postgresql://username@hostname:port/database

# Example
psql postgresql://postgres@127.0.0.1:5432/postgres
```

### PostgreSQL Data Types
```sql
-- Integer types
SMALLINT     -- 2 bytes
INTEGER      -- 4 bytes
BIGINT       -- 8 bytes
SERIAL       -- Auto-incrementing INTEGER
BIGSERIAL    -- Auto-incrementing BIGINT

-- Text types
VARCHAR(n)   -- Variable length
TEXT         -- Unlimited length
CHAR(n)      -- Fixed length

-- Numeric types
NUMERIC(precision, scale)  -- Exact decimal
REAL         -- 4 bytes floating point
DOUBLE PRECISION  -- 8 bytes floating point

-- Date/Time
DATE
TIME
TIMESTAMP
INTERVAL     -- Time duration

-- Boolean
BOOLEAN      -- TRUE/FALSE

-- Arrays (PostgreSQL-specific)
INTEGER[]
TEXT[]

-- JSON (PostgreSQL-specific)
JSON
JSONB        -- Binary JSON (faster)

-- UUID
UUID
```

### PostgreSQL CREATE TABLE
```sql
CREATE TABLE "table_name" (
    "id" SERIAL,
    "name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) UNIQUE,
    "status" VARCHAR(20) DEFAULT 'active',
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "data" JSONB,
    PRIMARY KEY("id")
);

-- With custom ENUM type
CREATE TYPE "status_type" AS ENUM ('active', 'inactive', 'pending');

CREATE TABLE "users" (
    "id" SERIAL,
    "status" status_type DEFAULT 'pending',
    PRIMARY KEY("id")
);
```

### PostgreSQL Specific Features
```sql
-- RETURNING clause (get inserted/updated data back)
INSERT INTO users (name, email)
VALUES ('John', 'john@example.com')
RETURNING id, created_at;

UPDATE users SET status = 'active'
WHERE id = 5
RETURNING *;

-- Array operations
SELECT * FROM table_name WHERE tags @> ARRAY['sql', 'database'];

-- JSON operations
SELECT data->>'name' AS name FROM table_name;
SELECT * FROM table_name WHERE data @> '{"status": "active"}';

-- Window functions (advanced)
SELECT name, salary,
       AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM employees;
```

### Access Control
```sql
-- MySQL/PostgreSQL user management

-- Create user
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

-- Grant privileges
GRANT SELECT, INSERT, UPDATE ON database.table TO 'username'@'localhost';
GRANT ALL PRIVILEGES ON database.* TO 'username'@'localhost';

-- Revoke privileges
REVOKE INSERT, UPDATE ON database.table FROM 'username'@'localhost';

-- Show grants
SHOW GRANTS FOR 'username'@'localhost';

-- Drop user
DROP USER 'username'@'localhost';

-- PostgreSQL specific
CREATE ROLE role_name WITH LOGIN PASSWORD 'password';
GRANT SELECT ON TABLE table_name TO role_name;
```

### SQL Injection Prevention
```sql
-- ❌ VULNERABLE (Never do this!)
query = "SELECT * FROM users WHERE username = '" + input + "'";

-- ✅ SAFE: Use parameterized queries (prepared statements)
-- In application code, use placeholders:

-- Java/JDBC
PreparedStatement stmt = conn.prepareStatement(
    "SELECT * FROM users WHERE username = ?"
);
stmt.setString(1, userInput);

-- Python
cursor.execute("SELECT * FROM users WHERE username = %s", (user_input,))

-- Node.js
db.query("SELECT * FROM users WHERE username = ?", [userInput]);

-- PHP PDO
$stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
$stmt->execute(['username' => $userInput]);
```

### Database Replication (Conceptual)
```sql
-- Single-leader replication
-- - One leader (primary) handles all writes
-- - Followers (replicas) replicate data
-- - Followers handle read queries

-- Configure as leader (MySQL example)
-- In my.cnf:
[mysqld]
server-id = 1
log_bin = /var/log/mysql/mysql-bin.log

-- Configure as follower
[mysqld]
server-id = 2
relay-log = /var/log/mysql/mysql-relay-bin
```

### Sharding (Conceptual)
```sql
-- Horizontal partitioning across servers

-- Example: User sharding by ID range
-- Server 1: Users with ID 1-1,000,000
-- Server 2: Users with ID 1,000,001-2,000,000
-- Server 3: Users with ID 2,000,001-3,000,000

-- Application logic determines which server to query
user_id = 1,500,000
server_num = (user_id // 1,000,000) + 1  -- Server 2

-- Hash-based sharding
server_num = hash(user_id) % number_of_servers
```

### MySQL vs PostgreSQL vs SQLite Comparison
```sql
-- Auto-increment
SQLite:     INTEGER PRIMARY KEY  -- Implicit AUTOINCREMENT
MySQL:      INT AUTO_INCREMENT
PostgreSQL: SERIAL or GENERATED ALWAYS AS IDENTITY

-- String concatenation
SQLite:     'Hello' || ' ' || 'World'
MySQL:      CONCAT('Hello', ' ', 'World')
PostgreSQL: 'Hello' || ' ' || 'World'

-- Limit/Offset
SQLite:     LIMIT 10 OFFSET 20
MySQL:      LIMIT 10 OFFSET 20  or  LIMIT 20, 10
PostgreSQL: LIMIT 10 OFFSET 20

-- Date functions
SQLite:     DATE('now')
MySQL:      NOW(), CURDATE(), CURTIME()
PostgreSQL: NOW(), CURRENT_DATE, CURRENT_TIME

-- String matching
SQLite:     column LIKE '%pattern%'
MySQL:      column LIKE '%pattern%'  or  column REGEXP 'pattern'
PostgreSQL: column LIKE '%pattern%'  or  column ~ 'pattern'
```

---

## 💡 Best Practices for Scaling

### When to Use Each Database
| Database | Best For |
|----------|----------|
| **SQLite** | Single-user apps, mobile apps, prototyping |
| **MySQL** | Web applications, read-heavy workloads |
| **PostgreSQL** | Complex queries, data integrity, write-heavy |

### Replication Strategies
1. **Single-leader** - Simple, most common
2. **Multi-leader** - Complex, for multi-datacenter
3. **Leaderless** - High availability, eventual consistency

### Sharding Considerations
- **Pros:** Handle massive data, distribute load
- **Cons:** Complex queries, joins across shards difficult
- **Key:** Choose good shard key (even distribution)

### Security Best Practices
1. **Always use prepared statements** - Prevent SQL injection
2. **Principle of least privilege** - Grant minimal permissions
3. **Never store passwords in plain text** - Use bcrypt/scrypt
4. **Validate input** - Application-level validation
5. **Use SSL/TLS** - Encrypt database connections
6. **Regular backups** - Test restore procedures
7. **Monitor access logs** - Detect suspicious activity

---

## ⚠️ Common Scaling Pitfalls

- Not planning for growth early
- Ignoring connection pooling
- Not monitoring query performance
- Over-complicating with premature sharding
- Ignoring security until it's too late
- Not testing failover procedures
- Forgetting to backup before major changes

---

## 🧑‍💻 Author

**Omar Abdullah**  
Backend Developer (Java)  
Learning database scaling with Harvard CS50 SQL
