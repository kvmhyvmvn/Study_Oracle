[연습문제 4-2]

1. 사원 테이블에서 커미션을 받는 사원이 모두 몇명인지 그 수를 조회하는 쿼리문을 작성한다

SELECT COUNT(COMMISSION_PCT) AS "커미션 받는 사원 수"
FROM EMPLOYEES;

/*
SELECT *
FROM    employees
WHERE   commission_pct IS NOT NULL; -- 커미션율이 NULL 아닌 사람 ==> 판매부서원만 커미션 받음!
*/

2. 가장 최근에 뽑은 직원을 입사시킨 날짜가 언제인지 최근 입사일자를 조회하는 쿼리문을 작성한다.

SELECT MAX(HIRE_DATE)
FROM EMPLOYEES;

-- SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
-- FROM EMPLOYEES
-- ORDER BY 3 DESC;


3. 90번 부서의 평균급여액을 조회하는 쿼리문을 작성한다.
(단, 평균급여액은 소수 둘째자리까지 표기되도록 한다)
-- SUM(), AVG() : 숫자 데이터 컬럼의 합/평균을 계산하여 반환하는 함수
-- MAX(), MIN() : 모든 데이터 컬럼에 적용가능
-- ROUND(n [,i]) : 소수점 이하 i번째 자리로 반올림한 결과를 반환하는 함수
-- i가 음수면, 정수부에서 i번째 자리로 반올림한 결과를 반환하는 함수
-- 날짜데이터에도 ROUND(date [,fmt]) 형식으로 반올림한 결과를 반환

SELECT TO_CHAR(ROUND(AVG(SALARY), 2), '999,999') AS 평균급여액1,
       ROUND(AVG(SALARY), 2) AS 평균급여액2
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;