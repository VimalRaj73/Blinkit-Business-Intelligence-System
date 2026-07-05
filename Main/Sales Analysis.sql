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

-- 17) Top Brands

SELECT p.brand,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY revenue DESC
LIMIT 10;

-- CATEGORY ANALYSIS

-- 18) Revenue by Category

SELECT p.category,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY revenue;

-- 19) Quantity sold by category

SELECT p.category,
	SUM(o.quantity) as total_quantity_sold
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;

-- 20) Top Category

SELECT p.category,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 10;

-- BRAND ANALYSIS

-- 21) Highest revenue brand
	
SELECT p.brand,
	SUM(o.quantity * o.unit_price) as revenue
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.brand
ORDER BY revenue DESC
LIMIT 1;

-- 22) Most sold brand

SELECT p.brand,
	SUM(o.quantity) as quantity_sold
FROM products p JOIN order_items o ON p.product_id = o.product_id
GROUP BY p.brand
ORDER BY quantity_sold DESC
LIMIT 1;

-- PAYMENT ANALYSIS

-- 23) Revenue by Payment method

SELECT payment_method, SUM(order_total) as revenue
FROM orders
GROUP BY payment_method;

-- 24) Most preferred payment method

SELECT payment_method, COUNT(order_id) as users
FROM orders
GROUP BY payment_method
ORDER BY users DESC
LIMIT 1;

-- DELIVERY PERFORMANCE VS SALES

-- 25) Average delivery time duration

SELECT
	AVG(actual_time - promised_time) as avg_delivery_duration
FROM delivery_performance;

-- 26) Delayed orders

SELECT order_id, delivery_time
FROM delivery_performance
WHERE delivery_time > 0
ORDER BY delivery_time DESC;

-- 27) Revenue affected by delays

SELECT d.delivery_time, SUM(o.order_total) as revenue
FROM delivery_performance d JOIN orders o ON d.order_id = o.order_id
WHERE d.delivery_time > 0
GROUP BY d.delivery_time
ORDER BY d.delivery_time ASC;

-- STORE PERFORMANCE

-- 28) Best performing store

SELECT store_id, SUM(order_total) as highest_revenue
FROM orders
GROUP BY store_id
ORDER BY highest_revenue DESC
LIMIT 1;

-- 29) Revenue per store

SELECT store_id, SUM(order_total) as revenue
FROM orders
GROUP BY store_id
ORDER BY revenue DESC;

-- DELIVERY PARTNER ANALYSIS

-- 30) Fastest partner

SELECT
    delivery_partner_id,
    AVG(distance_km / delivery_minutes) AS avg_speed
FROM (
    SELECT
        delivery_partner_id,
        distance_km,
        EXTRACT(EPOCH FROM (actual_time - promised_time)) / 60 AS delivery_minutes
    FROM delivery_performance
) AS t
WHERE delivery_minutes > 0
GROUP BY delivery_partner_id
ORDER BY avg_speed DESC
LIMIT 1;

-- 31) Most delayed partner

SELECT delivery_partner_id, AVG(delivery_time) as avg_delay
FROM delivery_performance
GROUP BY delivery_partner_id
ORDER BY avg_delay DESC
LIMIT 1;

-- CUSTOMER SATISFACTION

-- 32) Average rating

SELECT AVG(rating) as avg_rating 
FROM customer_feedback;

-- 33) Revenue from satisfied customers

SELECT SUM(o.order_total) as revenue
FROM orders o JOIN customer_feedback c ON o.order_id = c.order_id
WHERE c.sentiment = 'Positive';

-- 34) Rating distribution

SELECT c.rating, COUNT(o.order_id) as total_orders
FROM customer_feedback c JOIN orders o ON c.order_id = o.order_id
GROUP BY c.rating
ORDER BY c.rating ASC;

-- QUANTITY ANALYSIS

-- 35) Total units sold

SELECT SUM(quantity) as total_units_sold
FROM order_items;

-- 36) Average quantity per order

SELECT AVG(quantity) as avg_quantity
FROM order_items;

-- 37) Largest quantity purchased

SELECT MAX(quantity) as max_quantity
FROM order_items;

