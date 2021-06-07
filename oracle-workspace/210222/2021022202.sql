2021-02-22-02) ������ �Լ�

1. ������ �Լ� ( ABS, SIGN, POWER, SQRT, ... �� )
	. ABS(n) : n�� ���밪
	. SIGN(n) : n�� ��ȣ ( ���� : -1, ��� : 1, 0 : 0 )
	. POWER(n, e) : n�� e��
	. SQRT(n) : n�� ���� ( root �� )

	��� ��)
		SELECT ABS(-100),
				ABS(0.000001),
				SIGN(10000000),
				SIGN(-10000000),
				SIGN(0.0000001),
				SIGN(-0.0000001),
				SIGN(0),
				POWER(2, 10),
				SQRT(1024)
			FROM DUAL;

2. GREATEST, LEAST
	. �־��� �ڷ� �� �ִ밪�� �ּҰ��� ����

	��� ����
		GREATEST(n1, n2, ...) : n1, n2, ... �� �ִ� ��ȯ
		LEAST(n1, n2, ...) : n1, n2, ... �� �ּڰ� ��ȯ

	��)
		SELECT GREATEST(20, 40, 5, 70),
		LEAST(20, 40, 5, 70)
		FROM DUAL;

	��)
		ȸ�� ���̺��� ȸ������ ������ ���ϸ����� ��ȸ�Ͽ� 1000 �̸��� ȸ������ ���ϸ����� 1000���� ����ÿ�.
		Alias�� ȸ����ȣ, ȸ����, ���� ���ϸ���, ���� ���ϸ���
			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					MEM_MILEAGE AS "���� ���ϸ���",
					GREATEST(MEM_MILEAGE, 1000) AS "���� ���ϸ���"
				FROM MEMBER;

	** ȸ�� ���̺��� �ִ� ���ϸ����� ���Ͻÿ�.

		SELECT MEM_NAME,
				MEM_MILEAGE
			FROM MEMBER
			WHERE MEM_MILEAGE = (
						SELECT MAX(MEM_MILEAGE) FROM MEMBER
					);

		SELECT MEM_NAME AS ȸ����,
				MEM_MILEAGE AS ���ϸ���
			FROM (
					SELECT MAX(MEM_MILEAGE) AS MILE_MAX FROM MEMBER
				) A,
				MEMBER B
			WHERE A.MILE_MAX = B.MEM_MILEAGE;

3. ROUND, TRUNC
	. �־��� �����ڷḦ �ݿø� ( ROUND ) �Ǵ� �ڸ����� ( TRUNC ) ���� �� ����� ��ȯ

	��� ����
		ROUND(n[, i])
			i�� ����̸� �־��� �ڷ� n���� �Ҽ��� ���� i + 1��° �ڸ����� �ݿø��Ͽ� i���� ������ ��ȯ
			i�� �����̸� �־��� �ڷ� n���� �������� i��° �ڸ����� �ݿø��Ͽ� ��� ��ȯ
			i�� �����Ǹ� 0���� ����
		TRUNC(n[, i])
			i�� ����̸� �־��� �ڷ� n���� �Ҽ��� ���� i + 1��° �ڸ����� �����Ͽ� i��° ������ ��ȯ
			i�� �����̸� �־��� �ڷ� n���� �������� i��° �ڸ����� �����Ͽ� ��� ��ȯ
			i�� �����Ǹ� 0���� ����

	��)
		��� ���̺��� �ڷḦ �̿��Ͽ� �̹� �� �޿��� ��ȸ�Ͻÿ�.
			. �̹� �޿� ���ʽ��� ���� ��
			. ���ʽ� = �޿� * 0.13
			. ���޾� = ���� + ���ʽ�
		Alias�� �����ȣ, �����, ����, ���ʽ�, ���޾��̴�.
		��, ���ʽ� �� ���޾��� �Ҽ� ù �ڸ����� ��Ÿ���ÿ�. ( �Ҽ��� ���� 2��° �ڸ����� �ݿø� )
			SELECT EMPLOYEE_ID AS �����ȣ,
					EMP_NAME AS �����,
					SALARY AS ����,
					SALARY * 0.13 AS ���ʽ�1,
					ROUND(SALARY * 0.13, 1) AS ���ʽ�2,
					ROUND(SALARY * 1.13, 1) AS ���޾�
				FROM EMPLOYEES;

	��)
		��� ���̺��� �ڷḦ �̿��Ͽ� �̹� �� �޿��� ��ȸ�Ͻÿ�.
			. �̹� �޿� ���ʽ��� ���� ��
			. ���ʽ� = �޿� * 0.13
			. ���޾� = ���� + ���ʽ�
		Alias�� �����ȣ, �����, ����, ���ʽ�, ���޾��̴�.
		��, ���ʽ� �� ���޾��� 10�� �ڸ����� ��Ÿ���ÿ�. ( 1�� �ڸ����� �ݿø� )
			SELECT EMPLOYEE_ID AS �����ȣ,
					EMP_NAME AS �����,
					SALARY AS ����,
					SALARY * 0.13 AS ���ʽ�1,
					ROUND(SALARY * 0.13, -1) AS ���ʽ�2,
					ROUND(SALARY * 1.13, -1) AS ���޾�
				FROM EMPLOYEES;

	��)
		��� ���̺��� �ڷḦ �̿��Ͽ� �̹� �� �޿��� ��ȸ�Ͻÿ�.
			. �̹� �޿� ���ʽ��� ���� ��
			. ���ʽ� = �޿� * 0.13
			. ���޾� = ���� + ���ʽ�
		Alias�� �����ȣ, �����, ����, ���ʽ�, ���޾��̴�.
		��, ���ʽ� �� ���޾��� �Ҽ� ù �ڸ����� ��Ÿ���ÿ�. ( �Ҽ��� ���� 2��° �ڸ����� ���� )
			SELECT EMPLOYEE_ID AS �����ȣ,
					EMP_NAME AS �����,
					SALARY AS ����,
					SALARY * 0.13 AS ���ʽ�1,
					TRUNC(SALARY * 0.13, 1) AS ���ʽ�2,
					TRUNC(SALARY * 1.13, 1) AS ���޾�
				FROM EMPLOYEES;

	��)
		��� ���̺��� �ڷḦ �̿��Ͽ� �̹� �� �޿��� ��ȸ�Ͻÿ�.
			. �̹� �޿� ���ʽ��� ���� ��
			. ���ʽ� = �޿� * 0.13
			. ���޾� = ���� + ���ʽ�
		Alias�� �����ȣ, �����, ����, ���ʽ�, ���޾��̴�.
		��, ���ʽ� �� ���޾��� 10�� �ڸ����� ��Ÿ���ÿ�. ( 1�� �ڸ����� ���� )
			SELECT EMPLOYEE_ID AS �����ȣ,
					EMP_NAME AS �����,
					SALARY AS ����,
					SALARY * 0.13 AS ���ʽ�1,
					TRUNC(SALARY * 0.13, -1) AS ���ʽ�2,
					TRUNC(SALARY * 1.13, -1) AS ���޾�
				FROM EMPLOYEES;

UPDATE EMPLOYEES
	SET SALARY = SALARY * 1.13;

COMMIT;