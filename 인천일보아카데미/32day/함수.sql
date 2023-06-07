--====================================06.07========================================
--ORACLE - ���� �Լ�
--TO_CHAR() - ��¥�� >> ������
--TO_DATE() - ������ >> ��¥��
--UPPER() - ��� �빮�ڷ� ����
--LOWER() - ��� �ҹ��ڷ� ����
SELECT UPPER('student'), LOWER('STudENT')
FROM DUAL;

SELECT * FROM EMP WHERE UPPER(ENAME) = 'allen';

SELECT * FROM EMP WHERE LOWER(ENAME) = 'allen';

--INITCAP(): ù���ڸ� �빮�ڷ�, �������� �ҹ��ڷ�
SELECT INITCAP('STUDENT'), INITCAP('student'), INITCAP('stUDent')
FROM DUAL;

--LENGTH() : ���ڿ��� ���̸� Ȯ��
SELECT LENGTH('STUDENT') FROM DUAL;

SELECT ENAME, LENGTH(ENAME)
FROM EMP;

SELECT MID, LENGTH(MID)
FROM EMP;

--LENGHTB(): ������ BYTE Ȯ��
SELECT LENGTH('STUDENT'), LENGTHB('STUDENT') FROM DUAL;
SELECT LENGTH('�л�'), LENGTHB('�л�'),LENGTHB('��'),LENGTHB('��') FROM DUAL;

--SUBSTR(������������, ������ġ): ���ڿ��� �Ϻθ� ����
SELECT SUBSTR('STUDENT',1), SUBSTR('STUDENT',3) FROM DUAL;

--SUBSTR(������������, ������ġ,���ڼ�): ���ڿ��� �Ϻθ� ����
SELECT SUBSTR('STUDENT',3), SUBSTR('STUDENT',3,4) FROM DUAL;

SELECT ENAME, SUBSTR(ENAME,2), SUBSTR(ENAME,2,2) FROM EMP;

--INSTR('������������','ã������',������ġ )
SELECT INSTR('STUDENT','T'), INSTR('STUDENT','T',3) FROM DUAL;

SELECT INSTR('STUDENT','DEN') FROM DUAL;
SELECT INSTR('STUDENT','Z') FROM DUAL;
SELECT INSTR('STUDENT','SUT') FROM DUAL;

--REPLACE('������������','�����','�����ҹ���') : Ư�� ���ڸ� �ٲٴ� �Լ� 
SELECT REPLACE('010-1111-2222','-','*') FROM DUAL;

SELECT ENAME, REPLACE(ENAME,'A','����') FROM EMP;
SELECT ENAME, REPLACE(ENAME,'A'), REPLACE(ENMAE,'A','') FROM EMP;

--LPAD('������������', ��ü���ڼ�, 'ä���ٹ���')
--RPAD()
SELECT LPAD('STU',10,'-'), RPAD('STU',10,'-') FROM DUAL;

SELECT LPAD('STUDENT',5,'-'), RPAD('STUDENT',5,'-') FROM DUAL;

-- '230605-3456789' ��ȸ ��� >> '203607-3******' ���
SELECT RPAD(SUBSTR ('230605-3456789',1,8), 14,'*')
FROM DUAL;
--'����' >> '��*��'
SELECT MNAME, REPLACE(MNAME,SUBSTR(MNAME,2,1),'*')
FROM MEMBERS;
SELECT MNAME
FROM MEMBERS;