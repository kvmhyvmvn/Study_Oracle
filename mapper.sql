-- ���̺� ����� ��, Ű
-- ���̺� ����� : ���̺�� => CUSTOMER
-- ID�� �������·� �����͸� �ĺ��� �� �ִ� ������ Ű ��
-- NAME ����� �̸��� ������ (NULL �ƴ�)
-- GENDER�� ���� ����, �⺻������ ���� ������ ������ (NULL �ƴ�)
-- EMAIL �̸����� ����
-- PHONE �ڵ��� ��ȣ�� ����

CREATE TABLE CUSTOMER (
    ID NUMBER PRIMARY KEY,
    NAME NVARCHAR2(17) NOT NULL,
    GENDER VARCHAR2(3) DEFAULT '��' CHECK(GENDER IN('��', '��')),
    EMAIL VARCHAR2(100),
    PHONE VARCHAR2(50)
);

DROP TABLE CUSTOMER;

SELECT *
FROM CUSTOMER
where id = 6;

INSERT INTO CUSTOMER VALUES (1, 'NAME', '��', 'EMAIL', 'PHON1E');
INSERT INTO CUSTOMER VALUES (2, '���ϴú��Ա����޴Ժ��ٻ�������츮', '��', 'EMAIL', 'PHON2E');
INSERT INTO CUSTOMER VALUES (3, '��ä��', '��', 'EMAIL', 'PHON3E');
INSERT INTO CUSTOMER VALUES (4, '��������', '��', 'EMAIL', 'PHON4E');
INSERT INTO CUSTOMER VALUES (5, '������', '��', 'EMAIL', 'PHON5E');

SELECT ID, NAME, EMAIL FROM CUSTOMER WHERE ID > 2;

SELECT * FROM CUSTOMER WHERE NAME = '��ä��';

INSERT INTO CUSTOMER (ID, NAME, EMAIL, PHONE)
VALUES(6, 'NAME', 'EMAIL', 'PHONE');

select
