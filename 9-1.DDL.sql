-- 9장. DDL

-- Data Definition Language, 데이터베이스 정의어

-- [-------개발자-------] [-------------- DBA(데이터베이스 관리자) ----------------]
-- 1) 테이블 생성 2) 뷰 3) 인덱스 4) 시노님(=호)  5) 클러스터... : 데이터베이스 객체
-- CREATE TABLE, CREATE VIEW, CREATE INDE, CREATE SYNONM, CREATE CLUSTER, ... - DBA
-- 9.1 데이터 타입 ==> 테이블에 컬럼 정의 자료형, 길이(Bytes)를 알아야 올바르게 생성
-- 가장 자주 사용하는 자료형
-- 1) 문자형 : 고정길이 문자형, 가변길이 문자형(=고무줄처럼 늘고 주는 방식이 아님) VARCHAR2
--       ㄴ (국가별 언어에 따른 문자형)  : NCHAR, NVARCHAR2 ==> National (국가별 --> 한국, 중국, 일본 쪽)
-- 2) 숫자형 : 정수, 실수
-- 3) 날짜형 : 날짜
-- NLS 설정에 따라 다름
-- 도구 > 환경설정 > NLS 또는
SELECT *
FROM V$NLS_PARAMETERS;

-- 문자열의 Bytes를 알려주는 함수 : LENGTHB()
SELECT LENGTHB('abc') AS ENG_CHAR,
       LENGTHB('한') AS KOR_CHAR,
       LENGTHB('宣') AS CN_CHAR
FROM DUAL;

-- 9.1.1 문자(열)형 데이터
-- 고정 길이 : CHAR(바이트 수) ==> CHAR(5) : 5 bytes 문자열 저장하는 컬럼의 길이를 정의
-- 가변 길이 : VARCHAR2(바이트 수) ==> VARCHAR2(5) :      "                 "
-- 5byte 컬럼에 3byte 입력하면 ==> 2byte 반환 X, 데이터가 저장된 곳까지 오라클이 구분하는 기호를 삽입하는 형태
-- VARCHAR : 21C 까지는 VARCHAR 타입 ==> 오라클이 나중에 사용하거나 다른 용도로 쓰기위해 예약어처럼 선점해둔 상태
-- 오라클 23C에서 변경되었는지는 아직 확실하지 않음 (23.05.19 윈도우용 23C 다운로드 링크는 아직 제공되지 않음)
-- EX> VARCHAR2(CHAR 5) : BYTE가 아닌 문자로 5자 형태 <-- 잘 쓰는 형태는 아님

-- 9.1.2 숫자형 데이터
-- NUMBER(n) : 정수 n바이트 길이로 정의
-- NUMBER(P, S) : 전체길이 P, 정수 P-S 길이, 소수 S 길이로 정의
-- NUMBER(5, 2) : 전체길이 5, 정수 3, 소수 2

-- INT 컬럼정의 ==> 오라클이 ==> VARCHAR2로 변경해버림
-- BIGINT ==> VARCHAR2
-- DOUBLE ==> NUMBER

-- 9.1.3 날짜형 데이터
-- DATE 타입, 날짜와 시각 정보를 갖는다.
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS DATE2
FROM DUAL;

-- NLS 설정상 날짜 데이터는 RRRR/MM/DD로 설정 ==> 매번 NLS 설정 변경 X, 변환함수를 활용

-- DDL : 데이터베이스 객체를 조작(생성, 수정)하는 명령어 : CREATE, ALTER, DROP, TRUNCATE
-- DDL은 자동으로 커밋으로 이루어진다 : 개발자(X) VS DBA(O)
-- TRUNC(NUMBER | DATE) : (소숫점 이하) 버리는 함수(숫자, 날짜)

/* ============ 테이블 생성 규칙 : 데이터베이스 객체 생성 규칙 =============
   1) 반드시 문자로 시작한다
   2) 문자 + 숫자 활용
   3) 최대 30바이트
   4) 오라클 예약어를 사용할 수 없다 ==> CREATE TABLE TALBE(...); -- X 
*/

