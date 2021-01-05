/* START - SELECT - Account email, full mobile number (with country code), country list */

SELECT
    acc.email,
    CONCAT('+', c.phone_code, '-', acc.mobile_phone_number) AS phone,
    c.name AS country
FROM
    accounts AS acc
LEFT JOIN
    countries AS c
ON
    acc.country_id = c.id;

/* END - SELECT */


/* START - FUNCTION - Get subscription status name by subscription 'id' */

DROP FUNCTION IF EXISTS get_subscription_status_name_by_id;
DELIMITER //
CREATE FUNCTION get_subscription_status_name_by_id (value INT)
    RETURNS TINYTEXT READS SQL DATA
BEGIN
    DECLARE status TINYTEXT;
    SET status = (SELECT name FROM subscription_statuses WHERE id = (SELECT subscription_statuses_id FROM subscriptions WHERE id = value));
    RETURN status;
end//
DELIMITER ;

SELECT get_subscription_status_name_by_id(4); /* RETURN 'Paused' */
SELECT get_subscription_status_name_by_id(9); /* RETURN 'Active' */
SELECT get_subscription_status_name_by_id(10); /* RETURN 'Payment required' */

/* END - FUNCTION */


/* START - VIEW - Content 'id', 'name', 'likes' list */

CREATE OR REPLACE VIEW content_id_name_likes_list as
    SELECT
        c.id AS content_id,
        c.name AS content_name,
        count(l.content_id) AS content_likes
    FROM
        content AS c
    INNER JOIN
        content_likes AS l
    ON
        l.content_id = c.id
    GROUP BY
        l.content_id;

SELECT * FROM content_id_name_likes_list;

/* END - VIEW */


/* START - VIEW - Content 'id', 'name', 'categories names' list */

CREATE OR REPLACE VIEW content_id_name_categories_names_list as
    SELECT
        c.id AS content_id,
        c.name AS content_name,
        GROUP_CONCAT((SELECT name FROM content_categories_list WHERE cat.category_id = id) SEPARATOR ', ') AS content_categories
    FROM
        content AS c
    RIGHT JOIN
        content_category AS cat
    ON
        cat.content_id = c.id
    GROUP BY
        cat.content_id;

SELECT * FROM content_id_name_categories_names_list;

/* END - VIEW