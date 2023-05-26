-- 11장. 뷰와 시퀀스

-- 데이터베이스 용도, 권한 따라서 다름
-- 개발자 VS 데이터베이스 관리자
-- 테이블    테이블, 뷰, 함수, 시퀀스, 인덱스, 클러스터, 동의어(SYNONYM)...
-- 시퀀스
-- 트리거

-- 11.1 뷰(VIEW)
-- 뷰는 데이터가 존재하지 않는 가상 테이블 : 메모리에서 --> 쿼리를 저장했다가 실행한 결과 반환 후 소멸
-- 보안과 사용자 편의를 위해 사용한다 : 노출되면 안되는거 (HR-SALARY), 편의? 잦은 요청 --> 조인이 복잡하
-- HR 계정의 기본 뷰를 조회
SELECT *
FROM EMP_DETAILS_VIEW;

-- 실제 EMP_DETAILS_VIEW의 SQL이 저장된 사용자_뷰 정보객체
SELECT TEXT
FROM USER_VIEWS;

[예제 11-1] 80번 부서에 근무하는 사원들의 정보를 담는 V_EMP80인 뷰를 생성하시오!
-- ITAS : SELECT한 데이터를 특정 테이블에 삽입(복제)
-- CTAS : SELECT한 데이터를 저장하는 테이블을 생성(구조+데이터 복제 | 구조만)
CREATE OR REPLACE VIEW V_EMP80 AS -- 이미 있으면? REPLACE!
SELECT EMPLOYEE_ID AS EMP_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;
-- WITH READ ONLY; 읽기전용

-- Q. 뷰는 가상의 테이블 => 데이터 삽입 | 수정 | 삭제를 할 수 있는 정보객체, 그러면 뷰도 가능?
-- A. 현재는 가능! WITH READ ONLY 사용해서 VIEW 만들지 않았기 때문
-- 1. 원래 테이블에 데이터 삽입 --> 뷰에 영향?
/*
DESC employees; -- employee_id(PK), department_id(FK)
SELECT
SELECT *
FROM    jobs;
SELECT *
FROM    job_history;
SELECT *
FROM    departments;
SELECT *
FROM    employees
ORDER BY employee_id DESC;
*/

-- 홍길동 사원 등록
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY, DEPARTMENT_ID)
VALUES (207, 'Gildong', 'Hong', 'GILDONGHONG', SYSDATE, 'SA_REP', 6500, 80);

-- 홍길동 추가 됐는지 확인
SELECT *
FROM V_EMP80;

-- 결과 : 실제 테이블에 데이터 삽입 --> V_EMP80을 조회하면 추가된 데이터가 나타남

-- 2. 뷰에 데이터 삽입 --> 원래 테이블에 영향 : EMPLOYEES
-- DESC V_EMP80;
INSERT INTO V_EMP80 (EMP_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE, 'SA_REP');

-- 실제 EMPLOYEES 테이블의 필수 입력 컬럼이 V_EMP80에는 없으니까, 확인용 전체 사원 뷰 생성

CREATE OR REPLACE VIEW v_emp_all AS -- 이미 있으면? REPLACE!
SELECT  *
FROM    employees; -- View V_EMP_ALL이(가) 생성되었습니다.

-- 샘플 데이터 : 이순신 삽입
INSERT INTO v_emp_all (employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE, 'SA_REP', 6600, 80); -- 1 행 이(가) 삽입되었습니다.

-- 원래 employees 테이블에서 데이터 확인 ==> 뷰: 테이블처럼 삽입/삭제/수정할수 있구나?! VS WITH READ ONLY
SELECT *
FROM    employees
ORDER BY 1 DESC;

ROLLBACK;

-- 뷰 생성시 데이터 삽입/수정/삭제를 막으려면 WITH READ ONLY; 를 추가!