-- 9.2 테이블 생성 CREATE
-- EX> 회원의 정보를 저장하는 테이블 생성
--     데이터 모델링 - 개념설계 :     사람 <-----> 이름, 연락처, 이메일, ...
--                   - 논리설계 : MEMBERS       NAME(20), PHONE(30), EMAIL(50)
--                   - 물리설계 : CREATE TABLE MEMBERS ( NAME VARCHAR2(20), ...);
-- 1. SQL 생성 : DDL
--CREATE TABLE 테이블명 (
--    컬럼명1 데이터타입,
--    컬럼명2 데이터타입,
--    ... 계속...
-- );

[예제 9-1] 3 BYTE 숫자 ID 컬럼, 20 BYTE 문자 FNAME 컬럼으로 이루어진 TMP 테이블 생성

CREATE TABLE TMP(
    ID NUMBER(3),
    FNAME VARCHAR2(30)
);

[예제 9-2] TMP 테이블에 홍길동과 이순신의 데이터를 저장
INSERT INTO TMP(ID, FNAME)
VALUES(1, '홍길동');

INSERT INTO TMP
VALUES (2, '홍길동');

SELECT *
FROM TMP2;

COMMIT;

[예제 9-3] ID가 1번인 사람의 NAME 컬럼의 데이터를 홍명보로 변경
UPDATE TMP
SET FNAME = '홍명보'
WHERE ID = 1;

-- 사용자 테이블 : 데이터베이스 객체 정보 ==> 데이터 사전, 딕셔너리 조회
SELECT *
FROM DICT -- 또는 DICTIONATY
-- WHERE TABLE_NAME LIKE 'DBA%'; -- HR 계정 : USERS 그룹

-- USER_ : 사용자 계정 / 권한
-- ALL_ : 누구나~
-- DBA_ : 관리자 계정 / 권한

-- 2. 그래픽 : 접속 > 계정명(HR) > 테이블 - 마우스 우클릭 > 테이블 > 생성..

-- =========================================================================================================
-- 키워드 AS와 서브쿼리를 사용해, 이미 있는 테이블을 참조하여 복사하는 형태로 테이블 생성 : CTAS
CREATE TABLE 테이블명 AS
SELECT 컬럼명1, 컬럼명2,...
FROM 테이블명
WHERE 조건;

[예제 9-4] 부서 테이블 데이터를 복사하여 DEPT1 테이블로 생성(=복사)한다.
CREATE TABLE DEPT1 AS
SELECT *
FROM DEPARTMENTS;

-- 조회
SELECT *
FROM DEPT1;

-- 테이블 구조, 컬럼명 | 자료형
DESC DEPT1;

[예제 9-5] 사원 테이블에서 20번 부서에 소속된 사원의 사번, 이름, 입사일 컬럼의 데이터를 복사하여 EMP20 테이블을 생성한다.

CREATE TABLE EMP20 AS
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20;

-- 조회
SELECT *
FROM EMP20;

[예제 9-6] 부서 테이블에서 데이터 없이 DEPT2 테이블을 복사하여 생성
-- 일치하는 조건의 데이터가 없는 경우 ==> DEPT2 테이블 생성 : OK, 데이터 : NO
-- CTAS의 WHERE 조건을 거짓으로!!     ==> 컬럼명, 자료형은 그대로 복제, 데이터만 없다
CREATE TABLE DEPT2 AS
SELECT *
FROM DEPARTMENTS
WHERE 1 = 2;

-- 조회
SELECT *
FROM DEPT2;

DESC DEPT2;

-- ==========================================================================================================
--                     "                        "                             테이블 데이터 저장 : ITAS                                      
-- ==========================================================================================================
CREATE TABLE 테이블명
SELECT 컬럼명1, 컬럼명2,...
FROM 테이블명
WHERE 조건;

-- 9.3 테이블 구조 변경 ALTER
-- 테이블 내에 데이터가 있을 때 ==> 삭제 불가, 삭제 없이 구조를 변경하려고 할 때

-- 9.3.1 컬럼 추가 : 데이터는 NULL 채워짐
-- 기존 테이블에 새로운 컬럼을 추가하는 형식
ALTER TABLE 테이블명
ADD (컬럼명1 자료형(길이), 컬럼명2 자료형(길이)...)

