-- JOIN�� ����
-- INNER JOIN A n B <- ������
-- LEFT RIGHT OUTER JOIN <- (A n B) U (A - B)
-- FULL JOIN (���� ����) ����ϸ� ��Ա� �� ����

-- [INNER or OUTER or FULL] [JOIN] ON key = key, ���� = ����
SELECT E.*
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 LEFT OUTER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
                 LEFT OUTER JOIN COUNTRIES C ON C.COUNTRY_ID = L.COUNTRY_ID
                 LEFT OUTER JOIN REGIONS R ON R.REGION_ID = C.REGION_ID;
-- FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.EMPLOYEE_ID = D.DEPARTMENT_NAME; JOIN�� ��Ȯ�� �ȵǾ
-- ��� ����� �� ����

select count(*) from employees;

-- select ���� group �Լ��� ����� ǥ���� �ִ� ���,
-- group �Լ��� ������ ���� ��� ǥ���� ���ؼ��� group by�� �������� ��õǾ�� �Ѵ�.

select e.department_id, count(*) count, nvl(d.department_name, '�ҼӾ���') department_name
from employees e left outer join departments d on e.department_id = d.department_id
group by e.department_id, d.department_name
order by e.department_id;

select count(*) from departments;