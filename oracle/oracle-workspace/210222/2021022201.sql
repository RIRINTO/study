2021-02-22-01) ���ڿ� �Լ� ..cont
	6) SUBSTR
		- ���� ���ڿ����� ���ǵ� ���̸�ŭ�� �κй��ڿ��� ������
		- ����� ���ڿ���

		��� ����
			SUBSTR(c, n[, len])

		. �־��� ���ڿ� c �� n��°���� len�� ������ŭ ���ڿ��� �����Ͽ� ��ȯ
		. n�� 0 �Ǵ� 1�̸� ù ��° ���ں��� ó��
		. n�� �����̸� ���ڸ����� ó��
		. len�� �����Ǹ� n�ڸ� ���� ��� ���ڿ� ��ȯ

		��� ��)
			��ٱ��� ���̺��� 2005�� 7�� �Ǹ��ڷḦ ��ȸ�Ͻÿ�.
			Alias�� �Ǹ�����, ������, ��ǰ��, ����
				SELECT TO_DATE(SUBSTR(C.CART_NO, 1, 8)) AS �Ǹ�����,
						M.MEM_NAME AS ������,
						P.PROD_NAME AS ��ǰ��,
						C.CART_QTY AS ����
					FROM CART C, MEMBER M, PROD P
					WHERE C.CART_PROD = P.PROD_ID
						AND C.CART_MEMBER = M.MEM_ID
						AND SUBSTR(C.CART_NO, 1, 6) = '200507';

		��� ��)
			������̺� ( EMPLOYEES ) ���� �ǸŰ��� ��å ( SALES)�� �ο����� ��������� ��ȸ�Ͻÿ�.
			Alias�� �����ȣ, �����, �μ���, ��å�ڵ�, �޿��̴�.
				SELECT E.EMPLOYEE_ID AS �����ȣ,
						E.EMP_NAME AS �����,
						D.DEPARTMENT_NAME AS �μ���,
						E.JOB_ID AS ��å�ڵ�,
						E.SALARY AS �޿�
					FROM EMPLOYEES E, DEPARTMENTS D
					WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
						AND SUBSTR(JOB_ID, 1, 2) = 'SA'
					ORDER BY E.SALARY DESC;

		���� 1)
			ȸ�� ���̺��� �达 ���� ���� ȸ�������� ����Ͻÿ�.
			Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ����̴�.
			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					CASE
						WHEN SUBSTR(MEM_REGNO2, 1, 1) IN('1', '3')
							THEN '����ȸ��'
						ELSE '����ȸ��'
					END AS ����,
					MEM_MILEAGE AS ���ϸ���
				FROM MEMBER
				WHERE SUBSTR(MEM_NAME, 1, 1) = '��';
--				WHERE MEM_NAME LIKE '��%';

	7) REPLACE
		- Ư�� ���ڿ��� ã�� �ٸ� ���ڿ��� ��ġ��Ŵ

		��� ����
			REPLACE(c1, c2[, c3])

		. �־��� ���ڿ� c1���� c2 ���ڿ��� ��� ã�� c3 ���ڿ��� ��ġ
		. c3�� �����Ǹ� ã�� ���ڿ��� ���� �� ( ���ڿ� ������ ���� ���ſ� ��� )

		��� ��)
			SELECT ' ILPOSTINO BOYHOOD' AS NORMAL,
					TRIM(' ILPOSTINO BOYHOOD') AS TRIM,
					REPLACE(' ILPOSTINO BOYHOOD', ' ') AS REPLACE,
					REPLACE(' ILPOSTINO BOYHOOD', ' ', '*') AS REPLACE
				FROM DUAL;

		����)
			��� ���̺��� ��ȭ��ȣ�� xxx-xxx-xxxx �������� ����Ͻÿ�.
			��, 2005�� ���� �Ի��� ����� ������� �Ѵ�.
			Alias�� �����ȣ, �����, ��ȭ��ȣ, ����̴�.
			���� '������', '����' �� �ϳ��� ����� ��
				SELECT EMPLOYEE_ID AS �����ȣ,
						EMP_NAME AS �����,
						REPLACE(PHONE_NUMBER, '.', '-') AS ��ȭ��ȣ,
						CASE
							WHEN RETIRE_DATE IS NULL
								THEN '������'
							ELSE '����'
						END AS ���
					FROM EMPLOYEES
					WHERE HIRE_DATE >= TO_DATE('20050101')
--					WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2005
					ORDER BY HIRE_DATE;
--					ORDER BY EMPLOYEE_ID;

	8) INSTR
		- ���ڿ����� Ư�� ���ڿ��� ��ġ�� ( INDEX ) �� ��ȯ

		��� ����
			INSTR(c1, c2[, m[, n]])

		. �־��� ���ڿ� c1���� c2 ���ڿ��� ó�� ������ ��ġ ��ȯ
		. m�� �˻��� Ư�� ��ġ�� ������ �� ���Ǵ� INDEX
		. n�� �ݺ��Ǿ� ǥ���� ���ڿ� �� �ݺ��� Ƚ���� Ư���Ͽ� �˻��� �� ���

		��� ��)
			SELECT EMP_NAME,
					INSTR(EMP_NAME, 'o'),
					INSTR(EMP_NAME, 'o', 3),
					INSTR(EMP_NAME, 'o', 2, 2)
				FROM  EMPLOYEES
				WHERE DEPARTMENT_ID = 50;

	9) LENGTH, LENGTHB
		- ���ڿ��� ���̳� ���ڿ� ���� ������ ���� ��ȯ

		��� ����
			LENGTH(c), LENGTHB(c)

		. LENGTH(c) : c ���ڿ� ���� ������ ��
		. LENGTHB(c) : c ���ڿ��� ���� ( byte �� )
		. �ѱ� �� ���ڴ� 3byte�� ǥ�� ��