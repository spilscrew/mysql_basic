DROP DATABASE IF EXISTS netflix_db;
CREATE DATABASE netflix_db;

USE netflix_db;


/* START - Tables */

/* Table list: accounts, profiles, subscriptions, subscriptions_statuses, subscription_plans, payment_methods, content,
content_categories_list, content_category, content_likes. */

CREATE TABLE accounts(
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,
    mobile_phone_number INT NOT NULL,
    subscription_id BIGINT UNSIGNED,
    payment_method_id BIGINT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    iso CHAR(2) NOT NULL,
    iso_3 char(3) DEFAULT NULL,
    name_uppercase VARCHAR(80) NOT NULL,
    name VARCHAR(80) NOT NULL,
    un_m49_code SMALLINT(6) DEFAULT NULL,
    phone_code INT(5) NOT NULL
);

CREATE TABLE profiles(
    id SERIAL PRIMARY KEY,
    account_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(100) NOT NULL,
    photo VARCHAR(100),
    kids_flag BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE subscriptions(
    id SERIAL PRIMARY KEY,
    account_id BIGINT UNSIGNED NOT NULL,
    subscription_plan_id BIGINT UNSIGNED,
    subscription_statuses_id BIGINT UNSIGNED NOT NULL,
    last_payment DATETIME NOT NULL,
    next_payment DATETIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE subscription_statuses(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE subscription_plans(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description JSON NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE payment_methods(
    id SERIAL PRIMARY KEY,
    account_id BIGINT UNSIGNED,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    card_number_last_four INT(4) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE content(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(250) NOT NULL,
    additional_description JSON,
    kids_flag BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE content_categories_list(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE content_category(
    content_id BIGINT UNSIGNED NOT NULL,
    category_id BIGINT UNSIGNED NOT NULL
);

CREATE TABLE content_likes(
    id SERIAL PRIMARY KEY,
    content_id BIGINT UNSIGNED NOT NULL,
    profile_id BIGINT UNSIGNED NOT NULL
);

/* END - Tables  */


/* START - INDEXES */

CREATE INDEX accounts_id_idx ON accounts(id);
CREATE INDEX accounts_email_idx ON accounts(email);

CREATE INDEX profiles_id_idx ON profiles(id);
CREATE INDEX profiles_account_id_idx ON profiles(account_id);

CREATE INDEX subscriptions_id_idx ON subscriptions(id);
CREATE INDEX subscriptions_account_id_idx ON subscriptions(account_id);

CREATE INDEX content_id_idx ON content(id);

/* END - INDEXES */


/* START - Constraints */

ALTER TABLE accounts
    ADD CONSTRAINT accounts_country_id_fk
        FOREIGN KEY (country_id) REFERENCES countries(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    ADD CONSTRAINT accounts_subscription_id_fk
        FOREIGN KEY (subscription_id) REFERENCES subscriptions(id)
            ON UPDATE CASCADE
            ON DELETE SET NULL,
    ADD CONSTRAINT accounts_payment_method_id_fk
        FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id)
            ON UPDATE CASCADE
            ON DELETE SET NULL;

ALTER TABLE profiles
    ADD CONSTRAINT profiles_account_id_fk
        FOREIGN KEY (account_id) REFERENCES accounts(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE;

ALTER TABLE subscriptions
    ADD CONSTRAINT subscriptions_account_id_fk
        FOREIGN KEY (account_id) REFERENCES accounts(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    ADD CONSTRAINT subscriptions_subscription_plan_id_fk
        FOREIGN KEY (subscription_plan_id) REFERENCES subscription_plans(id)
            ON UPDATE CASCADE
            ON DELETE RESTRICT,
    ADD CONSTRAINT subscriptions_subscription_statuses_id_fk
        FOREIGN KEY (subscription_statuses_id) REFERENCES subscription_statuses(id)
            ON UPDATE CASCADE
            ON DELETE RESTRICT;

ALTER TABLE payment_methods
    ADD CONSTRAINT payment_methods_account_id_fk
        FOREIGN KEY (account_id) REFERENCES accounts(id)
            ON UPDATE RESTRICT
            ON DELETE RESTRICT;

ALTER TABLE content_category
    ADD CONSTRAINT content_category_content_id_fk
        FOREIGN KEY (content_id) REFERENCES content(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    ADD CONSTRAINT content_category_category_id_fk
        FOREIGN KEY (category_id) REFERENCES content_categories_list(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE;

ALTER TABLE content_likes
    ADD CONSTRAINT content_likes_content_id_fk
        FOREIGN KEY (content_id) REFERENCES content(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    ADD CONSTRAINT content_category_profile_id_fk
        FOREIGN KEY (profile_id) REFERENCES profiles(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE;

/* END - Constraints */


/* START - Triggers */

DROP TRIGGER IF EXISTS accounts_subscription_id_set;
DELIMITER //
CREATE TRIGGER accounts_subscription_id_set AFTER INSERT ON subscriptions
    FOR EACH ROW
BEGIN
    UPDATE accounts SET subscription_id = NEW.id WHERE NEW.account_id = id;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS accounts_payment_method_id_set;
DELIMITER //
CREATE TRIGGER accounts_payment_method_id_set AFTER INSERT ON payment_methods
    FOR EACH ROW
BEGIN
    UPDATE accounts SET payment_method_id = NEW.id WHERE NEW.account_id = id;
END//
DELIMITER ;

/* END - Triggers */