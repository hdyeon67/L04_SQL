SHOW DATABASES;
USE world;
SHOW TABLES;
SELECT con.`Continent` AS 대륙, con.`Name` AS 이름, con.`GNP` AS GNP
FROM country AS con
WHERE con.`Continent`
ORDER BY con.`Continent`, con.`GNP` DESC;

SELECT con.`Continent` AS 대륙, COUNT(*) AS 국가수
FROM country AS con
GROUP BY con.`Continent`
ORDER BY 국가수 DESC;

SELECT con.`Continent` AS 대륙, AVG(con.`LifeExpectancy`) AS 평균기대수명
FROM country AS con
WHERE con.`IndepYear` IS NOT NULL
GROUP BY con.`Continent`
ORDER BY 평균기대수명 DESC;

DESC city;
SELECT *
FROM city
ORDER BY city.`Population` DESC
LIMIT 10 OFFSET 10;