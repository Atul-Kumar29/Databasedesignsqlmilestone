-- ============================================================================
-- MINI E-COMMERCE PLATFORM - DATABASE DESIGN

-- ============================================================================

-- ============================================================================
-- Table 1: CATEGORIES
-- ============================================================================
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    description TEXT,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
);

-- ============================================================================
-- Table 2: PRODUCTS
-- ============================================================================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    is_active BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ============================================================================
-- Table 3: CUSTOMERS
-- ============================================================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    registration_date DATE NOT NULL,
    loyalty_points INT
);

-- ============================================================================
-- Table 4: ADDRESSES (Multi-valued attribute handling)
-- ============================================================================
CREATE TABLE addresses (
    address_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_type VARCHAR(20) NOT NULL,
    street_address VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100),
    is_default BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================================
-- Table 5: ORDERS
-- ============================================================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    billing_address_id INT NOT NULL,
    order_date TIMESTAMP,
    order_status VARCHAR(50),
    total_amount DECIMAL(10,2) NOT NULL,
    discount_applied DECIMAL(10,2),
    final_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (billing_address_id) REFERENCES addresses(address_id)
);

-- ============================================================================
-- Table 6: ORDER_ITEMS (Junction Table for M:N Relationship)
-- ============================================================================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2),
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================================
-- Table 7: REVIEWS
-- ============================================================================
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    is_verified_purchase BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    UNIQUE (customer_id, product_id)
);

-- ============================================================================
-- SAMPLE DATA
-- ============================================================================

-- Insert Categories
INSERT INTO categories (category_id, category_name, parent_category_id, description) VALUES
(1, 'Electronics', NULL, 'All electronic devices and accessories'),
(2, 'Mobile Phones', 1, 'Smartphones and mobile accessories'),
(3, 'Laptops', 1, 'Laptops and computing devices'),
(7, 'Books', NULL, 'Books and publications'),
(8, 'Fiction', 7, 'Fiction books');

-- Insert Products
INSERT INTO products (product_id, product_name, category_id, description, price, stock_quantity, is_active) VALUES
(201, 'iPhone 15 Pro', 2, 'Latest Apple smartphone with A17 chip', 99999.00, 50, TRUE),
(202, 'Samsung Galaxy S24', 2, 'Premium Android smartphone', 79999.00, 75, TRUE),
(203, 'MacBook Pro 14', 3, 'M3 Pro chip, 16GB RAM', 199999.00, 25, TRUE),
(207, 'Harry Potter Box Set', 8, 'Complete 7-book collection', 3999.00, 100, TRUE);

-- Insert Customers
INSERT INTO customers (customer_id, first_name, last_name, email, phone_number, registration_date, loyalty_points) VALUES
(301, 'John', 'David', 'john.david@email.com', '9988776655', '2023-01-15', 1500),
(302, 'Sarah', 'Johnson', 'sarah.j@email.com', '9988776656', '2023-02-20', 2200),
(303, 'Mike', 'Wilson', 'mike.wilson@email.com', '9988776657', '2023-03-10', 800),
(304, 'Emily', 'Brown', 'emily.brown@email.com', '9988776658', '2023-04-05', 3100);

-- Insert Addresses
INSERT INTO addresses (address_id, customer_id, address_type, street_address, city, state, postal_code, is_default) VALUES
(401, 301, 'Shipping', '123 Main Street, Apt 5', 'Mumbai', 'Maharashtra', '400001', TRUE),
(402, 301, 'Billing', '123 Main Street, Apt 5', 'Mumbai', 'Maharashtra', '400001', TRUE),
(403, 302, 'Shipping', '456 Oak Avenue', 'Delhi', 'Delhi', '110001', TRUE),
(404, 302, 'Billing', '789 Pine Road', 'Delhi', 'Delhi', '110002', FALSE),
(405, 303, 'Shipping', '321 Elm Street', 'Bangalore', 'Karnataka', '560001', TRUE),
(406, 303, 'Billing', '321 Elm Street', 'Bangalore', 'Karnataka', '560001', TRUE),
(407, 304, 'Shipping', '654 Maple Lane', 'Chennai', 'Tamil Nadu', '600001', TRUE),
(408, 304, 'Billing', '654 Maple Lane', 'Chennai', 'Tamil Nadu', '600001', TRUE);

