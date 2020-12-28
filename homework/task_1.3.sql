/*
Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года
'2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август,
выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

CREATE TABLE dates (
    id SERIAL PRIMARY KEY,
    created_at DATETIME
);

INSERT INTO dates VALUES
    (NULL, '2018-08-01'),
    (NULL, '2016-08-04'),
    (NULL, '2018-08-16'),
    (NULL, '2018-08-17');

CREATE TEMPORARY TABLE august_days (day SERIAL PRIMARY KEY);

INSERT INTO august_days VALUES
    (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL),
    (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL),
    (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL);

SELECT august_days.day, dates.created_at, (DAYOFMONTH(dates.created_at) <=> august_days.day) AS flag
    FROM august_days
    LEFT JOIN dates
        ON DAYOFMONTH(dates.created_at) = august_days.day;