-- 외부키, 기본키
-- 외부키 : 키를 상속받아서 사용하는 것
-- └> 상속받을 때 꼭 지켜야하는 규칙 (실제 사용) : 부모가 가진 기본키를 모두 상속 받아야한다.
-- 게시판. 게시판의 구조가 똑같이
-- 게시판 종류 (KEY), 게시글 번호 (KEY), 게시글 제목, 게시글 내용, 기타속성( 날짜 글쓴이 등등) 일 때
-- 게시판이 여러개 있다면 테이블이 여러개가 되어야 할까?
               
SELECT * FROM AND_BOARD;

COMMIT;

CREATE TABLE AND_BOARD (
    BOARD_CATEGORY VARCHAR2(10) NOT NULL, -- B면 회원게시판.. 구분자 키
    BOARD_NO NUMBER NOT NULL, -- 자동 증가 할 것, 시퀀스와 트리거 이용
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
               VALUES ('B', 1, '제목1', '내용1', SYSDATE, 'dev');

CREATE TABLE AND_BOARD_REPLY(
    BOARD_CATEGORY VARCHAR2(10) NOT NULL, -- 부모 테이블 키를 참조하기위한 컬럼 1
    BOARD_NO NUMBER NOT NULL, -- 부모 테이블 키를 참조하기위한 컬럼 2
    REPLY_NO NUMBER NOT NULL, -- 부모키 컬럼 1,2 + 댓글 구분을 위한 키
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
                      VALUES('B', 1, 1, '댓글내용1', SYSDATE, 'dev');







