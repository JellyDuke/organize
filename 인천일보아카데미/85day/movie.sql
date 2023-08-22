--��ȭ ���� ���̺�
CREATE TABLE MOVIES(
    MVCODE NCHAR(7),            -- ��ȭ �ڵ�(MV0001)
    MVTITLE NVARCHAR2(50),      -- ����
    MVDIRECTOR NVARCHAR2(30),   -- ����
    MVACTORS NVARCHAR2(200),    -- ���
    MVGERNE NVARCHAR2(200),     -- �帣
    MVINFO NVARCHAR2(200),      -- �⺻����
    MVOPEN DATE,                -- ������
    MVPOSTER NVARCHAR2(200),    -- ������URL
    MVSTATE NCHAR(1)            -- ����(1,0)
);

ALTER TABLE MOVIES
ADD CONSTRAINT PK_MOVIES PRIMARY KEY(MVCODE);

ALTER TABLE MOVIES
MODIFY MVTITLE NOT NULL;

SELECT * FROM MOVIES;
DESC MOVIES;

drop table MOVIES;