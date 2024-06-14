-- WILDCARD and REGEX Usage

CREATE TABLE employees2
(
id CHAR (9),
name VARCHAR(50),
state VARCHAR (50),
salary SMALLINT,
company VARCHAR (20)
);

INSERT INTO employees2 VALUES (123456789, 'John Walker', 'Florida', 2500, 'IBM'); 
INSERT INTO employees2 VALUES (234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE'); 
INSERT INTO employees2 VALUES (345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM'); 
INSERT INTO employees2 VALUES (456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE'); 
INSERT INTO employees2 VALUES (567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT'); 
INSERT INTO employees2 VALUES (456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE'); 
INSERT INTO employees2 VALUES (123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
SELECT * FROM employees2;

-- WILDCARDS 
-- Wildcards in SQL
-- LIKE Clause: Used with wildcards.
-- 1) % percent sign wildcard: queries if there are zero or more characters

-- %a 
-- , Sophia, Olivia, Isabella, Emma, Mia, Ava, a

-- %a% 
-- Ayşe, Fatma, Ahmet, Aslı, Canan, Melisa 

-- % -> 0 characters or 1 character, any character, multiple characters

-- a%
-- Adam, Alexander, Aaron, Andrew, Anthony, a

-- Briefly, how to comment -> Ctrl+/ 
SELECT * FROM employees2;

-- Retrieve employee names starting with 'E'.

SELECT Name FROM employees2 WHERE Name LIKE 'E%';

-- Retrieve employee names ending with 'e'.
SELECT Name FROM Employees2 WHERE Name LIKE '%e';

-- Retrieve names containing the letter 'e' anywhere

SELECT Name FROM Employees2 WHERE Name LIKE '%e%';

SELECT * FROM words;

SELECT * FROM employees2;

-- Retrieve employee names starting with 'B' and ending with 't'
-- LIKE _wildcard with WHERE 
SELECT Name FROM employees2 WHERE Name LIKE 'B%t';

-- Retrieve names containing the letter 'a' anywhere
SELECT Name FROM employees2 WHERE Name LIKE '%a%';

-- Retrieve names containing the letter 'e' or 'r' anywhere

SELECT Name FROM employees2 WHERE Name LIKE '%e%' OR Name LIKE '%r%';

SELECT Name FROM employees2 WHERE Name LIKE '%e%r%'; -- order matters

INSERT INTO employees2 VALUES (123456712,'xcreu','x',6000,'x');

SELECT Name FROM employees2 WHERE Name LIKE '%e%r%' OR Name LIKE '%r%e%'; 
SELECT Name FROM employees2 WHERE Name ~ 'e';

---- WILDCARD 

-- _ -> only one character 

-- Retrieve state values where the second character is 'e' and the fourth character is 'n'

SELECT State FROM employees2 WHERE State LIKE '_e_n%';

SELECT * FROM employees2;

-- Retrieve state values where the second last character is 'i'

SELECT State FROM employees2 WHERE State LIKE '%i_';

-- Retrieve state values where the second character is 'e' and at least 6 characters long

SELECT State FROM employees2 WHERE State LIKE '_e____%';

-- Retrieve state values where there is an 'i' character anywhere after the second character

SELECT State FROM employees2 WHERE State LIKE '__%i%';

CREATE TABLE words
(
word_id CHAR(10) UNIQUE, 
word VARCHAR(50) NOT NULL, 
number_of_letters SMALLINT
);

INSERT INTO words VALUES (1001,'hot', 3);
INSERT INTO words VALUES (1002,'hat', 3);
INSERT INTO words VALUES (1003,'hit', 3);
INSERT INTO words VALUES (1004,'hbt', 3);
INSERT INTO words VALUES (1008,'hct', 3); 
INSERT INTO words VALUES (1005,'adem',4);
INSERT INTO words VALUES (1006,'selena', 6);
INSERT INTO words VALUES (1007,'yusuf', 5);
INSERT INTO words VALUES (1009,'hoait', 5);
INSERT INTO words VALUES (1010,'htc', 3);
INSERT INTO words VALUES (1011,'haxxyt', 6);
SELECT * FROM words;

SELECT word FROM words WHERE word ~ 'tc';

-- order matters
--- NOT LIKE

-- Retrieve words that do not contain the letter 'h'

SELECT word FROM words WHERE word NOT LIKE '%h%';

-- Retrieve words that end with the letter 't' or 'f' 
SELECT word FROM words WHERE word LIKE '%t' OR word LIKE '%f';

-- Retrieve words that do not end with the letter 't' or 'f' 

SELECT word FROM words WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';

-- Retrieve words that start with any character and do not contain the letter 'a' or 'e' 

SELECT word FROM words WHERE word NOT LIKE '_%a%' AND word NOT LIKE '_%e%';

-- Retrieve words that do not contain the letter 'a' or 'e' 
SELECT word FROM words WHERE word NOT LIKE '%a%' AND word NOT LIKE '%e%';

-- REGEX
------ Regular Expression Condition: -- REGEX 

-- Retrieve words where the first character is 'h', the second character is 'o', 'a', 'i' and the last character is 't'

-- Method 1 
SELECT word FROM words 
WHERE word 
LIKE 'ho%t' OR word 
LIKE 'ha%t' OR word 
LIKE 'hi%t';

-- Method 2 
-- 3 letters
SELECT word FROM words WHERE word ~ 'h[oai]t';
SELECT * FROM words 
-- Retrieve words where the first character is 'h', the second character is 'o', 'a', 'i' and the last character is 't', even if it is more than 3 letters
SELECT word FROM words WHERE word ~ 'h[oai](.*)t';

SELECT * FROM words;

INSERT INTO words VALUES (1011,'habit',5);
INSERT INTO words VALUES (1012,'ahmet',5);
INSERT INTO words VALUES (1013,'ahmetaga',8);

SELECT word FROM words WHERE word ~ 'h(.*)[oae]t';

SELECT word FROM words WHERE word ~ 'h(.*)[oae]t$';

SELECT word FROM words WHERE word ~ '^h(.*)[oae]t';

SELECT word FROM words WHERE word ~ 'h';

-- ^ -> first character 
-- $ -> last character 
-- (.*) -> any character 
-- . -> _ -> one character 
-- * -> % -> 0, 1, multiple characters 

-- Retrieve words where the first character is 'h', the last character is 't' and the second character is any character
-- between 'a' and 'e' 
SELECT word FROM words WHERE word ~ '^h[a-e](.*)t$';

-- Retrieve words where the first character is 's', 'a' or 'y'

SELECT word FROM words WHERE word ~ '^[say]';

-- Retrieve words where the last character is 'm', 'a' or 'f' 

SELECT word FROM words WHERE word ~ '[maf]$';

-- Retrieve words where the first character is 's' and the last character is 'a' 
-- 's' is only one character, so there is no need to say ^
Select word from words where word ~ '^s(.*)a$';

--- The following code will not work, if there is only one character, there is no need to put it in square brackets,
-- extra characters in the middle can use (.*), 
-- '^sa$'; this regex will not work because we need to indicate that there may be other characters in the middle 
--ERROR!!
Select word from words where word ~ '^s[a]$';
Select word from words where word ~ '^sa$';
Select word from words where word ~ '^s(.*)a$';
-- Retrieve words that contain the letter 'a' anywhere

SELECT word from words where word ~ 'a';

-- Retrieve words where the first character is between 'd' and 't', followed by any character, and the third character is 'l' 
SELECT word from words where word ~ '^[d-t].l';

SELECT word from words where word ~ '^[a-e](.*)m$'; --adem
SELECT word from words where word ~ '^[a-e].e'; --adem

-- Retrieve words where the first character is between 'd' and 't', followed by any character, and the fourth character is 'e' 

SELECT word from words where word ~ '^[d-t]..e';

-- Retrieve words where the first character is between 'r' and 'z', followed by any character, and the fourth character is 'u'

SELECT word from words where word ~ '^[r-z]..u';

SELECT word from words where word ~ '[r-z]..u';

CREATE TABLE workers3
(
id CHAR (9),
name VARCHAR (50),
state VARCHAR (50), 
salary SMALLINT, 
company VARCHAR (20)
);

INSERT INTO workers3 VALUES (123456789, 'John Walker', 'Florida', 2500, 'IBM'); 
INSERT INTO workers3 VALUES (234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE'); 
INSERT INTO workers3 VALUES (345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM'); 
INSERT INTO workers3 VALUES (456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE'); 
INSERT INTO workers3 VALUES (567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT'); 
INSERT INTO workers3 VALUES (456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE'); 
INSERT INTO workers3 VALUES (123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
SELECT * FROM workers3;

-- EN
--^ when written outside square brackets, it means the first letter
--^ when written inside square brackets, it means any character except this character

-- Retrieve names from workers3 that start with 'E' and end with 'y'

SELECT name FROM workers3 WHERE Name ~ '^E(.*)y$';

-- Retrieve names from workers2 that do not start with 'E' and do not end with 'y'
SELECT name FROM workers3 WHERE Name ~ '^[^E](.*)[^y]$';

-- Retrieve names that start with 'J', 'B', or 'E' and end with 'r' or 't'

SELECT name FROM workers3 WHERE Name ~ '^[JBA](.*)[rt]$';

-- Retrieve names that start with 'J', 'B', or 'E' or end with 'r' or 't'

SELECT name FROM workers3 WHERE Name ~ '^[JBE]' OR Name ~ '[rt]$';

-- Retrieve names that do not start with 'J', 'B', or 'E' AND do not end with 'r' or 't'

SELECT name FROM workers3 WHERE Name ~ '^[^JBE](.*)[^rt]$';

DROP TABLE workers2;

CREATE TABLE workers2
(
id CHAR (9),
name VARCHAR (50),
state VARCHAR (50), 
salary SMALLINT, 
company VARCHAR (20),
number_of_employees numeric(6)
);

INSERT INTO workers2 VALUES (123456789, 'John Walker', 'Florida', 2500, 'IBM',15000); 
INSERT INTO workers2 VALUES (234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE',34900); 
INSERT INTO workers2 VALUES (345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM',903400); 
INSERT INTO workers2 VALUES (456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE',259000); 
INSERT INTO workers2 VALUES (567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT',90100); 
INSERT INTO workers2 VALUES (456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE',56900); 
INSERT INTO workers2 VALUES (123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM',45690);
INSERT INTO workers2 VALUES (123456711, 'Maks Stelon', 'Ohio', 12500, 'IBM',5790);
INSERT INTO workers2 VALUES (123456712, 'Maksim Mark', 'Ohio', 3500, 'Google',3090);
SELECT * FROM workers2;

-- Retrieve names that contain the letter 'a' or 'k' anywhere
-- The following codes query the same result
SELECT name FROM workers2 WHERE name ~ 'a' OR name ~ 'k';  = SELECT name FROM workers2 WHERE name ~ '[ak]';

SELECT name FROM workers2 WHERE name ~ 'ak';  = SELECT name FROM workers2 WHERE name LIKE '%ak%';

SELECT name FROM workers2 WHERE name LIKE '%ak%';

SELECT name FROM workers2 WHERE name ~ '[ak]';

-- Both letters are present in the name field, but order matters
SELECT name FROM workers2 WHERE name ~ 'a(.*)k';

SELECT * FROM workers2;

-- Retrieve names where the first letter is between 'A' and 'F', the second letter is any character, and the third letter is 'a'

SELECT name FROM workers2 WHERE name ~ '^[A-F].a';

-- Retrieve state values where the third character is 'o' or 'x'

SELECT state FROM workers2 WHERE state  ~ '..[ox]';

-- When using the caret symbol, it means from the beginning
SELECT state FROM workers2 WHERE state  ~ '^..[ox]';

-- Retrieve state values where the third character is not 'o' or 'x'

SELECT state FROM workers2 WHERE state !~ '^..[ox]';

SELECT state FROM workers2 WHERE state ~ '^..[^ox]';
