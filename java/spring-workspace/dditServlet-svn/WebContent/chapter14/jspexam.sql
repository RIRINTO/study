CREATE TABLE MEMBER(
   MEMBERID VARCHAR2(20)
 , PASSWORD VARCHAR2(100)
 , NAME VARCHAR2(90)
 , EMAIL VARCHAR2(60)
 , CONSTRAINT PK_MEMBER PRIMARY KEY(MEMBERID)
);

INSERT INTO MEMBER(MEMBERID, PASSWORD, NAME, EMAIL)
VALUES('a001','1234','������','ked@ddit.or.kr');

INSERT INTO MEMBER(MEMBERID, PASSWORD, NAME, EMAIL)
VALUES('b001','1234','�̻ڴ�','lpn@ddit.or.kr');

COMMIT;

CREATE TABLE MEMBER_ETC(
    MEMBERID VARCHAR2(20)
   ,BIRTHDAY VARCHAR2(30)
   ,CONSTRAINT PK_MEMBER_ETC PRIMARY KEY(MEMBERID)
   ,CONSTRAINT FR_MEMBER_MEMBER_ETC FOREIGN KEY(MEMBERID) REFERENCES MEMBER(MEMBERID)
);