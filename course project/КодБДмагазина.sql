-- создадим служебную БД
CREATE DATABASE  test_imp CHARACTER SET utf8 COLLATE utf8_general_ci;


-- Таблица  import_data в служебной БД 
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


-- Обновим цену и наличие товара у тех позиций, котрые есть как в БД магазина, так и в сервсиной (от поставщика)
UPDATE product p JOIN 
	test_imp.import_data as tp ON p.model = tp.model 
SET	
	p.quantity=tp.quantity,
	p.price=(CASE 
	WHEN tp.price < 500 THEN tp.price*1.25
	WHEN tp.price < 1000 THEN tp.price*1.2
	WHEN tp.price < 3000 THEN tp.price*1.15
	ELSE tp.price*1.1
	END);


-- Укажем наличе ноль для товаров, которые не найдены в БД поставщика
UPDATE product p LEFT JOIN 
	test_imp.import_data as tp ON p.model = tp.model 
SET	
	p.quantity=0
WHERE tp.id IS  NULL;

-- Процедура обновления остатков
CREATE PROCEDURE update_price_count()
BEGIN
	START TRANSACTION;
		UPDATE product p JOIN 
			test_imp.import_data as tp ON p.model = tp.model 
			SET	
				p.quantity=tp.quantity,
				p.price=(CASE 
					WHEN tp.price < 500 THEN tp.price*1.25
					WHEN tp.price < 1000 THEN tp.price*1.2
					WHEN tp.price < 3000 THEN tp.price*1.15
					ELSE tp.price*1.1
					END);
		UPDATE product p LEFT JOIN 
			test_imp.import_data as tp ON p.model = tp.model 
			SET	
				p.quantity=0
		WHERE tp.id IS  NULL;
	COMMIT;
END;
DROP PROCEDURE update_price_count;
CALL update_price_count();


-- Создадим таблицу в сервсиной БД которой будем хранить отсутвующие в магазине товары
CREATE TABLE lost (
id  serial PRIMARY KEY,
artikul varchar(64) NOT NULL UNIQUE,
UNIQUE  unique_artikul(artikul));


-- Заполним таблицу lost , отсутвующим в магазине товаром. Перед эти обнулим ее.
TRUNCATE test_imp.lost;
INSERT INTO test_imp.lost (artikul)
SELECT id.model FROM test_imp.import_data id  
	LEFT JOIN 	product p ON id.model=p.model
WHERE p.model IS NULL;


-- Запрос на доавление данных в таблицу product
INSERT INTO product 
(model,
sku,
upc,
ean,
jan,
isbn,
mpn,
location,
stock_status_id,
image,
manufacturer_id,
tax_class_id,
weight_class_id,
length_class_id,
minimum,
status,
date_added,
date_modified)
SELECT 
id.model,
id.sku,
'' a,
'' b ,
'' c ,
'' d ,
''e ,
'' f,
5,
CONCAT('catalog/images_small/',id.model,'.jpg'),
m.manufacturer_id,
0,
1,
1,
id.minimum,
1,
now(),
now()
FROM test_imp.import_data  id 
	JOIN test_imp.lost l ON id.model=l.artikul 
	JOIN category c ON id.category_id=c.category_id
	JOIN manufacturer m ON id.Brand_Nm=m.name;


-- Загрузка в таблицу product_description
INSERT INTO product_description
SELECT 
product_id,
1,
id.name,
CONCAT(c.name,': ',id.name),
c.name,
id.name,
id.name,
CONCAT(c.name,': ',id.name),
CONCAT(c.name,': ',id.name)
FROM product p
	JOIN test_imp.lost l ON p.model=l.artikul
	JOIN test_imp.import_data id ON l.artikul=id.model
	JOIN category_description c ON c.category_id=id.category_id;


-- Загрузка в таблицу product_to_store
INSERT INTO product_to_store(product_id)
	SELECT  product_id 
	FROM product p
		JOIN test_imp.lost l ON p.model=l.artikul;


-- Загрузка в таблицу product_to_category
INSERT INTO product_to_category
	SELECT  product_id, id.category_id,1 
	FROM product p
		JOIN test_imp.lost l ON p.model=l.artikul
		JOIN import_data id ON l.artikul=id.model;
	
