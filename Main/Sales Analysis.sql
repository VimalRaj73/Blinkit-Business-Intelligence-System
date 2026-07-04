-- SALES ANALYSIS

-- OVERALL SALES PERFORMANCE

-- 1) What is the total sales ?

SELECT SUM(order_total) as total_sales
FROM orders;

-- 2) What is the Average Order Value ?

SELECT AVG(order_total) as avg_order_value
FROM orders;

-- 3) What is total no. of orders ?

SELECT COUNT(order_id) as number_of_orders
FROM orders;

-- 4) What is the Highest order ?

SELECT MAX(order_total) as highest_order_value
FROM orders;

-- 5) What is the Lowest order ?

SELECT MIN(order_total) as lowest_order_value
FROM orders;

-- SALES TREND

-- 7) Which month generated the highest revenue ?

SELECT
	DATE_TRUNC('month', order_date) as month,
	MAX(order_total) as highest_revenue
FROM orders
GROUP BY month
ORDER BY highest_revenue DESC
LIMIT 1;

-- 8) Which day has maximum orders ?

SELECT
	DATE_TRUNC('day',order_date) as day,
	COUNT(order_id) as maximum_orders
FROM orders
GROUP BY day
ORDER BY maximum_orders DESC
LIMIT 1;

-- 9) Sales trend over time 

SELECT
	DATE_TRUNC('quarter',order_date) as quarter,
	SUM(order_total) as total_sales
FROM orders
GROUP BY quarter
ORDER BY quarter;

-- CUSTOMER SALES

-- 10) Top Customers

SELECT c.customer_id, c.customer_name, o.order_total
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
ORDER BY order_total DESC
LIMIT 10;

-- 11) Revenue by customer segment

SELECT c.customer_segment,
	SUM(o.order_total) as revenue
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_segment;

-- 12) Average spending by customer segment

SELECT c.customer_segment,
	AVG(o.order_total) as average_spending
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_segment;

-- 13) Orders per customer

SELECT c.customer_id,
	COUNT(o.order_id) as total_orders
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- PRODUCT SALES

-- 14) Best selling products

SELECT p.product_name,
	SUM(o.quantity) as total_quantity_sold
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- 15) Least selling products

SELECT p.product_name,
	SUM(o.quantity) as total_quantity_sold
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold ASC
LIMIT 10;

-- 16) Highest revenue products

SELECT p.product_name,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;
	