-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS check_products_insert$$

CREATE TRIGGER check_products_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN 
	IF (new.name IS NULL AND new.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Заполните одно из полей name или description';
	END IF;
END$$

DROP TRIGGER IF EXISTS check_products_update$$

CREATE TRIGGER check_products_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN 
	IF (new.name IS NULL AND new.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Заполните одно из полей name или description';
	END IF;
END$$

INSERT INTO products (price,catalog_id) VALUES (200,2)$$
INSERT INTO products (name,price,catalog_id) VALUES ('Куллер 100Вт',200,2)$$
INSERT INTO products (description,price,catalog_id) VALUES ('Куллер 150 Вт',210,2)$$

UPDATE products set name = Null  WHERE description is Null$$
UPDATE products set name = Null  WHERE id=9$$
UPDATE products set name = Null  WHERE id=7$$

SELECT * from products$$