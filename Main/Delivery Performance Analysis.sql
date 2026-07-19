-- DELIVERY ANALYSIS

-- Delivery Performance

-- 1) Average Delivery Time

SELECT ROUND(AVG(delivery_time),2) as avg_delivery_time
FROM delivery_performance;

-- 2) On Time Delivery Percentage

SELECT
    ROUND(
        (COUNT(*) FILTER (WHERE delivery_status = 'On Time') * 100.0)
        / COUNT(*),2) as ontime_delivery_percentage
FROM delivery_performance;

-- 3) Delayed Delivery Percentage

SELECT
    ROUND(
        (COUNT(*) FILTER (WHERE delivery_status != 'On Time') * 100.0)
        / COUNT(*),2) as delayed_delivery_percentage
FROM delivery_performance;

-- DELAY ANALYSIS

-- 4) Most Common Delay Reasons

SELECT MAX(reasons_if_delayed) as delay_reason
FROM delivery_performance
WHERE delivery_status != 'On Time';

-- 5) Average Delay by Delivery status

SELECT delivery_status, ROUND(AVG(delivery_time),2) as avg_delivery_time
FROM delivery_performance
WHERE delivery_status != 'On Time'
GROUP BY delivery_status;

-- PARTNER PERFORMANCE

-- 6) Delivery Partner Performance

SELECT 
	delivery_partner_id,
	COUNT(order_id) as total_orders,
	ROUND(AVG(delivery_time),2) as avg_delivery_time,
	ROUND(AVG(distance_km),2) as avg_distance,
	ROUND(COUNT(*) FILTER (WHERE delivery_status != 'On Time'),2) as delayed_delivery,
	ROUND(
        (COUNT(*) FILTER (WHERE delivery_status = 'On Time') * 100.0)
        / COUNT(*),2) as ontime_delivery_percentage
FROM delivery_performance
GROUP BY delivery_partner_id
ORDER BY ontime_delivery_percentage DESC, avg_delivery_time;

-- 7) Fastest Delivery Partner

SELECT
    delivery_partner_id,
    AVG(distance_km / delivery_time) AS avg_speed
FROM (
    SELECT
        delivery_partner_id,
        distance_km,
		delivery_time
    FROM delivery_performance
) AS t
WHERE delivery_time != 0
GROUP BY delivery_partner_id
ORDER BY avg_speed
LIMIT 1;

-- 8) Slowest Delivery Partner

SELECT
    delivery_partner_id,
    AVG(distance_km / delivery_time) AS avg_speed
FROM (
    SELECT
        delivery_partner_id,
        distance_km,
		delivery_time
    FROM delivery_performance
) AS t
WHERE delivery_time != 0
GROUP BY delivery_partner_id
ORDER BY avg_speed DESC
LIMIT 1;

-- DISTANCE ANALYSIS

-- 9) Distance vs Delivery Time

SELECT delivery_partner_id,
	ROUND(AVG(distance_km)) as avg_distance, 
	ROUND(AVG(delivery_time)) as avg_delivery_time
FROM delivery_performance
GROUP BY delivery_partner_id
ORDER BY avg_distance DESC, avg_delivery_time;

-- 10) Average Distance by Delivery Status

SELECT delivery_status, ROUND(AVG(distance_km),2) as avg_distance
FROM delivery_performance
GROUP BY delivery_status
ORDER BY avg_distance DESC;
