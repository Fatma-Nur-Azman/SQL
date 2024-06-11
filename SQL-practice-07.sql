CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(50),
    HoursWorked INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

CREATE TABLE Salaries (
    EmployeeID INT,
    SalaryDate DATE,
    Amount DECIMAL(10, 2),
    PRIMARY KEY (EmployeeID, SalaryDate),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Sales'),
(4, 'Marketing');

-- Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID, Salary) VALUES
(101, 'John', 'Doe', '1985-03-15', '2010-07-01', 1, 75000.00),
(102, 'Jane', 'Smith', '1990-06-24', '2012-08-15', 2, 60000.00),
(103, 'Sam', 'Brown', '1988-11-30', '2015-01-10', 1, 80000.00),
(104, 'Lisa', 'Jones', '1992-04-21', '2018-03-05', 3, 72000.00),
(105, 'Tom', 'Harris', '1983-09-10', '2009-11-30', 4, 68000.00);

-- Projects
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES
(201, 'Project Alpha', '2023-01-01', '2023-06-30'),
(202, 'Project Beta', '2023-02-15', '2023-07-31'),
(203, 'Project Gamma', '2023-05-01', '2023-12-31');

-- EmployeeProjects
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role, HoursWorked) VALUES
(101, 201, 'Manager', 150),
(102, 202, 'Developer', 120),
(103, 203, 'Analyst', 130),
(104, 201, 'Tester', 80),
(105, 202, 'Designer', 110);

-- Salaries
INSERT INTO Salaries (EmployeeID, SalaryDate, Amount) VALUES
(101, '2024-01-01', 78000.00),
(102, '2024-01-01', 63000.00),
(103, '2024-01-01', 82000.00),
(104, '2024-01-01', 75000.00),
(105, '2024-01-01', 70000.00);

---SQL Questions

--1. List the first and last names of all employees.

SELECT 
	firstname, 
	lastname
FROM Employees;

--2. List the names of distinct departments.

SELECT DISTINCT departmentname 
FROM Departments;

--3. List the names of employees with a salary greater than 70,000.

SELECT concat (firstname, ' ',lastname)
FROM Employees
WHERE salary > 70000;

--4. List employees born after 1990 and with a salary greater than 65,000.

SELECT *
FROM Employees
WHERE 
	birthdate > '1990-01-01' 
	AND
	salary > 65000;

--5. List employees ordered by salary in descending order.

SELECT * 
FROM Employees
ORDER BY salary DESC;

--6. List employees ordered by birthdate in ascending order.

SELECT * 
FROM Employees
ORDER BY birthdate ASC;

--7. List employees with a salary between 60,000 and 80,000.

SELECT *
FROM Employees
WHERE salary BETWEEN 60000 AND 80000;

--8. List employees with Department ID 1, 2, or 3.

SELECT *
FROM Employees
WHERE departmentid IN(1,2,3);

--9. List employees whose last name starts with 'S'.

SELECT *
FROM Employees
WHERE lastname LIKE 'S%';

--10. List the number of employees in each department.

SELECT 
	departmentid ,
	count(*) AS total_employees
FROM Employees
GROUP BY departmentid;

--11. Calculate the total hours worked by each employee on projects.

SELECT employeeid, sum(hoursworked) AS total_hoursworked
FROM EmployeeProjects
GROUP BY employeeid ;

--12. List projects with total hours worked greater than 100.

SELECT projectid, 
	sum(hoursworked) AS total_hoursworked
FROM EmployeeProjects
GROUP BY projectid 
HAVING sum(hoursworked) > 100;

--13. List the names of employees working in the 'Engineering' department.

-- Method 1
SELECT 
	e.firstname, 
	e.lastname
FROM Employees e
JOIN departments d 
ON e.departmentid = d.departmentid
WHERE d.departmentname = 'Engineering';

-- Method 2
SELECT  
	firstname, 
	lastname
FROM Employees
WHERE departmentid = (SELECT departmentid FROM Departments WHERE departmentname = 'Engineering');

--14. List each employee's name, surname, salary, and department name.

SELECT 
	concat (e.lastname,' ',e.lastname) AS name_surname,
	e.salary,
	d.departmentname 
FROM Employees e
JOIN departments d 
ON e.departmentid = d.departmentid;

--15. List the names, surnames, and roles of employees in each project.

SELECT 
	e.firstname , 
	e.lastname ,
	ep."role" ,
	ep.projectid 
FROM employees e
INNER JOIN EmployeeProjects ep 
ON e.employeeid = ep.employeeid ;

--15 A. List the names, surnames, roles, and project names of employees in each project.

SELECT 
	e.firstname , 
	e.lastname ,
	ep."role" ,
	p.projectname  
FROM employees e
INNER JOIN EmployeeProjects ep 
ON e.employeeid = ep.employeeid
INNER JOIN Projects p 
ON ep.projectid  = p.projectid ;

--16. Find the employee with the highest salary.

-- Method 1
SELECT *
FROM Employees
ORDER BY salary DESC
LIMIT 1;

-- Method 2 
SELECT * 
FROM employees e 
WHERE salary = ( SELECT max(salary) FROM employees);

--17. Calculate the average hours worked on each project.

SELECT  
	projectid ,
	avg(hoursworked) AS avg_hoursworked
FROM EmployeeProjects
GROUP BY projectid ;

--18. List the latest salary of each employee.

-- Method 1 
SELECT 
	e.firstname ,
	e.lastname , 
	e.salary 
FROM Salaries s 
INNER JOIN employees e ON s.employeeid = e.employeeid 
WHERE salarydate = (SELECT salarydate FROM salaries s ORDER BY salarydate LIMIT 1 );

-- Method 2 
SELECT FirstName, LastName, Amount AS LatestSalary FROM Employees 
JOIN Salaries ON Employees.EmployeeID = Salaries.EmployeeID 
WHERE SalaryDate = (SELECT MAX(SalaryDate) FROM Salaries WHERE Salaries.EmployeeID = Employees.EmployeeID);

--19. List the names of employees not working on any projects.

SELECT
	firstname,
	lastname 
FROM Employees e
WHERE employeeid NOT IN (SELECT employeeid FROM EmployeeProjects ep);

--20. List the average salary for each department by department name.

SELECT d.departmentname , avg(salary) AS avg_salary 
FROM Employees e
JOIN Departments d ON e.departmentid = d.departmentid 
GROUP BY d.departmentid;
