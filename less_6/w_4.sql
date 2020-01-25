-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT (SELECT sex FROM profiles WHERE user_id= likes.user_id) AS sex,
	COUNT(*) AS count_likes	
	FROM likes
	GROUP BY sex
	ORDER BY count_likes DESC;
