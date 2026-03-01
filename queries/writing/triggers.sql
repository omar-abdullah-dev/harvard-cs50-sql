-- ============================================
-- TRIGGERS - Automatic SQL Execution
-- ============================================
-- Triggers run automatically in response to INSERT, UPDATE, or DELETE
-- Used for maintaining data consistency and automating tasks

-- ============================================
-- TRIGGER BASICS
-- ============================================

-- Trigger Syntax:
-- CREATE TRIGGER trigger_name
-- [BEFORE | AFTER | INSTEAD OF] [INSERT | UPDATE | DELETE] ON table_name
-- [FOR EACH ROW]
-- [WHEN condition]
-- BEGIN
--     SQL statements;
-- END;

-- ============================================
-- BEFORE DELETE TRIGGER
-- ============================================

-- Example 1: Log artwork before it's sold (deleted)
CREATE TRIGGER "sell"
BEFORE DELETE ON "collections"
FOR EACH ROW
BEGIN
    INSERT INTO "transactions" ("title", "action", "timestamp")
    VALUES (OLD."title", 'sold', DATETIME('now'));
END;

-- Explanation:
-- - Runs BEFORE row is deleted from collections
-- - OLD refers to the row being deleted
-- - Automatically logs the sale

-- Test the trigger:
DELETE FROM "collections"
WHERE "title" = 'Farmers working at dawn';

-- Check transactions table:
SELECT * FROM "transactions";

-- ============================================
-- AFTER INSERT TRIGGER
-- ============================================

-- Example 2: Log artwork when it's bought (inserted)
CREATE TRIGGER "buy"
AFTER INSERT ON "collections"
FOR EACH ROW
BEGIN
    INSERT INTO "transactions" ("title", "action", "timestamp")
    VALUES (NEW."title", 'bought', DATETIME('now'));
END;

-- Explanation:
-- - Runs AFTER row is inserted into collections
-- - NEW refers to the row being inserted
-- - Automatically logs the purchase

-- Test the trigger:
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('New Painting', '24.001', '2024-01-01');

-- Check transactions table:
SELECT * FROM "transactions";

-- ============================================
-- AFTER UPDATE TRIGGER
-- ============================================

-- Example 3: Track price changes
CREATE TRIGGER "log_price_change"
AFTER UPDATE ON "products"
FOR EACH ROW
WHEN OLD."price" != NEW."price"
BEGIN
    INSERT INTO "price_history" ("product_id", "old_price", "new_price", "changed_at")
    VALUES (NEW."id", OLD."price", NEW."price", DATETIME('now'));
END;

-- Explanation:
-- - Runs AFTER product is updated
-- - WHEN clause: only triggers if price actually changed
-- - Logs both old and new prices

-- Test:
UPDATE "products"
SET "price" = 29.99
WHERE "id" = 100;

-- ============================================
-- BEFORE INSERT TRIGGER
-- ============================================

-- Example 4: Auto-set timestamps
CREATE TRIGGER "set_created_timestamp"
BEFORE INSERT ON "users"
FOR EACH ROW
WHEN NEW."created_at" IS NULL
BEGIN
    UPDATE NEW SET "created_at" = DATETIME('now');
END;

-- Explanation:
-- - Runs BEFORE inserting new user
-- - Only sets timestamp if it wasn't provided
-- - Ensures every row has a created_at value

-- Example 5: Validate data before insert
CREATE TRIGGER "validate_email"
BEFORE INSERT ON "users"
FOR EACH ROW
WHEN NEW."email" NOT LIKE '%@%'
BEGIN
    SELECT RAISE(ABORT, 'Invalid email format');
END;

-- Explanation:
-- - Validates email has @ symbol
-- - RAISE(ABORT) prevents the insert and shows error message

-- ============================================
-- BEFORE UPDATE TRIGGER
-- ============================================

-- Example 6: Prevent updates to locked records
CREATE TRIGGER "prevent_locked_update"
BEFORE UPDATE ON "documents"
FOR EACH ROW
WHEN OLD."locked" = 1
BEGIN
    SELECT RAISE(ABORT, 'Cannot update locked document');
END;

-- Example 7: Update timestamp on modification
CREATE TRIGGER "update_timestamp"
AFTER UPDATE ON "posts"
FOR EACH ROW
BEGIN
    UPDATE "posts"
    SET "updated_at" = DATETIME('now')
    WHERE "id" = NEW."id";
END;

-- ============================================
-- OLD AND NEW KEYWORDS
-- ============================================

-- OLD: References the row BEFORE the operation
--      Available in: UPDATE and DELETE triggers
-- NEW: References the row AFTER the operation
--      Available in: INSERT and UPDATE triggers

-- Example 8: Using both OLD and NEW
CREATE TRIGGER "track_status_change"
AFTER UPDATE ON "orders"
FOR EACH ROW
WHEN OLD."status" != NEW."status"
BEGIN
    INSERT INTO "status_log" ("order_id", "old_status", "new_status", "changed_at")
    VALUES (NEW."id", OLD."status", NEW."status", DATETIME('now'));
