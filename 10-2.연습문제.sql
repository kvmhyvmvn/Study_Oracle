-- [연습문제10-2] 
-- HANUL 계정↗↗↗↗↗ 으로 풀이

-- 1. 이메일 정보가 없는 배역들의 모든 정보(=모든 컬럼)를 조회
SELECT *
FROM CHARACTERS
WHERE EMAIL IS NULL;

-- 2. 역할이 시스에 해당하는 등장인물을 조회
SELECT *
FROM CHARACTERS
WHERE ROLE_ID = (SELECT ROLE_ID
                 FROM ROLES
                 WHERE ROLE_NAME = '시스');
                 
-- 3. 에피소드 4에 출연한 배우들의 실제 이름을 조회
-- STAR_WARS : 영화정보(에피소드 아이디, 에피소드명, 개봉연도)
-- CHARATERS : 등장인물정보(아이디, 이름, 마스터ID, 역할ID, 이메일)
-- CASTING : 등장인물과 배우정보(에피소드 ID, 캐릭터 ID, 실제이름)

SELECT REAL_NAME
FROM CASTING
WHERE EPISODE_ID = 4;

-- 4. 에피소드5에 출연한 배우들의 배역이름과 실제이름
-- 배역이름 : CHARACTER_NAME <CHARACTERS 테이블>
-- 실제이름 : REAL_NAME      <CASTING 테이블>
-- 조인 연산 : 다른 테이블의 컬럼을 가져와 마치 하나의 테이블인 것처럼 데이터를 조회 (수평)
-- SET 연산 : 컬럼 갯수, 데이터 타입만 맞으면 마치 하나의 테이블에서 데이터 조회한 결과 (수직)
-- 4.1 오라클 조인
-- 4.2 ANSI 조인 : MYSQL등 기타 다른 DBMS에서 각기 다른 조인 문법 ==> 표준 문법으로 만든 조인

SELECT CH.CHARACTER_NAME AS 배역이름,
       CA.REAL_NAME AS 실제이름
FROM CHARACTERS CH, CASTING CA
WHERE CH.CHARACTER_ID = CA.CHARACTER_ID
AND CA.EPISODE_ID = 5;

-- 5. 국제표준 조인문으로 바꾸어 작성하시오
-- ANSI 조인 : INNER JOIN, OUTER JOIN
-- ON절 : WHERE 조건절 대신
-- USING : 컬럼의 별칭 / 약어 사용 X
-- 테이블 여러개 일 때 : 먼저 조인한 결과에 다시 추가로 조인하는 형식
-- (+) : 오라클 아우터 조인 <--> [LEFT|RIGHT|FULL] OUTER JOIN

SELECT C.CHARACTER_NAME, P.REAL_NAME, R.ROLE_NAME
FROM CHARACTERS C LEFT OUTER JOIN CASTING P
ON C.CHARACTER_ID = P.CHARACTER_ID
RIGHT OUTER JOIN ROLES R
ON C.ROLE_ID = R.ROLE_ID
AND P.EPISODE_ID = 2;

-- CHARACTERS 데이터와 CASTING 데이터간 불일치 : 교재 제공 VS 직접 데이터 수집/가공

-- 6. 문자 함수를 이용해 CHARACTERS 테이블의 배역이름, 이메일, 이메일 아이디를 조회하시오
-- SUBSTR() : 문자열 추출하여 반환
-- INSTR() : 특정 문자열의 시작위치를 반환
-- REPLACE(), TRANSLATE() : 치환/1:1 변환
-- TRIM(), LTRIM(), RTRIM() : 문자열/기본값 공백 제거
-- LPAD(), RPAD() : 문자열 / 공백 추가
-- LENGTH() : 문자열 길이 반환
-- 단, 이메일이 아이디@도메인일때

SELECT CHARACTER_NAME AS 배역이름,
       EMAIL AS 이메일,
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) AS 이메일_아이디
FROM CHARACTERS;

-- 7. 역할이 제다이에 해당하는 배역들의 배역이름, 그의 마스터
-- 서브쿼리
-- NULL 처리 함수 : NVL(exp1, exp2), NVL2(exp1,exp2,exp3)
-- COALESCE() : 최소 하나는 NULL 아니어야 하는 .. 최초 NULL아닌 값 반환 함수

