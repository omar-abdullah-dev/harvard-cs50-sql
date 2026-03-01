-- ============================================
-- SUM - Calculating Totals
-- ============================================
-- SUM adds up numeric values from multiple rows

-- ============================================
-- BASIC SUM USAGE
-- ============================================

-- Example 1: Calculate total votes for all books
SELECT SUM("votes") AS "total_votes"
FROM "longlist";

-- Example 2: Sum with specific condition
SELECT SUM("rating") AS "sum_of_ratings"
FROM "longlist"
WHERE "year" = 2023;

-- Example 3: Multiple SUM calculations
SELECT
    SUM("price") AS "total_revenue",
    SUM("quantity") AS "total_items_sold"
FROM "sales";

-- ============================================
-- SUM WITH GROUP BY
-- ============================================

-- Example 4: Sum by category
SELECT
    "category",
    SUM("sales") AS "total_sales"
FROM "products"
GROUP BY "category";

-- Example 5: Sum by year
SELECT
    "year",
    SUM("votes") AS "total_votes_per_year"
FROM "longlist"
GROUP BY "year"
ORDER BY "year";

-- Example 6: Sum with multiple grouping
SELECT
    "year",
    "publisher",
    SUM("votes") AS "total_votes"
FROM "longlist"
GROUP BY "year", "publisher"
ORDER BY "year", "total_votes" DESC;

-- ============================================
-- SUM WITH CALCULATIONS
-- ============================================

-- Example 7: Calculate total revenue (price * quantity)
SELECT SUM("price" * "quantity") AS "total_revenue"
FROM "order_items";

-- Example 8: Sum with discounts
SELECT SUM("price" * (1 - "discount")) AS "total_after_discount"
FROM "products";

-- Example 9: Sum with conditions in calculation
SELECT SUM(
    CASE
        WHEN "status" = 'completed' THEN "amount"
        ELSE 0
    END
) AS "completed_revenue"
FROM "orders";

-- ============================================
-- SUM WITH HAVING
-- ============================================

-- Example 10: Show only categories with high total sales
SELECT
    "category",
    SUM("sales") AS "total_sales"
FROM "products"
GROUP BY "category"
HAVING SUM("sales") > 10000;

-- Example 11: Publishers with many votes
SELECT
    "publisher",
    SUM("votes") AS "total_votes"
FROM "longlist"
GROUP BY "publisher"
HAVING SUM("votes") > 50000
ORDER BY "total_votes" DESC;

-- ============================================
-- SUM WITH JOIN
-- ============================================

-- Example 12: Sum across joined tables
SELECT
    "customers"."name",
    SUM("orders"."total") AS "total_spent"
FROM "customers"
JOIN "orders" ON "customers"."id" = "orders"."customer_id"
GROUP BY "customers"."id", "customers"."name"
ORDER BY "total_spent" DESC;

-- Example 13: Sum with multiple joins
SELECT
    "categories"."name",
    SUM("order_items"."quantity" * "order_items"."price") AS "category_revenue"
FROM "categories"
JOIN "products" ON "categories"."id" = "products"."category_id"
JOIN "order_items" ON "products"."id" = "order_items"."product_id"
GROUP BY "categories"."id", "categories"."name"
ORDER BY "category_revenue" DESC;

-- ============================================
-- SUM WITH NULL VALUES
-- ============================================

-- Example 14: SUM ignores NULL values
SELECT SUM("rating") AS "sum_of_ratings"
FROM "longlist";
-- NULL values are automatically excluded

-- Example 15: Count rows vs SUM check
SELECT
    COUNT(*) AS "total_rows",
    COUNT("rating") AS "rows_with_rating",
    SUM("rating") AS "sum_of_ratings"
FROM "longlist";

-- Example 16: Handle NULL with COALESCE
SELECT SUM(COALESCE("amount", 0)) AS "total"
FROM "transactions";
-- Treats NULL as 0

-- ============================================
-- SUM WITH DISTINCT
-- ============================================

-- Example 17: Sum unique values only
SELECT SUM(DISTINCT "price") AS "sum_of_unique_prices"
FROM "products";

-- Example 18: Difference between SUM and SUM DISTINCT
SELECT
    SUM("price") AS "total_all_prices",
    SUM(DISTINCT "price") AS "total_unique_prices"
FROM "products";

-- ============================================
-- ROUNDING SUM RESULTS
-- ============================================

-- Example 19: Round sum to 2 decimal places
SELECT ROUND(SUM("price"), 2) AS "total_price"
FROM "products";

-- Example 20: Format currency
SELECT '$' || ROUND(SUM("amount"), 2) AS "total_revenue"
FROM "sales";

-- ============================================
-- CONDITIONAL SUM
-- ============================================

-- Example 21: Sum only specific rows with CASE
SELECT
    SUM(CASE WHEN "status" = 'paid' THEN "amount" ELSE 0 END) AS "paid_total",
    SUM(CASE WHEN "status" = 'pending' THEN "amount" ELSE 0 END) AS "pending_total",
    SUM(CASE WHEN "status" = 'cancelled' THEN "amount" ELSE 0 END) AS "cancelled_total"
FROM "invoices";

-- Example 22: Multiple conditional sums
SELECT
    "year",
    SUM(CASE WHEN "rating" >= 4.0 THEN 1 ELSE 0 END) AS "highly_rated",
    SUM(CASE WHEN "rating" < 3.0 THEN 1 ELSE 0 END) AS "poorly_rated"
FROM "longlist"
GROUP BY "year";

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: Sales Report
SELECT
    DATE("order_date") AS "date",
    SUM("total") AS "daily_revenue"
