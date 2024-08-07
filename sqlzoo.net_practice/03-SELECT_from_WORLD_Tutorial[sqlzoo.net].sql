
--link : https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial

--use the table given in '01-data.sql' as the table !!!!

SELECT * FROM world;

--1 Show the name, continent and population of all countries

SELECT name, continent, population 
FROM world;

/*2 Show the name for the countries that have a population of at least 200 million. 
200 million is 200000000, there are eight zeros.*/

SELECT name FROM world
WHERE population > 200000000;

--3 Give the name and the per capita GDP for those countries with a population of at least 200 million.

SELECT name, gdp/population  AS  per_capita_GDP 
FROM world
WHERE population > 200000000;

--https://www.youtube.com/watch?v=5Md75Wfpocs

/*4 Show the name and population in millions for the countries of the continent 'South America'. 
 Divide the population by 1000000 to get population in millions.*/

SELECT name, population/1000000  
FROM world
WHERE continent=  'South America'

--5 Show the name and population for France, Germany, Italy

SELECT name, population  
FROM world
WHERE name IN ('France', 'Germany', 'Italy')

--6 Show the countries which have a name that includes the word 'United'

SELECT name 
FROM world
WHERE name LIKE '%United%'

/* 7 Two ways to be big: A country is big if it has an area of more than 
 3 million sq km or it has a population of more than 250 million.

Show the countries that are big by area or big by population. Show name, population and area.*/

SELECT name, population, area  
FROM world
WHERE area > 3000000 or population > 250000000;

/* 8 Exclusive OR (XOR). 
Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.

Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded.*/

SELECT name, population, area  
FROM world
WHERE NOT (area > 3000000 and population > 250000000) 
and 
(area > 3000000 or population > 250000000);

/* 9 Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

For Americas show population in millions and GDP in billions both to 2 decimal places.
Millions and billions
Missing decimals*/

SELECT
    name,
    ROUND(population / 1000000.0, 2) AS "Population (millions)",
    ROUND(gdp / 1000000000.0, 2) AS "GDP (billions)"
FROM
    world
WHERE
    continent = 'South America';

/* 10 Show the name and per-capita GDP for those countries with a GDP of at least one trillion 
(1000000000000; that is 12 zeros). Round this value to the nearest 1000.

Show per-capita GDP for the trillion dollar countries to the nearest $1000. */
   
SELECT name, 
 	round(gdp/population, -3) AS "Per-capita GDP ($)"
FROM world
WHERE gdp >= 1000000000000;

/* 11 
Greece has capital Athens.
Each of the strings 'Greece', and 'Athens' has 6 characters.
Show the name and capital where the name and the capital have the same number of characters.
You can use the LENGTH function to find the number of characters in a string */

SELECT name, capital 
FROM world
WHERE LENGTH(name) = LENGTH(capital);

/* 12 
The capital of Sweden is Stockholm. Both words start with the letter 'S'.
Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
You can use the function LEFT to isolate the first character.
You can use <> as the NOT EQUALS operator. */

SELECT name,  
	capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) 
AND name <> capital ;

/*13.
Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.
Find the country that has all the vowels and no spaces in its name.
You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
The query shown misses countries like Bahamas and Belarus because they contain at least one 'a' */

SELECT
    name
FROM
    world
WHERE
    name NOT LIKE '% %'
    AND name LIKE '%a%'
    AND name LIKE '%e%'
    AND name LIKE '%i%'
    AND name LIKE '%o%'
    AND name LIKE '%u%'
    AND name NOT LIKE '%.%'
    AND name NOT LIKE '%-%' 
    
    
By Fatma Nur Azman

📧 Contact

- [LinkedIn]    https://www.linkedin.com/in/fatma-nur-azman/
- [GitHub]      https://github.com/Fatma-Nur-Azman/
- [Website]     https://fatmanurazman.vercel.app/
- [Kaggle]      https://www.kaggle.com/fnurazman





