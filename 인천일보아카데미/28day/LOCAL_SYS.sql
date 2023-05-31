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
--==========================5.24=============================

DROP TABLE DEPT;
CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;
DROP TABLE EMP;
CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
DROP TABLE BONUS;
CREATE TABLE BONUS
	(
	ENAME VARCHAR2(10)	,
	JOB VARCHAR2(9)  ,
	SAL NUMBER,
	COMM NUMBER
	) ;
DROP TABLE SALGRADE;
CREATE TABLE SALGRADE
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

SELECT * FROM EMP;
SELECT * FROM DEPT;

/* SELECT�� 
   SELECT �÷���1, �÷���2
   FROM ���̺��
   WHERE ����
*/
SELECT *
FROM EMP; --EMP ���̺��� ��� �÷�
--������ȣ (EMPNO), �����̸�(ENAME) ��ȸ
SELECT EMPNO, ENAME
FROM EMP;

--�μ���ȣ�� 10���� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO = 10;
-- ����(JOB)�� SALESMAN�� �������� ������ȣ(EMPNO), �̸�(ENAME), �޿�(SAL)�� ��ȸ
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

--�μ���ȣ�� 10���� �ƴ� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO != 10;

-- ����(JOB)�� SALESMAN�� �ƴ� �������� ������ȣ(EMPNO), �̸�(ENAME), �޿�(SAL)�� ��ȸ
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB != 'SALESMAN';

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE NOT JOB = 'SALESMAN';

--�޿���(SAL)�� 1500 �̻�, 2500������ �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE SAL >= 1500 AND SAL <=2500;

SELECT *
FROM EMP
WHERE SAL BETWEEN 1500 AND 2500;

/*���� ������
  ����(JOB)�� SALESMAN�� �������� ������ȣ(EMPNO), �̸�(ENAME), �޿�(SAL)�� ��ȸ
*/
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

-- ���ϵ� ���� : LIKE Ű����� �Բ� ���
-- 1. _ : � ���̵� �ѱ��ڸ� ��ü ���ִ� ����
-- 2. % : ���̿� ��� ���� ��ü���ִ� ����

-- ����(JOB)�� 'SA   MAN'(SALESMAN �߰� 3���� �𸥴ٰ� ����)�� �������� ��� ���� ��ȸ
SELECT *
FROM EMP
WHERE JOB LIKE 'SA___MAN';

SELECT *
FROM EMP
WHERE JOB LIKE 'SA%MAN';
--�����̸�(ENAME)�� �׹�° ���ڰ� 'K'�� �������� ��� ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '___K%';
--�����̸��� 4������ ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '____';

--���� - NULL
--COMM�� ���� �ʴ� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NULL ;

--COMM�� �޴� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NOT NULL ;

--����-��¥��
--�Ի��� (HIREDATE)�� 1981�� 9�� 8���� ������ ��� ������ ��ȸ

SELECT *
FROM EMP
WHERE HIREDATE ='1981-09-08 19:37';

UPDATE EMP
SET HIREDATE = '1981-09-08 19:37'
WHERE EMPNO = 7844;
--�Ի���(HIREDATE)�� 1981�� 9�� 8���� ������ ��� ������ ��ȸ
--TO_DATE: ���ڸ� ��¥��
--TO_CHAR: ��¥�� ���ڷ�
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY-MM-DD') ='1981-09-08'; -- '1981-09-08'== '1981-09-08'
--�Ի���(HIREDATE) 1981�� 9�� ������ �������� ��� ���� ��ȸ
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY-MM') >= '1981-09';

SELECT *
FROM EMP
WHERE HIREDATE >= TO_DATE('1981-09','YYYY-MM');

SELECT *
FROM EMP
WHERE HIREDATE >= '1981-09';

--�Ի���(HIREDATE) 12�� �������� ��� ���� ��ȸ
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = '12';

SELECT SYSDATE, SYSDATE -1, SYSDATE+1, SYSDATE-(1/24)/60 --��¥ 1��/�ð� 24�ð�/�� 60��
FROM DUAL;

