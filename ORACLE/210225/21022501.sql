2021-02-25-01)
	��� �� 1)
		������̺��� �� �μ��� �޿� �հ踦 ���Ͻÿ�.
		Alias�� �μ���ȣ, �޿��հ�
			SELECT DEPARTMENT_ID AS �μ���ȣ,
					SUM(SALARY) AS �޿��հ�
				FROM EMPLOYEES
				GROUP BY DEPARTMENT_ID
				ORDER BY DEPARTMENT_ID;

	��� �� 2)
		2005�� 1 ~ 6���� ����, �ŷ�ó�� ���������� ��ȸ�Ͻÿ�.
		Alias�� ��, �ŷ�ó�ڵ�, ���Լ�����, ���Աݾ���
			SELECT EXTRACT(MONTH FROM A.BUY_DATE)||'��' AS ��,
					B.PROD_BUYER AS �ŷ�ó�ڵ�,
					SUM(A.BUY_QTY) AS ���Լ�����,
					SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ���
				FROM BUYPROD A,
					PROD B
				WHERE A.BUY_PROD = B.PROD_ID
					AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
					AND EXTRACT(MONTH FROM A.BUY_DATE) BETWEEN 1 AND 6
				GROUP BY EXTRACT(MONTH FROM A.BUY_DATE),
					B.PROD_BUYER
				ORDER BY EXTRACT(MONTH FROM A.BUY_DATE),
					B.PROD_BUYER;

			SELECT EXTRACT(MONTH FROM A.BUY_DATE)||'��' AS ��,
					B.PROD_BUYER AS �ŷ�ó�ڵ�,
					SUM(A.BUY_QTY) AS ���Լ�����,
					SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ���
				FROM BUYPROD A,
					PROD B,
					BUYER C
				WHERE A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630') -- �Ϲ�����
					AND A.BUY_PROD = B.PROD_ID -- ��������
					AND B.PROD_BUYER = C.BUYER_ID -- ��������
				GROUP BY EXTRACT(MONTH FROM A.BUY_DATE),
					B.PROD_BUYER
				ORDER BY EXTRACT(MONTH FROM A.BUY_DATE),
					B.PROD_BUYER;

	��� �� 3)
		2005�� 5�� ȸ���� ���������� ��ȸ�Ͻÿ�.
		��, �Ǹż����� 20�� �̻��� ȸ���� ��ȸ�Ͻÿ�.
		Alias�� ȸ����, �Ǹż����հ�
			SELECT B.MEM_NAME AS ȸ����,
					SUM(A.CART_QTY) AS �Ǹż����հ�
				FROM CART A,
					MEMBER B
				WHERE A.CART_MEMBER = B.MEM_ID -- ��������
					AND A.CART_NO LIKE '200505%' -- �Ϲ�����
				GROUP BY B.MEM_NAME
				HAVING SUM(A.CART_QTY) >= 20
				ORDER BY SUM(A.CART_QTY) DESC;

	��� �� 4)
		2005�� 5�� �Ϻ�, ��ǰ�� �Ǹ������� ��ȸ�Ͻÿ�.
		Alias�� ����, ��ǰ�ڵ�, �Ǹż����հ�, �Ǹűݾ��հ�
			SELECT TO_DATE(SUBSTR(A.CART_NO, 1, 8)) AS ����,
				A.CART_PROD AS ��ǰ�ڵ�,
				SUM(A.CART_QTY) AS �Ǹż����հ�,
				SUM(B.PROD_SALE * A.CART_QTY) AS �Ǹűݾ��հ�
			FROM CART A,
				PROD B
			WHERE A.CART_PROD = B.PROD_ID
				AND A.CART_NO LIKE '200505%'
			GROUP BY SUBSTR(A.CART_NO, 1, 8),
				A.CART_PROD
			ORDER BY SUBSTR(A.CART_NO, 1, 8),
				A.CART_PROD;

