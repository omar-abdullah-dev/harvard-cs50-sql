-- 4.sql: find the 10 cities with the most public schools.
-- Your query should return the names of the cities and the number of public schools within them,
-- ordered from the greatest number of public schools to least.
-- If two cities have the same number of public schools, order them alphabetically.
SELECT city, COUNT(*) AS "number_of_public_schools"
FROM schools
WHERE type = 'Public School'
GROUP BY city
ORDER BY "number_of_public_schools" DESC, city
LIMIT 10;