[예제11-2] v_dept 뷰를 생성 - 부서코드, 부서명, 최저급여, 최대급여, 평균급여 정보를 담고있다.
CREATE OR REPLACE VIEW v_dept AS
SELECT  d.department_id, d.department_name,
        MIN(e.salary) AS min_sal, MAX(e.salary) AS max_sal, ROUND(AVG(e.salary)) AS avg_sal
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
GROUP BY  d.department_id, d.department_name, location_id  --ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
ORDER BY 1
WITH READ ONLY;

-- DROP VIEW v_dept; -- 다시 만들게 아니라, v_dept가 컬럼만 추가|수정되면 CREATE OR REPLACE 처리!


[예제11-3]
-- EMP_DETAILS_VIEW : hr 스키마 추가할때 자동으로 생성된 뷰 <지우지마세요!>
DROP VIEW v_dept;
DROP VIEW v_emp80;
DROP VIEW v_emp_all;
-- 뷰를 지우면? 원본 테이블은 영향 x

SELECT *
FROM    employees; -- 원래 107명

-- 홍길동 : 뷰-> 데이터 삽입 -> 테이블 반영 vs WITH READ ONLY로 만들지 않아서...
DELETE FROM employees
WHERE   employee_id = 207;

--COMMIT;



/* 뷰 생성문
    CREATE [OR REPLACE] VIEW 뷰명 AS
    SELECT 이하
    
    뷰 삭제
    DROP VIEW 뷰명;
*/
/* 테이블 생성문
    CREATE TABLE 테이블명 (
        ...   
    )
    테이블 삭제
    DROP TABLE 테이블명;
*/

-- 11.2 시퀀스 (SEQUENCE)
-- 연속적인 번호의 생성이 필요한 경우 SEQUENCE를 사용하여 , 자동으로 만들어주는 기능
-- 의사컬럼 CURRVAL, NEXTVAL을 통해 조회하고 사용할 수 있다.

SELECT *
FROM    user_sequences; -- 시스템 만든 뷰 : 누구나 사용할 수 있게~

/*
DEPARTMENTS_SEQ : 부서등록 (10씩 증가 --> 9990까지)
EMPLOYEES_SEQ  : 사원등록 (1씩 증가 --> 9999999999999999999999999)
LOCATIONS_SEQ : 부서위치 등록(100씩 증가 --> 9900까지)
*/

-- 왜 시퀀스를 만들까? 데이터 입력할때마다, 특정 패턴의 값을 기억해둘 필요가 없어지므로..

/* 테이블 생성, 뷰 생성, 시퀀스 생성...거의 같아요!
   CREATE SEQUENCE 시퀀스명
   START WITH 시작값
   MAXVALUE    최대값
   INCREMENT BY 증감값
   NOCACHE | CACHE
   NOCYCLE | CYCLE
   
   테이블 삭제, 뷰 삭제, 시퀀스 삭제...같다.
   DROP SEQUENCE 시퀀스명;
   
   테이블 수정, 뷰 수정(=x), 시퀀스(=x)
   ALTER TABLE 테이블명
   MODIFY  컬러명 데이터타입(바이트수);
*/   

-- 그러면 다른 데이터베이스 객체는 또 뭐가 있나? 어떻게 만드나~ 어떻게 삭제하나!
-- 개발자 보다 데이터베이스 관리자가 도움되는 정도?!

-- 테이블을 찾는 빠른 방법?
SELECT *
FROM    ALL_TABLES -- 시스템 계정으로 생성한 뷰
WHERE   OWNER = 'HANUL';


[예제11-4] 시퀀스를 생성
CREATE SEQUENCE emp_seq
START WITH 103
MAXVALUE 9999999
MINVALUE 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- CURRVAL, NEXTVAL 통해 조회하고 사용
SELECT emp_seq.CURRVAL,
        emp_seq.NEXTVAL
FROM    dual;        

[예제11-5] emp_test에 데이터 삽입
SELECT *
FROM    emp_test;

DESC emp_test;

INSERT INTO emp_test
VALUES (emp_seq.CURRVAL - 1, 'Choi', 20, 'ST_CLERK');

