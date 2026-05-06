-- Session #1
-- Step 1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Step 3
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';
-- Step 5
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';
-- Step 7
COMMIT;
-- Step 9
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';

-- Session #2
--Step 2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Step 4
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';
-- Step 6
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';
-- Step 8
COMMIT;
-- Step 10
SELECT rating FROM pizzeria WHERE name = 'Pizza Hut';