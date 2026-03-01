CREATE VIEW june_vacancies AS
SELECT listings.id,
       listings.property_type,
       listings.host_name,
       COUNT(*) AS days_vacant
FROM listings
         LEFT JOIN availabilities ON listings.id = availabilities.listing_id
    AND availabilities.available = 1
    AND date >= '2023-06-01'
    AND date < '2023-07-01'
GROUP BY listings.id,
         listings.property_type,
         listings.host_name;

