-- 4.sql: find the first_name and the last_name of players where the birth_country is not United States
SELECT players."first_name",players."last_name" FROM players
WHERE "birth_country" != 'United States'
ORDER BY first_name, last_name DESC;