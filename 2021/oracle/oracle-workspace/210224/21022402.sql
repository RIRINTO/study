2021-02-24-02) ��¥ ��ȯ �Լ�

1. TO_DATE(c[, fmt])
	- ��¥������ ���ڿ� c�� ����� �ڷḦ ��¥������ ��ȯ
	- 'fmt'�� TO_CHAR�Լ��� ����

	��)
		SELECT TO_DATE('20051001')
			FROM DUAL;

		SELECT TO_DATE('2005-10-01')
			FROM DUAL;

		SELECT TO_DATE('2005�� 10�� 01��', 'YYYY"��" MM"��" DD"��"')
			FROM DUAL;

		SELECT TO_DATE('2021-02-24 10:10:34', 'YYYY-MM-DD HH:MI:SS')
			FROM DUAL;