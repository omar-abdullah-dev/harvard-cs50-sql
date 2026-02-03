-- 1.sql : Find the normal ocean surface temperature in the Gulf of Maine, off the coast of Massachusetts.
SELECT "0m" FROM normals
WHERE longitude= -69.5
  AND latitude = 42.5;
