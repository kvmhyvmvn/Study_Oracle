-- ����, ����, ����
-- DCL (Data Control Language) - ���� (GRANT (���Ѻο�), REVOKE (���ѻ���)
-- DML (Data Manipulation Language) - INSERT, UPDATE, DELETE, SELECT
-- CRUD ( WEB���� �⺻ 4���� ������ ��� CRUD��� ǥ���� �Ѵ� )
-- DDL (Data Definition Language) - CREATE, ALTER, DROP (���̺� ����, ����, ����)

-- JAVA (JDBC) -> (SQL) DBMS -> DB(Exceló�� ���常 �ϴ� â��)

SELECT 1 FROM DUAL;
-- KEY �����ͺ��̽� ����ȭ ������ ��ġ�µ� �� �� �����͸� �ϳ��� ���� �����ϰ� �� �� �ְ� ���ִ�
-- �ĺ��� ( ������� ġ�� �� �ĺ��� : �ֹε�Ϲ�ȣ, �� �ĺ��� : �θ���� �ֹε�Ϲ�ȣ )
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

-- ��� �۾��� ��� �͵��� �ǵ����� (ROLLBACK); ROLLBACK �Ǵ� COMMIT�� �� ���� �����ϰ�
-- ��� �۾��� ��� �� Ȯ�� (COMMIT);
-- Ʈ����� : ��� �۾��� �ּ��� ���� : DBMS�� �۾��� �س��� Ȯ���Ұ��� ��ٸ��� ����
SELECT * FROM KHM;

ROLLBACK;

UPDATE KHM SET COL1 = '��ȣ��ٲ�' WHERE COL3 = 'F';

DELETE FROM KHM;

-- DATA TYPE : NUMBER (int) , VARCHAR2 (String)
-- CREATE TABLE ���̺��̸� (
-- �÷��̸� ������Ÿ��(ũ��), <- �÷��� ��������� �޸��� �������� �÷� �̸� ������Ÿ�Ժκ��� �ݺ�
-- �÷��̸� ������Ÿ��(ũ��),
-- );

ROLLBACK;
DROP TABLE KOREA_PEOPLE;
CREATE TABLE KOREA_PEOPLE (
    JUMIN_NUM NUMBER PRIMARY KEY, -- �ߺ��Ǹ� �ȵǴ� ������(KEY, �ĺ���)�� �ǹ���.
    NAME VARCHAR2(20),
    GENDER NUMBER
);

INSERT INTO KOREA_PEOPLE (JUMIN_NUM, NAME, GENDER) VALUES (2, '�̸�1', '1');

SELECT * FROM KOREA_PEOPLE;

COMMIT;

-- ���� ���������� ���п��� ������ �����͸� ���� DB�� �����ϰ� �ʹٸ� ��� �ؾ��ұ�?
-- �ش� ������ ������ ���̺��� �����, INSERT���� �̿��� �����͸� �־��

CREATE TABLE COMPANY (
    CODE VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(20),
    EMPLOYEE NUMBER
);

INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('33910', '���������', 1);
INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('26511', '�¸�����', 4);
INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('30320', '����', 3);
INSERT INTO COMPANY (CODE, NAME, EMPLOYEE) VALUES ('20423', '���������̼�' , 1);

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

INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (1, 'AAA', '�ȳ��ϼ���', 'ȫ�浿', '230512');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (2, 'BBB', '�ȳ��ϼ���', 'ȫ�浿', '230511');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (3, 'CCC', '�ȳ��ϼ���', 'ȫ�浿', '230513');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (4, 'DDD', '�ȳ��ϼ���', 'ȫ�浿', '230515');
INSERT INTO TBL_BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITE_DATE) VALUES (5, 'EEE', '�ȳ��ϼ���', 'ȫ�浿', '230517');

COMMIT;

SELECT * FROM TBL_BOARD;

UPDATE TBL_BOARD SET WRITER = 'KKK' WHERE WRITER = 'ȫ�浿';

DELETE FROM TBL_BOARD WHERE WRITE_DATE = '230515';

SELECT * FROM TBL_BOARD
WHERE UPPER(BOARD_TITLE) LIKE UPPER('%b2%');

SELECT BOARD_NO FROM TBL_BOARD WHERE BOARD_TITLE = 'AAA';

SELECT * FROM TBL_BOARD WHERE BOARD_TITLE LIKE '%2%' OR BOARD_CONTENT LIKE '%2%';

-- SELECT * FROM TBL_ROUND WHERE BOARD_TITLE = 'SFASDF' OR BOARD_CONTENT = 'AAF';

-- ���� ��ȸ�� ���� �ϳ��� java �ڵ�� ������, => title, content �Է¹޾� �� insert ��Ŵ
select max(board_no) + 1 from board;

























