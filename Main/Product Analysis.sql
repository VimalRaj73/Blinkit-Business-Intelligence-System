-- PRODUCT ANALYSIS

-- PRICING ANALYSIS

-- 1) Average Product Price by Category

SELECT category, AVG(price) as avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

-- 2) Average Product Price by Brand

SELECT brand, AVG(price) as avg_price
FROM products
GROUP BY brand
ORDER BY avg_price DESC;

-- 3) Product with Highest Margin %

SELECT product_name, MAX(margin_percentage) as margin_percentage
FROM products
GROUP BY product_id
LIMIT 1;

-- 4) Product with Lowest Margin %

SELECT product_name, MIN(margin_percentage) as margin_percentage
FROM products
GROUP BY product_id
LIMIT 1;