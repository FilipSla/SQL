-- Case Study Questions
-- 1. Which customer has made the most orders?
-- I choose method using subquery, other possible is with CTE or using rank() function
SELECT customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = (
        SELECT top 1 COUNT(order_id)
        FROM orders
        GROUP BY customer_id
    );
-- 2. What's the total revenue per product?
-- basic join and sum() function
SELECT p.product_id,
    SUM(p.price * o.quantity) AS total_revenue
FROM products p
    INNER JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY total_revenue DESC;
-- 3. Find the day with the highest revenue.
WITH cte AS (
    SELECT o.order_date,
        SUM(p.price * oi.quantity) AS day_revenue
    FROM orders o
        INNER JOIN order_items oi ON o.order_id = oi.order_id
        INNER JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.order_date
)
SELECT order_date,
    day_revenue
FROM cte
WHERE day_revenue = (
        SELECT MAX(day_revenue)
        FROM cte
    );