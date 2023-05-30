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
--ADD CONSTRAINT 식별이름 제약조건종류 (부여할컬럼명);

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

--=================================5.22==========================================
--제약조건
CREATE TABLE MEMBERS1(
    MID1 NVARCHAR2(20),  --아이디
    MPW1 NVARCHAR2(20),  --비밀번호
    MNAME1 NVARCHAR2(5), --이름
    MEMAIL1 NVARCHAR2(20)--이메일
);
--제약 조건 부여(MID 컬럼에 UNIQUE)
ALTER TABLE MEMBERS1
ADD CONSTRAINT UK_MEM1_MID UNIQUE(MID);

--제약조건 부여 - 테이블을 생성하면서 제약조건 부여 1
CREATE TABLE MEMBERS2(
    MID2 NVARCHAR2(20) CONSTRAINT UK_MEM2_MID UNIQUE,  --아이디
    MPW2 NVARCHAR2(20),  --비밀번호
    MNAME2 NVARCHAR2(5), --이름
    MEMAIL2 NVARCHAR2(20)--이메일
);
--제약조건 부여 - 테이블을 생성하면서 제약조건 부여 2
CREATE TABLE MEMBERS3(
    MID NVARCHAR2(20),  --아이디
    MPW NVARCHAR2(20),  --비밀번호
    MNAME NVARCHAR2(5), --이름
    MEMAIL NVARCHAR2(20),--이메일
    CONSTRAINT UK_MEM3_MID UNIQUE(MID)
);
-- UNIQUE : 테이블의 특정한 컬럼 부여 중복되는 값이 입력되지 않도록 방지
INSERT INTO MEMBERS3(MID, MPW, MNAME, MEMAIL)
VALUES('PJH', '1111', '박주호','WNGHQKR@NAVER'); --F9실행
INSERT INTO MEMBERS3(MID, MPW, MNAME, MEMAIL)
VALUES('PJH', '1234', '박주호','abc@NAVER'); --F9실행

--MID 컬럼에 NULL값 입력
INSERT INTO MEMBERS3(MID, MPW, MNAME, MEMAIL)
VALUES(NULL, '1234', '박주호','WNGH-QKR@NAVER'); --F9실행
INSERT INTO MEMBERS3(MPW, MNAME, MEMAIL)
VALUES('111-1', '박-주호','WNGH-QKR@NAVER'); --F9실행
SELECT * FROM MEMBERS3;

--NOT NULL: 지정된 컬럼에 NULL 값을 허용하지 않는다.
--따로 제약을 두지 않으면 기본값으로 NULL을 허용
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20) CONSTRAINT NN_MEM_MID NOT NULL,--그냥 NOT NULL 써도 됨
    MPW NVARCHAR2(20),  --비밀번호
    MNAME NVARCHAR2(5), --이름
    MEMAIL NVARCHAR2(20),--이메일
    CONSTRAINT UK_MEM_MID UNIQUE(MID)
);
INSERT INTO MEMBERS(MID ,MPW, MNAME, MEMAIL)
VALUES(NULL, '1234', '박주호','WNGHQKR@NAVER');
--ORA-01400: NULL을 ("SYS"."MEMBERS"."MID") 안에 삽입할 수 없습니다
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --아이디
    MPW NVARCHAR2(20),  --비밀번호
    MNAME NVARCHAR2(5), --이름
    MEMAIL NVARCHAR2(20),--이메일
    CONSTRAINT UK_MEM_MID UNIQUE(MID)
);
ALTER TABLE MEMBERS
MODIFY MID NOT NULL; --NOT NULL은 수정 MODIFY로 사용
DESC MEMBERS;

ALTER TABLE MEMBERS --제약조건을 지우기 UNIQUE
DROP CONSTRAINT UK_MEM_MID;

ALTER TABLE MEMBERS
MODIFY MID NULL; --NOT NULL 을 NULL로 수정하여 기본값으로 변경(수정)

--제약조건
--  UNIQUE: 테이블의 특정한 컬럼 부여, 중복되는 값이 입력되지 않도록 방지
--  NOT NULL: 특정 컬럼에 NULL값이 입력되지 않도록 방지
--  PRIMARY KEY: UNIQUE + NOT NULL
--               테이블에서 레코드를 구분 지을 수 있는 유일한 컬럼에 부여            

DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --아이디
    MPW NVARCHAR2(20),  --비밀번호
    MNAME NVARCHAR2(5), --이름
    MEMAIL NVARCHAR2(20)--이메일
);
-- MID 컬럼에 PRIMARY KEY 부여
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MID);
INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( 'PJH','1111','박주호','WNGHQKR@NAVER.COM');

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( 'PJH','1234','1234','1234'); --UNIQUE 확인

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( NULL,'1111','박주호','WNGHQKR@NAVER.COM'); --NOT NULL 확인

--이메일 컬럼에 UNIQUE 제약 조건 부여
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE(MEMALL);

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( '01','1111','박주호',NULL);

INSERT INTO MEMBERS(MID, MPW, MNAME, MEMAIL)
VALUES( '02','1111','박주호',NULL);

-- MNAME 에 PRIMERY KEY 부여
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MNAME); --기본키는 한테이블만 가능
ALTER TABLE MEMBERS
ADD CONSTRAINT UK_MEM_MID UNIQUE(MNAME);
SELECT * FROM MEMBERS;

-- DEFAULT: 특정한 컬럼에 값이 입력되지 않을 경우 기본으로 입력되는 값을 설정
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --아이디
    MPW NVARCHAR2(20),  --비밀번호
    MNAME NVARCHAR2(20) DEFAULT '이름없음',--이름
    MAGE NUMBER         --나이
);
-- 나이 컬럼에 기본값 1 설정
ALTER TABLE MEMBERS
MODIFY MAGE DEFAULT 1; --수정

INSERT INTO MEMBERS(MID,MPW,MAGE)
VALUES( '01','1234',10);
INSERT INTO MEMBERS(MID, MAGE)
VALUES( '01',10);
SELECT * FROM MEMBERS;
INSERT INTO MEMBERS(MID, MPW, MNAME, MAGE)
VALUES( '02','1111',DEFAULT,20);


--CHECK : 특정한 컬럼에 입력할 수 있는 값에 대한 조건 부여
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --아이디
    MPW NVARCHAR2(20),  --비밀번호
    MNAME NVARCHAR2(20),--이름
    MAGE NUMBER         --나이
    CONSTRAINT CK_MEM_MAGE CHECK(MAGE > 10)
);
INSERT INTO MEMBERS(MAGE)
VALUES(30); --1 행이 삽입되었습니다.
SELECT * FROM MEMBERS;
INSERT INTO MEMBERS(MAGE)
VALUES(5); -- 체크 제약조건(SYS.CK_MEM_MAGE)이 위배되었습니다

--제약조건
-- PRIMARY KEY
-- FOREIGN KEY
-- UNIQUE 
-- NOT NULL
-- CHECK
-- DEFAULT
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MID NVARCHAR2(20),  --아이디
    MPW NVARCHAR2(20)   --비밀번호
);
--MID 컬럼에 PRIMARY KEY 부여
ALTER TABLE MEMBERS
ADD CONSTRAINT PK_MEM_MID PRIMARY KEY(MID);
INSERT INTO MEMBERS(MID, MPW) --회원 정보 입력
VALUES('Y','1111');
INSERT INTO MEMBERS(MID, MPW) --회원 정보 입력
VALUES('ABC','1111');
SELECT * FROM MEMBERS;

DROP TABLE LOGINCHECK;
CREATE TABLE LOGINCHECK( --회원의 로그인 시간
    MID NVARCHAR2(20),   --회원 아이디 -MEMBERS 테이블의 MID
    LOGINTIME DATE       --로그인 시간
);

-- LOGINCHECK 테이블에 MID 컬럼에 FOREIGN KEY 지정
ALTER TABLE LOGINCHECK
ADD CONSTRAINT FK_LOG_MID FOREIGN KEY(MID)
REFERENCES MEMBERS(MID);


INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('PJH',SYSDATE); --무결성 제약조건(SYS.FK_LOG_MID)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('Y',SYSDATE);   --MEMBERS에 있는 아이디는 가능

INSERT INTO LOGINCHECK(MID, LOGINTIME)
VALUES('ABC',SYSDATE); --MEMBERS에 있는 아이디는 가능

SELECT * FROM LOGINCHECK;

