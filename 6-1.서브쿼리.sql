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
WHERE COUNTRY_ID = 'UK'; -- 2400, 2500, 2600 : ������ �μ� ������~

-- 2. ��������
SELECT  DEPARTMENT_ID, LOCATION_ID, DEPARTMENT_NAME
FROM    DEPARTMENTS
--WHERE   LOCATION_ID = (2400, 2500, 2600); 
WHERE   LOCATION_ID = 2400
OR      LOCATION_ID = 2500
OR      LOCATION_ID = 2600;
-- WHERE    LOCATION_ID IN (2400, 2500, 2600)
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�  ==> = ANY () �� = ALL () ���·� �ۼ�
-- 01797. 00000 -  "this operator must be followed by ANY or ALL"

/*

> ANY : (�������� ���࿡ ���� ��ȯ����� ���������)  > �ּҰ�(MIN�Լ�) �� ����.
< ANY : (�������� ���࿡ ���� ��ȯ����� ���������)  < �ּҰ�(MAX�Լ�) �� ����.
= ANY : ��ġ�ϴ� �� �ϳ��� ������ TRUE ��� (�������� ���� ����� �������� ��ȯ�Ҷ�) ==> IN ������
= ALL : (�������� ���࿡ ���� ��ȯ����� ���������)  = ��� ����� ���ؼ� TRUE���� �ϴ� ���� ==> 
        ����� �ȳ����� ���
> ALL : (�������� ���࿡ ���� ��ȯ����� ���������) > �ִ밪(MAX�Լ�) �� ����.         
< ALL : (�������� ���࿡ ���� ��ȯ����� ���������) > �ּҰ�(MIN�Լ�) �� ����.         

NOT IN : <> ALL�� ���� ��� 
*/

[����6-10] 100�� �μ��� ����� �޿����� ���� �޿��� �޴� ����� ���, �̸�, �μ���ȣ, �޿��� �޿���
������������ ��ȸ�Ѵ�.

-- �׷��Լ� : COUNT(*) or COUNT(�÷���) or COUNT(DISTINCT �÷���)
-- COUNT() : NULL ����
-- 100�� �μ��� ��ȸ ==> �׷캰 ����� �� ����
SELECT department_id, COUNT(*) AS cnt
FROM    employees
GROUP BY department_id
ORDER BY 1;

SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE   department_id = 100
ORDER BY 3;


SELECT  employee_id, first_name, department_id, salary
FROM    employees
WHERE   salary < ALL (  SELECT   salary
                    FROM    employees
                    WHERE   department_id = 100 )  -- 6900, 7700, 7800, 8200, 9000, 12008
ORDER BY salary;                    
-- ORA-01427: ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�. ==> ANY ? ALL! 

-- 6.2.2 NOT ������
-- NOT IN �����ڿ� <> ALL�� ���� ���
-- ^=, <>, != : ��������

[����6-16] �μ����̺��� �μ��ڵ尡 10,20,30,40�� �ش����� �ʴ� �μ��ڵ带 ��ȸ
SELECT department_id, department_name
FROM    departments
WHERE   department_id NOT IN (10,20,30,40); -- ��ü�μ� : 27�� (10 ~ 270)  ==> <> ALL ���� ���

SELECT department_id, department_name
FROM    departments
WHERE   department_id <> ALL (10,20,30,40); -- 23rows

SELECT department_id, department_name
FROM    departments
WHERE   department_id <> ANY (10,20,30,40); -- 27rows ==> 10�� ��, 20~270 / 20�� �� , 10,30~270
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�

SELECT department_id, department_name
FROM    departments
WHERE   department_id <> (10,20,30,40);
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�

SELECT department_id, department_name
FROM    departments
WHERE   department_id != (10,20,30,40);
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�
-- NOT IN �����ڿ� <> ALL�� ������ ����� �Ѵ�.

-- 6.2.3 ANY(=SOME) ������
-- 6.2.4 ALL ������



