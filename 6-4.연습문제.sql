[연습문제6-4] 

-- 예제6-28 급여가 많은 상위 10명!
1. 급여가 적은 상위 5명 사원의 순위, 사번, 이름, 급여를 조회하는 쿼리문을 인라인 뷰 서브쿼리로
작성한다.

SELECT  ROWNUM AS rank, 
        RANK() OVER(ORDER BY e.salary ASC) AS rank1,
        DENSE_RANK() OVER(ORDER BY e.salary ASC) AS rank2,        
        e.*
FROM    (   SELECT  employee_id, first_name, salary
            FROM    employees
            ORDER BY    salary ASC ) e
WHERE   ROWNUM <= 5;        

-- 순위함수

2. 부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호, 급여, 업무코드를 조회하는 쿼리문을
인라인 뷰 서브쿼리를 사용하여 작성한다.
-- p.57 다중컬럼 서브쿼리
-- p.62 인라인 뷰 서브쿼리

SELECT  department_id, MAX(salary)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;

-- 인라인 뷰 + 데이터 조회 <--> 순위로 정렬하는 건 아니지만,...
SELECT  employee_id, first_name, department_id, salary, job_id
FROM    employees e1,
        (   SELECT MAX(salary) AS max_sal
            FROM    employees
            WHERE   department_id IS NOT NULL
            GROUP BY department_id ) e2
WHERE   e1.salary = e2.max_sal
ORDER BY 3;

-- 인라인 뷰 가독성 문제 ==> WITH 절
WITH
e1 AS ( SELECT * FROM employees),
e2 AS ( SELECT MAX(salary) AS max_sal
            FROM    employees
            WHERE   department_id IS NOT NULL
            GROUP BY department_id )
SELECT  employee_id, first_name, department_id, salary, job_id
FROM    e1, e2
WHERE   e1.salary = e2.max_sal
ORDER BY 3;

-- 다중행 서브쿼리
--SELECT  사번, 이름, 부서번호, 급여, 업무코드
--FROM    
--WHERE   salary IN (   SELECT  MAX(salary)
--            FROM    employees
--            GROUP BY department_id
--            )
            

