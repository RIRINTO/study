2021-02-26-01)

-- ��������
	PRIMARY KEY ����
	UNIQUE ����
		�ش� �÷��� �ߺ��� ���� �� �� ����.
		��, NULL���� �� �� �ִ�.
			NOT NULL

-- ��ü ������ ��
	SELECT DEPTNO,
			COUNT(*)
		FROM EMP
		GROUP BY DEPTNO;

-- �׷��Լ� ����
	�׷��Լ� ����
		SUM, COUNT, AVG, MAX, MIN

	������
		GROUP BY ���� ���� �÷� �̿��� �÷��� �׷��Լ��� ������� ���� ä�� SELECT ���� �� �� ����.

	�׷��Լ��� ���꿡�� NULL ���� ���ܵȴ�.

	WHERE �� ( ���� �����ϴ� ���� ) ���� GROUP �Լ��� ������ �� ����.
		HAVING ���� ���

	���̺��� ��� �࿡ ���� �׷����� �� ���, GROUP BY ������� �ʴ´�.

-- ��, ��� ���� �߰� ����
	SELECT DEPTNO,
			1,
			'TEST',
			COUNT(*)
		FROM EMP
		GROUP BY DEPTNO;

GRP]
	EMP ���̺��� �̿��Ͽ� ������ ���Ͻÿ�.
		���� �� ���� ���� �޿�
		���� �� ���� ���� �޿�
		������ �޿� ��� ( �Ҽ��� �� �ڸ����� �������� �ݿø� )
		������ �޿� ��
		���� �� �޿��� �ִ� ������ �� ( NULL ���� )
		���� �� ����ڰ� �ִ� ������ �� ( NULL ���� )
		��� ������ ��
			SELECT MAX(SAL) AS MAX_SAL,
					MIN(SAL) AS MIN_SAL,
					ROUND(AVG(SAL), 2) AS AVG_SAL,
					SUM(SAL) AS SUM_SAL,
					COUNT(SAL) AS COUNT_SAL,
					COUNT(MGR) AS COUNT_MGR,
					COUNT(*) AS COUNT_ALL
				FROM EMP;

GRP2]
	EMP ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
		�μ� ���� ���� �� ���� ���� �޿�
		�μ� ���� ���� �� ���� ���� �޿�
		�μ� ���� ������ �޿� ��� ( �Ҽ��� 2�ڸ����� )
		�μ� ���� ������ �޿� ��
		�μ��� ���� �� �޿��� �ִ� ������ �� ( NULL ���� )
		�μ��� ���� �� ����ڰ� �ִ� ������ �� ( NULL ����)
		�μ��� ������ ��
			SELECT DEPTNO,
					MAX(SAL) AS MAX_SAL,
					MIN(SAL) AS MIN_SAL,
					ROUND(AVG(SAL), 2) AS AVG_SAL,
					SUM(SAL) AS SUM_SAL,
					COUNT(SAL) AS COUNT_SAL,
					COUNT(MGR) AS COUNT_MGR,
					COUNT(*) AS COUNT_ALL
				FROM EMP
				GROUP BY DEPTNO
				ORDER BY DEPTNO;

GRP4]
	EMP ���̺��� �̿��Ͽ� ������ ���Ͻÿ�.
		������ �Ի� ������� �� ���� ������ �Ի��ߴ��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
			SELECT TO_CHAR(HIREDATE, 'YYYYMM') AS HIRE_YYYYMM,
					COUNT(*) AS CNT
				FROM EMP
				GROUP BY TO_CHAR(HIREDATE, 'YYYYMM')
				ORDER BY TO_CHAR(HIREDATE, 'YYYYMM');

GRP5]
	EMP ���̺��� �̿��Ͽ� ������ ���Ͻÿ�.
		������ �Ի� �⺰�� �� ���� ������ �Ի��ߴ��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
			SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YYYY,
					COUNT(*) AS CNT
				FROM EMP
				GROUP BY TO_CHAR(HIREDATE, 'YYYY')
				ORDER BY TO_CHAR(HIREDATE, 'YYYY');

1]
	�ܹ��� ���������� �� ���� �Ǽ�
	���������� ��, ���� �Ǽ�
		SELECT STORECATEGORY AS �����������,
				COUNT(*) AS �Ǽ�
			FROM BURGERSTORE
			GROUP BY STORECATEGORY
			ORDER BY COUNT(*) DESC;

