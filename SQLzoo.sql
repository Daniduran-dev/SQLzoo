/*
First section of sqlzoo, SELECT basics
*/
--#1
/*
The example shows the population of 'France'. Strings should be in 'single quotes';
Show the population of Germany
*/
SELECT population
FROM world
WHERE name = 'Germany'

--#2
/*
The query shows the population density population/area for each country where the area is over 5,000,000 km2.
Show the name and per capita gdp: gdp/population for each country where the area is over 5,000,000 km2
*/
SELECT name, gdp/population
FROM world
WHERE area > 5000000

--#3
/*
Where to find some very small, very rich countries.
We use AND to ensure that two or more conditions hold true.
The example shows the countries where the population is small and the gdp is high.
Show the name and continent where the area is less than 2000 and the gdp is more than 5000000000
*/
SELECT name , continent
FROM world
WHERE area < 2000
AND gdp > 5000000000

--#4
/*
Checking a list The word IN allows us to check if an item is in a list. The example shows the name and population for the countries 'Ireland', 'Iceland' and 'Denmark'
Show the name and the population for 'Denmark', 'Finland', 'Norway', 'Sweden'
*/
SELECT name, population
FROM world
WHERE name IN ('Norway', 'Sweden', 'Finland',
                 'Denmark')
--#5
/*
What are the countries beginning with G? The word LIKE permits pattern matching - % is the wildcard. The examples shows countries beginning with D
Show each country that begins with G
*/
SELECT name
FROM world
WHERE name LIKE 'G%'

--#6
/*
Which countries are not too small and not too big? Show the country and the area for countries with an area between 200000 and 250000. BETWEEN allows range checking - note that it is inclusive.
Show the area in 1000 square km. Show area/1000 instead of area
*/
SELECT name, area/1000
FROM world
WHERE area BETWEEN 200000 AND 250000

/*
Second section of sqlzoo, SELECT from WORLD
*/


--#1
/*
Read the notes about this table. Observe the result of running a simple SQL command.
*/
SELECT name, continent, population
FROM world

--#2
/*
How to use WHERE to filter records.
Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
*/
SELECT name
FROM world
WHERE population>=200000000

--#3
/*
Give the name and the per capita GDP for those countries with a population of at least 200 million.
*/
SELECT name, gdp/population
FROM world
WHERE population >= 200000000

--#4
/*
Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
*/
SELECT name, population/1000000
FROM world
WHERE continent = 'South America'

--#5
/*
Show the name and population for France, Germany, Italy
*/
SELECT name, population
FROM world
WHERE name in ('France', 'Germany', 'Italy')

--#6
/*
Show the countries which have a name that includes the word 'United'
*/
SELECT name
FROM world
WHERE name LIKE '%united%'

--#7
/*
Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
Show the countries that are big by area or big by population. Show name, population and area.
*/
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000

--#8
/*
USA and China are big in population and big by area. Exclude these countries.
Show the countries that are big by area or big by population but not both. Show name, population and area.
*/
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population < 250000000)
  OR (area < 3000000 and population > 250000000)

--#9
/*
Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
For South America show population in millions and GDP in billions to 2 decimal places.
*/
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America'

--#10
/*
Show the per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
Show per-capita GDP for the trillion dollar countries to the nearest $1000.
*/
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp > 1000000000000

--#11
/*
The CASE statement shown is used to substitute North America for Caribbean in the third column.
Show the name and the continent - but substitute Australasia for Oceania - for countries beginning with N.
*/
SELECT name, continent,
       CASE WHEN continent='Caribbean' THEN 'North America'
            ELSE continent END
FROM world
WHERE name LIKE 'J%'

--#12
/*
Show the name and the continent - but substitute Eurasia for Europe and Asia; substitute America - for each country in North America or South America or Caribbean.
Show countries beginning with A or B
*/
SELECT name,
CASE WHEN continent = 'Europe' OR continent = 'Asia' THEN 'Eurasia'
      WHEN continent LIKE '%america%' OR continent = 'Caribbean' THEN 'America'
      ELSE continent END
FROM world
WHERE name LIKE 'a%' or name LIKE 'b%'

