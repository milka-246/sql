-- Session #1 
-- Step 1
BEGIN;
UPDATE pizzeria SET rating = 5 WHERE name = 'Pizza Hut';
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
-- Step 3
COMMIT;

-- Session #2
-- Step 2
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
-- Step 4
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';