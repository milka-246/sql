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
    min_max_cost AS (
        SELECT 
            MIN(total_cost) AS min_cost,
            MAX(total_cost) AS max_cost
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
  AND (total_cost = (SELECT min_cost FROM min_max_cost)
    OR total_cost = (SELECT max_cost FROM min_max_cost))
ORDER BY total_cost, tour;