-- 1. 데이터가 담긴 테이블 구조를 조회 명령
-- DESC 테이블명;
-- DESCRIBE 테이블명;
-- describe 테이블명;
-- 대소문자 구분하지 않음
-- 왼쪽 접속창 [+] 누르면 같은 기능! (구조 확인)

desc departments;
-- 나머지 테이블을 모두 조회해보세요!

-- 2. 데이터를 조회하는 SELECT
-- SELECT * FROM 테이블명;
SELECT * FROM EMPLOYEES;
/*
    SELECT *
    FROM     테이블명;
*/
-- 왼쪽 접속에서 각 테이블을 더블클릭하고, [데이터] 컬럼을 클릭하면 같은 기능!

SELECT * FROM COUNTRIES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;



DESC EMPLOYEES;
SELECT *
FROM EMPLOYEES;
/*
HR 스키마에 있는 테이블(=오라클 데이터베이스 객체중 하나)
==================================================================
이름              정보
------------------------------------------------------------------
COUNTRIES         국가/나라 정보(국가 코드, 이름, 지역 코드)
DEPARTMENTS       부서 정보(부서 코드, 부서 이름, 담당자 코드, 위치 코드) 
EMPLOYEES         사원 정보(사원 코드, 이름, 성, 이메일, 전화번호, 입사일, 업무 코드, 급여, 커미션율, 담당자 코드, 부서 코드)
JOB_HISTORY         
JOBS              
LOCATIONS         
REGIONS           
*/

-- 2.1 테이블 구조
-- 오라클 (=데이터베이스 관리 시스템)이 데이터를 2차원 구조(표, table의 행과 열)로 기본적으로 저장
-- 테이블: 어떤 정보가 있는데 <--> 데이터베이스: 관계(Relation)
/*
사원 정보 테이블
사원 코드   사원 이름(성,이름)   부서   입사일   급여 ....
----------------------------------------------------------
1           길동 홍               IT   23-02-01  2000000 
1           길동 홍               IT   23-02-01  2000000
1           길동 홍               IT   23-02-01  2000000
1           길동 홍               IT   23-02-01  2000000

고객 정보 테이블
고객 코드    고객명     등급      연락처        근무지
-----------------------------------------------------------
1000         이순신     우수     010.123.456     광주
1000         이순신     우수     010.123.456     광주
1000         이순신     우수     010.123.456     광주
1000         이순신     우수     010.123.456     광주
*/


-- ※ Document : 행,열 구조가 아님 vs RDBMS : 테이블(행,열)
/*
↓ 열(Column) : 가로 방향 [열 이름(=특성), 열의 자료형(문자,숫자,날짜..), 길이]
이름           널?       유형            <---- 행(ROW), 세로 방향   
------------ -------- ------------ 
COUNTRY_ID   NOT NULL CHAR(2)      
COUNTRY_NAME          VARCHAR2(40) 
REGION_ID             NUMBER  

COUNTRY_ID COUNTRY_NAME                              REGION_ID
-- ---------------------------------------- ----------
AR          Argentina                                         2   : 가로방향의 연관된 데이터를 정보(튜플,레코드)
AU          Australia                                         3
BE          Belgium                                           1
*/


-- 대소문자 구별 x
-- 띄어쓰기, TAB을 사용해서 가독성 있게!
-- 쿼리는 절(clause) 단위로 작성
-- 자동완성 지원함! 근데, 직접 쿼리작성 빠름!


-- 2.1 DESC / DESCRIBE : 테이블의 구조 ==> 열 이름, 자료형, (저장할 수 있는 데이터) 길이 확인
--     SELECT : 데이터를 조회 ==> 테이블의 레코드 (ROW 또는 Tuple/튜플) 

SELECT *        -- SELECT 절
FROM    employees;  -- FROM 절
-- 계속 뭔가가 추가..

-- 2.2 조건절
-- 필요한 정보만 조회하기 위한 구문, 일종의 필터링!
SELECT 열 이름1, 열이름2, 열이름3,...
FROM    테이블명;

-- * : 애스터리스크, All (모든 컬럼)
SELECT * 
FROM countries; -- 25rows

