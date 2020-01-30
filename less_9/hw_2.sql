-- Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW cp AS 
	SELECT p.name name, c.name `catalog`
		FROM products p 
			LEFT JOIN catalogs c 
				ON p.catalog_id=c.id;
							
select * from cp;


				 