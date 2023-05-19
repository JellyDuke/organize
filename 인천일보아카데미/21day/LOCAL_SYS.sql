--계정 생성
--CREATE user 아이디 identified by 비밀번호;
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; -- 공통 사용자 규칙 해제
CREATE USER PJH_TEST IDENTIFIED BY "1111"; -- 전송(F9)
--권한 부여
--GRANT CREATE SESSION TO 아이디; <-접속권한.
GRANT CREATE SESSION TO PJH_TEST; 
--권한 회수
--REVOKE CREATE SESSION FROM 아이디; <-회수.
REVOKE CREATE SESSION FROM PJH_TEST;
--계정 삭제 
--DROP USER 아이디;
DROP USER PJH_TEST;

--CRUD
--CREATE - INSERT 
--READ - SELECT
--UPDATE - UPDATE
--DELETE - DELETE

--DBA 계정생성
CREATE USER PJH_DBA 
IDENTIFIED BY "1111";
--DBA 권한 부여 (dba의 모든 권한)
GRANT DBA TO PJH_DBA;

--테이블 생성
CREATE TABLE MEMBERS( --회원정보 테이블
    MID NVARCHAR2(5), --아이디 저장, 문자 최대 5글자까지
    MPW NVARCHAR2(5), --비밀번호
    MNAME NVARCHAR2(5)
);
DESC MEMBERS; --테이블 구조 확인
SELECT * FROM members;
INSERT INTO members VALUES('ID01','PW01','회원01');
INSERT INTO members VALUES('ID02','PW02','회원02');
INSERT INTO members VALUES('ID03','PW03','회원03');
SELECT * FROM members;

-- 테이블 생성 
-- CREATE TABLE 테이블이름(
-- 컬럼명1 데이터타입,
-- 컬럼명2 데이터타입,
-- 컬럼명n 데이터타입
-- );

--Table 테이블이름이(가) 생성되었습니다.

CREATE TABLE TESTTBL(
    COL01 CHAR(5),
    COL02 VARCHAR(10)
);
/* 데이터타입
문자형 - 고정형: CHAR(5) (N은 글자의 숫자를 붙이지 않으면 크기를 의미한다.) 5바이트 저장
        가변형: [NVARCHAR2(10 10글자를 저장)] 1바이트를 저장
숫자형 - [NUMBER(글자 자리수)] <- 아무것도 안쓰면 모든걸 저장,
        NUMBER(3), NUMBER(3 최대 3자리수 ,2 소수점 2자리수)
날짜형 - [DATE] // 연-월-일  시:분:초    ,순서
            YYYY-MM-DD HH24:MI:SS
*/


CREATE TABLE CHARTEST_TBL(
    CHARCOL1 CHAR(5), --5BYTE
    NCHARCOL2 NCHAR(5) --5글자
);
--INSERT문
--INSERT INTO 테이블명(컬럼명1,컬럼명2)
--VALUES(데이터1,데이터2);


INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('ABCDE','ABCDE');
SELECT *
FROM chartest_tbl;

INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('가나다라마','ABCDE'); --오류 열에 대한 값이 너무 큼(실제: 15, 최대값: 5) 한글은 3바이트씩 사용

INSERT INTO CHARTEST_TBL(CHARCOL1, NCHARCOL2)
VALUES('ABCDE','가나다라마');

CREATE TABLE NUMBERTEST_TBL(
    COL1 NUMBER,
    COL2 NUMBER(3),
    COL3 NUMBER(3,2)
);

INSERT INTO NUMBERTEST_TBL
VALUES(123, 123, 1.23);
SELECT * FROM NUMBERTEST_TBL;

INSERT INTO NUMBERTEST_TBL
VALUES(12345678, 123, 1.23); --성공

INSERT INTO NUMBERTEST_TBL
VALUES(123567, 12345, 1.23); --  이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.

INSERT INTO NUMBERTEST_TBL
VALUES(123567, 123, 1.23456789); -- 실행성공하지만 저장은 1.23까지 됨

INSERT INTO NUMBERTEST_TBL1111
VALUES(123567, 123, 12.3); -- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.

--날짜형 데이터
CREATE TABLE DATETEST_TBL(
    COL1 DATE
);
--시스템 DATE 입력
INSERT INTO DATETEST_TBL VALUES(SYSDATE);
SELECT *
FROM DATETEST_TBL;

