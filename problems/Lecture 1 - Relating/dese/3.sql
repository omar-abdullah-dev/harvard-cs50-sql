-- 3.sql: find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”.
SELECT AVG(expenditures.per_pupil_expenditure) AS "Average District Per-Pupil Expenditure"  FROM expenditures ;
