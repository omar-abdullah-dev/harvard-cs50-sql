-- Passengers:
-- id PK
-- first_name TEXT
-- last_name TEXT
-- age INTEGER
CREATE TABLE IF NOT EXISTS  passengers (
    "id" INTEGER,
    "first_name" TEXT NOT NULL ,
    "last_name" TEXT NOT NULL ,
    "age" INTEGER NOT NULL CHECK ( "age">0 ) ,
    PRIMARY KEY ("id")
);

-- Check-ins:
-- id PK
-- passenger_id FK
-- flight_id FK
-- datetime of the check-in TEXT
CREATE TABLE IF NOT EXISTS checkIns(
     "id" INTEGER,
     "passenger_id" INTEGER,
     "flight_id" INTEGER,
     "datetime" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
     PRIMARY KEY ("id"),
     FOREIGN KEY ("passenger_id") REFERENCES passengers("id"),
     FOREIGN KEY ("flight_id") REFERENCES flights("id")
);

-- AirLines:
-- id PK
-- name of the airline TEXT
CREATE TABLE IF NOT EXISTS  airLines(
    "id" INTEGER,
    "name" TEXT NOT NULL ,
    PRIMARY KEY ("id")
);

-- Airline_Concourses:
--  id PK
-- airline_id (FK)
-- concourse TEXT IN SET ('A','B','C','D','E','F','T')
CREATE TABLE IF NOT EXISTS  airline_concourses(
    "id" INTEGER,
    "airline_id" INTEGER ,
    "concourse" TEXT NOT NULL
      CHECK ( "concourse" IN ('A','B','C','D','E','F','T')),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("airline_id") REFERENCES airLines("id")
);


-- Flights:
-- id PK
-- airline_id FK
-- departure airport TEXT
-- landing airport TEXT
-- departure TEXT
-- arrival TEXT
CREATE TABLE IF NOT EXISTS  flights (
    "id" INTEGER,
    "airline_id" INTEGER,
    "departure_airport" TEXT NOT NULL ,
    "landing_airport" TEXT NOT NULL  ,
    "departure" TEXT NOT NULL,
    "arrival" TEXT NOT NULL,
    PRIMARY KEY ("id") ,
    FOREIGN KEY ("airline_id") REFERENCES airLines("id")
);