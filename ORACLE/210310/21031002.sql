2021-03-10-02)
PL/SQL
	- PROCEDURAL LANGUAGE SQL�� ����
	- ǥ�� SQL�� ���α׷��� �帧�� �����ϴ� ��ɰ� ���� ���� ����� �������� ����.
	- PL/SQL�� �帧���� ���� ����� �����ϰ�,
		���� ������ �����ϴ� ��� ������ ���α׷��� �������Ͽ� ���� ������ ���·� ������ ����
	- BLOCK ������ ����
	- ���ȭ, ĸ��ȭ ��� ����
	- Anonymus Block,
		Stored Procedure,
		User Defined Function,
		Package,
		trigger �� ����

1. Annonymus Block
	- �̸��� �ο����� ���� ��
	- PL/SQL�� �⺻ ���� ����

	����
		DECLARE
			�����;
		BEGIN
			�����;
		[EXCEPTION
			����ó����;
		]
		END;
	. '�����'
		���ؿ󿡼� ����� ����, ���, Ŀ�� ����
	. '�����'
		SELECT, DML ������� ������ �����Ͻ� ���� ó�� ����
	. '����ó����'
		���� �߻� �� ó���� ��� ���

--SELECT * FROM LPROD;

	��� ��)
		Ű����� ȸ����ȣ�� �Է¹޾� ȸ�������� ����ϴ� ����� �ۼ�
		Alias�� ȸ����ȣ, ȸ����, ���ϸ���
			ACCEPT P_ID PROMPT 'ȸ����ȣ : '
			DECLARE
				V_ID MEMBER.MEM_ID % TYPE;
				V_NAME MEMBER.MEM_NAME % TYPE;
				V_MILE NUMBER(5) := 0;
				V_RES VARCHAR2(100);
			BEGIN
				SELECT MEM_ID,
						MEM_NAME,
						MEM_MILEAGE
					INTO V_ID,
						V_NAME,
						V_MILE
					FROM MEMBER
					WHERE MEM_ID = '&P_ID';

				V_RES := V_ID || ', ' || V_NAME || ' �� ' || V_MILE;

				DBMS_OUTPUT.PUT_LINE('--------------------');
				DBMS_OUTPUT.PUT_LINE(V_RES);
				DBMS_OUTPUT.PUT_LINE('--------------------');
			END;

	1)
		����
			- ���α׷��� ���߾���� ������ ���� ����
			- ����ο��� ���

			���� ����
				������ ������Ÿ��[(ũ��)][ := �ʱⰪ];

			. ������ Ÿ��
				ǥ�� sql���� ����ϴ� ������ Ÿ��
				BOOLEAN, PLS_INTEGER, BINARY_INTEGER �� ������ ��� ����
			. PLS_INTEGER, BINARY_INTEGER
				4byte ���� ( -2147483648 ~ 2147483647 )
			. ������
				�ش� ���̺��� �� ( ROW ) �̳� �� ( COLUMN ) �� ������ Ÿ�� �� ũ�⸦ ���� ���� ����
				���̺��.�÷��� % TYPE
					�÷� ����
				���̺�� % ROWTYPE
					�ش� ���̺� ���� ��� ���� ( �迭 ȿ�� )
			. ������ ������ �����ϱ� �� �ݵ�� �ʱ�ȭ
	2)
		���
			- ���α׷����� ������ �ʴ� ���� ǥ��
			- ����� �Ҵ翬������ ���� ( LEFT VALUE ) �� ��� �Ұ�
			
			���� ����
				������ CONSTANT ������Ÿ��[(ũ��)] := ��;

			. �ݵ�� �ʱ�ȭ�� �ʿ�

	��� ��)
		���� �Է¹޾� 2005�� �ش� ���� �������踦 ����ϴ� 
		Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ���
			ACCEPT P_MONTH PROMPT '�� ( 1 ~ 12 ) : '
			DECLARE
				V_CODE PROD.PROD_ID % TYPE;
				V_NAME PROD.PROD_NAME % TYPE;
				V_QTY_AMT NUMBER := 0;
				V_SDATE CONSTANT DATE := TO_DATE('2005' || LTRIM(TO_CHAR(TO_NUMBER('&P_MONTH')), '00'), 'YYYYMM');
				V_EDATE CONSTANT DATE := ADD_MONTHS(TO_DATE('2005' || LTRIM(TO_CHAR(TO_NUMBER('&P_MONTH')), '00'), 'YYYYMM'), 1) - 1 / 24 / 60 / 60 / 100;
				CURSOR BUYQTY_CUR(V_SDATE DATE, V_EDATE DATE)
					IS
						SELECT BUY_PROD,
								PROD_NAME,
								SUM(BUY_QTY)
							FROM BUYPROD,
								PROD
							WHERE BUY_PROD = PROD_ID
								AND BUY_DATE BETWEEN V_SDATE AND V_EDATE
							GROUP BY BUY_PROD,
								PROD_NAME
							ORDER BY BUY_PROD,
								PROD_NAME;
			BEGIN
				OPEN BUYQTY_CUR(V_SDATE, V_EDATE);
				LOOP
					FETCH BUYQTY_CUR INTO V_CODE, V_NAME, V_QTY_AMT;
					EXIT WHEN BUYQTY_CUR % NOTFOUND;
					DBMS_OUTPUT.PUT_LINE('--------------------');
					DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ�	' || V_CODE);
					DBMS_OUTPUT.PUT_LINE('��ǰ��	' || V_NAME);
					DBMS_OUTPUT.PUT_LINE('���Լ���	' || V_QTY_AMT);
				END LOOP;
				DBMS_OUTPUT.PUT_LINE('--------------------');
				DBMS_OUTPUT.PUT_LINE('���԰Ǽ�	' || BUYQTY_CUR % ROWCOUNT);
				DBMS_OUTPUT.PUT_LINE('--------------------');
			EXCEPTION WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('���ܹ߻�	' || SQLERRM);
			END;

	3)
		�б⹮
			- ���߾���� �б⹮ ( IF �� ) �� ���� ��� ����

			��� ����
				IF ���ǽ� THEN
					��ɹ�;
				[ELSE
					��ɹ�;]
				END IF;

			��� ����
				IF ���ǽ� THEN
					��ɹ�;
				[ELSIF ���ǽ� THEN
					��ɹ�;]
				[ELSE
					��ɹ�;]
				END IF;

			��� ����
				IF ���ǽ� THEN
					IF ���ǽ� THEN
						��ɹ�;
					[ELSIF ���ǽ� THEN
						��ɹ�;]
					[ELSE
						��ɹ�;]
					END IF;
				[ELSIF ���ǽ� THEN
					IF ���ǽ� THEN
						��ɹ�;
					[ELSIF ���ǽ� THEN
						��ɹ�;]
					[ELSE
						��ɹ�;]
					END IF;]
				[ELSE
					IF ���ǽ� THEN
						��ɹ�;
					[ELSIF ���ǽ� THEN
						��ɹ�;]
					[ELSE
						��ɹ�;]
					END IF;]
				END IF;

	��� ��)
		�μ���ȣ 60�� �μ��� ���� ����� �޿��� ��ȸ�Ͽ�
		�� �μ����� ù ��° ��ȸ�� ����� �޿��� 5000�����̸� '���ӱ� ���',
		5001 - 15000 �̸� '����ӱ� ���',
		�� �̻��̸� '���ӱ� ���' �� ����ϴ� �� �ۼ�
			DECLARE
				V_DEPT EMPLOYEES.EMPLOYEE_ID % TYPE := ROUND(DBMS_RANDOM.VALUE(10, 110), -1);
				V_EMP_NAME EMPLOYEES.EMP_NAME % TYPE;
				V_SALARY EMPLOYEES.SALARY % TYPE;
				V_MESSAGE VARCHAR2(100);
			BEGIN
				SELECT EMP_NAME,
						SALARY
					INTO V_EMP_NAME,
						V_SALARY
					FROM EMPLOYEES
					WHERE DEPARTMENT_ID = V_DEPT
						AND ROWNUM = 1;

				IF V_SALARY <= 5000 THEN
					V_MESSAGE := '���ӱ� ���';
				ELSIF V_SALARY <= 15000 THEN
					V_MESSAGE := '����ӱ� ���';
				ELSE
					V_MESSAGE := '���ӱ� ���';
				END IF;

				V_MESSAGE := V_EMP_NAME || '	' || V_SALARY || ' �� ' || V_MESSAGE;
				DBMS_OUTPUT.PUT_LINE(V_MESSAGE);
			END;




