--========================5.23============================
--FOREING KEY: 외래키
--상품정보 테이블 - GOODS
--상품이름 - GNAME 문자타입 20글자까지, PRIMARY KEY로 지정
--상품가격 - GPRICE 숫자타입
--상품브랜드 - GBRAND 문자타입 20글자까지 - NOT NULL

CREATE TABLE GOODS(
    GNAME NVARCHAR2(20) ,  --상품이름
    GPRICE NUMBER,  --상품가격
    GBRAND NVARCHAR2(20)  --상품브랜드
);
--제약 조건 부여
ALTER TABLE GOODS
ADD CONSTRAINT PK_GOODS_GNAME PRIMARY KEY(GNAME)
MODIFY GBRAND NOT NULL;
-- 상품 정보 입력

INSERT INTO GOODS(GNAME, GPRICE, GBRAND) 
VALUES('르네상스','5000000','시대');
INSERT INTO GOODS(GNAME, GPRICE, GBRAND) 
VALUES('혁명','5000000','농민');
INSERT INTO GOODS(GNAME, GPRICE, GBRAND) 
VALUES('아틀란티스','5000000','바다');


--주문내역의 테이블 - ORDERLIST
--상품이름, 가격, 구매자, 주문일시, 배송지, 주문수량
CREATE TABLE ORDERLIST(
    GNAME NVARCHAR2(20),    --상품이름
    GPRICE NUMBER,          --상품가격
    CUSTOMER NVARCHAR2(10), --고객
    ODDATE DATE ,           --주문일자
    ADDRESS NVARCHAR2(50),  --배송지
    QTY NUMBER              --주문수
);
--FOREIGN KEY (외래키) 지정
ALTER TABLE ORDERLIST
ADD CONSTRAINT FK_ODLIST_GNAME FOREIGN KEY(GNAME)
REFERENCES GOODS(GNAME);
--주문 정보 입력
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('르네상스','5000000','박주호',SYSDATE,'인천',1); --입력가능
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('혁명','5000000','박주호',SYSDATE,'인천',2);
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('아틀란티스','5000000','박주호',SYSDATE,'인천',3);
INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('르네상스','5000000','박주호',SYSDATE,'인천',4);
SELECT * FROM ORDERLIST;

INSERT INTO ORDERLIST(GNAME, GPRICE, CUSTOMER, ODDATE,ADDRESS,QTY)
VALUES('사이다','5000000','박주호',SYSDATE,'인천',1); --입력불가능
--무결성 제약조건(SYS.FK_ODLIST_GNAME)이 위배되었습니다- 부모 키가 없습니다

/*
CREATE - INSERT: 데이터 입력
READ   - SELECT: 데이터 조회
UPDATE - UPDATE: 데이터 수정
DELETE - DELETE: 데이터 삭제
*/

--INSERT문
--INSERT INTO 테이블이름(컬럼명1, 컬럼명2, .... 컬럼명N)
--VALUES(컬럼1에 저장할 값, 컬럼2에 저장할 값, .....);
DROP TABLE ORDERLIST;
DROP TABLE GOODS;
CREATE TABLE GOODS(
    GNAME NVARCHAR2(20) ,  --상품이름
    GPRICE NUMBER,  --상품가격
    GBRAND NVARCHAR2(20)  --상품브랜드
);
INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('상품명1',10000,'브랜드1');
INSERT INTO GOODS(GBRAND,GNAME)
VALUES('브랜드2','상품명2');
INSERT INTO GOODS(GBRAND)
VALUES('브랜드2');
--컬럼명을 명시하지 않을시 VALUES 항목은 테이블의 모든 컬럼 값
INSERT INTO GOODS
VALUES('브랜드2'); -- GNAME, GPRICE, GBRAND 맞춰서 해야함.
SELECT * 
FROM GOODS
WHERE GBRAND = '브랜드1';
--실행 순서
--데이트 조회 - SELECT  
--[5]SELECT 조회할컬러명1, 조회할컬럼명2....
--[1]FROM 테이블명
--[2]WHERE 조건
--[3]GROUP BY 그룹을 나눌 컬럼
--[4]HAVING 나눠진 그룹에 부여할 조건
--[6]ORDER BY 정렬기준컬럼

