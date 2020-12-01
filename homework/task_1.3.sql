/*
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар
закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они
выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
*/
INSERT INTO storehouses (name) VALUES ('Storehouse 1');

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
(1, 1, 0),(1, 2, 2500),(1, 3, 0),(1, 4, 30),(1, 5, 500),(1, 6, 1);

SELECT * FROM storehouses_products ORDER BY value = 0 ASC, value ASC;