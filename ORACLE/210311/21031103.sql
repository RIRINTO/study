2021-03-11-03)
	2)
		WHILE��
			. ���� ���α׷� ���߾���� WHILE�� ����

			��� ����
				WHILE ���� LOOP
					�ݺ�ó����;
				END LOOP; 
			- '����'�� ����� FALSE�� ���, �ݺ��� ���

			��� ��)
				�������� 4���� ����Ͻÿ�.
				DECLARE
					V_CNT NUMBER := 0;
				BEGIN
					WHILE V_CNT < 9 LOOP
						V_CNT := V_CNT + 1;
						DBMS_OUTPUT.PUT_LINE('4 * ' || V_CNT || ' = ' || 4 * V_CNT);
					END LOOP;
				END;

			��� ��)
				LOOP�� ������ CURSOR���� WHILE�� �籸���Ͻÿ�.
					DECLARE
						V_ID PROD.PROD_ID % TYPE;
						V_NAME PROD.PROD_NAME % TYPE;
						V_AQTY NUMBER := 0;
						V_AMON NUMBER := 0;
						CURSOR CUR_BUYPROD02
						IS
							SELECT BUY_PROD,
									PROD_NAME,
									SUM(BUY_QTY),
									SUM(BUY_QTY * PROD_COST)
								FROM BUYPROD, PROD
								WHERE PROD_ID = BUY_PROD
									AND TO_CHAR(BUY_DATE, 'YYYYMM') = '200503'
								GROUP BY BUY_PROD,
									PROD_NAME;
					BEGIN
						DBMS_OUTPUT.PUT_LINE('--------------------');

						OPEN CUR_BUYPROD02;
						FETCH CUR_BUYPROD02
							INTO V_ID,
								V_NAME,
								V_AQTY,
								V_AMON;

						WHILE CUR_BUYPROD02 % FOUND LOOP
							DBMS_OUTPUT.PUT_LINE('����		' || CUR_BUYPROD02 % ROWCOUNT);
							DBMS_OUTPUT.PUT_LINE('��ǰ��ȣ	' || V_ID);
							DBMS_OUTPUT.PUT_LINE('��ǰ��	' || V_NAME);
							DBMS_OUTPUT.PUT_LINE('���Լ���	' || V_AQTY);
							DBMS_OUTPUT.PUT_LINE('���Աݾ�	' || V_AMON);
							DBMS_OUTPUT.PUT_LINE('--------------------');
							
							FETCH CUR_BUYPROD02
								INTO V_ID,
									V_NAME,
									V_AQTY,
									V_AMON;
						END LOOP;
						CLOSE CUR_BUYPROD02;
					END;

			����]
				ù���� 100��, �� ��° �� ���ʹ� ������ 2�辿 ������ �Ϸ� �Ѵ�.
				���ʷ� 100������ �Ѵ� ���� �������̰�, �� ������ ������ �׼��� ���Ͻÿ�.
				LOOP�� WHILE������ ������ ��
					DECLARE
						V_DAY NUMBER := 0;
						V_MONEY NUMBER := 0;
					BEGIN
						LOOP
							V_DAY := V_DAY + 1;
							V_MONEY := V_MONEY + POWER(2, V_DAY - 1) * 100;
							DBMS_OUTPUT.PUT_LINE(V_DAY || '����');
							DBMS_OUTPUT.PUT_LINE(POWER(2, V_DAY - 1) * 100 || '�� ����.');
							DBMS_OUTPUT.PUT_LINE('���ñ��� ' || V_MONEY || '��.');
							DBMS_OUTPUT.PUT_LINE('--------------------');
							EXIT WHEN V_MONEY > 1000000;
						END LOOP;

						DBMS_OUTPUT.PUT_LINE('���ʷ� 100������ ���� ���� ' || V_DAY || '�� ° �Ǵ� ���̰�, ' || V_MONEY || '���� ��ҽ��ϴ�.');
					END;

					DECLARE
						V_DAY NUMBER := 0;
						V_MONEY NUMBER := 0;
					BEGIN
						WHILE V_MONEY <= 1000000 LOOP
							V_DAY := V_DAY + 1;
							V_MONEY := V_MONEY + POWER(2, V_DAY - 1) * 100;
							DBMS_OUTPUT.PUT_LINE(V_DAY || '����');
							DBMS_OUTPUT.PUT_LINE(POWER(2, V_DAY - 1) * 100 || '�� ����.');
							DBMS_OUTPUT.PUT_LINE('���ñ��� ' || V_MONEY || '��.');
							DBMS_OUTPUT.PUT_LINE('--------------------');
						END LOOP;

						DBMS_OUTPUT.PUT_LINE('���ʷ� 100������ ���� ���� ' || V_DAY || '�� ° �Ǵ� ���̰�, ' || V_MONEY || '���� ��ҽ��ϴ�.');
					END;