-- 10.sql : Determine how many points of latitude we have at least one data point for.
SELECT COUNT(DISTINCT latitude) FROM normals;