-- Insert Orders
INSERT INTO orders (order_id, customer_id, shipping_address_id, billing_address_id, order_date, order_status, total_amount, discount_applied, final_amount, payment_method, payment_status) VALUES
(501, 301, 401, 402, '2024-03-01 10:30:00', 'Delivered', 99999.00, 0, 99999.00, 'CreditCard', 'Paid'),
(502, 302, 403, 404, '2024-03-02 14:15:00', 'Shipped', 79999.00, 0, 79999.00, 'UPI', 'Paid'),
(503, 303, 405, 406, '2024-03-03 09:45:00', 'Processing', 199999.00, 0, 199999.00, 'DebitCard', 'Paid'),
(504, 304, 407, 408, '2024-03-04 16:20:00', 'Delivered', 3999.00, 0, 3999.00, 'NetBanking', 'Paid');

-- Insert Order Items
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_percent, subtotal) VALUES
(601, 501, 201, 1, 99999.00, 0, 99999.00),
(603, 502, 202, 1, 79999.00, 0, 79999.00),
(604, 503, 203, 1, 199999.00, 0, 199999.00),
(605, 504, 207, 1, 3999.00, 0, 3999.00);

-- Insert Reviews
INSERT INTO reviews (review_id, customer_id, product_id, rating, review_text, is_verified_purchase) VALUES
(701, 301, 201, 5, 'Amazing phone! Best purchase ever.', TRUE),
(702, 302, 202, 4, 'Great phone but camera could be better.', TRUE),
(703, 303, 203, 5, 'Best laptop for developers!', TRUE),
(704, 304, 207, 5, 'My kids love Harry Potter!', TRUE);

-- ============================================================================
-- SQL QUERIES
-- ============================================================================

-- Query 1: Get all orders with customer details and order status
SELECT 
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    c.email,
    o.order_status,
    o.total_amount,
    o.discount_applied,
    o.final_amount,
    o.payment_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Query 2: Customers with their order details
SELECT 
    o.order_id,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    o.order_date,
    o.order_status,
    o.final_amount,
    c.loyalty_points
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Query 3: Products included in each order
SELECT 
    o.order_id,
    p.product_id,
    p.product_name,
    c.category_name,
    oi.quantity,
    oi.unit_price,
    oi.subtotal,
    p.stock_quantity
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id;

-- Query 4: Orders pending shipment with shipping city
SELECT 
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    c.phone_number,
    a.city,
    a.state,
    o.order_status,
    o.final_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN addresses a ON o.shipping_address_id = a.address_id;

-- Query 5: Category, product, and ordered item details
SELECT 
    o.order_id,
    c.category_name,
    p.product_name,
    oi.quantity,
    oi.subtotal,
    o.order_status
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id;

-- Query 6: Customer address details with related orders
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    o.order_id,
    a.address_type,
    a.street_address,
    a.city,
    a.state,
    a.postal_code,
    o.order_status
FROM customers c
JOIN addresses a ON c.customer_id = a.customer_id
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Query 7: Product reviews with customer details
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    r.review_id,
    cu.first_name,
    cu.last_name,
    r.rating,
    r.review_text,
    r.is_verified_purchase
FROM products p
JOIN categories c ON p.category_id = c.category_id
LEFT JOIN reviews r ON p.product_id = r.product_id
LEFT JOIN customers cu ON r.customer_id = cu.customer_id;

-- Query 8: Products with category details and current stock
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.stock_quantity,
    p.price,
    p.is_active
FROM products p
RIGHT JOIN categories c ON p.category_id = c.category_id;
