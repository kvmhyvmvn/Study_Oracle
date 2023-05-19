-- 8장. DML 
-- Data Manipulation Language, 데이터를 조작하는 명령문
-- 8.1 SELECT : 데이터 조회 ===> DQL(Data Query Language) : Query 질의 --> 요청
-- 8.2 INSERT : 새 데이터를 저장하는 명령
-- 8.3 UPDATE : 기존 데이터를 변경해서 저장하는 명령
-- 8.4 DELETE : 기존 데이터 삭제하는 명령
-- ※ DML은 TCL(Transaction Control Language)와 함께 사용한다.
-- COMMIT : 데이터 조작 (메모리) ==> (물리적인 저장장치에) 반영
-- ROLLBACK : 데이터 조작        ==> 변경사항을 버림 ==> 조작 전 상태로!



-- 8.1 INSERT
-- 데이터 삽입 명령 ==> 테이블에 삽입!
INSERT INTO 테이블명 [컬럼명1, 컬럼명2, ...] -- 컬럼명 생략시, 컬럼의 순서를 지켜야 함!
VALUES (값1, 값2, ...) -- 컬럼 갯수와 값의 갯수, 타입(=자료형) / 변환함수

-- 1) 데이터를 저장할 컬럼 목록과 일대일 대응되도록 저장 값 목록을  VALUES에 나열한다.
-- 2) 저장하지 않는 컬럼값은 자동으로 NULL이 저장된다.
-- 3) 날짜 데이터는 날짜 포맷 형식(YYYY-MM-DD, RR/MM/DD..)을 사용해서 저장할 수 있다.

[예제8-1] emp 테이블에 300번 사원 이름이 'Steven', 성이 'jobs'인 사원의 정보를 오늘 날짜 기준으로 등록
-- 1. emp 테이블 생성 (컬럼명, 컬럼의 자료형, 길이값 정의) ==> DDL(Data Definition Language, 데이터 정의어)
CREATE TABLE emp(
    emp_id NUMBER,  -- emp_id라는 컬럼을 NUMBER(숫자 자료형,정수-실수) 으로 정의
    fname VARCHAR2(30),   -- fname 이라는 컬럼을 VARCHAR2(가변 문자 자료형, 30바이트 길이)로 정의
    lname VARCHAR2(20),   -- lname 이라는 컬럼을 VARCHAR2(가변 문자 자료형, 20바이트 길이)로 정의  
    hire_date DATE DEFAULT SYSDATE,   -- hire_date 컬럼은 DATE(날짜 자료형)으로 정의, 생략시 시스템의 현재날짜를 등록
    job_id  VARCHAR2(20), -- job_id라는 컬럼은 가변문자 20바이트로 정의
    salary NUMBER(9,2), -- salary 라는 컬럼은 숫자형(정수부 : 7, 소수부 : 2) 길이로 정의
    comm_pct NUMBER(3,2), -- comm_pct는 숫자형(정수부: 1, 소수부: 2)길이로 정의
    dept_id NUMBER(3)  -- dept_id는 숫자형(정수부: 3byte)
);

-- 테이블 삭제 
-- DDL : 데이터베이스 객체 생성, 삭제, 수정, 추가하는 명령어 ==> 개발자 안시킴 ==> DBA 관리자가..
DROP TABLE 테이블명;  -- 테이블, 테이블 데이터 없어짐..(자동으로 COMMIT되니까, 주의!)
-- 또는
-- 접속 > 해당 테이블 + 우클릭 > 테이블 > 삭제 [v] - 비우기~
DROP TABLE emp;
-- Table EMP이(가) 삭제되었습니다. ==> 자동으로 COMMIT!
ROLLBACK;


-- NLS 설정 : 기본 크기 (bytes* / chars)   


-- 테이블 생성후 확인하는 방법1. SQL로 질의~ 사용자 테이블에 EMP라는 테이블이 있는지?
SELECT *
FROM    user_tables  -- 사용자 계정으로 생성한 테이블들이 저장되는 테이블(객체)
WHERE   table_name='EMP';

-- 아니면, 접속 > HR 계정 선택후 새로고침 클릭!

