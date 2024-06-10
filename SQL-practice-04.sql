


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    major VARCHAR(50),
    enrollment_date DATE
);

INSERT INTO students (student_id, first_name, last_name, birth_date, major, enrollment_date) VALUES
(1, 'John', 'Doe', '2000-05-15', 'Computer Science', '2018-09-01'),
(2, 'Jane', 'Smith', '1999-08-22', 'Mathematics', '2017-09-01'),
(3, 'Michael', 'Johnson', '2001-12-11', 'Physics', '2019-09-01'),
(4, 'Emily', 'Davis', '2000-03-30', 'Biology', '2018-09-01'),
(5, 'Daniel', 'Brown', '1998-11-12', 'Chemistry', '2016-09-01');


INSERT INTO students (student_id, first_name, last_name, birth_date, major, enrollment_date) VALUES
(6, 'Alice', 'Walker', '2000-02-15', 'History', '2018-09-01'),
(7, 'Robert', 'Wilson', '2001-07-19', 'Literature', '2019-09-01'),
(8, 'Jessica', 'Martinez', '1999-10-25', 'Philosophy', '2017-09-01'),
(9, 'David', 'Garcia', '2000-01-08', 'Economics', '2018-09-01'),
(10, 'Sarah', 'Lopez', '1998-09-21', 'Political Science', '2016-09-01'),
(11, 'Chris', 'Hall', '2001-04-30', 'Sociology', '2019-09-01'),
(12, 'Anna', 'Allen', '2000-11-13', 'Anthropology', '2018-09-01'),
(13, 'James', 'Young', '1999-06-07', 'Psychology', '2017-09-01'),
(14, 'Laura', 'King', '2000-03-27', 'Geography', '2018-09-01'),
(15, 'Tom', 'Wright', '2001-05-18', 'Art History', '2019-09-01');

INSERT INTO students (student_id, first_name, last_name, birth_date, major, enrollment_date) VALUES
(16, 'Sophia', 'Taylor', '1999-07-14', 'History', '2017-09-01'),
(17, 'Liam', 'Anderson', '2000-09-30', 'Literature', '2018-09-01'),
(18, 'Olivia', 'Thomas', '2001-01-20', 'Philosophy', '2019-09-01'),
(19, 'Mason', 'Jackson', '1998-03-12', 'Economics', '2016-09-01'),
(20, 'Isabella', 'White', '2000-11-04', 'Political Science', '2018-09-01');




CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(50),
    credits INT
);

INSERT INTO courses (course_id, course_name, department, credits) VALUES
(1, 'Introduction to Computer Science', 'Computer Science', 4),
(2, 'Calculus I', 'Mathematics', 4),
(3, 'General Physics', 'Physics', 4),
(4, 'Biology 101', 'Biology', 4),
(5, 'Organic Chemistry', 'Chemistry', 4);

INSERT INTO courses (course_id, course_name, department, credits) VALUES
(6, 'Modern History', 'History', 3),
(7, 'Shakespearean Literature', 'Literature', 3),
(8, 'Ethics and Philosophy', 'Philosophy', 2),
(9, 'Microeconomics', 'Economics', 3),
(10, 'Introduction to Political Science', 'Political Science', 3),
(11, 'Social Theories', 'Sociology', 3),
(12, 'Cultural Anthropology', 'Anthropology', 3),
(13, 'Cognitive Psychology', 'Psychology', 2),
(14, 'World Geography', 'Geography', 3),
(15, 'Renaissance Art', 'Art History', 3);

-- 1. List all records in the students table.

SELECT * 
FROM students ;

-- 2. List all records in the courses table.

SELECT * 
FROM courses ;

-- 3. List the first names and last names of students majoring in 'Computer Science'.

SELECT first_name, last_name 
FROM students 
WHERE major = 'Computer Science' ;

-- 4. List the names of courses in the 'Mathematics' department.

SELECT course_name
FROM courses 
WHERE department = 'Mathematics' ;

-- 5. List the first names and enrollment dates of students who enrolled before 2018.

SELECT first_name, enrollment_date
FROM students 
WHERE enrollment_date < '2018-09-01';

-- 6. List the names and credits of courses with 4 credits.

SELECT course_name, credits
FROM courses 
WHERE credits = 4;

-- 7. List the first names and birth dates of students born after the year 2000.

SELECT first_name, birth_date 
FROM students 
WHERE birth_date > '2000-01-01';

-- 8. Group all courses by department and count the number of courses in each department.

SELECT department, COUNT(*) AS count_course
FROM courses
GROUP BY department ;

-- 9. Count the total number of students in the students table.

SELECT COUNT(*) AS total_students
FROM students ;

-- 10. Group students by major and count the number of students in each major.

SELECT major, COUNT(*) AS total_count
FROM students
GROUP BY major ;

-- 11. Find the major and enrollment date of the student with the last name 'Doe'.

SELECT major, enrollment_date
FROM students
WHERE last_name = 'Doe' ;

-- 12. Find the department and credits of the course named 'Organic Chemistry'.

SELECT department, credits  
FROM courses 
WHERE course_name = 'Organic Chemistry';

-- 13. Find the first and last name of the student with student_id 3.

SELECT first_name, last_name
FROM students 
WHERE student_id = 3 ;

-- 15. Find the first name, last name, and enrollment date of the most recently enrolled student.

SELECT first_name, last_name, enrollment_date
FROM students
ORDER BY enrollment_date DESC
LIMIT 1;

-- 16. Find the course_id of the course named 'General Physics'.

SELECT course_id
FROM courses 
WHERE course_name = 'General Physics';

-- 17. List the first names of students majoring in 'Economics' in alphabetical order.

SELECT first_name 
FROM students 
WHERE major = 'Economics' 
ORDER BY first_name ;

-- 18. List all courses in descending order of credits.

SELECT * 
FROM courses 
ORDER BY credits DESC ;

-- 19. Group students by major and count the number of students in each major.

SELECT major, COUNT(*)
FROM students
GROUP BY major
ORDER BY COUNT(*);

-- 20. List the first name, last name, and course name for each student using the students and courses tables.

SELECT s.first_name, 
    s.last_name, 
    c.course_name
FROM students s 
JOIN courses c ON s.student_id = c.course_id;

By Fatma Nur Azman

https://github.com/Fatma-Nur-Azman