-- 6.3 (���� ��, ���� ��) ���� �÷� ��������
-- ���������� ��������ó�� �������� �÷��� (���ϴµ�) ����� �� �ִ�.
-- WHERE ���� (�÷���1, �÷���2...) ó�� �ۼ�
-- �÷��� ������ ������ Ÿ���� ��ġ�ؾ� ��

[���� 6-18] �Ŵ����� ���� ����� �Ŵ����� �ִ� �μ��ڵ�, �μ����� ��ȸ�Ѵ�.
-- ���������� ��� ��ȸ�� ����! ==> ���������� ������� �˸�, ������ �����ϰ� ���� �� �ִ�.
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE (DEPARTMENT_ID, MANAGER_ID) IN (SELECT DEPARTMENT_ID, EMPLOYEE_ID
                                              FROM EMPLOYEES
                                              WHERE MANAGER_ID IS NULL);
                                              
-- �����÷� �������� ==> �ѹ��� �ΰ� �̻��� �÷��� ���ϴ� ��������
-- �з� ==> ���� ������� ���� �� ���� ==> ���� ���� VS �����Ҽ���?

-- ======== ���� �� / ���� �� / ���� �÷� ��������
-- 6.4 ��ȣ���� ��������(p.57) / EXISTS ������(��ȣ���������������� ���)
-- ��ȣ : ���� / ����: ���� / ���� => JOIN���� VS SET����
-- ���������ε� JOIN ������ Ȱ���� ��������
-- ���������� �÷��� ���������� �������� ���Ǿ� ���������� ���������� ���� ����

[���� 6-19] �Ŵ����� �ִ� �μ��ڵ忡 �Ҽӵ� ������� ���� ��ȸ
-- ���� ��� �� ����� ��ȯ�ϴ� �Լ� : COUNT() / �׷��Լ�
-- �Ŵ����� ���� �μ��ڵ� : 90�� VS �Ŵ����� �ִ� �μ��ڵ� 10  ~ 80, 100 ~ 110

SELECT  COUNT(*) AS �����
FROM    employees e
WHERE   department_id IN ( SELECT    department_id
                           FROM      departments d
                           WHERE     manager_id IS NOT NULL
                           AND       e.department_id = d.department_id );
-- ������̺��� �μ��ڵ尡 NULL�� ��� : 1�� / Ŵ����~
-- NULL ó�� �Լ� : NVL(), NVL2(), COALESCE()
                           
-- IN �����ڸ� EXISTS �����ڷ� �ٲ� ����� �� �ִ�.
SELECT  COUNT(*) AS �����
FROM    employees e
WHERE   EXISTS ( SELECT    1
                 FROM      departments d
                 WHERE     manager_id IS NOT NULL
                 AND       e.department_id = d.department_id );
-- ORA-00920: ���� �����ڰ� �������մϴ� : IN ��� EXISTS�� ����Ҷ��� WHERE���� �� �÷��� ����� ��.
-- EXISTS �����ڴ� ���������� ����� ���� ���θ� �Ǵ��Ѵ� ==> 
-- EXISTS �����ڸ� ����Ҷ�, ���������� SELECT ��ϰ��� ������ ���� ���� �÷����� JOIN ������ �ٽ��̴�.
-- �����÷� ������������ �з��� �� �� �ִ� --> ������ ���� �ִ� --> �� ���� ����� �� �ִ�??
-- ��ȣ���� ���������� �������� ������� ���������� ���� ==> �ӵ����̰� �߻��� �� �ִ�!

-- ============ ���������� ���� ���� =================================================================
-- 1) �������� ����࿡ ���� ���� : ���� ��, ������, ���� �÷���
-- 2) �������� ���� ����(=JOIN���� ���) : ��ȣ���� ��������
-- 3) �������� �����ġ�� ���� ���� : ��Į�� ��������, �ζ��� �� ����������, (�Ϲ�, WHERE���� )����������
-- ==================================================================================================

