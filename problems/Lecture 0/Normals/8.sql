-- 8.sql : Find the 10 locations with the lowest normal ocean surface temperature, sorted coldest to warmest.
SELECT "0m",latitude, longitude FROM normals
ORDER BY "0m",
         latitude
LIMIT 10;
