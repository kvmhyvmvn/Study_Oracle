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

-- 10.2 CHECK 제약조건 - 값의 범위 / 도메인
-- 조건에 맞는 데이터만 저장할 수 있도록 하는 제약조건이다.
-- 컬럼 레벨, 테이블 레벨에서 정의한다.
-- 컬럼 레벨
-- 테이블 레벨
[예제 10-6]
CREATE TABLE CHECK_TEST (
    NAME VARCHAR2(10) NOT NULL,  -- 컬럼 레벨
    GENDER VARCHAR2(10) NOT NULL CHECK (GENDER IN ('남성', '여성', 'MALE', 'FEMALE', 'MAN', 'WOMAN')),
    SALARY NUMBER(8),
    DEPT_ID NUMBER(4),
    CONSTRAINT CHECK_SALARY_CK CHECK (SALARY > 2000) -- 테이블 레벨
);

-- 테이블명_컬럼명_제약조건 약어(NN: NOT NULL, CK: CHECK, PK: PRIMARY KEY, FK: FOREIGN, UK: UNIQUE KEY)

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CHECK_TEST';

[예제 10-7] 데이터를 CHECK_TEST 테이블에 삽입해보시오
INSERT INTO CHECK_TEST
VALUES ('홍길동', '남성', 3000, 10); -- GENDER, SALARY 체크 : 통과

[예제 10-9]
UPDATE CHECK_TEST
SET SALARY = 2000
WHERE NAME = '홍길동';

-- II. 테이블 생성 후 제약조건 추가/지정
[예제 10-10]
-- DDL : CREATE, ALTER, DROP
--         생성,  수정, 삭제
-- CHECK_TEST에 걸린 제약조건을 확인하고, 그런 다음 삭제했다가 다시 추가 하는 과정

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CHECK_TEST';

/*
SYS_C008366	C	"NAME" IS NOT NULL
SYS_C008367	C	"GENDER" IS NOT NULL
SYS_C008368	C	GENDER IN ('남성', '여성', 'MALE', 'FEMALE', 'MAN', 'WOMAN')
CHECK_SALARY_CK	C	SALARY > 2000
*/

-- 제거
ALTER TABLE CHECK_TEST
DROP CONSTRAINT CHECK_SALARY_CK;

-- 다시 추가
[예제 10-11]
ALTER TABLE CHECK_TEST
ADD CONSTRAINT CHECK_SALARY_DEPT_CK
    CHECK ( SALARY BETWEEN 2000 AND 10000 AND DEPT_ID IN(10, 20, 30));

SELECT *
FROM CHECK_TEST;

-- 10.3 UNIQUE 제약조건 - 중복방지 (NULL 허용)
-- 데이터가 중복되지 않도록 유일성을 보장하는 제약조건
-- 컬럼 레벨, 테이블 레벨에서 정의
-- 복합키(Composite Key)를 생성할 수 있다. 예) 보통 사번 VS 사번+이름
-- PRIMARY KEY : UNIQUE + NOT NULL

-- 테이블 생성시 UNIQUE 지정
-- I. 컬럼레벨 정의
[예제 10-13]
CREATE TABLE UNIQUE_TEST (
    COL1 VARCHAR2(5) UNIQUE NOT NULL,
    COL2 VARCHAR2(5),
    COL3 VARCHAR2(5) NOT NULL,
    COL4 VARCHAR2(5) NOT NULL,
    CONSTRAINT UNI_COL2_UK UNIQUE (COL2),
    CONSTRAINT UNI_COL34_UK UNIQUE (COL3, COL4) -- 복합키 : 둘 이상의 컬럼을 조합 ==> 사번 + 전화번호, 사번 + 이름, ...
);

[예제 10-14]
INSERT INTO UNIQUE_TEST
VALUES ('A1', 'B1', 'C1', 'D1');

INSERT INTO UNIQUE_TEST
VALUES ('A2', 'B2', 'C2', 'D2');

SELECT *
FROM UNIQUE_TEST;

COMMIT;

[예제 10-15]
UPDATE UNIQUE_TEST
SET COL1 = 'A1'
WHERE COL1 = 'A2';

[예제 10-16]
INSERT INTO UNIQUE_TEST
VALUES ('A3', '', 'C3', 'D3');

INSERT INTO UNIQUE_TEST
VALUES ('A4', NULL, 'C4', 'D4');

INSERT INTO UNIQUE_TEST
VALUES ('A5', 'B5', 'C5', 'D5');

INSERT INTO UNIQUE_TEST
VALUES ('A6', 'B6', 'C6', 'D5');

SELECT *
FROM UNIQUE_TEST;

-- II. 테이블 레벨 정의
-- 테이블 생성 후 UNIQUE 추가 / 지정: 생성 시 작성한 UNIQUE 제거 --> 추가

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'UNIQUE_TEST';

[예제 10-18] UNI_COL34_UK 제약조건을 삭제하고 COL2, COL3, COL4를 UNIQUE 복합키로 지정하는
ALTER TABLE UNIQUE_TEST
DROP CONSTRAINT UNI_COL34_UK;

ALTER TABLE UNIQUE_TEST
ADD CONSTRAINT UNI_COL234_UK UNIQUE (COL2, COL3, COL4);

SELECT *
FROM UNIQUE_TEST;

[예제 10-20]
INSERT INTO UNIQUE_TEST
VALUES ('A7', '', 'C4', 'D4');

