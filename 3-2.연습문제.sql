-- 연습문제3-2
-- 숫자함수, 문자함수 PART

1. 사원 테이블에서 이름(first_name)이 A로 시작하는 모든 사원의 이름과 이름의 길이를 조회한다
SELECT  first_name, LENGTH(first_name) AS name_length
FROM    employees
WHERE   first_name LIKE 'A%'; -- 10 rows

-- LENGTH(char) : 이름길이
-- LIKE 연산자
-- % : 여러 문자
-- _ : 하나의 문자
-- _ 자체를 인식 , \_     ESCAPE '\' 


/*
FIRST_NAME           NAME_LENGTH
-------------------- -----------
Amit                           4
Alexis                         6
Anthony                        7
Alberto                        7
Adam                           4
Alexander                      9
Alyssa                         6
Alexander                      9
Allan                          5
Alana                          5
*/

2. 80번 부서원의 이름과 급여를 조회하는 쿼리문을 작성한다.
(단, 급여는 15자 길이, 왼쪽에 $ 기호가 채워진 형태로 표시한다)
-- LPAD(char, n [,char2])

SELECT  first_name, LPAD(salary, 15, '$') AS salary, '$' || salary AS salary2
FROM    employees
WHERE   department_id = 80; --34 rows

3. 60번 부서, 80번 부서, 100번 부서에 소속된 사원의 사번, 이름, 전화번호, 전화번호의 지역번호를 조회한다
(단, 지역번호는 Local Number라고 표시하고, 지역번호 515.124.4169에서 515가 지역번호이다)
-- SUBSTR(char, position [,length])
-- INSTR(char, from_string, to_string [,_th] )

SELECT employee_id, first_name, phone_number, SUBSTR(phone_number, 1, INSTR(phone_number, '.') - 1) AS "Local Number", department_id
FROM    employees
WHERE   department_id IN (60, 80, 100); -- 45 rows
--WHERE   department_id = 60
--OR      department_id = 80
--OR      department_id = 100
--ORDER BY department_id ASC; -- 왠만하면 ORDER BY는 생략, 생략해도~ 테이블마다 기본적으로 정렬의 순서가 식별자에 맞춰져 있음


