-- 6��. ��������

-- SQL���� �ȿ� �����ϴ� �� �ٸ� SQL ������ ����������� �Ѵ�.
-- 1) ���������� ��ȣ(, )�� ��� ����Ѵ�.
-- 2) ���������� ���Ե� �������� ���� ������� �Ѵ�.
-- 3) ������� : ���������� ���� ����ǰ� �� ����� ��ȯ�� �� ���������� ����ȴ�.


-- ORACLE, MYSQL, MSSQL : RDBMS     VS     mongoDB(atlas), firbase(google), MS Azure, Amazon AWS
-- ������ �����ͺ��̽�                     <CLOUD ����� �����ͺ��̽�> : NoSQL (������ �����ͺ��̽��� �ƴ�)

-- ����Ŭ => ��������
-- MSSQL ==> T-SQL
-- ���� DBMS���� �ణ �ٸ� �̸�

[���� 6-1] ��� �޿����� �� ���� �޿��� �޴� ����� ���� ��ȸ
-- 1. ��� �޿��� ���Ѵ�
SELECT ROUND(AVG(SALARY)) AS AVG_SAL
FROM EMPLOYEES;

--2. ��� �޿� �̸��� �޴� ���
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < 6462;

-- 1+2�� ȿ�� : ��������
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT ROUND(AVG(SALARY)) AS AVG_SAL
                FROM EMPLOYEES);

-- ============== ���� ������ ���� ==============
-- �������� ���� ����� ������ ���� ����
-- 6.1 ���� �� �������� : �ϳ��� ��� ���� ��ȯ�ϴ� ��������
-- �� ���� �� ������ (=, >=, >, <, <=,          <>, !=, ^=)
-- �� �׷� �Լ��� ����ϴ� ��찡 ����. (AVG, SUM, COUNT, MAX, MIN)

[���� 6-2] �� �޿��� ���� ���� ����� ���, �̸�, �� ������ ��ȸ
-- 1. �� �޿� ���� ���� �ݾ� ��ȸ
SELECT SALARY
FROM EMPLOYEES
ORDER BY 1 DESC; -- MAX: 24000 => ���� ������

SELECT MAX(SALARY) AS MAX_SAL, MIN(SALARY) AS MIN_SAL
FROM EMPLOYEES;

SELECT MIN(SALARY) AS MIN_SAL
FROM EMPLOYEES;

-- 2. �������� �ۼ�
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY) AS MAX_SAL
                FROM EMPLOYEES);
                
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY) AS MIN_SAL
                FROM EMPLOYEES);

[���� 6-3] ��� 108�� ����� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ
-- 1. ���������� ������� ���� ��
-- 1-1. 108�� ����� �޿��� ��ȸ
-- 1-2. ��ü ��� ���� 1-1���� ���� �޿��� ���ؼ� �� ���� �޿��� �޴� ��� ��ȸ
SELECT SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 108;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);
                
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <> (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);
                
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY ^= (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY != (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 108);
                
[���� 6-4] ���޿��� ���� ���� ����� ���, �̸�, ��, �������� ������ ��ȸ
-- EMPLOYEES : ���, �̸�, ��
-- JOBS : ��������(JOB_TITLE)

-- 1. ���޿� ���� ū �� : 24000   VS   2100
SELECT MAX(salary)
FROM    employees;

SELECT MIN(salary)
FROM    employees;

-- 2. ����� ���, �̸�, ��, �������� ����
-- 2-1. ����Ŭ ����
-- 2-2. ANSI JOIN ==> MYSQL ��� ����, T-SQL (MSSQL), ...

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND SALARY = (SELECT MAX(SALARY) AS MAX_SAL
              FROM EMPLOYEES);
              
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND SALARY = (SELECT MIN(SALARY) AS MIN_SAL
              FROM EMPLOYEES);

-- 6.2 ���� �� ��������
-- ���� �� ������(IN, NOT, ANY(=SOME), ALL, EXISTS)

-- 6.2.1 IN ������
-- OR ������ ��� --> ����
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 80);

[���� 6-5] �μ�(��ġ�ڵ�, LOCATION_ID)�� ����(UK)�� �μ��ڵ�, ��ġ�ڵ�, �μ��� ������ ��ȸ
-- 1. ������ ��ġ�ڵ� ��ȸ
SELECT LOCATION_ID
FROM LOCATIONS
WHERE COUNTRY_ID = 'UK';

-- 2. ��������
SELECT DEPARTMENT_ID, LOCATION_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE LOCATION_ID  = ANY (2400, 2500, 2600);


-- 6.2.2 NOT ������
-- 6.2.3 ANY(=SOME) ������
-- 6.2.4 ALL ������
-- 6.2.5 EXISTS ������



-- 6.3 ���� �÷� ��������

-- �������� ����?
-- 6.4 ��ȣ���� ��������

-- ���������� �ۼ� ��ġ�� ���� ���� : ������ WHERE���� �ۼ�/���
-- 6.5 ��Į�� �������� : SELECT ���� �ۼ� / ���
-- 6.6 �ζ��� �� �������� : FROM ���� �ۼ� / ���
-- ==============================================