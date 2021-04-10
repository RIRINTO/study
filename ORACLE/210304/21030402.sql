2021-03-04-02)
�ܺ� ����
	- �������ο����� ���������� �������� ���� �ڷ� ( �� ) �� ����
	- �ܺ����ο����� ���������� �������� ���� ���̺� ���� �ุŭ
		NULL ���� ���� ���� �߰� ������ �� ���� ����
	- ���� ���� ������� ������ �ڷḦ ���� �ִ� ���̺� ���� �÷��� �ڿ� �ܺ� ���� ������ ( '(+)' ) �� ���
	- �� �� �̻��� ���ο� �ܺ� ������ ���ÿ� ����Ǿ� �� ���
		�ش�Ǵ� ���� ���� ��� �ܺ� ���� ������ ( '(+)' ) �� ���
	- �� ���� �� ���̺� ���ؼ��� �ܺ� ������ ������ �� �ִ�.
		��, A, B, C ���̺��� �ܺ� ���ο� �����ϴ� ���,
			A�� �������� B�� �ܺ� �����ϰ� ( A = B(+) ),
			���ÿ� C�� �������� B�� �ܺ� ���� ( B = C(+) )�� �� ����.
	- (+) �����ڰ� ���� ���ǿ����� OR ������ ��� ����
	- (+) �����ڰ� ���� ���ǿ����� IN ������ ��� ����

	��� ����
		�Ϲ� OUTER JOIN
			SELECT �÷�LIST
				FROM ���̺�LIST
				WHERE �÷���1 = �÷���2(+)
					[AND �Ϲ�����]

		ANSI OUTER JOIN
			SELECT �÷�LIST
				FROM ���̺�1
					FULL|LEFT|RIGHT OUTER JOIN ���̺��2
						ON (��������1[ AND �Ϲ�����])
				WHERE �Ϲ�����

			. LEFT
				���̺��1�� ���̺��2���� �� ���� �ڷḦ ���� �ִ� ��� ���
			. RIGHT
				���̺��2�� ���̺��1���� �� ���� �ڷḦ ���� �ִ� ��� ���
			. FULL
				���̺��1, ���̺��2 ��� ������ ��� ���

	��)
		��ǰ ���̺��� ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�.
		Alias�� �з��ڵ�, �з���, ��ǰ�� ��
			SELECT A.LPROD_GU AS �з��ڵ�,
					A.LPROD_NM AS �з���,
					NVL(COUNT(B.PROD_ID), 0) AS "��ǰ�� ��"
				FROM LPROD A,
					PROD B
				WHERE A.LPROD_GU = B.PROD_LGU(+)
				GROUP BY A.LPROD_GU,
					A.LPROD_NM
				ORDER BY A.LPROD_GU,
					A.LPROD_NM;

			SELECT A.LPROD_GU AS �з��ڵ�,
					A.LPROD_NM AS �з���,
					COUNT(B.PROD_ID) AS "��ǰ�� ��"
				FROM LPROD A
					LEFT OUTER JOIN PROD B
						ON(A.LPROD_GU = B.PROD_LGU)
				GROUP BY A.LPROD_GU,
					A.LPROD_NM
				ORDER BY A.LPROD_GU,
					A.LPROD_NM;

	��)
		2005�� 2�� ��� ��ǰ �� ���� ��Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�
			SELECT A.PROD_ID AS ��ǰ�ڵ�,
					A.PROD_NAME AS ��ǰ��,
					NVL(SUM(B.BUY_QTY), 0) AS ���Լ���,
					NVL(SUM(B.BUY_QTY * A.PROD_COST), 0)���Աݾ�
				FROM PROD A,
					(
						SELECT *
							FROM BUYPROD
							WHERE TO_CHAR(BUY_DATE, 'YYYYMM') = '200502'
					) B
				WHERE A.PROD_ID = B.BUY_PROD(+)
				GROUP BY A.PROD_ID,
					A.PROD_NAME
				ORDER BY A.PROD_ID;

			SELECT A.PROD_ID AS ��ǰ�ڵ�,
					A.PROD_NAME AS ��ǰ��,
					NVL(SUM(B.BUY_QTY), 0) AS ���Լ���,
					NVL(SUM(B.BUY_QTY * A.PROD_COST), 0)���Աݾ�
				FROM PROD A
					LEFT OUTER JOIN BUYPROD B
						ON(
							A.PROD_ID = B.BUY_PROD
								AND TO_CHAR(BUY_DATE, 'YYYYMM') = '200502'
						)
				GROUP BY A.PROD_ID,
					A.PROD_NAME
				ORDER BY A.PROD_ID;

	��)
		��� ���̺��� ��� �μ��� ��� ���� ��ȸ�Ͻÿ�.
		�μ��ڵ�, �μ���, ��� ��
			SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
					B.DEPARTMENT_NAME AS �μ���,
					COUNT(A.EMPLOYEE_ID) AS "��� ��"
				FROM EMPLOYEES A,
					DEPARTMENTS B
				WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID
				GROUP BY B.DEPARTMENT_ID,
					B.DEPARTMENT_NAME
			UNION
			SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
					B.DEPARTMENT_NAME AS �μ���,
					COUNT(A.EMPLOYEE_ID) AS "��� ��"
				FROM EMPLOYEES A,
					DEPARTMENTS B
				WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
				GROUP BY B.DEPARTMENT_ID,
					B.DEPARTMENT_NAME;

			SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
					B.DEPARTMENT_NAME AS �μ���,
					COUNT(A.EMPLOYEE_ID) AS "��� ��"
				FROM EMPLOYEES A
					FULL OUTER JOIN DEPARTMENTS B
						ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
				GROUP BY B.DEPARTMENT_ID,
					B.DEPARTMENT_NAME
				ORDER BY B.DEPARTMENT_ID;

	��)
		2005�� 7�� ��� ȸ���� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� ȸ����ȣ, ȸ����, ���ż����հ�, ���űݾ��հ�
			SELECT A.MEM_ID AS ȸ����ȣ,
					A.MEM_NAME AS ȸ����,
					NVL(D.SUM_CART_QTY, 0) AS ���ż����հ�,
					NVL(D.SUM_CART_QTY_PROD_SALE, 0) AS ���űݾ��հ�
				FROM MEMBER A,
					(
						SELECT B.CART_MEMBER AS CART_CART_MEMBER,
								SUM(B.CART_QTY) AS SUM_CART_QTY,
								SUM(B.CART_QTY * C.PROD_SALE) AS SUM_CART_QTY_PROD_SALE
							FROM CART B,
								PROD C
							WHERE B.CART_PROD = C.PROD_ID
								AND CART_NO LIKE '200507%'
							GROUP BY B.CART_MEMBER
					) D
				WHERE A.MEM_ID = D.CART_CART_MEMBER(+)
				ORDER BY A.MEM_ID;

			SELECT C.MEM_ID AS ȸ����ȣ,
					C.MEM_NAME AS ȸ����,
					NVL(SUM(A.CART_QTY), 0) AS ���ż����հ�,
					NVL(SUM(A.CART_QTY * PROD_SALE), 0) AS ���űݾ��հ�
				FROM CART A
					INNER JOIN PROD B
						ON(
							A.CART_PROD = B.PROD_ID
								AND A.CART_NO LIKE '200507%'
						)
					RIGHT OUTER JOIN MEMBER C
						ON(A.CART_MEMBER = C.MEM_ID)
				GROUP BY C.MEM_ID,
					C.MEM_NAME
				ORDER BY C.MEM_ID;