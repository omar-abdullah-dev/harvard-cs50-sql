-- 5.sql
-- It’s a bit of a slow day in the office. Though Satchel no longer plays,
-- in 5.sql, write a SQL query to find all teams that Satchel Paige played for.
-- return a table with a single column, one for the name of the teams.

SELECT DISTINCT teams.name FROM teams
JOIN performances
     ON teams.id = performances.team_id
WHERE performances.player_id = (
    SELECT players.id FROM players
    WHERE players.first_name = 'Satchel'
      AND players.last_name = 'Paige'
) ;

