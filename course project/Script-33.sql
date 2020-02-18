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
	p.quantity=tp.balance,
	p.price=(CASE 
	WHEN tp.price < 500 THEN tp.price*1.25
	WHEN tp.price < 1000 THEN tp.price*1.2
	WHEN tp.price < 3000 THEN tp.price*1.15
	ELSE tp.price*1.1
	END);


UPDATE product p LEFT JOIN 
	test_imp.product_balances as tp ON p.model = tp.artikul 
SET	
	p.quantity=0
WHERE tp.id IS  NULL;


CREATE PROCEDURE update_price_count()
BEGIN
	START TRANSACTION;
	UPDATE product p JOIN 
		test_imp.product_balances as tp ON p.model = tp.artikul 
	SET	
		p.quantity=tp.balance,
		p.price=(CASE 
		WHEN tp.price < 500 THEN tp.price*1.25
		WHEN tp.price < 1000 THEN tp.price*1.2
		WHEN tp.price < 3000 THEN tp.price*1.15
		ELSE tp.price*1.1
		END);
	UPDATE product p LEFT JOIN 
		test_imp.product_balances as tp ON p.model = tp.artikul 
	SET	
		p.quantity=0
	WHERE tp.id IS  NULL;
COMMIT;
END;

CALL update_price_count();

SELECT price,balanse as quantity FROM test_imp.product_balances p WHERE p.artikul=product.model;

SELECT p.model FROM product p JOIN test_imp.product_balances tp ON p.model = tp.artikul;
SELECT COUNT(p.model) FROM product p JOIN test_imp.product_balances tp ON p.model = tp.artikul;

CREATE TABLE lost (
id  serial PRIMARY KEY,
artikul varchar(64) NOT NULL UNIQUE,
UNIQUE  unique_artikul(artikul));

TRUNCATE test_imp.lost;
INSERT INTO test_imp.lost (artikul)
SELECT artikul FROM test_imp.product_balances pb 
	LEFT JOIN 	product p ON pb.artikul=p.model
WHERE p.model IS NULL;	

CREATE TABLE import_data (
id SERIAL PRIMARY KEY,
model varchar(64) UNIQUE,
price decimal(15,4),
quantity int,
name varchar(255),
minimum int,
sku varchar(64),
Brand_Nm varchar(255),
category_id int,
UNIQUE un_model_idx(model));

SELECT * FROM import_data  id JOIN lost l ON id.model=l.artikul;
SELECT COUNT(id.id) FROM import_data  id JOIN lost l ON id.model=l.artikul;
SELECT COUNT(*) FROM lost;

SELECT count(*) FROM import_data  id JOIN test_zubr.category c ON id.category_id=c.category_id JOIN lost l ON id.model=l.artikul;

SELECT count(*) FROM import_data  id 
	JOIN lost l ON id.model=l.artikul 
	JOIN test_zubr.manufacturer m ON id.Brand_Nm=m.name;

SELECT name, COUNT(name)  FROM test_zubr.manufacturer  GROUP by name;

SELECT * FROM test_zubr.product WHERE manufacturer_id=11;

SELECT count(*) FROM import_data  id 
	JOIN lost l ON id.model=l.artikul 
	JOIN test_zubr.category c ON id.category_id=c.category_id
	JOIN test_zubr.manufacturer m ON id.Brand_Nm=m.name;

SELECT * FROM import_data  id 
	JOIN lost l ON id.model=l.artikul 
	JOIN test_zubr.category c ON id.category_id=c.category_id
	JOIN test_zubr.manufacturer m ON id.Brand_Nm=m.name;

INSERT INTO test_zubr.product (mode,sku,upc,ean,jan,isbn,mpn,
location,stock_status_id,image,manufacturer_id,
tax_class_id,weight_class_id,length_class_id,
minimum,status,date_added,date_modified)
SELECT id.model,id.sku,'','','','','','',5,CONCAT('catalog/images_small/',id.model,'.jpg'),
m.manufacturer_id,0,1,1,minimum,now(),now()
FROM import_data  id 
	JOIN lost l ON id.model=l.artikul 
	JOIN test_zubr.category c ON id.category_id=c.category_id
	JOIN test_zubr.manufacturer m ON id.Brand_Nm=m.name;
	
SELECT id.model,id.sku,'','','','','','',5,CONCAT('catalog/images_small/',id.model,'.jpg'),
m.manufacturer_id,0,1,1,id.minimum,now(),now()
FROM import_data  id 
	JOIN lost l ON id.model=l.artikul 
	JOIN test_zubr.category c ON id.category_id=c.category_id
	JOIN test_zubr.manufacturer m ON id.Brand_Nm=m.name;
	
SELECT id.model,id.sku FROM import_data  id 
	JOIN lost l ON id.model=l.artikul 
	JOIN test_zubr.category c ON id.category_id=c.category_id
	JOIN test_zubr.manufacturer m ON id.Brand_Nm=m.name;
	
select "",1,5;