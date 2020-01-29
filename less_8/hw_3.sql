-- Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).

-- 1. Запрос. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
-- К сожалению более простого решения у меня не нашлось, что бы без одного вложенного запроса

SELECT (IF (from_user_id=75,CONCAT(ut.first_name,' ', ut.last_name),
	CONCAT(uf.first_name, ' ', uf.last_name))) AS interlocutor ,COUNT(*) as count_mess
 FROM messages m  
 JOIN friendship f
	ON     (f.user_id=m.from_user_id AND f.friend_id=75 AND m.to_user_id=75) 
		OR (f.user_id=m.to_user_id AND f.friend_id=75 AND m.from_user_id=75)
		OR (f.friend_id=m.from_user_id AND f.user_id=75 AND m.to_user_id=75)
		OR (f.friend_id=m.to_user_id AND f.user_id=75 AND m.from_user_id=75)
 JOIN friendship_statuses fs
 	ON 	fs.id=f.status_id
 JOIN	users uf
 	ON uf.id=m.from_user_id
 JOIN users ut 
 	ON ut.id=m.to_user_id
 WHERE fs.name='Confirmed'
 GROUP BY interlocutor
 ORDER BY count_mess DESC
 LIMIT 1;

-- 2. Зпрос. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей. Без вложенного запроса не смог придумать.

SELECT SUM(CL) as total_likes 
FROM (SELECT COUNT(l.created_at) CL 
	FROM users u 
		LEFT JOIN profiles p 
			ON u.id=p.user_id
		LEFT JOIN likes l 
			ON p.user_id=l.target_id
		LEFT JOIN target_types tt
			ON tt.id=l.target_type_id AND tt.name='users' 
		GROUP BY u.id
		ORDER BY p.birthday DESC
		LIMIT 10) as clu;
-- 3 Запрос. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT CASE(sex)
	WHEN 'M'  THEN 'Мужчины'
	WHEN 'F'  THEN 'Женщины'
	END as sex,
	COUNT(*) as count_likes
	FROM likes l 
		JOIN profiles p 
			ON l.user_id=p.user_id
	GROUP BY sex
	ORDER BY sex DESC;
	

-- 4 Запрос. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- Единицей активности считаем: Отправленное сообщение, лайк, пост, встреча, медиа файл.
-- Количесвто друзей и участие в группах не будем считать активностями
-- Мне кажеться использование JOIN для этой задаи  извращение :)
-- Ни как н смог без вложенных запросов

SELECT CONCAT(u.first_name,' ',u.last_name) as `user`,count_messages, count_likes,count_meetings, count_media ,
(IF(count_messages IS NULL,0, count_messages) +IF(count_likes IS NULL,0, count_likes)+
IF(count_meetings IS NULL,0, count_meetings)+IF(count_media IS NULL,0, count_media)) AS total
	FROM	users u 
		LEFT JOIN	
		(SELECT from_user_id user_id, COUNT(*)  count_messages  FROM messages GROUP BY user_id) m
			ON u.id=m.user_id
		LEFT JOIN (SELECT user_id,IFNULL(COUNT(*),0)  count_likes  FROM likes  GROUP BY user_id) l
			ON u.id=l.user_id
		LEFT JOIN (SELECT user_id,COUNT(*)  count_meetings  FROM meetings_users  GROUP BY user_id) mee
			ON u.id=mee.user_id
		LEFT JOIN (SELECT user_id,COUNT(*)  count_media  FROM media   GROUP BY user_id) med
			ON u.id=med.user_id
		ORDER BY total,`user`
		limit 10; 

