/*
(по желанию) Подсчитайте произведение чисел в столбце таблицы.
*/
SELECT round(EXP(SUM(LOG(num)))) FROM (SELECT 1 num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) SEQ;