--데이터 수정 - UPDATE
--UPDATE 테이블명
--SET 컬럼명1 = 수정할 데이터, 컬럼명2 = 수정할데이터
--WHERE 데이터를 수정할 레코드를 선별할 조건
SELECT * FROM GOODS;
UPDATE GOODS
SET GPRICE = 115000, GBRAND = '브랜드명수점'
WHERE GNAME = '상품명1';

--데이터 삭제: DELETE
--DELETE FROM 테이블명
--WHERE 삭제할 레코드를 선별하는 조건

DELETE FROM GOODS
WHERE GNAME = '상품명1'; -- 1행이 삭제
DELETE FROM GOODS; --5행 전체 삭제

ROLLBACK;
SELECT * FROM GOODS;

DROP TABLE GOODS;
CREATE TABLE GOODS(
    GNAME NVARCHAR2(20) ,  --상품이름
    GPRICE NUMBER,  --상품가격
    GBRAND NVARCHAR2(20)  --상품브랜드
);
INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('상품명1',10000,'브랜드1');
INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('상품명2',15000,'브랜드1');

COMMIT; --> 커밋 데이터 저장 (세이브 파일)
ROLLBACK; --> 삭제된 데이터 롤백
SELECT * FROM GOODS; --> 확인 레코드 2개

DELETE FROM GOODS
WHERE GNAME = '상품명1'; -- 1행이 삭제
DELETE FROM GOODS; --5행 전체 삭제

INSERT INTO GOODS(GNAME,GPRICE,GBRAND)
VALUES('상품명3',15000,'브랜드1');
ROLLBACK;

CREATE TABLE TESTTBL01(COL01 NUMBER); --실행하면 자동저장. (테이블 만들면 자동 저장.)
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

/* SELECT문 
   SELECT 컬럼명1, 컬럼명2
   FROM 테이블명
   WHERE 조건
*/
SELECT *
FROM EMP; --EMP 테이블의 모든 컬럼
--직원번호 (EMPNO), 직원이름(ENAME) 조회
SELECT EMPNO, ENAME
FROM EMP;

--부서번호가 10번인 직원들의 모든 정보를 조회
SELECT *
FROM EMP
WHERE DEPTNO = 10;
-- 직무(JOB)가 SALESMAN인 직원들의 직원번호(EMPNO), 이름(ENAME), 급여(SAL)를 조회
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

--부서번호가 10번이 아닌 직원들의 모든 정보를 조회
SELECT *
FROM EMP
WHERE DEPTNO != 10;

-- 직무(JOB)가 SALESMAN이 아닌 직원들의 직원번호(EMPNO), 이름(ENAME), 급여(SAL)를 조회
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB != 'SALESMAN';

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE NOT JOB = 'SALESMAN';

--급여가(SAL)가 1500 이상, 2500이하인 직원들의 모든 정보를 조회
SELECT *
FROM EMP
WHERE SAL >= 1500 AND SAL <=2500;

SELECT *
FROM EMP
WHERE SAL BETWEEN 1500 AND 2500;

/*조건 문자형
  직무(JOB)가 SALESMAN인 직원들의 직원번호(EMPNO), 이름(ENAME), 급여(SAL)를 조회
*/
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN';

-- 와일드 문자 : LIKE 키워드와 함께 사용
-- 1. _ : 어떤 값이든 한글자를 대체 해주는 문자
-- 2. % : 길이에 상관 없이 대체해주는 문자

-- 직무(JOB)가 'SA   MAN'(SALESMAN 중간 3글자 모른다고 가정)인 직원들의 모든 정보 조회
SELECT *
FROM EMP
WHERE JOB LIKE 'SA___MAN';

SELECT *
FROM EMP
WHERE JOB LIKE 'SA%MAN';
--직원이름(ENAME)에 네번째 글자가 'K'인 직원들의 모든 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '___K%';
--직원이름이 4글자인 직원 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '____';

--조건 - NULL
--COMM을 받지 않는 직원들의 모든 정보를 조회
SELECT *
FROM EMP
WHERE COMM IS NULL ;

--COMM을 받는 직원들의 모든 정보를 조회
SELECT *
FROM EMP
WHERE COMM IS NOT NULL ;

--조건-날짜형
--입사일 (HIREDATE)이 1981년 9월 8일인 직원의 모든 정보를 조회

