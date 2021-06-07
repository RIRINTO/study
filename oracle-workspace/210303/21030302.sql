2021-03-03-02)

	��� ��)
		�ŷ�ó ���̺� ( BUYER ) �� �̿��Ͽ� 2005�� 7�� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
		Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, �Ǹűݾ��հ��̴�.
			SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
					A.BUYER_NAME AS �ŷ�ó��,
					SUM(B.CART_QTY * C.PROD_SALE) AS �Ǹűݾ��հ�
				FROM BUYER A,
					CART B,
					PROD C
				WHERE A.BUYER_ID = C.PROD_BUYER
					AND B.CART_PROD = C.PROD_ID
					AND B.CART_NO LIKE '200507%'
				GROUP BY A.BUYER_ID, A.BUYER_NAME;

** ���� �ڷḦ �����ϴ� �޿�������̺��� �����Ͻÿ�.
	1) ���̺��
		SAL_GRADE
	2) �÷���
		GRADE CHAR(2) PK
		LSAL NUMBER(8, 2)
		HSAL NUMBER(8, 2)
	3) ������
		------------------------------
		GRADE	LSAL	HSAL
		------------------------------
			01	2000	2999
			02	3000	3999
			03	4000	5999
			04	6000	8999
			05	9000	11999
			06	12000	14999
			07	15000	18999
			08	19000	23999
			09	24000	29999
			10	30000	100000
		------------------------------

	CREATE TABLE SAL_GRADE(
		GRADE CHAR(2),
		LSAL NUMBER(8, 2),
		HSAL NUMBER(8, 2),
		
		CONSTRAINT PK_SAL_GRADE PRIMARY KEY(GRADE)
	);

	INSERT INTO SAL_GRADE
		VALUES('01', 2000, 2999);

	INSERT INTO SAL_GRADE
		VALUES('02', 3000, 3999);

	INSERT INTO SAL_GRADE
		VALUES('03', 4000, 5999);

	INSERT INTO SAL_GRADE
		VALUES('04', 6000, 8999);

	INSERT INTO SAL_GRADE
		VALUES('05', 9000, 11999);

	INSERT INTO SAL_GRADE
		VALUES('06', 12000, 14999);

	INSERT INTO SAL_GRADE
		VALUES('07', 15000, 18999);

	INSERT INTO SAL_GRADE
		VALUES('08', 19000, 23999);

	INSERT INTO SAL_GRADE
		VALUES('09', 24000, 29999);

	INSERT INTO SAL_GRADE
		VALUES('10', 30000, 100000);

	COMMIT;

2. NON-EQUI JOIN
	- �������ǿ� ���� �����ڰ� '='�� �ƴ� ���� ����
	- IN, ANY, SOME ���� �ַ� ���

	��� ��)
		������̺� ( EMPLOYEES ) �� �޿�������̺� ( SAL_GRADE )�� ����Ͽ�
		60�� �μ��� ���� ������� �޿��� ����� ��ȸ�Ͻÿ�.
		Alias�� �����ȣ, �����, �޿�, ����̴�.
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.SALARY AS �޿�,
					TO_NUMBER(B.GRADE) AS ���
				FROM EMPLOYEES A,
					SAL_GRADE B
				WHERE A.SALARY BETWEEN B.LSAL AND B.HSAL
					AND A.DEPARTMENT_ID = 60
				ORDER BY A.EMPLOYEE_ID;

	��� ��)
		������̺� ( EMPLOYEES ) ����  ��� �޿����� ���� �޿��� ���޹޴� ��������� ��ȸ�Ͻÿ�.
		Alias�� �����ȣ, �����, �޿�, �μ���, ��å�̴�.
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.SALARY AS �޿�,
					D.SAL AS ��ձ޿�,
					B.DEPARTMENT_NAME AS �μ���,
					C.JOB_TITLE AS ��å
				FROM EMPLOYEES A,
					DEPARTMENTS B,
					JOBS C,
					(
						SELECT ROUND(AVG(SALARY)) AS SAL
							FROM EMPLOYEES
					) D
				WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
					AND A.JOB_ID = C.JOB_ID
					AND A.SALARY >= D.SAL
				ORDER BY A.EMPLOYEE_ID;

			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.SALARY AS �޿�,
					B.DEPARTMENT_NAME AS �μ���,
					C.JOB_TITLE AS ��å
				FROM EMPLOYEES A,
					DEPARTMENTS B,
					JOBS C
				WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
					AND A.JOB_ID = C.JOB_ID
					AND A.SALARY >= (
							SELECT ROUND(AVG(SALARY))
								FROM EMPLOYEES
						)
				ORDER BY A.EMPLOYEE_ID;

			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.SALARY AS �޿�,
					ROUND(AVG(A.SALARY) OVER()) AS ��ձ޿�,
					B.DEPARTMENT_NAME AS �μ���,
					C.JOB_TITLE AS ��å
				FROM EMPLOYEES A,
					DEPARTMENTS B,
					JOBS C
				WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
					AND A.JOB_ID = C.JOB_ID
				ORDER BY A.EMPLOYEE_ID;










