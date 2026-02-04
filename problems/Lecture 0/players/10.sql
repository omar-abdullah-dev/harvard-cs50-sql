-- 10.sql: list the first and last names of all players of above average height,
--          sorted tallest to shortest, then by first and last name.
SELECT "first_name", "last_name" FROM players
WHERE "height" >(
    SELECT  AVG("height") AS "Average Height" FROM players
)
ORDER BY "height" DESC,"first_name","last_name";
