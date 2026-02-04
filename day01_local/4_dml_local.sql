USE lecture; --데이터베이스 지정

SHOW TABLES; -- 데이터베이스 내 테이블 목록 확인

DESCRIBE user_info; -- 테이블 요약 확인

SELECT *
FROM user_info; -- 현재 비어 있는 테이블

-- DML : 데이터 조작
-- [1] INSERT : 데이터 삽입

INSERT INTO user_info (user_id, name, email, birthday)
VALUES (101, 'alex', 'alex@example.com', '2002.01.01');

-- 입력 확인
SELECT *
FROM user_info;

-- (2) 다중행 입력
INSERT INTO user_info (user_id, name, email, birthday)
VALUES (102, 'jun', 'jun@example.com', '1996.10.30'),
        (103, 'chelsea', 'chelsea@example.com', '1990.01.20');

SELECT *
FROM user_info;
