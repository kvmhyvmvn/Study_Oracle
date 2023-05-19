-- 9��. DDL

-- Data Definition Language, �����ͺ��̽� ���Ǿ�

-- [-------������-------] [-------------- DBA(�����ͺ��̽� ������) ----------------]
-- 1) ���̺� ���� 2) �� 3) �ε��� 4) �ó��(=ȣ)  5) Ŭ������... : �����ͺ��̽� ��ü
-- CREATE TABLE, CREATE VIEW, CREATE INDE, CREATE SYNONM, CREATE CLUSTER, ... - DBA
-- 9.1 ������ Ÿ�� ==> ���̺� �÷� ���� �ڷ���, ����(Bytes)�� �˾ƾ� �ùٸ��� ����
-- ���� ���� ����ϴ� �ڷ���
-- 1) ������ : �������� ������, �������� ������(=����ó�� �ð� �ִ� ����� �ƴ�) VARCHAR2
--       �� (������ �� ���� ������)  : NCHAR, NVARCHAR2 ==> National (������ --> �ѱ�, �߱�, �Ϻ� ��)
-- 2) ������ : ����, �Ǽ�
-- 3) ��¥�� : ��¥
-- NLS ������ ���� �ٸ�
-- ���� > ȯ�漳�� > NLS �Ǵ�
SELECT *
FROM V$NLS_PARAMETERS;

-- ���ڿ��� Bytes�� �˷��ִ� �Լ� : LENGTHB()
SELECT LENGTHB('abc') AS ENG_CHAR,
       LENGTHB('��') AS KOR_CHAR,
       LENGTHB('�') AS CN_CHAR
FROM DUAL;

-- 9.1.1 ����(��)�� ������
-- ���� ���� : CHAR(����Ʈ ��) ==> CHAR(5) : 5 bytes ���ڿ� �����ϴ� �÷��� ���̸� ����
-- ���� ���� : VARCHAR2(����Ʈ ��) ==> VARCHAR2(5) :      "                 "
-- 5byte �÷��� 3byte �Է��ϸ� ==> 2byte ��ȯ X, �����Ͱ� ����� ������ ����Ŭ�� �����ϴ� ��ȣ�� �����ϴ� ����
-- VARCHAR : 21C ������ VARCHAR Ÿ�� ==> ����Ŭ�� ���߿� ����ϰų� �ٸ� �뵵�� �������� �����ó�� �����ص� ����
-- ����Ŭ 23C���� ����Ǿ������� ���� Ȯ������ ���� (23.05.19 ������� 23C �ٿ�ε� ��ũ�� ���� �������� ����)
-- EX> VARCHAR2(CHAR 5) : BYTE�� �ƴ� ���ڷ� 5�� ���� <-- �� ���� ���´� �ƴ�

-- 9.1.2 ������ ������
-- NUMBER(n) : ���� n����Ʈ ���̷� ����
-- NUMBER(P, S) : ��ü���� P, ���� P-S ����, �Ҽ� S ���̷� ����
-- NUMBER(5, 2) : ��ü���� 5, ���� 3, �Ҽ� 2

-- INT �÷����� ==> ����Ŭ�� ==> VARCHAR2�� �����ع���
-- BIGINT ==> VARCHAR2
-- DOUBLE ==> NUMBER

-- 9.1.3 ��¥�� ������
-- DATE Ÿ��, ��¥�� �ð� ������ ���´�.
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS DATE2
FROM DUAL;

-- NLS ������ ��¥ �����ʹ� RRRR/MM/DD�� ���� ==> �Ź� NLS ���� ���� X, ��ȯ�Լ��� Ȱ��

-- DDL : �����ͺ��̽� ��ü�� ����(����, ����)�ϴ� ��ɾ� : CREATE, ALTER, DROP, TRUNCATE
-- DDL�� �ڵ����� Ŀ������ �̷������ : ������(X) VS DBA(O)
-- TRUNC(NUMBER | DATE) : (�Ҽ��� ����) ������ �Լ�(����, ��¥)

/* ============ ���̺� ���� ��Ģ : �����ͺ��̽� ��ü ���� ��Ģ =============
   1) �ݵ�� ���ڷ� �����Ѵ�
   2) ���� + ���� Ȱ��
   3) �ִ� 30����Ʈ
   4) ����Ŭ ���� ����� �� ���� ==> CREATE TABLE TALBE(...); -- X 
*/