/* ��Ī(ALIAS)*/
-- �÷��� AS ��Ī
SELECT EMPNO AS ������ȣ, ENAME AS �����̸�, TO_CHAR(HIREDATE, 'YYYY-MM') AS HIREDATE
FROM EMP;
-- �÷��� AS "��Ī"
SELECT EMPNO AS "������ȣ", ENAME AS "�����̸�", TO_CHAR(HIREDATE, 'YYYY-MM') AS "HIREDATE"
FROM EMP;
-- �÷��� ��Ī
SELECT EMPNO ������ȣ, ENAME �����̸�, TO_CHAR(HIREDATE, 'YYYY-MM') HIREDATE
FROM EMP;
-- �÷��� "��Ī"
SELECT EMPNO "������ȣ", ENAME "�����̸�", TO_CHAR(HIREDATE, 'YYYY-MM') "HIREDATE"
FROM EMP;

--���� ����
SELECT ENAME, SAL||' �޷�'
FROM EMP;
SELECT EMPNO||','||ENAME
FROM EMP;

SELECT TO_CHAR(HIREDATE, 'YYYY')||'��'||TO_CHAR(HIREDATE, 'MM')||'��'||TO_CHAR(HIREDATE, 'DD')||'��' AS �Ի���
FROM EMP;

SELECT ENAME AS �����̸�, SAL AS ����, SAL * 12 AS ����
FROM EMP;
--=======================5.25==============================

--WHERE - AND, OR
--�Ի� �⵵�� 1981�� �̰� �μ���ȣ�� 30���� �������� �̸���, ��å�� ��ȸ

SELECT ENAME, JOB, HIREDATE, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981' AND DEPTNO = 30; --6��

--�Ի�⵵�� 1981�� �̰ų� �μ���ȣ�� 20���� �������� �̸���, ��å�� ��ȸ
SELECT ENAME, JOB, HIREDATE, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981' OR DEPTNO = 20; -- 11��

--��å(JOB)�� 'MANAGER' �̰ų� 'SALESMAN'�� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
--��å(JOB)�� 'MANAGER' �̰ų� 'SALESMAN'�Ǵ� 'ANALYST'�� �������� ��� ������ ��ȸ
SELECT *
FROM EMP
WHERE JOB IN('MANAGER','SALESMAN','ANALYST');

--��å(JOB)�� 'MANAGER' �̰ų� 'SALESMAN'�� ������ �߿��� COMM�� ���� �ʴ� ������ ������ ��ȸ
SELECT *
FROM EMP
WHERE (JOB = 'MANAGER' OR JOB = 'SALESMAN') AND COMM IS NULL;
--��ȣ �� ��ߵ�

SELECT *
FROM EMP
WHERE JOB = 'SALESMAN' OR JOB = 'MANAGER' AND COMM IS NULL;

SELECT *
FROM EMP
WHERE JOB IN('MANAGER','SALESMAN') AND COMM IS NULL ;

SELECT *
FROM EMP
WHERE JOB IN('SALESMAN','MANAGER') AND COMM IS NULL ;

SELECT *
FROM EMP
WHERE JOB = 'SALESMAN';
-- �빮�� ��ȯ: UPPER, �ҹ��� LOWER
SELECT *
FROM EMP
WHERE JOB = 'salesman'; --��ҹ��� ����

-- UPPER('���ڵ�����') >> �빮�ڷ� ��ȯ
SELECT *
FROM EMP
WHERE JOB = UPPER('salesman');
-- LOWER('���ڵ�����') >> �ҹ��ڷ� ��ȯ
SELECT *
FROM EMP
WHERE LOWER(JOB) = 'salesman';

--LENGTH('����') >> ������ ����
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- �׷��Լ�
-- SUM, COUNT, MAX, MIN, AVG

-- SUM(): ������ ���ϴ� �Լ�
-- �������� SAL�� ����
SELECT SUM(SAL)
FROM EMP;

-- COUNT() ��ȸ�Ǵ� ���ڵ��� ���
SELECT COUNT(ENAME)
FROM EMP;

