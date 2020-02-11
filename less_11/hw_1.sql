/*Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, 
название таблицы, идентификатор первичного ключа и содержимое поля name.*/

DROP TABLE IF EXISTS logs;

CREATE TABLE if NOT EXISTS logs (
id SERIAL,
table_name ENUM ('catalogs','users','products ') NOT NULL,
from_tabele_id int UNSIGNED NOT NULL,
name_from_table varchar(255),
create_at datetime DEFAULT NOW())
ENGINE=Archive;

-- Тригер на users
DROP TRIGGER archive_users;

CREATE TRIGGER archive_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (Null,'users',new.id,new.name,now());	
END

INSERT INTO users(name, birthday_at) VALUES ('Vitalii','1979-11-22');

SELECT * FROM logs;


-- Тригер на catalogs
DROP TRIGGER archive_catalogs;

CREATE TRIGGER archive_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (Null,'catalogs',new.id,new.name,now());	
END

INSERT INTO catalogs(name) VALUES ('chipset');

SELECT * FROM logs;

-- Тригер на products
DROP TRIGGER archive_products;

CREATE TRIGGER archive_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs VALUES (Null,'products',new.id,new.name,now());	
END

INSERT INTO products(name,catalog_id,price) VALUES ('Mous',2,325);

SELECT * FROM logs;
