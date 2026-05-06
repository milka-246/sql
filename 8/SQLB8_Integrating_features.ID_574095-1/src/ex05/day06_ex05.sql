COMMENT ON TABLE person_discounts IS 'Хранит персональные скидки клиентов в конкретных пиццериях. Скидка рассчитывается на основе количества заказов клиента в данной пиццерии.';
COMMENT ON COLUMN person_discounts.id IS 'Уникальный идентификатор записи о скидке (первичный ключ).';
COMMENT ON COLUMN person_discounts.person_id IS 'Идентификатор клиента (внешний ключ к таблице person).';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Идентификатор пиццерии (внешний ключ к таблице pizzeria).';
COMMENT ON COLUMN person_discounts.discount IS 'Размер персональной скидки в процентах (от 0 до 100). Рассчитывается автоматически: 10.5% за 1 заказ, 22% за 2 заказа, 30% за 3 и более заказов.';