SELECT *
FROM EMP
WHERE HIREDATE ='1981-09-08 19:37';

UPDATE EMP
SET HIREDATE = '1981-09-08 19:37'
WHERE EMPNO = 7844;
--입사일(HIREDATE)이 1981년 9월 8일인 직원의 모든 정보를 조회
--TO_DATE: 문자를 날짜로
--TO_CHAR: 날짜를 문자로
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY-MM-DD') ='1981-09-08'; -- '1981-09-08'== '1981-09-08'
--입사일(HIREDATE) 1981년 9월 이후인 직원들의 모든 정보 조회
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY-MM') >= '1981-09';

SELECT *
FROM EMP
WHERE HIREDATE >= TO_DATE('1981-09','YYYY-MM');

SELECT *
FROM EMP
WHERE HIREDATE >= '1981-09';

--입사일(HIREDATE) 12월 직원들의 모든 정보 조회
SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = '12';

SELECT SYSDATE, SYSDATE -1, SYSDATE+1, SYSDATE-(1/24)/60 --날짜 1일/시간 24시간/분 60분
FROM DUAL;

/* 별칭(ALIAS)*/
-- 컬럼명 AS 별칭
SELECT EMPNO AS 직원번호, ENAME AS 직원이름, TO_CHAR(HIREDATE, 'YYYY-MM') AS HIREDATE
FROM EMP;
-- 컬럼명 AS "별칭"
SELECT EMPNO AS "직원번호", ENAME AS "직원이름", TO_CHAR(HIREDATE, 'YYYY-MM') AS "HIREDATE"
FROM EMP;
-- 컬럼명 별칭
SELECT EMPNO 직원번호, ENAME 직원이름, TO_CHAR(HIREDATE, 'YYYY-MM') HIREDATE
FROM EMP;
-- 컬럼명 "별칭"
SELECT EMPNO "직원번호", ENAME "직원이름", TO_CHAR(HIREDATE, 'YYYY-MM') "HIREDATE"
FROM EMP;

--문자 결합
SELECT ENAME, SAL||' 달러'
FROM EMP;
SELECT EMPNO||','||ENAME
FROM EMP;

SELECT TO_CHAR(HIREDATE, 'YYYY')||'년'||TO_CHAR(HIREDATE, 'MM')||'월'||TO_CHAR(HIREDATE, 'DD')||'일' AS 입사일
FROM EMP;

SELECT ENAME AS 직원이름, SAL AS 월급, SAL * 12 AS 연봉
FROM EMP;
--=======================5.25==============================

--WHERE - AND, OR
--입사 년도가 1981년 이고 부서번호가 30번인 직원들의 이름과, 직책을 조회

SELECT ENAME, JOB, HIREDATE, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981' AND DEPTNO = 30; --6명

--입사년도가 1981년 이거나 부서번호가 20번인 직원들의 이름과, 지책을 조회
SELECT ENAME, JOB, HIREDATE, DEPTNO
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981' OR DEPTNO = 20; -- 11명

--직책(JOB)이 'MANAGER' 이거나 'SALESMAN'인 직원들의 모든 정보를 조회
SELECT *
FROM EMP
WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN';
--직책(JOB)이 'MANAGER' 이거나 'SALESMAN'또는 'ANALYST'인 직원들의 모든 정보를 조회
SELECT *
FROM EMP
WHERE JOB IN('MANAGER','SALESMAN','ANALYST');

--직책(JOB)이 'MANAGER' 이거나 'SALESMAN'인 직원들 중에서 COMM을 받지 않는 직원의 정보를 조회
SELECT *
FROM EMP
WHERE (JOB = 'MANAGER' OR JOB = 'SALESMAN') AND COMM IS NULL;
--괄호 잘 써야됨

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
-- 대문자 변환: UPPER, 소문자 LOWER
SELECT *
FROM EMP
WHERE JOB = 'salesman'; --대소문자 구별

-- UPPER('문자데이터') >> 대문자로 변환
SELECT *
FROM EMP
WHERE JOB = UPPER('salesman');
-- LOWER('문자데이터') >> 소문자로 변환
SELECT *
FROM EMP
WHERE LOWER(JOB) = 'salesman';

--LENGTH('문자') >> 문자의 길이
SELECT ENAME, LENGTH(ENAME)
FROM EMP;

