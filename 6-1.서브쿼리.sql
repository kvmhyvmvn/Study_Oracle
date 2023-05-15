-- 6장. 서브쿼리

-- SQL문장 안에 존재하는 또 다른 SQL 문장을 서브쿼리라고 한다.
-- 1) 서브쿼리는 괄호(, )로 묶어서 사용한다.
-- 2) 서브쿼리가 포함된 쿼리문을 메인 쿼리라고 한다.
-- 3) 실행순서 : 서브쿼리가 먼저 실행되고 그 결과를 반환한 뒤 메인쿼리가 실행된다.


-- ORACLE, MYSQL, MSSQL : RDBMS     VS     mongoDB(atlas), firbase(google), MS Azure, Amazon AWS
-- 관계형 데이터베이스                     <CLOUD 기반의 데이터베이스> : NoSQL (관계형 데이터베이스가 아님)

-- 오라클 => 서브쿼리
-- MSSQL ==> T-SQL
-- 각종 DBMS마다 약간 다른 이름

[예제 6-1] 평균 급여보다 더 적은 급여를 받는 사원의 정보 조회
-- 1. 평균 급여를 구한다
SELECT ROUND(AVG(SALARY)) AS AVG_SAL
FROM EMPLOYEES;

--2. 평균 급여 미만을 받는 사원
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < 6462;

-- 1+2의 효과 : 서브쿼리
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT ROUND(AVG(SALARY)) AS AVG_SAL
                FROM EMPLOYEES);

-- ============== 서브 쿼리의 유형 ==============
-- 서브쿼리 실행 결과의 갯수에 따른 구분
-- 6.1 단일 행 서브쿼리 : 하나의 결과 행을 반환하는 서브쿼리
-- ㄴ 단일 행 연산자 (=, >=, >, <, <=,          <>, !=, ^=)
-- ㄴ 그룹 함수를 사용하는 경우가 많다. (AVG, SUM, COUNT, MAX, MIN)

[예제 6-2] 월 급여가 가장 많은 사원의 사번, 이름, 성 정보를 조회
-- 1. 월 급여 가장 많은 금액 조회
SELECT SALARY
FROM EMPLOYEES
ORDER BY 1 DESC; -- MAX: 24000 => 행이 여러개

SELECT MAX(SALARY) AS MAX_SAL, MIN(SALARY) AS MIN_SAL
FROM EMPLOYEES;

SELECT MIN(SALARY) AS MIN_SAL
FROM EMPLOYEES;

-- 2. 서브쿼리 작성
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY) AS MAX_SAL
                FROM EMPLOYEES);
                
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY) AS MIN_SAL
                FROM EMPLOYEES);

[예제 6-3] 사번 108번 사원의 급여보다 더 많은 급여를 받는 사원의 정보를 조회
-- 1. 서브쿼리를 사용하지 않을 때
-- 1-1. 108번 사원의 급여를 조회
-- 1-2. 전체 사원 기준 1-1에서 구한 급여와 비교해서 더 많은 급여를 받는 사원 조회
SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 108;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);
                
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <> (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);
                
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY ^= (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY != (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);
                
[예제 6-4] 월급여가 가장 많은 사원의 사번, 이름, 성, 업무제목 정보를 조회
-- EMPLOYEES : 사번, 이름, 성
-- JOBS : 업무제목(JOB_TITLE)

-- 1. 월급여 가장 큰 값 : 24000   VS   2100
SELECT MAX(salary)
FROM    employees;

SELECT MIN(salary)
FROM    employees;

-- 2. 사원의 사번, 이름, 성, 업무제목 정보
-- 2-1. 오라클 조인
-- 2-2. ANSI JOIN ==> MYSQL 사용 전제, T-SQL (MSSQL), ...

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND SALARY = (SELECT MAX(SALARY) AS MAX_SAL
              FROM EMPLOYEES);
              
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND SALARY = (SELECT MIN(SALARY) AS MIN_SAL
              FROM EMPLOYEES);

-- 6.2 다중 행 서브쿼리
-- 다중 행 연산자(IN, NOT, ANY(=SOME), ALL, EXISTS)

-- 6.2.1 IN 연산자
-- OR 연산자 대신 --> 간결
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80);

[예제 6-5] 부서(위치코드, LOCATION_ID)가 영국(UK)인 부서코드, 위치코드, 부서명 정보를 조회
-- 1. 영국의 위치코드 조회
SELECT LOCATION_ID
FROM LOCATIONS
WHERE COUNTRY_ID = 'UK';

-- 2. 서브쿼리
SELECT DEPARTMENT_ID, LOCATION_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE LOCATION_ID  = ANY (2400, 2500, 2600);


-- 6.2.2 NOT 연산자
-- 6.2.3 ANY(=SOME) 연산자
-- 6.2.4 ALL 연산자
-- 6.2.5 EXISTS 연산자



-- 6.3 다중 컬럼 서브쿼리

-- 연관성의 유무?
-- 6.4 상호연관 서브쿼리

-- 서브쿼리의 작성 위치에 따른 구분 : 보통은 WHERE절에 작성/사용
-- 6.5 스칼라 서브쿼리 : SELECT 절에 작성 / 사용
-- 6.6 인라인 뷰 서브쿼리 : FROM 절에 작성 / 사용
-- ==============================================