--MAX() �ش� �÷��� �ִ밪 ���ϴ� �Լ�
SELECT MAX(SAL)
FROM EMP;

--MIN() �ش� �÷��� �ּҰ� ���ϴ� �Լ�
SELECT MIN(SAL)
FROM EMP;
--AVG() �ش� �÷��� ��հ� ���ϴ� �Լ�
SELECT AVG(SAL)
FROM EMP;

--��� ������ �̸���, �޿��� ��ȸ
SELECT ENAME, SAL
FROM EMP;

--�μ���ȣ �޿� ��ȸ
SELECT DEPTNO, SAL
FROM EMP;

--�μ��� �޿��� ����
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB;

--�μ��� �ο��� ��ȸ
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;

-- 20�� �μ��� �ο��� ��ȸ
SELECT DEPTNO, COUNT(*)
FROM EMP
WHERE DEPTNO = 20
GROUP BY DEPTNO;

SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO = 20;

/*
SELECT �÷���
FROM ���̺��
WHERE ����
GROUP BY �׷��� ���� �÷�
HAVING �׷� ���� (GROUP BY�� ���� ��)
GROUP BY ���� ����
*/
--�μ��� �׷��� �����ϰ�, �ο��� 4�� �̻��� �μ� ��ȸ
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 4;
-- ��å(JOB)�� ��� �޿�(SAL)�� 3000�̻��� ��å�� ��� �޿�, �ο��� ��ȸ
SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
GROUP BY JOB, SAL
HAVING AVG(SAL) >= 3000;

-- ��å(JOB)�� ��� �޿�(SAL)�� 3000�̻��� [��å��] [��� �޿�], [�ο��� ��ȸ]
-- �� �μ��� 10, 30�� ������ �������
SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
WHERE DEPTNO IN(10,30)
GROUP BY JOB
HAVING AVG(SAL) >= 3000;

SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
GROUP BY JOB, DEPTNO
HAVING AVG(SAL) >= 3000 AND DEPTNO IN(10,30); --������ ��

--�ο����� 5�� �̻��� �μ��� �μ���ȣ, �ο���, ��տ��� ��ȸ
SELECT DEPTNO, AVG(SAL*12), COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 5;

--NVL(�÷���, ��ü�� ��)
SELECT ENAME, JOB, (SAL + COMM), SAL, COMM, NVL(COMM, 0), (SAL + NVL(COMM,0))
FROM EMP;

--ORDER BY: ���ı��� - ��������, ��������
SELECT *
FROM EMP
ORDER BY ENAME ASC; --�����̸� ���� ���� ���� ���� (ASC ���� ����)

SELECT *
FROM EMP
ORDER BY ENAME DESC, SAL; --��å ���� �������� ���� (DESC �ʼ� )

/*
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
*/

--�̸��� WARD�� ������ ���� �μ����� �ٹ��ϴ� �������� ������ ��ȸ
--1. �̸��� WARD�� ������ �μ���ȣ ��ȸ -- DEPTNO == 30
SELECT ENAME
FROM EMP
WHERE ENAME = 'WARD'; --30

--2. ��ȸ�� �μ���ȣ�� �������� �ش� �μ��� �������� ��ȸ -- �Ʒ� ���¸� �������̶� ��
SELECT *
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'WARD');

SELECT *
FROM (SELECT * FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') ='1981')
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'WARD');



--========================5.26==============================

-- ���� ���� 
-- WHERE �� SELECT �� ���
--WHERE��: Ư���� ���ڵ带 �����ϱ� ���� ����

-- �μ���ȣ�� 10�� �������� ������ ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO = 10;
--���� �̸��� KING�� ������ ���� �μ����� �ٹ��ϴ� �������� ������ ��ȸ
--1. �̸��� KING�� ������ �μ���ȣ ��ȸ
SELECT DEPTNO
FROM EMP
WHERE ENAME = 'KING'; -- 10

--2. 10�� �μ����� �ٹ��ϴ� �������� ������ ��ȸ
SELECT *
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'KING');

