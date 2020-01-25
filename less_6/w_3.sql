-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей. 
-- В моем понимании нужно получить одно чило. Общая сумма лайков


-- Самый простой вариант, который сразй пришел в голову, но пишет что ошибка, 
-- Почемуто при использовании IN на подзапрос, LIMIT не работает, я правитльно это понял?

SELECT count(*) AS sum_likes
	FROM likes
	WHERE target_id in (SELECT user_id FROM profiles ORDER BY birthday DESC) AND target_type_id=(SELECT id FROM target_types WHERE name='users');

-- воторой вариант. В группировку сталю target_id, так как могут быть два пользователя с одним днем рождения

SELECT sum(users_likes) 
	FROM
	(SELECT COUNT(id) as users_likes, target_id, (SELECT birthday from profiles WHERE user_id=target_id) AS birthday
		FROM likes 
		WHERE target_type_id=(SELECT id FROM target_types WHERE name='users')
		GROUP BY birthday,target_id
		ORDER BY birthday DESC
		LIMIT 10) AS ul;
	

	




	
