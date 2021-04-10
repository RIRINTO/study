2021-03-08-01)
3. ���� �� ��������
	- ���������� ����� 1���� ������ ������ ���
	- ���迬���ڰ� ���� ��� ( ���� )
	
	��� ��)
		ȸ�� ���̺��� ȸ���� ��� ���ϸ������� ���� ���ϸ����� ������ ȸ������
		Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ��ո��ϸ���
			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					MEM_MILEAGE AS ���ϸ���,
					(
						SELECT ROUND(AVG(MEM_MILEAGE), 1)
							FROM MEMBER
					)AS ��ո��ϸ���
				FROM MEMBER
				WHERE MEM_MILEAGE >= (
						SELECT AVG(MEM_MILEAGE)
							FROM MEMBER
					);

			SELECT A.MEM_ID AS ȸ����ȣ,
					A.MEM_NAME AS ȸ����,
					A.MEM_MILEAGE AS ���ϸ���,
					ROUND(B.AVG_MILEAGE, 1) AS ��ո��ϸ���
				FROM MEMBER A,
					(
						SELECT AVG(MEM_MILEAGE) AS AVG_MILEAGE
							FROM MEMBER
					) B
				WHERE A.MEM_MILEAGE >= B.AVG_MILEAGE;

	��� ��)
		2005�� 6�� ��� ȸ�� �� ���� ��Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� ȸ����ȣ, ȸ����, ���ż����հ�, ���űݾ��հ�
			SELECT C.MEM_ID AS ȸ����ȣ,
					C.MEM_NAME AS ȸ����,
					NVL(SUM(A.CART_QTY), 0) AS ���ż����հ�,
					NVL(SUM(A.CART_QTY * PROD_SALE), 0) AS ���űݾ��հ�
				FROM CART A
					INNER JOIN PROD B
						ON(
						A.CART_PROD = B.PROD_ID
						AND A.CART_NO LIKE '200506%'
						)
					RIGHT OUTER JOIN MEMBER C
						ON(A.CART_MEMBER = C.MEM_ID)
				GROUP BY C.MEM_ID,
					C.MEM_NAME
				ORDER BY C.MEM_ID;

			SELECT B.MEM_ID AS ȸ����ȣ,
					B.MEM_NAME AS ȸ����,
					NVL(D.SQTY, 0) AS ���ż����հ�,
					NVL(D.SAMT, 0) AS ���űݾ��հ�
				FROM MEMBER B,
					(
						SELECT B.CART_MEMBER AS DID,
								SUM(B.CART_QTY) AS SQTY,
								SUM(B.CART_QTY * C.PROD_PRICE) AS SAMT
							FROM CART B,
								PROD C
							WHERE B.CART_PROD = C.PROD_ID
								AND B.CART_NO LIKE '200506%'
							GROUP BY B.CART_MEMBER
					) D
				WHERE B.MEM_ID = D.DID(+)
				ORDER BY B.MEM_ID;

4. ���� �� ���� ����
	- �������� ����� ��ȯ�ϴ� ��������
	- IN, ANY, EXISTS ���� ������ ����
	
	��� ��)
		��� ���̺��� 2005�⵵�� �Ի��� ������� �޿����� �� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�.
		Alias�� �����ȣ, �����, �Ի���, �޿�, ��å��
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.HIRE_DATE AS �Ի���,
					A.SALARY AS �޿�,
					B.JOB_TITLE AS ��å��
				FROM EMPLOYEES A,
					JOBS B
				WHERE A.HIRE_DATE >= TO_DATE('20070101')
					AND A.SALARY >= ANY(
							SELECT SALARY
								FROM EMPLOYEES
								WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2004
						)
					AND A.JOB_ID = B.JOB_ID
				ORDER BY A.EMPLOYEE_ID;
				
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.HIRE_DATE AS �Ի���,
					A.SALARY AS �޿�,
					B.JOB_TITLE AS ��å��
				FROM EMPLOYEES A,
					JOBS B
				WHERE A.HIRE_DATE >= TO_DATE('20070101')
					AND EXISTS(
							SELECT 1
								FROM EMPLOYEES B
								WHERE EXTRACT	(YEAR FROM B.HIRE_DATE) = 2004
									AND A.SALARY >= B.SALARY
						)
					AND A.JOB_ID = B.JOB_ID
				ORDER BY A.EMPLOYEE_ID;

	����]
		�μ� ���̺�� ��� ���̺��� �̿��Ͽ� ���� ������ �ذ��Ͻÿ�.
		���� �μ� ( PARENT_ID ) �� 90�� �μ��� �����μ��� ���� �� ������ ���� �μ��� ��� �޿����� ���� �޿��� �޴� ������� ��ȸ
		Alias�� �����ȣ, �����, �μ���ȣ, �μ���, ��ձ޿�
		��, INLINE SUBQUERY�� �ۼ��Ͻÿ�.
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					D.DID AS �μ���ȣ,
					D.DNAME AS �μ���,
					A.SALARY AS �޿�,
					D.DSAL AS ��ձ޿�
				FROM EMPLOYEES A,
					(
						SELECT B.DEPARTMENT_ID AS DID,
								B.DEPARTMENT_NAME AS DNAME,
								AVG(C.SALARY) AS DSAL
							FROM DEPARTMENTS B,
								EMPLOYEES C
							WHERE B.DEPARTMENT_ID = C.DEPARTMENT_ID
								AND B.PARENT_ID = 90
							GROUP BY B.DEPARTMENT_ID,
								B.DEPARTMENT_NAME
					) D
				WHERE A.DEPARTMENT_ID = D.DID
					AND A.SALARY >= D.DSAL
				ORDER BY A.EMPLOYEE_ID;