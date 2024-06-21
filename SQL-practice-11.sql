-- Let's create the table.

CREATE TABLE movies (
    film_id int,
    film_name varchar(30),
    category varchar(30)
);

INSERT INTO movies VALUES (1, 'Eyvah Eyvah', 'Comedy');
INSERT INTO movies VALUES (2, 'Kurtlar Vadisi', 'Action');
INSERT INTO movies VALUES (3, 'Eltilerin Savasi', 'Comedy');
INSERT INTO movies VALUES (4, 'Aile Arasinda', 'Comedy');
INSERT INTO movies VALUES (5, 'GORA', 'Science Fiction');
INSERT INTO movies VALUES (6, 'Organize Isler', 'Comedy');
INSERT INTO movies VALUES (7, 'Babam ve Oglum', 'Drama');

CREATE TABLE actors (
    id int,
    actor_name varchar(30),
    film_id int
);

INSERT INTO actors VALUES (1, 'Ata Demirer', 1);
INSERT INTO actors VALUES (2, 'Necati Sasmaz', 2);
INSERT INTO actors VALUES (3, 'Gupse Ozay', 3);
INSERT INTO actors VALUES (4, 'Engin Gunaydin', 4);
INSERT INTO actors VALUES (5, 'Cem Yilmaz', 5);

-- Question-1: List all movie names, categories, and the names of the actors in the movies

SELECT f.film_name,
    f.category,
    a.actor_name 
FROM movies f 
LEFT JOIN actors a ON f.film_id = a.film_id;

-- Question-2: List all actor names and the names of the movies they acted in

SELECT a.actor_name,
    f.film_name
FROM movies f 
RIGHT JOIN actors a ON f.film_id = a.film_id;

-- Let's create the table

CREATE TABLE Customers(
    customer_id int primary key,
    name varchar(50),
    email varchar(50)
);

INSERT INTO Customers(customer_id, name ,email)
VALUES(1, 'Ali', 'ali@gmail.com'),
      (2, 'Ayşe', 'ayse@gmail.com'),
      (3, 'Fatih', 'fatih@gmail.com');

CREATE TABLE Orders(
    order_id int primary key,
    customer_id int,
    product varchar(50),
    price decimal(8,2),
    foreign key (customer_id) references Customers(customer_id)
);

INSERT INTO Orders(order_id, customer_id, product, price)
VALUES(101, 1, 'Laptop', 2500.00),
      (102, 1, 'Printer', 500.00),
      (103, 2, 'Tablet', 1200.00),
      (104, 3, 'Phone', 1500.00),
      (105, 3, 'Camera', 2000.00);

-- Question-1: Use inner join to combine customer names with their products and prices

SELECT c.name,
    o.product,
    o.price
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id;

DELETE FROM orders;

INSERT INTO Orders(order_id, customer_id, product, price)
VALUES(101, 1, 'Laptop', 2500.00),
      (102, 1, 'Printer', 500.00),
      (103, 2, 'Tablet', 1200.00),
      (104, null, 'Phone', 1500.00),
      (105, null, 'Camera', 2000.00);

-- Question-2: Get all customer names, products, and prices

SELECT c.name,
    o.product,
    o.price
FROM customers c 
FULL JOIN orders o ON c.customer_id = o.customer_id;

-- Let's create the table

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    manager_id INT
);

INSERT INTO Employees (employee_id, name, department, manager_id)
VALUES (1, 'Ali', 'IT', 2),
       (2, 'Ayşe', 'IT', NULL),
       (3, 'Fatih', 'Marketing', 4),
       (4, 'Mehmet', 'Marketing', NULL),
       (5, 'Elif', 'DEV', 1);

-- Question-3: Use inner join to show employee names and manager names

SELECT e.name AS employee_name,
    m.name AS manager_name 
FROM Employees e 
INNER JOIN Employees m 
ON m.employee_id = e.manager_id;

-- Let's create the table

DROP TABLE students;

CREATE TABLE students(
    id int,
    name varchar(50),
    city varchar(50),
    score int,
    department varchar(20)
);

INSERT INTO students VALUES (100, 'Ahmet Ümit', 'Istanbul', 546, 'Computer Science');
INSERT INTO students VALUES (101, 'R.Nuri Güntekin', 'Antalya', 486, 'Business');
INSERT INTO students VALUES (102, 'S.Faik Abasıyanık', 'Bursa', 554, 'Computer Science');
INSERT INTO students VALUES (103, 'Yaşar Kemal', 'Istanbul', 501, 'Mathematics');
INSERT INTO students VALUES (104, 'Halide E. Adıvar', 'Izmir', 473, 'Psychology');
INSERT INTO students VALUES (105, 'Nazan Bekiroğlu', 'Izmir', 432, 'Literature');
INSERT INTO students VALUES (106, 'Peyami Safa', 'Antalya', 535, 'Computer Science');
INSERT INTO students VALUES (107, 'Sabahattin Ali', 'Istanbul', 492, 'Mathematics');

