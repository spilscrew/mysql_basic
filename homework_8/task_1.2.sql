/*
Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название
каталога name из таблицы catalogs.
*/

CREATE OR REPLACE VIEW products_catalog_name AS
    SELECT p.name AS product_name, c.name AS catalog_name
    FROM products AS p
    LEFT JOIN catalogs AS c
    ON p.catalog_id = c.id;

SELECT * FROM products_catalog_name;