-- 홍길동, 20번 부서, ''
INSERT INTO emp_test
VALUES (emp_seq.NEXTVAL, '홍길동', 20, '');


-- emp_dept_seq 생성 : 40번 부터 10씩 증가~ 최대 999999999990 까지~
CREATE SEQUENCE emp_test_dept_seq
START WITH 40
MINVALUE 10
MAXVALUE 999999999990
INCREMENT BY 10
NOCACHE
NOCYCLE;  -- Sequence EMP_TEST_DEPT_SEQ이(가) 생성되었습니다.

-- 이순신
INSERT INTO emp_test
VALUES (emp_seq.NEXTVAL, '이순신', emp_test_dept_seq.NEXTVAL, ''); -- FK 에러 vs 제약조건: 해제후 입력!

-- HANUL 계정 소유의 테이블의 제약조건 확인
SELECT *
FROM    user_constraints
WHERE   table_name = 'EMP_TEST'; -- EMP_TEST_DEPT_ID_FK

SELECT emp_test_dept_seq.NEXTVAL, emp_test_dept_seq.CURRVAL
FROM    dual; -- 제약조건을 DISABLE한 상태에서 입력

SELECT *
FROM    dept_test;

-- 테스트| 연습 |실습시 제약조건을 일시적으로 무력화 or 삭제
-- 구글 : oracle database disable constraint
-- 공식문서 : 
/*
alter table table_name
[ENABLE | DISABLE] constraint  constraint_name
*/
ALTER TABLE emp_test
DISABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST에 걸린 det_test_id_fk를 해제

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST에 걸린 det_test_id_fk를 설정 : 제약조건과 맞지 않는 값 존재
-- ORA-02298: 제약 (HANUL.EMP_TEST_DEPT_ID_FK)을 사용 가능하게 할 수 없음 - 부모 키가 없습니다
-- 외래키 제약조건 : 10,20,30 범위에 없는 230번 데이터 때문!!

SELECT *
FROM    emp_test;

-- 117번 이순신 230번 부서 --> 10~ 30중 하나로 변경 후 제약조건 ENABLE

UPDATE emp_test
SET dept_id = 30
WHERE   emp_id = 117;

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST에 걸린 det_test_id_fk를 설정

-- 제약조건 ENABLE/DISABLE : 테스트 할때 가끔 사용할 일이 있다.
-- 단, 다시 제약조건을 ENABLE 할때 테스트 하는 테이블에 제약조건과 일치하는 데이터가 있는지 확인!

COMMIT;


-- 12.오라클 데이터베이스 객체
-- 12.1 데이터 사전/데이터 딕셔너리 : 데이터베이스의 중요한 정보, 객체등을 저장하고 있는 객체
-- 오라클이라는 시스템이 사용하는 데이터 + 사용자 데이터

-- 12.2 데이터 사전 조회
SELECT *
FROM    dict;

SELECT *
FROM    dictionary;

-- 테이블, 뷰를 포함한 데이터베이스 객체 정보 : 제약조건, 인덱스, 클러스터, 시노님(=동의어), ...
-- 사실, 데이터베이스 관리자가 보는 정보
-- 사용자가 활용하는 정보가 담겨있다.

-- 조회해볼 수 있는 고유한 정보 테이블/뷰의 종류
-- 1) ALL_ 시작하는 뷰 : 권한 상관없이 누구든 조회할 수 있는 데이터
-- 2) DBA_ 시작하는 뷰 : DBA 권한이 있을때 조회
-- 3) USER_시작하는 뷰 : 접속한 계정에 포함된 데이터를 조회
-- 4) v$ 시작하는 뷰 : 오라클 데이터베이스에서 요약된,특징적인 정보를 조회

SELECT *
FROM    v$nls_parameters;

SELECT  *
FROM    all_tables
WHERE   owner = 'HANUL';

SELECT  *
FROM    all_objects
WHERE   owner = 'HANUL';

