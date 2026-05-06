-- Session #1
-- Step 1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Step 3
SELECT SUM(rating) FROM pizzeria;
-- Step 6
SELECT SUM(rating) FROM pizzeria;
-- Step 7
COMMIT;
-- Step 8
SELECT SUM(rating) FROM pizzeria;

-- Session #2
-- Step 2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Step 4
INSERT INTO pizzeria (id, name, rating)
VALUES (11, 'Kazan Pizza 2', 4);
-- Step 5
COMMIT;
-- Step 9
SELECT SUM(rating) FROM pizzeria;