-- 9.sql: find the players who played their final game in 2022.
--         Sort the results alphabetically by first name, then by last name.
SELECT "first_name" , "last_name" FROM players
WHERE "final_game" BETWEEN '2022-01-01' AND '2022-12-31'
-- WHERE strftime('%Y', final_game) = '2022'
ORDER BY "first_name" , "last_name";