SELECT *
FROM    departments; -- 27rows

[예제 2-3] 80번 부서의 사원 정보를 조회 ==> 80번 부서에 근무하는 사원들을 필터링!
-- CTRL+ENTER or 블럭씌우고 + F5 
SELECT *
FROM    employees 
WHERE   department_id = 80; -- 총 107명중 80번 부서에 근무하는 사원은 34명(rows)
-- 오라클 연산자 : = (같다), 대입x

-- 80번 부서의 부서이름을 조회하시오!
SELECT *
FROM    departments
WHERE   department_id = 80; -- Sale 부서 : 판매 부서 --> 소속이 많이 필요한 부서

-- Sales 부서(80)가 위치한 위치 정보를 조회해보시오! (도로주소, 우편번호, 국가 코드)
-- LOCATION_ID를 찾아서, LOCATIONS 테이블에 LOCATION_ID가 일치한 정보
SELECT location_id 위치코드 -- 별칭(Alias) : 컬럼의 이름을 약어로 표시
FROM    departments
WHERE   department_id = 80;   -- 부서코드로 필터링, 2500
--WHERE   department_name = 'Sales'; -- 부서이름으로 필터링
--WHERE   department_name = 'sales'; -- 문자는 '로 작성, 대/소문자를 구분 [날짜 데이터도 '로]

-- 위치정보를 찾아보면,
SELECT  city, street_address, postal_code
FROM    locations
WHERE   location_id = 2500;

--   부서코드    부서명    부서위치 도시명   부서의 도로주소    부서의 우편번호
--      80        Sales        Oxford             Magdalen~      OX9 9ZB

SELECT *
FROM    job_history; -- 10 rows

SELECT *
FROM    jobs; -- 19rows

SELECT * 
FROM    locations; -- 23rows

SELECT *
FROM    regions; -- 4rows

-- 미국의 어떤 회사의 정보 : 회사에 근무하는 사원을 중심으로 이들이 소속된 부서, 하는 업무, 
-- 지역(국가/대륙)등의 정보  [작은 규모, 학습용 데이터/실제 데이터x]

/*
    WHERE 조건절을 구성하는 항목의 분류
    1) 컬럼, 숫자, 문자
    2) 산술연산자 (+,-,*,/), 비교연산자(=, <=, <, >, >=, !=, <>, ^=),  -- MOD(젯수, 피젯수): % 대신 사용하는 함수
    3) AND, OR, NOT
    4) LIKE, IN, BETWEEN, EXISTS
    5) IS NULL, IS NOT NULL
    6) ANY, SOME, ALL
    7) 함수
*/

-- 2.3 연산자
-- 2.3.1 산술 연산자: +, -, *, /
-- MOD(젯수, 피젯수) : % 대신 사용하는 함수
-- 산술연산자는 SELECT 목록과 조건절에 사용할 수 있습니다.

SELECT 2+2 "합"
FROM dual; --4
-- 실제 존재하지 않는 테이블 dual, 단순히 산술연산이나 시스템 날짜 출력하거나 함수 실행, 반환값 확인

SELECT 2-1 AS 차
FROM dual;
-- 실제로 DB에서는 기본적으로 오라클 객체를(=테이블) 대문자로 작성하는데,
-- 소문자 테이블명으로 작성하려면 생성할 때 "소문자"로 명령을 처리!
-- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다.
-- 00942. 00000 - "table or view does not exist"

SELECT 2 * 4 AS 곱
FROM dual;

-- 약어 사용시 AS: 생략 가능하지만, SELECT 절이 복잡해지면 가독성 측면에서 AS를 추가하는 개발자가 많다
-- 라는 통계가 있음

SELECT 2 * 4 AS 곱, 2 - 1 AS 차, 2 * 3 AS 곱, 2 / 3 몫
FROM dual;

-- 2) WHERE 조건절
SELECT employee_id, last_name, salary, salary * 12 AS 연봉, department_id
FROM employees
--WHERE department_id = 80; --80번 부서에 근무하는 사원의 정보 조회, 34 rows
WHERE salary * 12 >= 100000;

