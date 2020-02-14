show tables;

SHOW CREATE TABLE product;

SHOW CREATE TABLE stock_status;

select * from stock_status;

SHOW CREATE TABLE url_alias;
SHOW CREATE TABLE category_to_store;


	
CREATE DATABASE  test_imp CHARACTER SET utf8 COLLATE utf8_unicode_ci;


CREATE TABLE product_balances (
id  serial PRIMARY KEY,
artikul varchar(64) NOT NULL UNIQUE,
price decimal(15,2) NOT NULL,
balance int DEFAULT 0,
UNIQUE  unique_artikul(artikul));

ALTER TABLE product_balances MODIFY COLUMN artikul varchar(64) not NULL;

DROP TABLE product_balances;
SELECT COUNT(*) from product_balances;
SELECT COUNT(*) from product;

UPDATE product p JOIN 
	test_imp.product_balances as tp ON p.model = tp.artikul 
SET	
	p.price=tp.price,
	p.quantity=tp.balance;



SELECT price,balanse as quantity FROM test_imp.product_balances p WHERE p.artikul=product.model;

SELECT p.model FROM product p JOIN test_imp.product_balances tp ON p.model = tp.artikul;
SELECT COUNT(p.model) FROM product p JOIN test_imp.product_balances tp ON p.model = tp.artikul;
