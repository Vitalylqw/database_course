-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.


-- подготовка
CREATE Database flight;
USE flight;
DROP TABLE flights;
CREATE TABLE flights (
id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
from_citi varchar(150) NOT NULL,
to_citi varchar(150) NOT NULL
);

INSERT INTO flights VALUES 
(null,'moscow','omsk'),
(null,'novgorod','kasan');


DROP TABLE cities;
CREATE TABLE cities (
label varchar(150) NOT NULL PRIMARY KEY,
name varchar(150) NOT NULL
);

INSERT INTO cities VALUES
('moscow','Москва'),
('omsk','Омск'),
('novgorod','Новгород'),
('kasan','Казань');

ALTER TABLE flights 
ADD FOREIGN KEY (from_citi)
REFERENCES cities (label)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE flights 
ADD FOREIGN KEY (to_citi)
REFERENCES cities (label)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- сам запрос
SELECT  `from`,`to`
FROM (SELECT id, name as `from` from cities as c JOIN flights as f ON c.label=f.from_citi) AS f
JOIN  (SELECT id, name as `to` from cities as c JOIN flights as f ON c.label=f.to_citi) AS t
USING (id);




