2021-03-02-01)
���̺� ����
	- ������ �����ͺ��̽��� �ٽ�
	- ���� ���̺� �л�Ǿ� ����� �ڷ���� ���� ( Relationshipo ) �� �̿��Ͽ� �����ϴ� ����
	- ����
		1) ��������, �ܺ�����
		2) �Ϲ�����, ANSI����
		3) Cartesian Product, Equi Join, Non-Equi Join, Self Join, etc ...

1. �������� ( Inner Join )
	- ���������� �����ϴ� �����͸� ������ ����� ��ȯ�ǰ�, �������ǿ� ���� �ʴ� �ڷ�� ���� ��

	��� ���� ( �Ϲ� ���� )
		SELECT �÷�1, �÷�2, ...
			FROM ���̺��1 [���̺�Ī1], ���̺��2 [���̺�Ī2], [, ���̺��3 [���̺�Ī3], ...]
			WHERE ��������
				[AND ��������, ...]
				[AND �Ϲ�����, ...]
		. ���Ǵ� ���̺��� ������ n���϶� ���� ������ ��� n - 1�� �̻��̾�� ��
		. ���� ���ǿ� ���Ǵ� �÷��� �� ���̺� �����ϴ� ���� �ڷḦ �����ϰ� �ִ� �÷� ( ���� �ܷ�Ű ���� Ȱ�� )
		. ���� ���ǰ� ���� ������ ��� ������ ��� ����

	��� ���� ( ANSI - �Ϲ� ���� )
		SELECT �÷�1, �÷�2, ...
			FROM ���̺��1 [���̺�Ī1]
				INNER JOIN ���̺��2[ ���̺�Ī2] ON(��������[ AND �Ϲ�����])
				[INNER JOIN ���̺��3[ ���̺�Ī3] ON(��������[ AND �Ϲ�����])
			[WHERE �Ϲ�����, ...]

	��)
		��ٱ��� ���̺��� �̿��Ͽ� 2005�� 6�� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� ȸ����ȣ, ȸ����, ���ż����հ��̴�.
			SELECT A.CART_MEMBER AS ȸ����ȣ,
					B.MEM_NAME AS ȸ����,
					SUM(CART_QTY) AS ���ż����հ�
				FROM CART A, MEMBER B
				WHERE A.CART_MEMBER = B.MEM_ID
					AND CART_NO LIKE '200506%'
				GROUP BY A.CART_MEMBER,
					B.MEM_NAME
				ORDER BY A.CART_MEMBER,
					B.MEM_NAME;

			SELECT A.CART_MEMBER AS ȸ����ȣ,
					B.MEM_NAME AS ȸ����,
					SUM(CART_QTY) AS ���ż����հ�
				FROM CART A
					INNER JOIN MEMBER B
					ON(A.CART_MEMBER = B.MEM_ID)
				WHERE CART_NO LIKE '200506%'
				GROUP BY A.CART_MEMBER,
					B.MEM_NAME
				ORDER BY A.CART_MEMBER,
					B.MEM_NAME;

2. Cartesian Product ( ANSI ���� CROSS JOIN�̶�� �� )
	- ��� ���� ����� ����
	- ���ο� ������ ���̺��� ���� ���� ���� ���� ����� ��ȯ
	- �ݵ�� �ʿ��� ��찡 �ƴϸ� ��� ����
	- ���� ������ �����ϰų�, �߸��� ���� ������ �����ϸ� �߻�

	��� ��)
		SELECT COUNT(*) AS "���� ��" -- 74 * 209
			FROM CART,
				PROD;

