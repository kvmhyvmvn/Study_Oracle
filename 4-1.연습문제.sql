[�������� 4-1]

1. ��� ���̺��� �� ȸ���� �Ŵ������� ��ȸ�Ͻÿ�
-- MANAGER_ID : ��� �� �Ŵ����� �ش��ϴ� ����� ��� (=EMPLOYEE_ID)
-- EMPLOYEE_ID
DESC EMPLOYEES;

SELECT DISTINCT MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

-- �Ŵ����� ���� ��� ==> BOSS
