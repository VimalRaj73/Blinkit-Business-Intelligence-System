-- CUSTOMER FEEDBACK ANALYSIS

-- RATINGS

-- 1) Average rating

SELECT AVG(rating) as avg_rating
FROM customer_feedback;

-- 2) Rating Distribution

SELECT rating, COUNT(rating) as rating_distribution
FROM customer_feedback
GROUP BY rating
ORDER BY rating;

-- 3) Rating by Customer Segment

SELECT c.customer_segment, ROUND(AVG(f.rating),2) as avg_rating
FROM customer_feedback f JOIN customers c ON f.customer_id = c.customer_id
GROUP BY c.customer_segment;

-- SENTIMENT

-- 4) Positive vs Neutral vs Negative

SELECT sentiment, COUNT(sentiment) as sentiment_distribution
FROM customer_feedback
GROUP BY sentiment;

-- 5) Sentiment by Feedback Category

SELECT feedback_category, sentiment, COUNT(sentiment) as sentiment_distribution
FROM customer_feedback
GROUP BY feedback_category, sentiment
ORDER BY sentiment DESC, sentiment_distribution DESC;

-- FEEDBACK

-- 6) Most Common Feedback Category

SELECT feedback_category, COUNT(feedback_category) as no_of_feedback
FROM customer_feedback
GROUP BY feedback_category
LIMIT 1;

-- 7) Average Rating by Delivery Status

SELECT d.delivery_status, ROUND(AVG(f.rating),2) as avg_rating
FROM customer_feedback f JOIN delivery_performance d ON f.order_id = d.order_id
GROUP BY d.delivery_status;

