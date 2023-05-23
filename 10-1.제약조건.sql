-- 10��. ��������

-- ���Ἲ ��������(Intergrity Constraints) : �������� ��Ȯ���� �����ϱ� ���� �δ� ����/���� ����
-- 1) ���̺� ������ ���� : CREATE TABLE ~
-- 2) ���̺� ���� �� �߰� : ALTER TABLE ~

-- 10.1 NOT NULL �������� - NULL ������� ���� : 
-- �÷��� ������ ���� �־� NULL ������� ���� ==> �ݵ�� �����͸� �Է��ؾ� �Ѵ�
-- * ���̺� ������ �÷� �������� �����Ѵ�
-- EX> ���̺� ���� ����
CREATE TABLE ���̺�� (
    �÷���1 ������Ÿ��(����) ��������, -- �÷� ����
    �÷���2 ������Ÿ��(����),
    ...���...
);

CREATE TABLE USER(
    ID VARCHAR2(20) NOT NULL, -- �÷� ����
    NICK VARCHAR2(20) ,
    ...���...
);

[���� 10-1] NULL_TEST��� ���̺��� �����ϵ� �÷��� COL1 ����Ÿ�� 5����Ʈ ����, NULL ��������ʰ�,
COL2 ����Ÿ�� 5����Ʈ ���̷� ����

-- 1) ���̺� ���� : NULL_TEST + NOT NULL
CREATE TABLE NULL_TEST (
    COL1 VARCHAR2(5) NOT NULL, -- �÷� ����
    COL2 VARCHAR2(5) -- ���� ���� X ==> NULL ���
);

INSERT INTO NULL_TEST (COL1)
VALUES ('AA'); -- AA | (NULL)

SELECT *
FROM NULL_TEST;

[���� 10-3] BB�� COL2�� ����
INSERT INTO NULL_TEST (COL2)
VALUES ('BB'); -- COL1 NOT NULL ��������
-- ORA-01400: NULL�� ("HR"."NULL_TEST"."COL1") �ȿ� ������ �� �����ϴ�

-- 2) ���̺� ���� �� NOT NULL ����
-- �÷��� NULL �����Ͱ� ���� ���, NOT NULL�� �߰��� �� �ִ�.

-- NULL_TEST�� �̹� BB�� COL2 �÷��� �ִ� ����
UPDATE NULL_TEST
SET COL2 = 'BB'; -- COL2 �÷��� �����͸� NULL���� 'BB'�� ����

SELECT *
FROM NULL_TEST;

[���� 10-4]
ALTER TABLE NULL_TEST
MODIFY (COL2 NOT NULL); -- ���� ���� �߰�

[���� 10-5] COL2�� NULL�� �ٲپ�� ==> ���������� �߰��Ǿ�����, �����߻�
-- COL2�� NOT NULL�� �߰� ==> �����͸� NULL
UPDATE NULL_TEST
SET COL2 = NULL; -- �����߻�

-- �ٽ� COL2 �÷��� NULL ���
ALTER TABLE NULL_TEST
MODIFY (COL2 NULL); -- COL1, COL2 ��� �����Ͱ� �ִ� <---> NULL�� �ƴϹǷ�

UPDATE NULL_TEST
SET COL2 = NULL;

COMMIT;
-- ===================================================================================================================
-- ������ ����
SELECT *
FROM DICT; -- ���� ���ѿ� ���� �������ʴ� ��ü ==> SYS�� SYSTEM���� ��ȸ�ϸ� ��� ã�� �� ����

-- ============= ����� �������� ������ (���̺���) ���� ������ ��� ��ϵ� ������ ���̺� ��ü : ����Ŭ ���� ==============
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'NULL_TEST'; -- ������ COL1 NOT NULL, ���� �� �߰� COL2 NOT NULL

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEES';

-- 10.2 CHECK �������� - ���� ���� / ������
-- ���ǿ� �´� �����͸� ������ �� �ֵ��� �ϴ� ���������̴�.
-- �÷� ����, ���̺� �������� �����Ѵ�.
-- �÷� ����
-- ���̺� ����
[���� 10-6]
CREATE TABLE CHECK_TEST (
    NAME VARCHAR2(10) NOT NULL,  -- �÷� ����
    GENDER VARCHAR2(10) NOT NULL CHECK (GENDER IN ('����', '����', 'MALE', 'FEMALE', 'MAN', 'WOMAN')),
    SALARY NUMBER(8),
    DEPT_ID NUMBER(4),
    CONSTRAINT CHECK_SALARY_CK CHECK (SALARY > 2000) -- ���̺� ����
);

-- ���̺��_�÷���_�������� ���(NN: NOT NULL, CK: CHECK, PK: PRIMARY KEY, FK: FOREIGN, UK: UNIQUE KEY)

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CHECK_TEST';

