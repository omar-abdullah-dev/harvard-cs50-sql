-- 6.sql: find the names of schools (public or charter!) that reported a 100% graduation rate.
    SELECT schools.name FROM schools
    WHERE id IN (
        SELECT graduation_rates.school_id
        FROM graduation_rates
        WHERE graduated = 100
    );
-- another solution: USING JOIN
    SELECT schools.name
    FROM schools
    JOIN graduation_rates
     ON schools.id = graduation_rates.school_id
    WHERE graduated =100;
