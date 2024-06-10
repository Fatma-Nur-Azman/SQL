-- 1. Create a table to store information about books in a library. The table should have the following columns:

CREATE TABLE books (
    book_id INTEGER,
    title VARCHAR(80),
    author VARCHAR(50),
    published_date DATE,
    genre VARCHAR(20)
);

/*2. Add the following book information to the books table:
Id: 100
Title: "War and Peace"
Author: "Leo Tolstoy"
Published Date: "1869-01-01"
Genre: "Novel"*/

INSERT INTO books VALUES(100, 'War and Peace', 'Leo Tolstoy', '1869-01-01', 'Novel');

/*3. Add the following books to the books table:
Book 1:

Id: 101
Title: "1984"
Author: "George Orwell"
Published Date: "1949-06-08"
Genre: "Dystopia"

Book 2:

Id: 102
Title: "To Kill a Mockingbird"
Author: "Harper Lee"
Published Date: "1960-07-11"
Genre: "Novel"
Book 3:

Id: 103
Title: "The Stranger"
Author: "Albert Camus"
Published Date: "1942-01-01"
Genre: "Novel"*/

-- Method 1
INSERT INTO books VALUES (101, '1984', 'George Orwell', '1949-06-08', 'Dystopia');
INSERT INTO books VALUES (102, 'To Kill a Mockingbird', 'Harper Lee', '1960-07-11', 'Novel');
INSERT INTO books VALUES (103, 'The Stranger', 'Albert Camus', '1942-01-01', 'Novel');

-- Method 2
INSERT INTO books (book_id, title, author, published_date, genre) VALUES
(101, '1984', 'George Orwell', '1949-06-08', 'Dystopia'),
(102, 'To Kill a Mockingbird', 'Harper Lee', '1960-07-11', 'Novel'),
(103, 'The Stranger', 'Albert Camus', '1942-01-01', 'Novel');

--4. Add additional books with only specific columns:

INSERT INTO books (title, author) VALUES ('Crime and Punishment', 'Fyodor Dostoevsky');
INSERT INTO books (title, author, genre) VALUES ('Martin Eden', 'Jack London', 'Novel');

--5. Create a table for storing student information:

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    gender VARCHAR(8) CHECK (gender IN ('male', 'female'))
);

--6. Insert data into the students table:
--Some of the data will give errors and the reasons for the errors are written next to them. 

INSERT INTO students (first_name, last_name, date_of_birth, email, phone_number, gender) VALUES 
('John', 'Doe', '1998-05-15', 'john@example.com', '555-1234', 'male'),
('Jane', 'Smith', '2000-08-22', 'jane@example.com', '555-5678', 'female'),
('Michael', 'Brown', '1999-03-30', 'michael@example.com', '555-9876', 'male'),
('Emily', 'Johnson', NULL, 'emily@example.com', '555-2222', 'female'), -- This will fail because date_of_birth is NOT NULL
('David', 'Lee', '2001-10-18', 'david@example.com', '555-4444', 'male'),
('Maria', 'Garcia', '1997-12-25', NULL, '555-7777', 'female'), -- This will fail because email is NOT NULL
('Christopher', 'Martinez', '2002-06-05', 'chris@example.com', '555-6666', 'male'),
('Sarah', 'Wilson', '1998-08-14', 'sarah@example.com', NULL, 'female'),
('James', 'Taylor', '2000-04-03', 'james@example.com', '555-3333', 'male'),
('Jennifer', 'Adams', '1999-09-20', ' ', '555-8888', 'female'), -- This will fail because email is an empty string, not a valid email
('Daniel', 'Hernandez', '2001-07-10', 'daniel@example.com', '555-1111', 'male'),
('Amanda', 'Thomas', '2000-01-28', 'amanda@example.com', '555-9999', 'female'),
('Robert', 'White', '2003-02-14', 'robert@example.com', '555-5555', NULL),
('Megan', 'Scott', '1998-11-05', 'megan@example.com', '555-7777', 'female'),
('Kevin', 'Garcia', '1999-05-30', 'kevin@example.com', '555-2222', 'male'); -- This will fail because of duplicate email

--7. View all data in the students table:

SELECT *
FROM students;

--8. View only the first names of students:

SELECT first_name
FROM students;

--9. View the first name, last name, and date of birth of students:

SELECT first_name, last_name, date_of_birth
FROM students;

--10. Create a table to store address information for students. This table should have the following columns:

CREATE TABLE student_address (
    address_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL UNIQUE,
    city VARCHAR(50),
    country VARCHAR(15),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

--11. Insert address information into the student_address table:

INSERT INTO student_address (student_id, city, country) VALUES 
(11, 'New York', 'USA'),
(12, 'Paris', 'FR'),
(17, 'London', 'UK'),
(14, 'Amsterdam', 'NL'),
(24, 'New York', 'USA');

--12. Create a teachers table and insert records:
----Some of the data will give errors and the reasons for the errors are written next to them.
CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER DEFAULT 0,
    email VARCHAR(100)
);

INSERT INTO teachers (name, age, email) VALUES
('John Doe', 25, 'john.doe@example.com'),
('Jane Smith', 30, 'jane.smith@example.com'),
('Michael Brown', 28, 'michael.brown@example.com'),
('Emily Johnson', 22, 'emily.johnson@example.com'),
('David Lee', 35, 'david.lee@example.com'),
('Maria Garcia', 27, 'maria.garcia@example.com'),
('Christopher Martinez', 29, 'christopher.martinez@example.com'),
('Sarah White', 26, 'white@example.com'), -- Duplicate email, same as Robert White
('James Taylor', 31, 'james.taylor@example.com'),
('Jennifer Adams', 33, 'jennifer.adams@example.com'),
('Daniel Hernandez', 28, 'daniel.hernandez@example.com'),
('Amanda Thomas', 24, 'amanda.thomas@example.com'),
('Robert White', 32, 'white@example.com'), -- Duplicate email, same as Sarah White
('Megan Scott', 29, 'scott@example.com'), -- Duplicate email, same as Kevin Scott
('Kevin Scott', 27, 'scott@example.com'); -- Duplicate email, same as Megan Scott

-- Inserting another record with only name and email (age will default to 0)
INSERT INTO teachers (name, email) VALUES ('Jack', 'jack@mail.com');

--13. View all records in the teachers table:

SELECT *
FROM teachers;

--14. Sort records in the teachers table alphabetically by name:

SELECT *
FROM teachers
ORDER BY name;

--15. Sort records in the teachers table by age in descending order:

SELECT *
FROM teachers
ORDER BY age DESC;


--16. Sort records in the teachers table first by email in ascending order and then by age in descending order:

SELECT *
FROM teachers
ORDER BY email ASC, age DESC;

--17. Sort records in the teachers table by the length of the name in descending order:

SELECT *, LENGTH(name) AS name_len
FROM teachers
ORDER BY LENGTH(name) DESC;

By Fatma Nur Azman

https://github.com/Fatma-Nur-Azman


