[���� 10-7] �����͸� CHECK_TEST ���̺� �����غ��ÿ�
INSERT INTO CHECK_TEST
VALUES ('ȫ�浿', '����', 3000, 10); -- GENDER, SALARY üũ : ���

[���� 10-9]
UPDATE CHECK_TEST
SET SALARY = 2000
WHERE NAME = 'ȫ�浿';

-- II. ���̺� ���� �� �������� �߰�/����
[���� 10-10]
-- DDL : CREATE, ALTER, DROP
--         ����,  ����, ����
-- CHECK_TEST�� �ɸ� ���������� Ȯ���ϰ�, �׷� ���� �����ߴٰ� �ٽ� �߰� �ϴ� ����

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CHECK_TEST';

/*
SYS_C008366	C	"NAME" IS NOT NULL
SYS_C008367	C	"GENDER" IS NOT NULL
SYS_C008368	C	GENDER IN ('����', '����', 'MALE', 'FEMALE', 'MAN', 'WOMAN')
CHECK_SALARY_CK	C	SALARY > 2000
*/

-- ����
ALTER TABLE CHECK_TEST
DROP CONSTRAINT CHECK_SALARY_CK;

-- �ٽ� �߰�
[���� 10-11]
ALTER TABLE CHECK_TEST
ADD CONSTRAINT CHECK_SALARY_DEPT_CK
    CHECK ( SALARY BETWEEN 2000 AND 10000 AND DEPT_ID IN(10, 20, 30));

SELECT *
FROM CHECK_TEST;

-- 10.3 UNIQUE �������� - �ߺ����� (NULL ���)
-- �����Ͱ� �ߺ����� �ʵ��� ���ϼ��� �����ϴ� ��������
-- �÷� ����, ���̺� �������� ����
-- ����Ű(Composite Key)�� ������ �� �ִ�. ��) ���� ��� VS ���+�̸�
-- PRIMARY KEY : UNIQUE + NOT NULL

-- ���̺� ������ UNIQUE ����
-- I. �÷����� ����
[���� 10-13]
CREATE TABLE UNIQUE_TEST (
    COL1 VARCHAR2(5) UNIQUE NOT NULL,
    COL2 VARCHAR2(5),
    COL3 VARCHAR2(5) NOT NULL,
    COL4 VARCHAR2(5) NOT NULL,
    CONSTRAINT UNI_COL2_UK UNIQUE (COL2),
    CONSTRAINT UNI_COL34_UK UNIQUE (COL3, COL4) -- ����Ű : �� �̻��� �÷��� ���� ==> ��� + ��ȭ��ȣ, ��� + �̸�, ...
);

[���� 10-14]
INSERT INTO UNIQUE_TEST
VALUES ('A1', 'B1', 'C1', 'D1');

INSERT INTO UNIQUE_TEST
VALUES ('A2', 'B2', 'C2', 'D2');

SELECT *
FROM UNIQUE_TEST;

COMMIT;

[���� 10-15]
UPDATE UNIQUE_TEST
SET COL1 = 'A1'
WHERE COL1 = 'A2';

[���� 10-16]
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

-- II. ���̺� ���� ����
-- ���̺� ���� �� UNIQUE �߰� / ����: ���� �� �ۼ��� UNIQUE ���� --> �߰�

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'UNIQUE_TEST';

[���� 10-18] UNI_COL34_UK ���������� �����ϰ� COL2, COL3, COL4�� UNIQUE ����Ű�� �����ϴ�
ALTER TABLE UNIQUE_TEST
DROP CONSTRAINT UNI_COL34_UK;

ALTER TABLE UNIQUE_TEST
ADD CONSTRAINT UNI_COL234_UK UNIQUE (COL2, COL3, COL4);

SELECT *
FROM UNIQUE_TEST;

[���� 10-20]
INSERT INTO UNIQUE_TEST
VALUES ('A7', '', 'C4', 'D4');

-- 10.4 PRIMARY KEY �������� - UNIQUE + NOT NULL
-- ������ ��(ROW)�� ��ǥ�ϵ��� �����ϰ� �ĺ��ϱ� ���� ��������
-- UNIQUE + NOT NULL�� ����
-- �⺻Ű, �ĺ���, �� Ű, PK�� �Ѵ�
-- �÷� ����, ���̺� �������� ���� *����Ű*�� ������ �� �ִ�
-- ��) ��� - �ֹε�Ϲ�ȣ, ȸ��� - �����ȣ

-- I. �÷����� ����
�÷��� ������Ÿ�� PRIMARY KEY : ��� --> SYS_C008XXX
�÷��� ������Ÿ�� CONSTRAINT �������Ǹ� PRIMARY KEY --> ���̺��_�÷���_�������Ǿ��

-- II. ���̺��� ����
CONSTRAINT ���̺��_�÷���_�������Ǿ�� PRIMARY KEY (�÷���)

