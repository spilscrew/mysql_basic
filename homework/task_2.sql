DROP TABLE IF EXISTS example;

CREATE DATABASE example;

CREATE TABLE example.users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

INSERT INTO example.users(name) VALUES ('Oleg');
INSERT INTO example.users(name) VALUES ('Sergey');
INSERT INTO example.users(name) VALUES ('Jekaterina');