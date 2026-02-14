-- 10.sql
-- The general manager has asked you for a report which details
-- each player’s name,
-- their salary for each year they’ve been playing,
-- and their number of home runs for each
-- year they’ve been playing.
-- To be precise, the table should include:
-- All player’s first names
-- All player’s last names
-- All player’s salaries
-- All player’s home runs
-- The year in which the player was paid that salary and hit those home runs
-- In 10.sql, write a query to return just such a table.

-- Your query should return a table with five columns, per the above.
-- Order the results, first and foremost, by player’s IDs (least to greatest).
-- Order rows about the same player by year, in descending order.
-- Consider a corner case: suppose a player has multiple salaries or performances for a given year.
-- Order them first by number of home runs, in descending order,
-- followed by salary, in descending order.
-- Be careful to ensure that, for a single row, the salary’s year and the performance’s year match.
-- Example table
-- To help you visualize what the general manager would like, they gave you an example table:
--
-- +------------+-----------+--------+------+----+
-- | first_name | last_name | salary | year | HR |
-- +------------+-----------+--------+------+----+
-- | Don        | Aase      | 400000 | 1989 | 0  |
-- | Don        | Aase      | 675000 | 1988 | 0  |
-- | Don        | Aase      | 625000 | 1987 | 0  |
-- | Don        | Aase      | 600000 | 1986 | 0  |
-- | Jeff       | Abbott    | 300000 | 2001 | 0  |
-- | Jeff       | Abbott    | 255000 | 2000 | 3  |
-- | Jeff       | Abbott    | 255000 | 1999 | 2  |
-- +------------+-----------+--------+------+----+
-- If all goes well, you might also see two rows like this in your final table:
--
-- +-------------+---------------+----------+----+------+
-- | first_name  | last_name     | salary   | HR | year |
-- +-------------+---------------+----------+----+------+
-- | Todd        | Zeile         | 3700000  | 9  | 1995 |
-- | Todd        | Zeile         | 3700000  | 5  | 1995 |
-- +-------------+---------------+----------+----+------+
-- As an aside, based on the schema of the database, why do you think Todd Zeile appears to have two different salaries (and two different HR counts) for the same year?

    SELECT players.first_name,
           players.last_name,
           salaries.salary,
           performances.HR,
           salaries.year
    FROM players
             JOIN salaries
                  ON players.id = salaries.player_id
             JOIN performances
                  ON players.id = performances.player_id
    WHERE salaries.year = performances.year
    ORDER BY players.id ASC,
             salaries.year DESC,
             performances.HR DESC,
             salaries.salary DESC;

