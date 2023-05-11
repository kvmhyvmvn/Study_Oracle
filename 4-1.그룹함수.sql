-- 4장. 그룹 함수
-- 그룹 지어서, 그룹별로 데이터를 조회
-- 부서별 급여 합계, 급여 평균 조회하고자 할 때 / 합계, 평균, 최고, 최저의 통계적인 결과를 구하기 위한 함수

-- 4.1 DISTINCT
-- 중복을 제거한 결과를 반환하는 함수 --> SYSDATE처럼 파라미터가 없음
-- DISTINCT 컬럼명1, 컬럼명2, ... : 모든 컬럼에 (중복제거) 적용된다
-- NULL은 제거하지 않는다

[예제 4-1] 사원들이 소속된 부서를 조회한다.
-- DISTINCT : 중복을 포함한 결과를 보여주는 함수 (기본값 ==> 생략)
SELECT DISTINCT DEPARTMENT_ID
FROM    EMPLOYEES;

-- ALL : 중복을 포함한 결과를 보여주는 함수 (기본값 ==> 생략)
SELECT ALL department_id
FROM    employees;

-- 생략
SELECT department_id
FROM    employees;

-- DEPARTMENTS 테이블 : 27개 부서 (11개 부서에 사원이 소속, 나머지?)
/*
           부서(코드)
---------------------------------------
..
김길동     판매[10]
홍길동     총무[20]
이순신     판매[10]
강감찬     판매[10]
...
*/

[예제 4-2] 사원들이 소속된 부서와 사번을 조회한다.
-- 컬럼끼리 조합해서 중복을 제거 => _ID : 식별자 (중복되지않은 유일한 값, NULL 허용X)
SELECT DISTINCT DEPARTMENT_ID, EMPLOYEE_ID
FROM    EMPLOYEES;

-- 4.2 COUNT() : 데이터 행이 몇건 존재하는지 갯수를 세어서 반환하는 함수
-- 데이터가 NULL인 행은 제외된다.

[예제 4-3]
-- * : 애스터리스크 / 모든 행
-- 검색 속도 차이가 있다고 알려져 있음
-- 사원들은 10~110번 부서에 소속되어 있음.
SELECT COUNT (*), COUNT(EMPLOYEE_ID), COUNT(DEPARTMENT_ID),
       COUNT(DISTINCT DEPARTMENT_ID)
FROM EMPLOYEES;

-- 4.3 SUM() : 숫자 데이터 컬럼의 전체 합계를 계산하여 그 결과를 반환하는 함수
SELECT TO_CHAR(SUM(SALARY), '999,999') AS 급여총합,
       TO_CHAR(ROUND(SUM(SALARY) / COUNT(EMPLOYEE_ID), 0), '9,999') AS 급여평균
FROM EMPLOYEES;

-- 4.4 MAX() : 데이터 컬럼에서 가장 큰 값을 반환하는 함수, MIN() : 가장 작은 값을 반환하는 함수
-- 모든 데이터 유형을 사용! (숫자데이터 컬럼에만 사용하는게 아니다)
-- (월)급여
-- 연봉(12 * 월급여)
SELECT MAX(SALARY) AS 최고급여액,
       MIN(SALARY) AS 최저급여액
FROM EMPLOYEES;

[예제 4-6]
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY IN(24000, 2100);

SELECT *
FROM JOB_HISTORY;

SELECT * 
FROM JOBS;

----- 급여 : 직무와 연관성이 있다.
-- AD_PRES : 대표자
-- ST_CLERK : 재고 담당자
-- 최고금액 vs 최저금액 10배 차이의 이유?

-- MAX(), MIN() : 모든 데이터 컬럼에서 사용 가능
DESC employees;

SELECT EMPLOYEE_ID, FIRST_NAME, MAX(HIRE_DATE), MIN(HIRE_DATE), MAX(COMMISSION_PCT), MIN(COMMISSION_PCT)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;
-- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
-- 00937. 00000 -  "not a single-group group function"
-- 그룹 함수 사용하지 않고, 함께 나열한 일반 컬럼의 경우 GROUP BY절에 명시해야함.

SELECT MAX(hire_date), MIN(hire_date)
FROM    employees; -- 08/04/21 ,            01/01/13
                   -- 가장 느린 입사자,   가장 빠른 입사자

SELECT employee_id, first_name, hire_date, commission_pct, department_id
FROM    employees
WHERE   hire_date = '08/04/21';

SELECT MAX(COMMISSION_PCT), MIN(COMMISSION_PCT)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

SELECT employee_id, first_name, hire_date, commission_pct, department_id
FROM    employees
WHERE   commission_pct = 0.4;

-- 4.6 AVG() : 숫자데이터 컬럼의 평균값을 계산한 결과를 반환하는 함수

SELECT SUM(SALARY) AS 급여총액,
       ROUND(AVG(SALARY)) AS 급여평균1,
       ROUND(SUM(SALARY)/COUNT(*)) AS 급여평균2
FROM EMPLOYEES;

