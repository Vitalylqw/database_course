-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.
-- В талицу users будем грузить два поля имя и дата рождения. Имя - имя пользователя для авторизации- будет набор латинских букв
-- ПРостой инсерт в таблицу занимаете около часа. ПРименение транзакций, не дает существенных притемуществ. Отключение индексов то же.
-- 

-- Функция по генерации случаного имени. Передаем в функцию количесвто символов в имени

delimiter //;

DROP FUNCTION IF EXISTS get_name //

CREATE FUNCTION get_rand_name (num int)
RETURNS varchar(20) NO SQL
BEGIN 
	DECLARE  name varchar(20) DEFAULT CHAR(65+FLOOR(RAND()*25));
	WHILE num>1 DO
		SET name=CONCAT(name,CHAR(97+FLOOR(RAND()*25)));
		SET num=num-1;
	END WHILE;
	RETURN name;
END//

-- Функция по генерации дня рождения (с 1950 по 2010 гг)
DROP FUNCTION IF EXISTS get_name //

CREATE FUNCTION get_rand_birthday ()
RETURNS char(12) NO SQL
BEGIN 
	DECLARE `year` int;
	DECLARE `month`int;
	DECLARE `day` int;
	SET `year`=floor(1950+rand()*60);
	SET `month`=floor(1+rand()*12);
	SET `day`=floor(1+rand()*28);
	RETURN CONCAT(`year`,'-',`month`,'-',`day`);
END//

-- Процедура заполнения таблицы
-- Простой инсерт в таблицу занимает более часа. ПРименение транзакций, не дает существенных притемуществ. Отключение индексов то же.
-- Временное преобразование табоицы users на движок archive , на случай заливки данных и обратно, дает выйгрыш в два раза по времени
DROP PROCEDURE create_users//

CREATE PROCEDURE create_users(number_of_users int)
BEGIN
	DECLARE name varchar(20);
	DECLARE birthday char(12);
	WHILE number_of_users>0 DO
		set name=get_name(FLOOR(5+RAND()*10));
		set birthday=get_rand_birthday ();
		INSERT INTO users(name,birthday_at) VALUES (name,birthday);
		set number_of_users=number_of_users-1;
	END WHILE;
END//

DROP PROCEDURE create_users//

-- Самый быстрый и эффективный способ это сохранить в файл и занрузка из файла. Выйгрыш космический по времени.
-- Если ресурсы сервера не большие, то Быстрее всего получается , если разбивать данные по 50 -100 тысяч строк. 
-- Тогда на весь процесс уходит не более 20 минут
DROP PROCEDURE create_users//

CREATE PROCEDURE create_users(number_of_users int)
BEGIN
	DECLARE name varchar(20);
	DECLARE birthday char(12);
	DECLARE insert_text LONGTEXT DEFAULT '' ;
		WHILE number_of_users>1 DO
			set name=get_name(FLOOR(5+RAND()*10));
			set birthday=get_rand_birthday ();
			set insert_text=CONCAT(insert_text,name,',',birthday, ';');
			set number_of_users=number_of_users-1;
		END WHILE;
			set insert_text=CONCAT(insert_text,name,',',birthday);
	SELECT insert_text into OUTFILE '/var/lib/mysql-files/data.csv';	
END//

-- К Сожалению нельзя использовать в процедуре into OUTFILE. Поэтому выполним его после того как процедура отработает

CALL create_users(50000)//

LOAD DATA  INFILE '/var/lib/mysql-files/data.csv' INTO TABLE users  FIELDS TERMINATED BY ','  LINES TERMINATED  BY ';' (name,birthday_at)  //

SELECT * from users order by id desc limit 10//








