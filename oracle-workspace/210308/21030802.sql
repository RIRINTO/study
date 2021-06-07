2021-03-08-02)
���տ�����
	- �����̷п��� �����ϴ� ������ ( UNION, UNION ALL ),
		������ ( INTERSECT ),
		������ ( MINUS ) ������ ����
	
	��� ����
		SELECT �÷�List
			FROM ���̺��
			[WHERE ����]
		UNION | UNION ALL | INTERSECT | MINUS
            SELECT �÷�List
                FROM ���̺��
                [WHERE ����
                    :	]
		[UNION | UNION ALL | INTERSECT | MINUS
            SELECT �÷�List
                FROM ���̺��
                [WHERE ����
                    :	]]
	. �� SELECT ���� �÷� ������ ���� �� TYPE�� ���ƾ� ��
	. ORDER BY ���� �� ������ SELECT �������� ��� ����
	. CLOB, BLOB, BFILE ���� ��� �Ұ�
	. ����� ������ ù ��° SELECT ����

1. UNION, UNION ALL
	- �������� ��� ��ȯ
	- UNION
		�ߺ����� ���� ��� ��ȯ
	- UNION ALL
		�ߺ��� ���� ��ȯ

	��� ��)
		2005�� 4���� 6���� �Ǹŵ� ��ǰ������ �ߺ����� �ʰ� ��ȸ�Ͻÿ�
		Alias�� ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�
			SELECT B.PROD_ID AS ��ǰ�ڵ�,
				B.PROD_NAME AS ��ǰ��
				FROM CART A,
					PROD B
				WHERE A.CART_PROD = B.PROD_ID
					AND A.CART_NO LIKE '200504%'
				GROUP BY B.PROD_ID,
					B.PROD_NAME
			UNION
                SELECT B.PROD_ID AS ��ǰ�ڵ�,
                    B.PROD_NAME AS ��ǰ��
                    FROM CART A,
                        PROD B
                    WHERE A.CART_PROD = B.PROD_ID
                        AND A.CART_NO LIKE '200506%'
                    GROUP BY B.PROD_ID,
                        B.PROD_NAME;

2. INTERSECT
	- �������� ��� ��ȯ

	��� ��)
		2005�� 4���� 6���� ��� �Ǹŵ� ��ǰ������ ��ȸ�Ͻÿ�
		Alias�� ��ǰ�ڵ�, ��ǰ��, �Ǹż����հ�
			SELECT B.PROD_ID AS ��ǰ�ڵ�,
				B.PROD_NAME AS ��ǰ��
				FROM CART A,
					PROD B
				WHERE A.CART_PROD = B.PROD_ID
					AND A.CART_NO LIKE '200504%'
				GROUP BY B.PROD_ID,
					B.PROD_NAME
			INTERSECT
                SELECT B.PROD_ID AS ��ǰ�ڵ�,
                    B.PROD_NAME AS ��ǰ��
                    FROM CART A,
                        PROD B
                    WHERE A.CART_PROD = B.PROD_ID
                        AND A.CART_NO LIKE '200506%'
                    GROUP BY B.PROD_ID,
                        B.PROD_NAME;

3. MINUS ( ������ )
	- A MINUS B
		���� A���� ���� B�� ���� ��Ҹ� ������ ��� ��ȯ
	- B MINUS A
		���� B���� ���� A�� ���� ��Ҹ� ������ ��� ��ȯ

	��� ��)
		2005�� 4���� �Ǹŵ� ��ǰ �� 6���� �Ǹŵ��� ���� ��ǰ������ ��ȸ�Ͻÿ�.
			SELECT B.PROD_ID AS ��ǰ�ڵ�,
				B.PROD_NAME AS ��ǰ��
				FROM CART A,
					PROD B
				WHERE A.CART_PROD = B.PROD_ID
					AND A.CART_NO LIKE '200504%'
				GROUP BY B.PROD_ID,
					B.PROD_NAME
			MINUS
                SELECT B.PROD_ID AS ��ǰ�ڵ�,
                    B.PROD_NAME AS ��ǰ��
                    FROM CART A,
                        PROD B
                    WHERE A.CART_PROD = B.PROD_ID
                        AND A.CART_NO LIKE '200506%'
                    GROUP BY B.PROD_ID,
                        B.PROD_NAME;

	��� ��)
		2005�� 6���� �Ǹŵ� ��ǰ �� 4���� �Ǹŵ��� ���� ��ǰ������ ��ȸ�Ͻÿ�.
			SELECT B.PROD_ID AS ��ǰ�ڵ�,
				B.PROD_NAME AS ��ǰ��
				FROM CART A,
					PROD B
				WHERE A.CART_PROD = B.PROD_ID
					AND A.CART_NO LIKE '200506%'
				GROUP BY B.PROD_ID,
					B.PROD_NAME
			MINUS
                SELECT B.PROD_ID AS ��ǰ�ڵ�,
                    B.PROD_NAME AS ��ǰ��
                    FROM CART A,
                        PROD B
                    WHERE A.CART_PROD = B.PROD_ID
                        AND A.CART_NO LIKE '200504%'
                    GROUP BY B.PROD_ID,
                        B.PROD_NAME;

**
	SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
			B.PROD_NAME AS ��ǰ��
		FROM CART A, PROD B
		WHERE A.CART_NO LIKE '200506%'
			AND A.CART_PROD = B.PROD_ID
	UNION
		SELECT B.LPROD_GU AS �з��ڵ�,
				B.LPROD_NM AS �з���
			FROM LPROD B
			ORDER BY 1;