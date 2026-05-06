-- Session #1
-- Step 1
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Step 3
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';
-- Step 6
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';
-- Step 7
COMMIT;
-- Step 8
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';

-- Session #2
-- Step 2
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Step 4
UPDATE pizzeria SET rating = 3.0 WHERE name = 'Pizza Hut';
-- Step 5
COMMIT;
-- Step 9
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';