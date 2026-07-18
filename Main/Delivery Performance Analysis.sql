-- DELIVERY ANALYSIS

-- Delivery Performance

-- 1) Average Delivery Time

SELECT ROUND(AVG(delivery_time),2) as avg_delivery_time
FROM delivery_performance;

-- 2) On Time Delivery Percentage

SELECT
    ROUND(
        (COUNT(*) FILTER (WHERE delivery_status = 'On Time') * 100.0)
        / COUNT(*),2) AS ontime_delivery_percentage
FROM delivery_performance;

-- 3) Delayed Delivery Percentage

SELECT
    ROUND(
        (COUNT(*) FILTER (WHERE delivery_status != 'On Time') * 100.0)
        / COUNT(*),2) AS ontime_delivery_percentage
FROM delivery_performance;

-- DELAY ANALYSIS

-- 4) Most Common Delay Reasons

SELECT MAX(reasons_if_delayed) as delay_reason FROM delivery_performance
WHERE delivery_status != 'On Time';

-- PARTNER PERFORMANCE

-- 5) Delivery Partner Performance

SELECT 

-- 6) Fastest Delivery Partner

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

-- 7) Slowest Delivery Partner

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
