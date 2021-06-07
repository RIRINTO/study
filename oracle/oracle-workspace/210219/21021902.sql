2021-02-19-02) �Լ� ( FUNCTION )

	- �̸� �����Ͽ� �������� ���డ���� ���
	- �Լ��� ��ø ����� ����
	- ������ �Լ�
		���̺� ����� ���� ���� ������� �Լ��� �����Ͽ� �ϳ��� ����� ��ȯ
	- ������ �Լ�
		���� ���� �׷�ȭ�Ͽ� ����� ó���� �� �ϳ��� ����� ��ȯ�ϴ� �Լ�.
		�׷��Լ� ( SUM, AVG, COUNT, MIN, MAX �� )

1. ���ڿ� �Լ�
	1) ���ڿ� ���� ������
		- '||' ( �ڹ��� ���ڿ� ���տ����� '+'�� ���� ��� )
		- ���ڿ� ���� �Լ� CONCAT()�� ���� ���

		��� ����
			���ڿ� || ���ڿ�

		��� ��)
			ȸ�� ���̺��� ����ȸ���̸鼭 ���ϸ����� 2000 �̻� ������ ȸ���� ��ȸ�Ͻÿ�.
			��, �ֹι�ȣ�� 'XXXXXX-XXXXXXX'�������� ����Ͻÿ�.
			Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���
				SELECT MEM_ID AS ȸ����ȣ,
						MEM_NAME AS ȸ����,
						MEM_REGNO1 || '-' || MEM_REGNO2 AS �ֹι�ȣ,
						MEM_MILEAGE AS ���ϸ���
					FROM MEMBER
					WHERE SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3')
						AND MEM_MILEAGE >= 2000;

	2) CONCAT
		- �־��� �� ���ڿ��� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ
		- '||'�� ���� ���

		��� ����
			CONCAT(S1, S2)

		��� ��)
			ȸ�� ���̺��� ����ȸ���̸鼭 ���ϸ����� 2000 �̻� ������ ȸ���� ��ȸ�Ͻÿ�.
			��, �ֹι�ȣ�� 'XXXXXX-XXXXXXX'�������� ����Ͻÿ�.
			Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���
				SELECT MEM_ID AS ȸ����ȣ,
						MEM_NAME AS ȸ����,
						CONCAT(CONCAT(MEM_REGNO1, '-'), MEM_REGNO2) AS �ֹι�ȣ,
						MEM_MILEAGE AS ���ϸ���
					FROM MEMBER
					WHERE SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3')
						AND MEM_MILEAGE >= 2000;

	3) LOWER, UPPER, INITCAP
		- 'LOWER' : �־��� ���ڿ� ���� �ڷ� �� �빮�ڸ� ��� �ҹ��ڷ� ��ȯ
		- 'UPPER' : �־��� ���ڿ� ���� �ڷ� �� �ҹ��ڸ� ��� �빮�ڷ� ��ȯ
		- 'INITCAP' : �־��� ���ڿ� ���� �ڷ� �� �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ

		��� ��)
			��ǰ���̺� ( PROD ) ���� �з��ڵ尡 'p201'�� ���� �ڷḦ ��ȸ�Ͻÿ�.
			Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �ǸŰ���
				SELECT PROD_ID AS ��ǰ�ڵ�,
						PROD_NAME AS ��ǰ��,
						PROD_LGU AS �з��ڵ�,
						PROD_SALE AS �ǸŰ���
					FROM PROD
					WHERE LOWER(PROD_LGU) = 'p201';
--					WHERE PROD_LGU = UPPER('p201');

		��� ��)
			��� ���̺��� EMAIL �÷��� ���� �ҹ��ڷ� ��ȯ�Ͻÿ�
			SELECT EMPLOYEE_ID,
					EMP_NAME,
					LOWER(EMAIL),
					INITCAP(EMAIL)
				FROM EMPLOYEES;

	4) LPAD(c1, n[, c2]), RPAD(c1, n[, c2])
		- ������ ���� n��ŭ Ȯ���Ͽ� c1�� ä��� ���� ���� ( ���� : LPAD, ������ : RPAD ) �� c2�� ä��
		- c2�� �����Ǹ� �������� ä��

		��� ��)
			��ǰ ���̺��� ��ǰ���� 30����Ʈ�� ����ϵ� ���� ��ﰣ(������)�� '^' ���ڸ� �����Ͽ� ����Ͻÿ�.
				SELECT PROD_ID,
						RPAD(PROD_NAME, 30, '^') AS ��ǰ��1,
						LPAD(PROD_NAME, 30, '^') AS ��ǰ��2
					FROM PROD
					WHERE ROWNUM <= 10;

		��� ��)
			��ǰ���̺��� �з��ڵ� 'p101'�� ���� ��ǰ ������ ����Ͻÿ�.
			��, �ݾ��� 3�ڸ����� �ڸ��� ( ',' ) �� �����ϰ� 15�ڸ��� ����� ��
			Alias�� ��ǰ��, ���԰���, ���Ⱑ��, �ŷ�ó�ڵ�
				SELECT PROD_NAME AS ��ǰ��,
						LPAD(TO_CHAR(PROD_COST, '9,999,999'), 15) AS ���԰���,
						TO_CHAR(PROD_PRICE, '999,999,999') AS ���Ⱑ��,
						PROD_BUYER AS �ŷ�ó�ڵ�
					FROM PROD
					WHERE LOWER(PROD_LGU) = 'p101';

	5) LTRIM(c1 [, c2]), RTRIM(c1 [, c2]), TRIM(c1)
		- �־��� ���ڿ� �ڷ� c1���� ���ʿ��� ( LTRIM ) �Ǵ� �����ʿ��� ( RTRIM ) c2�� ã�� ����
		- c2�� �����Ǹ� ������ ã�� ����
		- TRIM�� ������ ������ ��� ����
		- ��, �ܾ� ���� ( ���ڿ� ���� ) �� ������ ������ �� ���� ( REPLACE �Լ� ��� )

		��)
			������̺��� ����� ( EMP_NAME ) �� ������ Ÿ���� VARCHAR2���� CHAR�� �����Ͻÿ�.
			ALTER TABLE EMPLOYEES
					MODIFY(EMP_NAME CHAR(80));
					SELECT EMP_NAME
				FROM EMPLOYEES;

			SELECT RTRIM(EMP_NAME)
				FROM EMPLOYEES;

			ALTER TABLE EMPLOYEES
				MODIFY(EMP_NAME VARCHAR(80));

			UPDATE EMPLOYEES
				SET EMP_NAME = TRIM(EMP_NAME);

			COMMIT;

		��� ��)
			��ǰ ���̺��� ��ǰ�� �� '����'�̶�� ���ڿ��� ���ʿ��� ã�� �����Ͻÿ�.
				SELECT PROD_ID AS ��ǰ�ڵ�,
						PROD_NAME AS ��ǰ��,
						LTRIM(PROD_NAME, '����') AS ��ǰ��2,
						LTRIM(LTRIM(PROD_NAME, '����')) AS ��ǰ��3,
						RTRIM(PROD_NAME, '���� 1') AS ��ǰ��4
					FROM PROD;