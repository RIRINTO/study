2021-03-10-01)
	��� ����
		CREATE[ UNIQUE | BITMAP] INDEX �ε�����
			ON ���̺��(�÷���1[, �÷���2, ...][ASC | DESC]);
	. '���̺�'�� '�÷�'���� �������� �������� ( ASC ) �Ǵ� �������� ( DESC ) ���� �ε��� ����. ( �⺻�� ASC )
	
	��� ��)
		��� ���̺��� ������� �������� �ε����� �����Ͻÿ�.
			CREATE INDEX IDX_EMP01
				ON EMPLOYEES(EMP_NAME);

	CREATE INDEX IDX_MEM01
		ON MEMBER(SUBSTR(MEM_REGNO2, 4));

	CREATE INDEX IDX_KOR_LOAN
		ON KOR_LOAN_STATUS(PERIOD, REGION);

	SELECT *
		FROM KOR_LOAN_STATUS
		WHERE PERIOD='201111'
			AND REGION IN ('�泲', '����', '����');

	4)
		�ε����� �籸��
			- �������� ����, ����, ������ �߻��ϸ� �ε����� �� ������
			- �� ������ WORK SPACE�� ����ǰų� �������� ���Ի����� �ټ� �߻��� ���� REBUILD ������� ����
			
			��� ����
				ALTER INDEX �ε����� REBUILD;

			ALTER INDEX IDX_KOR_LOAN REBUILD;