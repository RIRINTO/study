2021-02-10-01)
2. update��
	- �ش� �ڷᰡ ���̺� ����
	- �ʿ��� �÷��� ���� ����

	��� ����
		UPDATE ���̺��
			SET �÷���1=��[,]
				[�÷���2=��,
					:
				�÷���n = ��n]
			[WHERE ����];

	.'WHERE ����'���� �����Ǹ� ��� ���� ���� ������

	��) ��� ���̺�(EMPLOYEES)���� �μ���ȣ�� 50�� �μ��� ���� ����� �޿��� 20% �߰��Ͽ� �����Ͻÿ�.
		SELECT * FROM EMPLOYEES;
		
		SELECT EMP_NAME AS �����,
				DEPARTMENT_ID AS �μ���ȣ,
				SALARY AS �޿�,
				SALARY*1.2 AS �λ�ȱ޿�
			FROM EMPLOYEES
			WHERE DEPARTMENT_ID = 50;

	������ ����
		UPDATE EMPLOYEES
			SET SALARY = SALARY * 1.2
			WHERE DEPARTMENT_ID = 50;

		ROLLBACK;

	��� ��)
		ȸ�����̺�( MEMBER ) ���� ȸ����ȣ 'f001'ȸ���� �ֹε�Ϲ�ȣ ( MEM_REGNO1, MEM_REGNO2 ) ��
		������� ( MEMBER_BIR ) �� ���� �ڷ�� �����Ͻÿ�.
		
		1)
			�ֹι�ȣ 1 : 751228 �� 021228
			�ֹι�ȣ 2 : 1459919 �� 3459919
		2)
			������� : 1972/11/04 �� 2002/12/18

		SELECT *
			FROM MEMBER
			WHERE MEM_REGNO1 = '751228';

		SELECT *
			FROM MEMBER
			WHERE MEM_REGNO1 = '021228';

		UPDATE MEMBER
			SET MEM_REGNO1 = '021228',
				MEM_REGNO2 = '3459919',
				MEM_BIR = TO_DATE('2022/12/18')
			WHERE MEM_REGNO1 = '751228';

		COMMIT;

3. DELETE��
	- ���̺� ����� �ڷḦ ����
	- WHERE ���� �����Ǹ� �ش� ���̺��� ��� ���� ���� �� �� ���̺��� ����

	��� ����
		DELETE ���̺��
			[WHERE ����];

	.DELETE ���� ROLLBACK�� �����.

	��� ��)
		ȸ�� ���̺��� '��ö��' ȸ�� �ڷḦ �����Ͻÿ�.
			DELETE MEMBER;

			SELECT *
				FROM MEMBER;

	��� ��)
		��ٱ��� ���̺� ( CART ) ���� 'k001' ȸ���ڷḦ �����Ͻÿ�.
		DELETE CART;

		SELECT *
			FROM CART
			WHERE CART_MEMBER = 'k001';

		DELETE CART
			WHERE CART_MEMBER = 'k001';

		ROLLBACK;