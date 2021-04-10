2021-02-15-02)
4. ��Ÿ �ڷ���
	- 2�� �ڷḦ �����ϱ� ���� �ڷ���
	- RAW, LONG RAW, BLOB, BFILE
	1) RAW
		. ��������� ���� 2�� �ڷ� ����
		. �ε��� ó�� ����
		. �ִ� 2000 BYTE ó�� ����
		. ����Ŭ���� �ؼ��̳� ��ȯ�۾��� ������� ����
		. 16������ 2������ ����

		��� ����
			�÷��� RAW(ũ��);

	2) BFILE
		. 2�� �ڷ� ����
		. ����� �Ǵ� 2�� �ڷ�� �����ͺ��̽� �ܺο� ����
		. ��� ���� ( DIRECTORY ��ü ) �� ���ϸ� ���̺� ����
		. 4GB���� ���� ����

		��� ����
			�÷��� BFILE;

		** �׸� ���� ���� ����
			(1)
				�׸� ������ ����� ��ο� ���� Ȯ��
			(2)
				���丮 ��ü ����
					CREATE OR REPLACE DIRECTORY ���丮�� AS �����ּ�
			(3)
				���̺� ����
			(4)
				�׸����� ����

		��� ��)
			(1)
				�׸� ������ ����� ��ο� ���� Ȯ��
				�׸� ���
					'D:\A_TeachingMaterial\2.Oracle\workspace\210215'
				���� ��
					'SAMPLE01.png'
			(2)
				���丮 ��ü ����
					CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle\workspace\210215';
			(3)
				���̺� ����
					CREATE TABLE TEMP07 (
						COL1 BFILE
					);
			(4)
				�׸� ����
					INSERT INTO TEMP07
						VALUES (BFILENAME('TEST_DIR', 'SAMPLE01.png'));

					SELECT *
						FROM TEMP07;

	3) BLOB
		. 2�� �ڷḦ �����ͺ��̽� ���ο� ����
		. 4GB���� ���� ����
		. �ؼ� �� ��ȯ���� ����

		��� ����
			�÷��� BLOB;

		** �׸� ���� ���� ����
			(1)
				�׸� ������ ����� ��ο� ���� Ȯ��
			(2)
				���丮 ��ü ����
					CREATE OR REPLACE DIRECTORY ���丮�� AS �����ּ�
			(3)
				���̺� ����
					CREATE TABLE TEMP08 (
						COL1 BLOB
					);

			(4)
				�׸����� ���� - PROCEDURE �̿�
					CREATE OR REPLACE PROCEDURE PROC_IMG_INSERT (P_DIR IN VARCHAR2, P_FILENAME VARCHAR2)
					IS
						V_DEPT BLOB;
						V_SOURCE BFILE;
						V_LENGTH NUMBER:=0;
					BEGIN
						V_SOURCE:=BFILENAME(P_DIR, P_FILENAME);                
						DBMS_LOB.FILEOPEN(V_SOURCE, DBMS_LOB.FILE_READONLY);
						V_LENGTH:= DBMS_LOB.GETLENGTH(V_SOURCE);
						DBMS_LOB.LOADFROMFILE(V_DEPT, V_SOURCE, V_LENGTH);
						DBMS_LOB.FILECLOSE(V_SOURCE);
						INSERT INTO TEMP08 VALUES (V_DEPT);
						COMMIT;
					END;

			*** �׸� ���� ���� BLOCK ����
				DECLARE
				BEGIN
					PROC_IMG_INSERT('TEST_DIR', 'SAMPLE01.png');
					PROC_IMG_INSERT('TEST_DIR', 'SAMPLE02.png');
					PROC_IMG_INSERT('TEST_DIR', 'SAMPLE03.png');
				END;

				SELECT *
					FROM TEMP08;