SELECT M.CHARACTER_NAME AS MASTER_NAME
FROM CHARACTERS C, CHARACTERS M
WHERE C.MASTER_ID = M.CHARACTER_ID;

-- 스칼라 서브쿼리 : 단일 행 반환 (컬럼처럼) : X
-- NULL 처리 함수 : O

SELECT C.CHARACTER_NAME, NVL(M.CHARACTER_NAME, '마스터의 마스터') AS MASTER_NAME
FROM CHARACTERS C, ROLES R, CHARACTERS M
WHERE C.ROLE_ID = R.ROLE_ID
AND R.ROLE_NAME = '제다이'
AND NVL(C.MASTER_ID, 0) = M.CHARACTER_ID(+)
ORDER BY 1;

-- 8. 역할이 제다이 => 기사의 이메일 있으면 제다이 이메일, 없으면 마스터 이메일 조회

SELECT C.CHARACTER_NAME,
       NVL(C.EMAIL, NULL) AS JEDAI_EMAIL,
       NVL(M.EMAIL, NULL) AS MASTER_EMAIL
FROM CHARACTERS C, ROLES R, CHARACTERS M
WHERE C.ROLE_ID = R.ROLE_ID
AND R.ROLE_NAME = '제다이'
AND NVL(C.MASTER_ID, 0) = M.CHARACTER_ID(+)
ORDER BY 1;

-- 9. 스타워즈 시리즈별 출연한 배우의 수
-- 에피소드 이름, 출연배우 수를 개봉연도 순

SELECT S.EPISODE_NAME, COUNT(*) AS CNT
FROM STAR_WARS S, CASTING C
WHERE S.EPISODE_ID = C.EPISODE_ID
GROUP BY EPISODE_NAME, OPEN_YEAR
ORDER BY OPEN_YEAR;

-- 10. 스타워즈 전체 시리즈에서 각 배우별 배역이름, 실제이름, 출연횟수를 조회
-- 출연횟수가 많은 배역이름, 실제이름 순으로 조회

SELECT CH.CHARACTER_NAME, CA.REAL_NAME, COUNT(*) AS TIMES
FROM CHARACTERS CH, CASTING CA
WHERE CH.CHARACTER_ID = CA.CHARACTER_ID
GROUP BY CH.CHARACTER_NAME, CA.REAL_NAME;

-- 11. 위 쿼리문을 참고한 상위 3명의 배역명, 실명, 출연횟수
-- 인라인 뷰 서브쿼리 활용 하거나
-- RANK(), DENSE_RANK() 함수를 활용

SELECT E.*
FROM    (   SELECT  CH.CHARACTER_NAME, CA.REAL_NAME, COUNT(*) AS TIMES
            FROM    CHARACTERS CH, CASTING CA
            WHERE   CH.CHARACTER_ID = CA.CHARACTER_ID
            GROUP BY  CH.CHARACTER_NAME, CA.REAL_NAME) E
WHERE ROWNUM <= 3;

SELECT CH.CHARACTER_NAME, CA.REAL_NAME, COUNT(*) AS TIMES,
       RANK() OVER (ORDER BY COUNT(*) ASC) AS RANK,
       DENSE_RANK() OVER (ORDER BY COUNT(*) ASC) AS DENSE_RANK
FROM CHARACTERS CH, CASTING CA
WHERE CH.CHARACTER_ID = CA.CHARACTER_ID
GROUP BY CH.CHARACTER_NAME, CA.REAL_NAME;

-- 12. 스타워즈 시리즈별 어떤 시리즈에 몇명의 배우가 출연했는지 조회
-- 에피소드 번호, 이름, 출연배우 수 조회, 출연배우수가 많은 순으로 조회

SELECT S.EPISODE_ID, S.EPISODE_NAME, COUNT(*) AS CNT
FROM STAR_WARS S, CASTING C
WHERE S.EPISODE_ID = C.EPISODE_ID
GROUP BY S.EPISODE_ID, S.EPISODE_NAME
ORDER BY 3 DESC;


