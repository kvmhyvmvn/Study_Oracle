[연습문제5-2]

1. 사번이 110, 130, 150에 해당하는 사원의 사번, 이름, 부서명을 조회하는 쿼리문을 ANSI JOIN으로 작성
--                    SQL                              vs                     NoSQL
-- 오라클 학습 ==> 회사~ 조인!! [MySQL, MSSQL,..]            mongoDB, firebase,.. [DOCUMENT, COLLECTION]

SELECT  e.employee_id, e.first_name,
        d.department_name
FROM    employees e INNER JOIN departments d
ON      e.department_id = d.department_id
AND     e.employee_id IN (110, 130, 150); -- 107rows

2. 모든 사원의 사번, 이름, 부서명, 업무코드, 업무제목을 조회하여 사번 순서로 정렬하는 쿼리를 작성

SELECT  e.employee_id, e.first_name,
        d.department_name,
        j.job_title
FROM    employees e LEFT OUTER JOIN departments d
ON      e.department_id = d.department_id
INNER JOIN jobs j
ON      e.job_id = j.job_id
ORDER BY 1; -- 107 rows

-- 오라클 OUTER JOIN
SELECT  e.employee_id, e.first_name,
        d.department_name,
        j.job_title
FROM    employees e, departments d, jobs j
WHERE      e.department_id = d.department_id(+)
AND      e.job_id = j.job_id
ORDER BY 1;
