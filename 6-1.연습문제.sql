[�������� 6-1]

1. �޿��� ���� ����~ ����� ���, �̸�, �μ�(��), �޿��� ��ȸ�Ѵ�.

SELECT  e.employee_id, e.first_name, e.last_name,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
AND     salary = ( SELECT MIN(salary) AS max_sal
                    FROM    employees ); -- �����޿��� TJ Olson�� ���(=����) �μ��̴�.

2. �μ��� Marketing�� �μ��� ���� ��� ����� ���, �̸�, �μ��ڵ�, �����ڵ带 ��ȸ�ϴ� ������ �ۼ�

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME LIKE 'Marketing';

-- ��������
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME LIKE 'Marketing');
                       
3. ȸ���� ���庸�� �� ���� �Ի��� ������� ���, �̸�, �Ի����� ��ȸ�ϴ� �������� �ۼ�
-- ������ �׸� �����ϴ� �Ŵ����� ���� ����̴�.
-- 3.1 ������ �Ի��� ��ȸ
SELECT HIRE_DATE
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 3.2 �Ի����� ���ؼ� �� ���� (�Ի����� �� ���� ==> �̸�..)
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE < (SELECT HIRE_DATE
                   FROM EMPLOYEES
                   WHERE MANAGER_ID IS NULL)
ORDER BY 3;