-- 9.2 ���̺� ���� CREATE
-- EX> ȸ���� ������ �����ϴ� ���̺� ����
--     ������ �𵨸� - ���伳�� :     ��� <-----> �̸�, ����ó, �̸���, ...
--                   - ������ : MEMBERS       NAME(20), PHONE(30), EMAIL(50)
--                   - �������� : CREATE TABLE MEMBERS ( NAME VARCHAR2(20), ...);
-- 1. SQL ���� : DDL
--CREATE TABLE ���̺�� (
--    �÷���1 ������Ÿ��,
--    �÷���2 ������Ÿ��,
--    ... ���...
-- );

[���� 9-1] 3 BYTE ���� ID �÷�, 20 BYTE ���� FNAME �÷����� �̷���� TMP ���̺� ����

CREATE TABLE TMP(
    ID NUMBER(3),
    FNAME VARCHAR2(30)
);

[���� 9-2] TMP ���̺� ȫ�浿�� �̼����� �����͸� ����
INSERT INTO TMP(ID, FNAME)
VALUES(1, 'ȫ�浿');

INSERT INTO TMP
VALUES (2, 'ȫ�浿');

SELECT *
FROM TMP2;

COMMIT;

[���� 9-3] ID�� 1���� ����� NAME �÷��� �����͸� ȫ���� ����
UPDATE TMP
SET FNAME = 'ȫ��'
WHERE ID = 1;

-- ����� ���̺� : �����ͺ��̽� ��ü ���� ==> ������ ����, ��ųʸ� ��ȸ
SELECT *
FROM DICT -- �Ǵ� DICTIONATY
-- WHERE TABLE_NAME LIKE 'DBA%'; -- HR ���� : USERS �׷�

-- USER_ : ����� ���� / ����
-- ALL_ : ������~
-- DBA_ : ������ ���� / ����

-- 2. �׷��� : ���� > ������(HR) > ���̺� - ���콺 ��Ŭ�� > ���̺� > ����..

-- =========================================================================================================
-- Ű���� AS�� ���������� �����, �̹� �ִ� ���̺��� �����Ͽ� �����ϴ� ���·� ���̺� ���� : CTAS
CREATE TABLE ���̺�� AS
SELECT �÷���1, �÷���2,...
FROM ���̺��
WHERE ����;

[���� 9-4] �μ� ���̺� �����͸� �����Ͽ� DEPT1 ���̺�� ����(=����)�Ѵ�.
CREATE TABLE DEPT1 AS
SELECT *
FROM DEPARTMENTS;

-- ��ȸ
SELECT *
FROM DEPT1;

-- ���̺� ����, �÷��� | �ڷ���
DESC DEPT1;

[���� 9-5] ��� ���̺��� 20�� �μ��� �Ҽӵ� ����� ���, �̸�, �Ի��� �÷��� �����͸� �����Ͽ� EMP20 ���̺��� �����Ѵ�.

CREATE TABLE EMP20 AS
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20;

-- ��ȸ
SELECT *
FROM EMP20;

[���� 9-6] �μ� ���̺��� ������ ���� DEPT2 ���̺��� �����Ͽ� ����
-- ��ġ�ϴ� ������ �����Ͱ� ���� ��� ==> DEPT2 ���̺� ���� : OK, ������ : NO
-- CTAS�� WHERE ������ ��������!!     ==> �÷���, �ڷ����� �״�� ����, �����͸� ����
CREATE TABLE DEPT2 AS
SELECT *
FROM DEPARTMENTS
WHERE 1 = 2;

-- ��ȸ
SELECT *
FROM DEPT2;

DESC DEPT2;

-- ==========================================================================================================
--                     "                        "                             ���̺� ������ ���� : ITAS                                      
-- ==========================================================================================================
CREATE TABLE ���̺��
SELECT �÷���1, �÷���2,...
FROM ���̺��
WHERE ����;

-- 9.3 ���̺� ���� ���� ALTER
-- ���̺� ���� �����Ͱ� ���� �� ==> ���� �Ұ�, ���� ���� ������ �����Ϸ��� �� ��

