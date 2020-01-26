-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name products ,c.name catalogs FROM products p JOIN catalogs c ON p.catalog_id=c.id;