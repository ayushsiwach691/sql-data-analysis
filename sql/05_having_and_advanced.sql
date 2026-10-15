-- ============================================================
-- 05_having_and_advanced.sql  |  HAVING + business metrics
-- ============================================================

-- Q25: HAVING - products whose revenue crosses 180,000
-- WHERE filters rows BEFORE grouping; HAVING filters groups AFTER aggregation.
SELECT product,
       ROUND(SUM(total_price), 2) AS total_revenue
FROM orders
GROUP BY product
HAVING SUM(total_price) > 180000
ORDER BY total_revenue DESC;

-- Q26: Repeat customers - placed more than one order
SELECT customer_id,
       COUNT(*)                   AS orders_placed,
       ROUND(SUM(total_price), 2) AS total_spent
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_spent DESC;

-- Q27: Percentage contribution of each product to total revenue
SELECT product,
       ROUND(SUM(total_price), 2) AS total_revenue,
       ROUND(100.0 * SUM(total_price) / (SELECT SUM(total_price) FROM orders), 2) AS pct_of_total
FROM orders
GROUP BY product
ORDER BY pct_of_total DESC;

-- Q28: Cancellation + return rate per product (CASE WHEN inside an aggregate)
SELECT product,
       COUNT(*) AS total_orders,
       SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
       SUM(CASE WHEN order_status = 'Returned'  THEN 1 ELSE 0 END) AS returned,
       ROUND(100.0 * SUM(CASE WHEN order_status IN ('Cancelled','Returned') THEN 1 ELSE 0 END) / COUNT(*), 2) AS loss_rate_pct
FROM orders
GROUP BY product
ORDER BY loss_rate_pct DESC;

-- Q29: Top 5 best months by revenue
SELECT strftime('%Y-%m', order_date) AS year_month,
       COUNT(*)                      AS total_orders,
       ROUND(SUM(total_price), 2)    AS total_revenue
FROM orders
GROUP BY year_month
ORDER BY total_revenue DESC
LIMIT 5;

-- Q30: Referral sources with average delivered-order value above 1000
SELECT referral_source,
       COUNT(*)                   AS delivered_orders,
       ROUND(AVG(total_price), 2) AS avg_order_value
FROM orders
WHERE order_status = 'Delivered'
GROUP BY referral_source
HAVING AVG(total_price) > 1000
ORDER BY avg_order_value DESC;
