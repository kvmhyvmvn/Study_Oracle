-- �ܺ�Ű, �⺻Ű
-- �ܺ�Ű : Ű�� ��ӹ޾Ƽ� ����ϴ� ��
-- ��> ��ӹ��� �� �� ���Ѿ��ϴ� ��Ģ (���� ���) : �θ� ���� �⺻Ű�� ��� ��� �޾ƾ��Ѵ�.
-- �Խ���. �Խ����� ������ �Ȱ���
-- �Խ��� ���� (KEY), �Խñ� ��ȣ (KEY), �Խñ� ����, �Խñ� ����, ��Ÿ�Ӽ�( ��¥ �۾��� ���) �� ��
-- �Խ����� ������ �ִٸ� ���̺��� �������� �Ǿ�� �ұ�?
               
SELECT * FROM AND_BOARD;

COMMIT;

CREATE TABLE AND_BOARD (
    BOARD_CATEGORY VARCHAR2(10) NOT NULL, -- B�� ȸ���Խ���.. ������ Ű
    BOARD_NO NUMBER NOT NULL, -- �ڵ� ���� �� ��, �������� Ʈ���� �̿�
    BOARD_TITLE VARCHAR2(200),
    BOARD_CONTENT VARCHAR2(2000),
    CREATE_DATE DATE ,
    CREATE_BY VARCHAR2(100),
    UPDATE_DATE DATE,
    CONSTRAINT AND_BOARD_PK PRIMARY KEY 
  (
    BOARD_CATEGORY,
    BOARD_NO 
  )
  ENABLE ,
  CONSTRAINT AND_BOARD_FK FOREIGN KEY
  (
    CREATE_BY 
  )
    REFERENCES ANDMEMBER
  (
    ID 
  )
    ENABLE
);

INSERT INTO AND_BOARD (BOARD_CATEGORY, BOARD_NO, BOARD_TITLE, BOARD_CONTENT, CREATE_DATE, CREATE_BY)
               VALUES ('B', 1, '����1', '����1', SYSDATE, 'dev');

CREATE TABLE AND_BOARD_REPLY(
    BOARD_CATEGORY VARCHAR2(10) NOT NULL, -- �θ� ���̺� Ű�� �����ϱ����� �÷� 1
    BOARD_NO NUMBER NOT NULL, -- �θ� ���̺� Ű�� �����ϱ����� �÷� 2
    REPLY_NO NUMBER NOT NULL, -- �θ�Ű �÷� 1,2 + ��� ������ ���� Ű
    REPLY_CONTENT VARCHAR2(1000),
    CREATE_DATE DATE,
    CREATE_BY VARCHAR2(100),
    UPDATE_DATE DATE,
    CONSTRAINT AND_BOARD_REPLY_PK PRIMARY KEY
    (
        REPLY_NO
    )
    ENABLE,
    CONSTRAINT AND_BOARD_REPLY_FK_1 FOREIGN KEY
    (
        CREATE_BY
    )
    REFERENCES ANDMEMBER
    (
        ID
    )
    ENABLE,
    CONSTRAINT AND_BOARD_REPLY_FK_2 FOREIGN KEY
    (
        BOARD_CATEGORY,
        BOARD_NO
    )
    REFERENCES AND_BOARD
    (
        BOARD_CATEGORY,
        BOARD_NO
    )
);
SELECT * FROM AND_BOARD;
SELECT * FROM AND_BOARD_REPLY;
INSERT INTO AND_BOARD_REPLY (BOARD_CATEGORY, BOARD_NO, REPLY_NO, REPLY_CONTENT, CREATE_DATE, CREATE_BY)
                      VALUES('B', 1, 1, '��۳���1', SYSDATE, 'dev');







