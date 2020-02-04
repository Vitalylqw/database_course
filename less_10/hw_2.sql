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


	
SELECT  DISTINCT  c.name,(SELECT first_name FROM users JOIN profiles ON user.id=profiles.user_id WHERE birthday) )as `User`,
MAX(p.birthday) OVER (PARTITION by cu.community_id)  AS youngest
AVG() OVER (PARTITION by cu.community_id)  AS среднее
	FROM users u
	JOIN profiles p
		ON u.id=p.user_id
	JOIN communities_users cu
		ON p.user_id=cu.user_id
	JOIN communities c	
		ON c.id=cu.community_id;


SELECT 	DISTINCT community_id, COUNT(*) OVER (PARTITION by community_id)  AS  count_in_group FROM communities_users ;

SELECT * 
	FROM users u
	JOIN profiles p
		ON u.id=p.user_id
	JOIN communities_users cu
		ON p.user_id=cu.user_id
	JOIN communities c	
		ON c.id=cu.community_id;
		
	
	
