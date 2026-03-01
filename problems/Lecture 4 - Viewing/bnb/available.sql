CREATE VIEW available AS
SELECT listings.id , listings.property_type,listings.host_name,date
FROM listings
         JOIN availabilities  ON  listing_id= availabilities.listing_id ;
