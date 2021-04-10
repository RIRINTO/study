2021-02-23-03) ��ȯ �Լ�
	- �ڷ����� ��ȯ�� ����ϴ� �Լ�
	- CAST, TO_CHAR, TO_NUMBER, TO_DATE�� ����

1. CAST(expr AS type)
	. expr�� ǥ���� ���� type �������� ��ȯ

	��)
		SELECT MEM_ID,
				MEM_NAME,
				MEM_MILEAGE,
				CAST(MEM_MILEAGE AS CHAR(10)) AS CAST
			FROM MEMBER;

		SELECT SUBSTR(CART_NO, 1, 8),
				CAST(SUBSTR(CART_NO, 1, 8) AS DATE),
				CAST(SUBSTR(CART_NO, 9) AS NUMBER),
				CART_PROD,
				CART_QTY
			FROM CART
			WHERE ROWNUM <= 10;

2. TO_CHAR(c|d|n [, fmt])
	- ��¥, ����, ���� �ڷḦ ������ ������ ���ڿ� �ڷ�� ��ȯ

	�����������ڿ� ( fmt )
		-------------------------------------------------
		������������					�ǹ�
		-------------------------------------------------
		AD, BC, CC				����
		YYYY, YYY, YY, Y		�⵵
		MONTH, MON, MM, RM		��
		W, WW, IW				����
		Q						�б�    
		DD, DDD, J				��
		DAY, DY, D				����
		AM, PM[, A.M, P.M]		���� / ����
		HH, HH12, HH24			�ð�
		MI						��
		SS, SSSSS				��
		"���ڿ�"					����� ���� ���ڿ�
		-------------------------------------------------

	SELECT TO_CHAR(SYSDATE, 'AD, BC, CC')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'YYYY, YYY, YY, Y')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'MONTH, MON, MM, RM')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'W, WW, IW')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'Q')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'DD, DDD, J')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'AM, PM')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'HH, HH12, HH24')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'MI')
		FROM DUAL;

	SELECT TO_CHAR(SYSDATE, 'SS, SSSSS')
		FROM DUAL;