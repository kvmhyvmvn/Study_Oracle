-- 1. �����Ͱ� ��� ���̺� ������ ��ȸ ���
-- DESC ���̺��;
-- DESCRIBE ���̺��;
-- describe ���̺��;
-- ��ҹ��� �������� ����
-- ���� ����â [+] ������ ���� ���! (���� Ȯ��)

desc departments;
-- ������ ���̺��� ��� ��ȸ�غ�����!

-- 2. �����͸� ��ȸ�ϴ� SELECT
-- SELECT * FROM ���̺��;
SELECT * FROM EMPLOYEES;
/*
    SELECT *
    FROM     ���̺��;
*/
-- ���� ���ӿ��� �� ���̺��� ����Ŭ���ϰ�, [������] �÷��� Ŭ���ϸ� ���� ���!

SELECT * FROM COUNTRIES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;



DESC EMPLOYEES;
SELECT *
FROM EMPLOYEES;
/*
HR ��Ű���� �ִ� ���̺�(=����Ŭ �����ͺ��̽� ��ü�� �ϳ�)
==================================================================
�̸�              ����
------------------------------------------------------------------
COUNTRIES         ����/���� ����(���� �ڵ�, �̸�, ���� �ڵ�)
DEPARTMENTS       �μ� ����(�μ� �ڵ�, �μ� �̸�, ����� �ڵ�, ��ġ �ڵ�) 
EMPLOYEES         ��� ����(��� �ڵ�, �̸�, ��, �̸���, ��ȭ��ȣ, �Ի���, ���� �ڵ�, �޿�, Ŀ�̼���, ����� �ڵ�, �μ� �ڵ�)
JOB_HISTORY         
JOBS              
LOCATIONS         
REGIONS           
*/

-- 2.1 ���̺� ����
-- ����Ŭ (=�����ͺ��̽� ���� �ý���)�� �����͸� 2���� ����(ǥ, table�� ��� ��)�� �⺻������ ����
-- ���̺�: � ������ �ִµ� <--> �����ͺ��̽�: ����(Relation)
/*
��� ���� ���̺�
��� �ڵ�   ��� �̸�(��,�̸�)   �μ�   �Ի���   �޿� ....
----------------------------------------------------------
1           �浿 ȫ               IT   23-02-01  2000000 
1           �浿 ȫ               IT   23-02-01  2000000
1           �浿 ȫ               IT   23-02-01  2000000
1           �浿 ȫ               IT   23-02-01  2000000

�� ���� ���̺�
�� �ڵ�    ����     ���      ����ó        �ٹ���
-----------------------------------------------------------
1000         �̼���     ���     010.123.456     ����
1000         �̼���     ���     010.123.456     ����
1000         �̼���     ���     010.123.456     ����
1000         �̼���     ���     010.123.456     ����
*/


-- �� Document : ��,�� ������ �ƴ� vs RDBMS : ���̺�(��,��)
/*
�� ��(Column) : ���� ���� [�� �̸�(=Ư��), ���� �ڷ���(����,����,��¥..), ����]
�̸�           ��?       ����            <---- ��(ROW), ���� ����   
------------ -------- ------------ 
COUNTRY_ID   NOT NULL CHAR(2)      
COUNTRY_NAME          VARCHAR2(40) 
REGION_ID             NUMBER  

COUNTRY_ID COUNTRY_NAME                              REGION_ID
-- ---------------------------------------- ----------
AR          Argentina                                         2   : ���ι����� ������ �����͸� ����(Ʃ��,���ڵ�)
AU          Australia                                         3
BE          Belgium                                           1
*/


-- ��ҹ��� ���� x
-- ����, TAB�� ����ؼ� ������ �ְ�!
-- ������ ��(clause) ������ �ۼ�
-- �ڵ��ϼ� ������! �ٵ�, ���� �����ۼ� ����!


-- 2.1 DESC / DESCRIBE : ���̺��� ���� ==> �� �̸�, �ڷ���, (������ �� �ִ� ������) ���� Ȯ��
--     SELECT : �����͸� ��ȸ ==> ���̺��� ���ڵ� (ROW �Ǵ� Tuple/Ʃ��) 

SELECT *        -- SELECT ��
FROM    employees;  -- FROM ��
-- ��� ������ �߰�..

-- 2.2 ������
-- �ʿ��� ������ ��ȸ�ϱ� ���� ����, ������ ���͸�!
SELECT �� �̸�1, ���̸�2, ���̸�3,...
FROM    ���̺��;

