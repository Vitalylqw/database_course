-- Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

DROP FUNCTION IF EXISTS FIBONACCI;

CREATE FUNCTION FIBONACCI (value int)
RETURNS int DETERMINISTIC
BEGIN
	DECLARE num,num_bef int DEFAULT 1;
	IF (value <=0) THEN 
		RETURN 0;
	ELSEIF(value=1 OR value=2) THEN
		RETURN 1;
	ELSE
		set value=value-2;
		WHILE value >0 DO
			set num=num+num_bef;
			set num_bef=num-num_bef;
			set value=value-1;
		END WHILE;
		RETURN num;
	END IF;
END$$

SELECT FIBONACCI(10)$$
