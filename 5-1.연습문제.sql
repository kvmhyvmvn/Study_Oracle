[�������� 5-1]

1. �̸��� �ҹ��� v�� ���Ե� ��� ����� ���, �̸�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+) -- ����Ŭ �ƿ��� ����
AND E.FIRST_NAME LIKE '%v%';

2. Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼� �ݾ�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, Ŀ�̼� �ݾ��� ���޿��� ���� Ŀ�̼� �ݾ��� ��Ÿ����)
-- COMMISSION_PCT : NULL (�Ǹźμ��� �ƴ� �����)
-- NULL ó�� : �񱳴�� X => NVL(), NVL2()
-- Ŀ�̼� �ݾ� : SALARY * COMMISSION_PCT

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.COMMISSION_PCT * E.SALARY AS COMM_PCT, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND E.COMMISSION_PCT IS NOT NULL;

3. �� �μ��� �μ��ڵ�, �μ���, ��ġ�ڵ�, ���ø�, �����ڵ�, �������� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID,
       L.CITY, L.COUNTRY_ID, C.COUNTRY_NAME
FROM DEPARTMENTS D, LOCATIONS L, COUNTRIES C
WHERE D.LOCATION_ID = L.LOCATION_ID
AND   L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY 1;


4. ����� ���, �̸�, �����ڵ�, �Ŵ����� ���, �Ŵ����� �̸�, �Ŵ����� �����ڵ带 ��ȸ�Ͽ�
����� ��� ������ �����ϴ� �������� �ۼ��Ѵ�.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID,
       M.EMPLOYEE_ID AS MANAGER_ID, M.FIRST_NAME AS MANAGER_NAME, M.JOB_ID AS JOB_ID
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID; -- 106 ROWS, ����� : MANAGER_ID IS NULL

5. ��� ����� ���, �̸�, �μ���, ���ø�, �����ּ� ������ ��ȸ�Ͽ� ��� ������ �����ϴ�
�������� �ۼ��Ѵ�.

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY, L.STREET_ADDRESS
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND   D.LOCATION_ID = L.LOCATION_ID(+)
ORDER BY 1;