2. AVG(col)
	- col�� ����� �������� ��հ��� ���Ͽ� ��ȯ

	��� ��)
		ȸ�� ���̺��� ȸ���� ���� ��� ���ϸ����� ��ȸ�Ͻÿ�
			SELECT CASE
						WHEN MOD(SUBSTR(MEM_REGNO2, 1, 1), 2) = 0
							THEN '����ȸ��'
						ELSE '����ȸ��'
					END AS ����,
					TRUNC(AVG(MEM_MILEAGE)) AS "��� ���ϸ���"
				FROM MEMBER
				GROUP BY CASE
						WHEN MOD(SUBSTR(MEM_REGNO2, 1, 1), 2) = 0
							THEN '����ȸ��'
						ELSE '����ȸ��'
					END
				ORDER BY CASE
						WHEN MOD(SUBSTR(MEM_REGNO2, 1, 1), 2) = 0
							THEN '����ȸ��'
						ELSE '����ȸ��'
					END;

			SELECT CASE
						WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3')
							THEN '����ȸ��'
						ELSE '����ȸ��'
					END AS ����,
					TRUNC(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
				FROM MEMBER
				GROUP BY CASE
						WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3')
							THEN '����ȸ��'
						ELSE '����ȸ��'
					END
				ORDER BY CASE
						WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3')
							THEN '����ȸ��'
						ELSE '����ȸ��'
					END;

	����)
		ȸ�� ���̺��� ȸ���� ���ɴ뺰 ��� ���ϸ����� ���Ͻÿ�.
		���п��� '10��', '20��', ... ���� ���� ����Ѵ�.
		Alias�� ����, ��ո��ϸ���
			SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) + 1) / 10) || '0��' AS ���ɴ�,
					TRUNC(AVG(MEM_MILEAGE)) AS "��� ���ϸ���"
				FROM MEMBER
				GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) + 1) / 10)
				ORDER BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) + 1) / 10);

	��� ��)
		������̺��� ������ ��� �޿��� �Ҽ��� ���� �� �ڸ����� ���Ͽ� ����Ͻÿ�.
		Alias�� ������, ��� �޿�
			SELECT JOBS.JOB_TITLE AS ������,
					ROUND(AVG(EMPLOYEES.SALARY), 1) AS ��ձ޿�
				FROM EMPLOYEES, JOBS
				WHERE EMPLOYEES.JOB_ID = JOBS.JOB_ID
				GROUP BY JOBS.JOB_TITLE
				ORDER BY AVG(EMPLOYEES.SALARY) DESC;

	��� ��)
		�����ܾ����̺��� 2013�� ������ ��� ���� �ܾ��� ��ȸ�ϵ�, ��� ���� �ܾ��� ���� ���� 3�� �õ��� ����Ͻÿ�.
			SELECT A.R1 AS ����,
					A.LAVG AS "��� ���� �ܾ�"
				FROM (
						SELECT REGION AS R1,
								TO_CHAR(ROUND(AVG(LOAN_JAN_AMT), 1), '999,999.9') AS LAVG
							FROM KOR_LOAN_STATUS
							WHERE PERIOD LIKE '2013%'
							GROUP BY REGION
							ORDER BY SUM(LOAN_JAN_AMT) DESC
					) A
				WHERE ROWNUM <= 3;

