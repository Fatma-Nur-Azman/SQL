-- Table 1: customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO customers (customer_id, first_name, last_name, email, city, country) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 'Istanbul', 'Turkey'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', 'Ankara', 'Turkey'),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', 'Izmir', 'Turkey'),
(4, 'Emily', 'Davis', 'emily.davis@example.com', 'Antalya', 'Turkey'),
(5, 'Daniel', 'Brown', 'daniel.brown@example.com', 'Bursa', 'Turkey');

-- Table 2: orders

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, order_date, customer_id, total_amount) VALUES
(1, '2023-01-01', 1, 100.00),
(2, '2023-01-05', 2, 150.00),
(3, '2023-01-10', 1, 200.00),
(4, '2023-01-15', 3, 50.00),
(5, '2023-01-20', 4, 300.00),
(6, '2023-01-25', 5, 75.00);

-- Table 3: order_items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO order_items (order_item_id, order_id, product_name, quantity, price) VALUES
(1, 1, 'Laptop', 1, 100.00),
(2, 2, 'Mouse', 2, 50.00),
(3, 3, 'Keyboard', 1, 200.00),
(4, 4, 'Monitor', 1, 50.00),
(5, 5, 'Printer', 1, 300.00),
(6, 6, 'USB Cable', 3, 25.00);

-- 1.Find the total spending of each customer.

SELECT c.customer_id, 
	c.first_name, 
	c.last_name, 
	SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

--2. Find the customer who placed the most orders.

SELECT c.customer_id, 
	c.first_name, 
	c.last_name, 
	max(o.total_amount) AS max_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY max(o.total_amount) DESC
LIMIT 1;

--3. List customers with total order amounts greater than 100 TL.

SELECT c.customer_id, 
	c.first_name, 
	c.last_name, 
	sum(o.total_amount) AS total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
where o.total_amount > 100
GROUP BY c.customer_id, c.first_name, c.last_name
;

--4.Find the customer who bought the most expensive product.

SELECT c.customer_id, c.first_name, c.last_name, oi.product_name, oi.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
ORDER BY oi.price DESC
LIMIT 1;

--5. Find the number of orders for each customer.

SELECT c.customer_id , 
	c.first_name , 
	c.last_name, 
	sum(oi.quantity) AS total_quantity
FROM customers c
JOIN orders o ON o.customer_id  = c.customer_id 
JOIN order_items oi ON o.order_id = oi.order_id 
GROUP BY c.customer_id , c.first_name , c.last_name;

--6. Find the customer who placed the most recent order.

SELECT c.customer_id, 
	c.first_name, 
	c.last_name, 
	o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC
LIMIT 1;

--7. Find the most ordered product.

SELECT product_name , sum(quantity) AS total_quantity
FROM order_items
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 1;

--8. Find the total amount of each order.

SELECT order_id, 
SUM(price * quantity) AS total_amount
FROM order_items
GROUP BY order_id;

--9. List city where placed more than one order.

SELECT city
FROM customers c
JOIN orders o ON o.customer_id  = c.customer_id 
JOIN order_items oi ON o.order_id = oi.order_id 
WHERE oi.quantity > 1;

--10. List customers who placed more than one order.

SELECT c.customer_id, 
	c.first_name, 
	c.last_name, 
	COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 1;

By Fatma Nur Azman

https://github.com/Fatma-Nur-Azman









