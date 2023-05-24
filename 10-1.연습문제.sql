-- [연습문제10-1] 
-- HANUL 계정↗↗↗↗↗ 으로 풀이

-- 1~3. 다음의 테이블을 생성하시오 (DDL: CREATE TABLE~)

-- 테이블 생성하면서 정의
-- 1. 영화 정보 테이블 생성
CREATE TABLE star_wars (
    episode_id NUMBER(5),
    episode_name VARCHAR2(50) NOT NULL,
    open_year NUMBER(4),
    CONSTRAINT star_wars_episode_id_pk PRIMARY KEY (episode_id)
); -- Table STAR_WARS이(가) 생성되었습니다.

-- 추가 지정 : NN 제약조건 추가 x --> 컬럼 정의 수정하는 방법
ALTER TABLE star_wars
MODIFY episode_name NOT NULL;


-- 테이블 생성 후 지정하는 방법
-- ALTER TABLE star_wars
-- ADD CONSTRAINT star_wars_episode_id_pk PRIMARY KEY (episode_id)


-- 2. 등장인물 정보 테이블 생성
CREATE TABLE characters (
    character_id NUMBER(5) CONSTRAINT characters_id_pk PRIMARY KEY, -- 컬럼레벨 : SYS_C008981??
    charater_name VARCHAR(30) NOT NULL,
    master_id NUMBER(5),
    role_id NUMBER(5),
    email VARCHAR2(40)
);

SELECT *
FROM    user_constraints
WHERE   table_name = 'CHARACTERS';

ALTER TABLE characters
DROP CONSTRAINT characters_id_pk;

ALTER TABLE characters
ADD CONSTRAINT characters_id_pk PRIMARY KEY (character_id);


-- 3. 등장인물과 실제배역정보 테이블 생성
CREATE TABLE casting (
    episode_id NUMBER(5),
    character_id NUMBER(5),
    real_name VARCHAR2(30) NOT NULL,
    CONSTRAINT casting_episode_id_pk PRIMARY KEY (episode_id, character_id) -- 복합키
);


--  4. star_wars 테이블에 데이터 입력
-- 알아서 COMMIT;

INSERT INTO star_wars
VALUES (4, '새로운 희망(A New Hope)', 1977);
INSERT INTO star_wars
VALUES (5, '제국의 역습(The Empire Strikes Back)', 1980);
INSERT INTO star_wars
VALUES (6, '제다이의 귀환(Return of Jedi)', 1983);
INSERT INTO star_wars
VALUES (1, '보이지 않는 위험(The Phantom Menace)', 1999);
INSERT INTO star_wars
VALUES (2, '클론의 습격(Attack of the Clones)', 2002);
INSERT INTO star_wars
VALUES (3, '시스의 복수(Revenge of the Sith)', 2005);

SELECT *
FROM    star_wars;

COMMIT;

