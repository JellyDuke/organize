--��ȭ ���� ���̺�
CREATE TABLE MOVIES(
    MVCODE NCHAR(7),            -- ��ȭ �ڵ�(MV0001)
    MVTITLE NVARCHAR2(50),      -- ����
    MVDIRECTOR NVARCHAR2(30),   -- ����
    MVACTROS NVARCHAR2(200),    -- ���
    MVGERNE NVARCHAR2(200),     -- �帣
    MVINFO NVARCHAR2(200),      -- �⺻����
    MVOPEN DATE,                -- ������
    MVPOSTER NVARCHAR2(200),    -- ������URL
    MVSTATE NCHAR(1)            -- ����(1,0)
);