-- 10.sql: Find the average brightness of prints by Hokusai with "mountain" in the English title, rounded to one decimal place
SELECT ROUND(AVG(views.brightness),1) AS "Hokusai Average Brightness" FROM views
WHERE artist = 'Hokusai'
  AND english_title LIKE '%mountain%';
