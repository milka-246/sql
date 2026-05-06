WITH visit_data AS (
SELECT person_id, pizzeria_id, visit_date
FROM person_visits
WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03'
)

SELECT 
COALESCE (person.name, '-') AS person_name,
visit_date,
COALESCE (pizzeria.name, '-') AS pizzeria_name
FROM person
FULL JOIN visit_data ON visit_data.person_id = person.id
FULL JOIN pizzeria ON pizzeria.id = visit_data.pizzeria_id
ORDER BY person_name, visit_date, pizzeria_name;