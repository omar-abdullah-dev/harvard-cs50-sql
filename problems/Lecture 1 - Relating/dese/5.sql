-- 5.sql: find cities with 3 or fewer public schools.
-- Your query should return the names of the cities and the number of public schools within them,
-- ordered from the greatest number of public schools to least.
-- If two cities have the same number of public schools, order them alphabetically.
    SELECT city,COUNT(*) AS "school_count" FROM schools
    WHERE type = 'Public School'
    GROUP BY city
    HAVING COUNT(*) <= 3
    ORDER BY "school_count" DESC , city;