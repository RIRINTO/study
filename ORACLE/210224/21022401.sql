2021-02-24-01)

	** ���� ��ȯ ���ڿ�
		----------------------------------------------------------------------------------------
		���Ĺ��ڿ�			�ǹ�
		----------------------------------------------------------------------------------------
		9				�����Ǵ� �����Ͱ� ��ȿ�����̸� ���� �ڷḦ ����ϰ�,
						�����Ǵ� �����Ͱ� ��ȿ�� 0�̸� ����ó��
		0				�����Ǵ� �����Ͱ� ��ȿ�����̸� ���� �ڷḦ ����ϰ�,
						�����Ǵ� �����Ͱ� ��ȿ�� 0�̸� '0'�� ���
		$, L(1)			ȭ�� ��ȣ�� ���
		MI				�����Ͱ� ������ ��� ������ '-' ��ȣ ���
						�ݵ�� ���Ĺ��ڿ� �� ������ ���
		PR				�����Ͱ� ������ ��� '-' ��ȣ ��� '< >'�� ���� ���
		, ( comma )		3 �ڸ� ���� �ڸ��� ���
		. ( dot )		�Ҽ��� ���
		----------------------------------------------------------------------------------------

		SELECT TO_CHAR(12345, '999,999,999'),
				TO_CHAR(12345, '000,000,000'),
				TO_CHAR(12345, '$999,999,999'),
				TO_CHAR(12345, 'L999,999,999'),
				TO_CHAR(-12345, '999,999,999MI'),
				TO_CHAR(-12345, '999,999,999PR'),
				TO_CHAR(123.45, '999,999,999.999')
			FROM DUAL;

	��� ��)
		�츮���� �뵵�ú� �����ܾ����̺� ( KOR_LOAN_STATUS ) ����
		2013�� 11�� ������ ��ȸ�Ͻÿ�.
		Alias�� �õ�, ���ⱸ��, �����ܾ��̸�, �����ܾ��� 3�ڸ����� �ڸ����� �Ҽ����� �����Ͽ� ����Ͻÿ�.
			SELECT REGION AS �õ�,
					GUBUN AS ���ⱸ��,
					TO_CHAR(LOAN_JAN_AMT, '9,999,999.99') AS �����ܾ�,
					TO_CHAR(LOAN_JAN_AMT, 'L0,000,000.99') AS �����ܾ�,
					TO_CHAR(LOAN_JAN_AMT, 'L9,999,999.99') AS �����ܾ�
				FROM KOR_LOAN_STATUS
				WHERE PERIOD = 201311
				ORDER BY REGION;

	** ��ǰ ���̺��� ������ȣ 'P102000001'�� 'P102000002' ��ǰ�� �����ǸŰ��� ���԰����� 90%�� �����Ͻÿ�.
		UPDATE PROD
			SET PROD_SALE = PROD_COST * 0.9
			WHERE PROD_ID IN('P102000001', 'P102000002');

		COMMIT;

		ROLLBACK;

		SELECT PROD_COST, PROD_SALE
			FROM PROD
			WHERE PROD_ID IN('P102000001', 'P102000002');

	��� ��)
		��ǰ���̺��� �ŷ�ó�� ������� ( P10201 ) �� ��ǰ������ ��ȸ�Ͻÿ�.
		�����Ǹ������� �����ǸŰ� - ���԰��̰�,
		������ ���, < > �ȿ� ����Ͻÿ�.
		Alias�� ��ǰ��, ���԰�, �ǸŰ�, �����ǸŰ�, �����Ǹ�����
			SELECT PROD_NAME AS ��ǰ��,
					TO_CHAR(PROD_COST, '9,999,999') AS ���԰�,
					TO_CHAR(PROD_PRICE, '9,999,999') AS �ǸŰ�,
					TO_CHAR(PROD_SALE, '9,999,999') AS �����ǸŰ�,
					TO_CHAR(PROD_SALE - PROD_COST, '9,999,999PR') AS �����Ǹ�����
				FROM PROD
				WHERE UPPER(PROD_BUYER)= 'P10201';

