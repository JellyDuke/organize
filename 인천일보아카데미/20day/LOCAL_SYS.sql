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
-- 제약조건 

--CRUD
--CREATE - INSERT 
--READ - SELECT
--UPDATE - UPDATE
--DELETE - DELETE