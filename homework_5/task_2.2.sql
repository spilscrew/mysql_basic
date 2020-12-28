/*
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни
недели текущего года, а не года рождения.
*/
SELECT
    DATE_FORMAT(DATE_ADD(birthday_at, INTERVAL YEAR(CURDATE()) - YEAR(birthday_at) YEAR), '%W') as dayofweek,
    COUNT(*) as counter
FROM
    users
WHERE
    DATE_FORMAT(DATE_ADD(birthday_at, INTERVAL YEAR(CURDATE()) - YEAR(birthday_at) YEAR), '%W') IN ('Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday')
GROUP BY
    dayofweek;