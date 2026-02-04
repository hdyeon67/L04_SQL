SHOW DATABASES;
SHOW TABLES;
USE world;
DESC city;
SELECT Name, Population
From city
WHERE Population >= 8000000;

SELECT c.Name, c.CountryCode
FROM city AS c
WHERE c.CountryCode = 'KOR';

SELECT c.Name
FROM city AS c
WHERE c.Name LIKE 'San%';

SELECT c.Name
FROM city AS c
WHERE c.CountryCode = 'KOR' AND c.`Population` BETWEEN 1000000 AND 2000000;

SELECT c.Name, c.CountryCode, c.Population
FROM city AS c
WHERE c.CountryCode IN ('KOR', 'JPN', 'CHN') AND c.Population >= 5000000;


DESC city;
SELECT con.Name, con.LifeExpectancy, con.Continent
FROM country AS con
WHERE con.`Continent` = 'Oceania' AND con.`LifeExpectancy` IS NULL;

DESC country;
SELECT co.Continent AS 대륙명, SUM(co.`Population`) AS 총인구수
FROM country AS co
GROUP BY co.`Continent`;
SELECT co.Region AS 지역별, MAX(co.GNP)
FROM country AS co
GROUP BY co.`Region`;
SELECT co.`Continent` AS 대륙별, AVG(co.GNP) AS 평균GNP, AVG(co.`Population`) AS 평균인구수
FROM country AS co
GROUP BY co.`Continent`;
DESC city;
SELECT c.`District` AS 지역명, COUNT(*) AS 도시수
FROM city AS c
WHERE c.`Population` BETWEEN 500000 AND 1000000
GROUP BY c.District;

SELECT co.`Region` AS 지역명, SUM(co.GNP) AS 총GNP 
FROM country AS co
WHERE co.`Continent` = 'Asia'
GROUP BY co.`Region`;

DESC city;
SELECT c.`CountryCode` AS 도시코드, COUNT(*) AS 도시수
FROM city AS c
GROUP BY c.`CountryCode`
HAVING 도시수 >=10;

SELECT c.District AS 지역명, COUNT(*) AS 도시수, SUM(c.`Population`) AS 총인구수
FROM city AS c
GROUP BY c.`District`
HAVING AVG(c.`Population`) >= 1000000 AND 도시수 >= 3;

DESC country;
SELECT co.`Region` AS 지역명, AVG(co.`GNP`) AS 평균GNP
FROM country AS co
WHERE co.`Continent` = 'Asia'
GROUP BY co.`Region`
HAVING 평균GNP >= 1000;

SELECT co.`Continent` AS 대륙명, AVG(co.`LifeExpectancy`) AS 평균기대수명
FROM country AS co
WHERE co.`IndepYear` > 1900
GROUP BY co.`Continent`
HAVING 평균기대수명 >= 70;

SELECT c.`CountryCode` AS 국가코드, COUNT(*) AS 총도시수, SUM(c.`Population`) AS 총인구수
FROM city AS c
GROUP BY c.`CountryCode`
HAVING AVG(c.`Population`) >= 1000000 AND MIN(c.`Population`) >= 500000;