-- 그룹함수
-- SUM, COUNT, MAX, MIN, AVG

-- SUM(): 총합을 구하는 함수
-- 직원들의 SAL의 총합
SELECT SUM(SAL)
FROM EMP;

-- COUNT() 조회되는 레코드의 계수
SELECT COUNT(ENAME)
FROM EMP;

--MAX() 해당 컬럼의 최대값 구하는 함수
SELECT MAX(SAL)
FROM EMP;

--MIN() 해당 컬럼의 최소값 구하는 함수
SELECT MIN(SAL)
FROM EMP;
--AVG() 해당 컬럼의 평균값 구하는 함수
SELECT AVG(SAL)
FROM EMP;

--모든 직원의 이름과, 급여를 조회
SELECT ENAME, SAL
FROM EMP;

--부서번호 급여 조회
SELECT DEPTNO, SAL
FROM EMP;

--부서별 급여의 총합
SELECT JOB, SUM(SAL)
FROM EMP
GROUP BY JOB;

--부서별 인원수 조회
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;

-- 20번 부서의 인원수 조회
SELECT DEPTNO, COUNT(*)
FROM EMP
WHERE DEPTNO = 20
GROUP BY DEPTNO;

SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO = 20;

/*
SELECT 컬럼명
FROM 테이블명
WHERE 조건
GROUP BY 그룹을 나눌 컬럼
HAVING 그룹 조건 (GROUP BY와 같이 씀)
GROUP BY 정렬 기준
*/
--부서별 그룹을 구성하고, 인원이 4명 이상인 부서 조회
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 4;
-- 직책(JOB)별 평균 급여(SAL)가 3000이상인 직책과 평균 급여, 인원수 조회
SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
GROUP BY JOB, SAL
HAVING AVG(SAL) >= 3000;

-- 직책(JOB)별 평균 급여(SAL)가 3000이상인 [직책과] [평균 급여], [인원수 조회]
-- 단 부서가 10, 30인 직원을 대상으로
SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
WHERE DEPTNO IN(10,30)
GROUP BY JOB
HAVING AVG(SAL) >= 3000;

SELECT JOB, AVG(SAL), COUNT(*)
FROM EMP
GROUP BY JOB, DEPTNO
HAVING AVG(SAL) >= 3000 AND DEPTNO IN(10,30); --실행은 됨

--인원수가 5명 이상인 부서의 부서번호, 인원수, 평균연봉 조회
SELECT DEPTNO, AVG(SAL*12), COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 5;

--NVL(컬럼명, 대체할 값)
SELECT ENAME, JOB, (SAL + COMM), SAL, COMM, NVL(COMM, 0), (SAL + NVL(COMM,0))
FROM EMP;

--ORDER BY: 정렬기준 - 오름차순, 내림차순
SELECT *
FROM EMP
ORDER BY ENAME ASC; --직원이름 기준 오름 차순 정렬 (ASC 생략 가능)

SELECT *
FROM EMP
ORDER BY ENAME DESC, SAL; --직책 기준 내림차순 정렬 (DESC 필수 )

/*
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
*/

--이름이 WARD인 직원과 같은 부서에서 근무하는 직원들의 정보를 조회
--1. 이름이 WARD인 직원의 부서번호 조회 -- DEPTNO == 30
SELECT ENAME
FROM EMP
WHERE ENAME = 'WARD'; --30

--2. 조회된 부서번호를 바탕으로 해당 부서의 직원정보 조회 -- 아래 형태를 서브컬이라 함
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

-- 서브 쿼리 
-- WHERE 절 SELECT 문 사용
--WHERE절: 특정한 레코드를 선별하기 위한 조건

-- 부서번호가 10인 직원들의 정보를 조회
SELECT *
FROM EMP
WHERE DEPTNO = 10;
--직원 이름이 KING인 직원과 같은 부서에서 근무하는 직원들의 정보를 조회
--1. 이름이 KING인 직원의 부서번호 조회
SELECT DEPTNO
FROM EMP
WHERE ENAME = 'KING'; -- 10

--2. 10번 부서에서 근무하는 직원들의 정보를 조회
SELECT *
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'KING');

SELECT *
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO -- =이꼴로 하면 오류 되도록 IN을 사용
                FROM EMP
                WHERE JOB = 'MANAGER');