SELECT *
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO -- =�̲÷� �ϸ� ���� �ǵ��� IN�� ���
                FROM EMP
                WHERE JOB = 'MANAGER');

-- ��� �޿����� ���� �޿��� �޴� �������� ������ ��ȸ
--1. ��� �޿� ��ȸ
SELECT AVG(SAL)
FROM EMP; --2077.084
--2. ��ȸ�� ��� �޿��� ������ �޿��� �� (�޿� SAL�� 2077���� ū ������)
SELECT *
FROM EMP
WHERE SAL >= 2077;
SELECT *
FROM EMP
WHERE SAL >= (SELECT AVG(SAL)
             FROM EMP);
--JONES ���� �޿��� ���� �޴� �������� ������ ��ȸ
--1. JONES�� SAL ��ȸ
SELECT *
FROM EMP
WHERE ENAME = 'JONES';
--2. ��ȸ�� JONES�� SAL���� ���� �޿��� �޴� ������ ������ ��ȸ
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES');
--SALESMAN �� �ٹ����� �ʴ� �μ��� �μ���ȣ�� �ο����� ��ȸ

SELECT DEPTNO
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT DEPTNO, COUNT(*)
FROM EMP
WHERE DEPTNO NOT IN (SELECT DEPTNO
                    FROM EMP
                    WHERE JOB = 'SALESMAN')
GROUP BY DEPTNO;       

--JAMES�� ���� �޿� �Ի��� ������ �̸��� ���� �޿��� ��ȸ
--1.'JAMES' �� �Ի��� ��(MONTH) ��ȸ --'12'
SELECT TO_CHAR(HIREDATE,'MM')
FROM EMP
WHERE ENAME = 'JAMES';
--2. 12���� �Ի��� ������ �̸� ���� �޿�
SELECT ENAME,JOB, SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = '12';

SELECT ENAME,JOB, SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = (SELECT TO_CHAR(HIREDATE,'MM')
                                FROM EMP
                                WHERE ENAME = 'JAMES');

-- �μ��� ��� �޿��� 'MANAGER'�� ��� �޿� ���� ���� �μ��� ��ȣ�� ��ձ޿��� ��ȸ 
--1. ��ձ޿�
SELECT AVG(SAL)
FROM EMP
WHERE JOB = 'MANAGER';
--2. �μ��� ��� �޿� ��ȸ
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>(SELECT AVG(SAL)
                 FROM EMP
                 WHERE JOB = 'MANAGER');

--JOIN: �� �� �̻��� ���̺��� �����Ͽ� �ϳ��� ���̺�ó�� ����� ���
--INNER JOIN, OUTER JOIN

SELECT *
FROM EMP, DEPT --48���� ���ڵ�
WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME= 'SMITH';

SELECT *
FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.ENAME = 'SMITH';

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT E.ENAME, D.DNAME, D.DEPTNO
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP; --12���� ���ڵ�
SELECT *
FROM DEPT; --4���� ���ڵ�

-- 'SMITH'�� �ٹ��ϴ� �μ��� �̸�, ������ȸ
SELECT D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME = 'SMITH';

SELECT DEPT.DNAME, DEPT.LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'SMITH';

