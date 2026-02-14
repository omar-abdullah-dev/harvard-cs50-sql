-- 9.sql
-- What salaries are other teams paying?
-- In 9.sql, write a SQL query to find the 5 lowest paying teams
-- (by average salary) in 2001.
-- Round the average salary column to two decimal places and
-- call it “average salary”.
-- Sort the teams by average salary, least to greatest.
-- return a table with two columns, one for the teams’ names
-- and one for their average salary.

    SELECT teams.name,ROUND(AVG(salaries.salary),2) AS "average salary"
    FROM salaries
     JOIN teams
          ON salaries.team_id = teams.id
    WHERE salaries.year = 2001
    GROUP BY team_id,teams.name
    ORDER BY "average salary" ASC
    LIMIT 5;
