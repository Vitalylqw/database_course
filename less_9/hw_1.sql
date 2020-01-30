-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
-- переместить - я понимаю как удалить из начльной табоицы и вставить в таблицу назначения. 
-- По условиям задачи ничего не сказано, нужно ли проверять наличие такого id в таблице назначения, и что делать если он есть.
-- Поэтому будем считать, что его нет, такова логика приложения.


DROP TABLE sample.users;
SHOW CREATE TABLE users;

CREATE TABLE sample.users (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Покупатели';

TRUNCATE sample.users;

START TRANSACTION;

INSERT INTO sample.users 
(SELECT * FROM users WHERE id=1);

DELETE FROM users WHERE id=1;

COMMIT;

SELECT * FROM sample.users;
SELECT * from users;



