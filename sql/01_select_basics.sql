-- ============================================================
-- 01_select_basics.sql  |  SELECT fundamentals
-- ============================================================

-- Q01: Preview the first 10 rows
SELECT *
FROM orders
LIMIT 10;

-- Q02: Pick specific columns and rename them with aliases
SELECT order_id        AS "Order",
       order_date      AS "Date",
       product         AS "Product",
       total_price     AS "Order Value"
FROM orders
LIMIT 10;

-- Q03: Which products do we sell? (DISTINCT)
SELECT DISTINCT product
FROM orders
ORDER BY product;

-- Q04: Dataset size - total orders, unique customers, date range
SELECT COUNT(*)                    AS total_orders,
       COUNT(DISTINCT customer_id) AS unique_customers,
       MIN(order_date)             AS first_order,
       MAX(order_date)             AS last_order
FROM orders;