3. COUNT(* | col)
	- �׷� ���� �ڷ� ( �� ) �� ���� ��ȯ
	- '*'�� �÷����� ����ص� ���� ��� ��ȯ��
	��, �ܺ����ο� ����� �� '*'�� ����ؼ� �ȵ�. �ַ� �⺻Ű �÷����� ���

	��� ��)
		��� ���̺��� �μ��� ��� ���� ��ȸ�Ͻÿ�.
			SELECT DEPARTMENT_ID AS "�μ� �ڵ�",
					COUNT(*) AS "��� ��",
					COUNT(EMP_NAME) AS "��� ��"
				FROM EMPLOYEES
				GROUP BY DEPARTMENT_ID
				ORDER BY DEPARTMENT_ID;

	��� ��)
		��ٱ��� ���̺��� ȸ���� ����Ƚ���� ��ȸ�ϵ�,
		����Ƚ���� 5 �̻��� ȸ���� ����Ͻÿ�.
			SELECT CART_MEMBER AS ȸ����ȣ,
					COUNT(DISTINCT CART_NO) AS ����Ƚ��
				FROM CART
				GROUP BY CART_MEMBER
				HAVING COUNT(DISTINCT CART_NO) >= 5
				ORDER BY COUNT(DISTINCT CART_NO);

			SELECT A.AMEM AS ȸ����ȣ,
					COUNT(*) AS ����Ƚ��
				FROM (
						SELECT CART_MEMBER AS AMEM,
								CART_NO AS ANO,
								COUNT(*) AS CNT
							FROM CART
							GROUP BY CART_MEMBER,
								CART_NO
					) A
				GROUP BY A.AMEM
				HAVING COUNT(*) >= 5
				ORDER BY COUNT(*);

			SELECT A.CMEM AS ȸ����ȣ,
					COUNT(*) AS ����Ƚ��
				FROM (
						SELECT DISTINCT CART_MEMBER AS CMEM,
								CART_NO
							FROM CART
							ORDER BY CART_MEMBER
					) A
				GROUP BY A.CMEM
				HAVING COUNT(*) >= 5
				ORDER BY COUNT(*);

	��� ��)
		2005�� 3�� ��� �ŷ�ó �� ��ǰ ���� �Ǽ��� ��ȸ�Ͻÿ�.
		Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���԰Ǽ�
			SELECT D.BUYER_ID AS �ŷ�ó�ڵ�,
					D.BUYER_NAME AS �ŷ�ó��,
					NVL(C.CNT, 0) AS ���԰Ǽ�
				FROM (
						SELECT B.PROD_BUYER AS BCODE,
								COUNT(A.BUY_PROD) AS CNT
							FROM BUYPROD A,
								PROD B
							WHERE A.BUY_PROD = B.PROD_ID
								AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
								AND EXTRACT(MONTH FROM A.BUY_DATE) = 3
							GROUP BY B.PROD_BUYER
					) C,
					BUYER D
				WHERE D.BUYER_ID = C.BCODE(+)
				ORDER BY D.BUYER_ID;

			SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
					B.BUYER_NAME AS �ŷ�ó��,
					COUNT(A.BUY_PROD) AS ���԰Ǽ�
				FROM BUYPROD A
					RIGHT OUTER JOIN PROD C
						ON(
								C.PROD_ID = A.BUY_PROD
								AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
								AND EXTRACT(MONTH FROM A.BUY_DATE) = 3
							)
					RIGHT OUTER JOIN BUYER B
						ON(
								B.BUYER_ID = C.PROD_BUYER
							)
				GROUP BY B.BUYER_ID,
					B.BUYER_NAME
				ORDER BY B.BUYER_ID;

			SELECT D.BUYER_ID AS �ŷ�ó�ڵ�,
					D.BUYER_NAME AS �ŷ�ó��,
					NVL(TBLA.CNT, 0) AS ���԰Ǽ�
				FROM (
						SELECT B.BUYER_ID AS BCODE,
								COUNT(A.BUY_PROD) AS CNT
							FROM BUYPROD A,
								BUYER B,
								PROD C
							WHERE C.PROD_ID = A.BUY_PROD
								AND B.BUYER_ID = C.PROD_BUYER
								AND A.BUY_DATE BETWEEN '20050301' AND '20050331'
							GROUP BY B.BUYER_ID
					) TBLA,
					BUYER D
				WHERE D.BUYER_ID = TBLA.BCODE(+)
				ORDER BY D.BUYER_ID;