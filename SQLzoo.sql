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

-- 4th section SUM and COUNT

-- Total world population
-- 1.

-- Show the total population of the world.

-- world(name, continent, area, population, gdp)
SELECT SUM(population)
FROM world

-- List of continents
-- 2.

-- List all the continents - just once each. 
select distinct continent from world

-- GDP of Africa
-- 3.

-- Give the total GDP of Africa 
select sum(gdp) from world where continent like 'africa'

-- Count the big countries
-- 4.

-- How many countries have an area of at least 1000000 
select count(name) from world where area >= 1000000

-- Baltic states population
-- 5.

-- What is the total population of ('Estonia', 'Latvia', 'Lithuania')
 select sum(population) from world where name in ('estonia', 'latvia', 'lithuania')

--  Counting the countries of each continent
-- 6.

-- For each continent show the continent and number of countries.
select continent, count(name) from world group by continent

-- Counting big countries in each continent
-- 7.

-- For each continent show the continent and number of countries with populations of at least 10 million. 
select continent, count(name) from world where population >= 10000000 group by continent

-- Counting big continents
-- 8.

-- List the continents that have a total population of at least 100 million. 
select continent from world group by continent having sum(population) >= 100000000

-- 5 section

-- 1.

-- The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid LIKE 'ger'

--   2.

-- From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

-- Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.

-- Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012

-- 3.

-- You can combine the two steps into a single query with a JOIN.

-- SELECT *
--   FROM game JOIN goal ON (id=matchid)

-- The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
-- ON (game.id=goal.matchid)

-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.

-- Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
FROM game
JOIN goal ON (id=matchid AND teamid='GER')

-- 4.

-- Use the same JOIN as in the previous question.

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player
FROM game
JOIN goal ON (id=matchid AND player LIKE 'mario%')

-- 5.

-- The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
FROM goal
  JOIN eteam ON (teamid=id AND gtime<=10)

--   6.

-- To JOIN game with eteam you could use either
-- game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

-- Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id

-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
FROM game
  JOIN eteam ON (team1=eteam.id AND coach LIKE '%Santos')

-- 7.

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM goal
  JOIN game ON (id=matchid AND stadium = 'National Stadium, Warsaw')

-- 8.
-- The example query shows all goals scored in the Germany-Greece quarterfinal.

-- Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT(player)
FROM game
  JOIN goal ON matchid = id