-- 6.5 ��Į�� ��������
-- ��Į�� : (����) ������ ���� �ʰ� ũ�⸸ ���� ����(1����) VS ���� : ũ��� ������ ��� ���� ����(2����)
-- SELECT ���� ����ϴ� �������� ==> SELECT ���� �÷��� �ۼ��ϴ� ��(CLAUSE, ��)
-- �ڵ强 ���̺��� �ڵ���� ��ȸ�ϰų� �׷��Լ��� ������� ��ȸ�Ҷ� ����Ѵ�. / �ִ밪,�ּҰ�,�հ�,���,����..

[���� 6-22] ����� �̸�, �޿�, �μ��ڵ�, �μ����� ��ȸ
-- departments : �μ���
SELECT  first_name, salary, department_id,
        ( SELECT    department_name
          FROM      departments d
          WHERE     e.department_id = d.department_id ) AS department_name -- ��Į�� �������� , ������ ���� �������� - ��ȣ���� ��������
          --WHERE     NVL(e.department_id, 0) = d.department_id ) AS department_name
FROM    employees e;        

-- �ڵ强 ���̺�?? �μ���ձ޿��� ����ص� �������� ���̺��� ������, �ִ°�ó�� ���������� ��ȸ
[����6-23] ����� ���, �̸�, �޿�, �μ��ڵ�, �μ���ձ޿�
-- ROUND() : �Ҽ���/������ �ڸ����� �ݿø� �Լ�
-- AVG() : ��հ��� ���Ͽ� ��ȯ�ϴ� (�׷�)�Լ�
-- TO_CHAR() : �ڸ���, ������ȭ

SELECT  employee_id, first_name, TO_CHAR(salary, '999,999'), department_id, 
        ( SELECT    ROUND(AVG(salary))
          FROM      employees e1
          WHERE     e1.department_id = e2.department_id ) AS dept_avg_sal
FROM    employees e2;

-- 6.6 �ζ��� �� ��������
-- FROM ���� ���Ǵ� �������� ==> FROM���� ���̺� ���� ==> �ζ��� �� ��������
-- �� : ������ ���̺�(=�޸𸮿��� ����, ���� ����� �޸𸮿��� ����, ��� ��ȯ�ϰ� �����)
-- SELECT���� ���Ǵ� �������� => ��Į�� ��������
-- ���� ������ �������̰� ==> ������ ���̺��̴ϱ�
-- WHERE ���� ���� ������ ���̺�� JOIN�� ���� ���踦 �δ´�.

--> ������ WHERE���� �Ϲ����� �������� : ���� ���� ����Ѵ�.

[���� 6-24] �޿��� ȸ�� ��ձ޿� �̻��̰�, �ִ�޿� ������ ����� ���, �̸�, �޿�, ȸ����ձ޿�, ȸ���ִ�޿��� ��ȸ
-- HR ����: ȸ���� �޿� ��� ���� ���̺��� ���� ==> �������� �ִ� ��ó�� �������� ��ȸ

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
       AVG_SAL, MAX_SAL
FROM EMPLOYEES,
     (SELECT ROUND(AVG(SALARY)) AS AVG_SAL, MAX(SALARY) AS MAX_SAL
      FROM EMPLOYEES )
-- WHERE E.SALARY >= A.AVG_SAL
-- AND E.SALARY <= A.MAX_SAL;
WHERE SALARY BETWEEN AVG_SAL AND MAX_SAL;

-- JOIN ���� �� NON-EQUI JOIN ����: = �̿��� ������ ����ϴ� JOIN ����(���� �񱳿�����, BETWEEN, IN)
-- ���� ������� �ʴ� ����
-- NON-EQUI JOIN������ �ζ��� �� �������� ==> ���̺��� ��Ī�� AS�� �����ϰ�, �÷��� ���̴� ��� �����߻�

SELECT  e.employee_id, e.first_name, e.salary,
        a.avg_sal, a.max_sal
