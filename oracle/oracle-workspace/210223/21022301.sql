2021-02-23-01) ������ �Լ�

4. MOD, REMAINDER
	- ������ ���� ��ȯ

	1) MOD(c, n)
		. �־��� �� c�� n���� ���� ������ ��ȯ
		. Java ����� % �����ڿ� ���� ���

		��� ��)
			2000�� 2�� 23���� ���� �������� ���Ͻÿ�.
				SELECT CASE MOD(TO_DATE('20000223') - TO_DATE('00010101') - 1, 7)
							WHEN 1
								THEN '������'
							WHEN 2
								THEN 'ȭ����'
							WHEN 3
								THEN '������'
							WHEN 4
								THEN '�����'
							WHEN 5
								THEN '�ݿ���'
							WHEN 6
								THEN '�����'
							ELSE '�Ͽ���'
						END AS ����
					FROM DUAL;

		��� ��)
			������ ���� �������� ���Ͻÿ�.
				SELECT CASE MOD(TRUNC(SYSDATE) - TO_DATE('00010101') - 1, 7)
							WHEN 1
								THEN '������'
							WHEN 2
								THEN 'ȭ����'
							WHEN 3
								THEN '������'
							WHEN 4
								THEN '�����'
							WHEN 5
								THEN '�ݿ���'
							WHEN 6
								THEN '�����'
							ELSE '�Ͽ���'
						END AS ����,
						TRUNC(SYSDATE) - TO_DATE('00010101') AS �ϼ�
					FROM DUAL;

	2) REMAINDER(c, n)
		. c�� n���� ���� ������ ��ȯ
		. ���������� MODS�� �ٸ� ������� ó���Ͽ� �ٸ� ��� ��ȯ
		. MOD
			������ = c - FLOOR(c / n) * n
		. REMAINDER
			������ = c - ROUND(c / n) * n

		��)
			13 / 5�� ������
			1) MOD
			13 - FLOOR(13 / 5) * 5
			13 - FLOOR(2.6) * 5
			13 - 2 * 5
			3

	2) REMAINDER
		13 - ROUND(13 / 5) * 5
		13 - ROUND(2.6) * 5
		13 - 3 * 5
		-2

		SELECT MOD(13, 5),
				REMAINDER(13, 5)
			FROM DUAL;

		��)
			11 / 5�� ������

			1) MOD
				11 - FLOOR(11 / 5) * 5
				11 - FLOOR(2.2) * 5
				11 - 2 * 5
				1

			2) REMAINDER
				11 - ROUND(11 / 5) * 5
				11 - ROUND(2.2) * 5
				13 - 2 * 5
				1

			SELECT MOD(11, 5),
					REMAINDER(11, 5)
				FROM DUAL;

5. CEIL(n), FLOOR(n)
	- �־��� �� n�� ���� ������ ������ ��ȯ
	- CEIL�� n�� ���ų� ū �� �� ���� ���� ����
	- FLOOR�� n�� ���ų� ���� �� �� ���� ū ����

	ex)
		CEIL(23.56) �� 24
		CEIL(-23.56) �� -23
		FLOOR(23.56) �� 23
		FLOOR(-23.56) �� -24

6. WIDTH_BUCKET
	- �־��� �ּڰ��� �ִ��� �� ���� �׷����� ������ ���õ� ���� ��� �׷쿡 ���ϴ� �� ��ȯ

	��� ����
		WIDTH_BUCKET(c, min, max, b)
		. c : �־��� ��
		. min : ������ ���Ѱ�
		. max : ������ ���Ѱ�
		. b : ���� ������ ����

	��� ��)
		������̺��� ����� �޿��� ���� ����� ���Ͽ� ����Ͻÿ�.
		�޿��� 2000���� 14000���� 6�� ������� ������,
		�޿��� ���� ����� ���� ����� �ο��޵��� �Ͻÿ�.
		Alias�� �����ȣ, �����, �޿�, ���
			SELECT EMPLOYEE_ID AS �����ȣ,
					EMP_NAME AS �����,
					SALARY AS �޿�,
					6 - WIDTH_BUCKET(SALARY, 2000, 14000, 6) + 1 || '���' AS ���
				FROM EMPLOYEES
				WHERE 2000 <= SALARY
					AND SALARY < 14000;

			SELECT EMPLOYEE_ID AS �����ȣ,
					EMP_NAME AS �����,
					SALARY AS �޿�,
					WIDTH_BUCKET(SALARY, 14000, 2000, 6) || '���' AS ���
				FROM EMPLOYEES
				WHERE 2000 < SALARY
					AND SALARY <= 14000;

	��)
		ȸ�����̺��� ȸ������ ���ϸ����� �������� ����� ���ϰ�,
		1 ~ 2��� ȸ���� 'VIP ȸ��'
		3 ~ 5��� ȸ���� '�Ϲ�ȸ��'
		�� ���ϴ� '��ȸ��'�� ������ ����Ͻÿ�.
		��, ������ ���ϸ��� ���� 500���� 8000���� 8�� �������� ������ ���ϸ����� ���� ȸ���� ����� ���� ���� ��Ÿ������ �Ѵ�.
		Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ���, ���
			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					MEM_MILEAGE AS ���ϸ���,
					8 - WIDTH_BUCKET(MEM_MILEAGE, 500, 8000, 8) + 1 AS ���,
					CASE
						WHEN 8 - WIDTH_BUCKET(MEM_MILEAGE, 500, 8000, 8) + 1 BETWEEN 0 AND 2
							THEN 'VIP ȸ��'
						WHEN 8 - WIDTH_BUCKET(MEM_MILEAGE, 500, 8000, 8) + 1 BETWEEN 3 AND 5
							THEN '�Ϲ�ȸ��'
						ELSE '��ȸ��'
					END AS ���
			FROM MEMBER
			ORDER BY MEM_MILEAGE DESC;