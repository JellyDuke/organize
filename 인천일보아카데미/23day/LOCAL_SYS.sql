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
--ADD CONSTRAINT �ĺ��̸� ������������ (�ο����÷���);

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

--=================================5.22==========================================
--��������
CREATE TABLE MEMBERS1(
    MID1 NVARCHAR2(20),  --���̵�
    MPW1 NVARCHAR2(20),  --��й�ȣ
    MNAME1 NVARCHAR2(5), --�̸�
    MEMAIL1 NVARCHAR2(20)--�̸���
);
--���� ���� �ο�(MID �÷��� UNIQUE)
ALTER TABLE MEMBERS1
ADD CONSTRAINT UK_MEM1_MID UNIQUE(MID);

--�������� �ο� - ���̺��� �����ϸ鼭 �������� �ο� 1
CREATE TABLE MEMBERS2(
    MID2 NVARCHAR2(20) CONSTRAINT UK_MEM2_MID UNIQUE,  --���̵�
    MPW2 NVARCHAR2(20),  --��й�ȣ
    MNAME2 NVARCHAR2(5), --�̸�
    MEMAIL2 NVARCHAR2(20)--�̸���
);
--�������� �ο� - ���̺��� �����ϸ鼭 �������� �ο� 2
CREATE TABLE MEMBERS3(
    MID NVARCHAR2(20),  --���̵�
    MPW NVARCHAR2(20),  --��й�ȣ
    MNAME NVARCHAR2(5), --�̸�
    MEMAIL NVARCHAR2(20),--�̸���
    CONSTRAINT UK_MEM3_MID UNIQUE(MID)
);
-- UNIQUE : ���̺��� Ư���� �÷� �ο� �ߺ��Ǵ� ���� �Էµ��� �ʵ��� ����
INSERT INTO MEMBERS3(MID, MPW, MNAME, MEMAIL)
VALUES('PJH', '1111', '����ȣ','WNGHQKR@NAVER'); --F9����
INSERT INTO MEMBERS3(MID, MPW, MNAME, MEMAIL)
VALUES('PJH', '1234', '����ȣ','abc@NAVER'); --F9����

--MID �÷��� NULL�� �Է�
INSERT INTO MEMBERS3(MID, MPW, MNAME, MEMAIL)
VALUES(NULL, '1234', '����ȣ','WNGH-QKR@NAVER'); --F9����
INSERT INTO MEMBERS3(MPW, MNAME, MEMAIL)
VALUES('111-1', '��-��ȣ','WNGH-QKR@NAVER'); --F9����
SELECT * FROM MEMBERS3;

--NOT NULL: ������ �÷��� NULL ���� ������� �ʴ´�.
--���� ������ ���� ������ �⺻������ NULL�� ���
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20) CONSTRAINT NN_MEM_MID NOT NULL,--�׳� NOT NULL �ᵵ ��
    MPW NVARCHAR2(20),  --��й�ȣ
    MNAME NVARCHAR2(5), --�̸�
    MEMAIL NVARCHAR2(20),--�̸���
    CONSTRAINT UK_MEM_MID UNIQUE(MID)
);
INSERT INTO MEMBERS(MID ,MPW, MNAME, MEMAIL)
VALUES(NULL, '1234', '����ȣ','WNGHQKR@NAVER');
--ORA-01400: NULL�� ("SYS"."MEMBERS"."MID") �ȿ� ������ �� �����ϴ�
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --���̵�
    MPW NVARCHAR2(20),  --��й�ȣ
    MNAME NVARCHAR2(5), --�̸�
    MEMAIL NVARCHAR2(20),--�̸���
    CONSTRAINT UK_MEM_MID UNIQUE(MID)
);
ALTER TABLE MEMBERS
MODIFY MID NOT NULL; --NOT NULL�� ���� MODIFY�� ���
DESC MEMBERS;

ALTER TABLE MEMBERS --���������� ����� UNIQUE
DROP CONSTRAINT UK_MEM_MID;

ALTER TABLE MEMBERS
MODIFY MID NULL; --NOT NULL �� NULL�� �����Ͽ� �⺻������ ����(����)

--��������
--  UNIQUE: ���̺��� Ư���� �÷� �ο�, �ߺ��Ǵ� ���� �Էµ��� �ʵ��� ����
--  NOT NULL: Ư�� �÷��� NULL���� �Էµ��� �ʵ��� ����
--  PRIMARY KEY: UNIQUE + NOT NULL
--               ���̺��� ���ڵ带 ���� ���� �� �ִ� ������ �÷��� �ο�            

DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --���̵�
    MPW NVARCHAR2(20),  --��й�ȣ
    MNAME NVARCHAR2(5), --�̸�
    MEMAIL NVARCHAR2(20)--�̸���
);
-- MID �÷��� PRIMARY KEY �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MID);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( 'PJH','1111','����ȣ','WNGHQKR@NAVER.COM');

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( 'PJH','1234','1234','1234'); --UNIQUE Ȯ��

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( NULL,'1111','����ȣ','WNGHQKR@NAVER.COM'); --NOT NULL Ȯ��

