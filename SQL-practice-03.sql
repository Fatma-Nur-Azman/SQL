-- Create table and insert data
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    city VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    department VARCHAR(50)
);

INSERT INTO employees (name, age, city, email, phone_number, department) VALUES
('John Doe', 25, 'New York', 'john.doe@example.com', '555-1234', 'IT'),
('Jane Smith', 30, 'London', 'jane.smith@example.com', '555-5678', 'Finance'),
('Michael Brown', 28, 'Paris', 'michael.brown@mail.com', '555-9876', 'HR'),
('Emily Johnson', 22, 'Berlin', 'emily.johnson@example.com', '555-2222', 'Marketing'),
('David Lee', 35, 'Tokyo', 'david.lee@mail.com', '555-4444', 'IT'),
('Maria Garcia', 27, 'Moscow', 'garcia@mail.com', '555-7777', 'Sales'),
('Christopher Martinez', 29, 'Sydney', 'christopher.martinez@example.com', '555-6666', 'Finance'),
('Sarah White', 26, 'Toronto', 'white@example.com', '555-8888', 'HR'),
('James Taylor', 31, 'Los Angeles', 'james.taylor@example.com', '555-3333', 'IT'),
('Jennifer Adams', 33, 'Rome', 'jennifer.adams@example.com', '555-1111', 'Marketing'),
('Daniel Hernandez', 28, 'Seoul', 'daniel.hernandez@example.com', '555-9999', 'Sales'),
('Amanda Thomas', 24, 'Rio de Janeiro', 'amanda.thomas@example.com', '555-5555', 'Finance'),
('Robert White', 32, 'Mumbai', 'white@example.com', '555-4444', 'IT'),
('Megan Scott', 29, 'Cairo', 'megan.scott@example.com', '555-7777', 'Sales'),
('Kevin Garcia', 27, 'Mexico City', 'garcia@mail.com', '555-2222', 'Marketing');

SELECT *
FROM employees;

--1- List distinct emails in employees table
SELECT DISTINCT email
FROM employees;

--2- View the first 5 records in the employees table
SELECT *
FROM employees 
LIMIT 5;

--3- View 5 records starting from the 6th record in the employees table
SELECT *
FROM employees 
OFFSET 5
LIMIT 5;

--4- View the last 3 records (by id) in the employees table
SELECT *
FROM employees 
ORDER BY id DESC 
LIMIT 3;

--5- View employees with department 'IT'
SELECT *
FROM employees 
WHERE department = 'IT';

--6- View employees older than 30 years
SELECT *
FROM employees 
WHERE age > 30;

--7- View employees younger than 30 or living in 'Rome'
SELECT *
FROM employees 
WHERE age < 30 
OR city = 'Rome';

--8- View employees in 'Sales' department and younger than 30 years
SELECT *
FROM employees 
WHERE age < 30 
AND department = 'Sales';

--9- View employees in 'Sales', 'HR' or 'IT' departments
SELECT *
FROM employees 
WHERE department IN ('Sales', 'HR', 'IT');

--10- View employees not in 'Sales', 'HR' or 'IT' departments
SELECT *
FROM employees 
WHERE department 
NOT IN ('Sales', 'HR', 'IT');

-- Alternative method
SELECT *
FROM employees 
WHERE department != 'Sales' 
AND department != 'HR' 
AND department != 'IT';

--11- View names, ages, and departments of employees in 'Sales', 'HR', or 'IT', ordered by age
SELECT name, age, department
FROM employees 
WHERE department IN ('Sales', 'HR', 'IT')
ORDER BY age;

--12- View names and ages of employees aged between 25 and 30
SELECT name, age
FROM employees 
WHERE age BETWEEN 25 AND 30;

-- Alternative method
SELECT name, age
FROM employees 
WHERE age >= 25 AND age <= 30;

--12-b View names and ages of employees younger than 25 or older than 30
SELECT name, age
FROM employees 
WHERE age < 25 OR age > 30;

-- Alternative method
SELECT name, age
FROM employees 
WHERE age 
NOT BETWEEN 25 AND 30;

--13- View names and emails of employees whose email ends with 'mail.com', ordered by name
SELECT name, email
FROM employees 
WHERE email LIKE '%mail.com'
ORDER BY name;

