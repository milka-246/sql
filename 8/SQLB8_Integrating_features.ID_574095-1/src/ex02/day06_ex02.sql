SELECT person.name, menu.pizza_name, menu.price, menu.price * (100 - person_discounts.discount) / 100 AS discount_price, pizzeria.name AS pizzeria_name
FROM person_order
JOIN person ON person.id = person_order.person_id
JOIN menu ON menu.id = person_order.menu_id
JOIN person_discounts ON (person_discounts.pizzeria_id = menu.pizzeria_id AND person_discounts.person_id = person_order.person_id)
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
ORDER BY name, pizza_name;