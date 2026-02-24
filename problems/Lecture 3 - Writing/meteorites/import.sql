-- create table "meteorites_temp"
    CREATE TABLE IF NOT EXISTS "meteorites_temp"(
        name TEXT,
        id INTEGER,
        nametype TEXT,
        class TEXT,
        mass REAL,
        discovery TEXT,
        year INTEGER,
        lat REAL,
        long REAL,
        PRIMARY KEY ("id")
    );

-- import data from CSV:
-- .import --csv --skip 1 meteorites.csv meteorites_temp
-- SELECT * FROM meteorites_temp; -- data imported from terminal

-- update empty to be NULL values
UPDATE meteorites_temp SET mass = NULL WHERE mass = '';
UPDATE meteorites_temp SET year = NULL WHERE year ='';
UPDATE meteorites_temp SET lat = NULL WHERE lat = '';
UPDATE meteorites_temp SET long = NULL WHERE long = '';

-- ROUND values to TWO digits
UPDATE meteorites_temp SET mass = ROUND(mass,2)  WHERE mass IS NOT NULL;
UPDATE meteorites_temp SET lat = ROUND(lat,2)  WHERE lat IS NOT NULL;
UPDATE meteorites_temp SET long = ROUND(long,2) WHERE long IS NOT NULL;

-- delete Relict FROM meteorites_temp Table
DELETE FROM meteorites_temp WHERE nametype = 'Relict';

-- Create meteorites table :
CREATE TABLE IF NOT EXISTS "meteorites" (
      "id" INTEGER,
      "name" TEXT NOT NULL,
      "class" TEXT NOT NULL,
      "mass" REAL,
      "discovery" TEXT NOT NULL,
      "year" INTEGER,
      "lat" REAL,
      "long" REAL,
      PRIMARY KEY ("id")
);

-- INSERT meteorites_temp table into meteorites table after cleaning

INSERT INTO meteorites ( name , class , mass, discovery,year,lat , long)
SELECT  name, class, mass, discovery, year, lat, long
FROM meteorites_temp
ORDER BY year ASC , name ASC;

DROP TABLE meteorites_temp;