[예제2-4] 80번 부서 사원의 한 해 동안 받은 급여를 조회한다.
SELECT employee_id AS 사번, last_name AS 성, salary * 12 AS 연봉
FROM employees
WHERE department_id = 80;  -- Sales 부서, 34 rows

[예제2-4] 한 해 동안 받은 급여가 120000 ($, USD)인 사원의 정보 조회
-- NLS 설정상 : 자동으로 오라클이 원화로 설정되어 있음.
-- 다만, hr 스키마의 데이터는 영문 데이터로 자연스럽게 USD로 추측할 수 있음.
SELECT employee_id, last_name, salary * 12 || '$' AS "연봉", department_id
FROM employees
WHERE salary * 12 = 120000; -- 연봉 정보가 저장된 컬럼은 없지만, salary 컬럼에 12를 곱해서 연봉정보를 조회, 비교

SELECT employee_id, last_name, first_name, salary * 12 ||' ' || '$' AS "연봉", department_id
FROM employees
WHERE salary * 12 = 120000; -- 연봉 정보가 저장된 컬럼은 없지만, salary 컬럼에 12를 곱해서 연봉정보를 조회, 비교
-- 문자열 연결 연산자 : ||
-- 문자열 연결 함수 : CONCAT()
-- 문자 데이터, 숫자 데이터 : '로 묶음

[예제2-6] 사번이 101번인 사원의 성명을 조회한다.
SELECT employee_id, last_name || ' ' || first_name AS 성명, salary, job_id, department_id
FROM employees
WHERE employee_id = 101;

-- 90번 부서 : 
SELECT department_name
FROM departments
WHERE department_id = 90; -- 경영진

-- 컬럼의 별칭(Alias) : 컬럼에 별칭, 약어를 붙여 사용할 수 있다.
-- 1) 컬럼명 (공백) 별칭 : ' '
-- 2) 키워드 AS 또는 as 사용 -- 가독성 측면에서는 SELECT 절이 복잡해지면 AS를 추가하는 경우
-- 3) 큰 따옴표를 사용할 수 있다(보통 생략), 단 컬럼명에 공백을 포함할 경우는 반드시 큰 따옴표로 묶을 것

[예제 2-8] 사번이 101번인 사원의 성과 한해 동안 받은 급여를 조회
-- 성: name 이라는 별칭
-- 한 해 동안 받은 급여: ANNUAL SALARY 라는 별칭

SELECT employee_id AS 사번, last_name 성, salary * 12 AS "ANNUAL SALARY"
FROM employees
WHERE employee_id = 101;

-- 2.3.3 비교연산자
-- 값의 크기를 비교 : =, >=, >, <, <=

[예제 2-9] 급여가 3000 이하인 사원의 정보를 조회한다.
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary <= 3000;  -- 26 rows, 30번 30번 부서에 소속

[예제 2-10] 부서코드가 80번 초과인 사원의 정보를 조회한다.
-- 부서코드 : department_id
-- 사원코드 : employee_id
-- 업무코드 : job_id
-- 부서장코드 : manager_id

SELECT * 
FROM employees
WHERE department_id > 80; -- 90번 부터 나머지 부서들 11 rows

-- departments 데이터를 확인
SELECT *
FROM departments; -- 27 rows, 10 ~ 270 부서코드

-- 문자데이터, 날짜데이터는 작은 따옴표(')로 묶어서 표현해야 합니다.
-- 문자데이터는 대, 소문자를 구분합니다.

SELECT *
FROM employees
WHERE last_name = 'Chen';

SELECT 'hanul' AS company_name, employee_id, last_name, hire_date
FROM employees
WHERE hire_date < '05/09/28'; -- 년/월/일 : 먼저, 나중에 입사한 사람들 정보

DESC employees;

[예제 2-11] 성이 King인 사원의 정보를 조회
SELECT employee_id, last_name, email, phone_number, hire_date
FROM employees
WHERE last_name = 'King';

[예제 2-12] 입사일이 2004년 1월 1일 이전인 사원의 정보를 조회한다.
SELECT 'hanul' AS company_name, employee_id, last_name, hire_date
FROM employees
--WHERE hire_date < '04/01/01'; -- 14 rows
WHERE hire_date <= '03/12/30'; -- 14 rows



