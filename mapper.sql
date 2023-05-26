-- 테이블 만드는 법, 키
-- 테이블 만들기 : 테이블명 => CUSTOMER
-- ID는 숫자형태로 데이터를 식별할 수 있는 유일한 키 값
-- NAME 사람의 이름을 저장함 (NULL 아님)
-- GENDER는 성별 저장, 기본적으로 나의 성별이 들어가있음 (NULL 아님)
-- EMAIL 이메일을 저장
-- PHONE 핸드폰 번호를 저장

CREATE TABLE CUSTOMER (
    ID NUMBER PRIMARY KEY,
    NAME NVARCHAR2(17) NOT NULL,
    GENDER VARCHAR2(3) DEFAULT '여' CHECK(GENDER IN('남', '여')),
    EMAIL VARCHAR2(100),
    PHONE VARCHAR2(50)
);

DROP TABLE CUSTOMER;

SELECT *
FROM CUSTOMER
where id = 6;

INSERT INTO CUSTOMER VALUES (1, 'NAME', '남', 'EMAIL', 'PHON1E');
INSERT INTO CUSTOMER VALUES (2, '박하늘별님구름햇님보다사랑스러우리', '남', 'EMAIL', 'PHON2E');
INSERT INTO CUSTOMER VALUES (3, '최채윤', '여', 'EMAIL', 'PHON3E');
INSERT INTO CUSTOMER VALUES (4, '남궁희재', '남', 'EMAIL', 'PHON4E');
INSERT INTO CUSTOMER VALUES (5, '문병하', '여', 'EMAIL', 'PHON5E');

SELECT ID, NAME, EMAIL FROM CUSTOMER WHERE ID > 2;

SELECT * FROM CUSTOMER WHERE NAME = '최채윤';

INSERT INTO CUSTOMER (ID, NAME, EMAIL, PHONE)
VALUES(6, 'NAME', 'EMAIL', 'PHONE');

select
