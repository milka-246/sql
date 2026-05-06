INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT 
(SELECT MAX(id) FROM person_order) + generate_series,
person.id,
(SELECT id FROM menu WHERE menu.pizza_name = 'greek pizza'),
'2022-02-25'
FROM person
JOIN generate_series(1, (SELECT COUNT(*) FROM person)) ON person.id = generate_series;