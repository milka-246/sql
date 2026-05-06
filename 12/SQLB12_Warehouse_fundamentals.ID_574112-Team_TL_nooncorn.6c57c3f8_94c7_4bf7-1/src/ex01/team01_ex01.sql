insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

WITH User_CTE AS (
    SELECT 
        id,
        COALESCE(name, 'not defined') AS name,
        COALESCE(lastname, 'not defined') AS lastname
    FROM "user"
),
Balance_With_Rate AS (
    SELECT 
        b.user_id,
        b.money,
        b.currency_id,
        b.updated AS balance_updated,
        (SELECT name FROM currency c WHERE c.id = b.currency_id LIMIT 1) AS currency_name,
        COALESCE(
            (SELECT rate_to_usd 
             FROM currency c 
             WHERE c.id = b.currency_id 
               AND c.updated <= b.updated
             ORDER BY c.updated DESC 
             LIMIT 1),
            (SELECT rate_to_usd 
             FROM currency c 
             WHERE c.id = b.currency_id 
               AND c.updated > b.updated
             ORDER BY c.updated ASC 
             LIMIT 1)
        ) AS rate_to_usd
    FROM balance b
    WHERE b.currency_id IN (SELECT DISTINCT id FROM currency)
)
SELECT 
    u.name,
    u.lastname,
    br.currency_name,
    (br.money * br.rate_to_usd)::numeric AS currency_in_usd
FROM Balance_With_Rate br
JOIN User_CTE u ON br.user_id = u.id
WHERE br.rate_to_usd IS NOT NULL
ORDER BY 
    u.name DESC,
    u.lastname ASC,
    br.currency_name ASC;
