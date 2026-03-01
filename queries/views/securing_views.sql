-- ============================================
-- SECURING VIEWS - Data Privacy and Security
-- ============================================
-- Views can limit access to sensitive data by omitting certain columns.
-- Useful for sharing data with analysts while protecting PII (Personally Identifiable Information).

-- Example 1: Anonymizing Rider Information
-- Original table contains sensitive rider names
-- Create a view that shows ride data but anonymizes riders
CREATE VIEW "analysis" AS
SELECT
    "id",
    "origin",
    "destination",
    'Anonymous' AS "rider"
FROM "rides";

-- Query the secured view
SELECT * FROM "analysis";

-- Example 2: Hiding Sensitive Columns
-- Share book sales data without revealing customer information
CREATE VIEW "sales_analysis" AS
SELECT
    "sale_id",
    "book_id",
    "sale_date",
    "price",
    "quantity"
    -- Intentionally omitting: customer_name, customer_email, customer_address
FROM "sales";

-- Example 3: Masking Partial Information
-- Show partial email addresses for privacy
CREATE VIEW "user_summary" AS
SELECT
    "id",
    "username",
    SUBSTR("email", 1, 3) || '***@' || SUBSTR("email", INSTR("email", '@') + 1) AS "masked_email",
    "registration_date"
FROM "users";

-- Example 4: Role-Based Access View
-- View for managers (more data access)
CREATE VIEW "manager_view" AS
SELECT
    "employee_id",
    "name",
    "department",
    "position",
    "salary",
    "performance_rating"
FROM "employees"
WHERE "department" = 'Sales';

-- View for general users (limited data access)
CREATE VIEW "employee_directory" AS
SELECT
    "employee_id",
    "name",
    "department",
    "position"
    -- Intentionally omitting: salary, performance_rating, personal_info
FROM "employees";

-- Example 5: Aggregated Data Only
-- Share insights without individual records
CREATE VIEW "department_statistics" AS
SELECT
    "department",
    COUNT(*) AS "employee_count",
    ROUND(AVG("salary"), 0) AS "avg_salary",
    MIN("salary") AS "min_salary",
    MAX("salary") AS "max_salary"
FROM "employees"
GROUP BY "department";

-- Example 6: Time-Based Security
-- Only show current/active records
CREATE VIEW "active_accounts" AS
SELECT
    "account_id",
    "account_name",
    "account_type",
    "balance"
FROM "accounts"
WHERE "status" = 'active'
AND "closed_date" IS NULL;

-- ============================================
-- KEY POINTS:
-- ============================================
-- 1. Views can omit sensitive columns (PII, financial data, etc.)
-- 2. Views can anonymize or mask data using string functions
-- 3. Views can aggregate data to hide individual records
-- 4. Different views can provide different access levels
-- 5. Views alone don't prevent direct table access in SQLite
-- 6. For true security, combine views with proper access control

-- ============================================
-- IMPORTANT SECURITY NOTES:
-- ============================================
-- ⚠️  SQLite does not support user permissions or access control
-- ⚠️  Users with database access can still query original tables
-- ⚠️  For production systems, use DBMS with access control (PostgreSQL, MySQL, etc.)
-- ⚠️  Views are one layer of security, not the complete solution
-- ✅  Views are useful for application-level data filtering
-- ✅  Views help prevent accidental exposure of sensitive data

-- ============================================
-- BEST PRACTICES:
-- ============================================
-- 1. Always identify PII and sensitive data first
-- 2. Create views that explicitly select needed columns only
-- 3. Document which views are for which audiences
-- 4. Regular audit of what data is exposed through views
-- 5. Use database systems with proper access control for production

