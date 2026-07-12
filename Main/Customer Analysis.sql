-- CUSTOMER ANALYSIS

-- CUSTOMER BEHAVIOUR

-- 1) Top 10 Customers by Revenue

SELECT c.customer_name, SUM(o.order_total) as revenue
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY revenue DESC
LIMIT 10;

-- 2) Top 10 Customers by Orders

SELECT c.customer_name, COUNT(o.order_id) as total_orders
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- 3) Average Orders per Customer

SELECT AVG(total_orders) as avg_orders
FROM
	(SELECT COUNT(o.order_id) as total_orders
	FROM orders o JOIN customers c ON o.customer_id = c.customer_id
	GROUP BY c.customer_id) t;

-- 4) Average spend per Customer

SELECT AVG(order_amount) as avg_spend
FROM
	(SELECT SUM(o.order_total) as order_amount
	FROM orders o JOIN customers c ON o.customer_id = c.customer_id
	GROUP BY c.customer_id) t;

-- CUSTOMER SEGMENTATION

-- 5) Premium vs Regular Customer Distribution

SELECT customer_segment, COUNT(customer_id) as total_customers
FROM customers
WHERE customer_segment IN ('Premium','Regular')
GROUP BY customer_segment;

-- 6) Revenue Contribution by Segment

SELECT customer_segment, SUM(order_total) as revenue
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY customer_segment;

-- 7) New Customers per Month

SELECT
	DATE_TRUNC('month',registration_date) as monthly_trend,
	COUNT(customer_id) as registered_customers
FROM customers
GROUP BY monthly_trend
ORDER BY monthly_trend;

-- 8) Customer Distribution by Area

SELECT area, COUNT(customer_id) as total_customers
FROM customers
GROUP BY area
ORDER BY total_customers DESC;