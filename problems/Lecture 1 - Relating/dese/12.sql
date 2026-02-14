-- 12.sql: find public school districts with
-- above-average per-pupil expenditures
-- and an above-average percentage of teachers rated “exemplary”.
-- Your query should return the districts’ names,
-- along with their per-pupil expenditures and percentage of teachers rated exemplary.
-- Sort the results first by the percentage of teachers rated exemplary (high to low),
-- then by the per-pupil expenditure (high to low).

SELECT districts.name, expenditures.per_pupil_expenditure,
       staff_evaluations.exemplary
FROM districts
         JOIN expenditures
              ON districts.id= expenditures.district_id
         JOIN staff_evaluations
              ON districts.id = staff_evaluations.district_id

WHERE
    districts.type = 'Public School District'
  AND
    per_pupil_expenditure > (
        SELECT AVG(per_pupil_expenditure)
        FROM expenditures
                 JOIN districts
                      ON districts.id= expenditures.district_id
    )
  AND
    exemplary > (
        SELECT AVG(exemplary)
        FROM staff_evaluations
                 JOIN districts
                      ON staff_evaluations.district_id = districts.id
    )
ORDER BY staff_evaluations.exemplary DESC ,
         expenditures.per_pupil_expenditure DESC;

-- ---> USING ALIASING
    SELECT d.name,
           e.per_pupil_expenditure,
           s.exemplary
    FROM districts d
             JOIN expenditures e
                  ON d.id = e.district_id
             JOIN staff_evaluations s
                  ON d.id = s.district_id
    WHERE d.type = 'Public School District'
      AND e.per_pupil_expenditure > (
        SELECT AVG(per_pupil_expenditure)
        FROM expenditures
    )
      AND s.exemplary > (
        SELECT AVG(exemplary)
        FROM staff_evaluations
    )
    ORDER BY s.exemplary DESC,
             e.per_pupil_expenditure DESC;