-- Question-1: Get information of students whose names start with the letter 'A'

SELECT * 
FROM students
WHERE name LIKE 'A%'; -- case sensitive

SELECT *
FROM students s
WHERE name ILIKE 'A%'; -- case insensitive

-- Question-2: Get information of students whose names end with the letter 'i'

SELECT * 
FROM students
WHERE name LIKE '%i';

-- Question-3: Get information of students whose names start with the letter 'A' and study in the 'Computer Science' department

SELECT * 
FROM students
WHERE name ILIKE 'A%' 
AND department = 'Computer Science';

-- Question-4: Get information of students whose names contain the letter 'n'

SELECT * 
FROM students
WHERE name ILIKE '%n%';

-- Question-5: Get information of students whose names do not start with the letter 'A'

SELECT * 
FROM students
WHERE name NOT ILIKE 'A%';

-- Question-6: Get information of students whose names are longer than 12 characters

SELECT *
FROM students s
WHERE length(name) > 12;

-- Question-7: Get information of students whose fourth character in their name is 'a'

SELECT * 
FROM students
WHERE name ILIKE '___a%';

-- Question-8: Get information of students whose names contain the letters 'z' or 'k'
-- Method 1

SELECT * 
FROM students
WHERE name ILIKE '%z%' OR name ILIKE '%k%';

-- Method 2

SELECT * 
FROM students
WHERE name ~* '[kz]';

-- Question-9: Get information of students whose names start with 'Y' or 'N'
-- Method 1

SELECT * 
FROM students
WHERE name ILIKE 'y%' OR name ILIKE 'n%';

-- Method 2

SELECT * 
FROM students
WHERE name ~* '^[YN]';

-- Let's create the table

CREATE TABLE companies(
    company_id INT PRIMARY KEY,
    company_name VARCHAR(50),
    employee_count INT
);

INSERT INTO companies(company_id, company_name, employee_count)
VALUES(100, 'Nokia', 1000),
      (101, 'Iphone', 900),
      (102, 'Samsung', 1200),
      (103, 'Xiaomi', 1500);

-- Question-1: Set the employee count of Samsung to the highest employee count value

UPDATE companies
SET employee_count = (SELECT max(employee_count) FROM companies)
WHERE company_name = 'Samsung';

-- Question-2: Set the employee count of Nokia to 1.5 times the lowest employee count value

UPDATE companies
SET employee_count = (SELECT min(employee_count) FROM companies) * 1.5
WHERE company_name = 'Nokia';

-- Question-3: Set the employee count of Iphone to the sum of the employee counts of Nokia and Xiaomi

UPDATE companies
SET employee_count = (SELECT sum(employee_count) FROM companies
WHERE company_name IN ('Nokia', 'Xiaomi'))
WHERE company_name = 'Iphone';

-- Question-4: Increase the employee counts of companies with employee counts lower than the average employee count by 400

UPDATE companies
SET employee_count = employee_count + 400
WHERE employee_count < (SELECT avg(employee_count) FROM companies);

-- Let's create the table

CREATE TABLE employees (
    employee_id Int PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    company_name VARCHAR(100),
    work_performance VARCHAR(255)
);

INSERT INTO employees (employee_id, name, city, company_name, work_performance)
VALUES
    (100, 'Ali Yılmaz', 'Ankara', 'Samsung', 'Average 67'),
    (101, 'Ayşe Demir', 'Istanbul', 'Iphone', 'Average 72'),
    (102, 'Mehmet Kaya', 'Izmir', 'Xiaomi', 'Average 55'),
    (103, 'Ali Can', 'Bursa', 'Nokia', 'Average 98'),
    (104, 'Ahmet Kadir', 'Ankara', 'Nokia', 'Average 92.5'),
    (105, 'Fatma Güzel', 'Giresun', 'Samsung', 'Average 92.5'),
    (106, 'Furkan Yılmaz', 'Izmir', 'Xiaomi', 'Average 99');

SELECT * FROM employees;
SELECT * FROM companies;

-- Question-5: List the names and work performances of employees working in companies with more than 2200 employees

SELECT name, work_performance FROM employees
WHERE company_name IN
(SELECT company_name FROM companies WHERE employee_count > 2200);

-- Question-6: List the company IDs and employee counts of companies that have employees in Ankara

SELECT company_id, employee_count
FROM companies
WHERE company_name IN
(SELECT company_name FROM employees
WHERE city = 'Ankara');

-- Question-7: If there is at least one employee in Giresun, list all companies

SELECT * FROM companies WHERE EXISTS 
(SELECT company_name FROM employees WHERE city = 'Giresun');



By Fatma Nur Azman

https://github.com/Fatma-Nur-Azman