-- 5. characters 테이블에 데이터 저장
INSERT INTO characters (character_id, character_name, email)
VALUES (1, '루크 스카이워커', 'luke@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (2, '한 솔로', 'solo@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (3, '레이아 공주', 'leia@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (4, '오비완 케노비', 'Obi-Wan@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (5, '다쓰 베이더', 'vader@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (6, '다쓰 베이더(목소리)', 'vader_voice@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (7, 'C-3PO', 'c3po@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (8, 'R2-D2', 'r2d2@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (9, '츄바카', 'Chewbacca@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (10, '랜도 칼리시안', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (11, '요다', 'yoda@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (12, '다쓰 시디어스', 'sidious@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (13, '아나킨 스카이워커', 'Anakin@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (14, '콰이곤 진', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (15, '아미달라 여왕', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (16, '아나킨 어머니', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (17, '자자빙크스(목소리)',NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (18, '다쓰 몰', 'maul@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (19, '장고 펫', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (20, '마스터 윈두', 'windu@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (21, '두쿠 백작', 'dooku@jedai.com');

-- 컬럼명 오타
ALTER TABLE characters
RENAME COLUMN charater_name TO character_name;

-- 확인
SELECT *
FROM    characters;

-- 커밋
COMMIT;


-- 6. roles 테이블 생성 , 데이터 삽입
CREATE TABLE roles (
    role_id NUMBER(4),
    role_name VARCHAR2(20)
);

INSERT INTO roles
VALUES (1001, '제다이');
INSERT INTO roles
VALUES (1002, '시스');
INSERT INTO roles
VALUES (1003, '반란군');

SELECT *
FROM    roles;

COMMIT;


-- 7. characters 테이블의 role_id 컬럼의 데이터가 roles 테이블의 role_id 컬럼의 데이터를
-- 참조하도록 charaters 테이블에 참조키(=외래키, FK)를 생성하시오

-- 7.1 roles 테이블의 ROLE_ID를 기본키 지정
ALTER TABLE roles
ADD CONSTRAINT roles_id_pk PRIMARY KEY (role_id); -- Table ROLES이(가) 변경되었습니다.

-- 7.2 테이블 생성된 후 제약조건 지정 : characters 테이블의 role_id를 roles 테이블의 role_id 외래키 지정
ALTER TABLE characters
ADD CONSTRAINT characters_role_id_fk FOREIGN KEY (role_id) REFERENCES roles (role_id);
-- Table CHARACTERS이(가) 변경되었습니다.

-- 7.3 확인 [각자 알아서..필요하면]
INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '완전 악당', 1004 ,'dooku@jedai.com');
-- ORA-02291: 무결성 제약조건(HANUL.CHARACTERS_ROLE_ID_FK)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '완전 악당', 1003 ,'real_devil@jedai.com');

rollback;

SELECT *
FROM    characters;

-- 8. DML : UPDATE - 변경해서 데이터를 저장
UPDATE characters
SET role_id = 1002
WHERE   email LIKE '%sith%'; -- 4rows

UPDATE characters
SET role_id = 1003
WHERE   email LIKE '%alliance%'; -- 5rows

UPDATE characters
SET role_id = 1001
WHERE   character_name IN ('루크 스카이워커', '오비완 케노비', '요다', '아나킨 스카이워커', '콰이곤 진', '마스터 윈두', '두쿠 백작');
-- 7rows


SELECT *
FROM    characters;

-- 알아서 커밋
COMMIT;

-- 9. characters 테이블의 master_id 컬럼은 employees 테이블의 manager_id와 같은 역할을 한다.
-- 매니저 사원의 사번 : manager_id
-- master_id : 캐릭터 중 마스터의 캐릭터 id
SELECT *
FROM CHARACTERS;

SELECT CHARACTER_ID
FROM CHARACTERS
WHERE CHARACTER_NAME = '오비완 케노비';

UPDATE CHARACTERS
SET MASTER_ID = ( SELECT CHARACTER_ID
                  FROM CHARACTERS
                  WHERE CHARACTER_NAME = '오비완 케노비')
WHERE CHARACTER_NAME IN ('아나킨 스카이워커', '루크 스카이워커');

UPDATE CHARACTERS
SET MASTER_ID = ( SELECT CHARACTER_ID
                  FROM CHARACTERS
                  WHERE CHARACTER_NAME = '요다')
WHERE CHARACTER_NAME IN ('마스터 윈두', '두쿠 백작');

UPDATE CHARACTERS
SET MASTER_ID = ( SELECT CHARACTER_ID
                  FROM CHARACTERS
                  WHERE CHARACTER_NAME = '다쓰 시디어스')
WHERE CHARACTER_NAME IN ('다쓰 베이더', '다쓰 몰');

UPDATE CHARACTERS
SET MASTER_ID = ( SELECT CHARACTER_ID
                  FROM CHARACTERS
                  WHERE CHARACTER_NAME = '콰이곤 진')
WHERE CHARACTER_NAME = '콰이곤 진';

-- 10. CASTING (등장인물과 실제 배우 정보 테이블)의 기본키는 EPISODE_ID, CHARACTER_ID
-- 두 컬럼은 각각 STAR_WARS와 CHARATERS 테이블의 기본키를 참조하고 있다.
-- 참조키 생성

-- 제약조건 : NOT NULL, CHECK, UNIQUE, PRIMARY KEY, FOREIGN KEY
--            컬럼, 컬럼/테이블 ~
--                            <-- 복합키                     -->
-- 테이블 생성시 제약조건 정의 : 컬럼/테이블 레벨

-- 이미 테이블이 생성된 뒤 제약조건 추가
-- STAR_WARS 테이블의 EPISODE_ID 컬럼을 참조하는 CASTING 테이블의 EPISODE_ID 컬럼에 FK 제약조건 지정
ALTER TABLE CASTING
ADD CONSTRAINT STAR_WARS_EPISODE_ID_FK FOREIGN KEY (EPISODE_ID) REFERENCES STAR_WARS (EPISODE_ID);

-- CHARACTERS 테이블의 CHARACTER_ID 컬럼을 참조하는 CASTING 테이블의 CHARACTER_ID 컬럼에 FK 제약조건 지정
ALTER TABLE CASTING
ADD CONSTRAINT CHARACTERS_CHARACTER_ID_FK FOREIGN KEY (CHARACTER_ID) REFERENCES CHARACTERS(CHARACTER_ID);




