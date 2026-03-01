-- ============================================
-- SOFT DELETIONS WITH VIEWS
-- ============================================
-- Soft deletion marks rows as deleted without removing them from the table.
-- Views can be used to show only non-deleted records.
-- Triggers can make views behave like tables for INSERT/DELETE operations.

-- ============================================
-- SETUP: Add Soft Delete Column
-- ============================================
-- Add a "deleted" column to track soft deletions (0 = active, 1 = deleted)
ALTER TABLE "collections"
ADD COLUMN "deleted" INTEGER DEFAULT 0;

-- ============================================
-- SOFT DELETE OPERATION
-- ============================================
-- Mark a row as deleted (soft delete)
UPDATE "collections"
SET "deleted" = 1
WHERE "title" = 'Farmers working at dawn';

-- ============================================
-- VIEW: Show Only Active Records
-- ============================================
-- Create a view that excludes soft-deleted records
CREATE VIEW "current_collections" AS
SELECT
    "id",
    "title",
    "accession_number",
    "acquired"
FROM "collections"
WHERE "deleted" = 0;

-- Query the view (soft-deleted items won't appear)
SELECT * FROM "current_collections";

-- ============================================
-- TRIGGER: Delete from View = Soft Delete in Table
-- ============================================
-- INSTEAD OF trigger allows deletion operations on views
-- When you delete from the view, it performs a soft delete on the underlying table
CREATE TRIGGER "delete"
INSTEAD OF DELETE ON "current_collections"
FOR EACH ROW
BEGIN
    UPDATE "collections"
    SET "deleted" = 1
    WHERE "id" = OLD."id";
END;

-- Delete from the view (triggers soft delete in table)
DELETE FROM "current_collections"
WHERE "title" = 'Imaginative landscape';

-- Verify the deletion
SELECT * FROM "current_collections";

-- ============================================
-- TRIGGER: Insert into View (Restore Soft-Deleted)
-- ============================================
-- When inserting a row that already exists but was soft-deleted, restore it
CREATE TRIGGER "insert_when_exists"
INSTEAD OF INSERT ON "current_collections"
FOR EACH ROW
WHEN NEW."accession_number" IN (
    SELECT "accession_number" FROM "collections"
)
BEGIN
    UPDATE "collections"
    SET "deleted" = 0
    WHERE "accession_number" = NEW."accession_number";
END;

-- ============================================
-- TRIGGER: Insert into View (New Record)
-- ============================================
-- When inserting a completely new row, add it to the underlying table
CREATE TRIGGER "insert_when_new"
INSTEAD OF INSERT ON "current_collections"
FOR EACH ROW
WHEN NEW."accession_number" NOT IN (
    SELECT "accession_number" FROM "collections"
)
BEGIN
    INSERT INTO "collections" ("title", "accession_number", "acquired")
    VALUES (NEW."title", NEW."accession_number", NEW."acquired");
END;

-- ============================================
-- EXAMPLES: Using the View with Triggers
-- ============================================

-- Example 1: Soft delete through the view
DELETE FROM "current_collections"
WHERE "title" = 'Spring flowers';

-- Example 2: Restore a soft-deleted item
INSERT INTO "current_collections" ("title", "accession_number", "acquired")
VALUES ('Farmers working at dawn', '1988.123', '1988-01-15');

-- Example 3: Insert a new item
INSERT INTO "current_collections" ("title", "accession_number", "acquired")
VALUES ('Modern sculpture', '2023.456', '2023-03-01');

-- ============================================
-- VIEW: Show Only Deleted Records (Archive)
-- ============================================
CREATE VIEW "deleted_collections" AS
SELECT
    "id",
    "title",
    "accession_number",
    "acquired"
FROM "collections"
WHERE "deleted" = 1;

-- Query deleted items
SELECT * FROM "deleted_collections";

-- ============================================
-- BENEFITS OF SOFT DELETIONS
-- ============================================
-- 1. ✅ Data recovery: Deleted records can be restored
-- 2. ✅ Audit trail: Keep history of what was deleted and when
-- 3. ✅ Referential integrity: No broken foreign key relationships
-- 4. ✅ Analytics: Can analyze deleted vs active records
-- 5. ✅ Compliance: Meet data retention requirements

-- ============================================
-- DRAWBACKS OF SOFT DELETIONS
-- ============================================
-- 1. ⚠️  Increased storage: Deleted records still consume space
-- 2. ⚠️  Query complexity: Must always filter out deleted records
-- 3. ⚠️  Performance: Larger tables can slow down queries
-- 4. ⚠️  Unique constraints: Must handle soft-deleted duplicates

-- ============================================
-- ADVANCED: Add Timestamp to Track When Deleted
-- ============================================
ALTER TABLE "collections"
ADD COLUMN "deleted_at" DATETIME;

-- Update the soft delete trigger to record timestamp
DROP TRIGGER IF EXISTS "delete";

CREATE TRIGGER "delete"
INSTEAD OF DELETE ON "current_collections"
FOR EACH ROW
BEGIN
    UPDATE "collections"
    SET
        "deleted" = 1,
        "deleted_at" = DATETIME('now')
    WHERE "id" = OLD."id";
END;

-- ============================================
-- ADVANCED: Add User Tracking
-- ============================================
ALTER TABLE "collections"
ADD COLUMN "deleted_by" TEXT;

-- ============================================
-- KEY POINTS:
-- ============================================
-- 1. Soft deletions mark records as deleted without removing them
-- 2. Views filter out soft-deleted records for normal operations
-- 3. INSTEAD OF triggers make views behave like tables
-- 4. Use OLD keyword to reference the row being deleted/updated
-- 5. Use NEW keyword to reference the row being inserted
-- 6. WHEN clause adds conditions to trigger execution
-- 7. Multiple triggers can handle different scenarios (exists vs new)

