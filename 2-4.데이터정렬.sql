-- 2.4 데이터 정렬
-- 많이 사용하지 않는게 좋다 ==> 성능 관련 (데이터베이스 관리자, 옵티마이저(=최적화), 튜너의 역할)
-- 기본적으로 해당 테이블의 식별자(=유일하게/중복되지 않는 데이터를 구분하는 어떤 값)
-- ex) 사람의 경우 주민번호
SELECT *
FROM employees
ORDER BY 컬럼명 [ASC|DESC] -- [] : 옵션, ASC(=기본값)
-- 정렬: SELECT 구문 이하에서 조회된 결과의 특정 컬럼을 기준으로 값을 오름차순, 내림차순 정렬
-- ASC: Ascending / 오름차순 : 작은 값 --> 큰 값
-- DESC: Descending / 내림차순 : 큰 값 --> 작은 값
-- ORDER BY는 너무 많이 사용하지 않는게 좋다.
-- 데이터베이스 내부에서 테이블 작성할 때 기본적으로 테이블의 식별자를 기준으로 정렬이 되게 해주는데,
-- 잘못 조회하게 되면 되려 조회속도가 떨어질 수 있음
-- 1) 데이터베이스 내부에서 정렬 [요즘 DB 성능이 워낙 뛰어나니까 권장]
-- 2) 애플리케이션(비동기통신 -- JSON 데이터 정렬)
-- ====================================================================================
-- desc or describe : 테이블의 구조 조회 (=테이블의 컬럼 정의, 자료형, 길이값)
-- ====================================================================================
-- ※ SELECT문의 가장 마지막에 ORDER BY를 작성한다 ※

SELECT *
FROM employees
ORDER BY employee_id ASC
WHERE 조건절; -- Wrong!

[예제 2-40] 80번 부서의 사원 정보에 대해 이름을 오름차순으로 정렬
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id = 80
ORDER BY first_name ASC; -- 오름차순은 생략 가능

[예제 2-41] 80번 부서의 사원 정보에 대해 이름을 내림차순으로 정렬
SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id = 80
ORDER BY first_name DESC; -- 내림차순은 생략 불가능

-- ======================================================================
-- ORDER BY 절에 컬럼명 또는 컬럼의 Alias(별칭, 약어)를 이용해 정렬 가능
--     "    컬럼의 위치값을 이용해           "
-- ======================================================================

-- p.16 ORDER BY 정렬대상;
-- 정렬 대상 컬럼이 1개가 아니라면?
-- 예) 성은 오름차순, 급여는 내림차순
SELECT employee_id, last_name, salary, department_id
FROM employees
--WHERE
ORDER BY last_name ASC, salary DESC;
-- 이름과 급여를 하나의 정렬 기준으로 조합해서 정렬

-- ======== HR 계정과 같은 사용자 계정으로 만들어진 테이블 조회
SELECT *
FROM user_tables;
