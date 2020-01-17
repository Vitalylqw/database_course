-- ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными. «аполните их текущими датой и временем.

UPDATE users SET created_at=NOW(), updated_at=NOW();

SELECT * FROM users ;