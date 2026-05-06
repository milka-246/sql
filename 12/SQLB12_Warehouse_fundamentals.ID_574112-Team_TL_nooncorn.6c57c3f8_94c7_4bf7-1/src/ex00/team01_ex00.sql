WITH Latest_Currencies AS (
    SELECT DISTINCT ON (id)
        id,
        name,
        rate_to_usd
    FROM currency
    ORDER BY id, updated DESC
),
Aggregated_Balances AS (
    SELECT
        user_id,
        type,
        currency_id,
        SUM(money) AS volume
    FROM balance
    GROUP BY user_id, type, currency_id
)
SELECT
    COALESCE(u.name, 'not defined') AS name,
    COALESCE(u.lastname, 'not defined') AS lastname,
    b.type,
    b.volume,
    COALESCE(c.name, 'not defined') AS currency_name,
    COALESCE(c.rate_to_usd, 1) AS last_rate_to_usd,
    (b.volume * COALESCE(c.rate_to_usd, 1))::numeric AS total_volume_in_usd
FROM Aggregated_Balances b
LEFT JOIN "user" u ON b.user_id = u.id
LEFT JOIN Latest_Currencies c ON b.currency_id = c.id
ORDER BY
    name DESC,
    lastname ASC,
    type ASC;
