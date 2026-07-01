-- DATA QUALITY CHECK

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM products;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM order_items;

SELECT COUNT(*) FROM inventory;

SELECT COUNT(*) FROM delivery_performance;

SELECT COUNT(*) FROM marketing_performance;

SELECT COUNT(*) FROM customer_feedback;

-- MISSING VALUES

-- 1) CUSTOMERS TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
	COUNT(*) FILTER (WHERE customer_name IS NULL) AS customer_name_nulls,
	COUNT(*) FILTER (WHERE email IS NULL) AS email_nulls,
	COUNT(*) FILTER (WHERE phone IS NULL) AS phone_nulls,
	COUNT(*) FILTER (WHERE address IS NULL) AS address_nulls,
	COUNT(*) FILTER (WHERE area IS NULL) AS area_nulls,
	COUNT(*) FILTER (WHERE pincode IS NULL) AS pincode_nulls,
	COUNT(*) FILTER (WHERE registration_date IS NULL) AS reg_date_nulls,
	COUNT(*) FILTER (WHERE customer_segment IS NULL) AS cus_seg_nulls,
	COUNT(*) FILTER (WHERE total_orders IS NULL) AS total_orders_nulls,
	COUNT(*) FILTER (WHERE avg_order_value IS NULL) AS avg_order_nulls
FROM customers;

-- 2) PRODUCTS TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE product_id IS NULL) AS pd_id_nulls,
	COUNT(*) FILTER (WHERE product_name IS NULL) AS pd_name_nulls,
	COUNT(*) FILTER (WHERE category IS NULL) AS ctg_nulls,
	COUNT(*) FILTER (WHERE brand IS NULL) AS brand_nulls,
	COUNT(*) FILTER (WHERE price IS NULL) AS price_nulls,
	COUNT(*) FILTER (WHERE mrp IS NULL) AS mrp_nulls,
	COUNT(*) FILTER (WHERE margin_percentage IS NULL) AS mg_ptg_nulls,
	COUNT(*) FILTER (WHERE shelf_life_days IS NULL) AS shlf_lf_nulls,
	COUNT(*) FILTER (WHERE min_stock_level IS NULL) AS min_stk_nulls,
	COUNT(*) FILTER (WHERE max_stock_level IS NULL) AS max_stk_nulls
FROM products;

-- 3) ORDERS TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
	COUNT(*) FILTER (WHERE customer_id IS NULL) AS cust_id_nulls,
	COUNT(*) FILTER (WHERE order_date IS NULL) AS order_date_nulls,
	COUNT(*) FILTER (WHERE promised_delivery_time IS NULL) AS pd_tm_nulls,
	COUNT(*) FILTER (WHERE actual_delivery_time IS NULL) AS act_tm_nulls,
	COUNT(*) FILTER (WHERE delivery_status IS NULL) AS dlvry_status_nulls,
	COUNT(*) FILTER (WHERE order_total IS NULL) AS ord_total_nulls,
	COUNT(*) FILTER (WHERE payment_method IS NULL) AS pmnt_md_nulls,
	COUNT(*) FILTER (WHERE delivery_partner_id IS NULL) AS dlvry_pt_id_nulls,
	COUNT(*) FILTER (WHERE store_id IS NULL) AS store_id_nulls
FROM orders;

-- 4) ORDER_ITEMS TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
	COUNT(*) FILTER (WHERE product_id IS NULL) AS pd_id_nulls,
	COUNT(*) FILTER (WHERE quantity IS NULL) AS qty_nulls,
	COUNT(*) FILTER (WHERE unit_price IS NULL) AS unit_prc_nulls
FROM order_items;

-- 5) INVENTORY TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE product_id IS NULL) AS pd_id_nulls,
	COUNT(*) FILTER (WHERE inventory_date IS NULL) AS inv_date_nulls,
	COUNT(*) FILTER (WHERE stock_received IS NULL) AS stk_rcvd_nulls,
	COUNT(*) FILTER (WHERE damaged_stock IS NULL) AS dmgd_stks_nulls
FROM inventory;

-- 6) DELIVERY PERFORMANCE TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
	COUNT(*) FILTER (WHERE delivery_partner_id IS NULL) AS dlvry_pt_id_nulls,
	COUNT(*) FILTER (WHERE promised_time IS NULL) AS pd_tm_nulls,
	COUNT(*) FILTER (WHERE actual_time IS NULL) AS act_tm_nulls,
	COUNT(*) FILTER (WHERE delivery_time IS NULL) AS dlvry_tm_nulls,
	COUNT(*) FILTER (WHERE distance_km IS NULL) AS dist_km_nulls,
	COUNT(*) FILTER (WHERE delivery_status IS NULL) AS dlvry_status_nulls,
	COUNT(*) FILTER (WHERE reasons_if_delayed IS NULL) AS rsns_if_dly_nulls
FROM delivery_performance;

-- Imputing Null values for the column reasons_if_delayed with "No Delay"

UPDATE delivery_performance
SET reasons_if_delayed = 'No Delay'
WHERE reasons_if_delayed IS NULL;

