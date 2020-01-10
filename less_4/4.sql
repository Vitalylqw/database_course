-- Для хроанения типа ресурса, на который ставитьс лайк. Медиа файл, пользователи, пост и тд. В случае расширения типов данных для лайков , добавляется новый тип
CREATE TABLE IF NOT EXISTS resource_type_like (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE
);

INSERT INTO resource_type_like (name) VALUES 
('users'),
('media'),
('posts');

SELECT * FROM resource_type_like;

-- Таблица для храниния лайков, которые поставил пользователь. resource_id - id ресурса, который лайкнул пользователь, в таблице этого ресурса
-- status - текущий статус записи. 1 стоит лайк, 0 нет лайка
CREATE TABLE IF NOT EXISTS likes (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
resource_type_like_id INT UNSIGNED NOT NULL,
resource_id INT UNSIGNED NOT NULL,
status bool not null DEFAULT 1,
created_at datetime default now(),
updated_at datetime default now() on update now()
);

-- Таблица для хранения истории лайков /отмены лайков пользователя по ресусрсу. type_like - 1 - установлен лайк, 0 - отменен лайк

CREATE TABLE IF NOT EXISTS history_likes (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
likes_id INT UNSIGNED NOT NULL,
type_like bool not null DEFAULT 1,
created_at datetime default now()
);



