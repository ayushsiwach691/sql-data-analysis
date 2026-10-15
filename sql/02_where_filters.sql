-- ============================================================
-- 02_where_filters.sql  |  WHERE = the row-level funnel
-- ============================================================

-- Q05: Equality - all delivered orders
SELECT order_id, order_date, product, total_price
FROM orders
WHERE order_status = 'Delivered'
LIMIT 20;

-- Q06: Comparison - high-value orders (>= 3000)
SELECT order_id, product, quantity, unit_price, total_price
FROM orders
WHERE total_price >= 3000
ORDER BY total_price DESC;

-- Q07: AND - delivered laptop orders paid by credit card
SELECT order_id, order_date, customer_id, total_price
FROM orders
WHERE product = 'Laptop'
  AND payment_method = 'Credit Card'
  AND order_status = 'Delivered';

-- Q08: IN - orders for selected products
SELECT order_id, product, total_price
FROM orders
WHERE product IN ('Laptop', 'Phone', 'Tablet', 'Monitor')
LIMIT 20;

-- Q09: BETWEEN - orders placed in calendar year 2024
SELECT COUNT(*) AS orders_in_2024,
       ROUND(SUM(total_price), 2) AS revenue_2024
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Q10: IS NULL - orders placed WITHOUT any coupon
SELECT order_id, product, total_price
FROM orders
WHERE coupon_code IS NULL
LIMIT 20;

-- Q11: LIKE - pattern matching on tracking numbers
SELECT order_id, tracking_number
FROM orders
WHERE tracking_number LIKE 'TRK9%'
LIMIT 20;

-- Q12: The Alias Trap - filter on the expression, not the alias
-- WHERE runs BEFORE SELECT, so the alias "calc_value" doesn't exist yet.
-- (SQLite is lenient, but MySQL / PostgreSQL / SQL Server would throw an error.)
--   WRONG:  SELECT quantity * unit_price AS calc_value FROM orders WHERE calc_value > 2000;
--   RIGHT:
SELECT order_id,
       quantity * unit_price AS calc_value
FROM orders
WHERE quantity * unit_price > 2000
LIMIT 20;
