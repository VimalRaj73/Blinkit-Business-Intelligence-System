-- ADVANCED SQL

-- 1) Top Product in Each Category

WITH category_products AS (
	SELECT 
		p.category,
		p.product_name,
		SUM(o.quantity * o.unit_price) as revenue,
		ROW_NUMBER() OVER (
			PARTITION BY p.category
			ORDER BY SUM(o.quantity * o.unit_price) DESC
		) as row_num
	FROM products p JOIN order_items o ON p.product_id = o.product_id
	GROUP BY p.product_name, p.category
)

SELECT
	category,
	product_name,
	revenue
FROM category_products
WHERE row_num = 1
ORDER BY revenue DESC;

-- 2) Month-over-Month Revenue Growth

SELECT 
	month,
	revenue,
	LAG(revenue) OVER (ORDER BY month) as last_month_revenue,
	revenue - LAG(revenue) OVER (ORDER BY month) as revenue_growth
FROM (
	SELECT 
		DATE_TRUNC('month', order_date) as month,
		SUM(order_total) as revenue
	FROM orders
	GROUP BY month
) t;

-- 3) Running Monthly Revenue

WITH monthly_revenue AS (
	SELECT 
		DATE_TRUNC('month', order_date) as month,
		SUM(order_total) as revenue
	FROM orders
	GROUP BY month
)

SELECT 
	month,
	revenue,
	SUM(revenue) OVER (
		ORDER BY month
	) as running_monthly_revenue
FROM monthly_revenue
ORDER BY month;

-- 4) Top 3 Customers in Every Segment

WITH customer_segments AS (
	SELECT
		c.customer_segment,
		c.customer_name,
		SUM(o.order_total) as revenue,
		DENSE_RANK() OVER (
		PARTITION BY c.customer_segment
		ORDER BY SUM(o.order_total) DESC
		) as customer_rank
	FROM customers c JOIN orders o ON c.customer_id = o.customer_id
	GROUP BY c.customer_segment, c.customer_name
)

SELECT customer_segment, customer_name, revenue
FROM customer_segments
WHERE customer_rank <= 3;

-- 5) Product Contribution to Total Revenue

WITH product_revenue AS (
	SELECT
		p.product_id,
		p.product_name,
		SUM(o.quantity * o.unit_price) as revenue
	FROM products p JOIN order_items o ON p.product_id = o.product_id
	GROUP BY p.product_id, p.product_name
)
SELECT
	product_id,
	product_name,
	revenue,
	ROUND(revenue * 100 / SUM(revenue) OVER(),2) as contribution_percentage 
FROM product_revenue
ORDER BY revenue DESC;

-- 6) Store Revenue Ranking

SELECT store_id,
	SUM(order_total) as revenue,
	RANK() OVER (ORDER BY SUM(order_total) DESC) as stoer_rank
FROM orders
GROUP BY store_id;

-- 7) Customers Spending above Average Order Value

WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.order_total) AS total_spend
    FROM customers c JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
),
avg_customer_spend AS (
    SELECT AVG(total_spend) AS avg_spend
    FROM customer_revenue
)

SELECT
    cr.customer_id,
    cr.customer_name,
    cr.total_spend
FROM customer_revenue cr
CROSS JOIN avg_customer_spend acs
WHERE cr.total_spend > acs.avg_spend
ORDER BY cr.total_spend DESC;

-- 8) Highest Revenue Product of Every Brand

WITH top_revenue_products AS (
	SELECT 
		p.brand,
		p.product_name,
		SUM(o.quantity * o.unit_price) as revenue,
		ROW_NUMBER() OVER (
			PARTITION BY p.brand
			ORDER BY SUM(o.quantity * o.unit_price) DESC
		) as row_num
	FROM products p JOIN order_items o ON p.product_id = o.product_id
	GROUP BY p.product_name, p.brand
)

SELECT
	brand,
	product_name,
	revenue
FROM top_revenue_products
WHERE row_num = 1
ORDER BY revenue DESC;

-- 9) Marketing Campaign Performance by ROAS

WITH campaign_performance AS (
    SELECT
        campaign_id,
        campaign_name,
        channel,
        roas,
        NTILE(4) OVER (ORDER BY roas DESC) AS performance_quartile
    FROM marketing_performance
)

SELECT
    campaign_id,
    campaign_name,
    channel,
    roas,
    performance_quartile,
    CASE
        WHEN performance_quartile = 1 THEN 'Excellent'
        WHEN performance_quartile = 2 THEN 'Good'
        WHEN performance_quartile = 3 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM campaign_performance
ORDER BY roas DESC;

-- 10) Monthly Revenue Share

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(order_total) AS revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    revenue,
    ROUND(revenue * 100.0 / SUM(revenue) OVER (),2) AS revenue_share_percentage
FROM monthly_revenue
ORDER BY month;