WHERE ((team1='GER' OR team2='GER') AND teamid <> 'GER'

-- 9.
-- Show teamname and the total number of goals scored.
-- COUNT and GROUP BY
-- You should COUNT(*) in the SELECT line and GROUP BY teamname
SELECT teamname, COUNT(player)
FROM eteam
  JOIN goal ON id=teamid
GROUP BY teamname

-- 10.
-- Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(player) AS goals
FROM game
  JOIN goal ON (id=matchid)
GROUP BY stadium

-- 11.
-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(player) AS goals
FROM game
  JOIN goal ON (matchid=id AND (team1 = 'POL' OR team2 = 'POL'))
GROUP BY matchid, mdate

-- 12.
-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT id, mdate, COUNT(player)
FROM game
  JOIN goal ON (id=matchid AND (team1 = 'GER' OR team2 = 'GER') AND teamid='GER')
GROUP BY id, mdate
-- 13.
-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
-- mdate	team1	score1	team2	score2
-- 1 July 2012	ESP	4	ITA 	0
-- 10 June 2012	ESP	1	ITA	1
-- 10 June 2012	IRL	1	CRO	3
-- ...

-- Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 FROM
    game LEFT JOIN goal ON (id = matchid)
    GROUP BY mdate,team1,team2
    ORDER BY mdate, matchid, team1, team2

/*
Seventh section of sqlzoo, more JOIN
*/


--#1
/*
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
FROM movie
WHERE yr=1962

--#2
/*
Give year of 'Citizen Kane'.
*/
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

--#3
/*
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/
SELECT id, title, yr
FROM movie
WHERE title LIKE '%star trek%'
ORDER BY yr

--#4
/*
What are the titles of the films with id 11768, 11955, 21191
*/
SELECT title
FROM movie
WHERE id IN ( 11768, 11955, 21191)

--#5
/*
What id number does the actor 'Glenn Close' have?
*/
SELECT id
FROM actor
WHERE name = 'Glenn Close'

--#6
/*
What is the id of the film 'Casablanca'
*/
SELECT id
FROM movie
WHERE title = 'Casablanca'

--#7
/*
Obtain the cast list for 'Casablanca'.
what is a cast list?
Use movieid=11768 this is the value that you obtained in the previous question.
*/
SELECT name
FROM actor, casting
WHERE id=actorid AND movieid = (SELECT id FROM movie WHERE title = 'Casablanca')

--#8
/*
Obtain the cast list for the film 'Alien'
*/
SELECT name
FROM actor
  JOIN casting ON (id=actorid AND movieid = (SELECT id FROM movie WHERE title = 'Alien'))

--#9
/*
List the films in which 'Harrison Ford' has appeared
*/
SELECT title
FROM movie
  JOIN casting ON (id=movieid AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford'))

--#10
/*
List the films where 'Harrison Ford' has appeared - but not in the star role.
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
SELECT title
FROM movie
    JOIN casting ON (id=movieid AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord != 1)

--#11
/*
List the films together with the leading star for all 1962 films.
*/
SELECT title, name
FROM movie JOIN casting ON (id=movieid)
JOIN actor ON (actor.id = actorid)
WHERE ord=1 AND  yr = 1962

--#12
/*
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t)

--#13
/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/
SELECT title, name FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews')

--#14
/*
Obtain a list in alphabetical order of actors who've had at least 30 starring roles.
*/
SELECT name
FROM actor
  JOIN casting ON (id = actorid AND (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord=1)>=30)
GROUP BY name

--#15
/*
List the films released in the year 1978 ordered by the number of actors in the cast.
*/
SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC

--#16
/*
List all the people who have worked with 'Art Garfunkel'.
*/
SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name

/*
Eighth section of sqlzoo, Using NULL
*/

--#1
/*
List the teachers who have NULL for their department.
*/
SELECT name
FROM teacher
WHERE dept IS NULL

--#2
/*
Note the INNER JOIN misses the teacher with no department and the department with no teacher
*/
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

--#3
/*
Use a different JOIN so that all teachers are listed.
*/
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept
          ON (teacher.dept=dept.id)

--#4
/*
Use a different JOIN so that all departments are listed.
*/
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept
          ON (teacher.dept=dept.id)

--#5
/*
Use COALESCE to print the mobile number. Use the number '07986 444 2266' there is no number given. Show teacher name and mobile number or '07986 444 2266'
*/
SELECT name,
COALESCE(mobile, '07986 444 2266')
FROM teacher

--#6
/*
Use the COALESCE function and a LEFT JOIN to print the name and department name. Use the string 'None' where there is no department.
*/
SELECT COALESCE(teacher.name, 'NONE'), COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

--#7
/*
Use COUNT to show the number of teachers and the number of mobile phones.
*/
SELECT COUNT(name), COUNT(mobile)
FROM teacher

--#8
/*
Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
*/
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)
GROUP BY dept.name

--#9
/*
Use CASE to show the name of each teacher followed by 'Sci' if the the teacher is in dept 1 or 2 and 'Art' otherwise.
*/
SELECT teacher.name,
CASE WHEN dept.id = 1 THEN 'Sci'
     WHEN dept.id = 2 THEN 'Sci'
     ELSE 'Art' END
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

--#10
/*
Use CASE to show the name of each teacher followed by 'Sci' if the the teacher is in dept 1 or 2 show 'Art' if the dept is 3 and 'None' otherwise.
*/
SELECT teacher.name,
CASE
WHEN dept.id = 1 THEN 'Sci'
WHEN dept.id = 2 THEN 'Sci'
WHEN dept.id = 3 THEN 'Art'
ELSE 'None' END
FROM teacher LEFT JOIN dept ON (dept.id=teacher.dept)

/*
Final section of sqlzoo, Self JOIN
*/


--#1
/*
How many stops are in the database.
*/
SELECT COUNT(*)
FROM stops

--#2
/*
Find the id value for the stop 'Craiglockhart'
*/
SELECT id
FROM stops
WHERE name = 'Craiglockhart'

--#3
/*
Give the id and the name for the stops on the '4' 'LRT' service.
*/
SELECT id, name
FROM stops
    JOIN route ON id=stop
WHERE company = 'LRT' AND num=4

--#4
/*
The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2.
Add a HAVING clause to restrict the output to these two routes
*/
SELECT company, num, COUNT(*) AS visits
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING visits=2

--#5
/*
Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
*/
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

--#6
/*
The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown.
If you are tired of these places try 'Fairmilehead' against 'Tollcross'
*/
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'AND stopb.name = 'London Road'

--#7
/*
Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
*/
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company =b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

--#8
/*
Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
*/
SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.num=b.num AND a.company=b.company)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

--#9
/*
Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself. Include the company and bus no. of the relevant services.
*/
SELECT stopa.name, a.company, a.num
FROM route a
  JOIN route b ON (a.num=b.num AND a.company=b.company)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopb.name = 'Craiglockhart'

--#10
/*
Find the routes involving two buses that can go from Craiglockhart to Sighthill.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.
*/
SELECT DISTINCT a.num, a.company, stopb.name ,  c.num,  c.company
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
JOIN ( route c JOIN route d ON (c.company = d.company AND c.num= d.num))
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
JOIN stops stopc ON (c.stop = stopc.id)
JOIN stops stopd ON (d.stop = stopd.id)
WHERE  stopa.name = 'Craiglockhart' AND stopd.name = 'Sighthill'
            AND  stopb.name = stopc.name
ORDER BY LENGTH(a.num), b.num, stopb.id, LENGTH(c.num), d.num