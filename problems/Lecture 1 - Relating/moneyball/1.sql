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
