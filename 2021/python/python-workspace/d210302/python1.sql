CREATE TABLE SUSER(
    USER_ID VARCHAR2(20),
    PWD VARCHAR2(20),
    USER_NAME VARCHAR2(20),
    MOBILE VARCHAR(11),
    EMAIL VARCHAR(50),
    BIRTH VARCHAR(8),
    IN_DATE VARCHAR(15),
    IN_USER_ID VARCHAR2(20),
    UP_DATE VARCHAR(15),
    UP_USER_ID VARCHAR2(20),
    
    CONSTRAINT PK_USER PRIMARY KEY(USER_ID)
);

CREATE TABLE SURVEY(
    S_ID NUMBER,
    TITLE VARCHAR2(50),
    CONTENT VARCHAR2(1000),
    INTERVIEW_CNT NUMBER,
    DEADLINE VARCHAR(8),
    IN_DATE VARCHAR(15),
    IN_USER_ID VARCHAR2(20),
    UP_DATE VARCHAR(15),
    UP_USER_ID VARCHAR2(20),
    
    CONSTRAINT PK_SURVEY PRIMARY KEY(S_ID)
);

SELECT S_ID,
        TITLE,
        CONTENT,
        INTERVIEW_CNT,
        DEADLINE,
        IN_DATE,
        IN_USER_ID,
        UP_DATE,
        UP_USER_ID
    FROM SURVEY
    ORDER BY S_ID;


SELECT S_ID,
        TITLE,
        CONTENT,
        INTERVIEW_CNT,
        DEADLINE,
        IN_DATE,
        IN_USER_ID,
        UP_DATE,
        UP_USER_ID
        FROM SURVEY
        ORDER BY S_ID;
        
INSERT INTO SUSER(user_id, pwd, user_name, mobile, email, birth, in_date, in_user_id, up_date, up_user_id)
    VALUES(1,1,1,1,1,1,1,1,1,1);