-- 2. 데이터를 삽입
-- 2.1 테이블의 구조 조회 : desc or describe
DESC emp;

INSERT INTO emp (emp_id, fname, lname, hire_date)
VALUES (300, 'Steven', 'Jobs', SYSDATE);

SELECT *
FROM    emp;

[예제 8-2] 사번이 301이고 이름이 'Bill', 성이 'Gate'인 사원을 2013년 5월 26일자로 emp 테이블에 저장

INSERT INTO emp  -- 컬럼나열 없이 ==> 갯수, 순서순서를 지켜야함
VALUES (301, 'Bill', 'Gates', TO_DATE('2013-05-26 10:00:00','YYYY-MM-DD HH:MI:SS'), NULL, NULL, NULL, NULL);

SELECT *
FROM    emp;

-- 트랜잭션 처리 : 커밋 or 롤백
COMMIT;


INSERT INTO emp  -- 컬럼나열 없이 ==> 순서를 지켜야함
VALUES (303, 'Elon', 'Musk', TO_DATE('2015-05-26 10:00:00','YYYY-MM-DD HH:MI:SS'));

ROLLBACK;

-- p.69 컬럼 목록 없이 테이블의 모든 컬럼에 대한 저장값 목록을 VALUES 절에 나열해야 한다.
-- 빈문자열 : NULL 또는 ''를 사용해서 수동으로 NULL 저장할 수 있다.
-- NULL ==> UPDATE로 변경해서 다시 저장할 수 있다.
-- ※ 업무에서는 NULL 입력하는 게 좋다.


[예제8-3]
desc departments;
/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)
*/

SELECT *
FROM    departments;

INSERT INTO departments -- 컬럼의 수! 데이터 타입!
VALUES (300, 'Health Servces', NULL, NULL);

ROLLBACK;


[예제 8-4]
INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, salary)
VALUES (302, 'Warren', 'Buffett', SYSDATE, '',''); -- 가독성측면에서는 '' 대신 NULL로!

SELECT *
FROM    emp;

-- VALUES 절 없이 SELECT문을 사용해 서브쿼리로 테이블로부터 여러 데이터 행을 복사, 저장할 수 있다.
-- INSERT절의 저장할 컬럼 목록과 SELECT 절의 컬럼 목록의 갯수가 일치해야 한다.

INSERT INTO 테이블 [(컬럼명1, 컬럼명2,..)]  -- 2. 특정 테이블에 (그대로)삽입 (=복사)
--VALUES (값1, 값2, ...)
SELECT 컬럼명1, 컬럼명2,...    -- 1. 기존 테이블의 특정 컬럼값(=데이터) 선택해서
FROM    테이블명
WHERE   조건절;


[예제8-5] 사원테이블의 부서코드 10또는 20에 소속된 사원의 정보중 사번, 이름, 성, 입사일, 업무코드, 부서코드를 
emp 테이블에 삽입하시오!

INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, dept_id)
SELECT  employee_id, first_name, last_name, hire_date, job_id, department_id
FROM    employees
WHERE   department_id IN (10, 20);

SELECT *
FROM    emp;

-- =============================================================================================
-- ITAS : INSERT INTO ~ AS SELECT ~   // SELECT 결과를 다른 테이블에 삽입하는 명령 [DML]
-- CTAS : CREATE TABLE ~ AS SELECT ~ // SELECT 결과로 다른 테이블을 생성하는 방법(데이터 포함, 구조만)[DDL]
-- =============================================================================================

[예제8-6] 월별 급여 관리 테이블(month_salary)에 부서테이블의 부서코드 행 데이터를 삽입하시오
-- 일반 테이블 생성 방법, 데이터를 직접 삽입
/*
CREATE TABLE 테이블명 (
    컬럼명 데이터타입 제약조건,
    컬럼명 데이터타입 제약조건,
    ....계속..
);
*/
-- 데이터 입력 : 4000바이트,
CREATE TABLE month_salary (
    dept_id NUMBER(3), 
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2)
);

INSERT INTO month_salary (dept_id)
SELECT  department_id
FROM    departments
WHERE   manager_id IS NOT NULL;

SELECT *
FROM    month_salary;

ROLLBACK;