INSERT INTO DATETEST_TBL VALUES('2023/05/19');
INSERT INTO DATETEST_TBL VALUES('2023-07-19');
SELECT * FROM DATETEST_TBL;
INSERT INTO DATETEST_TBL VALUES('2023/05/19 23:50:48');
INSERT INTO DATETEST_TBL VALUES('202305191159');
--TO_DATE('날짜로 변경할 문자','날짜확인방식'):문자형>> 날짜형으로 변환
INSERT INTO DATETEST_TBL
VALUES( TO_DATE('2023-07-19 23:50:48', 'YYYY-MM-DD HH24:MI:SS'));

--TO_CHAR('문자로 변경할 날짜', '변경할 범위');
SELECT TO_CHAR(COL1, 'YYYY/MM/DD')
FROM DATETEST_TBL;

--테이블변경
--ALTER TABLE 테이블이름
--[ADD,RENAME,MODIFY,DROP]

--새로운 컬럼 추가
--ALTER TABLE 테이블이름
--ADD 컬럼명 데이터타입
CREATE TABLE ALTER_TBL(
    COL1 NUMBER
);
--ALTER_TBL 테이블에 컬럼이름은 NAME, 데이터타입은 NVARCHAR2(5) 컬럼 추가
ALTER TABLE ALTER_TBL
ADD NAME NVARCHAR2(5);
--컬럼 이름 변경
--ALTER TABLE 테이블이름
--RENAME COLUMN 현재컬럼명 TO 바꿀컬럼명
--ALTER_TBL 테이블에 COL1 컬럼명을 AGE로 변경
ALTER TABLE ALTER_TBL
RENAME COLUMN COL1 TO AGE;
DESC ALTER_TBL; --테이블 구조확인
--컬럼의 데이터 타입 변경
--ALTER TABLE 테이블 이름
--MODIFY 컬럼명 데이터타입;
-- ALTER_TBL 테이블에 EMAIL NUMBER 컬럼을 추가
-- ALTER_TBL 테이블의 EMAIL 컬럼의 데이터타입을 문자형 최대 20글자까지
ALTER TABLE ALTER_TBL
ADD EMAIL NUMBER;

ALTER TABLE ALTER_TBL
ADD EMAIL NVARCHAR2(20);

--컬럼 삭제
--ALTER TABLE 테이블이름
--DROP COLUMN 컬럼명;

--ALTER_TBL 테이블의 AGE 컬럼을 삭제
ALTER TABLE ALTER_TBL
DROP COLUMN AGE;
DESC ALTER_TBL;

--제약조건
-- PRIMARY KEY
-- FOREIGN KEY
-- UNIQUE 
-- NOT NULL
-- CHECK
-- DEFAULT

-- UNIQUE : 테이블의 특정한 컬럼 부여 중복되는 값이 입력되지 않도록 방지
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20), --아이디
    MPW NVARCHAR2(20), --비밀번호
    MNAME NVARCHAR2(5),--이름
    MEMAIL NVARCHAR2(20)--이메일
);
--회원정보 입력
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','박주호','wnghqkr@naver.com'); --아래 195부터 실행 이후 입력성공
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','인천일보','wnghqkr@naver.com'); -- 195행 이후 실행 실패. 무결성 제약 조건(PJH_DBA.UK_MEM_MID)에 위배됩니다
select * from MEMBERS;

--테이블에 제약조건 부여
--ALTER TABLE 테이블이름
--ADD CONSTRANINT 식별이름 제약조건종류 (부여할컬럼명);

--MEMBERS 테이블의 MID 컬럼에 UNIQUE 제약조건 부여
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE (MID); --중복 데이터가 존재해서 오류 발생
DELETE FROM MEMBERS; --데이터 삭제 MEMBERS 테이블로부터 

ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE (MID);

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','박주호','wnghqkr@naver.com'); --아래 195부터 실행 이후 입력성공
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','인천일보','wnghqkr@naver.com'); -- 195행 이후 실행 실패. 무결성 제약 조건(PJH_DBA.UK_MEM_MID)에 위배됩니다.

--MEMBERS 테이블의 MEMAIL 컬럼에 UNIQUE 제약조건 부여
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE(MEMAIL);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES('PJH','1111','인천일보','wnghqkr@naver.com');