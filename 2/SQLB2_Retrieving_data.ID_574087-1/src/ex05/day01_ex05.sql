SELECT 
    person.id AS "person.id",
    person.name AS "person.name",
    person.age,
    person.gender,
    person.address,
    pizzeria.id AS "pizzeria.id",
    pizzeria.name AS "pizzeria.name",
    pizzeria.rating
FROM person
CROSS JOIN pizzeria
ORDER BY person.id ASC, pizzeria.id ASC;