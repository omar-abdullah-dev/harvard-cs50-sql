-- 8.sql: English titles of the 5 prints with the least contrast by Hokusai, from least to highest contrast
SELECT english_title FROM views
WHERE artist = 'Hokusai'
ORDER BY contrast
LIMIT 5;
