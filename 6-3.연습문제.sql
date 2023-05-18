[연습문제 6-3]

1. 각 부서에 대해 부서코드, 부서명, 부서가 위치한 도시이름을 조회하는 쿼리문을
스칼라 서브쿼리로 작성한다.
-- 상호연관 서브쿼리 정의: 메인쿼리 컬럼이 서브쿼리의 조인 조건절에 사용되는--> 독립적이지 않은?
SELECT DEPARTMENT_ID, DEPARTMENT_NAME,
       (SELECT CITY
        FROM LOCATIONS L
        WHERE L.LOCATION_ID = D.LOCATION_ID) AS CITY_NAME
FROM DEPARTMENTS D;