-- Alternative method (case-insensitive)
SELECT name, email
FROM employees 
WHERE email ILIKE '%mail.com'
ORDER BY name;

--14- View names of employees whose name contains 'an'
SELECT name
FROM employees 
WHERE name LIKE '%an%';

--14-a View names of employees whose name's 2nd letter is 'a' and 3rd letter is 'n'
SELECT name
FROM employees 
WHERE name LIKE '_an%';

--15- Delete all employees older than 30 years
DELETE
FROM employees 
WHERE age > 30;

--16- Delete all employees living in 'Moscow'
DELETE
FROM employees 
WHERE city = 'Moscow';

--17- Delete all employees whose email starts with 'john'
DELETE FROM employees
WHERE email LIKE 'john%';

--18- Delete all employees whose department's 2nd letter is 'R'
DELETE 
FROM employees
WHERE department LIKE '_R%';

--19- Delete all employees
DELETE FROM employees;

--20- Truncate employees table
TRUNCATE TABLE employees;

--21- Create new table and insert data
CREATE TABLE personal (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    city VARCHAR(50),
    email VARCHAR(100),
    salary NUMERIC(10, 2),
    department VARCHAR(50)
);

INSERT INTO personal (name, age, city, email, salary, department) VALUES
('John Doe', 25, 'New York', 'john.doe@example.com', 60000, 'IT'),
('Jane Smith', 30, 'London', 'jane.smith@example.com', 75000, 'Finance'),
('Michael Brown', 28, 'Paris', 'michael.brown@example.com', 50000, 'HR'),
('Emily Johnson', 22, 'Berlin', 'emily.johnson@example.com', 45000, 'Marketing'),
('David Lee', 35, 'Tokyo', 'david.lee@example.com', 85000, 'IT'),
('Maria Garcia', 27, 'Moscow', 'maria.garcia@example.com', 55000, 'Sales'),
('Christopher Martinez', 29, 'Sydney', 'christopher.martinez@example.com', 65000, 'Finance'),
('Sarah Wilson', 26, 'Tokyo', 'sarah.wilson@example.com', 48000, 'HR'),
('James Taylor', 31, 'London', 'james.taylor@example.com', 70000, 'IT'),
('Jennifer Adams', 33, 'New York', 'jennifer.adams@example.com', 72000, 'Marketing'),
('Maria Darlin', 26, 'Moscow', 'maria.darlin@example.com', 55000, 'Sales'),
('Rod Johnson', 28, 'Berlin', 'rod.johnson@example.com', 45000, 'Marketing');

--22- Find total salary of all employees
SELECT sum(salary) AS total_salary
FROM personal;

--23- Find average salary of all employees
SELECT round(avg(salary), 2) AS avg_salary
FROM personal;

--24- Find the highest salary in the IT department
SELECT max(salary) AS IT_max_salary
FROM personal
WHERE department = 'IT';

--25- Find the number of employees in New York, Berlin, or Tokyo
SELECT count(id)
FROM personal
WHERE city IN('New York', 'Berlin','Tokyo');

--26- Display all employee names in uppercase
SELECT upper(name)
FROM personal;

-- Display all employee names in lowercase
SELECT lower(name)
FROM personal;

--27- Display name and city fields concatenated with 'from' in between
SELECT CONCAT(name, ' from ', city) AS name_city
FROM personal;

--28- Replace '@example.com' in email addresses with '@company.com'
SELECT replace(email, '@example.com', '@company.com')
FROM personal;

--29- Display average salary per department
SELECT department, round(avg(salary), 2) AS avg_salary
FROM personal
GROUP BY department;

--30- Display departments with an average salary over 60,000
SELECT department, round(avg(salary), 2) AS avg_salary
FROM personal
GROUP BY department
HAVING avg(salary) > 60000;

--31- Display departments with employees younger than 30 and an average salary over 60,000
SELECT department, round(avg(salary), 2) AS avg_salary
FROM personal
WHERE age < 30
GROUP BY department
HAVING avg(salary) > 60000;

--32- Update salary of employee 'John Doe' to 65000
UPDATE personal
SET salary = 65000
WHERE name = 'John Doe';