SELECT DNAME, LOC
FROM DEPT
WHERE DEPTNO = ( SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH');

-- 'NEW YORK'���� �ٹ��ϴ� ������ �μ��̸�, �����̸�, ��å��ȸ
SELECT DEPT.DNAME, EMP.ENAME, EMP.JOB
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
        AND DEPT.LOC = 'NEW YORK';

SELECT D.DNAME, E.ENAME, E.JOB
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'NEW YORK';

-- 'SMITH' ������ ����� (MCR)�� �̸� ��ȸ
SELECT ENAME
FROM EMP
WHERE EMPNO = (SELECT MGR FROM EMP WHERE ENAME = 'SMITH');

SELECT E1.ENAME ||'�� MGR��' || E2.ENAME ||'�Դϴ�'
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

--�μ��̸� || ���� || ������ 
--RESEARCH  DALLAS   3
--SALES     CHICAGO  6

--�μ��� ������ ��ȸ
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;    

SELECT *
FROM DEPT D, (SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO) COUNT_E
WHERE D.DEPTNO = COUNT_E.DEPTNO;

--=====================================5.30================================================

--�μ��� ��� �޿� ��ȸ, �μ��̸�, ��ձ޿�
SELECT D.DNAME, AVG(E.SAL)
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO =  D.DEPTNO
GROUP BY D.DNAME;



--�����̸�, �޿�, �μ��� ���
--1. EMP, �μ��� ��� �޿� ��ȸ
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;
--2. EMP, 1�� SELECT�� ����� ����
SELECT E1.ENAME, E1.SAL, E2.DEPTAVG
FROM EMP E1 INNER JOIN (SELECT DEPTNO, AVG(SAL) AS DEPTAVG FROM EMP GROUP BY DEPTNO) E2
         ON E1.DEPTNO = E2.DEPTNO;

--3. DEPTNO ��� DNAME(�μ��̸�)���� ���
SELECT E1.ENAME, E1.SAL, D.DNAME, E2.DEPTAVG
FROM EMP E1 INNER JOIN (
        SELECT DEPTNO, AVG(SAL) AS DEPTAVG  
        FROM EMP 
        GROUP BY DEPTNO) E2 ON E1.DEPTNO = E2.DEPTNO
        INNER JOIN DEPT D ON D.DEPTNO = E1.DEPTNO;
        
--�����̸�(ENAME), ����(JOB), ������ �ο��� 
--1. ������ �ο��� ��ȸ
SELECT JOB, COUNT(*) AS JOBCOUNT
FROM EMP
GROUP BY JOB;
--2. EMP ���̺� 1���� ����� ����
SELECT E.ENAME, E.JOB, E1.JOBCOUNT
FROM EMP E INNER JOIN (
        SELECT JOB, COUNT(*) AS JOBCOUNT  
        FROM EMP 
        GROUP BY JOB) E1 ON E1.JOB = E1.JOB;
-- ON ��� WHERE E1.JOB = E.JOB; �ᵵ ��

-- ROWNUM 
SELECT ROWNUM, EMP.*
FROM EMP;

--1. 
SELECT ROWNUM, EMP.*
FROM EMP
ORDER BY SAL DESC;
--�������� ������ ������� �ʾ� �Ʒ��� 2�� �������� ���ش�.
--2.
SELECT ROWNUM AS SALRANK, EMP.*
FROM (SELECT * FROM EMP ORDER BY SAL DESC) EMP;
--�޿��� ���� ���� ����� ���� ������

--3. VIEW �������̺� 3��ó�� �������� �ʰ� �ϱ� ���� 
SELECT *
FROM (SELECT ROWNUM AS SALRANK, EMP.* FROM (SELECT * FROM EMP ORDER BY SAL DESC) EMP) EMP
WHERE ENAME = 'WARD';
--VIEW
CREATE OR REPLACE VIEW SALRANK_EMP
AS( SELECT ROWNUM AS SALRANK, EMP.*
    FROM (SELECT * FROM EMP ORDER BY SAL DESC) EMP);
SELECT *
FROM SALRANK_EMP
WHERE ENAME = 'SMITH';

--UPDATE ���̺��
--SET �÷��� = ������ ��
--WHERE �����͸� ������ ���ڵ� ����

--'JAMES'�� �޿��� 1000���� ����
UPDATE EMP
SET SAL = 1000
WHERE ENAME = 'JAMES'; 

--'JAMES'�� �޿��� 100����
UPDATE EMP
SET SAL = SAL + 100
WHERE ENAME = 'JAMES';

--MGR�� 'BLAKE'�� �������� �޿��� 200 ����
UPDATE EMP
SET SAL = SAL +200
WHERE MGR = (SELECT EMPNO FROM EMP WHERE ENAME = 'BLAKE' );

--DELETE
/*
DELETE FROM ���̺��
WHERE ������ ���ڵ带 ����
*/
--����Ʈ�� �÷� �ϳ��� ���� �Ұ��� ���ڵ带 �ƿ� ���� �ع����� ����
--�޿��� ���� ���� �޴� ������ �ٹ��ϴ� �μ��� �������� ��� ����
--1.�޿��� �ּҰ� ��ȸ
SELECT MIN(SAL)
FROM EMP;
--2.�޿��� �ּҰ��� ������ �μ���ȣ ��ȸ
SELECT DEPTNO
FROM EMP
WHERE SAL = (SELECT MIN(SAL)
             FROM EMP);
--3. �ش� �μ��� ���� ������ ����
DELETE
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE SAL = (SELECT MIN(SAL)
                                  FROM EMP));