3. Equi Join
	- ���� �������� �������ǿ� '=' ������ ���Ǵ� ����
	- ANSI������ INNER JOIN�̶� ��
	
	��� ��)
		��� ���̺��� ���� ������ �����Ͽ� ����� ��ȸ�Ͻÿ�.
		Alias�� �����ȣ, �����, �μ��ڵ�, �μ���, ��å��, �޿�
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.DEPARTMENT_ID AS �μ��ڵ�,
					B.DEPARTMENT_NAME AS �μ���,
					C.JOB_TITLE AS ��å��,
					A.SALARY AS �޿�
				FROM EMPLOYEES A, DEPARTMENTS B, JOBS C
				WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
					AND A.JOB_ID = C.JOB_ID
				ORDER BY A.EMPLOYEE_ID;

			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.DEPARTMENT_ID AS �μ��ڵ�,
					B.DEPARTMENT_NAME AS �μ���,
					C.JOB_TITLE AS ��å��,
					A.SALARY AS �޿�
				FROM EMPLOYEES A
					INNER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
					INNER JOIN JOBS C ON(A.JOB_ID = C.JOB_ID)
				ORDER BY A.EMPLOYEE_ID;

	��� ��)
		��ǰ ���̺��� �� �з��� ���ϴ� ��ǰ�� ���� ��ȸ�Ͻÿ�.
		Alias�� �з��ڵ�, �з���, ��ǰ�� ��
		SELECT B.LPROD_GU AS �з��ڵ�,
				B.LPROD_NM AS �з���,
				COUNT(*) AS "��ǰ�� ��"
			FROM PROD A,
				LPROD B
			WHERE A.PROD_LGU = B.LPROD_GU
			GROUP BY B.LPROD_GU,
				B.LPROD_NM
			ORDER BY B.LPROD_GU;

		SELECT B.LPROD_GU AS �з��ڵ�,
				B.LPROD_NM AS �з���,
				COUNT(*) AS "��ǰ�� ��"
			FROM PROD A
				INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU)
			GROUP BY B.LPROD_GU,
				B.LPROD_NM
			ORDER BY B.LPROD_GU;

	���� 1]
		��ٱ��� ���̺��� 2005�� 7�� ��ǰ�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� ��ǰ�ڵ�, ��ǰ��, �Ǹż���, �Ǹűݾ�
		�Ϲ� ���� ���İ� ANSI ���� ���� ����
			SELECT B.PROD_ID AS ��ǰ�ڵ�,
					B.PROD_NAME AS ��ǰ��,
					SUM(A.CART_QTY) AS �Ǹż���,
					SUM(A.CART_QTY * B.PROD_SALE) AS �Ǹűݾ�
				FROM CART A,
					PROD B
                WHERE CART_NO LIKE '200507%' -- �Ϲ�����
					AND A.CART_PROD = B.PROD_ID -- ��������
				GROUP BY B.PROD_ID,
					B.PROD_NAME
				ORDER BY B.PROD_ID;

			SELECT B.PROD_ID AS ��ǰ�ڵ�,
					B.PROD_NAME AS ��ǰ��,
					SUM(A.CART_QTY) AS �Ǹż���,
					SUM(A.CART_QTY * B.PROD_SALE) AS �Ǹűݾ�
				FROM CART A
					INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID)
				WHERE CART_NO LIKE '200507%'
				GROUP BY B.PROD_ID,
					B.PROD_NAME
				ORDER BY B.PROD_ID;

	���� 2]
		2005�� 2�� �ŷ�ó��, ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ��, ���Լ���, ���Աݾ�
		�Ϲ� ���� ���İ� ANSI ���� ���� ����
			SELECT C.BUYER_ID AS �ŷ�ó�ڵ�,
					C.BUYER_NAME AS �ŷ�ó��,
					B.PROD_NAME AS ��ǰ��,
					SUM(A.BUY_QTY) AS ���Լ���,
					SUM(A.BUY_QTY * PROD_COST) AS ���Աݾ�
				FROM BUYPROD A,
					PROD B,
					BUYER C
				WHERE A.BUY_PROD = B.PROD_ID
					AND B.PROD_BUYER = C.BUYER_ID
					AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
					AND EXTRACT(MONTH FROM A.BUY_DATE) = 2
				GROUP BY C.BUYER_ID,
					C.BUYER_NAME,
					B.PROD_NAME
				ORDER BY C.BUYER_ID,
					B.PROD_NAME;
					
			SELECT C.BUYER_ID AS �ŷ�ó�ڵ�,
					C.BUYER_NAME AS �ŷ�ó��,
					B.PROD_NAME AS ��ǰ��,
					SUM(A.BUY_QTY) AS ���Լ���,
					SUM(A.BUY_QTY * PROD_COST) AS ���Աݾ�
				FROM BUYPROD A
					INNER JOIN PROD B
						ON
							(
								A.BUY_PROD = B.PROD_ID
								AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
								AND EXTRACT(MONTH FROM A.BUY_DATE) = 2
							)
					INNER JOIN BUYER C
						ON
							(
								B.PROD_BUYER = C.BUYER_ID
							)
				GROUP BY C.BUYER_ID,
					C.BUYER_NAME,
					B.PROD_NAME
				ORDER BY C.BUYER_ID,
					B.PROD_NAME;

	���� 3]
		2005�� 5�� ����, ������Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� ��ǰ�ڵ�, ��ǰ��, ���Աݾ��հ�, �Ǹűݾ��հ��̴�.

			SELECT C.PROD_ID AS ��ǰ�ڵ�,
					C.PROD_NAME AS ��ǰ��,
					SUM(C.PROD_COST * A.BUY_QTY) AS ���Աݾ��հ�,
					SUM(B.CART_QTY * C.PROD_PROCE) AS �Ǹűݾ��հ�
				FROM BUYPROD A, CART B, PROD C
				WHERE A.BUY_PROD = C.PROD_ID
					AND C.PROD_ID = B.CART_PROD
					AND TO_CHAR(A.BUY_DATE, 'YYYYMM') = '200505'
					AND B.CART_NO LIKE '200505%'
				GROUP BY C.PROD_ID,
					C.PROD_NAME
				ORDER BY C.PROD_ID;

			SELECT A.PROD_ID AS ��ǰ�ڵ�,
					A.PROD_NAME AS ��ǰ��,
					SUM(A.PROD_COST * B.BUY_QTY) AS ���Աݾ��հ�,
					SUM(A.PROD_SALE * C.CART_QTY) AS �Ǹű޾��հ�
				FROM PROD A,
					(
						SELECT *
							FROM BUYPROD
							WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
								AND EXTRACT(MONTH FROM BUY_DATE) = 5
					) B,
					(
						SELECT *
							FROM CART
							WHERE CART_NO LIKE '200505%'
					) C
				WHERE A.PROD_ID = B.BUY_PROD(+)
					AND A.PROD_ID = C.CART_PROD(+)
				GROUP BY A.PROD_ID,
					A.PROD_NAME;

			SELECT A.PROD_ID AS ��ǰ�ڵ�,
					A.PROD_NAME AS ��ǰ��,
					SUM(A.PROD_COST * B.BUY_QTY) AS ���Աݾ��հ�,
					SUM(A.PROD_SALE * C.CART_QTY) AS �Ǹű޾��հ�
				FROM PROD A
					LEFT OUTER JOIN (
                            SELECT *
                                FROM BUYPROD
                                WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
                                    AND EXTRACT(MONTH FROM BUY_DATE) = 5
					) B
						ON(A.PROD_ID = B.BUY_PROD)
					LEFT OUTER JOIN (
                            SELECT *
                                FROM CART
                                WHERE CART_NO LIKE '200505%'
					) C
						ON(A.PROD_ID = C.CART_PROD)
				GROUP BY A.PROD_ID,
					A.PROD_NAME
				ORDER BY A.PROD_ID;

			SELECT A.PROD_ID AS ��ǰ�ڵ�,
					A.PROD_NAME AS ��ǰ��,
					SUM(A.PROD_COST * B.BUY_QTY) AS ���Աݾ��հ�,
					SUM(A.PROD_SALE * C.CART_QTY) AS �Ǹű޾��հ�
				FROM PROD A
					LEFT OUTER JOIN BUYPROD B
						ON(
							A.PROD_ID = B.BUY_PROD
							AND EXTRACT(YEAR FROM BUY_DATE) = 2005
							AND EXTRACT(MONTH FROM BUY_DATE) = 5
						)
					LEFT OUTER JOIN CART C
						ON(
							A.PROD_ID = C.CART_PROD
							AND CART_NO LIKE '200505%'
						)
				GROUP BY A.PROD_ID,
					A.PROD_NAME
				ORDER BY A.PROD_ID;