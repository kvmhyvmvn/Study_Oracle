-- 7��. SET ������

-- ================================================================================
-- 5�� JOIN ����. ���̺�(�� �÷�)�� ���η� �����ϴ� ����
-- 7�� SET ����. ���̺�(�� ������/��)�� ���η� �����ϴ� ����
-- ================================================================================

-- SET �����ڷ� ���̴� �� SELECT���� (1) �÷��� �� (2) ������ Ÿ���� ��ġ�ؾ� �Ѵ�.
-- ��ȸ�Ǵ� �÷����� ù��° �������� �÷����� ���ȴ�.
-- ORDER BY ��� �������� ���� �������� ����Ѵ�.

-- 7.1 UNION : ������
-- ���տ��� �����տ� �ش��ϴ� ������, �ߺ��� ������ ���� ����� ��ȯ�Ѵ�.

[���� 7-1]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- ��ȸ�Ǵ� �÷����� �������� �÷����� ���ȴ�.
FROM DUAL
UNION -- ������ : SET ������
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM DUAL
UNION
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

[���� 7-2] �����ǰ� �ִ� �μ�, �����ǰ� �ִ� ���� ���� ��ȸ
SELECT DEPARTMENT_ID AS CODE, DEPARTMENT_NAME AS NAME
FROM DEPARTMENTS
UNION
SELECT LOCATION_ID, CITY
FROM LOCATIONS
UNION
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;

-- 7.2 UNION ALL : ������
-- UNION (�ߺ�����) VS UNION ALL (�ߺ�����)   /   ���� ����� ��ȯ�Ѵ�.

[���� 7-4]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- ��ȸ�Ǵ� �÷����� �������� �÷����� ���ȴ�.
FROM DUAL
UNION ALL -- ������ : SET ������
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM DUAL
UNION ALL
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

-- 7.3 INTERSECT : ������
-- ����� ���� ����� ��ȯ�Ѵ�.

SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- ��ȸ�Ǵ� �÷����� �������� �÷����� ���ȴ�.
FROM DUAL
INTERSECT -- ������ : SET ������
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- ��ȸ�Ǵ� �÷����� �������� �÷����� ���ȴ�.
FROM DUAL
UNION -- ������ : SET ������
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD
FROM DUAL;

[���� 7-7] 80�� �μ��� 50�� �μ��� �������� �ִ� ����� �̸��� ��ȸ
SELECT FIRST_NAME AS NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
INTERSECT
SELECT FIRST_NAME AS NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT DISTINCT FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (80, 50);

-- 7.4 MINUS : ������
-- ���տ��� �����տ� �ش��ϴ� ������

[���� 7-9] 80�� �μ����� �̸����� 50�� �μ����� �̸��� ����
-- �����ϰ� 80�� �μ����� �����ϴ� �μ����� �̸�
-- ���� : Peter, John (INTERSECT ���� ���)

-- A - B
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
MINUS
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;
