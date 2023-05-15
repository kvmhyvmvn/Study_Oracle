-- 5��. JOIN(����)
-- ����Ŭ ������ �����ͺ��̽��̴� ==> ���� : ���̺�� ���̺��� �δ�!
-- (Relation, �����̼� - �����ͺ��̽� ������ �� ���̺��� �����̼��̶�� ��0
-- JOIN ���� ���̺��� �����Ͽ� (HR : 7��, ���� : n)
-- ex> ��� ���̺� ~ �μ� ���̺� ���� : ��������� �μ�����(�μ��̸�, �μ���ġ�ڵ�)�� ��ȸ�� ��

-- 5.1 Cartesian Product (Decart�� �ٸ� ��, Cartesian)
-- JOIN ���� : �� �̻��� ���̺��� ���踦 ���� ��, ������ �Ǵ� �÷��� ���� ==> ����, WHERE���� ���
-- JOIN ������ ������� ���� �� �߸��� ����� �߻��ϴµ�, �̰� ī�׽þ� ��(=�ռ���)�̶�� ��
-- ������ �ȳ� ==> �����Ǵ� ������ ���� ���ٸ� �ǽ�
-- CROSS JOIN �̶�� ��.  (���̺��� ������(=ROW)�� ���ٸ� ����X, ���ٸ� => ���ð�, ���� �����ɸ�

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
-- ������ ������ ����� �����ؼ� ����� �ݿ� ==> ����� �� ��� (��ü�������) ==> OUTER JOIN ó��
-- �񱳵Ǵ� �������� INNER JOIN �̶�� �� �� ����
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

-- WHERE �������� JOIN ���ǰ� �Ϲ� ������ �Բ� ����Ѵ�.
[���� 5-6] ����� 101���� ����� ���, �̸�, �μ���, �������� ������ ��ȸ
-- ���, �̸� : EMPLOYEES --> E, EMP
-- �μ��� : DEPARTMENTS --> D, DEPT
-- �������� : JOBS --> J, JOB
-- ���̺��� ������ JOIN ������ ���� : ���̺� ���� - 1(JOIN ������ ����)

SELECT E.EMPLOYEE_ID, E.FIRST_NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID -- �μ��ڵ尡 ���� ��� 1��
AND E.JOB_ID = J.JOB_ID
AND E.EMPLOYEE_ID = 101;
-- ��� : �ĺ��� (PK, Primary Key / NULL ������ �ʰ�, �ߺ����� �ʴ� ������ ��
-- �������� : ������ �Է��� �Ǽ� / ���� / ���� �������� ��ġ

-- 5.3 NON-EQUI JOIN                           VS     EQUI JOIN (����� INNER JOIN VS OUTER JOIN)
--     �񱳿�����(>, >=, <, <=)                       �������(=)
--     BETWEEN
--     IN
--     NO ~ EQUI : ������� �̿��� �����ڸ� ����� JOIN ����
--     JOIN �ϴ� �÷��� ��ġ���� �ʰ� ����ϴ� JOIN �������� <���� ������� �ʴ´�>
--     ���������� ==> �ϳ��� �����Ͷ� ��ġ���ʰ� OUTER JOIN�� �ξ� ���� ����Ѵ�.

[���� 5-7] �޿��� ���� ������ ���� ���� �ִ� 10�� �μ����� ���, �̸�, �޿�, ���������� ��ȸ
-- ����� ���� : EMPLOYEES [���, �̸�, �޿�]
-- �������� : JOBS [��������]
/*
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND E.SALARY >= J.MIN_SALARY
AND E.SALARY <= J.MAX_SALARY
AND E.DEPARTMENT_ID = 50;
*/

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY,
       J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.SALARY BETWEEN J.MIN_SALARY AND J.MAX_SALARY
AND   E.JOB_ID = J.JOB_ID
AND   E.DEPARTMENT_ID = 50;


DESC JOBS;
/*
�̸�         ��?       ����           
---------- -------- ------------ 
JOB_ID     NOT NULL VARCHAR2(10) 
JOB_TITLE  NOT NULL VARCHAR2(35) 
MIN_SALARY          NUMBER(6)    
MAX_SALARY          NUMBER(6)    
*/

-- 5.4 OUTER JOIN : EQUI JOIN �������� JOIN �ϴ� ���̺� �������� �����Ǵ� ����
-- ���� ����� ������� ��ȯ�Ѵ�. ������, OUTER JOIN�� �����Ǵ� ���� ���� ����� �������(?)
-- ��ȯ�Ѵ�.

-- �����Ǵ� ���� ���� ���̺� �÷��� (+) ��ȣ�� ǥ���Ѵ�.
-- �������̺��� �ݴ��� (+) ǥ��

[���� 5-8] ��� ����� ���, �̸�, �޿�, �μ��ڵ�, �μ��� ������ ��ȸ
-- DEPARTMENT_ID�� NULL�� ��� 1���� ���� �����Ǵ� ��� : EQUI JOIN ����
-- ������� : ���, �̸�, �޿�, �μ��ڵ� (EMPLOYEES)
-- �μ����� : �μ��� (DEPARTMENTS)
SELECT E.EMPLOYEE_ID AS EMPNO, E.FIRST_NAME AS ENAME, E.SALARY AS ESAL,
       D.DEPARTMENT_NAME AS DNAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+) -- OUTER-JOIN�� ���̺��� 1���� ������ �� �ֽ��ϴ�.
ORDER BY 1;

[���� 5-9] ��� ����� ���, �̸�, �޿�, �μ��ڵ�, �μ���, ��ġ�ڵ�, �����̸� ������ ��ȸ
SELECT E.EMPLOYEE_ID AS EMPNO, E.FIRST_NAME AS ENAME, E.SALARY AS ESAL,
       D.DEPARTMENT_NAME AS DNAME,
       L.LOCATION_ID AS LOCNO, L.CITY AS CITY_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND D.LOCATION_ID = L.LOCATION_ID
ORDER BY 1;

-- 5.5 SELF JOIN : �ϳ��� ���̺��� �� �� ����Ͽ�, ������ ���̺� �ΰ��κ��� JOIN�� ����
-- �����͸� ��ȸ�� ����� ��ȯ�Ѵ�.
-- 1) ������ ���̺��� �ΰ��ΰ� �� ������? (���������� ����Ǵ� ���� ����)
-- 2) �� �� ����Ѵ� (�޸𸮻�-�ӵ� ������! -���������� �ߺ��� ������ ���� �����ʰ� ���� �ٸ�,
-- ���̺��� �����ϴ� ��ó�� JOIN ����
-- ���̺� ���� : ��ȯ ����(���, Recusive)

[���� 5-10] ����� ���, �̸�, �Ŵ����� ���, �Ŵ����� �̸� ������ ��ȸ
-- ����� ���� : EMPLOYEES [��� �÷�, �̸�]
-- �Ŵ����� ���� : MANAGER?? [��� �÷�, �̸�]

SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID
FROM EMPLOYEES;

-- SELF JOIN
SELECT E.EMPLOYEE_ID, E.FIRST_NAME,
       M.EMPLOYEE_ID AS MANAGER_ID, M.FIRST_NAME AS MANAGER_NAME
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.EMPLOYEE_ID = M.MANAGER_ID -- ID: IDENTIFIY, _IED. ������ NULL ���
ORDER BY 1;

--- ����Ŭ JOIN ���� ------------------------------------------------------------------------
-- 1) ī�׽þ� ��(Cartesign Product) : ���� �������� ����������~ �߸��� ���(�ʹ����� �����)
-- 2) EQUI-JOIN (��������, =) <---> INNER JOIN(=���� ����) / ����� ����
-- 3) NON-EQUI JOIN (�񱳿�����,BETWEEN,IN) <---> EQUI-JOIN (��������� ���� ����)
-- 4) OUTER JOIN (=�ܺ� ����) <---> INNER JOIN�� �ݴ�Ǵ� ����
-- 5) SELF JOIN : �ϳ��� ���̺� ����� ������ �÷��� �̿��� �ڱ��ȯ ���� JOIN

