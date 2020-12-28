/*
Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT
    p.name AS product_name,
    c.name AS catalog_name
FROM
    products AS p
RIGHT JOIN
    catalogs AS c
ON
    p.catalog_id = c.id
WHERE
    p.name IS NOT NULL;