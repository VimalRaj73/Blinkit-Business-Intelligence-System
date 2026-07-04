-- DATA STRUCTURE

SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM products
LIMIT 10;

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM order_items
LIMIT 10;

SELECT *
FROM inventory
LIMIT 10;

-- CARDINALITY (DISTINCT VALUES)

SELECT
	COUNT(DISTINCT customer_segment) as customer_segment,
	COUNT(DISTINCT area) AS areas
FROM customers;

SELECT
	COUNT(DISTINCT category) as categories,
	COUNT(DISTINCT BRAND) as brands
FROM products;

SELECT
	COUNT(DISTINCT payment_method) as payment_methods,
	COUNT(DISTINCT delivery_status) as delivery_status
FROM orders;

-- CATEGORY FREQUENCY

-- TYPES OF CUSTOMERS

SELECT customer_segment,
COUNT(*) as customer
FROM customers
GROUP BY customer_segment
ORDER BY customer DESC;

-- TYPES OF PRODUCT CATEGORY

SELECT category,
COUNT(*) as product_count
FROM products
GROUP BY category
ORDER BY product_count DESC;

-- TYPES OF PAYMENT

SELECT payment_method,
COUNT(*) as payments
FROM orders
GROUP BY payment_method;

-- TYPES OF DELIVERY BY STATUS

SELECT delivery_status,
COUNT(*) as delivery_status_count
FROM delivery_performance
GROUP BY delivery_status;

-- TYPES OF CHANNEL

SELECT channel,
COUNT(*) as channel_count
FROM marketing_performance
GROUP BY channel;

-- DATE EXPLORATION

-- REGISTRATION DATE

SELECT 
	MIN(registration_date) as first_date,
	MAX(registration_date) as last_date
FROM customers;

-- ORDER DATE

SELECT
	MIN(order_date) as first_order_date,
	MAX(order_date) as last_order_date
FROM orders;

-- ORDERS BY MONTH

SELECT
	DATE_TRUNC('month', order_date) as month,
	COUNT(*) as total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- NUMERICAL SUMMARY STATISTICS

-- PRODUCTS

SELECT
	MIN(price),
	MAX(price),
	AVG(price),
	STDDEV(price)
FROM products;

-- TOTAL ORDERS

SELECT
	MIN(order_total),
	MAX(order_total),
	AVG(order_total),
	STDDEV(order_total)
FROM orders;

-- QUANTITY 

SELECT
	MIN(quantity),
	MAX(quantity),
	AVG(quantity),
	STDDEV(quantity)
FROM order_items

-- RANGE EXPLORATION

-- PRODUCTS
SELECT *
FROM products
ORDER BY PRICE DESC
LIMIT 10;

SELECT *
FROM products
ORDER BY price
LIMIT 10;

-- ORDERS

SELECT *
FROM orders
ORDER BY order_total DESC
LIMIT 10;

SELECT *
FROM orders
ORDER BY order_total
LIMIT 10;
