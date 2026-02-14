-- 7.sql
-- You need to make a recommendation about which player (or players) to avoid recruiting.
-- In 7.sql, write a SQL query to find the name of the player who’s been paid the highest salary,
-- of all time, in Major League Baseball.
-- return a table with two columns, one for the player’s first name and one for their last name.

    SELECT players.first_name,players.last_name FROM players
     JOIN salaries
          ON players.id = salaries.player_id
    WHERE salaries.salary = (
        SELECT MAX(salaries.salary) FROM salaries
    );