[예제 9-7] EMP20 테이블에 숫자타입 급여 컬럽(SALARY), 문자타입 업무코드(JOB_ID) 컬럼을 추가한다.
DESC EMP20;

ALTER TABLE EMP20
ADD (SALARY NUMBER, JOB_ID VARCHAR2(10));

-- 데이터 조회
SELECT *
FROM EMP20;

-- 9.3.2 컬럼 변경 (이름, 길이, 자료형, 제약조건), 데이터 유실가능성
-- 데이터 타입, 크기를 변경하는 형식
ALTER TABLE 테이블명
MODIFY (컬럼명1 데이터타입, 컬럼명2 데이터타입, ...)
-- 테이블 행이 없거나, 컬럼이 NULL 값만 포함하고 있어야 데이터 타입을 변경할 수 있다.
-- 컬럼에 저장 되어 있는 데이터의 크기 이상까지 데이터의 크기를 줄일 수 있다.

ALTER TABLE 테이블명
RENAME COLUMN 원래의 컬럼명 TO 변경될 컬럼명; -- 컬럼명만 바꾸고 싶을 때

ALTER TABLE EMP
RENAME COLUMN FNAME TO FIRST_NAME;

[예제 9-8] EMP20 테이블의 SALARY 컬럼과 JOB_ID 컬럼의 데이터 크기를 각각 변경한다.
-- 기존 : SALARY NUMBER --> NUMBER(8,2), JOB_ID VARCHAR2(5) --> 10 BYTE
ALTER TABLE EMP20
MODIFY (SALARY NUMBER(8, 2), JOB_ID VARCHAR2(10)); -- TABLE EMP20이 변경되었습니다.

-- 조회
DESC EMP20;

SELECT *
FROM EMP20;

-- 임의로 203번 사원 삽입 후 MODIFY 해보자
INSERT INTO EMP20
VALUES (203, 'Steve', SYSDATE, 10000, 'SA_MAN'); -- 1행 삽입

ALTER TABLE emp20
MODIFY  (salary NUMBER(5, 3), job_id VARCHAR2(5));
-- ORA-01440: 정도 또는 자리수를 축소할 열은 비어 있어야 합니다

-- 9.3.3 컬럼 삭제 : 데이터 유실
-- 테이블의 컬럼을 삭제하는 형식
ALTER TABLE 테이블명
DROP COLUNM 컬럼명;

[예제 9-9] EMP20 테이블의 업무코드 컬럼 JOB_ID를 삭제
ALTER TABLE EMP20
DROP COLUMN JOB_ID;

DESC EMP20;

SELECT *
FROM EMP20;

ROLLBACK; -- DDL : CREATE, ALTER, DROP, TRUNCATE --> 자동 COMMIT;

-- 9.4 테이블 삭제 DROP => 휴지통 일단 옮겨지고, 필요시 복구(=FLASH BACK)
-- 테이블의 행 데이터와 구조를 삭제하는 형식 : DROP TABLE
-- 테이블의 행 데이터만 삭제하고 구조는 남기는 형식 : TRUNCATE TABLE 테이블명;
DROP TABLE 테이블명;

DROP TABLE EMP20;
-- 접속 > 휴지통 - EMP20 플래시백 --> EMP20BACK
-- 복구시 기존 테이블명을 변경 : 이미 있는 다른 테이블과의 충돌을 방지

SELECT *
FROM EMP20BACK;

-- 복구 안되게 테이블 삭제 : 휴지통을 거치지 않고 완전히 삭제(복구 불가)
DROP TABLE 테이블명 PURGE
DROP TABLE EMP20BACK PURGE;

-- 테이블의 이름을 변경
RENAME 원래의 테이블명 TO 변경 될 테이블명;

RENAME TMP2 TO TEST; --테이블 명 변경

-- 9.5 테이블 데이터 삭제 TRUNCATE (구조는 남기고, 데이터는 비우고)
SELECT *
FROM TMP2;

TRUNCATE TABLE TMP2; -- 데이터는 지워지고, 테이블과 컬럼, 자료형의 정의는 남음

DESC TMP2;