-- 7) CUSTOMER FEEDBACK TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE feedback_id IS NULL) AS feedback_id_nulls,
	COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
	COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
	COUNT(*) FILTER (WHERE rating IS NULL) AS rating_nulls,
	COUNT(*) FILTER (WHERE feedback_text IS NULL) AS fdbk_txt_nulls,
	COUNT(*) FILTER (WHERE feedback_category IS NULL) AS fdbk_ctg_nulls,
	COUNT(*) FILTER (WHERE sentiment IS NULL) AS sentiment_nulls,
	COUNT(*) FILTER (WHERE feedback_date IS NULL) AS fdbk_date_nulls
FROM customer_feedback;

-- 8) MARKETING PERFORMANCE TABLE

SELECT COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE campaign_id IS NULL) AS cmp_id_nulls,
	COUNT(*) FILTER (WHERE campaign_name IS NULL) AS cmp_name_nulls,
	COUNT(*) FILTER (WHERE marketing_date IS NULL) AS mrkt_date_nulls,
	COUNT(*) FILTER (WHERE target_audience IS NULL) AS trgt_aud_nulls,
	COUNT(*) FILTER (WHERE channel IS NULL) AS channel_nulls,
	COUNT(*) FILTER (WHERE impression IS NULL) AS imp_nulls,
	COUNT(*) FILTER (WHERE clicks IS NULL) AS clicks_nulls,
	COUNT(*) FILTER (WHERE conversions IS NULL) AS conversion_nulls,
	COUNT(*) FILTER (WHERE spend IS NULL) AS spend_nulls,
	COUNT(*) FILTER (WHERE revenue_generated IS NULL) AS rvn_gen_nulls,
	COUNT(*) FILTER (WHERE roas IS NULL) AS roas_nulls
FROM marketing_performance;


-- DUPLICATE RECORDS

-- Are there duplicates in Customer table ?

SELECT customer_name,
    email,
    phone,
    address,
    area,
    pincode,
    registration_date,
    customer_segment,
    total_orders,
    avg_order_value,
	COUNT(*) as dupl_count 
FROM customers
GROUP BY customer_name,
    email,
    phone,
    address,
    area,
    pincode,
    registration_date,
    customer_segment,
    total_orders,
    avg_order_value
HAVING COUNT(*) > 1 ;

-- Are there duplicates in Order table ?

SELECT 
    customer_id,
    order_date,
    promised_delivery_time,
    actual_delivery_time,
    delivery_status,
    order_total,
    payment_method,
    delivery_partner_id,
    store_id,
	COUNT(*) as dup_counts
FROM orders
GROUP BY customer_id,
    order_date,
    promised_delivery_time,
    actual_delivery_time,
    delivery_status,
    order_total,
    payment_method,
    delivery_partner_id,
    store_id
HAVING COUNT(*) > 1;

-- -- Are there duplicates in Product table ?

SELECT product_name,
    category,
    brand,
    price,
    mrp,
    margin_percentage,
    shelf_life_days,
    min_stock_level,
    max_stock_level,
	COUNT(*) as dup_products
FROM products
GROUP BY product_name,
    category,
    brand,
    price,
    mrp,
    margin_percentage,
    shelf_life_days,
    min_stock_level,
    max_stock_level
HAVING COUNT(*) > 1;

-- PRIMARY KEY VALIDATION

-- Does all customer_id are unique? 

SELECT customer_id, COUNT(*) as duplicate_rows 
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1 ;

-- Does all order_id are unique ?

SELECT order_id, COUNT(*) as duplicate_rows
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Does all product_id are unique ?

SELECT product_id, COUNT(*) as duplicate_rows
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Does all feedback_id are unique ?

SELECT feedback_id, COUNT(*) as duplicate_rows
FROM customer_feedback
GROUP BY feedback_id
HAVING COUNT(*) > 1;

-- Does all campaign_id are unique ?

SELECT campaign_id, COUNT(*) as duplicate_rows
FROM marketing_performance
GROUP BY campaign_id
HAVING COUNT(*) > 1;

-- FOREIGN KEY VALIDATION

-- Does every customer_id in orders exist in customers ? 

SELECT o.order_id, c.customer_id FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Does every product_id in order_items exist in products ?

SELECT o.order_id, p.product_id FROM order_items o
LEFT JOIN products p ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Does every order_id in order_items exist in orders ?

SELECT i.order_id, o.order_id FROM order_items i
LEFT JOIN orders o ON i.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Does every order_id in customer_feedback exist in orders ?

SELECT f.feedback_id, o.order_id FROM customer_feedback f
LEFT JOIN orders o ON f.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Does every customer_id in customer_feedback exist in customers ?

SELECT f.feedback_id, c.customer_id FROM customer_feedback f
LEFT JOIN customers c ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Does every product_id in inventory exist in products ?

SELECT i.product_id, p.product_id FROM inventory i
LEFT JOIN products p ON i.product_id = p.product_id
WHERE p.product_id IS NULL;

-- BUSINESS RULE VALIDATION

-- Are there any negative delivery time ?

SELECT *
FROM delivery_performance
WHERE delivery_time < 0;

-- Are ratings only between 1 and 5 ?

SELECT *
FROM customer_feedback
WHERE rating NOT BETWEEN 1 AND 5;

-- Are there any negative price ?

SELECT *
FROM products
WHERE price < 0;

-- Is MRP always greater than or equal to Price?

SELECT *
FROM products
WHERE mrp < price; 

-- Is Damaged stock greater than stock received ?

SELECT *
FROM inventory
WHERE damaged_stock > stock_received;