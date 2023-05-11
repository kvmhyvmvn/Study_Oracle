-- 5장. JOIN(연산)
-- 오라클 관계형 데이터베이스이다 ==> 관계 : 테이블과 테이블이 맺는!
-- (Relation, 릴레이션 - 데이터베이스 설계할 때 테이블을 릴레이션이라고 함0
-- JOIN 여러 테이블을 연결하여 (HR : 7개, 업무 : n)
-- ex> 사원 테이블 ~ 부서 테이블 연결 : 사원정보에 부서정보(부서이름, 부서위치코드)를 조회할 때

-- 5.1 Cartesian Product (Decart의 다른 말, Cartesian)
-- JOIN 조건 : 둘 이상의 테이블의 관계를 맺을 때, 기준이 되는 컬럼을 지정 ==> 보통, WHERE절에 기술
-- JOIN 조건을 기술하지 않을 때 잘못된 결과가 발생하는데, 이걸 카테시안 곱(=합성곱)이라고 함
-- 오류는 안남 ==> 예측되는 데이터 보다 많다면 의심

/*
SELECT 컬럼명1, 컬럼명2, ...
FROM 테이블명1, 테이블명2, ...
WHERE JOIN 조건(=비교)
*/

[예제 5-1] 사원 테이블과 부서 테이블을 이용해 사원의 정보를 조회하고자 한다. 사번, 성, 부서 이름을 조회
-- 사번, 성 : EMPLOYEES (사원 정보 테이블 : 사번, 이름, 사원급여, 입사일,...)
-- 부서이름 : DEPARTMENTS (부서 정보 테이블 : 부서코드, 부서가 위치한 지역코드)

-- 사원테이블 데이터/행 수 : 107
-- 부서테이블 데이터/행 수 : 27
-- 카테시안 곱 : 2889 ROWS ==> 107 * 27

SELECT 107 * 27
FROM DUAL;

DESC EMPLOYEES;
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    
*/

DESC DEPARTMENTS;
/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)   
*/

-- 5.2 EQUI JOIN : 동등연산자(=)를 사용해 JOIN 연산(=동등 조인)

-- 두 테이블의 공통 컬럼 : DEPARTMENT_ID (MANAGER_ID : 부서테이블의 식별자X)
-- 전체 사원은 107명, 조회된 결과 106건 <---> 1명의 누락
-- 테이블을 이용한 JOIN ==> 어느 테이블에 어떤 컬럼인지를 명시!

[예제 5-2]
SELECT EMP.EMPLOYEE_ID, EMP.LAST_NAME, -- 주된 내용을 조회하려는 테이블의 컬럼
        DEPT.DEPARTMENT_NAME -- 부가적인 정보
FROM EMPLOYEES EMP, DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID; -- 기준테이블.공통컬럼 = 대상테이블.공통컬럼;

[예제 5-3] 테이블의 ALIAS를 적용
SELECT EMP.EMPLOYEE_ID, EMP.LAST_NAME,
        DEPT.DEPARTMENT_NAME
FROM EMPLOYEES EMP, DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID;

[예제 5-4] 사원테이블, 업무테이블을 이용해 사번, 이름, 업무코드, 업무제목 정보를 조회
DESC JOBS;

SELECT E.EMPLOYEE_ID, E.FIRST_NAME||' '||E.LAST_NAME NAME, E.JOB_ID,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
ORDER BY 1;

-- 1) 사원 ~ 부서 : 조인조건 1개
-- 2) 사원 ~ 업무 : 조인조건 1개
-- 3) 사원 ~ 부서 ~ 업무 ~ 도시 ~ 나라(국가) ~ 대륙
-- => JOIN하는 테이블의 갯수 -1 : 조인조건의 갯수

-- JOIN 하는 대상 테이블이 추가되면, JOIN 조건을 추가한다.

[예제 5-5] 사원테이블, 부서테이블, 업무테이블을 이용해 사번, 이름, 부서명, 업무제목 정보를 조회
-- EMPLOYEES, DEPARTMENTS, JOBS
-- 사원정보, 부서정보, 업무정보
--      DEPARTMENT_ID

SELECT E.EMPLOYEE_ID AS 사번, E.FIRST_NAME||' '||E.LAST_NAME NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM   EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID -- 1명이 부서코드 X
AND    E.JOB_ID = J.JOB_ID
ORDER BY 1;

-- 5.3 NON-EQUI JOIN

-- 5.4 OUTER JOIN

-- 5.5 SELF JOIN

-- 5.6 ANSI JOIN /  ANSI 협회에서 만든 표준 JOIN식(ORACLE외에도 MYSQL, CUBRID, 기타 DBMS 공통 JOIN)

-- 5.7 OUTER JOIN