2. TO_NUMBER(c[, fmt])
	- �־��� ���ڿ� c ( �������� ) �� ���ڷ� ��ȯ
	- fmt�� TO_CHAR ���İ� �����ϳ�, ��� ��������� ����

	��� ��)
		SELECT TO_NUMBER('2021'),
				TO_NUMBER('$1,200','$9,999') + 100,
				TO_NUMBER('<200,000>','999,999PR') / 10,
			FROM DUAL;

	��� ��)
		������ 2005�� 4�� 1���̶�� �����ϰ�,
		��ö�� ȸ�� ( 'K001' ) �� ��ǰ�� �����ϱ� ���� ���θ��� �α��� �� ��,
		īƮ��ȣ�� �ο��ϵ��� �ڵ��Ͻÿ�.
			SELECT MAX(CART_NO) + 1
				FROM CART
				WHERE CART_NO LIKE '20050401%';

--			SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') || TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO, 9))) + 1, '00000'))
--				FROM CART
--				WHERE CART_NO LIKE '20210224%';

			CREATE OR REPLACE FUNCTION FN_CART_NO(P_DATE IN DATE) RETURN CHAR
			IS
				V_NUM NUMBER := 0;
				V_COUNT NUMBER := 0;
				V_DAY CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||'%';
				V_CART_NO CART.CART_NO%TYPE;
			BEGIN
				SELECT COUNT(*) INTO V_COUNT
					FROM CART
					WHERE CART_NO LIKE V_DAY;
				V_NUM := V_COUNT + 1;
				V_CART_NO := TO_CHAR(P_DATE, 'YYYYMMDD') || TRIM(TO_CHAR(V_NUM, '00000'));
				RETURN V_CART_NO;
			END;

			SELECT FN_CART_NO(TO_DATE('20050810')) FROM DUAL;

	��� ��)
		������ 2005�� 8�� 10���̶�� �����ϰ� ���� �ڷḦ �Է��Ͻÿ�.
		���� ȸ�� : Ź���� ( 'n001' )
		��ǰ �ڵ� : ���� �� ���� 2 ( 'P202000014' )
		���� ���� : 2
			INSERT INTO CART(CART_MEMBER, CART_NO, CART_PROD, CART_QTY)
				VALUES('n001', NVL((
					SELECT CART_NO
						FROM CART
						WHERE CART_MEMBER = 'n001'
							AND CART_NO LIKE '20050810%'
							AND ROWNUM <= 1
				), FN_CART_NO(TO_DATE('20050810'))), 'P202000014', 2)

		��ǰ �ڵ� : ���� ��� ( 'P302000011' )
		���� ���� : 5
			INSERT INTO CART(CART_MEMBER, CART_NO, CART_PROD, CART_QTY)
				VALUES('n001', NVL(
						(
							SELECT CART_NO
								FROM CART
								WHERE CART_MEMBER = 'n001'
									AND CART_NO LIKE '20050810%'
									AND ROWNUM <= 1
						), FN_CART_NO(TO_DATE('20050810'))), 'P302000011', 5);

		SELECT *
			FROM CART
			WHERE CART_MEMBER = 'n001'
				AND CART_NO LIKE '20050810%';

		DECLARE
			V_COUNT  NUMBER:=0;
			V_CART_NO NUMBER:=0;
		BEGIN
			SELECT COUNT(*) INTO V_COUNT
				FROM CART
				WHERE SUBSTR(CART_NO,1,8)='20050810'
					AND CART_MEMBER='n001';
			IF V_COUNT = 0 THEN
				INSERT INTO CART
					VALUES('n001',FN_CART_NO(TO_DATE('20050810')),'P302000011',5);
			ELSE
				SELECT CART_NO INTO V_CART_NO
					FROM CART
					WHERE SUBSTR(CART_NO,1,8)='20050810'
						AND CART_MEMBER='n001'; 
			INSERT INTO CART
				VALUES('n001',V_CART_NO,'P302000011',5);
			END IF;
			COMMIT;
		END;

		DELETE CART WHERE CART_NO LIKE '200508%';

		SELECT *  FROM CART WHERE CART_NO LIKE '200508%';