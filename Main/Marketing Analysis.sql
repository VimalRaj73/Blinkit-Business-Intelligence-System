-- MARKETING ANALYSIS

-- CAMPAIGN PERFORMANCE

-- 1) Total Marketing Spend

SELECT SUM(spend) as total_spend
FROM marketing_performance;

-- 2) Total Revenue Generated

SELECT SUM(revenue_generated) as total_revenue_generated
FROM marketing_performance;

-- 3) Average ROAS (Return on Ad Spend)

SELECT ROUND(AVG(roas),2) as avg_roas
FROM marketing_performance;

-- CHANNEL ANALYSIS

-- 4) Highest Revenue Channel

SELECT channel, ROUND(SUM(revenue_generated)) as revenue
FROM marketing_performance
GROUP BY channel
ORDER BY revenue DESC
LIMIT 1;

-- 5) Highest ROAS channel

SELECT channel, ROUND(SUM(roas)) as total_roas
FROM marketing_performance
GROUP BY channel
ORDER BY total_roas DESC
LIMIT 1;

-- 6) Highest Conversion Channel

SELECT channel, SUM(conversions) as total_conversions
FROM marketing_performance
GROUP BY channel
ORDER BY total_conversions DESC
LIMIT 1;

-- AUDIENCE ANALYSIS

-- 7) Revenue by Target Audience

SELECT target_audience, SUM(revenue_generated) as revenue
FROM marketing_performance
GROUP BY target_audience
ORDER BY revenue DESC;

-- 8) ROAS by Audience

SELECT target_audience, SUM(ROAS) as roas
FROM marketing_performance
GROUP BY target_audience
ORDER BY roas DESC;

-- CAMPAIGN RANKING

-- 9) Top Campaigns by Revenue

SELECT campaign_name, ROUND(SUM(revenue_generated)) as revenue
FROM marketing_performance
GROUP BY campaign_name
ORDER BY revenue DESC;

-- 10) Top Campaigns by Conversions

SELECT campaign_name, ROUND(SUM(conversions)) as total_conversions
FROM marketing_performance
GROUP BY campaign_name
ORDER BY total_conversions DESC;

SELECT conversions FROM marketing_performance

