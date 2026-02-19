-- 5.sql: find the first_name and the last_name of all R Batter Sorted by first_name then last_name
SELECT "first_name","last_name" FROM players
WHERE "bats" = 'R'
ORDER BY "first_name","last_name";