--#13
/*
Put the continents right...
Oceania becomes Australasia
Countries in Eurasia and Turkey go to Europe/Asia
Caribbean islands starting with 'B' go to North America, other Caribbean islands go to South America
Show the name, the original continent and the new continent of all countries.
*/
SELECT name, continent,
CASE WHEN continent = 'Oceania' THEN 'Australasia'
     WHEN continent = 'Eurasia' OR name = 'Turkey' THEN 'Europe/Asia'
     WHEN continent = 'Caribbean' AND name LIKE 'b%' THEN 'North America'
     WHEN continent = 'Caribbean' AND name NOT LIKE 'b%' THEN 'South America'
     ELSE continent END
FROM world
ORDER BY name

/*
Third section of sqlzoo, SELECT from Nobel
*/

--#1
/*
Change the query shown so that it displays Nobel prizes for 1950.
*/
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

--#2
/*
Show who won the 1962 prize for Literature.
*/
SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'Literature'

--#3
/*
Show the year and subject that won 'Albert Einstein' his prize.
*/
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

--#4
/*
Give the name of the 'Peace' winners since the year 2000, including 2000.
*/
SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000

--#5
/*
Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive
*/
SELECT yr, subject, winner
FROM nobel
WHERE (yr >=1980 AND yr <=1989) AND subject = 'Literature'

--#6
/*
Show all details of the presidential winners:
Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
*/
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter')

--#7
/*
Show the winners with first name John
*/
SELECT winner
FROM nobel
WHERE winner LIKE 'john%'

--#8
/*
Show the Physics winners for 1980 together with the Chemistry winners for 1984.
*/
SELECT *
FROM nobel
WHERE (subject = "Physics" AND yr = '1980') OR (subject = 'Chemistry' AND yr = 1984)

--#9
/*
Show the winners for 1980 excluding the Chemistry and Medicine
*/
SELECT *
FROM nobel
WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine')

--#10
/*
Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
*/
SELECT *
FROM nobel
WHERE (subject  = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004)

--#11
/*
Find all details of the prize won by PETER GRÜNBERG
*/
SELECT *
FROM nobel
WHERE winner LIKE 'peter gr%nberg'

--#12
/*
Find all details of the prize won by EUGENE O'NEILL
*/
SELECT *
FROM nobel
WHERE winner = 'Eugene O''Neill'

--#13
/*
Knights in order
List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
*/
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'sir%'
ORDER BY yr DESC, winner

--#14
/*
The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
Show the 1984 winners ordered by subject and winner name; but list Chemistry and Physics last.
*/
SELECT winner, subject, subject IN ('Physics','Chemistry')
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'),subject,winner

/*
Fourth section of sqlzoo, SELECT in SELECT
*/


--#1
/*
List each country name where the population is larger than 'Russia'.
*/
SELECT name
FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--#2
/*
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
*/
SELECT name
FROM world
WHERE gdp/population >
    (SELECT gdp/population FROM world WHERE name = 'United Kingdom') AND continent = 'Europe'

--#3
/*
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
*/
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name

--#4
/*
Which country has a population that is more than Canada but less than Poland? Show the name and the population.
*/
SELECT name, population
FROM world
WHERE population >
    (SELECT population FROM world WHERE name = 'Canada')
AND population <
    (SELECT population FROM world WHERE name = 'Poland')

--#5
/*
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
*/
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany'), 0), %)
FROM world
WHERE continent = 'Europe'

--#6
/*
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
*/
SELECT name
FROM world
WHERE gdp >= ALL(SELECT gdp FROM world WHERE gdp >=0 AND continent = 'Europe') AND continent != 'Europe'

--#7
/*
Find the largest country (by area) in each continent, show the continent, the name and the area:
*/
SELECT continent, name, area
FROM world x
WHERE area >= ALL
    (SELECT area FROM world y
    WHERE y.continent=x.continent
    AND area>0)

--#8
/*
List each continent and the name of the country that comes first alphabetically.
*/
SELECT continent, name
FROM world x
WHERE name <= ALL(SELECT name FROM world y WHERE y.continent = x.continent)

--#9
/*
Find the continents where all countries have a population <= 25000000.
Then find the names of the countries associated with these continents. Show name, continent and population.
*/
SELECT name, continent, population
FROM world x
WHERE 25000000  > ALL(SELECT population FROM world y WHERE x.continent = y.continent AND y.population > 0)

--#10
/*
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
*/
SELECT name, continent
FROM world x
WHERE population > ALL(SELECT population*3 FROM world y WHERE x.continent = y.continent AND population > 0 AND y.name != x.name)

