-- Удаляем обычные представления (views)
DROP VIEW v_persons_female;
DROP VIEW v_persons_male;
DROP VIEW v_generated_dates;
DROP VIEW v_symmetric_union;
DROP VIEW v_price_with_discount;

-- Удаляем материализованное представление
DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;