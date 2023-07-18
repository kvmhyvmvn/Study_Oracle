-- TRIGGER �� �⺻����

-- CREATE [ OR REPLACE ] TRIGGER [ schema.] trigger
-- BEFORE | AFTER
-- DML EVENT ( INSERT [OR] UPDATE [OR] DELETE )
-- ON [SCHEMA.] DATABASE TABLE
-- WHEN ( ����)
-- PL/SQL_BLOCK | CALL_PROCEDURE_STATEMENT ;

-- Ʈ���� : Ʈ������� �߻��ϴ� �۾��� �ϱ� �� �Ǵ� �Ŀ� � ������ �����ϰ� ����� ��
--  ����              NEW(�ű�)           /          OLD(����)
-- INSERT       ���ε��µ�����(��)      / NULL : ������ ���� �����߰� �� ���� ���� (OLD) �����ʹ� ����
-- UPDATE         �ٲ� ������(��)         /     �ٲ�� �� ������(��)
-- DELETE              NULL               /    ���� �Ǵ� ������(����)
-- FOR EACH ROW : INSERT, UPDATE, DELETE�� �������� �ѹ��� �۾��Ǵ� ��찡 ����, ���� �� �ึ���� �۾��� �����Ѵ�.
-- BEGIN END; PL/SQL���� �߰�ȣ(JAVA)

-- BEFORE(��) <- �̺�Ʈ -> AFTER(��) 
-- TRIGGER�� �̿��ؼ� ���� ������ ���ؼ� AND_BOARD_HISTORY�� �̷��� �����.
CREATE TABLE AND_BOARD_HISTORY (
    BOARD_CATEGORY VARCHAR2(10) NOT NULL,
    BOARD_NO NUMBER NOT NULL,
    BOARD_TITLE VARCHAR2(200),
    BOARD_CONTENT VARCHAR2(2000),
    CREATE_DATE DATE,
    STATUS_VALUE VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER TRG_AND_BOARD -- 1
AFTER UPDATE OR DELETE -- ���� (���� �Ǵ� ����)
ON AND_BOARD -- Ʈ���Ÿ� ������ ���̺� �̸�
FOR EACH ROW -- �� �ึ�� ������ �ȴ�. (UPDATING, DELETING, INSERTING)
BEGIN -- ����� --> �ڹ��� �߰�ȣ ����( for() "{}")
    IF UPDATING THEN
        INSERT INTO AND_BOARD_HISTORY
        VALUES ( :OLD.BOARD_CATEGORY, :OLD.BOARD_NO, :OLD.BOARD_TITLE, :OLD.BOARD_CONTENT, SYSDATE, 'UPDATING');
    ELSIF DELETING THEN
        INSERT INTO AND_BOARD_HISTORY
        VALUES ( :OLD.BOARD_CATEGORY, :OLD.BOARD_NO, :OLD.BOARD_TITLE, :OLD.BOARD_CONTENT, SYSDATE, 'DELETING');
    END IF;
END;

CREATE OR REPLACE TRIGGER TRG_AND_BOARD_PK -- 1
BEFORE INSERT -- ���� (�߰� �� ����)
ON AND_BOARD -- Ʈ���Ÿ� ������ ���̺� �̸�
FOR EACH ROW -- �� �ึ�� ������ �ȴ�.
BEGIN -- ����� --> �ڹ��� �߰�ȣ ����( for() "{}")
    :NEW.BOARD_NO := SEQ_AND_BOARD.NEXTVAL; -- int numBoardNo = 10;
END;



