SHOW DATABASES;

CREATE DATABASE practice;

SHOW DATABASES;

USE practice;

SHOW TABLES;

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    grade INT
)

SHOW TABLES;

DESC student;

INSERT INTO student (name, grade)
VALUES  ('홍길동', 3),
        ('김철수', 2),
        ('박병철', 1),
        ('안새싹', 3);

SELECT *
FROM student;

UPDATE student
SET grade=4
WHERE name = '안새싹';

SELECT *
FROM student;

DELETE FROM student
WHERE student_id = 2;

SELECT *
FROM student;

DROP DATABASE IF EXISTS practice;

SHOW DATABASES;