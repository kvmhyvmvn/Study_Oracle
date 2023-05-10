[연습문제3-4]

1. 사원의 사번, 이름, 부서, 매니저번호를 조회하는 쿼리문을 작성한다
(단, 매니저가 있는 사원은 Manager, 매니저가 없는 사원은 No Manager라 표시하도록 한다)
-- 매니저_아이디 NULL : BOSS (대표자, 사장님/회장님)
-- 일반 사원 : 부서에 소속되어 있고, 관리하는 사원(=매니저)이 있다.
-- manager_id : 사원의 식별자 (사번 employee_id)
-- 변환함수 : 숫자     문자     날짜
--            number   char     date

DESC employees; -- DATE : 날짜, NUMBER : 숫자, VARCHAR2 : 문자 + 나머지 시시콜콜한 타입들이 있음

SELECT employee_id, department_id, NVL2(manager_id, TO_CHAR(manager_id), 'No Manager') AS manager
FROM employees;

-- 1) NVL(exp1, exp2) : exp1이 NULL이면 exp2 반환, 아니면 exp1 반환
-- 2) NVL2(exp1, exp2, exp3) : exp1이 NULL이면 exp3 반환, NULL 아니면 exp2 반환
-- 3) COALESCE(exp1, exp2,...) : 최초로 NULL 아닌 exp 반환

