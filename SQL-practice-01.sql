
-- Please create the table first 

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);


-- Please enter values in the table 
INSERT INTO products (product_id, product_name, category, price, stock_quantity) VALUES
(1, 'Laptop', 'Electronics', 800.00, 50),
(2, 'Smartphone', 'Electronics', 600.00, 150),
(3, 'Tablet', 'Electronics', 300.00, 200),
(4, 'Headphones', 'Accessories', 50.00, 300),
(5, 'Charger', 'Accessories', 20.00, 500),
(6, 'Office Chair', 'Furniture', 150.00, 100),
(7, 'Desk', 'Furniture', 200.00, 75),
(8, 'Monitor', 'Electronics', 200.00, 80),
(9, 'Keyboard', 'Accessories', 30.00, 250),
(10, 'Mouse', 'Accessories', 25.00, 400);

--Let's question our table
SELECT *
FROM products 

-- Please create the table first 

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity_sold INT,
    total_sale DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Please enter values in the table 
INSERT INTO sales (sale_id, product_id, sale_date, quantity_sold, total_sale) VALUES
(1, 1, '2024-01-15', 5, 4000.00),
(2, 2, '2024-01-16', 10, 6000.00),
(3, 3, '2024-01-17', 7, 2100.00),
(4, 4, '2024-01-18', 20, 1000.00),
(5, 5, '2024-01-19', 15, 300.00),
(6, 6, '2024-01-20', 8, 1200.00),
(7, 7, '2024-01-21', 3, 600.00),
(8, 8, '2024-01-22', 4, 800.00),
(9, 9, '2024-01-23', 12, 360.00),
(10, 10, '2024-01-24', 18, 450.00);

--Let's question our table
SELECT *
FROM sales 



/*1. Write a query to fetch all the product details.*/

SELECT *
FROM products;

/*2. Write a query to fetch products with stock quantity greater than 100.*/

SELECT * 
FROM products
WHERE stock_quantity > 100;

/*3. Write a query to fetch the names and prices of products in the 'Electronics' category.*/

SELECT product_name, price 
FROM products
WHERE category = 'Electronics';

/*4. Write a query to fetch products with a price greater than 100.*/

SELECT * 
FROM products
WHERE price > 100;

/*5. Write a query to calculate the total stock quantity in each category.*/

SELECT 
	category, 
	SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category;

/*6. Write a query to fetch products in the 'Accessories' category.*/

SELECT * 
FROM products
WHERE category = 'Accessories';

/*7. Write a query to fetch products with a price between 50 and 200.*/

SELECT * 
FROM products
WHERE price BETWEEN 50 AND 200;

/*8. Write a query to fetch the most expensive product in each category.*/

SELECT 
	category, 
	MAX(price) AS max_price
FROM products
GROUP BY category;

/*9. Write a query to fetch sales after '2024-01-20'.*/

SELECT * 
FROM sales
WHERE sale_date > '2024-01-20';

/*10. Write a query to fetch the best-selling product.*/

SELECT product_id, SUM(quantity_sold) AS total_quantity_sold
FROM sales
GROUP BY product_id
ORDER BY total_quantity_sold DESC
LIMIT 1;

/*11. Write a query to calculate the number of units sold for each product.*/

SELECT 
	product_id, 
	SUM(quantity_sold) AS total_units_sold
FROM sales
GROUP BY product_id;

/*12. Write a query to calculate the total value of sales.*/

SELECT SUM(total_sale) AS total_sales
FROM sales;

/*13. Write a query to fetch sales between '2024-01-15' and '2024-01-20'.*/

SELECT * 
FROM sales
WHERE sale_date BETWEEN '2024-01-15' AND '2024-01-20';

/*14. Write a query to fetch the least sold product.*/

SELECT 
	product_id, 
	SUM(quantity_sold) AS total_quantity_sold
FROM sales
GROUP BY product_id
ORDER BY total_quantity_sold
LIMIT 1;

/*15. Write a query to calculate the total sales quantity and average sales value for each product.*/

SELECT 
	product_id, 
	SUM(quantity_sold) AS total_quantity_sold,
	AVG(total_sale) AS average_sale_value
FROM sales
GROUP BY product_id;

/*16. Write a query to list products in descending order of sales quantity.*/

SELECT * 
FROM sales 
ORDER BY quantity_sold DESC;

/*17. Write a query to calculate the total sales value of products in the 'Electronics' category.*/

SELECT SUM(s.total_sale) AS total_sales_value 
FROM sales s
JOIN products p ON s.product_id = p.product_id 
WHERE p.category = 'Electronics';

/*18. Write a query to calculate the number of different products in each category.*/

SELECT 
	category, 
	COUNT(product_name) AS total_products
FROM products
GROUP BY category;

/*19. Write a query to calculate the average price of products in the 'Accessories' category.*/

SELECT AVG(price) AS average_price
FROM products 
WHERE category = 'Accessories';

/*20. Write a query to calculate the total sales quantity and total sales value for each product.*/

SELECT 
	p.product_name, 
	SUM(s.quantity_sold) AS total_quantity_sold, 
	SUM(s.total_sale) AS total_sales_value 
FROM sales s
JOIN products p ON s.product_id = p.product_id 
GROUP BY p.product_name;








