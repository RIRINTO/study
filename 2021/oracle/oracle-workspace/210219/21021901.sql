2021-02-19-01)
				SELECT MEM_ID AS ȸ����ȣ,
						MEM_NAME AS ȸ���̸�,
						EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) - 1 AS ����,
						MEM_MILEAGE AS ���ϸ���
					FROM MEMBER
					WHERE SUBSTR(MEM_REGNO2, 1, 1) IN('2', '4')
						AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) - 1 BETWEEN 40 AND 49;

	4) LIKE ������
		- ���� �񱳽� ���
		- ���ڿ� �ڷ� �񱳿� ���Ǵ� ������
		- ���ϵ�ī�� '%'�� '_' ���\
		- '%'�� ���� ��ġ���� ��� ���ڿ��� ����

		ex)
			'��%' : '��'���� �����ϴ� ��� ���ڿ��� ����
			'%��' : '��'�� ������ ��� ���ڿ��� ����
			- '_'�� ���� ��ġ���� �� ���ڿ� ����

		ex)
			'��_' : '��'���� �����ϰ� 2���ڷ� ������ ���ڿ��� �� ��° ���ڴ� ��� ���� ���
			'_��' : '��'�� ������ 2���ڷ� ������ ���ڿ��� �� ��° ���ڴ� ��� ���� ���

		��)
			�ŷ�ó ���̺� ( BUYER ) ���� �ּ����� ������ �ŷ�ó�� ��ȸ�Ͻÿ�.
			Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�, �����
				SELECT BUYER_ID AS �ŷ�ó�ڵ�,
						BUYER_NAME AS �ŷ�ó��,
						BUYER_ADD1 || ' ' || BUYER_ADD2 AS �ּ�,
						BUYER_BANKNAME AS �����
					FROM BUYER
					WHERE SUBSTR(BUYER_ADD1, 1, 2) = '����';

				SELECT BUYER_ID AS �ŷ�ó�ڵ�,
						BUYER_NAME AS �ŷ�ó��,
						BUYER_ADD1 || ' ' || BUYER_ADD2 AS �ּ�,
						BUYER_BANKNAME AS �����
					FROM BUYER
					WHERE BUYER_ADD1 LIKE '����%';

		��)
			��ٱ��� ���̺� ( CART ) ���� 2005�� 5�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�.
			Alias�� ��¥, ��ǰ�ڵ�, �Ǹż����̴�.
				SELECT SUBSTR(CART_NO, 1, 8) AS ��¥,
						CART_PROD AS ��ǰ�ڵ�,
						CART_QTY AS �Ǹż���
					FROM CART
					WHERE SUBSTR(CART_NO, 1, 8) = '200505%'
					ORDER BY CART_NO;

				SELECT SUBSTR(CART_NO, 1, 8) AS ��¥,
						CART_PROD AS ��ǰ�ڵ�,
						CART_QTY AS �Ǹż���
					FROM CART
					WHERE CART_NO LIKE '200505%'

		����]
			2005�� 3�� ��ǰ���� ��Ȳ�� ��ȸ�Ͻÿ�.
			Alias�� ��¥, ��ǰ�ڵ�, ���Լ����̴�.
				SELECT BUY_DATE AS ��¥,
						BUY_PROD AS ��ǰ�ڵ�,
						BUY_QTY AS ���Լ���
					FROM BUYPROD
--					WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
--					AND EXTRACT(MONTH FROM BUY_DATE) = 3
--					WHERE TO_CHAR(BUY_DATE, 'YYYYMM') = '200503'
--					WHERE TO_CHAR(BUY_DATE) LIKE '2005/03%'
					WHERE BUY_DATE BETWEEN '20050301' AND '20050331'
					ORDER BY BUY_DATE;

		** 234567 * 12345 �� ���� ���Ͻÿ�.
			SELECT 234567 * 12345
			FROM DUAL;

			SELECT SYSDATE
			FROM DUAL;