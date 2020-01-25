	
SELECT  (SELECT CONCAT (first_name,' ',last_name) FROM users WHERE id=interlocutor) AS interlocutor,  
	COUNT(interlocutor) AS count_nessages
	FROM 
		(SELECT 
		from_user_id AS interlocutor
		FROM messages 
			WHERE to_user_id  = 75
		UNION ALL
		SELECT 
		to_user_id AS interlocutor
			FROM messages 
			WHERE  from_user_id = 75) AS interlocutors 
	WHERE 	interlocutor IN (SELECT user_id FROM friendship WHERE friend_id =75 AND status_id=1
							 UNION
							 SELECT friend_id from friendship WHERE user_id=75 AND status_id=1)	
	GROUP BY interlocutor
	ORDER BY count_nessages DESC
	LIMIT 1;

SELECT user_id FROM friendship WHERE friend_id =75 AND status_id=1
UNION
SELECT friend_id from friendship WHERE user_id=75 AND status_id=1;





	
	