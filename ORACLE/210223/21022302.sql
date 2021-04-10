2021-02-23-02) ��¥ �Լ�

1. SYSDATE
	- SYSTEM���� �����ϴ� ��¥ ( ��, ��, �� ) �� �ð� ( ��, ��, �� ) ������ ��ȯ
	- ������ ���� ����� ����� ��
		���� ����� ��¥�� ��

	��� ��)
		SELECT SYSDATE,
				SYSDATE + 25,
				SYSDATE - 25,
				SYSDATE - TO_DATE('20200223'),
				TRUNC(SYSDATE) - TO_DATE('20200223')
			FROM DUAL;

2. ADD_MONTHS(d, n)
	- �־��� ���ڵ�����  d�� n������ ���� ��¥ ��ȯ

	��)
		SELECT ADD_MONTHS(SYSDATE, 10) + 10
			FROM DUAL;

3. NEXT_DAY(d, c)
	- �־��� ��¥ ������ d ���� ù ��° c������ ��¥ ��ȯ.
	- c�� '������' �Ǵ� '��' ������ ��� ( ������ ȯ�漳������ MONDAY ���� ��� �Ұ� )

��)
	SELECT NEXT_DAY(SYSDATE, '��'),
			NEXT_DAY(SYSDATE, '�Ͽ���'),
			NEXT_DAY(SYSDATE, 'ȭ'),
			NEXT_DAY(SYSDATE, '�ݿ���')
		FROM DUAL;

4. LAST_DAY(d)
	- �־��� ���� ������ d���� �ش� ���� ������ ��¥ ��ȯ

	��� ��)
		SELECT LAST_DAY(TO_DATE('20070210'))
			FROM DUAL;

5. EXTRTACT(fmt FROM d)
	- �־��� ��¥ ������ d���� fmt�� ���ǵ� ����� ��ȯ
	- fmt�� YEAR, MONTH, DAY, HOUR, MINUTE, SECOND�̸�, ���ڷ� ���

	��� ��)
		ȸ�� ���̺��� ȸ������ ��������� �������� �Ͽ� ���Ͽ� ���� ���ڸ� �����Ϸ� �Ѵ�.
		���� ������ �� ȸ������� ����Ͻÿ�.
		Alias�� ȸ����ȣ, ȸ����, ����, �ڵ�����ȣ, �̸����ּ�
			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					MEM_BIR AS ����,
					MEM_HP AS �ڵ�����ȣ,
					MEM_MAIL AS �̸����ּ�
				FROM MEMBER
				WHERE EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM MEM_BIR)
					AND EXTRACT(DAY FROM SYSDATE) = EXTRACT(DAY FROM MEM_BIR);

			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					MEM_BIR AS ����,
					MEM_HP AS �ڵ�����ȣ,
					MEM_MAIL AS �̸����ּ�
				FROM MEMBER
				WHERE TO_CHAR(MEM_BIR, 'MMDD') = TO_CHAR(SYSDATE + 7, 'MMDD');

			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					MEM_BIR AS ����,
					MEM_HP AS �ڵ�����ȣ,
					MEM_MAIL AS �̸����ּ�
				FROM MEMBER
				WHERE EXTRACT(MONTH FROM SYSDATE + 7) = EXTRACT(MONTH FROM MEM_BIR)
					AND EXTRACT(DAY FROM SYSDATE + 7) = EXTRACT(DAY FROM MEM_BIR);

	��� ��)
		ȸ�� ���̺��� ȸ������ ��������� �������� �Ͽ� ���Ͽ� ���� ���ڸ� �����Ϸ� �Ѵ�.
		Alias�� ȸ����ȣ, ȸ����, ����, �ڵ�����ȣ, �̸����ּ�
			SELECT MEM_ID AS ȸ����ȣ,
					MEM_NAME AS ȸ����,
					MEM_BIR AS ����,
					MEM_HP AS �ڵ�����ȣ,
					MEM_MAIL AS �̸����ּ�
				FROM MEMBER
				WHERE EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM MEM_BIR);

UPDATE MEMBER
	SET MEM_BIR = TO_CHAR(EXTRACT(YEAR FROM MEM_BIR))
		|| TO_CHAR(EXTRACT(MONTH FROM SYSDATE))
		|| TO_CHAR(EXTRACT(DAY FROM SYSDATE));

SELECT TO_CHAR(EXTRACT(YEAR FROM MEM_BIR))
		|| TRIM(TO_CHAR(EXTRACT(MONTH FROM SYSDATE), '00'))
		|| TRIM(TO_CHAR(EXTRACT(DAY FROM SYSDATE), '00'))
	FROM MEMBER;