END;

-- ============================================
-- MULTIPLE STATEMENTS IN TRIGGERS
-- ============================================

-- Example 9: Trigger with multiple actions
CREATE TRIGGER "user_deleted"
AFTER DELETE ON "users"
FOR EACH ROW
BEGIN
    -- Log the deletion
    INSERT INTO "audit_log" ("action", "user_id", "timestamp")
    VALUES ('user_deleted', OLD."id", DATETIME('now'));

    -- Delete related data
    DELETE FROM "sessions" WHERE "user_id" = OLD."id";
    DELETE FROM "preferences" WHERE "user_id" = OLD."id";

    -- Update statistics
    UPDATE "statistics"
    SET "total_users" = "total_users" - 1;
END;

-- ============================================
-- CONDITIONAL TRIGGERS (WHEN CLAUSE)
-- ============================================

-- Example 10: Trigger only for specific conditions
CREATE TRIGGER "alert_low_stock"
AFTER UPDATE ON "inventory"
FOR EACH ROW
WHEN NEW."quantity" < 10 AND OLD."quantity" >= 10
BEGIN
    INSERT INTO "alerts" ("product_id", "message", "created_at")
    VALUES (NEW."product_id", 'Low stock alert', DATETIME('now'));
END;

-- Explanation: Only triggers when stock drops below 10

-- Example 11: Trigger only for premium users
CREATE TRIGGER "premium_order_bonus"
AFTER INSERT ON "orders"
FOR EACH ROW
WHEN (SELECT "tier" FROM "users" WHERE "id" = NEW."user_id") = 'premium'
BEGIN
    INSERT INTO "rewards" ("user_id", "points", "reason")
    VALUES (NEW."user_id", 100, 'Premium order bonus');
END;

-- ============================================
-- INSTEAD OF TRIGGERS (For Views)
-- ============================================

-- Example 12: Make view updatable
CREATE VIEW "active_users" AS
SELECT * FROM "users" WHERE "deleted" = 0;

CREATE TRIGGER "delete_from_view"
INSTEAD OF DELETE ON "active_users"
FOR EACH ROW
BEGIN
    UPDATE "users"
    SET "deleted" = 1
    WHERE "id" = OLD."id";
END;

-- Now you can delete from the view:
DELETE FROM "active_users" WHERE "id" = 5;
-- Actually performs a soft delete on the users table

-- Example 13: Insert through view
CREATE TRIGGER "insert_into_view"
INSTEAD OF INSERT ON "active_users"
FOR EACH ROW
BEGIN
    INSERT INTO "users" ("username", "email", "deleted")
    VALUES (NEW."username", NEW."email", 0);
END;

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: Inventory Management
CREATE TRIGGER "update_inventory"
AFTER INSERT ON "order_items"
FOR EACH ROW
BEGIN
    UPDATE "inventory"
    SET "quantity" = "quantity" - NEW."quantity"
    WHERE "product_id" = NEW."product_id";
END;

-- Use Case 2: Audit Trail
CREATE TRIGGER "audit_changes"
AFTER UPDATE ON "sensitive_data"
FOR EACH ROW
BEGIN
    INSERT INTO "audit_log" ("table_name", "record_id", "action", "user_id", "timestamp")
    VALUES ('sensitive_data', NEW."id", 'UPDATE', NEW."modified_by", DATETIME('now'));
END;

-- Use Case 3: Cascade Calculations
CREATE TRIGGER "update_order_total"
AFTER INSERT ON "order_items"
FOR EACH ROW
BEGIN
    UPDATE "orders"
    SET "total" = (
        SELECT SUM("price" * "quantity")
        FROM "order_items"
        WHERE "order_id" = NEW."order_id"
    )
    WHERE "id" = NEW."order_id";
END;

-- Use Case 4: Maintain Denormalized Data
CREATE TRIGGER "update_post_count"
AFTER INSERT ON "posts"
FOR EACH ROW
BEGIN
    UPDATE "users"
    SET "post_count" = "post_count" + 1
    WHERE "id" = NEW."user_id";
END;

CREATE TRIGGER "decrease_post_count"
AFTER DELETE ON "posts"
FOR EACH ROW
BEGIN
    UPDATE "users"
    SET "post_count" = "post_count" - 1
    WHERE "id" = OLD."user_id";
END;

-- Use Case 5: Referential Integrity (custom)
CREATE TRIGGER "prevent_orphan"
BEFORE DELETE ON "categories"
FOR EACH ROW
WHEN EXISTS (SELECT 1 FROM "products" WHERE "category_id" = OLD."id")
BEGIN
    SELECT RAISE(ABORT, 'Cannot delete category with products');
END;

-- Use Case 6: Auto-generate slugs
CREATE TRIGGER "generate_slug"
BEFORE INSERT ON "posts"
FOR EACH ROW
WHEN NEW."slug" IS NULL
BEGIN
    UPDATE NEW
    SET "slug" = LOWER(REPLACE(NEW."title", ' ', '-'));
