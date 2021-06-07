2021-03-05-02)
2. ������ �ִ� ��������
	- ���� ������ ���Ǵ� ���̺�� ���� ������ ���Ǵ� ���̺��� JOIN���� ����� ��������
	
	��)
		���� �̷� ���̺� ( JOB_HISTORY ) �� �����ϴ� �μ��� ��ȸ�Ͻÿ�.
		Alias�� �μ��ڵ�, �μ����̴�.
			EXISTS ���
				��������
					�μ� ���̺��� �μ��ڵ�, �μ��� ���
				SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
						A.DEPARTMENT_NAME AS �μ���
					FROM DEPARTMENTS A
					WHERE EXISTS(
--							��������
--								�����̷����̺� ( JOB_HISTORY ) ���� �μ� ��ȸ
							SELECT 1
								FROM JOB_HISTORY B
								WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
						)
					ORDER BY A.DEPARTMENT_ID;

			IN ���
				SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
						A.DEPARTMENT_NAME AS �μ���
					FROM DEPARTMENTS A
					WHERE A.DEPARTMENT_ID IN(
							SELECT B.DEPARTMENT_ID
								FROM JOB_HISTORY B
						)
					ORDER BY A.DEPARTMENT_ID;

			ANY ���
				SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
						A.DEPARTMENT_NAME AS �μ���
					FROM DEPARTMENTS A
					WHERE A.DEPARTMENT_ID = ANY(
							SELECT B.DEPARTMENT_ID
								FROM JOB_HISTORY B
						)
					ORDER BY A.DEPARTMENT_ID;

	��)
		���� �̷� ���̺��� �ڷḦ ��ȸ�Ͽ� ������ ����Ͻÿ�.
		Alias �����ȣ, �����, �μ���, ������
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					(
						SELECT B.EMP_NAME
							FROM EMPLOYEES B
							WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID
					) AS �����,
					(
						SELECT C.DEPARTMENT_NAME
							FROM DEPARTMENTS C
							WHERE A.DEPARTMENT_ID = C.DEPARTMENT_ID
					) AS �μ���,
					(
						SELECT D.JOB_TITLE
							FROM JOBS D
							WHERE A.JOB_ID = D.JOB_ID
					) AS ������
				FROM JOB_HISTORY A
				ORDER BY A.EMPLOYEE_ID;

	��)
		��� ���̺��� ������ ���� �μ��� ��� �޿����� �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�.
		�����ȣ, �����, �μ���, �μ���ձ޿�, ����Ǳ޿�
			SELECT A.EMPLOYEE_ID AS �����ȣ,
					A.EMP_NAME AS �����,
					C.DEPARTMENT_ID AS �μ��ڵ�,
					C.DEPARTMENT_NAME AS �μ���,
					ROUND(B.AVG_SALARY, 1) AS �μ���ձ޿�,
					A.SALARY AS ����Ǳ޿�
				FROM EMPLOYEES A
					INNER JOIN (
							SELECT DEPARTMENT_ID AS EMPLOYEES_DEPARTMENT_ID,
									AVG(SALARY) AS AVG_SALARY
								FROM EMPLOYEES
								GROUP BY DEPARTMENT_ID
						) B ON(
								A.DEPARTMENT_ID IS NULL
										AND B.EMPLOYEES_DEPARTMENT_ID IS NULL
										AND A.SALARY > B.AVG_SALARY
									OR A.DEPARTMENT_ID = B.EMPLOYEES_DEPARTMENT_ID
										AND A.SALARY > B.AVG_SALARY
							)
					LEFT OUTER JOIN DEPARTMENTS C ON(
							A.DEPARTMENT_ID = C.DEPARTMENT_ID
						)
				ORDER BY A.EMPLOYEE_ID;

	��)
		������� ���� �μ��� ��� �޿����� �� ���� �޿��� �޴� ����� �����ϴ� �μ��ڵ�� �μ����� ����Ͻÿ�.
			SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
					A.DEPARTMENT_NAME AS �μ���
				FROM DEPARTMENTS A
				WHERE EXISTS(
						SELECT 1
							FROM EMPLOYEES B
							WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
								AND B.SALARY > (
										SELECT AVG(C.SALARY)
											FROM EMPLOYEES C
											WHERE B.DEPARTMENT_ID = C.DEPARTMENT_ID
									)
					)
				ORDER BY A.DEPARTMENT_ID;

������ �ִ� ���������� �̿��� �ڷ� ����
������ 2005�� 1�� 31�̶� �����ϰ�, ��ٱ��� ���̺�� ���� ���̺��� �����Ͽ� �������̺����� UPDATE�Ͻÿ�.
UPDATE REMAIN A
	SET (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE) = (
			SELECT REMAIN_I + SUM(BUY_QTY),
					A.REMAIN_J_99 + SUM(BUY_QTY),
					TO_DATE('20050131')
				FROM BUYPROD B
				WHERE A.REMAIN_PROD = B.BUY_PROD
					AND TO_CHAR(B.BUY_DATE, 'YYYYMM') = '200501'
				GROUP BY B.BUY_PROD
		)
	WHERE A.REMAIN_YEAR = 2005
		AND A.REMAIN_PROD IN(
				SELECT BUY_PROD
					FROM BUYPROD
					WHERE TO_CHAR(BUY_DATE, 'YYYYMM') = '200501'
			);
COMMIT;

ROLLBACK;