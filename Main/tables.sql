CREATE TABLE customers (
	customer_id BIGINT PRIMARY KEY,
	customer_name VARCHAR(100),
	email VARCHAR(150),
	phone BIGINT,
	address TEXT,
	area VARCHAR(100),
	pincode INTEGER,
	registration_date DATE,
	customer_segment VARCHAR(25),
	total_orders INTEGER,
	avg_order_value NUMERIC(10,2)
);

CREATE TABLE products (
	product_id BIGINT PRIMARY KEY,
	product_name VARCHAR(10),
	category VARCHAR(100),
	brand VARCHAR(100),
	price NUMERIC(10,2),
	mrp NUMERIC(10,2),
	margin_percentage NUMERIC(5,2),
	shelf_life_days INTEGER,
	min_stock_level INTEGER,
	max_stock_level INTEGER
);

CREATE TABLE orders (
	order_id BIGINT PRIMARY KEY,
	customer_id BIGINT,
	order_date TIMESTAMP,
	promised_delivery_time TIMESTAMP,
	actual_delivery_time TIMESTAMP,
	delivery_status VARCHAR(30),
	order_total NUMERIC(10,2),
	payment_method VARCHAR(20),
	delivery_partner_id BIGINT,
	store_id BIGINT,

	FOREIGN KEY (customer_id)
	REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
	order_id BIGINT,
	product_id BIGINT,
	quantity INTEGER,
	unit_price NUMERIC(10,2),

	FOREIGN KEY (order_id)
	REFERENCES orders (order_id),

	FOREIGN KEY (product_id)
	REFERENCES products (product_id)
);

DROP TABLE delivery_performance CASCADE;

CREATE TABLE delivery_performance (
    order_id BIGINT PRIMARY KEY,
    delivery_partner_id BIGINT,
    promised_time TIMESTAMP,
    actual_time TIMESTAMP,
    delivery_time NUMERIC(6,2),
    distance_km NUMERIC(5,2),
    delivery_status VARCHAR(100),
    reasons_if_delayed VARCHAR(50),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

CREATE TABLE customer_feedback (
	feedback_id BIGINT PRIMARY KEY,
	order_id BIGINT,
	customer_id BIGINT,
	rating INTEGER,
	feedback_text TEXT,
	feedback_category VARCHAR(50),
	sentiment VARCHAR(20),
	feedback_date DATE,

	FOREIGN KEY (order_id)
	REFERENCES orders (order_id),

	FOREIGN KEY (customer_id)
	REFERENCES customers (customer_id)	
);

CREATE TABLE inventory (
	product_id BIGINT PRIMARY KEY,
	inventory_date DATE,
	stock_received INTEGER,
	damaged_stock INTEGER,

	FOREIGN KEY (product_id)
	REFERENCES products (product_id)
);

CREATE TABLE marketing_performance (
	campaign_id BIGINT PRIMARY KEY,
	campaign_name VARCHAR(100),
	marketing_date DATE,
	target_audience VARCHAR(50),
	channel VARCHAR(50),
	impression INTEGER,
	clicks INTEGER,
	conversions INTEGER,
	spend NUMERIC(10,2),
	revenue_generated NUMERIC(10,2),
	roas NUMERIC(5,2)
);
