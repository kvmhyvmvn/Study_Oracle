-- 10장. 제약조건

-- 무결성 제약조건(Intergrity Constraints) : 데이터의 정확성을 보장하기 위해 두는 제약/제한 조건
-- 1) 테이블 생성시 정의 : CREATE TABLE ~
-- 2) 테이블 생성 후 추가 : ALTER TABLE ~

-- 10.1 NOT NULL 제약조건 - NULL 허용하지 않음 : 
-- 컬럼의 데이터 값에 있어 NULL 허용하지 않음 ==> 반드시 데이터를 입력해야 한다
-- * 테이블 생성시 컬럼 레벨에서 정의한다
-- EX> 테이블 생성 구문
CREATE TABLE 테이블명 (
    컬럼명1 데이터타입(길이) 제약조건, -- 컬럼 레벨
    컬럼명2 데이터타입(길이),
    ...계속...
);

CREATE TABLE USER(
    ID VARCHAR2(20) NOT NULL, -- 컬럼 레벨
    NICK VARCHAR2(20) ,
    ...계속...
);

[예제 10-1] NULL_TEST라는 테이블을 생성하되 컬럼은 COL1 문자타입 5바이트 길이, NULL 허용하지않고,
COL2 문자타입 5바이트 길이로 정의

-- 1) 테이블 생성 : NULL_TEST + NOT NULL
CREATE TABLE NULL_TEST (
    COL1 VARCHAR2(5) NOT NULL, -- 컬럼 레벨
    COL2 VARCHAR2(5) -- 제약 조건 X ==> NULL 허용
);

INSERT INTO NULL_TEST (COL1)
VALUES ('AA'); -- AA | (NULL)

SELECT *
FROM NULL_TEST;

[예제 10-3] BB를 COL2에 삽입
INSERT INTO NULL_TEST (COL2)
VALUES ('BB'); -- COL1 NOT NULL 제약조건
-- ORA-01400: NULL을 ("HR"."NULL_TEST"."COL1") 안에 삽입할 수 없습니다

-- 2) 테이블 생성 후 NOT NULL 지정
-- 컬럼에 NULL 데이터가 없는 경우, NOT NULL을 추가할 수 있다.

-- NULL_TEST에 이미 BB가 COL2 컬럼에 있는 상태
UPDATE NULL_TEST
SET COL2 = 'BB'; -- COL2 컬럼의 데이터를 NULL에서 'BB'로 변경

SELECT *
FROM NULL_TEST;

[예제 10-4]
ALTER TABLE NULL_TEST
MODIFY (COL2 NOT NULL); -- 제약 조건 추가

[예제 10-5] COL2를 NULL로 바꾸어보면 ==> 제약조건이 추가되었으니, 오류발생
-- COL2에 NOT NULL이 추가 ==> 데이터를 NULL
UPDATE NULL_TEST
SET COL2 = NULL; -- 에러발생

-- 다시 COL2 컬럼에 NULL 허용
ALTER TABLE NULL_TEST
MODIFY (COL2 NULL); -- COL1, COL2 모두 데이터가 있다 <---> NULL이 아니므로

UPDATE NULL_TEST
SET COL2 = NULL;

COMMIT;
-- ===================================================================================================================
-- 데이터 사전
SELECT *
FROM DICT; -- 계정 권한에 따라서 보이지않는 객체 ==> SYS나 SYSTEM으로 조회하면 모두 찾을 수 있음

-- ============= 사용자 계정으로 생성된 (테이블의) 제약 조건이 모두 기록된 별도의 테이블 객체 : 오라클 관리 ==============
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'NULL_TEST'; -- 생성시 COL1 NOT NULL, 생성 후 추가 COL2 NOT NULL

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEES';

-- 10.2 CHECK 제약조건 - 값의 범위 : Check
-- 10.3 UNIQUE 제약조건 - 중복방지 (NULL 허용)
-- 10.4 PRIMARY KEY 제약조건 - UNIQUE + NOT NULL
-- 10.5 FOREIGN KEY 제약조건 - 외래키

