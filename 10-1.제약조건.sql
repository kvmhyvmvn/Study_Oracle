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

-- 10.2 CHECK �������� - ���� ���� : Check
-- 10.3 UNIQUE �������� - �ߺ����� (NULL ���)
-- 10.4 PRIMARY KEY �������� - UNIQUE + NOT NULL
-- 10.5 FOREIGN KEY �������� - �ܷ�Ű

