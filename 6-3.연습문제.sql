[�������� 6-3]

1. �� �μ��� ���� �μ��ڵ�, �μ���, �μ��� ��ġ�� �����̸��� ��ȸ�ϴ� ��������
��Į�� ���������� �ۼ��Ѵ�.
-- ��ȣ���� �������� ����: �������� �÷��� ���������� ���� �������� ���Ǵ�--> ���������� ����?
SELECT DEPARTMENT_ID, DEPARTMENT_NAME,
       (SELECT CITY
        FROM LOCATIONS L
        WHERE L.LOCATION_ID = D.LOCATION_ID) AS CITY_NAME
FROM DEPARTMENTS D;