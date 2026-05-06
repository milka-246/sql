INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
VALUES (
    (SELECT MAX(id) + 1 FROM person_visits),
    (SELECT id FROM person WHERE name = 'Dmitriy'),
    (SELECT DISTINCT pizzeria_id 
     FROM menu 
     WHERE price < 800 
       AND pizzeria_id NOT IN (
           SELECT pizzeria_id 
           FROM person_visits 
           WHERE person_id = (SELECT id FROM person WHERE name = 'Dmitriy')
             AND visit_date = '2022-01-08'
       )
     LIMIT 1),
    '2022-01-08'
);
REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;
SELECT * FROM mv_dmitriy_visits_and_eats;