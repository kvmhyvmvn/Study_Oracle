[연습문제 8-1]

1. EMP 테이블에 (교재의) 데이터 행을 저장하시오.

-- 테이블 구조(컬럼 정의) 확인
DESC EMP;

-- 데이터 입력
INSERT INTO EMP (EMP_ID, FNAME, LNAME, HIRE_DATE, SALARY)
VALUES (400, 'Johns', 'Hopkins', TO_DATE('2008/10/15', 'YYYY/MM/DD'), 5000);
INSERT INTO EMP (EMP_ID, FNAME, LNAME, HIRE_DATE, SALARY)
VALUES (401, 'Abraham', 'Lincoln', TO_DATE('2010/03/03', 'YYYY/MM/DD'), 12500);
INSERT INTO EMP (EMP_ID, FNAME, LNAME, HIRE_DATE, SALARY)
VALUES (402, 'Tomas', 'Edison', TO_DATE('2013/06/21', 'YYYY/MM/DD'), 6300);

-- 데이터 확인
SELECT *
FROM EMP;

/*
-- DML : INSERT, UPDATE, DELETE
INSERT INTO 테이블명 [(컬럼1, 컬럼2, ...)]
VALUES(값1, 값2, ...)

-- 또는 VALUES 생략하고,
-- SELECT ~ 이하 : ITAS

UPDATE 테이블명
SET 컬럼명=값
WHERE 조건;

DELETE FROM 테이블명
WHERE 조건;
*/

2. EMP 테이블의 사번 401번 사원의 부서코드를 90으로, 업무코드를 SA_MAN으로 변경하고 데이터행의 저장 확정

-- 데이터 확인 : 401번 사원
SELECT *
FROM EMP
WHERE EMP_ID = 401;

-- 데이터 변경(=업데이트, 기존 데이터를 변경해서 저장)
UPDATE EMP
SET DEPT_ID = 90,
    JOB_ID = 'SA_MAN'
WHERE EMP_ID = 401;

-- 다시 데이터 확인
SELECT *
FROM EMP
WHERE EMP_ID = 401;

-- 데이터 저장 확정
COMMIT;

3. EMP 테이블의 급여가 8000 미만인 모든 사원의  부서코드를 80번으로 변경하고, 급여는 EMPLOYEES 테이블의
80번 부서의 평균급여를 가져와 변경 (단, 평균급여는 반올림 된 정수 사용)

-- 데이터 확인
SELECT *
FROM EMP
WHERE SALARY < 8000;

-- EMPLOYEES 테이블의 80번 부서원의 평균 급여 조회
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80; -- 8956

SELECT DEPARTMENT_ID, ROUND(AVG(SALARY))
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
GROUP BY DEPARTMENT_ID
ORDER BY 1;

-- 데이터 변경
UPDATE EMP
SET DEPT_ID = 80,
    SALARY = ( SELECT ROUND(AVG(SALARY))
               FROM EMPLOYEES
               WHERE DEPARTMENT_ID = 80)
WHERE SALARY <  8000;

-- 확인
SELECT *
FROM EMP;

4. EMP 테이블의 2010년 이전 입사한 사원의 정보를 삭제한다.
-- TO_CHAR(HIRE_DATE, 'YYYY')
-- 2009년 12월 31일까지 포함, 2010년도 1월 1일 미만(포함X)

DELETE FROM EMP
-- WHERE HIRE_DATE <= '2009-12-31';
WHERE TO_CHAR(HIRE_DATE, 'YYYY') < '2010';

-- 2010년 이전 입사한 입사자 조회
SELECT *
FROM EMP
-- WHERE HIRE_DATE <= '2009-12-31';
WHERE TO_CHAR(HIRE_DATE, 'YYYY') < '2010';

-- 확인
SELECT *
FROM EMP;

-- 확정
COMMIT;



