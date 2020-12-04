-- 2. Создать все необходимые внешние ключи и диаграмму отношений.

/* cities.country_id - countries.id constraint */
ALTER TABLE cities MODIFY COLUMN country_id BIGINT UNSIGNED;
ALTER TABLE cities
    ADD CONSTRAINT cities_country_id_fk
        FOREIGN KEY (country_id) REFERENCES countries(id)
            ON DELETE RESTRICT;

/* profiles.country_id  - countries.id,
   profiles.city_id - cities.id,
   profiles.status_id - user_statuses.id constraints */
ALTER TABLE profiles
    MODIFY COLUMN country_id BIGINT UNSIGNED,
    MODIFY COLUMN city_id BIGINT UNSIGNED,
    MODIFY COLUMN status_id BIGINT UNSIGNED;
ALTER TABLE profiles
    ADD CONSTRAINT profiles_country_id_fk
        FOREIGN KEY (country_id) REFERENCES countries(id),
    ADD CONSTRAINT profiles_city_id_fk
        FOREIGN KEY (city_id) REFERENCES cities(id),
    ADD CONSTRAINT profiles_status_id_fk
        FOREIGN KEY (status_id) REFERENCES user_statuses(id)
            ON DELETE SET NULL;

/* communities_users.user_id  - users.id,
   communities_users.community_id - communities.id constraints */
ALTER TABLE communities_users
    MODIFY COLUMN community_id BIGINT UNSIGNED,
    MODIFY COLUMN user_id BIGINT UNSIGNED;
ALTER TABLE communities_users
    ADD CONSTRAINT communities_community_id_fk
        FOREIGN KEY (community_id) REFERENCES communities(id)
            ON DELETE CASCADE,
    ADD CONSTRAINT communities_user_id_fk
        FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE;

/* posts.user_id  - users.id,
   posts.community_id - communities.id
   posts.media_id - media.id constraints */
ALTER TABLE posts
    MODIFY COLUMN user_id BIGINT UNSIGNED,
    MODIFY COLUMN community_id BIGINT UNSIGNED,
    MODIFY COLUMN media_id BIGINT UNSIGNED;
ALTER TABLE posts
    ADD CONSTRAINT posts_user_id_fk
        FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE,
    ADD CONSTRAINT posts_community_id_fk
        FOREIGN KEY (community_id) REFERENCES communities(id)
            ON DELETE CASCADE,
    ADD CONSTRAINT posts_media_id_fk
        FOREIGN KEY (media_id) REFERENCES media(id)
            ON DELETE SET NULL;

/* media.user_id  - users.id,
   media.media_type_id - media_types.id constraints */
ALTER TABLE media
    MODIFY COLUMN media_type_id BIGINT UNSIGNED,
    MODIFY COLUMN user_id BIGINT UNSIGNED;
ALTER TABLE media
    ADD CONSTRAINT media_media_type_id_fk
        FOREIGN KEY (media_type_id) REFERENCES media_types(id)
            ON DELETE RESTRICT,
    ADD CONSTRAINT media_user_id_fk
        FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE;

/* likes.user_id  - users.id,
   likes.target_type_id - target_types.id constraints */
ALTER TABLE likes
    MODIFY COLUMN user_id BIGINT UNSIGNED;
ALTER TABLE likes
    ADD CONSTRAINT likes_user_id_fk
        FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE,
    ADD CONSTRAINT likes_target_type_id_fk
        FOREIGN KEY (target_type_id) REFERENCES target_types(id)
            ON DELETE RESTRICT;