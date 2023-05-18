-- 2장. SQL
-- 에스큐엘 or 시퀄~ 이라고 읽음
-- Sturctured Query Language (=구조화된 질의어) : 데이터를 조회, 저장, 삭제하는데 사용하는 질의언어
-- 구조화된~ : 일정한 사용 패턴 있다! (패턴을 익히면 쉽다)
--  개발자 --> SQL --> Oracle DBMS : 데이터 조회/저장/삭제 요청 ---> 데이터를 처리 --> 그 결과

-- SQL의 구분 : 보통은~
-- 0) DQL (Data Query Language) : 데이터를 조회하는 명령어

-- 1) DML (Data Manipulation Language) : 데이터를 저장(새 데이터, 기존데이터) 삭제하는 명령어
-- 2) DDL (Data Definion Language) : 데이터를 저장하는 테이블등의 객체를 생성, 삭제, 수정하는 명령어
-- 3) DCL (Data Control Language) : 데이터와 관련된 사용자 권한을 부여, 회수하는 명령어
-- 4) DTL (Data Transaction Language) : 데이터 처리 트랜잭션 관련 명령어
--     └ ex> grant connect, create table, dba to hanul; // revoke     


-- SQL 작성 방법
-- 1) 대,소문자를 구분하지 않고 작성
-- 2) 공백(spacebar, tab)이 SQL 처리에 영향을 주지 않음
-- 3) 문장의 마지막에 세미콜론(;)을 기술하여 명령의 끝을 표시
-- 4) 쿼리 실행은 CTRL+ENTER 또는 블럭씌워서 CTRL+ENTER
-- 5) SQLPLUS에서도 가능! (SQLDEVELOPER만 쓰지 않아도..DBeaver, Toad for Oracle, HeidiSQL,...)