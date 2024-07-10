
-- https://sqlzoo.net/wiki/SELECT_Quiz 


--use the table given in '01-data.sql' as the table !!!!

-- Some questions concerning basic SQL statements 


--1 Show countries with populations of 100000 AND 122000 as names and populations 

SELECT name, population
FROM world
WHERE population BETWEEN 100000 AND 122000;

--2 Show countries starting with Al with their populations 

SELECT name, population
FROM world
WHERE name LIKE "Al%";

--3 Show countries ending with A or L

SELECT name 
FROM world
WHERE name LIKE '%a' OR name LIKE '%l';

--4 Show the countries in Europe with names consisting of 5 letters 

SELECT name,
	length(name)
FROM world
WHERE length(name)=5 and continent='Europe'; -- region = continent

--5 Show the names of countries with a population of 64000 and 2 times the area 

SELECT name, 
	area*2 FROM world 
WHERE population = 64000;

--6 Show countries with an area larger than 50000 and a population smaller than 10000000 

SELECT name, area, population
FROM world
WHERE area > 50000 AND population < 10000000;

-- 7  that shows the population density of China, Australia, Nigeria and France

SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia')




By Fatma Nur Azman

📧 Contact

- [LinkedIn]    https://www.linkedin.com/in/fatma-nur-azman/
- [GitHub]      https://github.com/Fatma-Nur-Azman/
- [Website]     https://fatmanurazman.vercel.app/
- [Kaggle]      https://www.kaggle.com/fnurazman
