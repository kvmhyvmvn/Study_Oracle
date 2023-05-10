[연습문제3-3]

-- 1. 사원 테이블에서 30번 부서원의 사번, 성명, 급여, 근무 개월 수를 조회하는 쿼리문을 작성한다.
-- (단, 근무 개월 수는 오늘 날짜를 기준으로 날짜 함수를 사용하여 계산한다)

-- 날짜 함수
-- 1.개월수 n 더한 날짜 반환 : ADD_MONTHS(date, n)
-- 2.두 날짜 사이의 개월수를 계산, 반환 : MONTHS_BETWEEN(date1, date2) / date1:이후 날짜
-- 3. 원하는 컬럼 조회
-- 버림, 반올림 함수 ==> 소수점 첫째 자리 or 정수 처리

SELECT  employee_id, first_name, salary, 
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "근무 개월 수1",
        TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "근무 개월 수2"
FROM    employees -- 1. 테이블을 먼저 찾는다.
WHERE   department_id = 30; -- 2. 필터링, 6rows



-- 2. 급여가 12000 달러 이상인 사원의 사번, 성명, 급여를 조회하여 급여 순으로 결과를 정렬한다.
-- (단, 급여는 천단위 구분 기호를 사용하여 표시하도록 한다)
-- p.31 TO_CHAR(number [,fmt])
-- , : 천 단위 표기
-- 9 : 숫자 하나 표기
-- $ : 달러 표기
-- L : 지역(=나라) 통화기호 표기(WON, YEN, ...)

SELECT employee_id, first_name|| ' ' ||last_name AS name, LTRIM(TO_CHAR(salary, '99,999')) AS salary
FROM employees
WHERE salary >= 12000
ORDER BY salary DESC;



-- 3. 2005년 이전에 입사한 사원들의 사번, 성명, 입사일, 업무 시작 요일을 조회하는 쿼리문을 작성한다.
-- (단, 업무 시작 요일이란 입사일에 해당하는 요일을 지정한다)
-- TO_CHAR(date, 'YYYY') : 년도 4자릿수를 문자로 변환하여 반환하는 함수
-- 2004년 12월 31일 까지
-- 2005년 1월 1일 미만
-- NEXT_DAY(date, '요일형식') : 돌아오는 요일 반환하는 함수
-- LAST_DAY(date) : date의 달에 마지막 일자를 반환하는 함수

SELECT employee_id, first_name|| ' ' ||last_name AS name, hire_date,
       TO_CHAR(hire_date, 'DAY') AS "업무 시작 요일"
FROM employees
-- WHERE hire_date < '2005-12-31';
WHERE TO_CHAR(hire_date, 'YYYY') < '2005' -- 24rows
ORDER BY 3 DESC;


