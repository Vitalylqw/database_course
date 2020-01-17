-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.


select DAYNAME(DATE_FORMAT(birthday_at,CONCAT(YEAR(now()),'-%m-%d %T'))) as Day_of_week,count(*) FROM users GROUP by Day_of_week; 
