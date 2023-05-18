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
-- �������� 

--CRUD
--CREATE - INSERT 
--READ - SELECT
--UPDATE - UPDATE
--DELETE - DELETE