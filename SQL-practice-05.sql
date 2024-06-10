--Table 1: employees

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    department_id INT,
    company_id INT,
    city VARCHAR(50)
);

INSERT INTO employees (employee_id, first_name, last_name, salary, department_id, company_id, city) VALUES
(1, 'John', 'Doe', 4500, 1, 1, 'Istanbul'),
(2, 'Jane', 'Smith', 5500, 2, 1, 'Ankara'),
(3, 'Michael', 'Johnson', 3000, 1, 2, 'Izmir'),
(4, 'Emily', 'Davis', 6000, 3, 3, 'Antalya'),
(5, 'Daniel', 'Brown', 4000, 2, 2, 'Bursa'),
(567890123, 'Ali', 'Yilmaz', 3500, 3, 3, 'Istanbul');

-- Table 2: departments

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

-- Table 3: companies

CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(50)
);

INSERT INTO companies (company_id, company_name) VALUES
(1, 'TechCorp'),
(2, 'BizEnterprises'),
(3, 'FinServices');


-- 1. How many employees work in each department?

SELECT d.department_name, 
	count(*) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name ;

-- 2.What is the difference between the highest and lowest salary in the company?

SELECT max(salary) - min(salary) AS salary_difference
FROM employees ;

-- 3.What is the average salary we will pay to each department?

SELECT d.department_name, 
	avg(e.salary) AS average_salary
FROM departments d
JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_id;

-- 4.Find the companies of employees with a salary greater than 4000 TL, 
-- then display the minimum salary above this limit for each company.
SELECT c.company_name, 
	min(e.salary) AS minimum_salary_above_4000
FROM companies c
JOIN employees e ON c.company_id = e.company_id 
WHERE e.salary > 4000
GROUP BY c.company_name;

-- 5.Update the name of the employee with ID 567890123 to 6 ,
-- the to name 'Bruce' , the to last name 'Clark'and the city to 'Bursa'.

UPDATE employees
SET employee_id = 6, 
	first_name = 'Bruce', 
	last_name =  'Clark', 
	city = 'Bursa'
WHERE employee_id = 567890123;

-- 6.Update the company name of the employee with ID 6 to 'TechCorp'.

UPDATE employees
SET company_id = (SELECT company_id FROM companies WHERE company_name = 'TechCorp')
WHERE employee_id = 6;

-- 7.If the number of employees in a city is more than 2, write a query that displays the city name and the number of employees.

SELECT city, 
	count(first_name)
FROM employees
GROUP BY city 
HAVING count(city) > 1; 

-- 8.Get the highest salary in a department and sort by department name.

SELECT d.department_name, 
	max(e.salary) AS highest_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY d.department_name ;

-- 9.Calculate the total salary of all employees.

SELECT 
	sum(salary) AS total_salary
FROM employees;

-- 10.Find the total number of employees and the average salary in each city.

SELECT city, 
	avg(salary) AS city_avg_salary, 
	count(employee_id) AS total_employees
FROM employees
GROUP BY city;

-- 11.List the total number of employees working in each company.

SELECT c.company_name ,
	count(e.employee_id) AS total_employees
FROM employees e
JOIN companies c ON e.company_id = c.company_id 
GROUP BY c.company_name;

-- 12.List the lowest salary of employees in each department.

SELECT d.department_name  ,
	min(e.salary) AS min_salary
FROM employees e
JOIN departments d ON e.department_id  = d.department_id 
GROUP BY d.department_name ;

-- 13.List the name and salary of the highest-paid employee in each company.

SELECT c.company_name, 
	e.first_name, 
	e.last_name, 
	e.salary
FROM employees e
JOIN companies c ON e.company_id = c.company_id
WHERE e.salary = (SELECT MAX(salary) FROM employees WHERE company_id = c.company_id);

Şirketteki toplam maaş ödemesini ve ortalama maaşı hesaplayın.

-- 14.Calculate the total salary payment and the average salary in the all company.

SELECT SUM(salary) AS total_salary, AVG(salary) AS average_salary
FROM employees;

-- 15.Find the name and salary of the highest-paid employee.
--1.way

SELECT first_name , 
	last_name , 
	salary 
FROM employees
WHERE salary = (SELECT max(salary) FROM employees e );

--2. way 
SELECT concat (first_name, ' ', last_name) AS employee_name, 
	max(salary) AS max_salary
FROM employees
GROUP BY employee_id 
ORDER BY max(salary) DESC 
LIMIT 1;

-- 16.Calculate the total salary payment for each department.

SELECT d.department_name, 
	sum(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id 
GROUP BY d.department_name ;

-- 17.List the average salary for each company.

SELECT c.company_name, 
	avg(e.salary) AS avg_salary
FROM employees e
JOIN companies c ON e.company_id = c.company_id 
GROUP BY c.company_name ;

-- 18.List the name and salary of the highest-paid employee in each city.

SELECT city, 
	first_name, 
	last_name, 
	salary
FROM employees
WHERE (city, salary) IN (
    SELECT city, MAX(salary)
    FROM employees
    GROUP BY city
);

-- 19.List how many different departments exist in each city.

SELECT city,
	count(DISTINCT department_id) AS different_department
FROM employees e  
GROUP BY city;

Her bir şehirdeki toplam çalışan sayısını ve toplam maaş ödemesini bulun.

-- 20.Find the total number of employees and the total salary payment in each city.

SELECT city,
	sum(salary) AS total_salary,
	count(employee_id) AS total_employees
FROM employees e  
GROUP BY city;

By Fatma Nur Azman

https://github.com/Fatma-Nur-Azman