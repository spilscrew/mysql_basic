-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
    COUNT((SELECT user_id FROM profiles WHERE user_id = _like.user_id and gender = 'm')) as male_total_likes,
    COUNT((SELECT user_id FROM profiles WHERE user_id = _like.user_id and gender = 'f')) as female_total_likes
FROM likes _like
WHERE target_type_id = 2;