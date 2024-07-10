--link https://sqlzoo.net/wiki/BBC_QUIZ

--use the table given in '01-data.sql' as the table !!!!

SELECT * FROM world;


--1 Show the name of countries starting with U

SELECT name
FROM world
WHERE name LIKE 'U%';

--2 Show only the population of the United Kingdom

SELECT population 
FROM world
WHERE name = 'United Kingdom';

--3 Show only the continent of the 'France'

SELECT continent 
FROM world
WHERE name = 'France' ;

--4 Name countries with population less than 10000 and show as population /10 

SELECT name, population/10 AS population_new
FROM world 
WHERE population/10 < 10000 AND name = 'Nauru';
--Nauru = 990 

--5 Show the names and populations of countries in Europe and Asia

SELECT name, population
FROM world
WHERE continent IN ('Europe', 'Asia');

--6 . Select the code which would give two rows

SELECT name 
FROM world
WHERE name IN ('Cuba', 'Togo');

--7 Show the name of countries in the continent 'South America' with populations larger than 40000000 

SELECT name 
FROM world
WHERE continent = 'South America'
AND population > 40000000;

--answer Brazil - Colombia (questions do not take the whole main table) )


By Fatma Nur Azman

📧 Contact

- [LinkedIn]    https://www.linkedin.com/in/fatma-nur-azman/
- [GitHub]      https://github.com/Fatma-Nur-Azman/
- [Website]     https://fatmanurazman.vercel.app/
- [Kaggle]      https://www.kaggle.com/fnurazman
