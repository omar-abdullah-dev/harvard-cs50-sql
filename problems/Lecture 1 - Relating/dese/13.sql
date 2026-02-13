
-- 13.sql: Top 5 public school districts with highest average graduation rate
    SELECT districts.name ,
           ROUND(AVG(graduation_rates.graduated),2)
               AS "Average Grauation Rate"
    FROM districts
                  JOIN schools
                       ON districts.id = schools.district_id
                  JOIN graduation_rates
                       ON schools.id = graduation_rates.school_id
    WHERE districts.type = 'Public School District'
    GROUP BY district_id
    ORDER BY "Average Grauation Rate" DESC
    LIMIT 5;