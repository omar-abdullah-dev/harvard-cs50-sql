-- PostgreSQL MBTA Database Schema
-- ==================================================
-- Boston MBTA (subway system) database

-- Create database
CREATE DATABASE "mbta";
-- \c "mbta"

-- Create cards table
CREATE TABLE "cards" (
    "id" SERIAL,
    PRIMARY KEY("id")
);

-- Create stations table
CREATE TABLE "stations" (
    "id" SERIAL,
    "name" VARCHAR(32) NOT NULL UNIQUE,
    "line" VARCHAR(32) NOT NULL,
    PRIMARY KEY("id")
);

-- Create custom ENUM type for swipes
CREATE TYPE "swipe_type" AS ENUM('enter', 'exit', 'deposit');

-- Create swipes table
CREATE TABLE "swipes" (
    "id" SERIAL,
    "card_id" INT,
    "station_id" INT,
    "type" "swipe_type" NOT NULL,
    "datetime" TIMESTAMP NOT NULL DEFAULT now(),
    "amount" NUMERIC(5,2) NOT NULL CHECK("amount" != 0),
    PRIMARY KEY("id"),
    FOREIGN KEY("station_id") REFERENCES "stations"("id"),
    FOREIGN KEY("card_id") REFERENCES "cards"("id")
);

-- Insert sample data
INSERT INTO "stations" ("name", "line") VALUES
('Park Street', 'red'),
('South Station', 'red'),
('Harvard', 'red'),
('Government Center', 'blue'),
('Aquarium', 'blue'),
('North Station', 'orange'),
('Back Bay', 'orange'),
('Copley', 'green'),
('Kenmore', 'green');

INSERT INTO "cards" VALUES (DEFAULT), (DEFAULT), (DEFAULT);

INSERT INTO "swipes" ("card_id", "station_id", "type", "amount") VALUES
(1, 1, 'enter', -2.40),
(1, 2, 'exit', 0.00),
(2, 4, 'enter', -2.40),
(3, 1, 'deposit', 20.00);

-- Query examples
SELECT * FROM "stations" WHERE "line" = 'red';
SELECT * FROM "swipes" WHERE "type" = 'deposit';

SELECT s."name", sw."type", sw."datetime"
FROM "swipes" sw
JOIN "stations" s ON sw."station_id" = s."id"
WHERE sw."card_id" = 1;

-- Advanced PostgreSQL features

-- Use INTERVAL for time calculations
SELECT "datetime", "datetime" + INTERVAL '1 day' AS "next_day"
FROM "swipes";

-- Array aggregation
SELECT "card_id", array_agg("station_id") AS "stations_visited"
FROM "swipes"
GROUP BY "card_id";

-- JSON aggregation
SELECT "line",
       json_agg(json_build_object('name', "name", 'id', "id")) AS "stations"
FROM "stations"
GROUP BY "line";

