-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
-- Я так понимаю, что здесь нужно использовать NOT DETERMINISTIC, но у меня при этом ошибка
-- SQL Error [1418] [HY000]: This function has none of DETERMINISTIC, NO SQL,
-- or READS SQL DATA in its declaration and binary logging is enabled (you *might*
-- want to use the less safe log_bin_trust_function_creators variable)
-- Поэтому оставляю DETERMINISTIC


DROP FUNCTION IF EXISTS hello$$

CREATE FUNCTION hello()
RETURNS varchar(15)   DETERMINISTIC
BEGIN
DECLARE my_time varchar(8);
DECLARE answ varchar(15);
	SET my_time=DATE_FORMAT(NOW(), "%H:%i:%s");
	CASE 
		WHEN my_time BETWEEN '06:00:00' AND '11:59:59' THEN set answ='Доброе утро';
		WHEN my_time BETWEEN '12:00:00' AND '17:59:59' THEN set answ='Добрый день';
		WHEN my_time BETWEEN '18:00:00' AND '23:59:59' THEN set answ='Добрый вечер';
		ELSE
		set answ='Доброй ночи';
	END CASE;
	RETURN answ;
END$$

SHOW FUNCTION STATUS$$
 
SELECT hello()$$



