-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- Единицей активности считаем: Отправленное сообщение, лайк, пост, встреча, медиа файл.
-- Количесвто друзей и участие в группах не будем считать активностями


SELECT user_id,SUM(count_aktiv) as total_aktiv FROM
	(SELECT from_user_id user_id, COUNT(*)  count_aktiv  FROM messages GROUP BY user_id
	UNION ALL
	SELECT user_id,COUNT(*)  count_aktiv  FROM likes  GROUP BY user_id
	UNION ALL
	SELECT user_id,COUNT(*)  count_aktiv  FROM meetings_users  GROUP BY user_id
	UNION ALL
	SELECT user_id,COUNT(*)  count_aktiv  FROM media   GROUP BY user_id) AS u
	GROUP BY user_id
	ORDER BY total_aktiv
	limit 10;