-- 평균 급여보다 많은 급여를 받는 직원들의 정보를 조회
--1. 평균 급여 조회
SELECT AVG(SAL)
FROM EMP; --2077.084
--2. 조회된 평균 급여와 직원의 급여를 비교 (급여 SAL가 2077보다 큰 직원들)
SELECT *
FROM EMP
WHERE SAL >= 2077;
SELECT *
FROM EMP
WHERE SAL >= (SELECT AVG(SAL)
             FROM EMP);
--JONES 보다 급여를 많이 받는 직원들의 정보를 조회
--1. JONES의 SAL 조회
SELECT *
FROM EMP
WHERE ENAME = 'JONES';
--2. 조회된 JONES의 SAL보다 많은 급여를 받는 직원의 정보를 조회
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES');
--SALESMAN 이 근무하지 않는 부서의 부서번호와 인원수를 조회

SELECT DEPTNO
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT DEPTNO, COUNT(*)
FROM EMP
WHERE DEPTNO NOT IN (SELECT DEPTNO
                    FROM EMP
                    WHERE JOB = 'SALESMAN')
GROUP BY DEPTNO;       

--JAMES와 같은 달에 입사한 직원의 이름과 직무 급여를 조회
--1.'JAMES' 가 입사한 달(MONTH) 조회 --'12'
SELECT TO_CHAR(HIREDATE,'MM')
FROM EMP
WHERE ENAME = 'JAMES';
--2. 12월에 입사한 직원의 이름 직무 급여
SELECT ENAME,JOB, SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = '12';

SELECT ENAME,JOB, SAL
FROM EMP
WHERE TO_CHAR(HIREDATE, 'MM') = (SELECT TO_CHAR(HIREDATE,'MM')
                                FROM EMP
                                WHERE ENAME = 'JAMES');

-- 부서별 평균 급여가 'MANAGER'의 평균 급여 보다 높은 부서의 번호와 평균급여를 조회 
--1. 평균급여
SELECT AVG(SAL)
FROM EMP
WHERE JOB = 'MANAGER';
--2. 부서별 평균 급여 조회
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>(SELECT AVG(SAL)
                 FROM EMP
                 WHERE JOB = 'MANAGER');

--JOIN: 두 개 이상의 테이블을 연결하여 하나의 테이블처럼 만들어 사용
--INNER JOIN, OUTER JOIN

SELECT *
FROM EMP, DEPT --48개의 레코드
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
FROM EMP; --12개의 레코드
SELECT *
FROM DEPT; --4개의 레코드

-- 'SMITH'가 근무하는 부서의 이름, 지역조회
SELECT D.DNAME, D.LOC
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME = 'SMITH';

SELECT DEPT.DNAME, DEPT.LOC
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME = 'SMITH';

SELECT DNAME, LOC
FROM DEPT
WHERE DEPTNO = ( SELECT DEPTNO FROM EMP WHERE ENAME = 'SMITH');

-- 'NEW YORK'에서 근무하는 직원의 부서이름, 직원이름, 직책조회
SELECT DEPT.DNAME, EMP.ENAME, EMP.JOB
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
        AND DEPT.LOC = 'NEW YORK';

SELECT D.DNAME, E.ENAME, E.JOB
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'NEW YORK';

-- 'SMITH' 직원의 상급자 (MCR)의 이름 조회
SELECT ENAME
FROM EMP
WHERE EMPNO = (SELECT MGR FROM EMP WHERE ENAME = 'SMITH');

SELECT E1.ENAME ||'의 MGR은' || E2.ENAME ||'입니다'
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

--부서이름 || 지역 || 직원수 
--RESEARCH  DALLAS   3
--SALES     CHICAGO  6

--부서별 직원수 조회
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO;    

SELECT *
FROM DEPT D, (SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO) COUNT_E
WHERE D.DEPTNO = COUNT_E.DEPTNO;

--=====================================5.30================================================

--부서별 평균 급여 조회, 부서이름, 평균급여
SELECT D.DNAME, AVG(E.SAL)
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO =  D.DEPTNO
GROUP BY D.DNAME;