-- 10.4 PRIMARY KEY 제약조건 - UNIQUE + NOT NULL
-- 데이터 행(ROW)을 대표하도록 유일하게 식별하기 위한 제약조건
-- UNIQUE + NOT NULL의 형태
-- 기본키, 식별자, 주 키, PK라 한다
-- 컬럼 레벨, 테이블 레벨에서 정의 *복합키*를 생성할 수 있다
-- 예) 사람 - 주민등록번호, 회사원 - 사원번호

-- I. 컬럼레벨 정의
컬럼명 데이터타입 PRIMARY KEY : 약식 --> SYS_C008XXX
컬럼명 데이터타입 CONSTRAINT 제약조건명 PRIMARY KEY --> 테이블명_컬럼명_제약조건약어

-- II. 테이블레벨 정의
CONSTRAINT 테이블명_컬럼명_제약조건약어 PRIMARY KEY (컬럼명)

[예제 10-21]
CREATE TABLE DEPT_TEST (
    DEPT_ID NUMBER(4),
    DEPT_NAME VARCHAR2(30) NOT NULL,
    CONSTRAINT DEPT_TEST_ID_PK PRIMARY KEY (DEPT_ID)
);

[예제 10-22]
INSERT INTO DEPT_TEST
VALUES (10, '영업부');

INSERT INTO DEPT_TEST
VALUES (10, '개발부');

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

[예제 10-23]
ALTER TABLE DEPT_TEST
DROP CONSTRAINT DEPT_TEST_ID_PK;

[예제 10-24]
INSERT INTO DEPT_TEST
VALUES (10, '총무부');

UPDATE DEPT_TEST SET DEPT_ID = 20
WHERE DEPT_NAME = '총무부';

[예제 10-25]
ALTER TABLE DEPT_TEST
ADD CONSTRAINT DEPT_TEST_ID_PK PRIMARY KEY(DEPT_ID);

-- 10.5 FOREIGN KEY 제약조건 - 외래키
-- 부모 테이블의 컬럼을 참조하는 자식 테이블의 컬럼에, 데이터의 무결성을 보장하기 위해 지정하는 제약조건
-- NULL 허용 <---> UNIQUE : 중복방지, NULL 허용
-- 참조키, 외래키, FK
-- 컬럼레벨, 테이블레벨에서 정의, 복합키를 생성할 수 있다
-- 컬럼명 데이터 타입 REFERENCES 부모테이블 (참조되는 컬럼명)
-- 컬럼명 데이터 타입 CONSTRAINT 제약조건명 REFERENCES 부모테이블 (참조되는 컬럼)

-- 테이블레벨에서 정의
-- CONSTRAINT 테이블명_제약조건명_제약조건약어 FOREIGN KEY (참조하는 컬럼명) REFERENCES 부모테이블 (참조되는 컬럼)
-- 테이블과 테이블의 관계에 따라서, ...
-- 사원정보테이블 <--> 부서정보테이블
-- 사원은 부서에 소속된다(=관계) N:1 일대다관계 : RDBMS에서 가장 기본적인
-- 부서는 사원을 포함한다(=관계) 1:N 다대다, [M:N] 관계 :  관계해소

[예제 10-26]
CREATE TABLE EMP_TEST (       
    EMP_ID NUMBER(4) PRIMARY KEY, -- 중복x, NULL 허용! : 유일성 보장
    ENAME VARCHAR2(30) NOT NULL, -- NULL 허용하지 않음
    DEPT_ID NUMBER(4),
    JOB_ID VARCHAR2(10),
    CONSTRAINT EMP_TEST_DEPT_FK FOREIGN KEY (DEPT_ID) REFERENCES DEPT_TEST (DEPT_ID)    
);

SELECT *
FROM DEPT_TEST;

[예제 10-27]
INSERT INTO EMP_TEST
VALUES (100, 'King', 10, 'ST_MAN');

INSERT INTO EMP_TEST
VALUES (101, 'Kong', 300, 'AC_MGR'); -- 부서테이블에 300은 존재X

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP_TEST';

[예제 10-28]
ALTER TABLE EMP_TEST
DROP CONSTRAINT EMP_TEST_DEPT_FK;

INSERT INTO EMP_TEST
VALUES (102, '총무부', 300, 'MK_REP');

[예제 10-29]
ALTER TABLE EMP_TEST
ADD CONSTRAINT EMP_TEST_JOB_FK FOREIGN KEY (JOB_ID)
                               REFERENCES JOBS (JOB_ID);

-- 계정 권한 확인

SELECT *
FROM    dict
WHERE table_name LIKE '%PRIVS%';

SELECT *
FROM    USER_ROLE_PRIVS; -- 사용자 계정 롤_권한

SELECT *
FROM    ALL_TAB_PRIVS -- 사용자 계정 롤_권한
WHERE   grantee='HANUL';

-- DEFAULT
-- 컬럼 단위로 지정되는 속성, 데이터를 입력하지 않아도 지정된 값이 기본 입력되도록 한다.
-- 제약조건은 아니지만, 컬럼 레벨에서 작성한다.

[예제 10-30]
CREATE TABLE DEFAULT_TEST (
    NAME VARCHAR2(10) NOT NULL,
    HIRE_DATE DATE DEFAULT SYSDATE NOT NULL,
    SALARY NUMBER(8) DEFAULT 2500
);

[예제 10-31]
INSERT INTO DEFAULT_TEST (NAME)
VALUES ('홍길동');

SELECT * FROM DEFAULT_TEST;
