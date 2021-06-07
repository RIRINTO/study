2021-02-10-02) ������ Ÿ��
	- ������, ������, ��¥, ��Ÿ�� ����

1. ��¥��
	- �������� ���� ( CHAR )
	- �������� ���� ( VARCHAR, VARCHAR2, LONG, CLOB, NVARCHAR2, NCLOB )

	1) CHAR
		. �������� ���ڿ��� ����
		. �������� ������ �����ʿ� ������ ���ԵǾ� ����
		. �����Ͱ� ũ�� ����
		. �ַ� �⺻Ű�� ������ Ÿ������ ���
		. �ѱ� �� ���ڴ� 3BYTE
		. �ִ� 2000BYTE���� ���� ����

		��� ����
			�÷��� CHAR ( ũ��[BYTE|CHAR] );

		- ũ�� : 1 ~ 2000
		- BYTE|CHAR
			'ũ��'�� ������ ���� BYTE ������, CHAR �������� ����
			'CHAR'�� �����Ǵ��� 2000BYTE�� �ʰ��� �� ����
			DEFAULT ���� BYTE

		��)
			CREATE TABLE TEMP01 (
				COL1 CHAR(20 BYTE),
				COL2 CHAR(20 CHAR),
				COL3 CHAR(20)
			);

			INSERT INTO TEMP01(COL1, COL2, COL3)
				VALUES ('����ȭ ����', '����ȭ ����', 'ABCDEFGHIJKLMN');

			INSERT INTO TEMP01(COL1, COL2, COL3)
				VALUES ('����ȭ ����', '����ȭ ���� �Ǿ����ϴ�. ����ȭ ���� ��', 'ABCDEFGHIJKLMN');

			SELECT LENGTHB(COL1),
					LENGTHB(COL2),
					LENGTHB(COL3)
				FROM TEMP01;

			SELECT *
				FROM TEMP01;


	2) VARCHAR2
		. �������� ���ڿ��� ����
		. 1 ~ 4000 BYTE ó�� ����
		. ORACLE������ ��� ������ ������ Ÿ�� ( �ٸ� DBMS������ VARCHAR�� ��� )

		��� ����
			�÷��� VARCHAR2(ũ��[BYTE|CHAR])

		- ũ�� : 1 ~ 4000
		- BYTE|CHAR
			'ũ��'�� ������ ���� BYTE������ CHAR �������� ����
			'CHAR'�� �����Ǵ��� 4000BYTE�� �ʰ��� �� ������,
			DEFAULT ���� BYTE�̴�.

		��� ��)
			CREATE TABLE TEMP02 (
				COL1 VARCHAR2(50),
				COL2 VARCHAR2(50 CHAR),
				COL3 VARCHAR2(50 BYTE)
			);

			INSERT INTO TEMP02(COL1, COL2, COL3)
				VALUES ('����ȭ ����', '����ȭ ����', 'ABCDEFGHIJKLMN');

			INSERT INTO TEMP02(COL1, COL2, COL3)
				VALUES ('����ȭ ����', '����ȭ ���� �Ǿ����ϴ�. ����ȭ ���� ��', 'ABCDEFGHIJKLMN');

			SELECT LENGTHB(COL1),
					LENGTHB(COL2),
					LENGTHB(COL3)
				FROM TEMP02;

			SELECT *
				FROM TEMP02;

	3) NVARCHAR2, VARCHAR
		. VARCHAR�� VARCHAR2�� ���� ��� ����
		. ORACLE �翡���� VARCHAR2 ����� �ǰ�
		. NVARCHAR2�� ����ǥ���ڵ�(�ٱ��� ���)�� ����Ͽ� ���ڿ� ����
		. UTF-8(��������), UTF-16(��������) �������� ó��

	4) LONG
		. ��뷮 �������� �ڷḦ ����
		. 2GB���� ó�� ����
		. ������� : �� ���̺� �� �÷��� LONG Ÿ������ ���� ����
		. CLOB Ÿ������ ��ü ( ���� ��� ������ ���� �� )

		��� ����
			�÷��� LONG;

		��� ��)
			CREATE TABLE TEMP03 (
				COL1 LONG,
				COL2 CLOB,
				COL3 VARCHAR2(3000)
			);

			INSERT INTO TEMP03(COL1, COL2, COL3)
				VALUES ('����ȭ ����', '����ȭ ����', 'ABCDEFGHIJKLMN');

			INSERT INTO TEMP03(COL1, COL2, COL3)
				VALUES ('����ȭ ����', '����ȭ ���� �Ǿ����ϴ�. ����ȭ ���� ��', 'ABCDEFGHIJKLMN');

			SELECT LENGTHB(COL1),
					LENGTHB(COL2),
					LENGTHB(COL3)
				FROM TEMP03;

			SELECT *
				FROM TEMP03;

			SELECT DBMS_LOB.GETLENGTH(COL2),
					LENGTHB(COL3)
				FROM TEMP03;


	5) CLOB
		. LOB ( Large Objects ) Ÿ��
		. ��뷮 �ڷ� ( 4GB ) �� �����ϱ� ���� �������� ������ Ÿ��
		. ���� Į������ ���ÿ� ��� ���� ( LONG Ÿ�� ���� )
		. �Ϻ� ����� DBMS_LOB API ������ �޾ƾ� �� ( LENGTH, SUBSTR �� )

		��� ����
			�÷��� CLOB;

		CREATE TABLE TEMP04 (
			COL1 CLOB,
			COL2 CLOB,
			COL3 VARCHAR2(1000)
		);

		INSERT INTO TEMP04(COL1, COL2, COL3)
			VALUES ('����ȭ ����', '����ȭ ����', 'ABCDEFGHIJKLMN');

		INSERT INTO TEMP04(COL1, COL2, COL3)
			VALUES ('����ȭ ����', '����ȭ ���� �Ǿ����ϴ�. ����ȭ ���� ��', 'ABCDEFGHIJKLMN');

		SELECT DBMS_LOB.GETLENGTH(COL1),
				DBMS_LOB.GETLENGTH(COL2),
				LENGTHB(COL3)
			FROM TEMP04;

		SELECT *
			FROM TEMP04;

		SELECT SUBSTR(COL3, 2, 5)
			FROM TEMP04;

		SELECT DBMS_LOB.SUBSTR(COL2, 2, 5)
			FROM TEMP04;

		SELECT LENGTH(COL2),
				LENGTH(COL3)
			FROM TEMP04;

		SELECT DBMS_LOB.GETLENGTH(COL2) AS "������ ����"
			FROM TEMP04;

		SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" AM HH:MI:SS') AS "SYSDATE"
			FROM DUAL;