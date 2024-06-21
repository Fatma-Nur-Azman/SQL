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

-- Easy Questions
-- Question 1: List the names of employees in the "Finance" department.

SELECT * 
FROM Employees
WHERE departmentid  IN (
						SELECT departmentid 
						FROM Departments 
						WHERE departmentname='Finance'
						);

-- Question 2: List the names of departments with a budget greater than 1,000,000.

SELECT departmentname  
FROM Departments
WHERE budget > 1000000;

-- Question 3: List the names and roles of employees working on the "Project Alpha" project.
-- Method 1 
SELECT 
	e.firstname , 
	e.lastname , 
	a.role
FROM Employees e
JOIN Assignments a ON e.employeeid = a.employeeid 
JOIN Projects p ON e.departmentid = p.departmentid
WHERE p.projectname = 'Project Alpha';

-- Method 2

SELECT E.FirstName, E.LastName, A.Role
FROM Employees E
JOIN Assignments A ON E.EmployeeID = A.EmployeeID
WHERE A.ProjectID = (SELECT ProjectID FROM Projects WHERE ProjectName = 'Project Alpha');

-- Question 4: List the names of projects with a budget greater than 200,000.

SELECT projectname  
FROM Projects
WHERE budget > 200000;

-- Question 5: List the names and salaries of employees in the "Engineering" department.

SELECT firstname , lastname,salary 
FROM Employees
WHERE departmentid = (
						SELECT departmentid 
						FROM departments d 
						WHERE departmentname = 'Engineering');

-- Medium Questions
-- Question 6: List the number of employees in each department.
-- Method 1
SELECT d.departmentname ,
(SELECT count(*) AS total_workers FROM employees e WHERE d.departmentid =e.departmentid ) 
FROM Departments d
GROUP BY d.departmentname,d.departmentid
ORDER BY d.departmentname,d.departmentid;

-- Method 2
SELECT 
d.departmentname ,
count(e.*) AS total_workers
FROM employees e 
JOIN departments d ON e.departmentid =d.departmentid 
GROUP BY d.departmentname 
ORDER BY d.departmentname;

-- Question 7: Find the average salary of employees in the "Marketing" department.

SELECT 
    round(avg(salary),2) AS avg_Marketing_salary
FROM employees e 
WHERE departmentid IN 
                    (SELECT departmentid 
                    FROM departments d
                    WHERE departmentname ='Marketing');

-- Question 8: Find the employee with the highest salary in the "Human Resources" department.

SELECT 
    round(max(salary),2) AS max_HR_salary
FROM employees e 
WHERE departmentid IN 
                    (SELECT departmentid 
                    FROM departments d
                    WHERE departmentname ='Human Resources');

-- Question 9: List the names of projects that started in 2021.
-- Method 1 
SELECT projectname , startdate 
FROM Projects
WHERE startdate > '2021-01-01';

-- Method 2
SELECT projectname, EXTRACT (YEAR FROM startdate) AS startyear
FROM Projects
WHERE startdate > '2021-01-01';

-- Question 10: Compare the budget of each project with the total salary of employees working on that project.

SELECT p.projectname,p.budget, sum(e.salary) AS total_salary
FROM projects p
JOIN Assignments a ON a.projectid = p.projectid
JOIN Employees e ON a.employeeid = e.employeeid
GROUP BY p.projectname,p.budget;

By Fatma Nur Azman

https://github.com/Fatma-Nur-Azman
