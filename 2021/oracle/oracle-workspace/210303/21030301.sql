2021-03-03-01)

** NULL ó�� �Լ�
	1) IS[ NOT] NULL
		- Ư�� �÷��� ���� NULL���� �Ǵ�
		- NULL�� '=' ��ȣ�� �Ǵܵ� �� ����
		
		��� ����
			�÷��� IS[ NOT] NULL
		
		��� ��)
			��� ���̺��� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ� ��������� ��ȸ�Ͻÿ�.
				SELECT A.EMPLOYEE_ID AS �����ȣ,
						A.EMP_NAME AS �����,
						B.DEPARTMENT_NAME AS �μ���,
						A.COMMISSION_PCT AS ��������,
						A.SALARY AS �޿�
					FROM EMPLOYEES A,
						DEPARTMENTS B
					WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
						AND A.COMMISSION_PCT IS NULL
					ORDER BY A.EMPLOYEE_ID;

	2) NVL(c, val)
		- NULL ó�� �Լ� �� ���� �θ� ���
		- c �÷��� ���� NULL�̸� val ���� ��ȯ�ϰ�, NULL�� �ƴϸ� �ڽ��� ���� ��ȯ
		- �ַ� ����Ŀ� ��� ��
		- c�� val�� ������ Ÿ���� ���ƾ� ��
		
		��� ��)
			��� ���̺��� ���� ������ ���� ���ʽ��� ����ϰ�, �̹� �� ���޾��� ��ȸ�Ͻÿ�.
			���ʽ� = �޿� * ��������
			���޾� = �޿� + ���ʽ�
			Alias�� �����ȣ, �̸�, �μ���, ����, ��������, ���ʽ�, ���޾��̴�.
				SELECT A.EMPLOYEE_ID AS �����ȣ,
						A.EMP_NAME AS �̸�,
						B.DEPARTMENT_NAME AS �μ���,
						A.SALARY AS ����,
						NVL(A.COMMISSION_PCT, 0) AS ��������,
						NVL(A.SALARY * A.COMMISSION_PCT, 0) AS ���ʽ�,
						NVL(A.SALARY * (1 + A.COMMISSION_PCT), 0) AS ���޾�
					FROM EMPLOYEES A,
						DEPARTMENTS B
					WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
					ORDER BY A.EMPLOYEE_ID;

	3) NVL2(c, val1, val2)
		- c�� ���� NULL�� �ƴϸ� val1��, NULL�̸� val2�� ���� ��ȯ
		- val1�� val2�� ���� ������Ÿ���̾�� ��

		��� ��)
			ȸ�� ���̺��� ȸ������ �ڵ��� ��ȣ�� ��ȸ�Ͻÿ�.
			�ڵ��� ��ȣ�� ������ '����ó ����'�� ����Ͻÿ�.
			Alias�� ȸ����ȣ, ȸ����, ����ó�̴�.
				**
					UPDATE MEMBER
						SET MEM_HP = NULL
						WHERE MEM_ID IN('d001', 'f001', 'r001', 'p001', 's001');

					COMMIT;

				SELECT MEM_ID AS ȸ����ȣ,
						MEM_NAME AS ȸ����,
						NVL2(MEM_HP, MEM_HP, '����ó ����') AS ����ó
					FROM MEMBER;

		��� ��)
			ȸ�� ���̺��� ȸ���� ���ϸ����� �˻��Ͽ�,
			NULL�� �ƴϸ� '����ȸ��',
			NULL�̸� '��Ȱ�� ȸ��'�� ����� ����Ͻÿ�.
			Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���, ���
				**
					UPDATE MEMBER
						SET MEM_MILEAGE=NULL
						WHERE MEM_ID IN('d001', 'f001', 'r001', 'p001', 's001');

				SELECT MEM_ID AS ȸ����ȣ,
						MEM_NAME AS ȸ����,
						MEM_JOB AS ����,
						MEM_MILEAGE AS ���ϸ���,
						NVL2(MEM_MILEAGE, '����ȸ��', '��Ȱ�� ȸ��') AS ���
					FROM MEMBER;

** �����Լ�

1. ROLLUP
	- GROUP BY ���� ���� ���Ǹ�, ������ �հ�� ��ü �հ踦 ��ȯ
	
	��� ����
		GROUP BY ROLLUP(�÷���1, �÷���2, ..)

	. ������ ������ ���� �÷����� �� + 1������
	. �÷��� ����� ���� �����ʿ��� ���� ���� �������� ����

	��� ��)
		���� �ܾ� ���̺�(KOR_LOAN_STATUS)���� 2011 ~ 2013���� �⵵��, ������ ���� �ܾ��� ���Ͻÿ�.
        Alias �⵵, ����, �����ܾ��հ�
			ROLLUP �̻��
				SELECT REGION AS ����,
						GUBUN AS ���ⱸ��,
						SUBSTR(PERIOD, 5) AS ��,
						SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
					FROM KOR_LOAN_STATUS
					WHERE SUBSTR(PERIOD, 1, 4) BETWEEN '2011' AND '2013'
					GROUP BY REGION,
						GUBUN,
						SUBSTR(PERIOD, 5)
					ORDER BY REGION,
						GUBUN,
						SUBSTR(PERIOD, 5);

			ROLLUP ���
				SELECT REGION AS ����,
						GUBUN AS ���ⱸ��,
						SUBSTR(PERIOD, 5) AS ��,
						SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
					FROM KOR_LOAN_STATUS
					WHERE SUBSTR(PERIOD, 1, 4) BETWEEN '2011' AND '2013'
					GROUP BY ROLLUP(REGION, GUBUN, SUBSTR(PERIOD, 5))
					ORDER BY REGION,
						GUBUN,
						SUBSTR(PERIOD, 5);

			�κ� ROLLUP
				SELECT REGION AS ����,
						GUBUN AS ���ⱸ��,
						SUBSTR(PERIOD, 5) AS ��,
						SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
					FROM KOR_LOAN_STATUS
					WHERE SUBSTR(PERIOD, 1, 4) BETWEEN '2011' AND '2013'
					GROUP BY REGION,
						ROLLUP(GUBUN, SUBSTR(PERIOD, 5))
					ORDER BY REGION,
						GUBUN,
						SUBSTR(PERIOD, 5);

2. CUBE
	- ROLLUP�� ��� ������ ����
	- CUBE ���� '()' �ȿ� ����� �÷��� ������ ��� ����� ����ŭ�� ������ �հ踦 ��ȯ
		n���� �÷��� ���� ���, 2�� n�� ������ �հ踦 ��ȯ

	��� ��)
		���� �ܾ� ���̺�(KOR_LOAN_STATUS)���� 2011 ~ 2013���� �⵵��, ������ ���� �ܾ��� ���Ͻÿ�.
        Alias �⵵, ����, �����ܾ��հ�
			SELECT SUBSTR(PERIOD, 5) AS ��,
					REGION AS ����,
					SUM(LOAN_JAN_AMT) AS �����ܾ��հ�
				FROM KOR_LOAN_STATUS
				WHERE SUBSTR(PERIOD, 1, 4) BETWEEN '2011' AND '2013'
				GROUP BY CUBE(SUBSTR(PERIOD, 5), REGION)
				ORDER BY SUBSTR(PERIOD, 5),
					REGION;