-- 정의, 조작, 제어
-- DCL (Data Control Language) - 제어 (GRANT (권한부여), REVOKE (권한삭제)
-- DML (Data Manipulation Language) - INSERT, UPDATE, DELETE, SELECT
-- CRUD ( WEB에서 기본 4가지 로직을 묶어서 CRUD라고 표현을 한다 )
-- DDL (Data Definition Language) - CREATE, ALTER, DROP (테이블 생성, 삭제, 수정)

-- JAVA (JDBC) -> (SQL) DBMS -> DB(Excel처럼 저장만 하는 창고)

SELECT 1 FROM DUAL;
-- KEY 데이터베이스 정규화 과정을 거치는데 그 때 데이터를 하나로 묶고 구분하고 할 수 있게 해주는
-- 식별자 ( 사람으로 치면 주 식별자 : 주민등록번호, 부 식별자 : 부모님의 주민등록번호 )
-- NUMBER(int), VARCHAR2(String), NVARCHAR2(String)

CREATE TABLE KHM ( -- String col1, col4; int col2;
  COL1 VARCHAR2(1000),
  COL2 NUMBER,
  COL3 VARCHAR2(1000),
  COL4 VARCHAR2(1000),
  COL5 VARCHAR2(1000)
);

-- DROP TABLE KHM;

INSERT INTO "HANUL"."KHM" (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '1', 'C', 'D', 'E');
INSERT INTO "HANUL"."KHM" (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '1', 'C', 'D', 'E');
INSERT INTO "HANUL"."KHM" (COL1, COL2, COL3, COL4, COL5) VALUES ('A', '1', 'C', 'C', 'E');

COMMIT;

-- 방금 작업한 모든 것들을 되돌리다 (ROLLBACK); ROLLBACK 또는 COMMIT을 할 때는 신중하게
-- 방금 작업한 모든 것 확정 (COMMIT);
-- 트랜잭션 : 디비 작업에 최소의 단위 : DBMS가 작업을 해놓고 확정할건지 기다리는 상태
SELECT * FROM KHM;

ROLLBACK;

UPDATE KHM SET COL1 = '상호명바꿈' WHERE COL3 = 'F';

DELETE FROM KHM;

-- DATA TYPE : NUMBER (int) , VARCHAR2 (String)
-- CREATE TABLE 테이블이름 (
-- 컬럼이름 데이터타입(크기), <- 컬럼이 여러개라면 콤마를 기준으로 컬럼 이름 데이터타입부분이 반복
-- 컬럼이름 데이터타입(크기),
-- );

ROLLBACK;
DROP TABLE KOREA_PEOPLE;
CREATE TABLE KOREA_PEOPLE (
    JUMIN_NUM NUMBER PRIMARY KEY, -- 중복되면 안되는 데이터(KEY, 식별자)를 의미함.
    NAME VARCHAR2(20),
    GENDER NUMBER
);

INSERT INTO KOREA_PEOPLE (JUMIN_NUM, NAME, GENDER) VALUES (2, '이름1', '1');

SELECT * FROM KOREA_PEOPLE;

COMMIT;

-- 내가 공공데이터 포털에서 가져온 데이터를 나의 DB에 저장하고 싶다면 어떻게 해야할까?
-- 해당 내용을 가지고 테이블을 만들고, INSERT문을 이용해 데이터를 넣어보기

CREATE TABLE COMPANY (
    CODE VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(20),
    EMPLOYEE NUMBER
);

INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('33910', '대오디자인', 1);
INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('26511', '태림전자', 4);
INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('30320', '성진', 3);
INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('20423', '스마일케이션' , 1);

SELECT * FROM COMPANY;
SELECT CODE FROM COMPANY;

ROLLBACK;
COMMIT;

DROP TABLE TBL_BOARD;

CREATE TABLE TBL_BOARD (
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(100) NOT NULL,
    BOARD_CONTENT VARCHAR2(2000) NOT NULL,
    WRITER VARCHAR2(100),
    WRITE_DATE VARCHAR2(20)
);

INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (1, 'AAA', '안녕하세요', '홍길동', '230512');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (2, 'BBB', '안녕하세요', '홍길동', '230511');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (3, 'CCC', '안녕하세요', '홍길동', '230513');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (4, 'DDD', '안녕하세요', '홍길동', '230515');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (5, 'EEE', '안녕하세요', '홍길동', '230517');

COMMIT;

SELECT * FROM TBL_BOARD;

UPDATE TBL_BOARD SET WRITER = 'KKK' WHERE WRITER = '홍길동';

DELETE FROM TBL_BOARD WHERE WRITE_DATE = '230515';

SELECT * FROM TBL_BOARD
WHERE UPPER(BOARD_TITLE) LIKE UPPER('%b2%');

SELECT BOARD_NO FROM TBL_BOARD WHERE BOARD_TITLE = 'AAA';

SELECT * FROM TBL_BOARD WHERE BOARD_TITLE LIKE '%2%' OR BOARD_CONTENT LIKE '%2%';

-- SELECT * FROM TBL_ROUND WHERE BOARD_TITLE = 'SFASDF' OR BOARD_CONTENT = 'AAF';

-- 숫자 조회를 따로 하나를 java 코드로 가져옴, => title, content 입력받아 글 insert 시킴
select max(board_no) + 1 from board;

