INSERT INTO month_salary (dept_id, emp_count, sum_sal, avg_sal)
SELECT  department_id, COUNT(*), SUM(salary), ROUND(AVG(salary), 2)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;

-- CTAS로 테이블 생성 방법 ==> 데이터를 생성하면서 삽입하거나 또는 구조만 복제하고 데이터는 삽입x


[예제8-7] 사원테이블에서 부서코드가 30에서 60번에 해당하는 사원들의 사번, 이름, 성, 입사일, 업무코드, 급여,
커미션율, 부서코드를 조회해서 emp 테이블에 삽입하시오

SELECT *
FROM    emp; -- 현재 6명,

INSERT INTO emp
SELECT  employee_id, first_name, last_name, hire_date, job_id, salary, commission_pct, department_id
FROM    employees
WHERE   department_id BETWEEN 30 AND 60; -- 조회된 데이터는 57명

COMMIT;

-- 예상결과 : 63명
SELECT *
FROM    emp; 



-- 8.3 데이터 변경 UPDATE
-- INSERT : 새 데이터 삽입(=저장)
-- UPDATE : 기존 데이터 변경해서 저장 (WHERE 절의 조건에 일치하는 행의 컬럼 데이터를 새로운 값으로 변경)
/*
UPDATE 테이블명
SET 컬럼명=값
WHERE   조건;
*/

-- WHERE 생략 ==>  모든 데이터 행에 영향
-- ex> 급여를 특정 사원/부서를 제한하지 않으면 모든 사원의 급여가~ 커미션이~

[예제8-8] emp 테이블에서 사번이 300번 이상인 사원의 부서코드를 20 으로 변경하시오
-- emp : 현재 300번 이상 3명 + employees 테이블 30~60번 부서원 60명 ==> 63명
SELECT *
FROM    emp;

UPDATE emp
SET dept_id = 20
WHERE   emp_id >= 300; -- 3명의 부서코드 NULL --> 20으로

ROLLBACK;

-- WHERE 절 생략시, 모든 데이터가 영향 ==> emp 테이블의 모든 사원의 부서가 20으로 변경됨
UPDATE emp
SET dept_id = 20
--WHERE   emp_id >= 300;

SELECT *
FROM    emp;

COMMIT; -- 확정

[예제8-9] 사번이 300번인 사원의 급여, 커미션율, 업무코드를 변경한다.
UPDATE emp
SET salary = 2000,
    comm_pct = 0.1,
    job_id = 'IT_PROG' -- 부서: IT , 업무포지션 : PROGRAMMER
WHERE   emp_id = 300;    
    
ROLLBACK; -- 취소


-- 서브쿼리를 사용해 데이터를 변경할 수 있다. 
-- 업무코드, 급여, 커미션율 ===> 다중 컬럼 서브쿼리 ==> UPDATE 할때 사용한다.
-- MAX() : 다중행 함수 (결과상 단일) ==> 집계함수
[예제 8-11] emp 테이블 사번 103번 사원의 급여를 employees 테이블의 20번 부서의 최대 급여로 변경한다.
-- 1. 20번 ~ 최대급여 조회
-- 2. UPDATE로 103번 사원의 급여를 변경
-- or  서브쿼리를 이용!!

UPDATE emp
SET salary = ( SELECT   MAX(salary)
               FROM     employees
               WHERE    department_id = 20 ) -- 서브쿼리
WHERE   emp_id = 103;


[예제8-12] emp 테이블 사번 180번 사원과 같은 해에 입사한 사원들의 급여를, employees 테이블 50번 부서의
평균 급여로 변경하시오

-- 해(year)
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY') AS YEAR,
        TO_CHAR(SYSDATE, 'MM') AS MONTH,
        TO_CHAR(SYSDATE, 'DD') AS DAY
FROM    dual;        

-- employees 테이블 50번 부서의 평균 급여
SELECT  AVG(salary)
FROM    employees
WHERE   department_id = 50;  -- 3475.555555555555555555555555555555555556

desc emp;

-- emp 테이블 사번 180번 사원이 입사한 해 
SELECT TO_CHAR(hire_date, 'YYYY')
FROM    emp
WHERE   emp_id = 180;   -- 2006


