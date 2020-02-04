/*
2. Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группах
самый молодой пользователь в группе
самый пожилой пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
*/

SELECT DISTINCT c.name AS comunity,
	FLOOR(COUNT(cu.user_id) OVER ()/(SELECT COUNT(*) FROM communities))	as AVG_in_comun,
	FIRST_VALUE(u.last_name) OVER (PARTITION BY cu.community_id ORDER BY p.birthday DESC)   AS yangest,
	FIRST_VALUE(u.last_name) OVER (PARTITION BY cu.community_id ORDER BY p.birthday )   AS oldest,
	COUNT(*) OVER (PARTITION BY cu.community_id) qunty_comun,
	(SELECT COUNT(*) from users) AS total_users,
	COUNT(*) OVER (PARTITION BY cu.community_id)/(SELECT COUNT(*) from users)*100 AS `%%`
	FROM communities c
		JOIN communities_users cu
			ON c.id=cu.community_id
		JOIN users u
			ON u.id=cu.user_id
		JOIN profiles p 
			ON p.user_id=u.id;	
	

		
	
	
