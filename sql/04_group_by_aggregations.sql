-- ============================================================
-- 04_group_by_aggregations.sql  |  GROUP BY + COUNT / SUM / AVG
-- ============================================================

-- Q16: Orders per status (health of the order pipeline)
SELECT order_status,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q17: Product performance - volume, revenue, average order value
SELECT product,
       COUNT(*)                    AS total_orders,
       SUM(quantity)               AS units_sold,
       ROUND(SUM(total_price), 2)  AS total_revenue,
       ROUND(AVG(total_price), 2)  AS avg_order_value
FROM orders
GROUP BY product
ORDER BY total_revenue DESC;          -- ORDER BY can use the alias (runs after SELECT)

-- Q18: Revenue by payment method
SELECT payment_method,
       COUNT(*)                   AS total_orders,
       ROUND(SUM(total_price), 2) AS total_revenue
FROM orders
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Q19: Which marketing channel brings the most revenue?
SELECT referral_source,
       COUNT(*)                   AS total_orders,
       ROUND(SUM(total_price), 2) AS total_revenue,
       ROUND(AVG(total_price), 2) AS avg_order_value
FROM orders
GROUP BY referral_source
ORDER BY total_revenue DESC;

-- Q20: Yearly revenue trend
SELECT strftime('%Y', order_date)  AS order_year,
       COUNT(*)                    AS total_orders,
       ROUND(SUM(total_price), 2)  AS total_revenue
FROM orders
GROUP BY order_year
ORDER BY order_year;

-- Q21: Coupon usage - COUNT(*) vs COUNT(column) and the NULL rule
-- COUNT(*) counts every row; COUNT(coupon_code) skips NULLs.
SELECT COUNT(*)                         AS all_orders,
       COUNT(coupon_code)               AS orders_with_coupon,
       COUNT(*) - COUNT(coupon_code)    AS orders_without_coupon
FROM orders;

-- Q22: Orders per coupon (NULL group = no coupon used)
SELECT COALESCE(coupon_code, 'NO COUPON') AS coupon,
       COUNT(*)                           AS total_orders,
       ROUND(AVG(total_price), 2)         AS avg_order_value
FROM orders
GROUP BY coupon
ORDER BY total_orders DESC;

-- Q23: Net revenue - exclude Cancelled and Returned orders
SELECT product,
       ROUND(SUM(total_price), 2) AS net_revenue
FROM orders
WHERE order_status NOT IN ('Cancelled', 'Returned')
GROUP BY product
ORDER BY net_revenue DESC;

-- Q24: Average cart size per product
SELECT product,
       ROUND(AVG(items_in_cart), 2) AS avg_items_in_cart
FROM orders
GROUP BY product
ORDER BY avg_items_in_cart DESC;