--'ALLEN'�� �μ���ȣ�� 50������ ����
UPDATE EMP
SET DEPTNO = 50
WHERE ENAME = 'ALLEN'; 
--�ȵ� ���Ἲ ���� ���ǿ� ���� - �θ�Ű�� �����ϴ� �ܷ�Ű
SELECT * FROM DEPT;
DELETE FROM DEPT
WHERE DEPTNO = 30;
--ORA-02292: ���Ἲ ��������(SYS.FK_DEPTNO)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�.
DELETE FROM DEPT
WHERE DEPTNO = 20;
--ORA-02292: ���Ἲ ��������(SYS.FK_DEPTNO)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
ROLLBACK;
select *
from emp;
select *
from dept;

--===============================5.31=========================================

--���θ� (ȸ��, ��ǰ, �ֹ�����)
--ȸ������ ���̺�(MEMBERS)
DROP TABLE LOGINCHECK;
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(10), --ȸ�� ���̵� (PRIMARY KEY)
    MPW NVARCHAR2(20), --ȸ�� ��й�ȣ(NOT NULL)
    MNAME NVARCHAR2(5),--ȸ�� �̸�      (NOT NULL)
    MPHONE NVARCHAR2(13), --ȸ�� ��ȭ��ȣ
    MBIRTH DATE         --ȸ�� �������
);
--���� ���� �ο�
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MID)
MODIFY MPW NOT NULL
MODIFY MNAME NOT NULL;

DESC MEMBERS;
DROP TABLE MEMBERS;

--��ǰ ���� ���̺�(GOODS)
--��ǰ�ڵ�, ��ǰ �̸�, ��ǰ����, ��ǰ����, ��ǰ���

DROP TABLE GOODS;
CREATE TABLE GOODS(
    GCODE NVARCHAR2(5),    --��ǰ�ڵ�PK
    GNAME NVARCHAR2(30), --��ǰ�̸�NOTNULL
    GPRICE NUMBER, -- ��ǰ����DEFAULT 1000
    GTYPE NVARCHAR2(10), -- ��ǰ����
    GSTOCK NUMBER --��ǰ ���
);
ALTER TABLE GOODS
ADD CONSTRAINT PK_GCODE PRIMARY KEY(GCODE)
MODIFY GNAME NOT NULL
MODIFY GPRICE DEFAULT 1000;

--CHECK ����
--1.GCODE �÷��� ���ڼ� ����(������ 5����)
--2.GCODE �÷��� ù ���ڴ� 'G'�� �����ϵ��� ����
--3.GSTOCK �÷��� 0�̸��� ���� �Է��Ҽ� ������ ����
SELECT LENGTH('ABCDE') FROM DUAL;
SELECT SUBSTR('ABCDEFGH',1,1) FROM DUAL; --1��° ���ں��� 3������ ���ڴ�. -> A 1�� 3���� C => ABC, ���۸� �ᵵ ��


ALTER TABLE GOODS
ADD CONSTRAINT CK_GCODE_LTH CHECK (LENGTH(GCODE) = 5);

ALTER TABLE GOODS
ADD CONSTRAINT CK_GCODE_FIRST CHECK (SUBSTR(GCODE,1,1) = 'G'); --ù���ڰ� G���� �Ѵ�.

ALTER TABLE GOODS
ADD CONSTRAINT CK_GSTOCK CHECK (GSTOCK >= 0);

