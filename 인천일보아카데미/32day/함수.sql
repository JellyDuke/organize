--====================================06.07========================================
--ORACLE - 문자 함수
--TO_CHAR() - 날짜형 >> 문자형
--TO_DATE() - 문자형 >> 날짜형
--UPPER() - 모두 대문자로 변경
--LOWER() - 모두 소문자로 변경
SELECT UPPER('student'), LOWER('STudENT')
FROM DUAL;

SELECT * FROM EMP WHERE UPPER(ENAME) = 'allen';

SELECT * FROM EMP WHERE LOWER(ENAME) = 'allen';

--INITCAP(): 첫글자를 대문자로, 나머지는 소문자로
SELECT INITCAP('STUDENT'), INITCAP('student'), INITCAP('stUDent')
FROM DUAL;

--LENGTH() : 문자열의 길이를 확인
SELECT LENGTH('STUDENT') FROM DUAL;

SELECT ENAME, LENGTH(ENAME)
FROM EMP;

SELECT MID, LENGTH(MID)
FROM EMP;

--LENGHTB(): 문자의 BYTE 확인
SELECT LENGTH('STUDENT'), LENGTHB('STUDENT') FROM DUAL;
SELECT LENGTH('학생'), LENGTHB('학생'),LENGTHB('학'),LENGTHB('ㅎ') FROM DUAL;

--SUBSTR(문자형데이터, 시작위치): 문자열의 일부를 추출
SELECT SUBSTR('STUDENT',1), SUBSTR('STUDENT',3) FROM DUAL;

--SUBSTR(문자형데이터, 시작위치,글자수): 문자열의 일부를 추출
SELECT SUBSTR('STUDENT',3), SUBSTR('STUDENT',3,4) FROM DUAL;

SELECT ENAME, SUBSTR(ENAME,2), SUBSTR(ENAME,2,2) FROM EMP;

--INSTR('문자형데이터','찾을문자',시작위치 )
SELECT INSTR('STUDENT','T'), INSTR('STUDENT','T',3) FROM DUAL;

SELECT INSTR('STUDENT','DEN') FROM DUAL;
SELECT INSTR('STUDENT','Z') FROM DUAL;
SELECT INSTR('STUDENT','SUT') FROM DUAL;

--REPLACE('문자형데이터','대상문자','변경할문자') : 특정 문자를 바꾸는 함수 
SELECT REPLACE('010-1111-2222','-','*') FROM DUAL;

SELECT ENAME, REPLACE(ENAME,'A','에이') FROM EMP;
SELECT ENAME, REPLACE(ENAME,'A'), REPLACE(ENMAE,'A','') FROM EMP;

--LPAD('문자형데이터', 전체글자수, '채워줄문자')
--RPAD()
SELECT LPAD('STU',10,'-'), RPAD('STU',10,'-') FROM DUAL;

SELECT LPAD('STUDENT',5,'-'), RPAD('STUDENT',5,'-') FROM DUAL;

-- '230605-3456789' 조회 결과 >> '203607-3******' 출력
SELECT RPAD(SUBSTR ('230605-3456789',1,8), 14,'*')
FROM DUAL;
--'양기두' >> '양*두'
SELECT MNAME, REPLACE(MNAME,SUBSTR(MNAME,2,1),'*')
FROM MEMBERS;
SELECT MNAME
FROM MEMBERS;