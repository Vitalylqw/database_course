-- Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.
-- как я увидел индексы уже созданы автоматически на поле mame, внешние и первичные ключи, а так же поля phone и email

-- 1. таблица communities. Индексы на все поля созданы автоматически

-- 2. таблица communities_users. Индексы на все поля созданы автоматически

-- 3. таблица friendship. Индексы на соновные поля созданы автоматически. На поля  requsted_at and confirmed_at не вижу смысла делать

-- 4. таблица friendship_statuses. Индексы на все поля созданы автоматически

-- 5. таблица likes. Индексы на все основные поля созданы автоматически. Мне кажеться нужным делять индексы на поле created_at

-- 6. таблица media. Индексы на все основные поля созданы автоматически. Мне кажеться нужным делять индексы на поле created_at, updated_at. 
-- size и filename это скорее ресурс, их будут получать. То есть записывать их будут гораздо чаше чем ограничивать или сортировать по ним.

-- 7. таблица media_types. Индексы на все поля созданы автоматически

-- 8. таблица meetings. Индексы на id и name  созданы автоматически.Я бы добавил индекс на поле sheduled_at. Я думаю это важный параметр в запросах.

CREATE INDEX meetings_sheduled_at_idx ON meetings(sheduled_at);

-- 9. таблица meetings_users. Индексы на все основные поля созданы автоматически. Мне кажеться нужным делять индексы на поле created_at

-- 10. таблица messages. Индексы  поля id, from_user_id, to_user_id созданы автоматически. На поля is_important и is_delivered 
-- не имеет смысла ставить индексы, они принимают только два занчения. Мне кажеться возможен посик по содержанию сообщения, 
-- а так же по дате создания  created_at

CREATE FULLTEXT INDEX messages_body_idx ON messages(body);

CREATE INDEX messages_created_at_idx ON messages(created_at);

-- 11. таблица posts. Индексы  поля id, user_id созданы автоматически.
-- не имеет смысла ставить индекс updated_at. Мне кажеться возможен посик по содержанию поста, 
-- а так же по дате создания  created_at, а так же на header

CREATE FULLTEXT INDEX posts_body_idx ON posts(body);

CREATE INDEX posts_created_at_idx ON posts(created_at);

CREATE INDEX posts_header_idx ON posts(header);

-- 12 в таблицу profiles я бы добавил индексы на birthday и hometown

CREATE INDEX profiles_birthday_idx ON profiles(birthday);

CREATE INDEX profiles_hometown_idx ON profiles(hometown);

-- 13. в таблице target_types все необходимые индексы имеются

-- 14. В таблице users уже имеются индексы на поля: id, email, phone. Я бы добавил еще на поля: first_name, last_name, created_at

CREATE INDEX users_first_name_idx ON users(first_name);

CREATE INDEX users_last_name_idx ON users(last_name);

CREATE INDEX users_created_at_idx ON users(created_at);

