-- Active: 1769567489382@@127.0.0.1@3306@world
USE sakila; -- 데이터베이스 선택
SELECT DATABASE(); -- 데이터베이스 확인
SHOW TABLES; -- 테이블 목록 확인

-- 고객을 조회하시오. 
SELECT c.first_name, c.last_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE r.customer_id = c.customer_id
    AND cat.name = 'Action'
);

WITH action_customers AS (
    SELECT DISTINCT r.customer_id
    FROM rental r
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film_category fc ON i.film_id = fc.film_id
        JOIN category cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Action'
)
SELECT c.first_name, c.last_name
FROM customer c
LEFT JOIN action_customers ac
    ON c.customer_id = ac.customer_id
WHERE ac.customer_id IS NULL;



WITH heavy_renters AS (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) >= 40
),
RentedFilmsByTopCustomers AS (
    SELECT DISTINCT i.film_id
    FROM 
        rental r
        JOIN inventory i
        ON r.inventory_id = i.inventory_id
    WHERE r.customer_id IN (
        SELECT customer_id
        FROM heavy_renters
    )
)
SELECT f.title
FROM film f
JOIN RentedFilmsByTopCustomers rftc
    ON f.film_id = rftc.film_id;


SELECT c.first_name, c.last_name, CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM customer AS c

SELECT UPPER(f.title), LOWER(f.description)
FROM film AS f;

SELECT SUBSTRING_INDEX(c.email, '@', 1) AS 이메일_분리
FROM customer AS c;
SELECT SUBSTRING(c.email, 1, LOCATE('@', c.email) - 1) AS 이메일_분리
FROM customer AS c;

SELECT ROUND(p.amount, 2) AS 반올림, CEIL(p.amount) AS 올림, FLOOR(p.amount) AS 버림
FROM payment AS p
GROUP BY p.amount;

SELECT DATE(r.rental_date) AS 대여_날짜
FROM rental AS r;

SELECT DATE_FORMAT(r.rental_date, '%a') AS 요일별, COUNT(*) AS 렌탈건수, SUM(p.amount) AS 총수익
FROM rental AS r
    JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY DATE_FORMAT(r.rental_date, '%a');

SELECT r.rental_id AS 렌탈아이디, DATEDIFF(r.return_date, r.rental_date) AS 대여기간
FROM rental AS r;




SELECT c.`Name` AS 국가명, c.`Continent` AS 대륙명
FROM country AS c
WHERE c.`LifeExpectancy` IS NULL OR c.GNP IS NULL;

SELECT c.`Name` AS 국가명, c.`Continent` AS 대륙명
FROM country AS c
WHERE ISNULL(c.`LifeExpectancy`) OR ISNULL(c.GNP);


SELECT 
    c1.`Name` AS 국가명, 
    c1.`Continent` AS 대륙명,
    c1.`LifeExpectancy` AS 기대수명,
    COALESCE(c1.`LifeExpectancy`, c2.avg_le) AS 보정된기대수명
FROM country AS c1
JOIN (
    SELECT `Continent`, AVG(`LifeExpectancy`) AS avg_le
    FROM country
    GROUP BY `Continent`) AS c2
ON c1.`Continent` = c2.`Continent`;



DESC country;
SELECT
    c.`Name` AS 국가명, c.`GovernmentForm` AS 정부형태,
    CASE 
        WHEN c.`GovernmentForm` LIKE '%Republic%' THEN 'Republic' 
        ELSE c.`GovernmentForm`
    END AS 정부형태_분류
FROM country AS c;



SELECT c.`Name` AS 국가명, c.`Population` AS 인구수, c.`SurfaceArea` AS 면적,
    (c.`Population` / c.`SurfaceArea`) AS 인구밀도
FROM country AS c
WHERE c.`Population` > 0 AND c.`SurfaceArea` > 0



SELECT c.`Name` AS 국가명, c.`Continent` AS 대륙명,
    (c.`GNP` * 1000000 / c.`Population`) AS 1인당_GNP
FROM country AS c
WHERE c.`Population` > 0
ORDER BY 1인당_GNP DESC;


SELECT c.`Name` AS 국가명,
    ((ct.`Population`/c.`Population`) * 100) AS 도시인구비율
FROM country AS c
JOIN city AS ct
    ON c.`Code` = ct.`CountryCode`
WHERE c.`Population` > 0;
SELECT c.`Name` AS 국가명,
    ((ct.`Population`/c.`Population`) * 100) AS 도시인구비율
FROM country AS c
JOIN city AS ct
    ON c.`Capital` = ct.`ID`
WHERE c.`Population` > 0;

