-- Active: 1769567489382@@127.0.0.1@3306@sakila
SHOW DATABASES;
USE sakila;
SELECT DATABASE();
SHOW TABLES;

SELECT c.first_name AS 이름, c.last_name AS 성, a.address AS 주소
FROM customer AS c
    JOIN address AS a
    ON c.address_id = a.address_id;

SELECT f.title, l.name
FROM film AS f
    JOIN language AS l
    ON f.language_id = l.language_id;

DESC customer;

SELECT c.first_name AS 이름, MAX(r.rental_date) AS 대여일자
FROM customer AS c
    LEFT JOIN rental AS r
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

SELECT * FROM customer;
SELECT * FROM address;

SELECT c.first_name, c.last_name, c.email
FROM customer AS c
    JOIN address AS a
    ON c.address_id = a.address_id
WHERE a.city_id = 312;

SELECT * FROM staff;
SELECT * FROM payment;

SELECT s.first_name, COUNT(p.payment_id) AS 총결제건수
FROM staff AS s
    JOIN payment AS p
    ON s.staff_id = p.staff_id
GROUP BY s.first_name;

SELECT c.first_name, SUM(p.amount) AS 총결제액
FROM customer AS c
    JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

SELECT c.first_name, SUM(p.amount) AS 총결제액
FROM customer AS c
    JOIN payment AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING 총결제액 >= 180
ORDER BY 총결제액 DESC;