-- 12.3 데이터베이스 객체 종류
-- [참고 URL] https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/constraint.html#GUID-1055EA97-BA6F-4764-A15F-1024FD5B6DFE
-- 1) 테이블
-- 2) 뷰
-- 3) 시퀀스
-- 4) 함수 : 사용자 정의 함수 vs MAX() 있지만~ MID() 만들겠다면!  ==> 반환값이 있음
-- 5) 트리거 : 반환값이 없는 함수
-------------------- 개발자↑   DBA ↓ 까지 -----------------------------------------
-- 6) 인덱스 : 검색 성능 향상때문에
-- 7) 클러스터 :           "
-- 8) 시노님 : 객체의 또다른 이름(=별명) 생성
-- 9) 패키지 : PL/SQL로 함수나 트리거등을 한데 묶기 위해

/*
SQL vs PL/SQL - 함수, 트리거, 패키지 + 기본 프로그래밍 문법
       Procedural Language + SQL : 절차적인 프로그래밍 언어 + SQL ==> SQL에서 프로그래밍
       변수, 상수, 연산자, 족너문, 반복문, ...
       I. 익명 블럭(Anonymous Block)   /   II. 서브프로그램(Named Block)
                                               - 함수
                                               - 트리거
*/

-- 트리거 생성 : DML 처리를 위함
CREATE OR REPLACE TRIGGER 트리거명
[BEFORE | AFTER]
    INSERT OR
    UPDATE OF SALARY, DEPARTMENT_ID OR
    DELETE
    ON EMPLOYEES
BEGIN
-- 3. 아래에서 지정한 처리가 되는 PL/SQL
-- PL/SQL 실행부 : 변수, 연산자, 조건문, 반복문 ....
-- 에러처리부 : EXCEPTION 
END;

[공식문서 예제] HR 계정으로 생성
CREATE OR REPLACE TRIGGER t
  BEFORE | AFTER
    INSERT OR
    UPDATE OF salary, department_id OR
    DELETE
  ON employees
BEGIN
  CASE
    WHEN INSERTING THEN
      DBMS_OUTPUT.PUT_LINE('Inserting');
    WHEN UPDATING('salary') THEN
      DBMS_OUTPUT.PUT_LINE('Updating salary');
      -- 실제 처리 로직: 사원의 급여변경 테이블에, 변경사항을 자동으로 입력처리
      INSERT INTO salary_changes (employee_id, salary_before, salary_after, reason)
      VALUES (값,값,값,값);      
      DBMS_OUTPUT.PUT_LINE('writing slarry change OK!');
      
    WHEN UPDATING('department_id') THEN
      DBMS_OUTPUT.PUT_LINE('Updating department ID');
    WHEN DELETING THEN
      DBMS_OUTPUT.PUT_LINE('Deleting');
  END CASE;
END;
/

 employees 업데이트 --> salary 
 
 SELECT *
 FROM   employees; -- 205 Shelley 의 급여가 12008 --> 12000 으로 업데이트
 
-- DBMS_OUTPUT 패키지 : 화면에 출력하는 명령이 포함 ---> .PUT_LINE()  : 줄바꿈없이 텍스트 출력
-- SQL DEVELOPER 결과 확인 전, [보기 > DBMS 출력] 창을 선택해서 활성화 ==> + 눌러서 HR 계정 연결!
UPDATE employees
SET salary = 12000
WHERE   employee_id = 205;

-- 예제 코드에서는 단순 출력 메시지만,
-- 실제로는 특정 테이블에 변경사항을 추가 입력, 기록 용도로 활용
-- ex> 주문 테이블 : 상품의 재고를 자동으로 변경   vs   개발자 직접 재고를 업데이트 해야함!
-- ※SQLPLUS 확인하려면? SET SERVEROUTPUT ON | OFF;

DROP TRIGGER t;


-- 12.4 생성/삭제/변경
-- CREATE 구문
-- ALTER 구문
-- DROP 구문

ROLLBACK;