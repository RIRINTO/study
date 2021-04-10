2020-02-18-01)
SELECT ��
	- �ڷ� �˻� ���
	- SQL���� ���� ���� ���Ǵ� ��ɾ�

	��� ����
		SELECT [DISTINCT] * | [�÷���1 [AS ["]�÷���Ī["]]
				[, �÷���2 [AS ["]�÷���Ī["]]
							:
				[, �÷���n [AS ["]�÷���Ī["]]
			FROM ���̺� ��
			[WHERE ����1
				[AND ����2]
					:
				[AND ����n]]
			[GROUP BY �÷���1
				[, �÷���2]
					:
				[, �÷���n]]
			[HAVING ����1
				[, ����2]
					:
				[, ����n]]
			[ORDER BY �÷��ε��� | �÷���1 [ASC | DESC]
				[, �÷��ε��� | �÷���2 [ASC | DESC]]
							:
				[, �÷��ε��� | �÷���n [ASC | DESC]]
			]

1. SELECT ��
	- �˻��� �÷��� ���õ� ��
	- ����Ǵ� ������ ���� �ʰ� ( FROM �� WHERE �� SELECT )

	��� ����
		SELECT [DISTINCT] * | [�÷���1 [AS ["]�÷���Ī["]]
			[, �÷���2 [AS ["]�÷���Ī["]]
						:
			[, �÷���n [AS ["]�÷���Ī["]]

	. [DISTINCT] : �ߺ��� �ڷḦ �����Ͽ� ����� �����
		��� ��)
			ȸ�� ���̺��� ȸ������ �ּ����� ������ ��� ��ȸ�Ͻÿ�.
			Alias�� ������ ( ������ �Ǵ� �� )
				-- DISTINCT �̻��
					SELECT SUBSTR (MEM_ADD1, 1, 2)
						FROM MEMBER;

				-- DISTINCT ���
					SELECT DISTINCT SUBSTR (MEM_ADD1, 1, 2)
						FROM MEMBER;

		��� ��)
			ȸ�� ���̺��� ȸ������ ������ �ִ� ��� ( MEM_LIKE ) ���� ��ȸ�Ͻÿ�.
				SELECT DISTINCT MEM_LIKE AS ���
					FROM MEMBER;

	�÷� ��Ī
		. �÷��� �ο��ϴ� ������ �̸�
		. �ش� �÷��� �����̳� SUBQUERY ��� �� �÷��� ���� �����ϱ� ���Ͽ� ����
		. �÷���Ī�� Ư������ ( �����̳� ��ȣ, ����� ) �� ���� ������ " "�� ���� ����ؾ� ��
		. 'AS'�� ���� ���� ( ����ϴ� ���� �������� ���� ���� �� )
		. �÷���Ī�� �ش� SELECT ���� WHERE �� � ����� �� ����

	��� �� )
		�����ٷ� ���
			������̺� ( EMPLOYEES ) ���� �������� ( COMMISSION_PCT ) �� NULL�� �ƴ� ������ǿ��������� ���� ���ʽ��� ��ȸ�Ͻÿ�.
			���ʽ� = �޿� * ���������ڵ�
			Alias�� �����ȣ, �����, ���������ڵ�, ����, ���ʽ��̴�.
				SELECT EMPLOYEE_ID AS �����ȣ,
						EMP_NAME AS �����,
						COMMISSION_PCT AS "�������� �ڵ�",
						SALARY AS ����,
						SALARY * COMMISSION_PCT AS ���ʽ�
					FROM EMPLOYEES
					WHERE COMMISSION_PCT IS NOT NULL
						AND SALARY * COMMISSION_PCT >= 3000
--					ORDER BY 5 DESC
--					ORDER BY ���ʽ� DESC
					ORDER BY SALARY * COMMISSION_PCT DESC;


	GROUP BY �Լ� ���
		��� ��)
			ȸ�� ���̺� ( MEMBER ) ���� ���� ���ϸ��� �հ踦 ��ȸ�Ͻÿ�
				SELECT CASE
							WHEN SUBSTR(MEM_REGNO2, 1, 1)='1' OR SUBSTR(MEM_REGNO2, 1, 1)='3'
								THEN '����ȸ��'
							ELSE '����ȸ��'
						END AS ����,
						SUM(MEM_MILEAGE) AS "���ϸ��� �հ�"
					FROM MEMBER
					GROUP BY CASE
							WHEN SUBSTR(MEM_REGNO2, 1, 1)='1' OR SUBSTR(MEM_REGNO2, 1, 1)='3'
								THEN '����ȸ��'
							ELSE '����ȸ��'
						END;

		��� ��)
			��ٱ������̺� ( CART ) ���� 2005�� 6�� ȸ���� ���ž��� ��ȸ�ϵ� ���űݾ��� 50���� �̻��� ȸ�������� ��ȸ�Ͻÿ�.
			Alias�� ȸ����ȣ, ȸ����, ���ž��̴�.
				SELECT A.CART_MEMBER AS ȸ����ȣ,
						B.MEM_NAME AS ȸ����,
						SUM(A.CART_QTY * C.PROD_PRICE) AS ���ž�
					FROM CART A,
						MEMBER B,
						PROD C
					WHERE A.CART_MEMBER = B.MEM_ID	-- ��������
						AND A.CART_PROD = C.PROD_ID	-- ��������
						AND A.CART_NO LIKE '200506%'
--						AND SUBSTR(A.CART_NO, 1, 8) >= '20050601' AND SUBSTR(A.CART_NO, 1, 8) <= '20050630'
					GROUP BY A.CART_MEMBER, B.MEM_NAME
					HAVING SUM(A.CART_QTY * C.PROD_PRICE) >= 500000
					ORDER BY 3 DESC;


DROP TABLE ORDERS_GOODS;

DROP TABLE TB_GOODS;

DROP TABLE TB_MEM;

DROP TABLE ORDERS;

DROP TABLE TEMP01;

DROP TABLE TEMP02;

DROP TABLE TEMP03;

DROP TABLE TEMP04;

DROP TABLE TEMP05;

DROP TABLE TEMP06;

DROP TABLE TEMP07;

DROP TABLE TEMP08;