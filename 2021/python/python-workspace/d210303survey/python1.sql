CREATE TABLE DETAIL(
	SURVEY_ID NUMBER,
	S_SEQ NUMBER,
	Q1 VARCHAR2(1000),
	A1 VARCHAR2(20),
	A2 VARCHAR2(20),
	A3 VARCHAR2(20),
	A4 VARCHAR2(20),
	IN_DATE VARCHAR(15),
	IN_USER_ID VARCHAR2(20),
	UP_DATE VARCHAR(15),
	UP_USER_ID VARCHAR2(20),
    
	CONSTRAINT PK_DETAIL PRIMARY KEY(SURVEY_ID, S_SEQ)
);