FROM    employees e,
        (   SELECT  ROUND(AVG(salary)) AS avg_sal, MAX(salary) AS max_sal
            FROM    employees  ) AS a 
--WHERE   e.salary >= a.avg_sal 
--AND     e.salary <= a.max_sal;
WHERE   e.salary BETWEEN a.avg_sal AND a.max_sal;  
-- ORA-00933: SQL ��ɾ �ùٸ��� ������� �ʾҽ��ϴ� : ��Ÿ�� �޸�, AND �������θ� Ȯ�� (������ü����)

[���� 6-25, 26] ���� �Ի� ��Ȳ ���̺��� ������, �ζ��� �� �������� ��������, ���� �Ի��� ��Ȳ�� ��ȸ
-- �䱸�Ǵ� ���̺��� ����
-- 1��  ...6��... 12��
-- 14(��)..11(��)...7��(��)
-- 1) ������� �ϳ��̴�.
-- 2) �÷��� ���� 1��~12������ 12��
-- 3) �����ʹ� ������� �հ��̴�.
-- DECODE / �Լ�     vs     CASE ~ END / ǥ����    <------> ����Ŭ IF~ELSE��!
--  ����񱳸�!                    �����, ������~
-- DECODE (exp, search1, result1,            CASE exp WHEN search1 THEN result      or  CASE WHEN condition THEN result
--              search2, result2,                      WHEN search1 THEN result 
--              ....���...                            ELSE �⺻��
--              0 ) AS ��Ī                  END AS ��Ī

--     TO_CHAR()       TO_DATE()
-- ���� --------> ���� ----------> ��¥
--     <--------- ���� <---------- ��¥
--    TO_NUMBER()       TO_CHAR()
-- ���� --> ��¥ ��ȯ�ȵǹǷ�, ��ȯ�Լ��� Ȱ��!
-- ��¥���� ==> NLS Ȯ�� �ʿ�!

SELECT  DECODE(TO_CHAR(hire_date, 'MM'), '01', COUNT(*), 0) AS "1��",
        DECODE(TO_CHAR(hire_date, 'MM'), '02', COUNT(*), 0) AS "2��",
        DECODE(TO_CHAR(hire_date, 'MM'), '03', COUNT(*), 0) AS "3��",
        DECODE(TO_CHAR(hire_date, 'MM'), '04', COUNT(*), 0) AS "4��",
        DECODE(TO_CHAR(hire_date, 'MM'), '05', COUNT(*), 0) AS "5��",
        DECODE(TO_CHAR(hire_date, 'MM'), '06', COUNT(*), 0) AS "6��",
        DECODE(TO_CHAR(hire_date, 'MM'), '07', COUNT(*), 0) AS "7��",
        DECODE(TO_CHAR(hire_date, 'MM'), '08', COUNT(*), 0) AS "8��",
        DECODE(TO_CHAR(hire_date, 'MM'), '09', COUNT(*), 0) AS "9��",
        DECODE(TO_CHAR(hire_date, 'MM'), '10', COUNT(*), 0) AS "10��",
        DECODE(TO_CHAR(hire_date, 'MM'), '11', COUNT(*), 0) AS "11��",
        DECODE(TO_CHAR(hire_date, 'MM'), '12', COUNT(*), 0) AS "12��"
FROM    employees
-- WHERE
GROUP BY TO_CHAR(hire_date, 'MM')
ORDER BY TO_CHAR(hire_date, 'MM');
-- �׷��Լ��� ���� �����κ��� �ϳ��� ������� ��ȯ�Ѵ�.

-- ���������� �ζ��� �� �ǽ���
-- ���� ==> ���輺 ���̺��� ���� DB�� �ݿ��ϰ�, ��� �濵�ϴµ� �ʿ��� �����ͷ� �����ؼ� �����ؾ���!
-- ���̺��� �����Ͱ� ��û���� ������, ���ε����� �����ϸ� ó���ӵ�/�����ð� ==> ���̺��� �Ϻθ� �����Ҷ� ���


