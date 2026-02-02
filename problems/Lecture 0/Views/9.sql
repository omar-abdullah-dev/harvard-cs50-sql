-- 9.sql: English title and artist of the print with the highest brightness
SELECT english_title, artist FROM views
ORDER BY brightness DESC
LIMIT 1;
-- Alternative way:
-- WHERE brightness= (SELECT MAX(brightness) FROM views);