END;

-- ============================================
-- MANAGING TRIGGERS
-- ============================================

-- List all triggers
SELECT "name", "tbl_name", "sql"
FROM "sqlite_master"
WHERE "type" = 'trigger';

-- View specific trigger definition
SELECT "sql"
FROM "sqlite_master"
WHERE "type" = 'trigger' AND "name" = 'sell';

-- Drop a trigger
DROP TRIGGER IF EXISTS "sell";

-- Disable/Enable triggers (SQLite doesn't support this directly)
-- Workaround: Drop and recreate when needed

-- ============================================
-- TRIGGER EXECUTION ORDER
-- ============================================

-- When multiple triggers exist on same table/event:
-- 1. BEFORE triggers execute first
-- 2. The actual operation (INSERT/UPDATE/DELETE)
-- 3. AFTER triggers execute last

-- Example: Order of execution
-- BEFORE INSERT triggers (all)
-- INSERT operation
-- AFTER INSERT triggers (all)

-- ============================================
-- RECURSIVE TRIGGERS
-- ============================================

-- By default, SQLite prevents recursive triggers
-- A trigger that modifies a table won't trigger itself again

-- Enable recursive triggers (use with caution):
PRAGMA recursive_triggers = ON;

-- Example: Propagating updates
CREATE TRIGGER "propagate_update"
AFTER UPDATE ON "nodes"
FOR EACH ROW
BEGIN
    UPDATE "nodes"
    SET "updated_at" = DATETIME('now')
    WHERE "parent_id" = NEW."id";
END;

-- ============================================
-- RAISE FUNCTION
-- ============================================

-- RAISE(IGNORE): Silently skip the operation
-- RAISE(ABORT): Stop and show error (default)
-- RAISE(FAIL): Similar to ABORT
-- RAISE(ROLLBACK): Rollback transaction

-- Example 14: Prevent deletion of admin users
CREATE TRIGGER "protect_admin"
BEFORE DELETE ON "users"
FOR EACH ROW
WHEN OLD."role" = 'admin'
BEGIN
    SELECT RAISE(ABORT, 'Cannot delete admin users');
END;

-- Example 15: Silently ignore invalid inserts
CREATE TRIGGER "ignore_invalid"
BEFORE INSERT ON "products"
FOR EACH ROW
WHEN NEW."price" < 0
BEGIN
    SELECT RAISE(IGNORE);
END;

-- Trying to insert negative price will silently fail

-- ============================================
-- COMPLEX TRIGGER EXAMPLE
-- ============================================

-- Example 16: Complete order processing
CREATE TRIGGER "process_order"
AFTER INSERT ON "orders"
FOR EACH ROW
BEGIN
    -- Update customer statistics
    UPDATE "customers"
    SET
        "total_orders" = "total_orders" + 1,
        "last_order_date" = DATE('now')
    WHERE "id" = NEW."customer_id";

    -- Log the order
    INSERT INTO "order_log" ("order_id", "status", "timestamp")
    VALUES (NEW."id", 'created', DATETIME('now'));

    -- Create notification
    INSERT INTO "notifications" ("user_id", "message", "type")
    VALUES (NEW."customer_id", 'Order placed successfully', 'order_confirmation');

    -- Update sales statistics
    UPDATE "statistics"
    SET
        "total_orders" = "total_orders" + 1,
        "total_revenue" = "total_revenue" + NEW."total"
    WHERE "date" = DATE('now');
END;

-- ============================================
-- BEST PRACTICES
-- ============================================

-- ✅ DO: Keep triggers simple and focused
-- ✅ DO: Document trigger purpose and behavior
-- ✅ DO: Use WHEN clause to limit trigger execution
-- ✅ DO: Test triggers thoroughly
-- ✅ DO: Be aware of performance impact

-- ❌ DON'T: Use triggers for complex business logic
-- ❌ DON'T: Create trigger chains (trigger calling trigger)
-- ❌ DON'T: Forget about trigger side effects
-- ❌ DON'T: Use triggers when app logic is better

-- ============================================
-- DEBUGGING TRIGGERS
-- ============================================

-- Test by inserting/updating/deleting and checking results:
BEGIN TRANSACTION;
    -- Perform operation that should trigger
    INSERT INTO "collections" (...) VALUES (...);

    -- Check if trigger worked
    SELECT * FROM "transactions" WHERE ...;

ROLLBACK;  -- Or COMMIT if satisfied

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. Triggers run automatically on INSERT, UPDATE, or DELETE
-- 2. BEFORE triggers run before the operation
-- 3. AFTER triggers run after the operation
-- 4. INSTEAD OF triggers are for views
-- 5. OLD references the row before operation
-- 6. NEW references the row after operation
-- 7. WHEN clause adds conditions to trigger execution
-- 8. RAISE function controls trigger behavior
-- 9. Multiple statements allowed in BEGIN...END block
-- 10. Test triggers thoroughly before production use

