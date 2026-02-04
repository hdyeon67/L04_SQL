USE world;
SHOW TABLES;WITH CityRanking AS (
    SELECT ct.`CountryCode`, ct.`Name` AS city_name, ct.`Population`,
        ROW_NUMBER() OVER (PARTITION BY ct.`CountryCode` ORDER BY ct.`Population` DESC) AS ranking
    FROM city AS ct
)
SELECT cr.`CountryCode`, cr.city_name, cr.`Population`
FROM `CityRanking` AS cr
WHERE cr.ranking <= 5
ORDER BY cr.`CountryCode`, cr.`Population` DESC;