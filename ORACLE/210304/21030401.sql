2021-03-04-01)

3. SELF JOIN
	- �ϳ��� ���̺� 2 �� �̻��� ���̺� ��Ī�� �ο��Ͽ� ���� �ٸ� ���̺�� �����Ͽ� JOIN ���� ����

	��� ��)
		ȸ�� ���̺��� ������ '�ֺ�'�� ȸ������ ��� ���ϸ������� ���� ���ϸ����� ������ ȸ���� ��ȸ�Ͻÿ�.
		Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
			SELECT A.MEM_ID AS ȸ����ȣ,
					A.MEM_NAME AS ȸ����,
					A.MEM_JOB AS ����,
					C.JUBUMILEAGE AS �ֺθ��ϸ���,
					A.MEM_MILEAGE AS ���ϸ���
				FROM MEMBER A,
					(
						SELECT AVG(B.MEM_MILEAGE) AS JUBUMILEAGE
							FROM MEMBER B
							WHERE MEM_JOB = '�ֺ�'
					) C
				WHERE A.MEM_MILEAGE >= C.JUBUMILEAGE;

	��� ��)
		��� ���̺��� ��å�� ���������� ( SA_MAN )�� 145�� ������� ���� �޿��� ���� �޴� ����� ��ȸ�Ͻÿ�.
		Alias�� �����ȣ, �����, �Ի���, ��å�ڵ�, �޿�
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					A.HIRE_DATE AS �Ի���,
					A.JOB_ID AS ��å�ڵ�,
					A.SALARY AS �޿�
				FROM EMPLOYEES A,
					(
						SELECT B.SALARY AS SA_MAN_145_SALARY
							FROM EMPLOYEES B
							WHERE JOB_ID = 'SA_MAN'
								AND B.EMPLOYEE_ID = 145
					) C
				WHERE A.SALARY > C.SA_MAN_145_SALARY
				ORDER BY A.EMPLOYEE_ID;