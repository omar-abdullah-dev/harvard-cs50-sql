-- Users:
--
-- Their first and last name
-- Their username
-- Their password
-- Keep in mind that, if a company is following best practices, application passwords are “hashed.”
-- No need to worry about hashing passwords here, though.
    CREATE TABLE IF NOT EXISTS users (
        "id" INTEGER,
        "first_name" TEXT NOT NULL ,
        "last_name" TEXT NOT NULL ,
        "user_name" TEXT UNIQUE NOT NULL ,
        "password" TEXT NOT NULL ,
        PRIMARY KEY ("id")
    );

-- Schools and Universities
-- LinkedIn also allows for official school or university accounts,
-- such as that for Harvard, so alumni (i.e., those who’ve attended) can identify their affiliation.
-- Ensure that LinkedIn’s database can store the following information about each school:
--
-- The name of the school
-- The type of school (e.g., “Elementary School”, “Middle School”, “High School”, “Lower School”, “Upper School”, “College”, “University”, etc.)
-- The school’s location
-- The year in which the school was founded
    CREATE TABLE schools(
      "id" INTEGER,
      "name" TEXT NOT NULL ,
      "type" TEXT NOT NULL ,
      "location" TEXT NOT NULL ,
      "founded_year" INTEGER,
      PRIMARY KEY ("id")
    );

-- Companies
-- so employees can identify their past or current employment with the company.
-- Ensure that LinkedIn’s database can store the following information for each company:
--
-- The name of company
-- The company’s industry (e.g., “Education”, “Technology", “Finance”, etc.)
-- The company’s location

    CREATE TABLE IF NOT EXISTS companies(
        "id" INTEGER,
        "name" TEXT NOT NULL ,
        "industry" TEXT NOT NULL ,
        "location" TEXT NOT NULL ,
        PRIMARY KEY ("id")
    );

-- Connections

-- ✅ Connections with People
-- LinkedIn’s database should be able to represent mutual (reciprocal, two-way) connections between users.
-- No need to worry about one-way connections, such as user A “following” user B without user B “following” user A.
--
    CREATE TABLE IF NOT EXISTS connections(
        "user_id" INTEGER,
        "connected_user_id" INTEGER,
        "date_connected" TEXT DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY ("user_id","connected_user_id"),
        FOREIGN KEY ("user_id") REFERENCES users("id"),
        FOREIGN KEY ("connected_user_id") REFERENCES users("id")
    );
-- ✅ Connections with Schools
-- A user should be able to create an affiliation with a given school. And similarly,
-- that school should be able to find its alumni. Additionally, allow a user to define:
--
-- The start_date of their affiliation (i.e., when they started to attend the school)
-- The end_date of their affiliation (i.e., when they graduated), if applicable
-- The degree earned/pursued (e.g., “BA”, “MA”, “PhD”, etc.)
    CREATE TABLE IF NOT EXISTS education(
        "id" INTEGER,
        "school_id" INTEGER NOT NULL ,
        "user_id" INTEGER NOT NULL ,
        "start_date" TEXT,
        "end_date" TEXT,
        "degree" TEXT,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("user_id") REFERENCES users("id"),
        FOREIGN KEY ("school_id") REFERENCES schools("id")
    );

-- ✅ Connections with Companies
-- The start date of their affiliation (i.e., the date they began work with the company)
-- The end date of their affiliation (i.e., when left the company), if applicable
-- The title they held while affiliated with the company
    CREATE TABLE IF NOT EXISTS employment (
        "id" INTEGER,
        "user_id" INTEGER NOT NULL ,
        "company_id" INTEGER NOT NULL ,
        "title" TEXT NOT NULL ,
        "start_date" TEXT NOT NULL ,
        "end_date" TEXT  ,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("user_id") REFERENCES users("id"),
    FOREIGN KEY ("company_id") REFERENCES companies("id")
    );