DELETE FROM GOODS;
COMMIT;

SELECT * FROM GOODS;
DESC GOODS;

INSERT INTO GOODS(GCODE,GNAME,GPRICE,GTYPE,GSTOCK)
VALUES('G11','��ǰ',10000,'����',1);

--�ֹ�����(ORDERS)
--�ֹ��ڵ�PK,ȸ�����̵�(FK-MEMBER(MID)), ��ǰ�ڵ�(FK-GOODS(GCODE)), �ֹ�����, �ֹ��Ͻ�

CREATE TABLE ORDERS(
    ODCODE NVARCHAR2(5), --�ֹ��ڵ� PK
    ODMID NVARCHAR2(10), --�ֹ����̵� FK
    ODGCODE NVARCHAR2(5),--�ֹ���ǰ FK
    ODQTY NUMBER,        --�ֹ�����
    ODDATE DATE          --�ֹ��Ͻ�
);
DROP TABLE ORDERS;
ALTER TABLE ORDERS
ADD CONSTRAINT PK_ODCODE PRIMARY KEY(ODCODE)
ADD CONSTRAINT FK_ODLIST_MID FOREIGN KEY(ODMID) REFERENCES MEMBERS(MID)
ADD CONSTRAINT FK_ODLIST_GCODE FOREIGN KEY(ODGCODE) REFERENCES GOODS(GCODE);

Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('KSTD','1234','�����','010-3437-2496',to_date('01/01/03 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('LCY','1234','������','010-8277-7279',to_date('01/03/29 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('RDH','1111','������','01000000000',to_date('00/08/11 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('LJH','1111','������','010-2248-8355',to_date('00/09/21 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('HWI','1111','Ȳ��ȣ','010-2737-8655',to_date('01/06/25 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('HJH','5786','�������','010-1234-5678',to_date('01/11/23 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('JGH','1234','����ȣ','010-4904-3741',to_date('01/11/09 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('SJS','1111','������','010-2502-3307',to_date('01/09/22 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('KMH','3123','Ȳ�Թ�','010-9947-2958',to_date('00/09/19 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('LSY0107','1234','�̽¿�','010-2819-3627',to_date('01/01/07 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('HGD','9551','ȫ�浿','010-1111-2222',to_date('00/06/03 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('$SWINGS$','12SWINGS12','������','010-3333-4444',to_date('87/07/06 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('JTM','1111','���¹�','010-2222-3333',to_date('01/12/03 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('PYJ','2141','�ڿ���','010-1234-8923',to_date('01/03/13 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('GDH','1234','�����','010-6263-9823',to_date('01/06/29 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('HHS','1213','Ȳ����','010-1111-1111',to_date('01/03/20 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('SHC','1111','����ö','010-3626-7443',to_date('01/02/11 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('KMJ','1111','�����','010-3903-6979',to_date('03/07/11 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('ISM','1234','�ӽ¹�','010-2467-5518',to_date('03/03/13 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('PJH','1111','����ȣ','010-4335-4586',to_date('01/12/01 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('LJW','1111','������','010',to_date('00/09/03 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('YKD','1111','����','010-4520-3675',to_date('86/05/03 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into MEMBERS (MID,MPW,MNAME,MPHONE,MBIRTH) values ('SJH','2222','������','010-7674-9779',to_date('05/02/22 00:00:00','RR/MM/DD HH24:MI:SS'));
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0115','�ٳ�������',1500,'��ǰ',300000);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G2322','��Ÿ',800000,'��Ÿ',5);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1357','�ñ״��� �ξ� �������, 230ml, 30��',20790,'��ǰ',30);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1235','ź���� �ǱԾ�',99999,'��Ÿ',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G2468','������ õ����� �������� �ҽ���, 990g, 2��',22040,'��ǰ',20);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G2223','���ױ�',20000,'�Ƿ�',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G2211','�ݶ�',1700,'��ǰ',100);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1112','�������ݶ�',1701,'��ǰ',100);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G8038','����ȣ�� ����� �䰭',10000000,'��Ÿ',2);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0111','�����',2000000,'����',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0011','Ȳ��ȣ�ǱԾ�',1000000,'��Ÿ',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0100','IPHONEPRO14',1400000,'����',22);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G9999','������� �ž��� �縻',30000000,'�Ƿ�',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G3000','�Ƹ޸�ī��',3000,'��ǰ',30);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G7777','Ȳ��ȣ�� �ô� ��',1004,'��ǰ',2);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0022','Ƽ��',1000000,'����',2);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G3479','HermanMiller AERON CD',2450000,'��Ÿ',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0110','�Ｚ ťĿ',359000,'����',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0002','PS5',688000,'��Ÿ',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0010','YAMAHA MODX8',2400000,'��Ÿ',5);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1110','YAMAHA MODX8',2400000,'��Ÿ',5);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0004','��¡��',4000,'��ǰ',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1818','�����ظ��콺, LOGITECH, 100��',987654321,'������ǰ',20);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G6464','��ټ�, 500ML, 200��',123456789,'��ǰ',2000);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0304','å��',6000,'��Ÿ',5);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0181','����',10,'��ǰ',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G2452','AMD Ryzen�� 5 7600X ',400000,'��Ÿ',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0003','�Ŷ��',1500,'��ǰ',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0044','���ٵ�����ġ',400000,'��Ÿ',20);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G4885','Ȳ��ȣ',10000,'��ǰ',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G2110','å',10000,'��Ÿ',10);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0031','����',20000,'��Ÿ',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1234','������',2000000,'����',100);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0211','����ö',10,'��Ÿ',1);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1000','�������帵ũ',1200,'��ǰ',100);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1100','�η縶������',2000,'��Ÿ',100);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0100','�߽���',150,'����',15);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0060','�߽��������̽¿�',50,'����',15);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G0009','�ڵ���',1000,'����',1000);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1004','1��',5,'��Ÿ',3);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G2422','����',2222,'��ǰ',2222);
Insert into GOODS (GCODE,GNAME,GPRICE,GTYPE,GSTOCK) values ('G1324','���ν�Ÿ��',100000000,'����',1);

SELECT * FROM MEMBERS;
SELECT * FROM GOODS
ORDER BY GCODE;

--���θ�
--1. ȸ�� ��� - ȸ������, �α��α��, ������ Ȯ��,
--              �� �ֹ� ����
--2. �ֹ���� - ��ü��ǰ���, ���������
--             ��ǰ�ֹ����

--[ȸ�����Ա��]
--CONSOLE(SCANNER) >> ������ ���̵� ~ ������� �Է�
INSERT INTO MEMBERS(MID, MPW, MNAME, MPHONE, MBIRTH)
VALUES('�Է��� ���̵�','�Է��Ѻ�й�ȣ','�Է����̸�','�Է�����ȭ��ȣ', TO_DATE('�Է��ѻ������','YYYY-MM-DD'));

--[�α��α��]
--CONSOLE(SCANNER) >> �α����Ҿ��̵�,�α����Һ�й�ȣ >> �Է� 
SELECT *
FROM MEMBERS
WHERE MID = '�α����Ҿ��̵�' AND MPW = '�α����Һ�й�ȣ';
--���ڵ尡 ��ȸ�Ǹ� >> �α��� ó��
--���ڵ尡 ��ȸ���� ������ >> ���̵�/��й�ȣ�� ��ġ���� �ʽ��ϴ�.

--[������Ȯ�α��] - �α��� �� ����
SELECT *
FROM MEMBERS
WHERE MID = 'PJH'; --NULL�϶� �α��� �ȵȰɷ� �Ǻ�.. �̷��� ���������� Ȯ�� �Ұ���.

--[���ֹ����]��� - �α��� �� ����
--��ǰ�̸�(GOODS - GNAME), �ֹ�����(ORDERS - ODQTY), �ֹ��ݾ�(GPRICE * ODQTY), �ֹ�����(ORDER - ORDDATE)
--���� - ODMID = '�α��� ���� ���̵�'

