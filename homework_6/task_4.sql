-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей.

SELECT
    user_id,
    birth_date,
    (SELECT COUNT(target_id) FROM likes WHERE target_id = _profile.user_id AND target_type_id = 2) as likes
FROM
    profiles _profile
ORDER BY birth_date DESC LIMIT 10;