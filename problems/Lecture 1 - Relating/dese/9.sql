-- 9.sql: find the name (or names) of the school district(s) with the single least number of pupils.
-- Report only the name(s).
    SELECT districts.name FROM districts
               JOIN expenditures
               ON districts.id = expenditures.district_id
    WHERE pupils = (
        SELECT MIN(pupils) FROM expenditures
    );