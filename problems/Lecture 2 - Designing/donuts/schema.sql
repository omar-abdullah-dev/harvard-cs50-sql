-- Ingredients
--
-- We certainly need to keep track of our ingredients.
-- some of the ingredients names : flour, yeast, oil, butter, and several different types of sugar.
-- price we pay per unit of ingredient (whether it’s pounds, grams, etc.).
-- unit of the ingredient

    CREATE TABLE IF NOT EXISTS ingredients (
        "id" INTEGER,
        "name" TEXT NOT NULL UNIQUE ,
        "price_per_unit" REAL NOT NULL CHECK ( "price_per_unit" > 0 ),
        "unit" TEXT NOT NULL ,
        PRIMARY KEY ("id")
    );

-- Donuts
--
    -- The name of the donut
    -- Whether gluten-free or not
    -- The price per donut
-- Oh, and it’s important that we be able to look up the ingredients for each of the donuts!

    CREATE TABLE IF NOT EXISTS donuts(
        "id" INTEGER,
        "name" TEXT NOT NULL UNIQUE ,
        "gluten_free" INTEGER NOT NULL CHECK ( "gluten_free" IN (0,1)),
        "price" REAL NOT NULL CHECK ( "price" > 0 ),
         PRIMARY KEY ("id")
    );

-- connect each donut with its ingredients:

    CREATE TABLE IF NOT EXISTS donut_ingredients (
      "donut_id" INTEGER,
      "ingredient_id" INTEGER,
      Primary Key ("donut_id","ingredient_id"),
      FOREIGN KEY ("donut_id") REFERENCES donuts("id"),
      FOREIGN KEY ("ingredient_id") REFERENCES ingredients("id")
    );

-- Customers
--
-- A customer’s first and last name
-- A history of their orders

    CREATE TABLE IF NOT EXISTS customers(
        "id" INTEGER,
        "first_name" TEXT NOT NULL ,
        "last_name" TEXT NOT NULL ,
        PRIMARY KEY ("id")
    );

-- Orders
--
-- order number
-- donuts in the order
-- customer who placed the order. We suppose we could assume only one customer places any given order.

    CREATE TABLE IF NOT EXISTS orders(
        "id" INTEGER,
        "customer_id" INTEGER NOT NULL ,
        "order_date" DEFAULT CURRENT_TIMESTAMP NOT NULL,
        PRIMARY KEY ("id"),
        FOREIGN KEY ("customer_id") REFERENCES customers("id")
    );

-- donuts in order

    CREATE TABLE IF NOT EXISTS order_items (
      "order_id" INTEGER,
      "donut_id" INTEGER,
      "quantity" INTEGER NOT NULL CHECK ( "quantity" > 0 ) ,
        PRIMARY KEY ("order_id","donut_id"),
        FOREIGN KEY ("donut_id") REFERENCES donuts("id"),
        FOREIGN KEY ("order_id") REFERENCES orders("id")
    );
