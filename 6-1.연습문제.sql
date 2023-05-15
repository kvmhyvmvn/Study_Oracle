[연습문제 6-1]

1. 급여가 가장 적은~ 사원의 사번, 이름, 부서(명), 급여를 조회한다.

SELECT  e.employee_id, e.first_name, e.last_name,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
AND     salary = ( SELECT MIN(salary) AS max_sal
                    FROM    employees ); -- 최저급여자 TJ Olson은 배송(=물류) 부서이다.

2. 부서명 Marketing인 부서에 속한 모든 사원의 사번, 이름, 부서코드, 업무코드를 조회하는 쿼리를 작성

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME LIKE 'Marketing';

-- 메인쿼리
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME LIKE 'Marketing');
                       
3. 회사의 사장보다 더 먼저 입사한 사원들의 사번, 이름, 입사일을 조회하는 쿼리문을 작성
-- 사장은 그를 관리하는 매니저가 없는 사원이다.
-- 3.1 사장의 입사일 조회
SELECT HIRE_DATE
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 3.2 입사일을 비교해서 더 먼저 (입사일이 더 작은 ==> 이른..)
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE < (SELECT HIRE_DATE
                   FROM EMPLOYEES
                   WHERE MANAGER_ID IS NULL)
ORDER BY 3;
