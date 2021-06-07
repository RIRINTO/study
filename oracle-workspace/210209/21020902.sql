2021-02-09-02) DML (Data Manipulation Language)
	- ������ ���۾�
	- INSERT, UPDATE, DELETE ��ɾ� ����

1. INSERT ���
	. �����͸� ���̺� �ű� ����� �� ����ϴ� ���

	��� ����
		INSERT INTO ���̺��[(�÷���1, �÷���2, ...)]
			VALUES(��1, ��2, ...);

	. (�÷���1, �÷���2, ...)�� �����ϴ� ���
		�� ���̺� ���� �� ������� ��� �÷���
			������ ������ �µ��� VALUES ���� ���� ( ) �ȿ� ���� �Ǿ�� ��.
	. (�÷���1, �÷���2, ...)�� ����ϴ� ���
		�� ������ �Է��� ���ʿ��� �÷��� ����
			��, �÷� ��������� NOT NULL�� ���, ������ �� ����.
	. ��� �� '�÷���'�� ���� '��'�� ������ ������ �ݵ�� ��ġ�ؾ� ��.

	��� ��)
		���� �ڷḦ ȸ�� ���̺�(tb_mem)�� �����Ͻÿ�.
			[�ڷ�]
				ȸ����ȣ	�̸�			�ּ�					��ȭ��ȣ
			------------------------------------------------------------
				M1001	ȫ�浿		���������� �߱� ���ﵿ		042-222-8202
				M1002	�̱漱		����� ���ϱ� ��������		02-7654-0987
				M1003	õ���		��� ��õ�� �ſ���
				M1004	������
            ------------------------------------------------------------

			INSERT INTO tb_mem
				VALUES ('M1001', 'ȫ�浿', '���������� �߱� ���ﵿ', '042-222-8202');

			INSERT INTO tb_mem (MEM_ID, MEM_NAME, MEM_ADDR, MEM_TEL_NO)
				VALUES ('M1002', '�̱漱', '����� ���ϱ� ��������', '02-7654-0987');

			INSERT INTO tb_mem
				VALUES ('M1003', 'õ���', '��� ��õ�� �ſ���', '');

			INSERT INTO tb_mem (MEM_ID, MEM_NAME, MEM_ADDR)
				VALUES ('M1004', '������', NULL);

			SELECT *
				FROM tb_mem;

		����] ���� �ڷḦ ��ǰ ���̺�(tb_goods)�� �Է��Ͻÿ�.
				��ǰ�ڵ�		��ǰ��			����
			------------------------------------------------------------
				G11001		���콺			15,000
				G12002		USB ( 64G )	25,000
				G20001		��Ŀ��
				G21001		����
			------------------------------------------------------------

			INSERT INTO TB_GOODS (GOOD_ID, GOOD_NAME, GOOD_PRICE)
				VALUES ('G11001', '���콺', 15000);

			INSERT INTO TB_GOODS (GOOD_ID, GOOD_NAME, GOOD_PRICE)
				VALUES ('G12002', 'USB(64G)', 25000);

			INSERT INTO TB_GOODS (GOOD_ID, GOOD_NAME)
				VALUES ('G20001', '��Ŀ��');

			INSERT INTO TB_GOODS (GOOD_ID, GOOD_NAME)
				VALUES ('G21001', '����');

			SELECT *
				FROM TB_GOODS;

		����] ������ �ڷḦ �ֹ� ���̺�(ORDERS)�� �Է��Ͻÿ�.
			------------------------------------------------------------
				�ֹ���ȣ : 1
				�ֹ����� : ����
				�ֹ��ݾ� : ?
				���� : ?
				�ֹ��� : õ���
            ------------------------------------------------------------

			INSERT INTO ORDERS(ORDER_ID, MEM_ID)
				VALUES (1, 'M1003');

			SELECT *
				FROM ORDERS;

    ��� ��) ���� �ڷḦ �ֹ� �� ���̺�( ORDERS_GOODS ) �� �����Ͻÿ�.
			��ǰ�ڵ�		�ֹ���ȣ		����
		---------------------------------------------------------------
			G12002		1			5
			G21001		1			24
			G20001		1			10
		---------------------------------------------------------------
		INSERT INTO ORDERS_GOODS(ORDER_ID, GOOD_ID, QTY)
			VALUES(1, 'G12002', 5);

		INSERT INTO ORDERS_GOODS(ORDER_ID, GOOD_ID, QTY)
			VALUES(1, 'G21001', 24);

		INSERT INTO ORDERS_GOODS(ORDER_ID, GOOD_ID, QTY)
			VALUES(1, 'G20001', 10);

		INSERT INTO ORDERS_GOODS(ORDER_ID, GOOD_ID, QTY)
			VALUES(1, 'G11001', 2);

		UPDATE ORDERS
			SET ORDER_AMT = (
				SELECT SUM(GOOD_PRICE * QTY)
					FROM ORDERS_GOODS A, TB_GOODS B
					WHERE A.GOOD_ID = B.GOOD_ID
				),
				ORDER_FLAG = '2'
			WHERE ORDER_ID = 1;

		SELECT *
			FROM ORDERS_GOODS;
			
		SELECT *
			FROM ORDERS;

		COMMIT;