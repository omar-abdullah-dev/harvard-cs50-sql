-- 4.sql: find the first_name and the last_name of players where the birth_country is not United States
SELECT "first_name", "last_name"
FROM players
WHERE "birth_country" <> 'USA'
ORDER BY "first_name","last_name";