-- 5.6 ANSI JOIN
-- �̱� ǥ�� ��ȸ(American National Standards Institute, ANSI)
-- ����Ŭ DBMS�� �ƴ� �ٸ� DBMS���� ���������� ����� �� �ִ� ǥ�� ����� JOIN ����
-- ��� DBMS���� ..RDBMS(Relational DBMS/������ DBMS)

-- 5.6.1 INNER JOIN <---> ����Ŭ JOIN���� INNER JOIN�� ���, EQUI-JOIN! 
-- FROM���� INNER JOIN�� ����ϰ�, JOIN ����(=WHERE)�� ON ���� ����Ѵ�.

[���� 5-12](���) ����� ���, �̸�, �μ��ڵ�, �μ��� ������ ��ȸ

-- ����Ŭ JOIN
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id(+)
AND     e.manager_id IS NOT NULL
ORDER BY 1;

-- ANSI INNER JOIN
SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name
FROM    employees e INNER JOIN departments d -- 1) FROM ���� INNER JOIN �� ��� : , ���!
ON   e.department_id = d.department_id       -- 2) JOIN ������ ON ���� ǥ�� : WHERE ���~ ON!
AND     e.manager_id IS NOT NULL
ORDER BY 1; -- 105��


-- ON�� ��� USING���� ����� �� �ִ�.
-- ��, USING �� ����Ҷ� �÷��� ����ؾ� �Ѵ�
-- �� ���� �÷� �̸��� ���  ==> ���̺��� ��Ī(Alias)�� ����!!

 -- 2) SELECT���� �����÷��� ���̺� ��Ī ����

