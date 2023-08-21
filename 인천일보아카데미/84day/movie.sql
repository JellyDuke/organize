--영화 정보 테이블
CREATE TABLE MOVIES(
    MVCODE NCHAR(7),            -- 영화 코드(MV0001)
    MVTITLE NVARCHAR2(50),      -- 제목
    MVDIRECTOR NVARCHAR2(30),   -- 감독
    MVACTROS NVARCHAR2(200),    -- 배우
    MVGERNE NVARCHAR2(200),     -- 장르
    MVINFO NVARCHAR2(200),      -- 기본정보
    MVOPEN DATE,                -- 개봉일
    MVPOSTER NVARCHAR2(200),    -- 포스터URL
    MVSTATE NCHAR(1)            -- 상태(1,0)
);