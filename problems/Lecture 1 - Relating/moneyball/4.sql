-- 1.sql
-- You should start by getting a sense for how average player salaries have changed over time.

-- In 1.sql, write a SQL query to find the average player salary by year.
--     Sort by year in descending order.
--     Round the salary to two decimal places and call the column “average salary”.
--     return a table with two columns, one for year and one for average salary.
SELECT salaries.year , ROUND(AVG(salaries.salary),2) AS "average salary"
FROM salaries
GROUP BY salaries.year
ORDER BY salaries.year DESC ;


-- 2.sql
-- Your general manager (i.e., the person who makes decisions about player contracts)
-- asks you whether the team should trade a current player for Cal Ripken Jr.,
-- a star player who’s likely nearing his retirement.
-- In 2.sql, write a SQL query to find Cal Ripken Jr.’s salary history.
--     Sort by year in descending order.
--     return a table with two columns, one for year and one for salary.
SELECT salaries.year ,salaries.salary FROM salaries
WHERE player_id =(
    SELECT player_id FROM players
    WHERE first_name = 'Cal' AND last_name = 'Ripken'
)ORDER BY year DESC;

-- 3.sql
-- Your team is going to need a great home run hitter. Ken Griffey Jr.,
-- a long-time Silver Slugger and Gold Glove award winner, might be a good prospect.
-- In 3.sql, write a SQL query to find Ken Griffey Jr.’s home run history.
-- Sort by year in descending order.
-- Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
-- return a table with two columns, one for year and one for home runs.
SELECT performances.year,performances.HR FROM performances
WHERE player_id = (
    SELECT players.id FROM players
    WHERE players.first_name = 'Ken'
      AND players.last_name = 'Griffey'
      AND players.birth_year = 1969
) ORDER BY performances.year DESC ;

-- 4.sql
-- You need to make a recommendation about which players the team should consider hiring. With the team’s dwindling budget,
-- the general manager wants to know which players were paid the lowest salaries in 2001.
-- In 4.sql, write a SQL query to find the 50 players paid the least in 2001.
-- Sort players by salary, lowest to highest.
-- If two players have the same salary, sort alphabetically by first name and then by last name.
-- If two players have the same first and last name, sort by player ID.
-- return three columns, one for players’ first names, one for their last names, and one for their salaries.
SELECT players.first_name,players.last_name , salaries.salary FROM players
JOIN salaries
    ON salaries.player_id = players.id
WHERE salaries.year = 2001
ORDER BY salaries.salary ASC ,
         players.first_name ASC ,
         players.last_name ASC ,
         players.id ASC
LIMIT 50;
