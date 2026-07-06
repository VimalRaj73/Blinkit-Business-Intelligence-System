-- SALES ANALYSIS

-- OVERALL SALES PERFORMANCE

-- 1) Total Revenue 

SELECT SUM(order_total) as total_sales
FROM orders;

-- 2) Average Order Value

SELECT AVG(order_total) as avg_order_value
FROM orders;

-- 3) Total Orders

SELECT COUNT(order_id) as number_of_orders
FROM orders;

-- SALES TREND

-- 4) Monthly Revenue Trend

SELECT
	DATE_TRUNC('month', order_date) as month,
	SUM(order_total) as revenue
FROM orders
GROUP BY month
ORDER BY revenue DESC;

-- 5) Quarterly Revenue Trend

SELECT
	DATE_TRUNC('quarter',order_date) as quarter,
	SUM(order_total) as total_sales
FROM orders
GROUP BY quarter
ORDER BY quarter;

-- 6) Day Order Trend

SELECT
	DATE_TRUNC('day',order_date) as day,
	COUNT(order_id) as maximum_orders
FROM orders
GROUP BY day
ORDER BY maximum_orders DESC;

-- 7) Weekend vs Weekday Sales

SELECT 
	CASE WHEN EXTRACT(ISODOW FROM order_date) < 6
		THEN 'weekdays'
		ELSE 'weekend'
	END AS day_type,
	SUM(order_total) as revenue
FROM orders
GROUP BY day_type;

-- CUSTOMER SALES

-- 8) Revenue by customer segment

SELECT c.customer_segment,
	SUM(o.order_total) as revenue
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_segment;

-- 9) Average spending by customer segment

SELECT c.customer_segment,
	AVG(o.order_total) as average_spending
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_segment;

-- 10) Orders by customer segment

SELECT c.customer_segment,
	COUNT(o.order_id) as total_orders
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_segment;

-- PRODUCT SALES

-- 11) Best selling products (by Quantity)

SELECT p.product_name,
	SUM(o.quantity) as total_quantity_sold
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- 12) Highest revenue products

SELECT p.product_name,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- 13) Revenue by Category

SELECT p.category,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY revenue;

-- 14) Revenue by Brand

SELECT p.brand,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.brand
ORDER BY revenue DESC;

-- STORE PERFORMANCE

-- 15) Best performing store

SELECT store_id, SUM(order_total) as highest_revenue
FROM orders
GROUP BY store_id
ORDER BY highest_revenue DESC
LIMIT 1;

-- 16) Revenue per store

SELECT store_id, SUM(order_total) as revenue
FROM orders
GROUP BY store_id
ORDER BY revenue DESC;

-- PAYMENT ANALYSIS

-- 17) Revenue by Payment method

SELECT payment_method, SUM(order_total) as revenue
FROM orders
GROUP BY payment_method;

-- 18) Most preferred payment method

SELECT payment_method, COUNT(order_id) as users
FROM orders
GROUP BY payment_method
ORDER BY users DESC
LIMIT 1;