2]
	�õ�, �ñ����� �ܹ��� ���������� �� ���� �Ǽ�
	�õ�, �ñ���, �����������, �Ǽ�
		SELECT SIDO AS �õ�,
				SIGUNGU AS �ñ���,
				STORECATEGORY AS �����������,
			COUNT(*) AS �Ǽ�
			FROM BURGERSTORE
			GROUP BY SIDO, SIGUNGU, STORECATEGORY
			ORDER BY COUNT(*) DESC;

3]
	�õ��� �ܹ��� ��������� ����Ǽ�
	�õ�, �����������, �Ǽ�
		SELECT SIDO AS �õ�,
				STORECATEGORY AS �����������,
				COUNT(*) AS �Ǽ�
			FROM BURGERSTORE
			GROUP BY SIDO, STORECATEGORY
			ORDER BY COUNT(*) DESC;

4]
	�õ�, �ñ���, 3�� ����������(KFC, ����ŷ, �Ƶ�����) ����� ��
	�õ� �ñ��� 3�� ������������ ���� ��
		SELECT SIDO AS �õ�,
				SIGUNGU AS �ñ���,
				COUNT(*) AS "���������� ���� ��"
			FROM BURGERSTORE
			WHERE STORECATEGORY IN('BURGER KING', 'MACDONALD', 'KFC')
			GROUP BY SIDO, SIGUNGU
			ORDER BY COUNT(*) DESC;

5]
	���ù������� = ( ����ŷ + �Ƶ����� + KFC ) / �Ե�����
	�õ�, �ñ���, ���ù�������
		SELECT SIDO AS �õ�,
				SIGUNGU AS �ñ���,
				ROUND(
					SUM(
						CASE
							WHEN STORECATEGORY IN ('BURGER KING', 'MACDONALD', 'KFC')
								THEN 1
						END
					)
					/ SUM(
						CASE
							WHEN STORECATEGORY = 'LOTTERIA'
								THEN  1
						END
					), 2
				) AS "���ù�������"
			FROM BURGERSTORE
			GROUP BY SIDO, SIGUNGU;

SELECT *
	FROM MEMBER;

SELECT MEM_NAME
	FROM MEMBER;

SELECT MEM_NAME,
		LENGTH(MEM_NAME) AS MEM_NAME_LENGTH
	FROM MEMBER;

SELECT LENGTH('������')
	FROM DUAL;

SELECT *
	FROM EMP;

SELECT ENAME,
		DEPTNO,
		SAL
	FROM EMP;

SELECT DEPTNO,
		SUM(SAL)
	FROM EMP
	GROUP BY DEPTNO
	ORDER BY DEPTNO;

SELECT *
	FROM EMP
	WHERE EMPNO > 7200
		AND DEPTNO = 10;

SELECT *
	FROM EMP, DEPT;

SELECT *
	FROM DEPT, EMP;

SELECT DEPTNO,
		SUM(SAL),
		ROUND(AVG(SAL), 2),
		COUNT(*), -- ���� ���� ��ȯ
		COUNT(EMPNO), -- �÷��� ���� NULL�� �ƴ� ���� ���� ��ȯ
		COUNT(COMM) -- �÷��� ���� NULL�� �ƴ� ���� ���� ��ȯ
	FROM EMP
	GROUP BY DEPTNO
	ORDER BY DEPTNO;

SELECT DEPTNO,
		SUM(SAL),
		COUNT(*),
		MIN(SAL),
		MAX(SAL)
	FROM EMP
	GROUP BY DEPTNO;

SELECT DEPTNO,
		COUNT(*)
	FROM EMP
	GROUP BY DEPTNO
	HAVING COUNT(*) >= 4;

SELECT DEPTNO,
		COUNT(*)
	FROM EMP;
	GROUP BY DEPTNO;

SELECT *
	FROM EMP;

SELECT DEPTNO,
		ENAME,
		COUNT(*)
	FROM EMP
	GROUP BY DEPTNO, ENAME;

SELECT 'TEST'
	FROM EMP;

SELECT 100 + NULL,
		DEPTNO,
		NVL(SUM(COMM),0),
		SUM(NVL(COMM, 0))
	FROM EMP
	GROUP BY DEPTNO;
  
SELECT COUNT(*)
	FROM EMP;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS NOW
	FROM DUAL;

SELECT *
	FROM BURGERSTORE;

SELECT COUNT(*)
	FROM BURGERSTORE;