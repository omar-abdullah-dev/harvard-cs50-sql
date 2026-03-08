-- Database Replication and Scaling Concepts
-- ==================================================
-- Note: These are conceptual examples showing replication patterns.
-- Actual implementation requires database server configuration.

-- VERTICAL SCALING
-- ================
-- Increasing capacity by adding more power to a single server
-- - More CPU cores
-- - More RAM
-- - Faster disk (SSD)
-- - Better network connection
--
-- Pros: Simple, no code changes needed
-- Cons: Hardware limits, single point of failure, expensive

-- HORIZONTAL SCALING
-- ==================
-- Increasing capacity by adding more servers
-- - Distribute load across multiple machines
-- - Requires replication or sharding
--
-- Pros: Better availability, cost-effective, unlimited growth
-- Cons: More complex, consistency challenges

-- REPLICATION MODELS
-- ==================

-- 1. SINGLE-LEADER REPLICATION
-- ----------------------------
-- - One leader (primary) handles all writes
-- - Multiple followers (replicas) handle reads
-- - Leader replicates changes to followers

/*
Architecture:

    Application Writes
          ↓
    [LEADER/PRIMARY] ─────→ [FOLLOWER 1] (Read Replica)
          │
          ├─────────────→ [FOLLOWER 2] (Read Replica)
          │
          └─────────────→ [FOLLOWER 3] (Read Replica)
                           ↑
                Application Reads
*/

-- Example: Configure read replica (conceptual)
-- On Leader:
-- CREATE USER 'replication_user' IDENTIFIED BY 'password';
-- GRANT REPLICATION SLAVE ON *.* TO 'replication_user';

-- Application routes queries:
-- Writes go to: leader.example.com:3306
-- Reads go to: replica1.example.com:3306, replica2.example.com:3306

-- 2. SYNCHRONOUS vs ASYNCHRONOUS REPLICATION
-- ------------------------------------------

-- SYNCHRONOUS REPLICATION
-- Leader waits for followers to confirm write
-- Pros: Data consistency guaranteed
-- Cons: Slower writes, leader blocked if follower is down
-- Use cases: Banking, healthcare, financial transactions

/*
Write Process:
1. Application → Leader: INSERT new transaction
2. Leader → Followers: Replicate data
3. Followers → Leader: Acknowledge receipt
4. Leader → Application: Write confirmed
*/

-- ASYNCHRONOUS REPLICATION
-- Leader doesn't wait for followers
-- Pros: Fast writes, leader not blocked
-- Cons: Eventual consistency (slight delay)
-- Use cases: Social media, content platforms, analytics

/*
Write Process:
1. Application → Leader: INSERT new post
2. Leader → Application: Write confirmed (immediate)
3. Leader → Followers: Replicate data (background)
*/

-- 3. MULTI-LEADER REPLICATION
-- ---------------------------
-- Multiple servers accept writes
-- More complex conflict resolution needed

/*
Architecture:

[LEADER 1] ←→ [LEADER 2] ←→ [LEADER 3]
     ↓             ↓             ↓
[Followers]   [Followers]   [Followers]
*/

-- 4. LEADERLESS REPLICATION
-- -------------------------
-- No designated leader, all nodes are equal
-- Examples: Cassandra, DynamoDB

-- SHARDING (Horizontal Partitioning)
-- ===================================
-- Splitting database across multiple servers

-- Example: User sharding by ID range
/*
Shard 1: user_id 1-1000000      → server1.example.com
Shard 2: user_id 1000001-2000000 → server2.example.com
Shard 3: user_id 2000001-3000000 → server3.example.com
*/

-- Example: Geographic sharding
/*
Shard 1: region = 'US'     → us-server.example.com
Shard 2: region = 'EU'     → eu-server.example.com
Shard 3: region = 'ASIA'   → asia-server.example.com
*/

-- PROBLEMS WITH SHARDING
-- ----------------------

-- 1. HOTSPOTS
-- One shard gets disproportionate traffic
-- Example: Celebrity user gets millions of followers
-- Solution: Better sharding strategy, replica for hot shards

-- 2. SINGLE POINT OF FAILURE
-- If one shard goes down, part of data is unavailable
-- Solution: Replicate each shard

/*
Optimized Architecture with Sharding + Replication:

Shard 1 [Leader] → [Replica 1A] → [Replica 1B]
Shard 2 [Leader] → [Replica 2A] → [Replica 2B]
Shard 3 [Leader] → [Replica 3A] → [Replica 3B]
*/

-- PRACTICAL EXAMPLES
-- ==================

-- Example 1: Social Media Platform
-- Read-heavy workload (viewing posts vs. creating posts)
CREATE TABLE `posts` (
    `id` BIGINT AUTO_INCREMENT,
    `user_id` BIGINT,
    `content` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`),
    KEY `user_idx` (`user_id`)
);

-- Strategy: Single-leader + multiple read replicas
-- Writes: 10% of traffic → Leader
-- Reads: 90% of traffic → Distributed across 5 read replicas

-- Example 2: E-commerce Site
-- Need strong consistency for inventory
CREATE TABLE `products` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(100),
    `stock` INT NOT NULL,
    `price` DECIMAL(10, 2),
    PRIMARY KEY(`id`)
);

-- Strategy: Synchronous replication for stock updates
-- Writes: Synchronous to ensure inventory accuracy
-- Reads: Can use replicas for product browsing

-- Example 3: Analytics Platform
-- Write-heavy logging, eventual consistency OK
CREATE TABLE `events` (
    `id` BIGINT AUTO_INCREMENT,
    `user_id` BIGINT,
    `event_type` VARCHAR(50),
    `data` JSON,
    `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`)
);

-- Strategy: Asynchronous replication + sharding by time
-- Shard by month: events_2024_01, events_2024_02, etc.

-- MONITORING REPLICATION
-- ======================

-- Check replication status (MySQL)
SHOW SLAVE STATUS\G

-- Check replication lag
-- If followers are behind, queries might return stale data
SELECT
    TIMESTAMPDIFF(SECOND, last_heartbeat_timestamp, NOW()) AS lag_seconds
FROM replication_status;

-- BEST PRACTICES
-- ==============
-- ✅ Use read replicas for read-heavy workloads
-- ✅ Implement health checks and failover mechanisms
-- ✅ Monitor replication lag
-- ✅ Shard based on access patterns
-- ✅ Combine replication with sharding for best results
-- ✅ Use synchronous replication for critical data
-- ✅ Use asynchronous replication for performance
-- ✅ Plan for failure: replicate everything important
-- ❌ Don't create single points of failure
-- ❌ Don't shard prematurely (start simple)
-- ❌ Don't ignore replication lag in application logic