[���� 10-21]
CREATE TABLE DEPT_TEST (
    DEPT_ID NUMBER(4),
    DEPT_NAME VARCHAR2(30) NOT NULL,
    CONSTRAINT DEPT_TEST_ID_PK PRIMARY KEY (DEPT_ID)
);

[���� 10-22]
INSERT INTO DEPT_TEST
VALUES (10, '������');

INSERT INTO DEPT_TEST
VALUES (10, '���ߺ�');

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPT_TEST';

[���� 10-23]
ALTER TABLE DEPT_TEST
DROP CONSTRAINT DEPT_TEST_ID_PK;

[���� 10-24]
INSERT INTO DEPT_TEST
VALUES (10, '�ѹ���');

UPDATE DEPT_TEST SET DEPT_ID = 20
WHERE DEPT_NAME = '�ѹ���';

[���� 10-25]
ALTER TABLE DEPT_TEST
ADD CONSTRAINT DEPT_TEST_ID_PK PRIMARY KEY(DEPT_ID);

-- 10.5 FOREIGN KEY �������� - �ܷ�Ű
-- �θ� ���̺��� �÷��� �����ϴ� �ڽ� ���̺��� �÷���, �������� ���Ἲ�� �����ϱ� ���� �����ϴ� ��������
-- NULL ��� <---> UNIQUE : �ߺ�����, NULL ���
-- ����Ű, �ܷ�Ű, FK
-- �÷�����, ���̺������� ����, ����Ű�� ������ �� �ִ�
-- �÷��� ������ Ÿ�� REFERENCES �θ����̺� (�����Ǵ� �÷���)
-- �÷��� ������ Ÿ�� CONSTRAINT �������Ǹ� REFERENCES �θ����̺� (�����Ǵ� �÷�)

-- ���̺������� ����
-- CONSTRAINT ���̺��_�������Ǹ�_�������Ǿ�� FOREIGN KEY (�����ϴ� �÷���) REFERENCES �θ����̺� (�����Ǵ� �÷�)
-- ���̺�� ���̺��� ���迡 ����, ...
-- ����������̺� <--> �μ��������̺�
-- ����� �μ��� �Ҽӵȴ�(=����) N:1 �ϴ�ٰ��� : RDBMS���� ���� �⺻����
-- �μ��� ����� �����Ѵ�(=����) 1:N �ٴ��, [M:N] ���� :  �����ؼ�

[���� 10-26]
CREATE TABLE EMP_TEST (       
    EMP_ID NUMBER(4) PRIMARY KEY, -- �ߺ�x, NULL ���! : ���ϼ� ����
    ENAME VARCHAR2(30) NOT NULL, -- NULL ������� ����
    DEPT_ID NUMBER(4),
    JOB_ID VARCHAR2(10),
    CONSTRAINT EMP_TEST_DEPT_FK FOREIGN KEY (DEPT_ID) REFERENCES DEPT_TEST (DEPT_ID)    
);

SELECT *
FROM DEPT_TEST;

[���� 10-27]
INSERT INTO EMP_TEST
VALUES (100, 'King', 10, 'ST_MAN');

INSERT INTO EMP_TEST
VALUES (101, 'Kong', 300, 'AC_MGR'); -- �μ����̺� 300�� ����X

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP_TEST';

[���� 10-28]
ALTER TABLE EMP_TEST
DROP CONSTRAINT EMP_TEST_DEPT_FK;

INSERT INTO EMP_TEST
VALUES (102, '�ѹ���', 300, 'MK_REP');

[���� 10-29]
ALTER TABLE EMP_TEST
ADD CONSTRAINT EMP_TEST_JOB_FK FOREIGN KEY (JOB_ID)
                               REFERENCES JOBS (JOB_ID);

-- ���� ���� Ȯ��

SELECT *
FROM    dict
WHERE table_name LIKE '%PRIVS%';

SELECT *
FROM    USER_ROLE_PRIVS; -- ����� ���� ��_����

SELECT *
FROM    ALL_TAB_PRIVS -- ����� ���� ��_����
WHERE   grantee='HANUL';

-- DEFAULT
-- �÷� ������ �����Ǵ� �Ӽ�, �����͸� �Է����� �ʾƵ� ������ ���� �⺻ �Էµǵ��� �Ѵ�.
-- ���������� �ƴ�����, �÷� �������� �ۼ��Ѵ�.

[���� 10-30]
CREATE TABLE DEFAULT_TEST (
    NAME VARCHAR2(10) NOT NULL,
    HIRE_DATE DATE DEFAULT SYSDATE NOT NULL,
    SALARY NUMBER(8) DEFAULT 2500
);

[���� 10-31]
INSERT INTO DEFAULT_TEST (NAME)
VALUES ('ȫ�浿');

SELECT * FROM DEFAULT_TEST;
