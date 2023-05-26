-- 12장. PL/SQL
-- SQL --> 절차적인|선언적인 프로그래밍 --> PL/SQL
-- Procedural Language extension to SQL : 절차적인 프로그래밍 언어 + SQL ==> SQL에서 프로그래밍!(확장)
-- 1) 프로그래밍                 2) SQL : DML (개발자)
-- (데이터베이스를 다루는 프로그램)
-- 시중교재 : PL/SQL로 분리할 만큼 분량이 방대함 ==> 완벽하게 정리?
-- ==========================================================================
-- DBMS_OUTPUT 패키지 : 화면에 출력하는 명령이 포함 ---> .PUT_LINE()  : 줄바꿈없이 텍스트 출력
-- SQL DEVELOPER 결과 확인 전, [보기 > DBMS 출력] 창을 선택해서 활성화 ==> + 눌러서 HR 계정 연결!
-- ※SQLPLUS 확인하려면? SET SERVEROUTPUT ON | OFF;
-- ==========================================================================
/* PL/SQL has these advantages(=장점)

Tight Integration with SQL 
High Performance : 성능향상
High Productivity : 생산성?
Portability : 
Scalability 
Manageability : 관리의 용이성
Support for Object-Oriented Programming : 객체지향 프로그래밍
*/

SELECT *
FROM employees;

-- 12.1 PL/SQL 구분
DECLARE
    -- 옵션
    -- 선언부 : 변수, 상수를 선언하는 부분
    -- 상수는 선언과 동시에 초기화 ==> 안하면 오류!
BEGIN
    -- 필수
    -- 실행부 : 일반적인 처리 로직을 작성
    -- 조건문, 선택문, 반복문, SQL(=DML)이 위치
    
    EXCEPTION
    -- 예외처리부 : 옵션
END;


-- 변수명 자료형 := 값;    - 변수에 값을 할당하는 부분
-- 예시)
DECLARE
    -- 예약어 여부 체크, count?
    nInt INTEGER := 10;  -- 선언,초기화
    nString VARCHAR2(50); -- 선언만   
    nConstant CONSTANT NUMBER(1) := 5; -- 선언,초기화
BEGIN
    dbms_output.put_line('nInt : '||nInt);
    dbms_output.put_line('nConstant : '||nConstant);
END;

DESC employees;
-- ===========================
-- SQL 바인드 변수 -----------
SELECT  salary
FROM    employees
WHERE   employee_id =: emp_num;

-- ===========================




-- 예) SQL를 포함한 예시
DECLARE
    nSalary NUMBER(8, 2); -- employees 테이블의 사원의 급여 컬럼
    isTrue BOOLEAN; -- pl/sql에서만 존재하는 불린 타입
BEGIN
    SELECT  salary
    INTO    nSalary -- 변수 nSalary : 100번 사원의 급여 할당
    FROM    employees
    WHERE   employee_id = 206;
    
    DBMS_OUTPUT.PUT_LINE('nSalary : '||nSalary);
    -- 함수라면, RETURN을 명시하고,
    -- 프로시저라면, 단순히 DML(데이터 조작) ==> 출력
END;


-- 예) 연산자와 예외처리
DECLARE
    num1 INTEGER := 5;
    num2 INTEGER := 2;
    result INTEGER;
BEGIN
    num2 := 0;
    result := num1 / num2;
    DBMS_OUTPUT.PUT_LINE('result : '||result);
    EXCEPTION WHEN ZERO_DIVIDE THEN -- 예외처리 : 0으로 나누면~ 에러!
        num2 := 1;
        result := num1 / num2;
        DBMS_OUTPUT.PUT_LINE('result: '||result);
END;


-- ============================================================
-- 1) 사전에 정의된 예외(Pre-defined EXCEPTION)
-- 2) 사용자 정의하는 예외(User-defined EXCEPTION)
-- ※ https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-error-handling.html#GUID-8C327B4A-71FA-4CFB-8BC9-4550A23734D6
EXCEPTION
  WHEN 예외명1 THEN 처리구문1                 -- Exception handler
  WHEN 예외명2 OR 예외명3 THEN 처리구문2  -- Exception handler
  WHEN OTHERS THEN 처리구문3             -- 어떤 예외라도 발생하면, Exception 처리!
END;
-- =================================



-- 조건문 : IF 문
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-1D6FD34F-F58B-4D0B-B7FC-F7C2C22377C3
-- FORTRAN, COBOL, PASCAL, C언어를 참고해서 만들어낸 오라클의 '프로그래밍 가능한 SQL'
-- 조건 1개
IF 조건 THEN
처리문   
END IF;

-- 조건 1개 : 처리는 2개
IF 조건 THEN
처리문1
ELSE
처리문2
END IF;

-- 조건이 여러개
IF 조건1 THEN
처리문1
ELSIF 조건2 THEN
처리문2
ELSIF 조건2 THEN
처리문3
...계속...
ELSE
처리문n
END IF;

-- 예) 성적 ==> 점수에 따라 A등급, B등급, C등급... A등급이면 Excellent! 출력~

DECLARE
    grade CHAR(1) := 'A';
