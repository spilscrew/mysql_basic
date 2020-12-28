/*
Подсчитайте средний возраст пользователей в таблице users.
*/
SELECT AVG(YEAR(NOW()) - YEAR(birthday_at)) FROM users;