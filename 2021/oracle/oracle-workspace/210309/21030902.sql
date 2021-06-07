2021-03-09-02)
SEQUENCE ��ü
	- ���������� �����ϴ� ������ �߻�
	- �ٸ� DBMS ( MYSQL, SQL_SERVER �� ) ������ AUTO INCREMENT�� ����
	- ���̺� ���������� ���
	- �⺻Ű�� �����ϱ⿡ ������ �÷��� ���� ���
		������ ������ �ʿ��� ��� ( �Խ����� �۹�ȣ �� ) �� �ַ� ���

	��� ����
		CREATE SEQUENCE ��������
			[START WITH n]
			[INCREMENT BY n]
			[MAXVALUE n | NOMAXVALUE]
			[MINVALUE n | NOMINVALUE]
			[CYCLE | NOCYCLE]
			[CACHE | NOCACHE]
			[ORDER | NOORDER]

	. START WITH n
		���۰�
	. INCREMENT BY n
		������
	. MAXVALUE n
		�ִ밪 ( default�� 10^27 ), 'NOMAXVALUE'�� �⺻
	. MINVALUE n
		�ּҰ� ( default�� 1 ), 'NOMINVALUE'�� �⺻
	. CYCLE
		�ִ� �Ǵ� �ּҰ� ���� �� �ٽ� ���� ( DEFAULT�� 'NOCYCLE' )
	. CACHE
		�޸𸮿� �̸� �����Ͽ� �Ҵ��� �� ���� ( DEFAULT�� CACHE 20 )
	. ORDER
		��û�� ������� ������ ���� ( DEFAULT�� NOORDER )

	* �������� ���
	--------------------------------------------------
	�ǻ� �÷� ( Pseudo Column )	�ǹ�
	--------------------------------------------------
	��������.NEXTVAL				������ ��ü�� ���� �� ��ȯ
	��������.CURRVAL				������ ��ü�� ���� �� ��ȯ
	--------------------------------------------------
	
	** �������� ������ �� ù ��° ����� �ش� ���ǿ��� ��������.NEXTVAL�� ���ʷ� ����� �Ŀ��� ������ �� ����

	��� ��)
		��ǰ�з����̺�(LPROD)�� ���� �ڷḦ �߰��Ͻÿ�
		��, ����(LPROD_ID)�� SEQUENCE�� �����Ͽ� ����Ͻÿ�
			--------------------
			�з��ڵ�		�з���
			--------------------
			'p501'		'�ӻ깰'
			'p502'		'���깰'
			'p503'		'��깰'
			--------------------
        
	SELECT MAX(LPROD_ID) FROM LPROD;
	
	������ ����
	CREATE SEQUENCE SEQ_LPROD
		START WITH 10;

	INSERT INTO LPROD
		VALUES(SEQ_LPROD.NEXTVAL, 'P501', '�ӻ깰');
	
	INSERT INTO LPROD
		VALUES(SEQ_LPROD.NEXTVAL, 'P502', '�ӻ깰');

	INSERT INTO LPROD
		VALUES(SEQ_LPROD.NEXTVAL, 'p503', '��깰');

	SELECT *
		FROM LPROD;

	SELECT SEQ_LPROD.CURRVAL
		FROM DUAL;