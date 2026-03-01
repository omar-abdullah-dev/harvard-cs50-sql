CREATE VIEW frequently_reviewed AS
SELECT listings.id ,listings.property_type, listings.host_name, COUNT(comments) AS reviews
FROM listings
         JOIN reviews ON listings.id = reviews.listing_id
WHERE comments IS NOT NULL
GROUP BY listing_id,listings.property_type, listings.id, listings.host_name
ORDER BY reviews DESC , listings.property_type ASC , host_name ASC
LIMIT 100;