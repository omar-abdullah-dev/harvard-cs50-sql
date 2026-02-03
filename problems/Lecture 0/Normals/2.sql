-- 2.sql : Find the normal temperature of the deepest sensor near the Gulf of Maine, at the same coordinate above.
SELECT "225m" FROM normals
WHERE longitude= -69.5
  AND latitude = 42.5;
