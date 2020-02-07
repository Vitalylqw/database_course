-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.


DROP FUNCTION IF EXISTS get_name //

CREATE FUNCTION get_name (num int)
RETURNS varchar(20) NO SQL
BEGIN 
	DECLARE  name varchar(20) DEFAULT CHAR(65+FLOOR(RAND()*25));
	WHILE num>1 DO
		SET name=CONCAT(name,CHAR(97+FLOOR(RAND()*25)));
		SET num=num-1;
	END WHILE;
	RETURN name;
END//





select get_name(5)//