-- 9.3.1 �÷� �߰� : �����ʹ� NULL ä����
-- ���� ���̺� ���ο� �÷��� �߰��ϴ� ����
ALTER TABLE ���̺��
ADD (�÷���1 �ڷ���(����), �÷���2 �ڷ���(����)...)

[���� 9-7] EMP20 ���̺� ����Ÿ�� �޿� �÷�(SALARY), ����Ÿ�� �����ڵ�(JOB_ID) �÷��� �߰��Ѵ�.
DESC EMP20;

ALTER TABLE EMP20
ADD (SALARY NUMBER, JOB_ID VARCHAR2(10));

-- ������ ��ȸ
SELECT *
FROM EMP20;

-- 9.3.2 �÷� ���� (�̸�, ����, �ڷ���, ��������), ������ ���ǰ��ɼ�
-- ������ Ÿ��, ũ�⸦ �����ϴ� ����
ALTER TABLE ���̺��
MODIFY (�÷���1 ������Ÿ��, �÷���2 ������Ÿ��, ...)
-- ���̺� ���� ���ų�, �÷��� NULL ���� �����ϰ� �־�� ������ Ÿ���� ������ �� �ִ�.
-- �÷��� ���� �Ǿ� �ִ� �������� ũ�� �̻���� �������� ũ�⸦ ���� �� �ִ�.

ALTER TABLE ���̺��
RENAME COLUMN ������ �÷��� TO ����� �÷���; -- �÷��� �ٲٰ� ���� ��

ALTER TABLE EMP
RENAME COLUMN FNAME TO FIRST_NAME;

[���� 9-8] EMP20 ���̺��� SALARY �÷��� JOB_ID �÷��� ������ ũ�⸦ ���� �����Ѵ�.
-- ���� : SALARY NUMBER --> NUMBER(8,2), JOB_ID VARCHAR2(5) --> 10 BYTE
ALTER TABLE EMP20
MODIFY (SALARY NUMBER(8, 2), JOB_ID VARCHAR2(10)); -- TABLE EMP20�� ����Ǿ����ϴ�.

-- ��ȸ
DESC EMP20;

SELECT *
FROM EMP20;

-- ���Ƿ� 203�� ��� ���� �� MODIFY �غ���
INSERT INTO EMP20
VALUES (203, 'Steve', SYSDATE, 10000, 'SA_MAN'); -- 1�� ����

ALTER TABLE emp20
MODIFY  (salary NUMBER(5, 3), job_id VARCHAR2(5));
-- ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�

-- 9.3.3 �÷� ���� : ������ ����
-- ���̺��� �÷��� �����ϴ� ����
ALTER TABLE ���̺��
DROP COLUNM �÷���;

[���� 9-9] EMP20 ���̺��� �����ڵ� �÷� JOB_ID�� ����
ALTER TABLE EMP20
DROP COLUMN JOB_ID;

DESC EMP20;

SELECT *
FROM EMP20;

ROLLBACK; -- DDL : CREATE, ALTER, DROP, TRUNCATE --> �ڵ� COMMIT;

-- 9.4 ���̺� ���� DROP => ������ �ϴ� �Ű�����, �ʿ�� ����(=FLASH BACK)
-- ���̺��� �� �����Ϳ� ������ �����ϴ� ���� : DROP TABLE
-- ���̺��� �� �����͸� �����ϰ� ������ ����� ���� : TRUNCATE TABLE ���̺��;
DROP TABLE ���̺��;

DROP TABLE EMP20;
-- ���� > ������ - EMP20 �÷��ù� --> EMP20BACK
-- ������ ���� ���̺���� ���� : �̹� �ִ� �ٸ� ���̺���� �浹�� ����

SELECT *
FROM EMP20BACK;

-- ���� �ȵǰ� ���̺� ���� : �������� ��ġ�� �ʰ� ������ ����(���� �Ұ�)
DROP TABLE ���̺�� PURGE
DROP TABLE EMP20BACK PURGE;

-- ���̺��� �̸��� ����
RENAME ������ ���̺�� TO ���� �� ���̺��;

RENAME TMP2 TO TEST; --���̺� �� ����

-- 9.5 ���̺� ������ ���� TRUNCATE (������ �����, �����ʹ� ����)
SELECT *
FROM TMP2;

TRUNCATE TABLE TMP2; -- �����ʹ� ��������, ���̺�� �÷�, �ڷ����� ���Ǵ� ����

DESC TMP2;