--�̸��� �÷��� UNIQUE ���� ���� �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE(MEMALL);

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( '01','1111','����ȣ',NULL);

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( '02','1111','����ȣ',NULL);

-- MNAME �� PRIMERY KEY �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MNAME); --�⺻Ű�� �����̺� ����
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE(MNAME);
SELECT * FROM MEMBERS;

-- DEFAULT: Ư���� �÷��� ���� �Էµ��� ���� ��� �⺻���� �ԷµǴ� ���� ����
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --���̵�
    MPW NVARCHAR2(20),  --��й�ȣ
    MNAME NVARCHAR2(20) DEFAULT '�̸�����',--�̸�
    MAGE NUMBER         --����
);
-- ���� �÷��� �⺻�� 1 ����
ALTER TABLE MEMBERS
MODIFY MAGE DEFAULT 1; --����

INSERT INTO MEMBERS(MID,MPW,MAGE)
VALUES( '01','1234',10);
INSERT INTO MEMBERS(MID, MAGE)
VALUES( '01',10);
SELECT * FROM MEMBERS;
INSERT INTO MEMBERS(MID, MPW, MNAME, MAGE)
VALUES( '02','1111',DEFAULT,20);


--CHECK : Ư���� �÷��� �Է��� �� �ִ� ���� ���� ���� �ο�
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --���̵�
    MPW NVARCHAR2(20),  --��й�ȣ
    MNAME NVARCHAR2(20),--�̸�
    MAGE NUMBER         --����
    CONSTRAINT CK_MEM_MAGE CHECK(MAGE > 10)
);
INSERT INTO MEMBERS(MAGE)
VALUES(30); --1 ���� ���ԵǾ����ϴ�.
SELECT * FROM MEMBERS;
INSERT INTO MEMBERS(MAGE)
VALUES(5); -- üũ ��������(SYS.CK_MEM_MAGE)�� ����Ǿ����ϴ�

--��������
-- PRIMARY KEY
-- FOREIGN KEY
-- UNIQUE 
-- NOT NULL
-- CHECK
-- DEFAULT
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --���̵�
    MPW NVARCHAR2(20)   --��й�ȣ
);
--MID �÷��� PRIMARY KEY �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MID);
INSERT INTO MEMBERS(MID, MPW) --ȸ�� ���� �Է�
VALUES('Y','1111');
INSERT INTO MEMBERS(MID, MPW) --ȸ�� ���� �Է�
VALUES('ABC','1111');
SELECT * FROM MEMBERS;

DROP TABLE LOGINCHECK;
CREATE TABLE LOGINCHECK( --ȸ���� �α��� �ð�
    MID NVARCHAR2(20),   --ȸ�� ���̵� -MEMBERS ���̺��� MID
    LOGINTIME DATE       --�α��� �ð�
);

-- LOGINCHECK ���̺� MID �÷��� FOREIGN KEY ����
ALTER TABLE LOGINCHECK
ADD CONSTRAINT FK_LOG_MID FOREIGN KEY(MID)
REFERENCES MEMBERS(MID);


INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('PJH',SYSDATE); --���Ἲ ��������(SYS.FK_LOG_MID)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('Y',SYSDATE);   --MEMBERS�� �ִ� ���̵�� ����

INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('ABC',SYSDATE); --MEMBERS�� �ִ� ���̵�� ����

SELECT * FROM LOGINCHECK;

--========================5.23============================
--FOREING KEY: �ܷ�Ű
--��ǰ���� ���̺� - GOODS
--��ǰ�̸� - GNAME ����Ÿ�� 20���ڱ���, PRIMARY KEY�� ����
--��ǰ���� - GPRICE ����Ÿ��
--��ǰ�귣�� - GBRAND ����Ÿ�� 20���ڱ��� - NOT NULL

CREATE TABLE GOODS(
    GNAME NVARCHAR2(20) ,  --��ǰ�̸�
    GPRICE NUMBER,  --��ǰ����
    GBRAND NVARCHAR2(20)  --��ǰ�귣��
);
--���� ���� �ο�
ALTER TABLE GOODS
ADD CONSTRAINT PK_GOODS_GNAME PRIMARY KEY(GNAME)
MODIFY GBRAND NOT NULL;
-- ��ǰ ���� �Է�

INSERT INTO GOODS(GNAME, GPRICE, GBRAND) 
VALUES('���׻�','5000000','�ô�');
INSERT INTO GOODS(GNAME, GPRICE, GBRAND) 
VALUES('����','5000000','���');
INSERT INTO GOODS(GNAME, GPRICE, GBRAND) 
VALUES('��Ʋ��Ƽ��','5000000','�ٴ�');


