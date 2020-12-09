/*
Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label
содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями
городов.
*/

CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    _from VARCHAR(255),
    _to VARCHAR(255)
);

INSERT INTO flights VALUES
    (NULL, 'moscow', 'omsk'),
    (NULL, 'novgorod', 'kazan'),
    (NULL, 'irkutsk', 'moscow'),
    (NULL, 'omsk', 'irkutsk'),
    (NULL, 'moscow', 'kazan');


CREATE TABLE cities (
    label VARCHAR(255),
    name VARCHAR(255)
);

INSERT INTO cities VALUES
    ('moscow', 'Москва'),
    ('irkutsk', 'Иркутск'),
    ('novgorod', 'Новгород'),
    ('kazan', 'Казань'),
    ('omsk', 'Омск');

SELECT
    f.id AS flight_id,
    c_from.name AS flight_from,
    c_to.name AS flight_to
FROM
    flights AS f
LEFT JOIN
    cities AS c_from
ON
    f._from = c_from.label
LEFT JOIN
    cities AS c_to
ON
    f._to = c_to.label;