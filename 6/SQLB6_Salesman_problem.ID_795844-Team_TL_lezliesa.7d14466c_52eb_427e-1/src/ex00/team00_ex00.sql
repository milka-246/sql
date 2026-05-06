CREATE TABLE nodes (point1 varchar, point2 varchar, cost numeric);

INSERT INTO nodes
VALUES ('a', 'b', 10);

INSERT INTO nodes
VALUES ('b', 'a', 10);

INSERT INTO nodes
VALUES ('b', 'c', 35);

INSERT INTO nodes
VALUES ('c', 'b', 35);

INSERT INTO nodes
VALUES ('c', 'a', 15);

INSERT INTO nodes
VALUES ('a', 'c', 15);

INSERT INTO nodes
VALUES ('d', 'c', 30);

INSERT INTO nodes
VALUES ('c', 'd', 30);

INSERT INTO nodes
VALUES ('a', 'd', 20);

INSERT INTO nodes
VALUES ('d', 'a', 20);

INSERT INTO nodes
VALUES ('d', 'b', 25);

INSERT INTO nodes
VALUES ('b', 'd', 25);

WITH RECURSIVE
    cities_count AS (
        SELECT COUNT(DISTINCT point1) AS n
        FROM nodes
    ),
    travel(tour, used, depth, total_cost) AS (
        SELECT
            'a'::VARCHAR AS tour,
            ''::VARCHAR AS used,
            0::INT AS depth,
            0::NUMERIC AS total_cost

        UNION ALL

        SELECT
            t.tour || ',' || no.point2,
            t.used || no.point2,
            t.depth + 1,
            t.total_cost + no.cost
        FROM travel t
        JOIN nodes no ON no.point1 = RIGHT(t.tour, 1)
        WHERE t.depth < (SELECT n FROM cities_count)
          AND POSITION(no.point2 IN t.used) = 0
    ),
    min_cost AS (
        SELECT MIN(total_cost) AS cost
        FROM travel
        WHERE depth = (SELECT n FROM cities_count)
          AND RIGHT(tour, 1) = 'a'
    )
SELECT
    total_cost,
    ('{' || tour || '}') AS tour
FROM travel
WHERE depth = (SELECT n FROM cities_count)
  AND RIGHT(tour, 1) = 'a'
  AND total_cost = (SELECT cost FROM min_cost)
ORDER BY 1, 2;