-- Функция формирования ЧПУ
CREATE FUNCTION translit(original VARCHAR(512)) 
RETURNS varchar(512) NO SQL
BEGIN
	DECLARE translit VARCHAR(512) DEFAULT '';
	DECLARE len INT(3) DEFAULT 0;
	DECLARE pos INT(3) DEFAULT 1;
	DECLARE letter CHAR(4);
	SET original = TRIM(LOWER(original));
	SET len = CHAR_LENGTH(original);
	WHILE (pos <= len) DO
		SET letter = SUBSTRING(original, pos, 1);
		CASE TRUE
			WHEN letter IN('á','à','â','ä','å','ā','ą','ă','а','а') THEN SET letter = 'a';
			WHEN letter IN('č','ć','ç','ć') THEN SET letter = 'c';
			WHEN letter IN('ď','đ','д','д') THEN SET letter = 'd';
			WHEN letter IN('é','ě','ë','è','ê','ē','ę','е','е') THEN SET letter = 'e';
			WHEN letter IN('ģ','ğ') THEN SET letter = 'g';
			WHEN letter IN('í','î','ï','ī','î','и','і') THEN SET letter = 'i';
			WHEN letter IN('ķ') THEN SET letter = 'k';
			WHEN letter IN('ľ','ĺ','ļ','ł') THEN SET letter = 'l';
			WHEN letter IN('ň','ņ','ń','ñ') THEN SET letter = 'n';
			WHEN letter IN('ó','ö','ø','õ','ô','ő','ơ','о','о') THEN SET letter = 'o';
			WHEN letter IN('ŕ','ř','р','р') THEN SET letter = 'r';
			WHEN letter IN('š','ś','ș','ş','с','с') THEN SET letter = 's';
			WHEN letter IN('ť','ț') THEN SET letter = 't';
			WHEN letter IN('ú','ů','ü','ù','û','ū','ű','ư') THEN SET letter = 'u';
			WHEN letter IN('ý','у','у') THEN SET letter = 'y';
			WHEN letter IN('ž','ź','ż') THEN SET letter = 'z';
			WHEN letter = 'б' THEN SET letter = 'b';
			WHEN letter = 'в' THEN SET letter = 'v';
			WHEN letter = 'г' THEN SET letter = 'g';
			WHEN letter = 'д' THEN SET letter = 'd';
			WHEN letter = 'ж' THEN SET letter = 'zh';
			WHEN letter = 'з' THEN SET letter = 'z';
			WHEN letter = 'и' THEN SET letter = 'i';
			WHEN letter = 'й' THEN SET letter = 'i';
			WHEN letter = 'к' THEN SET letter = 'k';
			WHEN letter = 'л' THEN SET letter = 'l';
			WHEN letter = 'м' THEN SET letter = 'm';
			WHEN letter = 'н' THEN SET letter = 'n';
			WHEN letter = 'п' THEN SET letter = 'p';
			WHEN letter = 'т' THEN SET letter = 't';
			WHEN letter = 'ф' THEN SET letter = 'f';
			WHEN letter = 'х' THEN SET letter = 'ch';
			WHEN letter = 'ц' THEN SET letter = 'c';
			WHEN letter = 'ч' THEN SET letter = 'ch';
			WHEN letter = 'ш' THEN SET letter = 'sh';
			WHEN letter = 'щ' THEN SET letter = 'shch';
			WHEN letter = 'ъ' THEN SET letter = '';
			WHEN letter = 'ы' THEN SET letter = 'y';
			WHEN letter = 'ь' THEN SET letter = '';
			WHEN letter = 'э' THEN SET letter = 'e';
			WHEN letter = 'ю' THEN SET letter = 'ju';
			WHEN letter = 'я' THEN SET letter = 'ja';
			WHEN letter IN ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
			'p','q','r','s','t','u','v','x','y','z','1','2','3','4','5','6','7','8','9','0','-','_')
			THEN SET letter = letter;
		ELSE
			SET letter = '-';
		END CASE;
		SET translit = CONCAT(translit, letter);
		SET pos = pos + 1;
	END WHILE;
	WHILE (translit REGEXP '\-{2,}') DO
		SET translit = REPLACE(translit, '--', '-');
	END WHILE;
	RETURN TRIM(BOTH '-' FROM translit);
END;	



-- Запрос на вставку в таблицу url_alias
INSERT INTO url_alias (query,keyword)
SELECT CONCAT('product_id=',p.product_id),translit(id.name)
FROM product p
	JOIN test_imp.lost l ON p.model=l.artikul
	JOIN test_imp.import_data id ON l.artikul=id.model;


-- Процедура добавления нового товара
CREATE PROCEDURE add_products()
BEGIN
	TRUNCATE test_imp.lost;
	START TRANSACTION;
		INSERT INTO test_imp.lost (artikul)
		SELECT id.model FROM test_imp.import_data id  
			LEFT JOIN 	product p ON id.model=p.model
		WHERE p.model IS NULL;
		INSERT INTO product 
			(model,
			sku,
			upc,
			ean,
			jan,
			isbn,
			mpn,
			location,
			stock_status_id,
			image,
			manufacturer_id,
			tax_class_id,
			weight_class_id,
			length_class_id,
			minimum,
			status,
			date_added,
			date_modified)
		SELECT 
			id.model,
			id.sku,
			'' a,
			'' b ,
			'' c ,
			'' d ,
			''e ,
			'' f,
			5,
			CONCAT('catalog/images_small/',id.model,'.jpg'),
			m.manufacturer_id,
			0,
			1,
			1,
			id.minimum,
			1,
			now(),
			now()
		FROM test_imp.import_data  id 
			JOIN test_imp.lost l ON id.model=l.artikul 
			JOIN category c ON id.category_id=c.category_id
			JOIN manufacturer m ON id.Brand_Nm=m.name;
		INSERT INTO product_description
			SELECT 
			product_id,
			1,
			id.name,
			CONCAT(c.name,': ',id.name),
			c.name,
			id.name,
			id.name,
			CONCAT(c.name,': ',id.name),
			CONCAT(c.name,': ',id.name)
			FROM product p
				JOIN test_imp.lost l ON p.model=l.artikul
				JOIN test_imp.import_data id ON l.artikul=id.model
				JOIN category_description c ON c.category_id=id.category_id;
		INSERT INTO product_to_store(product_id)
			SELECT  product_id 
			FROM product p
				JOIN test_imp.lost l ON p.model=l.artikul;
		INSERT INTO product_to_category
			SELECT  product_id, id.category_id,1 
			FROM product p
				JOIN test_imp.lost l ON p.model=l.artikul
				JOIN test_imp.import_data id ON l.artikul=id.model;
		INSERT INTO url_alias (query,keyword)
			SELECT CONCAT('product_id=',p.product_id),translit(id.name)
			FROM product p
				JOIN test_imp.lost l ON p.model=l.artikul
				JOIN test_imp.import_data id ON l.artikul=id.model;
	COMMIT;		
	TRUNCATE test_imp.lost;
END;
DROP PROCEDURE add_products;
CALL add_products();



