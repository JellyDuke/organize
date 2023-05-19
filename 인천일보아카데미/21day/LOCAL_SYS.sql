--���� ����
--CREATE user ���̵� identified by ��й�ȣ;
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; -- ���� ����� ��Ģ ����
CREATE USER PJH_TEST IDENTIFIED BY "1111"; -- ����(F9)
--���� �ο�
--GRANT CREATE SESSION TO ���̵�; <-���ӱ���.
GRANT CREATE SESSION TO PJH_TEST; 
--���� ȸ��
--REVOKE CREATE SESSION FROM ���̵�; <-ȸ��.
REVOKE CREATE SESSION FROM PJH_TEST;
--���� ���� 
--DROP USER ���̵�;
DROP USER PJH_TEST;

--CRUD
--CREATE - INSERT 
--READ - SELECT
--UPDATE - UPDATE
--DELETE - DELETE

--DBA ��������
CREATE USER PJH_DBA 
IDENTIFIED BY "1111";
--DBA ���� �ο� (dba�� ��� ����)
GRANT DBA TO PJH_DBA;

--���̺� ����
CREATE TABLE MEMBERS( --ȸ������ ���̺�
    MID NVARCHAR2(5), --���̵� ����, ���� �ִ� 5���ڱ���
    MPW NVARCHAR2(5), --��й�ȣ
    MNAME NVARCHAR2(5)
);
DESC MEMBERS; --���̺� ���� Ȯ��
SELECT * FROM members;
INSERT INTO members VALUES('ID01','PW01','ȸ��01');
INSERT INTO members VALUES('ID02','PW02','ȸ��02');
INSERT INTO members VALUES('ID03','PW03','ȸ��03');
SELECT * FROM members;

-- ���̺� ���� 
-- CREATE TABLE ���̺��̸�(
-- �÷���1 ������Ÿ��,
-- �÷���2 ������Ÿ��,
-- �÷���n ������Ÿ��
-- );

--Table ���̺��̸���(��) �����Ǿ����ϴ�.

CREATE TABLE TESTTBL(
    COL01 CHAR(5),
    COL02 VARCHAR(10)
);
/* ������Ÿ��
������ - ������: CHAR(5) (N�� ������ ���ڸ� ������ ������ ũ�⸦ �ǹ��Ѵ�.) 5����Ʈ ����
        ������: [NVARCHAR2(10 10���ڸ� ����)] 1����Ʈ�� ����
������ - [NUMBER(���� �ڸ���)] <- �ƹ��͵� �Ⱦ��� ���� ����,
        NUMBER(3), NUMBER(3 �ִ� 3�ڸ��� ,2 �Ҽ��� 2�ڸ���)
��¥�� - [DATE] // ��-��-��  ��:��:��    ,����
            YYYY-MM-DD HH24:MI:SS
*/


CREATE TABLE CHARTEST_TBL(
    CHARCOL1 CHAR(5), --5BYTE
    NCHARCOL2 NCHAR(5) --5����
);
--INSERT��
--INSERT INTO ���̺��(�÷���1,�÷���2)
--VALUES(������1,������2);


INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('ABCDE','ABCDE');
SELECT *
FROM chartest_tbl;

INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('�����ٶ�','ABCDE'); --���� ���� ���� ���� �ʹ� ŭ(����: 15, �ִ밪: 5) �ѱ��� 3����Ʈ�� ���

INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('ABCDE','�����ٶ�');

CREATE TABLE NUMBERTEST_TBL(
    COL1 NUMBER,
    COL2 NUMBER(3),
    COL3 NUMBER(3,2)
);

INSERT INTO NUMBERTEST_TBL
VALUES(123, 123, 1.23);
SELECT * FROM NUMBERTEST_TBL;

INSERT INTO NUMBERTEST_TBL
VALUES(12345678, 123, 1.23); --����

INSERT INTO NUMBERTEST_TBL
VALUES(123567, 12345, 1.23); --  �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�.

INSERT INTO NUMBERTEST_TBL
VALUES(123567, 123, 1.23456789); -- ���༺�������� ������ 1.23���� ��

INSERT INTO NUMBERTEST_TBL1111
VALUES(123567, 123, 12.3); -- �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�.

--��¥�� ������
CREATE TABLE DATETEST_TBL(
    COL1 DATE
);
--�ý��� DATE �Է�
INSERT INTO DATETEST_TBL VALUES(SYSDATE);
SELECT *
FROM DATETEST_TBL;

