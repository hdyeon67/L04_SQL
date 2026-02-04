SHOW DATABASES;
USE sakila;
SHOW TABLES;

SELECT
    c.first_name,
    c.last_name,
    c.email,
    a.address AS 주소,
    ct.`city` AS 도시
FROM customer AS c
    LEFT JOIN
    address AS a
    ON c.address_id = a.address_id
    LEFT JOIN
    city AS ct
    ON ct.city_id = a.city_id;

SELECT c.first_name,
    c.last_name,
    c.email,
    a.address AS 주소,
    ct.`city` AS 도시
FROM customer c
    LEFT JOIN
    address a
    ON c.address_id = a.address_id
    LEFT JOIN
    city ct
    ON ct.city_id = a.city_id
WHERE ct.city = 'London';

SELECT ct.city AS 도시, COUNT(*) AS 고객수
FROM customer c
    LEFT JOIN
    address a
    ON c.address_id = a.address_id
    LEFT JOIN
    city ct
    ON ct.city_id = a.city_id
GROUP BY ct.city
ORDER BY 고객수 DESC;

SELECT c.first_name,
    c.last_name,
    c.email,
    a.address AS 주소,
    ct.`city` AS 도시,
    con.`country` AS 국가
FROM customer c
    LEFT JOIN
    address a
    ON c.address_id = a.address_id
    LEFT JOIN
    city ct
    ON ct.city_id = a.city_id
    LEFT JOIN
    country con
    ON con.country_id = ct.country_id;

