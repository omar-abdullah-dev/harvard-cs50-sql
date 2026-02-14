-- 8.sql
-- How much would the A’s need to pay to get the best home run hitter this past season?
-- In 8.sql, write a SQL query to find the 2001
-- salary of the player who hit the most home runs in 2001.
-- return a table with one column, the salary of the player.

    SELECT salaries.salary FROM salaries
        JOIN performances
             ON salaries.player_id = performances.player_id
    WHERE salaries.year = 2001
      AND performances.year =2001
      AND performances.HR= (
        SELECT max(performances.HR) FROM performances
        WHERE performances.year = 2001
    );
