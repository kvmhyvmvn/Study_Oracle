-- TRIGGER 의 기본형태

-- CREATE [ OR REPLACE ] TRIGGER [ schema.] trigger
-- BEFORE | AFTER
-- DML EVENT ( INSERT [OR] UPDATE [OR] DELETE )
-- ON [SCHEMA.] DATABASE TABLE
-- WHEN ( 조건)
-- PL/SQL_BLOCK | CALL_PROCEDURE_STATEMENT ;

-- 트리거 : 트랜잭션이 발생하는 작업을 하기 전 또는 후에 어떤 로직을 실행하게 만드는 것
--  구분              NEW(신규)           /          OLD(기존)
-- INSERT       새로들어온데이터(행)      / NULL : 데이터 행이 새로추가 될 때는 기존 (OLD) 데이터는 없음
-- UPDATE         바뀐 데이터(행)         /     바뀌기 전 데이터(행)
-- DELETE              NULL               /    삭제 되는 데이터(기존)
-- FOR EACH ROW : INSERT, UPDATE, DELETE는 여러행이 한번에 작업되는 경우가 존재, 따라서 한 행마다의 작업을 구분한다.
-- BEGIN END; PL/SQL에서 중괄호(JAVA)

-- BEFORE(전) <- 이벤트 -> AFTER(후) 
-- TRIGGER를 이용해서 여러 시점에 대해서 AND_BOARD_HISTORY에 이력을 남긴다.
CREATE TABLE AND_BOARD_HISTORY (
    BOARD_CATEGORY VARCHAR2(10) NOT NULL,
    BOARD_NO NUMBER NOT NULL,
    BOARD_TITLE VARCHAR2(200),
    BOARD_CONTENT VARCHAR2(2000),
    CREATE_DATE DATE,
    STATUS_VALUE VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER TRG_AND_BOARD -- 1
AFTER UPDATE OR DELETE -- 시점 (수정 또는 삭제)
ON AND_BOARD -- 트리거를 부착할 테이블 이름
FOR EACH ROW -- 각 행마다 적용이 된다. (UPDATING, DELETING, INSERTING)
BEGIN -- 실행부 --> 자바의 중괄호 역할( for() "{}")
    IF UPDATING THEN
        INSERT INTO AND_BOARD_HISTORY
        VALUES ( :OLD.BOARD_CATEGORY, :OLD.BOARD_NO, :OLD.BOARD_TITLE, :OLD.BOARD_CONTENT, SYSDATE, 'UPDATING');
    ELSIF DELETING THEN
        INSERT INTO AND_BOARD_HISTORY
        VALUES ( :OLD.BOARD_CATEGORY, :OLD.BOARD_NO, :OLD.BOARD_TITLE, :OLD.BOARD_CONTENT, SYSDATE, 'DELETING');
    END IF;
END;

CREATE OR REPLACE TRIGGER TRG_AND_BOARD_PK -- 1
BEFORE INSERT -- 시점 (추가 전 시점)
ON AND_BOARD -- 트리거를 부착할 테이블 이름
FOR EACH ROW -- 각 행마다 적용이 된다.
BEGIN -- 실행부 --> 자바의 중괄호 역할( for() "{}")
    :NEW.BOARD_NO := SEQ_AND_BOARD.NEXTVAL; -- int numBoardNo = 10;
END;



