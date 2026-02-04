-- SQL의 특징
-- 1) 쿼리가 끝났음을 알리는 세미콜론 ;
USE world;

SHOW TABLES;

-- (2) 대소문자 구분
SELECT *
FROM city
LIMIT 5;

select * from city limit 5;

-- 테이블명, 칼럼명은 소문자 혹은 스니이크 케이스로 사용할 것
SELECT *
FROM CITY
LIMIT 5;

-- (3) 주석
-- ctrl + / : 한줄 주석
SELECT c.Name, c.`District`, c.`Population`
FROM city AS c
WHERE c.`Population` > 10000000; -- 인구가 1000만 초과인 경우만 필터링

/* 
   여러 줄 주석
   ctrl + shift + / 
*/
SHOW TABLES;

-- (4) 정렬과 띄어쓰기
-- 공백 객수와 쿼리 값의 결과는 무관
