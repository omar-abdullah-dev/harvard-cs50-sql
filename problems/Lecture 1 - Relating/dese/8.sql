-- 8.sql: display the names of all school districts
-- and the number of pupils enrolled in each.
    SELECT districts.name, expenditures.pupils
    FROM districts
         JOIN expenditures
        ON districts.id = expenditures.district_id;
