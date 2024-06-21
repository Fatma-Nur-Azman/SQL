
-- Let's create the table.

CREATE TABLE students(
        id int primary key,
        name varchar(30),
        address varchar(100),
        exam_score integer
);

-- Inserting data into the table

INSERT INTO students values(1, 'Betul Kuyucu', 'Istanbul',80);
INSERT INTO students (id, name, address, exam_score) values
        (2, 'Zeki Bey', 'Izmir', 90),
        (3, 'Cemal Dogan', 'Trabzon', 65),
        (4, 'Mirac', 'Bursa', 45),
        (5, 'Yavuz Bal', 'Antalya', 55);
INSERT INTO students (id, name, exam_score) values
(6, 'Bilal Degirmen', 95),
(7, 'Fahri Ersoz', 92);
INSERT INTO students values(8, 'Ali Can', 'Ankara', 81);

-- QUESTION1: Get all records with id and name information from the students table:

SELECT id, name
FROM students s;

-- QUESTION2: List all information of students with an exam score greater than 80

SELECT *
FROM students s
WHERE exam_score > 80;

-- QUESTION3: List all information of students whose address is Ankara

SELECT *
FROM students s
WHERE address = 'Ankara';

-- QUESTION4: List the name of the student whose exam score is greater than 80 and whose address is Istanbul

SELECT name
FROM students s
WHERE exam_score > 80 
AND address = 'Istanbul';

-- QUESTION5: List all information of students whose exam score is 55 or 100
-- Method 1
SELECT *
FROM students s
WHERE exam_score = 55 
OR exam_score = 100;
-- Method 2
SELECT *
FROM students s
WHERE exam_score IN (55, 100);

-- QUESTION6: List all information of students whose exam score is between 65 and 85

SELECT *
FROM students s 
WHERE exam_score BETWEEN 65 AND 85;

-- QUESTION7: List the name and exam score of students whose id is not between 3 and 5
-- Method 1
SELECT name, exam_score
FROM students s 
WHERE id NOT BETWEEN 3 AND 5;
-- Method 2
SELECT name, exam_score
FROM students s
WHERE id NOT IN (3, 4, 5);

-- QUESTION8: What is the highest exam score

SELECT max(exam_score) AS max_exam_score
FROM students s;

-- QUESTION9: List of students living in Izmir and having an exam score greater than 50:

SELECT *
FROM students s
WHERE exam_score > 50
AND address = 'Izmir';

-- QUESTION10: Number of students and average exam score:

SELECT 
	count(*) AS student_count, 
	round(avg(exam_score),2) AS avg_exam_score
FROM students s;

-- QUESTION11: Delete the row with exam_score 55

DELETE FROM students 
WHERE exam_score = 55;

-- QUESTION12: Delete the rows where the name is Derya Soylu or Cemal Dogan
-- Method 1
DELETE FROM students 
WHERE name = 'Derya Soylu' 
OR name = 'Cemal Dogan';

-- Method 2

DELETE FROM students 
WHERE name IN ('Derya Soylu', 'Cemal Dogan');

-- QUESTION13: Clear the contents of the table.
-- Method 1
DELETE FROM students;
-- Method 2
TRUNCATE TABLE students;

-- QUESTION14: Delete the table

DROP TABLE students;


By Fatma Nur Azman

https://github.com/Fatma-Nur-Azman