-- 지금까지 등장했던 SQL 구문
SELECT
FROM
WHERE
ORDER BY -- 가장 마지막에 작성한다(★)
GROUP BY

-- 4.3 GROUP BY 절 (그룹함수)
-- 1) 특정 조건을 사용하여 데이터 행을 하나의 그룹으로 나눌 수 있다.
-- 2) 그룹짓는 기준이 되는 컬럼을 지정한다.
-- 그룹함수를 사용한 컬럼과 일반 컬럼을 함께 SELECT 절에 작성할 경우,
-- GROUP BY 절을 추가해서  그룹짓는 기준 컬럼을 명시해야 '오류'가 발생하지 않음.
-- !!!SELECT 목록에 사용되는 그룹함수 이외의 컬럼은 반드시 GROUP BY 절에 명시해야 한다!!!

[예제 4-8] 부서별 <=== (부서가 기준) 급여 총액, 사원 수, 평균 급여를 조회한다.
SELECT  department_id, SUM(salary) AS 급여총액, COUNT(*) AS 사원수, ROUND(AVG(salary)) AS 평균급여
FROM    employees
GROUP BY department_id
ORDER BY 1;


[예제 4-9] 부서별, 업무별 <=== (부서가 기준) 급여 총액, 평균 급여를 조회한다.
SELECT  department_id, job_id, SUM(salary) AS 급여총액,  COUNT(*) AS 사원수, ROUND(AVG(salary)) AS 평균급여
FROM    employees
GROUP BY department_id, job_id
ORDER BY 1;

-- SELECT절에 일반컬럼, 그룹함수를 나열할때는 생략 가능 ==> GROUP BY 절에는 기준되는 컬럼을 표시해야 함!
SELECT  SUM(salary) AS 급여총액,  COUNT(*) AS 사원수, ROUND(AVG(salary)) AS 평균급여
FROM    employees
GROUP BY department_id, job_id
ORDER BY 1;

[예제 4-10] 80번 부서의 급여 총액, 평균 급여를 조회한다.
SELECT *
FROM    employees
WHERE   department_id = 80; -- 34 rows / 판매부서

SELECT department_id, department_name
FROM    departments
WHERE   department_id = 80;

-- SUM(), AVG()
-- GROUP 함수, GROUP BY 절
SELECT  department_id AS 부서코드, 
        TO_CHAR(SUM(salary), '999,999') AS 급여총액, 
        TO_CHAR(ROUND(AVG(salary)), '999,999') AS 평균급여
FROM    employees
WHERE   department_id = 80
GROUP BY department_id;

-- ======== SQL 작성 순서 ====================
-- SELECT
-- FROM
-- WHERE    -- 일반 조건절
-- GROUP BY
-- HAVING   -- 그룹함수 조건절
-- ORDER BY  -- 항상, SQL 마지막에 위치!
-- =============== SQL 작성 순서 =============

-- 4.4 HAVING 절
-- HAVING절을 사용하여 그룹을 제한한다.
-- WHERE 절에서 사용하는 조건을 HAVING 절에 사용할 수도 있으나, ==> 일반조건일때
-- 그룹함수가 포함된 조건은 HAVING 절에서만 사용할 수 있다. ==> ex> 사원수가 5인 이하인, 평균이 1000 이상인..

[예제 4-11] 80번 부서의 평균 급여를 조회한다.
SELECT  department_id, ROUND(AVG(salary), 0) AS avg_sal
FROM    employees
--WHERE   department_id = 80;   -- 8956 $
GROUP BY department_id
HAVING  department_id = 80;     -- 8956$
--ORA-00979: GROUP BY 표현식이 아닙니다.
--00979. 00000 -  "not a GROUP BY expression"

-- 부서별 사원 수 조회
-- ORA-00904: "CNT": 부적합한 식별자 : WHERE 절에 식별자 사용 x
-- ORA-00934: 그룹 함수는 허가되지 않습니다  : WHERE 절에 그룹함수 사용 x
-- WHERE 절 생략 가능!, HAVING, GROUP BY : 그룹함수와 함께 사용할때
SELECT  department_id, COUNT(*) AS cnt
FROM    employees
--WHERE   COUNT(*) <= 5
GROUP BY department_id 
HAVING  COUNT(*) <= 5
ORDER BY 1;

-- 4.5 ROLLUP, CUBE
-- 분석용 함수

-- 4.5.1 ROLLUP : GROUP BY 절에 ROLLUP 함수를 사용해  GROUP BY 구문에 의한 결과와 함께,
--                단계별 소계, 총계
-- 4.5.2 CUBE :   ROLLUP 과 같고, **모든 경우의 조합에 대한** 소계, 총계 정보를 구할 수 있다 (??)
--                ==> 출력되는 내용이 좀더? 세분화/다르게

[예제4-13] 부서별 사원수와 급여합계, (사원, 급여)총계를 조회한다.
SELECT  department_id, job_id, COUNT(*), SUM(salary)
FROM    employees
GROUP BY ROLLUP(department_id, job_id) -- 12 rows
ORDER BY 1;
