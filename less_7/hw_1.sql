-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.


-- Зачем тут join? Ну если нужно, так нужно.

SELECT DISTINCT u.name FROM orders o join users u ON u.id=o.user_id;

-- Без join

SELECT user_id  from orders 
GROUP by user_id;
