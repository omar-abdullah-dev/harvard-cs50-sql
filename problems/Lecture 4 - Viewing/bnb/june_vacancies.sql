CREATE VIEW june_vacancies AS
SELECT listings.id,
       listings.property_type,
       listings.host_name,
       COUNT(*) AS days_vacant
FROM listings
         LEFT JOIN availabilities ON listings.id = availabilities.listing_id
WHERE availabilities.available = 'TRUE'
  AND date BETWEEN '2023-06-01' AND '2023-07-01'
--     AND date LIKE '2023-06-%
--     AND date >= '2023-06-01' AND date < '2023-07-01'
GROUP BY listings.id,
         listings.property_type,
         listings.host_name;

