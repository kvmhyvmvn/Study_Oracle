[�������� 4-2]

1. ��� ���̺��� Ŀ�̼��� �޴� ����� ��� ������� �� ���� ��ȸ�ϴ� �������� �ۼ��Ѵ�

SELECT COUNT(COMMISSION_PCT) AS "Ŀ�̼� �޴� ��� ��"
FROM EMPLOYEES;

/*
SELECT *
FROM    employees
WHERE   commission_pct IS NOT NULL; -- Ŀ�̼����� NULL �ƴ� ��� ==> �Ǹźμ����� Ŀ�̼� ����!
*/

2. ���� �ֱٿ� ���� ������ �Ի��Ų ��¥�� �������� �ֱ� �Ի����ڸ� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT MAX(HIRE_DATE)
FROM EMPLOYEES;

-- SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
-- FROM EMPLOYEES
-- ORDER BY 3 DESC;


3. 90�� �μ��� ��ձ޿����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, ��ձ޿����� �Ҽ� ��°�ڸ����� ǥ��ǵ��� �Ѵ�)
-- SUM(), AVG() : ���� ������ �÷��� ��/����� ����Ͽ� ��ȯ�ϴ� �Լ�
-- MAX(), MIN() : ��� ������ �÷��� ���밡��
-- ROUND(n [,i]) : �Ҽ��� ���� i��° �ڸ��� �ݿø��� ����� ��ȯ�ϴ� �Լ�
-- i�� ������, �����ο��� i��° �ڸ��� �ݿø��� ����� ��ȯ�ϴ� �Լ�
-- ��¥�����Ϳ��� ROUND(date [,fmt]) �������� �ݿø��� ����� ��ȯ

SELECT TO_CHAR(ROUND(AVG(SALARY), 2), '999,999') AS ��ձ޿���1,
       ROUND(AVG(SALARY), 2) AS ��ձ޿���2
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;