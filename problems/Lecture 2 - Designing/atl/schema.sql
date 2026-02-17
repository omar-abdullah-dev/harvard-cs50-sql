-- passengers:
    -- id PK
    -- first_name
    -- last_name
    -- age

-- Check-ins:
    -- id PK
    -- passenger_id FK
    -- flight_id FK
    -- datetime of the check-in

-- AirLines:
    -- id PK
    -- name of the airline
    -- concourses operates in

-- Airline_Concourses:
    -- airline_id (FK)
    -- concourse

-- Flights:
    -- id PK
    -- flight number
    -- airline_id FK
    -- departure airport TEXT
    -- heading airport TEXT
    -- departure_datetime
    -- arrival_datetime

-- airline_concourses:
    -- id PK
    -- airline_id FK
    -- concours
