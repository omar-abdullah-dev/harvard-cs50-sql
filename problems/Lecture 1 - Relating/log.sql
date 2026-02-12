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