SELECT  e.employee_id, e.first_name, department_id,
        d.department_name
FROM    employees e INNER JOIN departments d 
USING   (department_id)       -- 1) ON ��� USING (���� �÷���)
--AND     e.manager_id IS NOT NULL   -- �ؿ���
ORDER BY 1; -- 105��
--ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ� ==> SELECT ���� Ȯ��!
--00933. 00000 -  "SQL command not properly ended"

-- ORA-00906: ������ �°�ȣ    ==> USING (�����÷�)
-- 00906. 00000 -  "missing left parenthesis"

[���� 5-13]
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM   EMPLOYEES E INNER JOIN DEPARTMENTS D -- INNER�� �ɼ�
USING  (DEPARTMENT_ID)
WHERE  E.MANAGER_ID IS NOT NULL
ORDER BY 1;

--  ����Ŭ ���� : Cartesian Product, EQUI JOIN(=), NON-EQUI JOIN(>, >=, <, <= , BETWEEN, IN), OUTER JOIN(+)
-- ANSI JOIN    :  (CROSS JOIN)    ,  INNER JOIN,                  OUTER JOIN

[���� 5-15]  ����� ���, �̸�, �μ��ڵ�, �μ���, ��ġ�ڵ�, ���������� ��ȸ
-- ����Ŭ JOIN / ANSI JOIN

SELECT  e.employee_id, e.first_name, e.department_id,
        d.department_name,
        l.city
FROM    employees e INNER JOIN departments d
ON      e.department_id = d.department_id
INNER JOIN locations l
ON      d.location_id = l.location_id;

SELECT  e.employee_id, e.first_name, department_id,
        d.department_name,
        city
FROM    employees e INNER JOIN departments d
USING      (department_id)
INNER JOIN locations l
USING      (location_id);

-- ORACLE JOIN
SELECT  e.employee_id, e.first_name, d.department_id,
        d.department_name,
        l.city
FROM    employees e, departments d, locations l
WHERE   e.department_id = d.department_id
AND     d.location_id = l.location_id; -- 106rows

-- 5.6.2 OUTER JOIN <---> ����Ŭ JOIN���� (+)�� ����ϴ� OUTER JOIN�� ���� ����� �ϴ� ANSI JOIN
-- ����Ŭ JOIN�� OUTER JOIN�� ���� �������� ��� (+) �ٿ���.
-- ANSI JOIN�� OUTER JOIN�� FROM���� [LEFT|RIGHT|(FULL)] OUTER JOIN�� ����ϰ�,
-- JOIN ������ ON���� ����Ѵ�.

[���� 5-16] ����� ���, �̸�, �μ��ڵ�, �μ��� ������ ��ȸ
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E FULL OUTER JOIN DEPARTMENTS D -- INNER: ��������
ON   E.DEPARTMENT_ID = D.DEPARTMENT_ID  -- WHERE ��� ON �Ǵ� USING(���� �÷���)
ORDER BY 1;

-- OUTER JOIN���� FULL ������ �߻�
-- ORA-00905: ������ Ű����
-- 00905. 00000 -  "missing keyword"

-- [LEFT|RIGHT|(FULL)]
-- 1) ON ���� �������� �Ǵ�
-- 2) USING ���� �������� ���

-- 5.6 ANSI JOIN  /  ANSI ��ȸ���� ���� ǥ�� JOIN ��(ORACLE�ܿ��� MYSQL, CUBRID, ��Ÿ RDBMS ���� JOIN)


-- 5.7 OUTER JOIN