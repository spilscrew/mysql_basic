/*
Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/

SELECT
    u.name AS user_name
FROM
    users AS u
RIGHT JOIN
    orders AS o
ON
    u.id = o.user_id
GROUP BY
    u.id;