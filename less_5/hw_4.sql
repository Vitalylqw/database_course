--»з таблицы users необходимо извлечь пользователей, родившихс¤ в августе и мае.
--ћес¤цы заданы в виде списка английских названий ('may', 'august')

SELECT 
name »м¤,
CASE 
WHEN  month(birthday_at)=5 THEN 'may'
WHEN  month(birthday_at) = 8 THEN 'august'
END AS  'ћес¤ц рождени¤'
FROM users where  month(birthday_at)=5 or month(birthday_at) = 8;


