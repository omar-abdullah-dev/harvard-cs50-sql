-- *** The Lost Letter ***
-- From: 900 Somerville Avenue
-- To: 2 Finnigan Street
-- Description: A congratulatory letter

/* --- Step 1: Confirm sender address exists --- */
SELECT id
FROM addresses
WHERE address = '900 Somerville Avenue';


/* --- Step 2: Confirm receiver address exists --- */
SELECT id
FROM addresses
WHERE address = '2 Finnigan Street';


/* --- Step 3: Find the package sent from sender to receiver --- */
SELECT id, contents
FROM packages
WHERE from_address_id = (
    SELECT id
    FROM addresses
    WHERE address = '900 Somerville Avenue'
)
  AND to_address_id = (
    SELECT id
    FROM addresses
    WHERE address = '2 Finnigan Street'
);


/* --- Step 4: Determine the latest scan to find current location --- */
SELECT address_id, action, timestamp
FROM scans
WHERE package_id = (
    SELECT id
    FROM packages
    WHERE from_address_id = (
        SELECT id
        FROM addresses
        WHERE address = '900 Somerville Avenue'
    )
      AND to_address_id = (
        SELECT id
        FROM addresses
        WHERE address = '2 Finnigan Street'
    )
    LIMIT 1
)
ORDER BY timestamp DESC
LIMIT 1;


/* --- Step 5: Get final delivery address and type --- */
SELECT address, type
FROM addresses
WHERE id = (
    SELECT address_id
    FROM scans
    WHERE package_id = (
        SELECT id
        FROM packages
        WHERE from_address_id = (
            SELECT id
            FROM addresses
            WHERE address = '900 Somerville Avenue'
        )
          AND to_address_id = (
            SELECT id
            FROM addresses
            WHERE address = '2 Finnigan Street'
        )
        LIMIT 1
    )
    ORDER BY timestamp DESC
    LIMIT 1
);

-- *** The Devious Delivery ***
--     from: NULL
--     to: ???

/* Step 1: Find package with no sender address */
--         - id: 5098
--         - content: Duck debugger
--         - to_address_id : 50
SELECT "id","contents" FROM "packages"
WHERE "from_address_id" IS NULL;

/* Step 1: Find package with no sender address */
SELECT "scans"."address_id", "scans"."action" FROM "scans"
WHERE "package_id" =(
    SELECT "id" from "packages" WHERE "from_address_id" IS NULL
)ORDER BY "timestamp" DESC
LIMIT 1;

/* Step 3: Get final delivery address and type */
SELECT "address","type" FROM "addresses"
WHERE id =(
    SELECT "scans"."address_id" FROM "scans"
    WHERE "package_id" =(
        SELECT "packages"."id" from "packages" WHERE "from_address_id" IS NULL
    )ORDER BY "timestamp" DESC
    LIMIT 1
);

-- *** The Forgotten Gift ***
--     from: 109 Tileston Street
--     to: 728 Maple Place

/*  1- find the sender address id  */
SELECT id FROM addresses WHERE address = '109 Tileston Street';

/*  2- find the receiver address id */
SELECT id from addresses WHERE address = '728 Maple Place';
/*  3- find the content of the package with these ids */
SELECT packages.contents FROM packages
WHERE from_address_id=(
    SELECT id FROM addresses WHERE address = '109 Tileston Street'
    )AND to_address_id=(
        SELECT id FROM addresses WHERE address ='728 Maple Place'
    );

/* 4- find the package_id of this package from packages */
--         we can get it using content of the package
--          OR
--         we can get it using the from_address and to_address ids
-- 1 :
    SELECT id from packages WHERE contents='Flowers';
-- 2 :
    SELECT id FROM packages WHERE from_address_id=(
        SELECT id FROM addresses WHERE address = '109 Tileston Street'
    )AND to_address_id=(
        SELECT id FROM addresses WHERE address ='728 Maple Place'
    );

/* 5- find the last action of this package */
SELECT scans.action FROM scans
WHERE package_id = (
    SELECT id FROM packages WHERE from_address_id=(
        SELECT id FROM addresses WHERE address = '109 Tileston Street'
    )AND to_address_id=(
        SELECT id FROM addresses WHERE address ='728 Maple Place'
    )
) ORDER BY timestamp DESC
LIMIT 1;

/* 6- find the driver_id of the last scan using scan table*/
SELECT scans.driver_id FROM scans
WHERE package_id = (
    SELECT id FROM packages WHERE from_address_id=(
        SELECT id FROM addresses WHERE address = '109 Tileston Street'
    )AND to_address_id=(
        SELECT id FROM addresses WHERE address ='728 Maple Place'
    )
) ORDER BY timestamp DESC
LIMIT 1;

/*7- find the name of the driver using his id */
SELECT name FROM drivers
WHERE id = (
    SELECT driver_id FROM scans WHERE package_id = (
        SELECT id FROM packages WHERE from_address_id=(
            SELECT id FROM addresses WHERE address = '109 Tileston Street'
        )AND to_address_id=(
            SELECT id FROM addresses WHERE address ='728 Maple Place'
        )
    ) ORDER BY timestamp DESC
LIMIT 1
);