--�ֹ������� ���̺� - ORDERLIST
--��ǰ�̸�, ����, ������, �ֹ��Ͻ�, �����, �ֹ�����
CREATE TABLE ORDERLIST(
    GNAME NVARCHAR2(20),    --��ǰ�̸�
    GPRICE NUMBER,          --��ǰ����
    CUSTOMER NVARCHAR2(10), --��
    ODDATE DATE ,           --�ֹ�����
    ADDRESS NVARCHAR2(50),  --�����
    QTY NUMBER              --�ֹ���
);
--FOREIGN KEY (�ܷ�Ű) ����
ALTER TABLE ORDERLIST
ADD CONSTRAINT FK_ODLIST_GNAME FOREIGN KEY(GNAME)
REFERENCES GOODS(GNAME);
--�ֹ� ���� �Է�
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('���׻�','5000000','����ȣ',SYSDATE,'��õ',1); --�Է°���
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('����','5000000','����ȣ',SYSDATE,'��õ',2);
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('��Ʋ��Ƽ��','5000000','����ȣ',SYSDATE,'��õ',3);
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('���׻�','5000000','����ȣ',SYSDATE,'��õ',4);
SELECT * FROM ORDERLIST;

INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('���̴�','5000000','����ȣ',SYSDATE,'��õ',1); --�ԷºҰ���
--���Ἲ ��������(SYS.FK_ODLIST_GNAME)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

/*
CREATE - INSERT: ������ �Է�
READ   - SELECT: ������ ��ȸ
UPDATE - UPDATE: ������ ����
DELETE - DELETE: ������ ����
*/

--INSERT��
--INSERT INTO ���̺��̸�(�÷���1, �÷���2, .... �÷���N)
--VALUES(�÷�1�� ������ ��, �÷�2�� ������ ��, .....);
DROP TABLE ORDERLIST;
DROP TABLE GOODS;
CREATE TABLE GOODS(
    GNAME NVARCHAR2(20) ,  --��ǰ�̸�
    GPRICE NUMBER,  --��ǰ����
    GBRAND NVARCHAR2(20)  --��ǰ�귣��
);
INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('��ǰ��1',10000,'�귣��1');
INSERT INTO GOODS(GBRAND,GNAME)
VALUES('�귣��2','��ǰ��2');
INSERT INTO GOODS(GBRAND)
VALUES('�귣��2');
--�÷����� ������� ������ VALUES �׸��� ���̺��� ��� �÷� ��
INSERT INTO GOODS
VALUES('�귣��2'); -- GNAME, GPRICE, GBRAND ���缭 �ؾ���.
SELECT * 
FROM GOODS
WHERE GBRAND = '�귣��1';
--���� ����
--����Ʈ ��ȸ - SELECT  
--[5]SELECT ��ȸ���÷���1, ��ȸ���÷���2....
--[1]FROM ���̺��
--[2]WHERE ����
--[3]GROUP BY �׷��� ���� �÷�
--[4]HAVING ������ �׷쿡 �ο��� ����
--[6]ORDER BY ���ı����÷�

--������ ���� - UPDATE
--UPDATE ���̺��
--SET �÷���1 = ������ ������, �÷���2 = �����ҵ�����
--WHERE �����͸� ������ ���ڵ带 ������ ����
SELECT * FROM GOODS;
UPDATE GOODS
SET GPRICE = 115000, GBRAND = '�귣������'
WHERE GNAME = '��ǰ��1';

--������ ����: DELETE
--DELETE FROM ���̺��
--WHERE ������ ���ڵ带 �����ϴ� ����

DELETE FROM GOODS
WHERE GNAME = '��ǰ��1'; -- 1���� ����
DELETE FROM GOODS; --5�� ��ü ����

ROLLBACK;
SELECT * FROM GOODS;

DROP TABLE GOODS;
CREATE TABLE GOODS(
    GNAME NVARCHAR2(20) ,  --��ǰ�̸�
    GPRICE NUMBER,  --��ǰ����
    GBRAND NVARCHAR2(20)  --��ǰ�귣��
);
INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('��ǰ��1',10000,'�귣��1');
INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('��ǰ��2',15000,'�귣��1');

COMMIT; --> Ŀ�� ������ ���� (���̺� ����)
ROLLBACK; --> ������ ������ �ѹ�
SELECT * FROM GOODS; --> Ȯ�� ���ڵ� 2��

DELETE FROM GOODS
WHERE GNAME = '��ǰ��1'; -- 1���� ����
DELETE FROM GOODS; --5�� ��ü ����

INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('��ǰ��3',15000,'�귣��1');
ROLLBACK;

CREATE TABLE TESTTBL01(COL01 NUMBER); --�����ϸ� �ڵ�����. (���̺� ����� �ڵ� ����.)
ROLLBACK;
SELECT * FROM GOODS;
