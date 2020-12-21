/*
Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из
таблицы, оставляя только 5 самых свежих записей.
*/

DELETE FROM dates
    WHERE created_at NOT IN (
        SELECT * FROM (
            SELECT created_at FROM dates
            ORDER BY created_at DESC LIMIT 5
        ) as remove
    );