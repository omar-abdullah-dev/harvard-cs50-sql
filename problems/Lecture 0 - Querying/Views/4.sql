-- 4.sql: count of prints by Hiroshige with "Eastern Capital" in the English title
SELECT COUNT(*) FROM views
WHERE artist = 'Hiroshige'
  AND english_title LIKE '%Eastern Capital%';
