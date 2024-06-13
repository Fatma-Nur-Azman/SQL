### 1. Creating the Database and Tables

-- Create Database
CREATE DATABASE CompanyDB;

-- Use the Database
USE CompanyDB;

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    Location VARCHAR(50),
    Budget DECIMAL(12, 2),
    Head VARCHAR(50)
);

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT REFERENCES Departments(DepartmentID),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

-- Create Projects Table
CREATE TABLE Projects (
    ProjectID SERIAL PRIMARY KEY,
    ProjectName VARCHAR(100),
    DepartmentID INT REFERENCES Departments(DepartmentID),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12, 2)
);

-- Create Assignments Table
CREATE TABLE Assignments (
    AssignmentID SERIAL PRIMARY KEY,
    ProjectID INT REFERENCES Projects(ProjectID),
    EmployeeID INT REFERENCES Employees(EmployeeID),
    Role VARCHAR(50),
    AssignedDate DATE
);

-- Create Performance Reviews Table
CREATE TABLE PerformanceReviews (
    ReviewID SERIAL PRIMARY KEY,
    EmployeeID INT REFERENCES Employees(EmployeeID),
    ReviewDate DATE,
    Score INT,
    Comments TEXT
);

-- Insert Data into Departments Table
INSERT INTO Departments (DepartmentName, Location, Budget, Head) VALUES
('Human Resources', 'New York', 500000.00, 'Alice Johnson'),
('Finance', 'Boston', 800000.00, 'Bob Smith'),
('Engineering', 'San Francisco', 1200000.00, 'Carol White'),
('Marketing', 'Chicago', 600000.00, 'David Brown'),
('Sales', 'Los Angeles', 700000.00, 'Eve Davis');

-- Insert Data into Employees Table
INSERT INTO Employees (FirstName, LastName, DepartmentID, HireDate, Salary) VALUES
('John', 'Doe', 1, '2020-01-15', 50000.00),
('Jane', 'Smith', 2, '2019-03-23', 60000.00),
('James', 'Johnson', 3, '2018-07-11', 70000.00),
('Emily', 'Davis', 4, '2017-06-25', 55000.00),
('Michael', 'Wilson', 5, '2016-05-14', 75000.00);

-- Insert Random Data into Employees Table (Total 200 Employees)
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..195 LOOP
        INSERT INTO Employees (FirstName, LastName, DepartmentID, HireDate, Salary) VALUES
        (
            'Employee' || i,
            'LastName' || i,
            (SELECT DepartmentID FROM Departments ORDER BY RANDOM() LIMIT 1),
            CURRENT_DATE - INTERVAL '1 year' * FLOOR(RANDOM() * 10),
            30000 + FLOOR(RANDOM() * 50000)
        );
    END LOOP;
END $$;

-- Insert Data into Projects Table
INSERT INTO Projects (ProjectName, DepartmentID, StartDate, EndDate, Budget) VALUES
('Project Alpha', 3, '2021-01-01', '2022-01-01', 200000.00),
('Project Beta', 2, '2020-05-01', '2021-05-01', 150000.00),
('Project Gamma', 4, '2019-07-01', '2020-07-01', 300000.00),
('Project Delta', 1, '2022-02-01', '2023-02-01', 250000.00),
('Project Epsilon', 5, '2018-09-01', '2019-09-01', 100000.00);

-- Insert Data into Assignments Table
INSERT INTO Assignments (ProjectID, EmployeeID, Role, AssignedDate) VALUES
(1, 3, 'Developer', '2021-01-10'),
(2, 1, 'Analyst', '2020-05-05'),
(3, 4, 'Manager', '2019-07-15'),
(4, 5, 'HR Specialist', '2022-02-10'),
(5, 2, 'Sales Representative', '2018-09-05');

-- Insert Data into Performance Reviews Table
INSERT INTO PerformanceReviews (EmployeeID, ReviewDate, Score, Comments) VALUES
(1, '2021-06-15', 85, 'Good performance'),
(2, '2020-12-10', 90, 'Excellent work'),
(3, '2019-11-05', 70, 'Needs improvement'),
(4, '2018-08-20', 75, 'Satisfactory'),
(5, '2022-03-01', 80, 'Above average');

-- 2. Questions

--1. **Easy**: Retrieve the list of all employees.

SELECT * 
FROM Employees;

--2. **Easy**: Retrieve the list of all departments.

SELECT * 
FROM Departments;

--3. **Easy**: Retrieve the list of employees working in the Engineering department.

SELECT * 
FROM Employees
WHERE departmentid = (
						SELECT departmentid 
						FROM Departments 
						WHERE departmentname = 'Engineering'
					 );

