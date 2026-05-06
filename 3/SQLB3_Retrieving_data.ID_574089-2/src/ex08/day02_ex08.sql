SELECT DISTINCT person.name
FROM person_order
JOIN person ON person.id = person_order.person_id
JOIN menu ON menu.id = person_order.menu_id
WHERE person.gender = 'male' 
  AND person.address IN ('Moscow', 'Samara')
  AND menu.pizza_name IN ('pepperoni pizza', 'mushroom pizza')
ORDER BY person.name DESC;