/* ===================================================
   [�������� 2-1] (p.18)
   �� HR �������� �ǽ��ϼ���!
=================================================== */

-- 1. ����� 200�� ����� �̸��� �μ���ȣ�� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT first_name ||' '|| last_name AS name, department_id
FROM employees
WHERE employee_id = 200;

-- 2. �޿��� 3000���� 15000 ���̿� ���Ե��� �ʴ� ����� ���, �̸�, �޿� ������ ��ȸ�ϴ� �������� �ۼ��Ѵ�.
-- (��, �̸��� ���� �̸��� ���鹮�ڸ� �ξ� ���ļ� ��ȸ�Ѵ�. ������� �̸��� John �̰�, ���� Seo�̸� 
-- John Seo�� ��ȸ�Ѵ�)

SELECT employee_id, first_name||' '||last_name AS name, salary
FROM employees
WHERE salary NOT BETWEEN 3000 AND 15000;

-- 3. �μ���ȣ 30�� 60�� �Ҽӵ� ����� ���, �̸�, �μ���ȣ, �޿��� ��ȸ�ϴµ� �̸��� ���ĺ� ������ �����Ͽ�
-- ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT employee_id, first_name || ' ' || last_name AS name, department_id, salary
FROM employees
WHERE department_id = 30 OR department_id = 60
ORDER BY first_name ASC;

-- 4. �޿��� 3000���� 15000 ���̸鼭, �μ���ȣ�� 30 �Ǵ� 60�� �Ҽӵ� ����� ���, �̸�, �޿��� ��ȸ�ϴ�
-- �������� �ۼ��Ѵ�(��, ��ȸ�Ǵ� �÷����� ���� �̸��� ������ �ξ� ���� name����, �޿��� Monthly Salary��)

SELECT employee_id, first_name ||' '|| last_name AS name, salary AS "Monthly Salary"
FROM employees
WHERE salary BETWEEN 3000 AND 15000
AND department_id = 30 OR department_id = 60;

-- 5. �Ҽӵ� �μ���ȣ�� ���� ����� ���, �̸�, ����ID�� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT employee_id, first_name ||' '|| last_name, job_id
FROM employees
WHERE department_id IS NULL;

-- 6. Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϴµ� Ŀ�̼��� ���� ������� ���� ��� ������
-- �����Ͽ� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT employee_id, first_name || ' ' || last_name AS name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY commission_pct DESC;

-- 7. �̸��� ���� z�� ���Ե� ����� ����� �̸��� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT employee_id, first_name || ' '|| last_name AS name
FROM employees
-- WHERE���� Alias ��� X
WHERE first_name || ' ' || last_name LIKE '%z%';

