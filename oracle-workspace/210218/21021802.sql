2021-02-18-02) ������
	- ��Ģ������ ( +, -, /, * )
	- ������ ���� MOD()�� REMAINDER() �Լ��� ����
	- ���迬���� ( >, >=, <, <=, =, !=(<>) )
	- �������� ( AND, OR, NOT )
1. ��Ÿ������
	1) IN ������
		- �־��� �� �� ��� �ϳ��� ��ġ�ϸ� ��ü�� �� ( TRUE ) �� �Ǵ� ������
		- OR �����ڷ� �ٲپ� �� �� �ִ�.

		��� ����
			�÷��� IN ( ��1, ��2, ..., ��n )

		. WHERE ���� ���� ������ ���

		��� ��)
			��� ���̺��� �μ��� 60, 40, 20 �� �μ��� ���� ��������� ��ȸ�Ͻÿ�.
			Alias�� �����ȣ, �����, �μ���ȣ, �Ի����̴�.

				SELECT EMPLOYEE_ID AS �����ȣ,
						EMP_NAME AS �����,
						DEPARTMENT_ID AS �μ���ȣ,
						HIRE_DATE AS �Ի���
					FROM EMPLOYEES
--					WHERE DEPARTMENT_ID IN (60, 40, 20)
					WHERE DEPARTMENT_ID = 60
						OR DEPARTMENT_ID = 40
						OR DEPARTMENT_ID = 20
					ORDER BY 3;

	2) ANY ( SOME ) ������
		- ����� IN �����ڿ� ������

		��� ����
			�÷��� ���迬����ANY|SOME (��1, ��2, ..., ��n)

		��� ��)
			��� ���̺��� �μ��� 60, 40, 20 �� �μ��� ���� ��������� ��ȸ�Ͻÿ�.
			Alias�� �����ȣ, �����, �μ���ȣ, �Ի����̴�.

				SELECT EMPLOYEE_ID AS �����ȣ,
						EMP_NAME AS �����,
						DEPARTMENT_ID AS �μ���ȣ,
						HIRE_DATE AS �Ի���
					FROM EMPLOYEES
--					WHERE DEPARTMENT_ID = ANY (60, 40, 20)
					WHERE DEPARTMENT_ID = SOME (60, 40, 20)
					ORDER BY 3;

	3) BETWEEN ������
		- ������ �����Ͽ� ���� �� ���
		- AND �����ڷ� ��ȯ ����

		��� ����
			�÷��� BETWEEN A AND B

		. �÷��� ����� ���� ������ A ~ B ���� ���̸� �� ( TRUE ) ��ȯ

		��)
			�������̺� ( BUYPROD ) ���� 2005�� 2�� 5�Ϻ��� 16�� ���̿� �԰�� ��ǰ������ ��ȸ�Ͻÿ�.
			Alias�� ��¥, ��ǰ�ڵ�, ����, �ܰ�, �ݾ��̴�.
				SELECT BUY_DATE AS ��¥,
						BUY_PROD AS ��ǰ�ڵ�,
						BUY_QTY AS ����,
						BUY_COST AS �ܰ�,
						BUY_QTY * BUY_COST AS �ݾ�
					FROM BUYPROD
					WHERE BUY_DATE BETWEEN '20050205' AND '20050216';

		����]
			ȸ�����̺��� 40�� ����ȸ���� ���� ���ϸ����� ��ȸ�Ͻÿ�.
				SELECT MEM_ID AS ȸ����ȣ,
						MEM_NAME AS �̸�,
						MEM_BIR AS ����,
						TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE), 1, 4)) - (1900 + TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))) + 1 AS ����,
						MEM_MILEAGE AS ���ϸ���
					FROM MEMBER
					WHERE SUBSTR(MEM_REGNO2, 1, 1) = ANY (2, 4)
						AND TO_NUMBER(SUBSTR(TO_CHAR(SYSDATE), 1, 4)) - (1900 + TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))) + 1 BETWEEN 40 AND 49;