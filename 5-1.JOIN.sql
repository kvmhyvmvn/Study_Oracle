-- 5��. JOIN(����)
-- ����Ŭ ������ �����ͺ��̽��̴� ==> ���� : ���̺�� ���̺��� �δ�!
-- (Relation, �����̼� - �����ͺ��̽� ������ �� ���̺��� �����̼��̶�� ��0
-- JOIN ���� ���̺��� �����Ͽ� (HR : 7��, ���� : n)
-- ex> ��� ���̺� ~ �μ� ���̺� ���� : ��������� �μ�����(�μ��̸�, �μ���ġ�ڵ�)�� ��ȸ�� ��

-- 5.1 Cartesian Product (Decart�� �ٸ� ��, Cartesian)
-- JOIN ���� : �� �̻��� ���̺��� ���踦 ���� ��, ������ �Ǵ� �÷��� ���� ==> ����, WHERE���� ���
-- JOIN ������ ������� ���� �� �߸��� ����� �߻��ϴµ�, �̰� ī�׽þ� ��(=�ռ���)�̶�� ��
-- ������ �ȳ� ==> �����Ǵ� ������ ���� ���ٸ� �ǽ�

/*
SELECT �÷���1, �÷���2, ...
FROM ���̺��1, ���̺��2, ...
WHERE JOIN ����(=��)
*/

[���� 5-1] ��� ���̺�� �μ� ���̺��� �̿��� ����� ������ ��ȸ�ϰ��� �Ѵ�. ���, ��, �μ� �̸��� ��ȸ
-- ���, �� : EMPLOYEES (��� ���� ���̺� : ���, �̸�, ����޿�, �Ի���,...)
-- �μ��̸� : DEPARTMENTS (�μ� ���� ���̺� : �μ��ڵ�, �μ��� ��ġ�� �����ڵ�)

-- ������̺� ������/�� �� : 107
-- �μ����̺� ������/�� �� : 27
-- ī�׽þ� �� : 2889 ROWS ==> 107 * 27

SELECT 107 * 27
FROM DUAL;

DESC EMPLOYEES;
/*
�̸�             ��?       ����           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    
*/

DESC DEPARTMENTS;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)   
*/

-- 5.2 EQUI JOIN : �������(=)�� ����� JOIN ����(=���� ����)

-- �� ���̺��� ���� �÷� : DEPARTMENT_ID (MANAGER_ID : �μ����̺��� �ĺ���X)
-- ��ü ����� 107��, ��ȸ�� ��� 106�� <---> 1���� ����
-- ���̺��� �̿��� JOIN ==> ��� ���̺� � �÷������� ���!

[���� 5-2]
SELECT EMP.EMPLOYEE_ID, EMP.LAST_NAME, -- �ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
        DEPT.DEPARTMENT_NAME -- �ΰ����� ����
FROM EMPLOYEES EMP, DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID; -- �������̺�.�����÷� = ������̺�.�����÷�;

[���� 5-3] ���̺��� ALIAS�� ����
SELECT EMP.EMPLOYEE_ID, EMP.LAST_NAME,
        DEPT.DEPARTMENT_NAME
FROM EMPLOYEES EMP, DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID = DEPT.DEPARTMENT_ID;

[���� 5-4] ������̺�, �������̺��� �̿��� ���, �̸�, �����ڵ�, �������� ������ ��ȸ
DESC JOBS;

SELECT E.EMPLOYEE_ID, E.FIRST_NAME||' '||E.LAST_NAME NAME, E.JOB_ID,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
ORDER BY 1;

-- 1) ��� ~ �μ� : �������� 1��
-- 2) ��� ~ ���� : �������� 1��
-- 3) ��� ~ �μ� ~ ���� ~ ���� ~ ����(����) ~ ���
-- => JOIN�ϴ� ���̺��� ���� -1 : ���������� ����

-- JOIN �ϴ� ��� ���̺��� �߰��Ǹ�, JOIN ������ �߰��Ѵ�.

[���� 5-5] ������̺�, �μ����̺�, �������̺��� �̿��� ���, �̸�, �μ���, �������� ������ ��ȸ
-- EMPLOYEES, DEPARTMENTS, JOBS
-- �������, �μ�����, ��������
--      DEPARTMENT_ID

SELECT E.EMPLOYEE_ID AS ���, E.FIRST_NAME||' '||E.LAST_NAME NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM   EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID -- 1���� �μ��ڵ� X
AND    E.JOB_ID = J.JOB_ID
ORDER BY 1;

-- 5.3 NON-EQUI JOIN

-- 5.4 OUTER JOIN

-- 5.5 SELF JOIN

-- 5.6 ANSI JOIN /  ANSI ��ȸ���� ���� ǥ�� JOIN��(ORACLE�ܿ��� MYSQL, CUBRID, ��Ÿ DBMS ���� JOIN)

-- 5.7 OUTER JOIN