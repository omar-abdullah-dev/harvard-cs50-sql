-- 7.sql: find the names of schools (public or charter!)
-- in the Cambridge school district.
    SELECT schools.name FROM schools
     JOIN districts
     ON schools.district_id = districts.id
     WHERE districts.name = 'Cambridge';
