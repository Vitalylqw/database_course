
-- Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

-- 1 вариант
DELETE FROM users WHERE id  not in (select* from (SELECT id FROM users ORDER BY created_at DESC LIMIT 5) as id);

