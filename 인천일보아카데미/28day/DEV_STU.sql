SELECT * FROM USER_TABLES;
SELECT * FROM MEMBERS;
SELECT * FROM GOODS;

INSERT INTO GOODS(GCODE, GNAME, GPRICE, GTYPE, GSTOCK)
VALUES('G1004','1억',5,'기타',3);

INSERT INTO GOODS(GCODE, GNAME, GPRICE, GTYPE, GSTOCK)
VALUES('G1234','아인슈타인',100000000,'과학',1);

INSERT INTO MEMBERS(MID, MPW, MNAME, MPHONE, MBIRTH)
VALUES ('PJH', '1111', '박주호','010-4335-4586','2001/12/01');

COMMIT;
UPDATE GOODS
SET GNAME = '1억'
WHERE GCODE = 'G1004';