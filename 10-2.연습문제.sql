-- [��������10-2] 
-- HANUL �����֢֢֢֢� ���� Ǯ��

-- 1. �̸��� ������ ���� �迪���� ��� ����(=��� �÷�)�� ��ȸ
SELECT *
FROM CHARACTERS
WHERE EMAIL IS NULL;

-- 2. ������ �ý��� �ش��ϴ� �����ι��� ��ȸ
SELECT *
FROM CHARACTERS
WHERE ROLE_ID = (SELECT ROLE_ID
                 FROM ROLES
                 WHERE ROLE_NAME = '�ý�');
                 
-- 3. ���Ǽҵ� 4�� �⿬�� ������ ���� �̸��� ��ȸ
-- STAR_WARS : ��ȭ����(���Ǽҵ� ���̵�, ���Ǽҵ��, ��������)
-- CHARATERS : �����ι�����(���̵�, �̸�, ������ID, ����ID, �̸���)
-- CASTING : �����ι��� �������(���Ǽҵ� ID, ĳ���� ID, �����̸�)

SELECT REAL_NAME
FROM CASTING
WHERE EPISODE_ID = 4;

-- 4. ���Ǽҵ�5�� �⿬�� ������ �迪�̸��� �����̸�
-- �迪�̸� : CHARACTER_NAME <CHARACTERS ���̺�>
-- �����̸� : REAL_NAME      <CASTING ���̺�>
-- ���� ���� : �ٸ� ���̺��� �÷��� ������ ��ġ �ϳ��� ���̺��� ��ó�� �����͸� ��ȸ (����)
-- SET ���� : �÷� ����, ������ Ÿ�Ը� ������ ��ġ �ϳ��� ���̺��� ������ ��ȸ�� ��� (����)
-- 4.1 ����Ŭ ����
-- 4.2 ANSI ���� : MYSQL�� ��Ÿ �ٸ� DBMS���� ���� �ٸ� ���� ���� ==> ǥ�� �������� ���� ����

SELECT CH.CHARACTER_NAME AS �迪�̸�,
       CA.REAL_NAME AS �����̸�
FROM CHARACTERS CH, CASTING CA
WHERE CH.CHARACTER_ID = CA.CHARACTER_ID
AND CA.EPISODE_ID = 5;

-- 5. ����ǥ�� ���ι����� �ٲپ� �ۼ��Ͻÿ�
-- ANSI ���� : INNER JOIN, OUTER JOIN
-- ON�� : WHERE ������ ���
-- USING : �÷��� ��Ī / ��� ��� X
-- ���̺� ������ �� �� : ���� ������ ����� �ٽ� �߰��� �����ϴ� ����
-- (+) : ����Ŭ �ƿ��� ���� <--> [LEFT|RIGHT|FULL] OUTER JOIN

SELECT C.CHARACTER_NAME, P.REAL_NAME, R.ROLE_NAME
FROM CHARACTERS C LEFT OUTER JOIN CASTING P
ON C.CHARACTER_ID = P.CHARACTER_ID
RIGHT OUTER JOIN ROLES R
ON C.ROLE_ID = R.ROLE_ID
AND P.EPISODE_ID = 2;

-- CHARACTERS �����Ϳ� CASTING �����Ͱ� ����ġ : ���� ���� VS ���� ������ ����/����

-- 6. ���� �Լ��� �̿��� CHARACTERS ���̺��� �迪�̸�, �̸���, �̸��� ���̵� ��ȸ�Ͻÿ�
-- SUBSTR() : ���ڿ� �����Ͽ� ��ȯ
-- INSTR() : Ư�� ���ڿ��� ������ġ�� ��ȯ
-- REPLACE(), TRANSLATE() : ġȯ/1:1 ��ȯ
-- TRIM(), LTRIM(), RTRIM() : ���ڿ�/�⺻�� ���� ����
-- LPAD(), RPAD() : ���ڿ� / ���� �߰�
-- LENGTH() : ���ڿ� ���� ��ȯ
-- ��, �̸����� ���̵�@�������϶�

