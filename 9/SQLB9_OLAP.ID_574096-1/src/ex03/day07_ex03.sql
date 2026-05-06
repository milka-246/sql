SELECT 
    pizzeria.name,
    COALESCE(orders_count, 0) + COALESCE(visits_count, 0) AS total_count
FROM pizzeria
LEFT JOIN (
    SELECT 
        pizzeria_id, 
        COUNT(*) AS orders_count
    FROM person_order
    JOIN menu ON menu.id = person_order.menu_id
    GROUP BY pizzeria_id
) AS orders ON orders.pizzeria_id = pizzeria.id
LEFT JOIN (
    SELECT 
        pizzeria_id, 
        COUNT(*) AS visits_count
    FROM person_visits
    GROUP BY pizzeria_id
) AS visits ON visits.pizzeria_id = pizzeria.id
ORDER BY total_count DESC, pizzeria.name ASC;