FROM "orders"
WHERE "order_date" >= DATE('now', '-30 days')
GROUP BY DATE("order_date")
ORDER BY "date";

-- Use Case 2: Inventory Value
SELECT
    SUM("quantity" * "unit_price") AS "total_inventory_value"
FROM "inventory";

-- Use Case 3: Customer Lifetime Value
SELECT
    "customer_id",
    SUM("total") AS "lifetime_value",
    COUNT(*) AS "order_count"
FROM "orders"
GROUP BY "customer_id"
ORDER BY "lifetime_value" DESC
LIMIT 10;

-- Use Case 4: Monthly Revenue
SELECT
    strftime('%Y-%m', "order_date") AS "month",
    SUM("total") AS "monthly_revenue"
FROM "orders"
GROUP BY strftime('%Y-%m', "order_date")
ORDER BY "month";

-- Use Case 5: Department Budgets
SELECT
    "department",
    SUM("salary") AS "total_payroll"
FROM "employees"
GROUP BY "department"
ORDER BY "total_payroll" DESC;

-- ============================================
-- SUM WITH SUBQUERIES
-- ============================================

-- Example 23: Sum in subquery
SELECT
    "category",
    "total_sales",
    (SELECT SUM("sales") FROM "products") AS "overall_total",
    ROUND("total_sales" * 100.0 / (SELECT SUM("sales") FROM "products"), 2) AS "percentage"
FROM (
    SELECT
        "category",
        SUM("sales") AS "total_sales"
    FROM "products"
    GROUP BY "category"
) AS category_sales;

-- Example 24: Compare to average total
SELECT
    "store_id",
    SUM("sales") AS "store_total"
FROM "sales"
GROUP BY "store_id"
HAVING SUM("sales") > (
    SELECT AVG(store_total)
    FROM (
        SELECT SUM("sales") AS store_total
        FROM "sales"
        GROUP BY "store_id"
    )
);

-- ============================================
-- COMBINING SUM WITH OTHER AGGREGATES
-- ============================================

-- Example 25: Multiple aggregations together
SELECT
    "category",
    COUNT(*) AS "product_count",
    SUM("sales") AS "total_sales",
    AVG("sales") AS "avg_sales",
    MIN("sales") AS "min_sales",
    MAX("sales") AS "max_sales"
FROM "products"
GROUP BY "category";

-- Example 26: Comprehensive statistics
SELECT
    COUNT(*) AS "total_orders",
    SUM("total") AS "revenue",
    AVG("total") AS "avg_order_value",
    MIN("total") AS "smallest_order",
    MAX("total") AS "largest_order"
FROM "orders"
WHERE "status" = 'completed';

-- ============================================
-- WINDOW FUNCTIONS WITH SUM
-- ============================================

-- Example 27: Running total (cumulative sum)
SELECT
    "date",
    "amount",
    SUM("amount") OVER (ORDER BY "date") AS "running_total"
FROM "transactions"
ORDER BY "date";

-- Example 28: Sum by partition
SELECT
    "category",
    "product_name",
    "sales",
    SUM("sales") OVER (PARTITION BY "category") AS "category_total"
FROM "products"
ORDER BY "category", "sales" DESC;

-- ============================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================

-- ✅ SUM with indexed columns is fast
-- ✅ SUM with WHERE clause reduces rows to sum
-- ⚠️ SUM on calculated columns can be slower
-- ⚠️ Large tables without indexes can be slow

-- Optimized:
SELECT SUM("amount")
FROM "transactions"
WHERE "date" >= '2024-01-01'  -- Uses index
AND "status" = 'completed';

-- Less optimized:
SELECT SUM("price" * "quantity" * (1 - "discount"))
FROM "complex_table";  -- Calculates for each row

-- ============================================
-- COMMON PATTERNS
-- ============================================

-- Pattern 1: Total with percentage
SELECT
    "category",
    SUM("sales") AS "category_sales",
    ROUND(SUM("sales") * 100.0 / (SELECT SUM("sales") FROM "products"), 2) AS "percentage"
FROM "products"
GROUP BY "category";

-- Pattern 2: Comparison to goal
SELECT
    "salesperson",
    SUM("sales") AS "total_sales",
    10000 AS "goal",
    CASE
        WHEN SUM("sales") >= 10000 THEN 'Met Goal'
        ELSE 'Below Goal'
    END AS "status"
FROM "sales"
GROUP BY "salesperson";

-- Pattern 3: Year-over-year comparison
SELECT
    strftime('%Y', "date") AS "year",
    SUM("revenue") AS "total_revenue"
FROM "sales"
GROUP BY strftime('%Y', "date")
ORDER BY "year";

-- ============================================
-- ERROR HANDLING
-- ============================================

-- Example 29: Avoid summing non-numeric data
-- ❌ WRONG:
-- SELECT SUM("name") FROM "products";  -- Error!

-- ✅ CORRECT: Sum only numeric columns
SELECT SUM("price") FROM "products";

-- Example 30: Check for NULL results
SELECT
    COALESCE(SUM("amount"), 0) AS "total"
FROM "transactions"
WHERE "date" = '2024-01-01';
-- Returns 0 if no rows match instead of NULL

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. SUM adds up numeric values from multiple rows
-- 2. Returns NULL if no rows match (use COALESCE for 0)
-- 3. Automatically ignores NULL values in column
-- 4. Can use with GROUP BY to sum by category
-- 5. Combine with HAVING to filter grouped results
-- 6. Use CASE for conditional sums
-- 7. Works with calculated columns
-- 8. Can use with DISTINCT for unique values
-- 9. Combine with other aggregates (COUNT, AVG, etc.)
-- 10. Use window functions for running totals