SELECT CHARACTER_NAME AS �迪�̸�,
       EMAIL AS �̸���,
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) AS �̸���_���̵�
FROM CHARACTERS;

-- 7. ������ �����̿� �ش��ϴ� �迪���� �迪�̸�, ���� ������
-- ��������
-- NULL ó�� �Լ� : NVL(exp1, exp2), NVL2(exp1,exp2,exp3)
-- COALESCE() : �ּ� �ϳ��� NULL �ƴϾ�� �ϴ� .. ���� NULL�ƴ� �� ��ȯ �Լ�

SELECT M.CHARACTER_NAME AS MASTER_NAME
FROM CHARACTERS C, CHARACTERS M
WHERE C.MASTER_ID = M.CHARACTER_ID;

-- ��Į�� �������� : ���� �� ��ȯ (�÷�ó��) : X
-- NULL ó�� �Լ� : O

SELECT C.CHARACTER_NAME, NVL(M.CHARACTER_NAME, '�������� ������') AS MASTER_NAME
FROM CHARACTERS C, ROLES R, CHARACTERS M
WHERE C.ROLE_ID = R.ROLE_ID
AND R.ROLE_NAME = '������'
AND NVL(C.MASTER_ID, 0) = M.CHARACTER_ID(+)
ORDER BY 1;

-- 8. ������ ������ => ����� �̸��� ������ ������ �̸���, ������ ������ �̸��� ��ȸ

SELECT C.CHARACTER_NAME,
       NVL(C.EMAIL, NULL) AS JEDAI_EMAIL,
       NVL(M.EMAIL, NULL) AS MASTER_EMAIL
FROM CHARACTERS C, ROLES R, CHARACTERS M
WHERE C.ROLE_ID = R.ROLE_ID
AND R.ROLE_NAME = '������'
AND NVL(C.MASTER_ID, 0) = M.CHARACTER_ID(+)
ORDER BY 1;

-- 9. ��Ÿ���� �ø�� �⿬�� ����� ��
-- ���Ǽҵ� �̸�, �⿬��� ���� �������� ��

SELECT S.EPISODE_NAME, COUNT(*) AS CNT
FROM STAR_WARS S, CASTING C
WHERE S.EPISODE_ID = C.EPISODE_ID
GROUP BY EPISODE_NAME, OPEN_YEAR
ORDER BY OPEN_YEAR;

-- 10. ��Ÿ���� ��ü �ø���� �� ��캰 �迪�̸�, �����̸�, �⿬Ƚ���� ��ȸ
-- �⿬Ƚ���� ���� �迪�̸�, �����̸� ������ ��ȸ

SELECT CH.CHARACTER_NAME, CA.REAL_NAME, COUNT(*) AS TIMES
FROM CHARACTERS CH, CASTING CA
WHERE CH.CHARACTER_ID = CA.CHARACTER_ID
GROUP BY CH.CHARACTER_NAME, CA.REAL_NAME;

-- 11. �� �������� ������ ���� 3���� �迪��, �Ǹ�, �⿬Ƚ��
-- �ζ��� �� �������� Ȱ�� �ϰų�
-- RANK(), DENSE_RANK() �Լ��� Ȱ��

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

-- 12. ��Ÿ���� �ø�� � �ø�� ����� ��찡 �⿬�ߴ��� ��ȸ
-- ���Ǽҵ� ��ȣ, �̸�, �⿬��� �� ��ȸ, �⿬������ ���� ������ ��ȸ

SELECT S.EPISODE_ID, S.EPISODE_NAME, COUNT(*) AS CNT
FROM STAR_WARS S, CASTING C
WHERE S.EPISODE_ID = C.EPISODE_ID
GROUP BY S.EPISODE_ID, S.EPISODE_NAME
ORDER BY 3 DESC;