--4. **Easy**: Retrieve the list of employees working on projects.
					
-- Method 1
SELECT *
FROM Employees e
WHERE employeeid IN(
					SELECT employeeid  
					FROM Assignments
				   );
					
-- Method 2
SELECT *
FROM employees e 
INNER JOIN assignments a 
ON e.employeeid = a.employeeid ;
					
--5. **Easy**: Retrieve employees hired in 2020 or later.

SELECT * 
FROM Employees
WHERE hiredate > '2020-01-01';

--6. **Medium**: Retrieve the number of employees in each department.

SELECT d.departmentname, 
	count(*) AS total_employees
FROM Employees e
JOIN departments d 
ON e.departmentid = d.departmentid 
GROUP BY departmentname ;

--7. **Medium**: Retrieve the employee with the highest salary.

SELECT * 
FROM Employees
WHERE salary = (
				SELECT max(salary)
				FROM Employees
				);

--8. **Medium**: Retrieve the total salary amount in each department.
			
SELECT d.departmentname , 
	sum(e.salary) AS total_salary
FROM Employees e
JOIN departments d 
ON e.departmentid = d.departmentid 
GROUP BY d.departmentname ;	
			
--9. **Medium**: Retrieve the list of employees working on projects and their roles.

SELECT e.* , a."role" 
FROM Employees e
JOIN assignments a ON e.employeeid = a.employeeid ;

--10. **Medium**: Retrieve the total budget for each project.

SELECT 
	projectname , 
	budget 
FROM Projects
GROUP BY projectname ,budget ;

--11. **Hard**: Retrieve the 10 employees with the lowest salaries.

SELECT * 
FROM Employees
ORDER BY salary 
LIMIT 10;

--12. **Hard**: Retrieve the average salary in each department.

SELECT d.departmentname , 
	round(avg(e.salary),2) AS avg_salary
FROM Employees e
JOIN departments d 
ON e.departmentid = d.departmentid 
GROUP BY d.departmentname ;

--13. **Hard**: Retrieve the employees working on the same project.
-- Method 1
SELECT e.firstname , e.lastname , p.projectname
FROM employees e 
JOIN Projects p ON e.departmentid = p.departmentid
WHERE e.employeeid IN (SELECT employeeid FROM assignments)
GROUP BY e.firstname , e.lastname  , p.projectname;

-- Method 2

SELECT 
        p.projectid , 
        p.projectname,
        e.firstname ,
        e.lastname ,
        count(e.*) 
FROM projects p 
JOIN assignments a ON p.projectid = a.projectid 
JOIN employees e ON e.employeeid =a.employeeid 
GROUP BY p.projectid , p.projectname,e.firstname ,e.lastname

--14. **Hard**: Retrieve the average budget for projects.

SELECT 
	projectname , 
	avg(budget) AS avg_budget
FROM Projects
GROUP BY projectname ,budget ;

--15. **Hard**: Retrieve the count of employees whose third and fourth characters of their first names are 'pl'.

SELECT count(*) firstname_3_4_pl
FROM Employees
WHERE firstname LIKE '__pl%';

--16. **Hard**: Retrieve the employees with salaries between 40,000 and 60,000 and their department names, sorted by salary in ascending order.

SELECT e.*, d.departmentname 
FROM Employees e
JOIN departments d ON e.departmentid = d.departmentid 
WHERE salary BETWEEN 40000 AND 60000
ORDER BY salary ;

--17. **Hard**: Retrieve the project with the highest budget.
-- Method 1
SELECT * 
FROM Projects
WHERE budget = (
				SELECT max(budget) 
				FROM projects
			   );

-- Method 2
SELECT * 
FROM Projects
WHERE budget = (
				SELECT budget 
				FROM projects 
				ORDER BY budget DESC 
				LIMIT 1);

--18. **Hard**: Retrieve the highest salary and the department name for each department.

SELECT d.departmentname, 
	max(e.salary) 
FROM Employees e
JOIN departments d ON e.departmentid = d.departmentid 
GROUP BY d.departmentname;			
			
--19. **Hard**: Retrieve the employees with the highest performance review scores.

SELECT e.*, pr.score
FROM employees e 
JOIN PerformanceReviews pr ON e.employeeid = pr.employeeid 
WHERE score IN (SELECT max(score) FROM performancereviews pr );

--20. **Hard**: Retrieve the number of employees hired each year.

SELECT EXTRACT (YEAR FROM hiredate) AS year_, 
	count(*) AS Top_employees
FROM Employees
GROUP BY EXTRACT (YEAR FROM hiredate)
ORDER BY EXTRACT (YEAR FROM hiredate) DESC;
