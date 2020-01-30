-- Пусть имеется таблица с календарным полем created_at.
-- В ней размещены разряженые календарные записи за август 2018 года
-- '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
-- если дата присутствует в исходном таблице и 0, если она отсутствует.

-- Я не уловил истинную суть задания...
-- Если честно какое то не ясное задание, что именно нужно, причем тут август, причем тут изучаемая тема. 
-- Написано , что данные в таблице только за август. Требуется вывести данные только за август, если там и так только за август. Причем тут август?
-- Написано за август 2018, при этом одна дата 16  года. Ничего не понятно.

-- 1 вариант. Если все записи и так за август
SELECT created_at, IF(created_at IS NULL  ,0,1) FROM users;

-- 2 вариант. С августом 2018 г
SELECT created_at, IF(created_at IS NULL  ,0,1) FROM users WHERE created_at BETWEEN '2018-08-01 00:00:00' AND '2018-08-31 23:59:59'; 

-- 3 вариант просто за август
SELECT created_at, IF(created_at IS NULL  ,0,1) FROM users WHERE MONTH(created_at)=8; 

-- Хоть как то используя тему занятия
SET @august=8;
PREPARE prd FROM 'SELECT created_at, IF(created_at IS NULL  ,0,1) FROM users WHERE MONTH(created_at)=?';
EXECUTE prd USING @august;