-- * : �ֽ��͸���ũ, All (��� �÷�)
SELECT * 
FROM countries; -- 25rows

SELECT *
FROM    departments; -- 27rows

[���� 2-3] 80�� �μ��� ��� ������ ��ȸ ==> 80�� �μ��� �ٹ��ϴ� ������� ���͸�!
-- CTRL+ENTER or ������� + F5 
SELECT *
FROM    employees 
WHERE   department_id = 80; -- �� 107���� 80�� �μ��� �ٹ��ϴ� ����� 34��(rows)
-- ����Ŭ ������ : = (����), ����x

-- 80�� �μ��� �μ��̸��� ��ȸ�Ͻÿ�!
SELECT *
FROM    departments
WHERE   department_id = 80; -- Sale �μ� : �Ǹ� �μ� --> �Ҽ��� ���� �ʿ��� �μ�

-- Sales �μ�(80)�� ��ġ�� ��ġ ������ ��ȸ�غ��ÿ�! (�����ּ�, �����ȣ, ���� �ڵ�)
-- LOCATION_ID�� ã�Ƽ�, LOCATIONS ���̺� LOCATION_ID�� ��ġ�� ����
SELECT location_id ��ġ�ڵ� -- ��Ī(Alias) : �÷��� �̸��� ���� ǥ��
FROM    departments
WHERE   department_id = 80;   -- �μ��ڵ�� ���͸�, 2500
--WHERE   department_name = 'Sales'; -- �μ��̸����� ���͸�
--WHERE   department_name = 'sales'; -- ���ڴ� '�� �ۼ�, ��/�ҹ��ڸ� ���� [��¥ �����͵� '��]

-- ��ġ������ ã�ƺ���,
SELECT  city, street_address, postal_code
FROM    locations
WHERE   location_id = 2500;

--   �μ��ڵ�    �μ���    �μ���ġ ���ø�   �μ��� �����ּ�    �μ��� �����ȣ
--      80        Sales        Oxford             Magdalen~      OX9 9ZB

SELECT *
FROM    job_history; -- 10 rows

SELECT *
FROM    jobs; -- 19rows

SELECT * 
FROM    locations; -- 23rows

SELECT *
FROM    regions; -- 4rows

-- �̱��� � ȸ���� ���� : ȸ�翡 �ٹ��ϴ� ����� �߽����� �̵��� �Ҽӵ� �μ�, �ϴ� ����, 
-- ����(����/���)���� ����  [���� �Ը�, �н��� ������/���� ������x]

/*
    WHERE �������� �����ϴ� �׸��� �з�
    1) �÷�, ����, ����
    2) ��������� (+,-,*,/), �񱳿�����(=, <=, <, >, >=, !=, <>, ^=),  -- MOD(����, ������): % ��� ����ϴ� �Լ�
    3) AND, OR, NOT
    4) LIKE, IN, BETWEEN, EXISTS
    5) IS NULL, IS NOT NULL
    6) ANY, SOME, ALL
    7) �Լ�
*/

-- 2.3 ������
-- 2.3.1 ��� ������: +, -, *, /
-- MOD(����, ������) : % ��� ����ϴ� �Լ�
-- ��������ڴ� SELECT ��ϰ� �������� ����� �� �ֽ��ϴ�.

SELECT 2+2 "��"
FROM dual; --4
-- ���� �������� �ʴ� ���̺� dual, �ܼ��� ��������̳� �ý��� ��¥ ����ϰų� �Լ� ����, ��ȯ�� Ȯ��

SELECT 2-1 AS ��
FROM dual;
-- ������ DB������ �⺻������ ����Ŭ ��ü��(=���̺�) �빮�ڷ� �ۼ��ϴµ�,
-- �ҹ��� ���̺������ �ۼ��Ϸ��� ������ �� "�ҹ���"�� ����� ó��!
-- ORA-00942: ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�.
-- 00942. 00000 - "table or view does not exist"

SELECT 2 * 4 AS ��
FROM dual;

-- ��� ���� AS: ���� ����������, SELECT ���� ���������� ������ ���鿡�� AS�� �߰��ϴ� �����ڰ� ����
-- ��� ��谡 ����

SELECT 2 * 4 AS ��, 2 - 1 AS ��, 2 * 3 AS ��, 2 / 3 ��
FROM dual;

-- 2) WHERE ������
SELECT employee_id, last_name, salary, salary * 12 AS ����, department_id
FROM employees
--WHERE department_id = 80; --80�� �μ��� �ٹ��ϴ� ����� ���� ��ȸ, 34 rows
WHERE salary * 12 >= 100000;

