-- INVENTORY ANALYSIS

-- INVENTORY HEALTH

-- 1) Total Stock Received

SELECT SUM(stock_received) as total_stock_received
FROM inventory;

-- 2) Total Damaged Stock

SELECT SUM(damaged_stock) as total_damaged_stocks
FROM inventory;

-- 3) Damage Percentage

SELECT ROUND((SUM(damaged_stock)::numeric / SUM(stock_received)) * 100,2) as damage_percentage
FROM inventory;

-- PRODUCT INVENTORY

-- 4) Products below minimum stock

-- Assumption: Available stock is calculated as [Stock Received - Damaged Stock]
-- (Current stock is not available in the dataset.)

SELECT p.product_id, p.product_name, SUM(i.stock_received - i.damaged_stock) as available_stocks
FROM products p JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.product_id, p.product_name, p.min_stock_level
HAVING SUM(i.stock_received - i.damaged_stock) < p.min_stock_level
ORDER BY available_stocks ASC;

-- 5) Products with Highest Damaged Stock

SELECT p.product_name, SUM(i.damaged_stock) as total_damaged_stock
FROM products p JOIN inventory i ON p.product_id = i.product_id
GROUP BY product_name
ORDER BY total_damaged_stock DESC
LIMIT 10;

-- 6) Inventory Received by Category

SELECT p.category, SUM(i.stock_received) as inventory_received
FROM products p JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.category;

-- TREND

-- 7) Monthly Stock Received

SELECT
	DATE_TRUNC('month', inventory_date) as month,
	SUM(stock_received)
FROM inventory
GROUP BY month
ORDER BY month;

-- 8) Monthly Damaged Stock

SELECT
	DATE_TRUNC('month', inventory_date) as month,
	SUM(damaged_stock)
FROM inventory
GROUP BY month
ORDER BY month;
	