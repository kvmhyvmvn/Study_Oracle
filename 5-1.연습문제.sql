[연습문제 5-1]

1. 이름에 소문자 v가 포함된 모든 사원의 사번, 이름, 부서명을 조회하는 쿼리문을 작성한다.
-- 문자 패턴 검색 : LIKE, %, _
-- 대소문자 구분
-- 사원정보 테이블 + 부서 정보 테이블

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+) -- 오라클 아우터 조인
AND E.FIRST_NAME LIKE '%v%';

2. 커미션을 받는 사원의 사번, 이름, 급여, 커미션 금액, 부서명을 조회하는 쿼리문을 작성한다.
(단, 커미션 금액은 월급여에 대한 커미션 금액을 나타낸다)
-- COMMISSION_PCT : NULL (판매부서가 아닌 사원들)
-- NULL 처리 : 비교대상 X => NVL(), NVL2()
-- 커미션 금액 : SALARY * COMMISSION_PCT
-- 커미션 받는 사원 : 35명(1명이 부서가 없지만)

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.COMMISSION_PCT * E.SALARY AS COMM_PCT, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND E.COMMISSION_PCT IS NOT NULL;

3. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명을 조회하는 쿼리문을 작성한다.
-- 기준 테이블 : 부서정보 테이블(부서코드, 부서명, 위치코드)
-- 대상테이블 : 위치 테이블(도시명, 국가코드), 국가정보 테이블(국가명)

SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID,
       L.CITY, L.COUNTRY_ID, C.COUNTRY_NAME
FROM DEPARTMENTS D, LOCATIONS L, COUNTRIES C
WHERE D.LOCATION_ID = L.LOCATION_ID
AND   L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY 1;


4. 사원의 사번, 이름, 업무코드, 매니저의 사번, 매니저의 이름, 매니저의 업무코드를 조회하여
사원의 사번 순서로 정렬하는 쿼리문을 작성한다.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID,
       M.EMPLOYEE_ID AS MANAGER_ID, M.FIRST_NAME AS MANAGER_NAME, M.JOB_ID AS JOB_ID
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID; -- 106 ROWS, 사장님 : MANAGER_ID IS NULL

5. 모든 사원의 사번, 이름, 부서명, 도시명, 도로주소 정보를 조회하여 사번 순으로 정렬하는
쿼리문을 작성한다.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY, L.STREET_ADDRESS
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND   D.LOCATION_ID = L.LOCATION_ID(+)
ORDER BY 1;
