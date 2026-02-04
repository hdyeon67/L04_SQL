USE sakila;
SHOW TABLES;

#가격 정책 점검을 위한 기준 초과 상품 찾기
-- 현재 서비스에 등록된 영화 중,
-- 전체 평균 대여료보다 비싼 가격으로 책정된 영화를 찾아
-- 가격 정책 검토 대상으로 삼으려고 합니다.
 
-- 전체 영화의 평균 대여료를 기준으로,
-- 그보다 비싼 대여료를 가진 영화의 제목과 대여료를 조회하세요.
SELECT f.title AS 영화제목, f.rental_rate AS 대여료
FROM film f
WHERE
    f.rental_rate > (
        SELECT AVG(f2.rental_rate)
        FROM film f2
    );


/*특정 고객의 결제 패턴을 전체 평균과 함께 비교하기
고객 ID가 5인 고객의 결제 내역을 확인하면서,
각 결제가 전체 고객 평균 결제액 대비 어느 수준인지를 함께 보고 싶습니다.
 
해당 고객의 모든 결제 ID와 결제액을 조회하되,
전체 고객의 평균 결제액을 모든 행에 함께 표시하세요.*/
SELECT
    p.payment_id AS 결제ID, -- 결제ID
    p.amount AS 결제액, -- 결제액
    (SELECT AVG(p2.amount)
        FROM payment p2)
    AS 전체평균결제액
FROM payment p
WHERE p.customer_id = 5;

/*특정 카테고리 영화의 재고 현황 점검
‘Action’ 카테고리에 속한 영화들에 대해
현재 어떤 재고(inventory)가 존재하는지 확인하려고 합니다.
 
먼저 ‘Action’ 카테고리에 속한 영화 ID 목록을 구한 뒤,
그 영화들에 해당하는 재고 정보만 inventory 테이블에서 조회하세요.*/
SELECT
    i.inventory_id AS 재고ID, -- 재고ID
    i.film_id AS 영화ID, -- 영화ID
    i.store_id AS 매장ID -- 매장ID
FROM inventory i
WHERE i.film_id IN (
    SELECT fc.film_id
    FROM film_category fc
    JOIN category c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Action'
);  


/*특정 국가 외 지역 고객만 선별하기
마케팅 캠페인을 위해
캐나다에 거주하지 않는 고객만 따로 추출하려고 합니다.
 
캐나다에 속한 모든 도시를 기준으로,
그 도시들에 주소를 두고 있지 않은 고객의 이름을 조회하세요.*/
SELECT
    c.first_name AS 이름, -- 이름
    c.last_name AS 성 -- 성
FROM customer c
WHERE c.address_id NOT IN (
    SELECT a.address_id
    FROM address a
    JOIN city ct
    ON a.city_id = ct.city_id
    JOIN country co
    ON ct.country_id = co.country_id
    WHERE co.`country` = 'Canada'
);
SELECT
    first_name,
    last_name
FROM
    customer
WHERE
    address_id IN (
        SELECT address_id
        FROM address
        WHERE city_id NOT IN (
            SELECT city_id
            FROM city ci
            JOIN country co ON ci.country_id = co.country_id
            WHERE co.country = 'Canada'
        )
    ); 

/*고객 단위 매출 요약 리포트 생성
고객별로
지금까지의 총 결제 금액
고객당 평균 결제 금액
을 함께 계산한 뒤,
이를 고객 기본 정보와 결합하여 고객 이름 + 매출 요약 정보 형태의 리포트를 만들려고 합니다.
 
payment 테이블에서 고객별 결제 요약을 먼저 계산하고,
그 결과를 customer 테이블과 연결하여 조회하세요.*/
SELECT
    c.first_name AS 이름, -- 이름
    c.last_name AS 성, -- 성
    pm.총결제금액, -- 총결제금액
    pm.평균결제금액 -- 평균결제금액
FROM customer c
JOIN (
    SELECT
        p.customer_id,
        SUM(p.amount) AS 총결제금액, -- 총결제금액
        AVG(p.amount) AS 평균결제금액 -- 평균결제금액
    FROM payment p
    GROUP BY p.customer_id
) AS pm
ON c.customer_id = pm.customer_id;


SELECT f.film_id, f.title, f.description
FROM film AS f
    JOIN film_category AS fc
    ON f.film_id = fc.film_id
    JOIN category AS c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Action';
-- 해당 쿼리를 비연관 서브쿼리를 사용하여 작성하시오.
SELECT f.film_id, f.title, f.description
FROM film AS f
WHERE f.film_id IN (
    SELECT fc.film_id
    FROM film_category AS fc
    JOIN category AS c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Action');


/*고객별 최신 상태 요약 조회 (행마다 기준이 달라지는 경우)
운영 리포트에서
“각 고객이 가장 최근에 영화를 대여한 시점이 언제인지”
를 고객 목록과 함께 한 번에 보고 싶습니다.
 
이때는
고객 한 명 한 명마다
그 고객의 대여 기록 중 가장 최신 날짜를 찾아야 하므로
서브쿼리가 메인 쿼리의 고객 정보를 행 단위로 참조하며 실행되어야 합니다.
 
연관 서브쿼리를 사용하여
각 고객의 이름(first_name, last_name)과
해당 고객의 가장 최근 대여일(rental_date)을 조회해 보세요.*/
SELECT
    c.first_name AS 이름, -- 이름
    c.last_name AS 성, -- 성
    (
        SELECT MAX(r.rental_date)
        FROM rental r
        WHERE r.customer_id = c.customer_id
    ) AS 최신대여일 -- 최신대여일
FROM customer c;


SELECT c.first_name, c.last_name
FROM customer c
WHERE EXISTS(
        SELECT 1
        FROM rental r
        JOIN inventory i
        ON r.inventory_id = i.inventory_id
        JOIN film f
        ON i.film_id = f.film_id
        JOIN film_category fc
        ON f.film_id = fc.film_id
        JOIN category cat
        ON fc.category_id = cat.category_id
        WHERE cat.name = 'Horror'
            AND r.customer_id = c.customer_id
    );