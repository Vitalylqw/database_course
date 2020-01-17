--Подсчитайте средний возраст пользователей в таблице users

SELECT floor(avg (TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25) 'средний возраст, лет' FROM users;