INSERT INTO DATETEST_TBL VALUES('2023/05/19');
INSERT INTO DATETEST_TBL VALUES('2023-07-19');
SELECT * FROM DATETEST_TBL;
INSERT INTO DATETEST_TBL VALUES('2023/05/19 23:50:48');
INSERT INTO DATETEST_TBL VALUES('202305191159');
--TO_DATE('��¥�� ������ ����','��¥Ȯ�ι��'):������>> ��¥������ ��ȯ
INSERT INTO DATETEST_TBL
VALUES( TO_DATE('2023-07-19 23:50:48', 'YYYY-MM-DD HH24:MI:SS'));

--TO_CHAR('���ڷ� ������ ��¥', '������ ����');
SELECT TO_CHAR(COL1, 'YYYY/MM/DD')
FROM DATETEST_TBL;

--���̺���
--ALTER TABLE ���̺��̸�
--[ADD,RENAME,MODIFY,DROP]

--���ο� �÷� �߰�
--ALTER TABLE ���̺��̸�
--ADD �÷��� ������Ÿ��
CREATE TABLE ALTER_TBL(
    COL1 NUMBER
);
--ALTER_TBL ���̺� �÷��̸��� NAME, ������Ÿ���� NVARCHAR2(5) �÷� �߰�
ALTER TABLE ALTER_TBL
ADD NAME NVARCHAR2(5);
--�÷� �̸� ����
--ALTER TABLE ���̺��̸�
--RENAME COLUMN �����÷��� TO �ٲ��÷���
--ALTER_TBL ���̺� COL1 �÷����� AGE�� ����
ALTER TABLE ALTER_TBL
RENAME COLUMN COL1 TO AGE;
DESC ALTER_TBL; --���̺� ����Ȯ��
--�÷��� ������ Ÿ�� ����
--ALTER TABLE ���̺� �̸�
--MODIFY �÷��� ������Ÿ��;
-- ALTER_TBL ���̺� EMAIL NUMBER �÷��� �߰�
-- ALTER_TBL ���̺��� EMAIL �÷��� ������Ÿ���� ������ �ִ� 20���ڱ���
ALTER TABLE ALTER_TBL
ADD EMAIL NUMBER;

ALTER TABLE ALTER_TBL
ADD EMAIL NVARCHAR2(20);

--�÷� ����
--ALTER TABLE ���̺��̸�
--DROP COLUMN �÷���;

--ALTER_TBL ���̺��� AGE �÷��� ����
ALTER TABLE ALTER_TBL
DROP COLUMN AGE;
DESC ALTER_TBL;

--��������
-- PRIMARY KEY
-- FOREIGN KEY
-- UNIQUE 
-- NOT NULL
-- CHECK
-- DEFAULT

-- UNIQUE : ���̺��� Ư���� �÷� �ο� �ߺ��Ǵ� ���� �Էµ��� �ʵ��� ����
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20), --���̵�
    MPW NVARCHAR2(20), --��й�ȣ
    MNAME NVARCHAR2(5),--�̸�
    MEMAIL NVARCHAR2(20)--�̸���
);
--ȸ������ �Է�
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','����ȣ','wnghqkr@naver.com'); --�Ʒ� 195���� ���� ���� �Է¼���
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','��õ�Ϻ�','wnghqkr@naver.com'); -- 195�� ���� ���� ����. ���Ἲ ���� ����(PJH_DBA.UK_MEM_MID)�� ����˴ϴ�
select * from MEMBERS;

--���̺� �������� �ο�
--ALTER TABLE ���̺��̸�
--ADD CONSTRANINT �ĺ��̸� ������������ (�ο����÷���);

--MEMBERS ���̺��� MID �÷��� UNIQUE �������� �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE (MID); --�ߺ� �����Ͱ� �����ؼ� ���� �߻�
DELETE FROM MEMBERS; --������ ���� MEMBERS ���̺�κ��� 

ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE (MID);

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','����ȣ','wnghqkr@naver.com'); --�Ʒ� 195���� ���� ���� �Է¼���
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','��õ�Ϻ�','wnghqkr@naver.com'); -- 195�� ���� ���� ����. ���Ἲ ���� ����(PJH_DBA.UK_MEM_MID)�� ����˴ϴ�.

--MEMBERS ���̺��� MEMAIL �÷��� UNIQUE �������� �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE(MEMAIL);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','��õ�Ϻ�','wnghqkr@naver.com');