-- Session #1
-- Step 1
BEGIN;
-- Step 3
UPDATE pizzeria SET rating = 2 WHERE id = 1;
-- Step 5
UPDATE pizzeria SET rating = 3 WHERE id = 2;
-- Step 7
COMMIT;

-- Session #2
-- Step 2
BEGIN;
-- Step 4
UPDATE pizzeria SET rating = 2 WHERE id = 2;
-- Step 6
UPDATE pizzeria SET rating = 3 WHERE id = 1;
-- Step 8
COMMIT;