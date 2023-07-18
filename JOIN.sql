-- JOIN의 종류
-- INNER JOIN A n B <- 교집합
-- LEFT RIGHT OUTER JOIN <- (A n B) U (A - B)
-- FULL JOIN (사용빈도 낮음) 사용하면 욕먹기 딱 좋음

-- [INNER or OUTER or FULL] [JOIN] ON key = key, 조건 = 조건
SELECT E.*
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 LEFT OUTER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
                 LEFT OUTER JOIN COUNTRIES C ON C.COUNTRY_ID = L.COUNTRY_ID
                 LEFT OUTER JOIN REGIONS R ON R.REGION_ID = C.REGION_ID;
-- FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.EMPLOYEE_ID = D.DEPARTMENT_NAME; JOIN이 정확히 안되어서
-- 결과 출력할 수 없다

select count(*) from employees;

-- select 절에 group 함수를 사용한 표현이 있는 경우,
-- group 함수가 사용되지 않은 모든 표현에 대해서는 group by의 기준으로 명시되어야 한다.

select e.department_id, count(*) count, nvl(d.department_name, '소속없음') department_name
from employees e left outer join departments d on e.department_id = d.department_id
group by e.department_id, d.department_name
order by e.department_id;

select count(*) from departments;