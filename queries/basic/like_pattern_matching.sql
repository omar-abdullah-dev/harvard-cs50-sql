-- ============================================
-- LIKE PATTERN MATCHING
-- ============================================
-- LIKE is used for pattern matching with wildcards
-- Two wildcards: % (matches 0 or more characters) and _ (matches single character)

-- ============================================
-- WILDCARD: % (Percent Sign)
-- ============================================
-- Matches zero or more characters

-- Example 1: Find books with "love" anywhere in the title
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%love%';

-- Explanation: %love% matches any title containing "love"
-- Result: "The Memory of Love", "Love in the New Millennium", etc.

-- Example 2: Find books whose titles start with "The"
SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'The%';

-- Explanation: The% matches titles starting with "The"
-- Result: "The Memory of Love", "Their Eyes Were Watching God", etc.

-- Example 3: Find books whose titles start with the WORD "The" (not "Their", "They")
SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'The %';

-- Explanation: Adding space after "The" ensures it's a complete word
-- Result: "The Memory of Love", "The Book of Form and Emptiness", etc.

-- Example 4: Find books whose titles end with "Love"
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%Love';

-- Explanation: %Love matches titles ending with "Love"

-- ============================================
-- WILDCARD: _ (Underscore)
-- ============================================
-- Matches exactly ONE character

-- Example 5: Find book titled "Pyre" or "Pire" (if you're unsure of spelling)
SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'P_re';

-- Explanation: P_re matches "Pyre", "Pire", "Pore", "Pure", etc.
-- _ represents exactly one character

-- Example 6: Find books with 4-letter titles starting with "T"
SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'T___';

-- Explanation: T___ matches titles like "Time", "Tove", etc. (T + 3 characters)

-- ============================================
-- COMBINING MULTIPLE WILDCARDS
-- ============================================

-- Example 7: Find books starting with "The" and containing "love"
SELECT "title"
FROM "longlist"
WHERE "title" LIKE 'The%love%';

-- Explanation: Combines both patterns
-- Result: Titles starting with "The" that also contain "love"

-- Example 8: Find books with second letter "o"
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '_o%';

-- Explanation: _o% = any first character, "o" as second, then anything

-- Example 9: Find author names ending with "son" or "sen"
SELECT "author"
FROM "longlist"
WHERE "author" LIKE '%so_';

-- Explanation: Matches "Wilson", "Jackson", "Olsen", "Hansen", etc.

-- ============================================
-- CASE SENSITIVITY
-- ============================================
-- In SQLite: LIKE is case-INSENSITIVE by default
-- In other DBMS: May vary based on configuration

-- Example 10: These will both match "The Memory of Love"
SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%love%';  -- Matches "Love", "love", "LOVE"

SELECT "title"
FROM "longlist"
WHERE "title" LIKE '%LOVE%';  -- Also matches "Love", "love", "LOVE"

-- Note: Using = operator IS case-sensitive in SQLite
SELECT "title"
FROM "longlist"
WHERE "title" = 'the memory of love';  -- Won't match "The Memory of Love"

-- ============================================
-- NEGATION WITH NOT LIKE
-- ============================================

-- Example 11: Find books that DON'T contain "The" in title
SELECT "title"
FROM "longlist"
WHERE "title" NOT LIKE '%The%';

-- Example 12: Find authors whose names DON'T start with "A"
SELECT "author"
FROM "longlist"
WHERE "author" NOT LIKE 'A%';

-- ============================================
-- COMBINING WITH OTHER CONDITIONS
-- ============================================

-- Example 13: Find books from 2023 with "love" in title
SELECT "title", "year"
FROM "longlist"
WHERE "title" LIKE '%love%'
  AND "year" = 2023;

-- Example 14: Find highly-rated books starting with "The"
SELECT "title", "rating"
FROM "longlist"
WHERE "title" LIKE 'The%'
  AND "rating" > 4.0;

-- Example 15: Find books by authors with "Maria" in their name, published after 2020
SELECT "title", "author", "year"
FROM "longlist"
WHERE "author" LIKE '%Maria%'
  AND "year" > 2020;

-- ============================================
-- ESCAPING SPECIAL CHARACTERS
-- ============================================
-- What if you need to search for actual % or _ characters?
-- Use ESCAPE clause

-- Example 16: Find titles containing actual underscore character
SELECT "title"
FROM "books"
WHERE "title" LIKE '%\_%' ESCAPE '\';

-- Explanation: \_ means literal underscore, not wildcard
-- ESCAPE '\' tells SQL that \ is the escape character

-- ============================================
-- PRACTICAL USE CASES
-- ============================================

-- Use Case 1: Search functionality (like Google search)
-- User searches for "memory"
SELECT "title", "author"
FROM "longlist"
WHERE "title" LIKE '%memory%'
   OR "author" LIKE '%memory%';

-- Use Case 2: Find email domains
SELECT "email"
FROM "users"
WHERE "email" LIKE '%@gmail.com';

-- Use Case 3: Phone number patterns
SELECT "name", "phone"
FROM "contacts"
WHERE "phone" LIKE '617%';  -- Boston area code

-- Use Case 4: Partial name matching
SELECT "first_name", "last_name"
FROM "players"
WHERE "last_name" LIKE 'John%';  -- Johnson, Johnston, Johns, etc.

-- ============================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================
-- ⚠️ Leading wildcards (e.g., '%love') are slower
-- ✅ Trailing wildcards (e.g., 'The%') can use indexes efficiently
-- ⚠️ Avoid LIKE when exact match is possible (use = instead)

-- Slower (can't use indexes):
SELECT "title" FROM "longlist"
WHERE "title" LIKE '%Love';

-- Faster (can use indexes):
SELECT "title" FROM "longlist"
WHERE "title" LIKE 'The%';

-- Fastest (exact match):
SELECT "title" FROM "longlist"
WHERE "title" = 'The Memory of Love';

-- ============================================
-- KEY POINTS
-- ============================================
-- 1. % matches zero or more characters
-- 2. _ matches exactly one character
-- 3. LIKE is case-insensitive in SQLite (case-sensitive with =)
-- 4. Can combine multiple wildcards in one pattern
-- 5. Use NOT LIKE for exclusion
-- 6. Can combine with AND, OR for complex queries
-- 7. Use ESCAPE for literal % or _ characters
-- 8. Leading wildcards impact performance

