[�������� 8-1]

1. EMP ���̺� (������) ������ ���� �����Ͻÿ�.

-- ���̺� ����(�÷� ����) Ȯ��
DESC EMP;

-- ������ �Է�
INSERT INTO EMP (EMP_ID, FNAME, LNAME, HIRE_DATE, SALARY)
VALUES (400, 'Johns', 'Hopkins', TO_DATE('2008/10/15', 'YYYY/MM/DD'), 5000);
INSERT INTO EMP (EMP_ID, FNAME, LNAME, HIRE_DATE, SALARY)
VALUES (401, 'Abraham', 'Lincoln', TO_DATE('2010/03/03', 'YYYY/MM/DD'), 12500);
INSERT INTO EMP (EMP_ID, FNAME, LNAME, HIRE_DATE, SALARY)
VALUES (402, 'Tomas', 'Edison', TO_DATE('2013/06/21', 'YYYY/MM/DD'), 6300);

-- ������ Ȯ��
SELECT *
FROM EMP;

/*
-- DML : INSERT, UPDATE, DELETE
INSERT INTO ���̺�� [(�÷�1, �÷�2, ...)]
VALUES(��1, ��2, ...)

-- �Ǵ� VALUES �����ϰ�,
-- SELECT ~ ���� : ITAS

UPDATE ���̺��
SET �÷���=��
WHERE ����;

DELETE FROM ���̺��
WHERE ����;
*/

2. EMP ���̺��� ��� 401�� ����� �μ��ڵ带 90����, �����ڵ带 SA_MAN���� �����ϰ� ���������� ���� Ȯ��

-- ������ Ȯ�� : 401�� ���
SELECT *
FROM EMP
WHERE EMP_ID = 401;

-- ������ ����(=������Ʈ, ���� �����͸� �����ؼ� ����)
UPDATE EMP
SET DEPT_ID = 90,
    JOB_ID = 'SA_MAN'
WHERE EMP_ID = 401;

-- �ٽ� ������ Ȯ��
SELECT *
FROM EMP
WHERE EMP_ID = 401;

-- ������ ���� Ȯ��
COMMIT;

3. EMP ���̺��� �޿��� 8000 �̸��� ��� �����  �μ��ڵ带 80������ �����ϰ�, �޿��� EMPLOYEES ���̺���
80�� �μ��� ��ձ޿��� ������ ���� (��, ��ձ޿��� �ݿø� �� ���� ���)

-- ������ Ȯ��
SELECT *
FROM EMP
WHERE SALARY < 8000;

-- EMPLOYEES ���̺��� 80�� �μ����� ��� �޿� ��ȸ
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80; -- 8956

SELECT DEPARTMENT_ID, ROUND(AVG(SALARY))
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
GROUP BY DEPARTMENT_ID
ORDER BY 1;

-- ������ ����
UPDATE EMP
SET DEPT_ID = 80,
    SALARY = ( SELECT ROUND(AVG(SALARY))
               FROM EMPLOYEES
               WHERE DEPARTMENT_ID = 80)
WHERE SALARY <  8000;

-- Ȯ��
SELECT *
FROM EMP;

4. EMP ���̺��� 2010�� ���� �Ի��� ����� ������ �����Ѵ�.
-- TO_CHAR(HIRE_DATE, 'YYYY')
-- 2009�� 12�� 31�ϱ��� ����, 2010�⵵ 1�� 1�� �̸�(����X)

DELETE FROM EMP
-- WHERE HIRE_DATE <= '2009-12-31';
WHERE TO_CHAR(HIRE_DATE, 'YYYY') < '2010';

-- 2010�� ���� �Ի��� �Ի��� ��ȸ
SELECT *
FROM EMP
-- WHERE HIRE_DATE <= '2009-12-31';
WHERE TO_CHAR(HIRE_DATE, 'YYYY') < '2010';

-- Ȯ��
SELECT *
FROM EMP;

-- Ȯ��
COMMIT;



