[연습문제 4-1]

1. 사원 테이블에서 이 회사의 매니저들을 조회하시오
-- MANAGER_ID : 사원 중 매니저에 해당하는 사원의 사번 (=EMPLOYEE_ID)
-- EMPLOYEE_ID
DESC EMPLOYEES;

SELECT DISTINCT MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

-- 매니저가 없는 사원 ==> BOSS