[����2-4] 80�� �μ� ����� �� �� ���� ���� �޿��� ��ȸ�Ѵ�.
SELECT employee_id AS ���, last_name AS ��, salary * 12 AS ����
FROM employees
WHERE department_id = 80;  -- Sales �μ�, 34 rows

[����2-4] �� �� ���� ���� �޿��� 120000 ($, USD)�� ����� ���� ��ȸ
-- NLS ������ : �ڵ����� ����Ŭ�� ��ȭ�� �����Ǿ� ����.
-- �ٸ�, hr ��Ű���� �����ʹ� ���� �����ͷ� �ڿ������� USD�� ������ �� ����.
SELECT employee_id, last_name, salary * 12 || '$' AS "����", department_id
FROM employees
WHERE salary * 12 = 120000; -- ���� ������ ����� �÷��� ������, salary �÷��� 12�� ���ؼ� ���������� ��ȸ, ��

SELECT employee_id, last_name, first_name, salary * 12 ||' ' || '$' AS "����", department_id
FROM employees
WHERE salary * 12 = 120000; -- ���� ������ ����� �÷��� ������, salary �÷��� 12�� ���ؼ� ���������� ��ȸ, ��
-- ���ڿ� ���� ������ : ||
-- ���ڿ� ���� �Լ� : CONCAT()
-- ���� ������, ���� ������ : '�� ����

[����2-6] ����� 101���� ����� ������ ��ȸ�Ѵ�.
SELECT employee_id, last_name || ' ' || first_name AS ����, salary, job_id, department_id
FROM employees
WHERE employee_id = 101;

-- 90�� �μ� : 
SELECT department_name
FROM departments
WHERE department_id = 90; -- �濵��

-- �÷��� ��Ī(Alias) : �÷��� ��Ī, �� �ٿ� ����� �� �ִ�.
-- 1) �÷��� (����) ��Ī : ' '
-- 2) Ű���� AS �Ǵ� as ��� -- ������ ���鿡���� SELECT ���� ���������� AS�� �߰��ϴ� ���
-- 3) ū ����ǥ�� ����� �� �ִ�(���� ����), �� �÷��� ������ ������ ���� �ݵ�� ū ����ǥ�� ���� ��

[���� 2-8] ����� 101���� ����� ���� ���� ���� ���� �޿��� ��ȸ
-- ��: name �̶�� ��Ī
-- �� �� ���� ���� �޿�: ANNUAL SALARY ��� ��Ī

SELECT employee_id AS ���, last_name ��, salary * 12 AS "ANNUAL SALARY"
FROM employees
WHERE employee_id = 101;

-- 2.3.3 �񱳿�����
-- ���� ũ�⸦ �� : =, >=, >, <, <=

[���� 2-9] �޿��� 3000 ������ ����� ������ ��ȸ�Ѵ�.
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary <= 3000;  -- 26 rows, 30�� 30�� �μ��� �Ҽ�

[���� 2-10] �μ��ڵ尡 80�� �ʰ��� ����� ������ ��ȸ�Ѵ�.
-- �μ��ڵ� : department_id
-- ����ڵ� : employee_id
-- �����ڵ� : job_id
-- �μ����ڵ� : manager_id

SELECT * 
FROM employees
WHERE department_id > 80; -- 90�� ���� ������ �μ��� 11 rows

-- departments �����͸� Ȯ��
SELECT *
FROM departments; -- 27 rows, 10 ~ 270 �μ��ڵ�

-- ���ڵ�����, ��¥�����ʹ� ���� ����ǥ(')�� ��� ǥ���ؾ� �մϴ�.
-- ���ڵ����ʹ� ��, �ҹ��ڸ� �����մϴ�.

SELECT *
FROM employees
WHERE last_name = 'Chen';

SELECT 'hanul' AS company_name, employee_id, last_name, hire_date
FROM employees
WHERE hire_date < '05/09/28'; -- ��/��/�� : ����, ���߿� �Ի��� ����� ����

DESC employees;

[���� 2-11] ���� King�� ����� ������ ��ȸ
SELECT employee_id, last_name, email, phone_number, hire_date
FROM employees
WHERE last_name = 'King';

[���� 2-12] �Ի����� 2004�� 1�� 1�� ������ ����� ������ ��ȸ�Ѵ�.
SELECT 'hanul' AS company_name, employee_id, last_name, hire_date
FROM employees
--WHERE hire_date < '04/01/01'; -- 14 rows
WHERE hire_date <= '03/12/30'; -- 14 rows



