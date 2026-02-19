-- 2.sql: avg color of prints by Hokusai with "river" in the English title
SELECT average_color FROM views
WHERE artist = 'Hokusai'
    AND english_title LIKE '%river%';