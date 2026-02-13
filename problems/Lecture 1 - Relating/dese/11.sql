-- 11.sql: display the names of schools, their per-pupil expenditure, and their graduation rate.
-- Sort the schools from greatest per-pupil expenditure to least.
-- If two schools have the same per-pupil expenditure, sort by school name.
SELECT schools.name , expenditures.per_pupil_expenditure , graduation_rates.graduated
FROM schools
         JOIN graduation_rates
              ON graduation_rates.school_id = schools.id
         JOIN expenditures
              ON schools.district_id = expenditures.district_id
ORDER BY per_pupil_expenditure DESC , schools.name ASC;
;
