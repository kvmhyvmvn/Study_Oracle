-- 7장. SET 연산자

-- ================================================================================
-- 5장 JOIN 연산. 테이블(의 컬럼)을 가로로 연결하는 연산
-- 7장 SET 연산. 테이블(의 데이터/행)을 세로로 연결하는 연산
-- ================================================================================

-- SET 연산자로 묶이는 두 SELECT절은 (1) 컬럼의 수 (2) 데이터 타입이 일치해야 한다.
-- 조회되는 컬럼명은 첫번째 쿼리문의 컬럼명이 사용된다.
-- ORDER BY 모든 쿼리문의 가장 마지막에 사용한다.

-- 7.1 UNION : 합집합
-- 집합에서 합집합에 해당하는 연산자, 중복을 제거한 행의 결과를 반환한다.

[예제 7-1]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- 조회되는 컬럼명은 쿼리문의 컬럼명이 사용된다.
FROM DUAL
UNION -- 합집합 : SET 연산자
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM DUAL
UNION
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

[예제 7-2] 관리되고 있는 부서, 관리되고 있는 도시 정보 조회
SELECT DEPARTMENT_ID AS CODE, DEPARTMENT_NAME AS NAME
FROM DEPARTMENTS
UNION
SELECT LOCATION_ID, CITY
FROM LOCATIONS
UNION
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;

-- 7.2 UNION ALL : 합집합
-- UNION (중복제거) VS UNION ALL (중복포함)   /   행의 결과를 반환한다.

[예제 7-4]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- 조회되는 컬럼명은 쿼리문의 컬럼명이 사용된다.
FROM DUAL
UNION ALL -- 합집합 : SET 연산자
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM DUAL
UNION ALL
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

-- 7.3 INTERSECT : 교집합
-- 공통된 행의 결과를 반환한다.

SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- 조회되는 컬럼명은 쿼리문의 컬럼명이 사용된다.
FROM DUAL
INTERSECT -- 교집합 : SET 연산자
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- 조회되는 컬럼명은 쿼리문의 컬럼명이 사용된다.
FROM DUAL
UNION -- 교집합 : SET 연산자
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

[예제 7-7] 80번 부서와 50번 부서에 공통으로 있는 사원의 이름을 조회
SELECT FIRST_NAME AS NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
INTERSECT
SELECT FIRST_NAME AS NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT DISTINCT FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (80, 50);

-- 7.4 MINUS : 차집합
-- 집합에서 차집합에 해당하는 연산자

[예제 7-9] 80번 부서원의 이름에서 50번 부서원의 이름을 제외
-- 순수하게 80번 부서에만 존재하는 부서원의 이름
-- 공통 : Peter, John (INTERSECT 연산 결과)

-- A - B
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
MINUS
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;