UPDATE emp
SET salary = ( SELECT  AVG(salary)
               FROM    employees
               WHERE   department_id = 50 )
WHERE   TO_CHAR(hire_date, 'YYYY') = ( SELECT TO_CHAR(hire_date, 'YYYY')
                                       FROM    emp
                                       WHERE   emp_id = 180 );
-- SQL 오류: ORA-01861: 리터럴이 형식 문자열과 일치하지 않음
-- hire_date가 DATE 타입 --> 180번 사원의 입사년도는 CHAR 타입 <=== 변환함수


SELECT *
FROM    emp;

-- commit : 메모리 --> (연산/반환) --> 저장장치(HDD,SSD..)에 저장됨 <===> ORACLE이 관리 <--> SQL 조회,삽입,삭제,수정..



-- [예제 8-6] ==> [예제 8.13] : 서브쿼리로 처리
-- 부서코드만 삽입, 나머지 NULL --> 각 컬럼별로 서브쿼리로 처리!!
-- month_salary2 를 만들어서, 
CREATE TABLE month_salary2 (
    dept_id NUMBER(3), 
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2)
);

-- 사원테이블에서 사원들의 소속 부서코드만 삽입
INSERT INTO month_salary2 (dept_id) -- ITAS
SELECT  department_id
FROM    employees
WHERE   department_id IS NOT NULL -- 킴벌리는 부서가 없는 사원
GROUP BY department_id;

-- month_salary2 조회
SELECT *
FROM    month_salary2;

-- UPDATE로 emp_count, sum_sal, avg_sal을 업데이트
UPDATE month_salary2 m
SET emp_count = ( SELECT COUNT(*)
                  FROM  employees e
                  WHERE e.department_id = m.dept_id
                  GROUP BY  e.department_id ),
    sum_sal = ( SELECT SUM(e.salary)
                  FROM  employees e
                  WHERE e.department_id = m.dept_id
                  GROUP BY e.department_id ),
    avg_sal = ( SELECT AVG(e.salary)
                  FROM  employees e
                  WHERE e.department_id = m.dept_id
                  GROUP BY e.department_id );
                  
-- month_salary 처럼 month_salary2를 서브쿼리로 처리
-- ※ 서브쿼리가 반복됨..WHERE절, GROUP BY 절! ==> 다중컬럼 서브쿼리로 처리하면 훨씬 간결하다!
-- 다중 컬럼 서브쿼리 ==> UPDATE 문에서 활용!

[예제 8-14] MONTH_SALARY2의 EMP_COUNT, SUM_SAL, AVG_SAL 컬럼을 다중 컬럼 서브쿼리를 활용해
EMPLOYEES의 부서별 집계된 데이터를 업데이트 (단, 급여평균은 정수로 표시)

UPDATE MONTH_SALARY2 M
SET (EMP_COUNT, SUM_SAL, AVG_SAL) = (SELECT COUNT(*), SUM(SALARY), ROUND(AVG(SALARY))
                                     FROM EMPLOYEES E
                                     WHERE E.DEPARTMENT_ID = M.DEPT_ID
                                     GROUP BY DEPARTMENT_ID
                                     );
-- 확인                                     
SELECT *
FROM    month_salary2;

-- 커밋 OR 롤백
COMMIT;

-- 8.3 데이터 삭제 DELETE
-- 테이블의 행 데이터를 삭제하는 기본 문법
-- WHERE 절의 조건에 일치하는 행 데이터를 삭제한다. (WHERE절 생략시 모든 행 데이터가 삭제됨)
/*
DELTE FROM 테이블명
WHERE 조건;
*/

[예제 8-15] EMP 테이블에서 60번 부서의 사원정보 삭제
-- 조회
SELECT *
FROM EMP
ORDER BY DEPT_ID;

-- 삭제
DELETE FROM EMP
WHERE DEPT_ID = 60; -- 5 ROWS DELETED, 58 ROWS REMAIN.

-- WHERE절 생략시 모든 데이터가 삭제되므로 주의
DELETE FROM EMP;

SELECT *
FROM EMP;

COMMIT; -- 58ROWS REMAIN



