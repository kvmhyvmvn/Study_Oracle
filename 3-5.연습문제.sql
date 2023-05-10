[연습문제3-5]

1. 사원의 사번, 이름, 업무, 업무등급을 조회하는 쿼리문을 DECODE 함수를 사용하여 작성한다.
단, 업무 등급은 다음과 같이 적용된다.

-- DECODE() .. exp, search1, result1, ... [,default] ...계속..
-- CASE WHEN~THEN [ELSE default] END : 콤마, 괄호 없음

SELECT  employee_id, first_name, job_id,
        DECODE(job_id, 'AD_PRES', 'A', 
                       'ST_MAN', 'B',
                       'IT_PROG', 'C',
                       'SA_REP', 'D',
                       'ST_CLERK', 'E',
                       'X') AS job_grade
FROM    employees
ORDER BY 4;

--------------------
업무           등급
--------------------
AD_PRES        A
ST_MAN         B
IT_PROG        C
SA_REP         D
ST_CLERK       E
기타           X
--------------------

-- DECODE() ==> CASE ~ END로 '동등비교' 표현

SELECT  employee_id, first_name, job_id,
        CASE job_id WHEN 'AD_PRES' THEN 'A'
                    WHEN 'ST_MAN' THEN 'B'
                    WHEN 'IT_PROG' THEN 'C'
                    WHEN 'SA_REP' THEN 'D'
                    WHEN 'ST_CLERK' THEN 'E'
                    ELSE 'X'
        END AS job_grade
FROM    employees
ORDER BY job_grade;

2. 사원의 사번, 이름, 입사일, 근무년수, 근속상태를 조회하는 쿼리문을 작성한다
단, 근무년수는 오늘 날짜를 기준으로 정수형태로 표기한다  ex> 3.56 ==> 3
근속상태는 근무년수   3년 미만  '3년 미만'
                      3년 ~ 5년  '3년근속'
                      5년 ~ 7년  '5년 근속'
                      8년 ~ 10년 '7년 근속'
                      10년~      '10년 이상 근속'
                      
-- 근무년수? 
-- MONTHS_BETWEEN(오늘, 입사일) : 두 날짜간 개월수를 반환하는 함수 ==> 개월수 / 12 ==> 년수
-- 날짜(년/월/일) 변환함수 : 오늘날짜 년수 - 입사일자 년수 
-- ※ 23년 기준, 근무년수 15 ~ 22년
--              10년 ~ 15년 미만 '10년 이상 근속'
--              15년 ~ 20년 미만 '15년 이상 근속'
--              20년 (이상) ~    '20년 이상 근속'

SELECT employee_id, first_name, hire_date AS 입사년도, 
       ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS 근무년수1,
       TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(hire_date, 'YYYY') AS 근무년수2, -- 묵시적 형변환(자동형변환)
       CASE WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) >= 10 AND ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) <15 THEN '10년 이상 근속'
            WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) >= 15 AND ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) <20 THEN '15년 이상 근속'            
            WHEN ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) >= 20 THEN '20년 이상 근속'            
            ELSE ' '
       END AS 근속상태
FROM    employees
ORDER BY 4 DESC, 5 DESC;