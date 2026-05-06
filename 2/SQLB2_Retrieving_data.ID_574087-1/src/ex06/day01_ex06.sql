SELECT action_date, 
(SELECT name FROM person WHERE person.id = combined.person_id) AS person_name
FROM (
 SELECT order_date AS action_date, person_id
 FROM person_order
 INTERSECT
 SELECT visit_date AS action_date, person_visits.person_id AS person_id
FROM person_visits
) AS combined
ORDER BY action_date ASC, person_name DESC;