
## USERS
DESC users;
SELECT * FROM users;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

## PROFILES
ALTER TABLE profiles ADD COLUMN photo_id INT UNSIGNED AFTER birth_date;
DESC profiles;
SELECT * FROM profiles LIMIT 10;
SELECT FLOOR(1+RAND()*100);
UPDATE profiles SET photo_id = 1+FLOOR(RAND()*100);

DROP TEMPORARY TABLE genders;
CREATE TEMPORARY TABLE genders (name CHAR(1));
INSERT INTO genders VALUES ('m'),('f');
SELECT * FROM genders;
SELECT name FROM genders ORDER BY RAND();
UPDATE profiles SET gender = ( SELECT name FROM genders ORDER BY RAND() LIMIT 1 );

SELECT * FROM user_statuses;
UPDATE profiles SET status_id = 1+FLOOR(RAND()*2);

## MESSAGES
SELECT * FROM messages;

UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at;

## MEDIA
SELECT * FROM media;
SELECT * FROM media_types;
UPDATE media_types SET created_at = NOW();
UPDATE media_types SET updated_at = NOW();

CREATE TEMPORARY TABLE extensions (name CHAR(20));
INSERT INTO extensions (name) VALUES ('jpg'),('avi'),('png'),('mp3'),('png');
UPDATE media SET filename = CONCAT( 'https://dropbox.net/vk/', filename, '.', ( SELECT name FROM extensions ORDER BY RAND() LIMIT 1 ) );
UPDATE media SET size = 1000000+FLOOR(RAND()*1000000) WHERE size < 10000;
UPDATE media SET metadata = concat('{"owner":"', ( SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id ),'"}');

ALTER TABLE media MODIFY COLUMN metadata JSON;
SELECT * FROM media;

## FRIENDSHIP
SELECT * FROM friendship;
SELECT * FROM friendship_statuses;
UPDATE friendship SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE friendship SET confirmed_at = updated_at;

## COMMUNITIES
SELECT * FROM communities;
SELECT * FROM communities_users;
ALTER TABLE communities_users ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;