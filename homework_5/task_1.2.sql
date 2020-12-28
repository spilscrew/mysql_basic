/*
Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое
время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые
ранее значения.
 */

UPDATE users SET updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %H:%i");
UPDATE users SET created_at = STR_TO_DATE(created_at, "%d.%m.%Y %H:%i");
ALTER TABLE users MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;