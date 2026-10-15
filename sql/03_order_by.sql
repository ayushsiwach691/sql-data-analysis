-- ============================================================
-- 03_order_by.sql  |  Sorting the final result set
-- ============================================================

-- Q13: Top 10 most valuable orders
SELECT order_id, product, quantity, total_price
FROM orders
ORDER BY total_price DESC
LIMIT 10;

-- Q14: 10 most recent orders
SELECT order_id, order_date, product, order_status
FROM orders
ORDER BY order_date DESC, order_id
LIMIT 10;

-- Q15: Multi-column sort - A-Z by product, then highest value first
SELECT product, order_id, total_price
FROM orders
ORDER BY product ASC, total_price DESC
LIMIT 20;