BEGIN
    IF  grade = 'A' THEN
        DBMS_OUTPUT.PUT_LINE('Excellent!');
    ELSIF grade = 'B' THEN
        DBMS_OUTPUT.PUT_LINE('Good!');
    ELSIF grade = 'C' THEN
        DBMS_OUTPUT.PUT_LINE('Not Bad!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('WORK HARD!');
    END IF;
END;


-- 반복문
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-4CD12F11-2DB8-4B0D-9E04-DF983DCF9358
-- Basic LOOP : LOOP ~statements~ END LOOP;
-- FOR LOOP : FOR 변수명 IN 최소값..최대값 LOOP ~ statements ~ END LOOP;
-- Cursor FOR LOOP
-- WHILE LOOP : WHILE condition LOOP ~ statements(EXIT WHEN condition)~ END LOOP;

-- FOR 루프로 숫자값 출력
DECLARE
    start_num INTEGER := 1; -- 변수
    num CONSTANT INTEGER := 2;    -- 상수
    result INTEGER; -- 변수, 초기화x
BEGIN
    FOR start_num IN 1..9 LOOP
        result := num * start_num; -- 초기화
        DBMS_OUTPUT.PUT_LINE(num||' x '||start_num||' = '|| result);
    END LOOP;
END;


-- 명명된 블럭(Named Block) <---> 오라클, 서브프로그램이라고 함
-- A PL/SQL subprogram is a named PL/SQL block that can be invoked repeatedly. If the subprogram has parameters, their values can differ for each invocation.
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-subprograms.html#GUID-117C2D94-EB7C-4A9E-A080-99F4829D69B0
-- 서브프로그램 쓰는 이유 : 안전성, 재사용성
-- 1) 프로시저 : 사원의 사번, 올려줄 급여만 넣고 실행하는 프로시저 --> DML 실제 데이터 업데이트
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-subprograms.html#GUID-9ACD7C7D-861B-4410-AC6F-8536C191E2EF
-- 프로시저 생성(=선언만)
-- DECLARE 대신
CREATE OR REPLACE PROCEDURE 프로시저명 (파라미터1 데이터타입, 파라미터2 데이터타입,...) IS
    -- 변수 선언부;
    -- raise_salary(사번, 올려줄 급여)
BEGIN
    -- 실행 처리
    UPDATE employees
    SET salary = 올려줄 급여
    WHERE   employee_id = 사번;
    COMMIT;
END;

-- 프로시저 실행  : EXEC 급여변경_프로시저(사번, 결정된 salary)
EXEC raise_salary(120, 18000); -- vs DML로 처리하는 것과 비교

-- 원래 급여를 올려주는 로직 : 현재 급여 * 상승률 + 성과에 따른 보너스 ==> 최종 급여
-- EMPLOYEES 테이블의 사원 총 급여 : salary + (commission_pct * salary)

-- 직접 만들어 보기
CREATE OR REPLACE PROCEDURE update_emp_salary(
    emp_id NUMBER, 
    final_salary NUMBER
) 
IS
BEGIN
    UPDATE employees
    SET salary = final_salary
    WHERE   employee_id = emp_id;
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('====== Error 발생!! =======');
        ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('====== process 처리 완료!! =======');    
END;
-- Procedure UPDATE_EMP_SALARY이(가) 컴파일되었습니다.

-- 사원 1명을 선택하고, 급여를 입력 ==> JOBS 테이블의 MIX_SAL, MAX_SAL 제약조건이 걸렸을수도?
SELECT *
FROM    user_constraints
WHERE   constraint_name LIKE '%SALARY%'; -- salary는 무조건 0 초과

SELECT employee_id, salary
FROM    employees
WHERE   employee_id = 206; -- 8300 --> 18000으로 조정하는 udpate프로시저를 실행 테스트

EXEC update_emp_salary(206, 18000); -- PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT employee_id, salary
FROM    employees
WHERE   employee_id = 206; -- 잘 업데이트 되었나 확인

-- ※ 프로시저는 반환 값이 없다   vs   함수는 반환 값이 있다 

-- Quiz. 사원을 등록하는 프로시저 : 사원의 정보중 필수 입력값 < 업무 투입 전 : 부서x, 업무x , 입사일 등록|변경>
-- 1.employees 테이블의 제약조건 확인
DESC employees;

CREATE OR REPLACE PROCEDURE add_emp(
    e_id NUMBER, 
    l_name VARCHAR2, -- number를 VARCHAR2로 수정
    e_mail VARCHAR2,
    h_date DATE,
    j_id VARCHAR2
) 
IS
BEGIN
    INSERT INTO employees (employee_id, last_name, email, hire_date, job_id)
    VALUES (e_id,l_name,e_mail,h_date,j_id);
    COMMIT;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('====== Error 발생!! =======');
        ROLLBACK;    
END;

EXEC add_emp(employees_seq.NEXTVAL, '장','JANGBOGO',SYSDATE,'ST_CLERK');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC add_emp(employees_seq.NEXTVAL, '강','GAMCHAN',SYSDATE,'ST_CLERK');
EXEC add_emp(employees_seq.NEXTVAL, '김','KIMGU',SYSDATE,'ST_CLERK');

SELECT *
FROM    employees;

SELECT *
FROM    job_history;


-- Quiz. 사원을 부서배치하는 프로시저 : < 계약서 작성, 급여 결정, 부서 결정, 직무 결정 >
-- 성이 '장'인 사원을 80번 부서로 배치한다면?
-- set_emp('장', 80); ==> 사원의 department_id를 80으로 결정

-- Quiz. 사원이 퇴사처리 프로시저 : 사원정보 제거, 퇴사일/퇴사시 직무/부서정보 변경하는 처리
-- del_emp(208) ==> job_history 등록, employees에서 delete 그리고 commit;


-- 2) 함수 : MAX() 처럼, 새로운 함수를 생성!
-- 예) 최대값 함수, 최소값 함수,..길이값 함수....80번 부서원의 급여평균을 반환하는 함수
SELECT AVG_SAL(80)
FROM    employees; -- 80번 부서의 평균 급여를 조회하고 반환하는 함수를 사용!

CREATE OR REPLACE FUNCTION AVG_SAL(

)
IS

BEGIN

END;
