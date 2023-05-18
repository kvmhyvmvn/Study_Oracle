[연습문제 6-2]

1. 부서위치코드가 1700에 해당하는 모든 사원의 사번, 이름, 부서코드, 업무코드를 조회하는 쿼리문을
다중 행 서브쿼리로 작성한다.
-- 결과가 여러개 비교 ==> IN, ANY(=SOME), ALL 이런거

-- 1.1 서브쿼리 없이 조회

-- 1.2 서브쿼리로 조회
SELECT  employee_id, first_name, department_id, job_id
FROM    employees
WHERE   department_id IN  ( SELECT department_id
                          FROM  departments
                          WHERE location_id = 1700 );   -- 18rows
                          
SELECT department_id, department_name
FROM  departments
WHERE location_id = 1700; -- 10, 30, 90, 100, 110   /  120~270: 부서만 존재, 사원은 소속x

-- 가장 급여를 많이 받는 : MAX(SALARY) ==> 단일 행 함수 ==> 단일 행 서브쿼리 특징!! 
2. 부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호, 급여, 업무코드를 조회하는 쿼리문을
다중 컬럼 서브쿼리를 사용하여 작성한다.
-- 컬럼의 개수, 데이터가 일치하는 여러 컬럼/행을 비교

SELECT  employee_id, first_name, department_id, salary, job_id
FROM    employees
WHERE   (department_id, salary) = ANY ( SELECT department_id, MAX(salary)
                                        FROM    employees
                                        GROUP BY department_id );
                   