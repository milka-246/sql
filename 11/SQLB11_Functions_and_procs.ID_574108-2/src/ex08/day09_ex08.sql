CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE (fibonacci_number INTEGER) AS $$
WITH RECURSIVE fib(a, b) AS (
    SELECT 0::INTEGER, 1::INTEGER
    UNION ALL
    SELECT b, a + b
    FROM fib
    WHERE b < pstop
)
SELECT a FROM fib WHERE a < pstop;
$$ LANGUAGE sql;

SELECT * FROM fnc_fibonacci(100);
SELECT * FROM fnc_fibonacci();