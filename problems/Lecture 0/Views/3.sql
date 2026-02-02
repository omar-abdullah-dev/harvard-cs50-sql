-- 3.sql: count of prints by Hokusai with "Fuji" in the English title
SELECT COUNT(*) FROM views
WHERE artist = 'Hokusai'
  AND english_title LIKE '%Fuji%';