--직원이름, 급여, 부서별 평균
--1. EMP, 부서별 평균 급여 조회
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;
--2. EMP, 1번 SELECT문 결과를 조인
SELECT E1.ENAME, E1.SAL, E2.DEPTAVG
FROM EMP E1 INNER JOIN (SELECT DEPTNO, AVG(SAL) AS DEPTAVG FROM EMP GROUP BY DEPTNO) E2
         ON E1.DEPTNO = E2.DEPTNO;

--3. DEPTNO 대신 DNAME(부서이름)으로 출력
SELECT E1.ENAME, E1.SAL, D.DNAME, E2.DEPTAVG
FROM EMP E1 INNER JOIN (
        SELECT DEPTNO, AVG(SAL) AS DEPTAVG  
        FROM EMP 
        GROUP BY DEPTNO) E2 ON E1.DEPTNO = E2.DEPTNO
        INNER JOIN DEPT D ON D.DEPTNO = E1.DEPTNO;
        
--직원이름(ENAME), 직무(JOB), 직무별 인원수 
--1. 직무별 인원수 조회
SELECT JOB, COUNT(*) AS JOBCOUNT
FROM EMP
GROUP BY JOB;
--2. EMP 테이블 1번의 결과를 조인
SELECT E.ENAME, E.JOB, E1.JOBCOUNT
FROM EMP E INNER JOIN (
        SELECT JOB, COUNT(*) AS JOBCOUNT  
        FROM EMP 
        GROUP BY JOB) E1 ON E1.JOB = E1.JOB;
-- ON 대신 WHERE E1.JOB = E.JOB; 써도 됨

-- ROWNUM 
SELECT ROWNUM, EMP.*
FROM EMP;

--1. 
SELECT ROWNUM, EMP.*
FROM EMP
ORDER BY SAL DESC;
--오름차순 순위가 깔끔하지 않아 아래에 2번 형식으로 해준다.
--2.
SELECT ROWNUM AS SALRANK, EMP.*
FROM (SELECT * FROM EMP ORDER BY SAL DESC) EMP;
--급여가 제일 많은 사람이 순위 재정의

--3. VIEW 가상테이블 3번처럼 복잡하지 않게 하기 위해 
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

--UPDATE 테이블명
--SET 컬럼명 = 수정할 값
--WHERE 데이터를 수정할 레코드 선별

--'JAMES'의 급여를 1000으로 수정
UPDATE EMP
SET SAL = 1000
WHERE ENAME = 'JAMES'; 

--'JAMES'의 급여를 100증가
UPDATE EMP
SET SAL = SAL + 100
WHERE ENAME = 'JAMES';

--MGR이 'BLAKE'인 직원들의 급여를 200 증가
UPDATE EMP
SET SAL = SAL +200
WHERE MGR = (SELECT EMPNO FROM EMP WHERE ENAME = 'BLAKE' );

--DELETE
/*
DELETE FROM 테이블명
WHERE 삭제할 레코드를 선별
*/
--딜리트는 컬럼 하나만 삭제 불가능 레코드를 아예 삭제 해버리니 주의
--급여를 가장 적게 받는 직원이 근무하는 부서의 직원들을 모두 삭제
--1.급여의 최소값 조회
SELECT MIN(SAL)
FROM EMP;
--2.급여가 최소값인 직원의 부서번호 조회
SELECT DEPTNO
FROM EMP
WHERE SAL = (SELECT MIN(SAL)
             FROM EMP);
--3. 해당 부서의 직원 정보를 삭제
DELETE
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE SAL = (SELECT MIN(SAL)
                                  FROM EMP));
--'ALLEN'의 부서번호를 50번으로 수정
UPDATE EMP
SET DEPTNO = 50
WHERE ENAME = 'ALLEN'; 
--안됨 무결성 제약 조건에 위배 - 부모키가 없습니다 외래키
SELECT * FROM DEPT;
DELETE FROM DEPT
WHERE DEPTNO = 30;
--ORA-02292: 무결성 제약조건(SYS.FK_DEPTNO)이 위배되었습니다- 자식 레코드가 발견되었습니다.
DELETE FROM DEPT
WHERE DEPTNO = 20;
--ORA-02292: 무결성 제약조건(SYS.FK_DEPTNO)이 위배되었습니다- 자식 레코드가 발견되었습니다
ROLLBACK;
select *
from emp;
select *
from dept;









